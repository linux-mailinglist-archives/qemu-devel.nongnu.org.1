Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 362739D96DE
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Nov 2024 12:59:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFuCn-0004ON-I3; Tue, 26 Nov 2024 06:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tFuCj-0004N3-PI
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:58:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tFuCh-000316-Dp
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732622281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=slmy+fHdgldNl5byxBojnjlZ/STyoZ5w1W2jmEOHjpo=;
 b=R42+nsAKADbP6P4Xhferjxg1gRyjHIC0NdgWlsKxdsALvkBJEUYxyW9zUAQ2lg/EX6uSLO
 p/evDIj3VvsDDz43U2WXVZwdbBleh8FX2VUjHF3OtcS3xIjyGW15yNiDVv+mczFSVMKbmf
 sDk891hNWvk0PeXJf/JlWnMg90LXZN4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-NOI4SFi0OIaLilm3rj-QXQ-1; Tue,
 26 Nov 2024 06:57:59 -0500
X-MC-Unique: NOI4SFi0OIaLilm3rj-QXQ-1
X-Mimecast-MFC-AGG-ID: NOI4SFi0OIaLilm3rj-QXQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C82021953953; Tue, 26 Nov 2024 11:57:57 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.158])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 169681955F56; Tue, 26 Nov 2024 11:57:53 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v1 0/4] Allow to enable multifd and postcopy migration together
Date: Tue, 26 Nov 2024 17:27:44 +0530
Message-ID: <20241126115748.118683-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Prasad Pandit <pjp@fedoraproject.org>

Hello,

* Currently Multifd and Postcopy migration can not be used together.
  QEMU shows "Postcopy is not yet compatible with multifd" message.

  When migrating guests with large (100's GB) RAM, Multifd threads
  help to accelerate migration, but inability to use it with the
  Postcopy mode delays guest start up on the destination side.

* This patch series allows to enable both Multifd and Postcopy
  migration together. Precopy and Multifd threads work during
  the initial guest (RAM) transfer. When migration moves to the
  Postcopy phase, Multifd threads are restrained and the Postcopy
  threads start to request pages from the source side.

* This series removes magic value (4-bytes) introduced in the
  previous series for the Postcopy channel.

  v0 -> https://lore.kernel.org/qemu-devel/20241029150908.1136894-1-ppandit@redhat.com/T/#u

Thank you.
---
Prasad Pandit (4):
  migration/multifd: move macros to multifd header
  migration: remove multifd check with postcopy
  migration: refactor ram_save_target_page functions
  migration: enable multifd and postcopy together

 migration/migration.c      | 95 ++++++++++++++++++++++++--------------
 migration/multifd-nocomp.c |  3 +-
 migration/multifd.c        |  5 --
 migration/multifd.h        |  5 ++
 migration/options.c        |  5 --
 migration/ram.c            | 74 +++++++++--------------------
 6 files changed, 89 insertions(+), 98 deletions(-)

-- 
2.47.0


