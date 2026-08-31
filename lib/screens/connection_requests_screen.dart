import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ConnectionRequestsScreen extends StatefulWidget {
  const ConnectionRequestsScreen({super.key});

  @override
  State<ConnectionRequestsScreen> createState() =>
      _ConnectionRequestsScreenState();
}

class _ConnectionRequestsScreenState
    extends State<ConnectionRequestsScreen> {
  final List<_ConnectionRequest> _requests = [
    _ConnectionRequest(
      id: 'request_001',
      name: 'Rahul Sharma',
      relationship: 'Son',
      requestedAt: 'Today, 10:42 AM',
    ),
  ];

  void _acceptRequest(String requestId) {
    setState(() {
      final index = _requests.indexWhere(
            (request) => request.id == requestId,
      );

      if (index != -1) {
        _requests[index] = _requests[index].copyWith(
          status: ConnectionStatus.accepted,
        );
      }
    });

    _showMessage(
      'Connection approved successfully.',
    );
  }

  void _rejectRequest(String requestId) {
    setState(() {
      _requests.removeWhere(
            (request) => request.id == requestId,
      );
    });

    _showMessage(
      'Connection request rejected.',
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingRequests = _requests
        .where(
          (request) =>
      request.status == ConnectionStatus.pending,
    )
        .toList();

    final acceptedRequests = _requests
        .where(
          (request) =>
      request.status == ConnectionStatus.accepted,
    )
        .toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            22,
            18,
            22,
            30,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              // =================================================
              // HEADER
              // =================================================

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppTheme.navy,
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints:
                    const BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                    ),
                  ),

                  const SizedBox(width: 4),

                  const Expanded(
                    child: Text(
                      'Connection Requests',
                      style: TextStyle(
                        color: AppTheme.navy,
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),

                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF7F6),
                      borderRadius:
                      BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.people_alt_outlined,
                      color: AppTheme.primary,
                      size: 23,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  'Manage who can access your shared '
                      'CareBridge progress.',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // =================================================
              // PRIVACY BANNER
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7F0),
                  borderRadius:
                  BorderRadius.circular(22),
                  border: Border.all(
                    color: const Color(0xFFD4EDDF),
                  ),
                ),
                child: const Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      color: Color(0xFF2E9B68),
                      size: 24,
                    ),
                    SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You are in control',
                            style: TextStyle(
                              color: AppTheme.navy,
                              fontSize: 13,
                              fontWeight:
                              FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Only approve people you trust. '
                                'You can manage or remove access '
                                'at any time.',
                            style: TextStyle(
                              color:
                              AppTheme.textSecondary,
                              fontSize: 11.5,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // =================================================
              // PENDING REQUESTS
              // =================================================

              if (pendingRequests.isNotEmpty) ...[
                Row(
                  children: [
                    const Text(
                      'Pending requests',
                      style: TextStyle(
                        color: AppTheme.navy,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${pendingRequests.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight:
                          FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                ...pendingRequests.map(
                      (request) =>
                      _buildRequestCard(request),
                ),
              ],

              // =================================================
              // ACCEPTED CONNECTIONS
              // =================================================

              if (acceptedRequests.isNotEmpty) ...[
                const SizedBox(height: 25),

                const Text(
                  'Connected guardians',
                  style: TextStyle(
                    color: AppTheme.navy,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 12),

                ...acceptedRequests.map(
                      (request) =>
                      _buildAcceptedCard(request),
                ),
              ],

              // =================================================
              // EMPTY STATE
              // =================================================

              if (_requests.isEmpty)
                _buildEmptyState(),

              const SizedBox(height: 30),

              // =================================================
              // INFORMATION
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(23),
                  border: Border.all(
                    color: const Color(0xFFE5ECEC),
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: AppTheme.primary,
                          size: 22,
                        ),
                        SizedBox(width: 9),
                        Text(
                          'How connections work',
                          style: TextStyle(
                            color: AppTheme.navy,
                            fontSize: 14,
                            fontWeight:
                            FontWeight.w800,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    _buildInfoStep(
                      number: '1',
                      text:
                      'A guardian sends you a connection request.',
                    ),

                    const SizedBox(height: 10),

                    _buildInfoStep(
                      number: '2',
                      text:
                      'You review who is requesting access.',
                    ),

                    const SizedBox(height: 10),

                    _buildInfoStep(
                      number: '3',
                      text:
                      'You decide whether to accept or reject.',
                    ),

                    const SizedBox(height: 10),

                    _buildInfoStep(
                      number: '4',
                      text:
                      'You control what information the guardian can see.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Center(
                child: Text(
                  'CareBridge • Your health, connected.',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================
  // PENDING REQUEST CARD
  // =============================================================

  Widget _buildRequestCard(
      _ConnectionRequest request,
      ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color(0xFFE3EAEA),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.03,
            ),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFEDE5F5),
                      Color(0xFFF4EFF9),
                    ],
                  ),
                  borderRadius:
                  BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Color(0xFF8B5FBF),
                  size: 31,
                ),
              ),

              const SizedBox(width: 13),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.name,
                      style: const TextStyle(
                        color: AppTheme.navy,
                        fontSize: 16,
                        fontWeight:
                        FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(
                          Icons.family_restroom_rounded,
                          color:
                          AppTheme.textSecondary,
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          request.relationship,
                          style: const TextStyle(
                            color:
                            AppTheme.textSecondary,
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      request.requestedAt,
                      style: const TextStyle(
                        color:
                        AppTheme.textSecondary,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Pending badge
              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4DD),
                  borderRadius:
                  BorderRadius.circular(10),
                ),
                child: const Text(
                  'Pending',
                  style: TextStyle(
                    color: Color(0xFFB57918),
                    fontSize: 9.5,
                    fontWeight:
                    FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 17),

          const Divider(
            color: Color(0xFFE8EEEE),
            height: 1,
          ),

          const SizedBox(height: 15),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'This person wants to track the progress '
                  'you choose to share.',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () {
                      _rejectRequest(
                        request.id,
                      );
                    },
                    style:
                    OutlinedButton.styleFrom(
                      foregroundColor:
                      const Color(0xFFC65353),
                      side: const BorderSide(
                        color: Color(0xFFE5BABA),
                      ),
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Reject',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                        FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      _acceptRequest(
                        request.id,
                      );
                    },
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      AppTheme.primary,
                      foregroundColor:
                      Colors.white,
                      elevation: 0,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                        FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =============================================================
  // ACCEPTED CARD
  // =============================================================

  Widget _buildAcceptedCard(
      _ConnectionRequest request,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF7F0),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFD2EBDD),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Color(0xFF2E9B68),
              size: 27,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  request.name,
                  style: const TextStyle(
                    color: AppTheme.navy,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${request.relationship} • Connected',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 30,
            height: 30,
            decoration:
            const BoxDecoration(
              color: Color(0xFFD5F0E1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Color(0xFF2E9B68),
              size: 19,
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // EMPTY STATE
  // =============================================================

  Widget _buildEmptyState() {
    return Container(
      key: const ValueKey('empty_state'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
        border: Border.all(
          color: const Color(0xFFE5ECEC),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: const BoxDecoration(
              color: Color(0xFFEAF7F6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.people_outline_rounded,
              color: AppTheme.primary,
              size: 37,
            ),
          ),

          const SizedBox(height: 17),

          const Text(
            'No connection requests',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.navy,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 7),

          const Text(
            'When someone requests access to your '
                'shared progress, their request will '
                'appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // INFORMATION STEP
  // =============================================================

  Widget _buildInfoStep({
    required String number,
    required String text,
  }) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF7F6),
            borderRadius:
            BorderRadius.circular(9),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              color: AppTheme.primary,
              fontSize: 10.5,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Padding(
            padding:
            const EdgeInsets.only(top: 3),
            child: Text(
              text,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 11.5,
                height: 1.35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ===============================================================
// CONNECTION STATUS
// ===============================================================

enum ConnectionStatus {
  pending,
  accepted,
}

// ===============================================================
// CONNECTION REQUEST MODEL
// ===============================================================

class _ConnectionRequest {
  final String id;
  final String name;
  final String relationship;
  final String requestedAt;
  final ConnectionStatus status;

  const _ConnectionRequest({
    required this.id,
    required this.name,
    required this.relationship,
    required this.requestedAt,
    this.status = ConnectionStatus.pending,
  });

  _ConnectionRequest copyWith({
    String? id,
    String? name,
    String? relationship,
    String? requestedAt,
    ConnectionStatus? status,
  }) {
    return _ConnectionRequest(
      id: id ?? this.id,
      name: name ?? this.name,
      relationship:
      relationship ?? this.relationship,
      requestedAt:
      requestedAt ?? this.requestedAt,
      status: status ?? this.status,
    );
  }
}