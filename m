Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD9772CF2F
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 21:16:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8n1X-0006UL-DR; Mon, 12 Jun 2023 15:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q8n1U-0006S0-Tq
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q8n1S-0002ZC-Gu
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686597373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rj3dEjt2xo4A0wTtPF2NmIos8IZdMzwcatch8bQFbVM=;
 b=TnTErg3Xbf5Ro1uVQhK43DuZ6vp12lo2jyr9jpOoRWww4p6XgXPYRSBeKtdd5uQxadOfg3
 2Knvt20UTWp9wWIEkPh/J/UHD0f2m+5WAIc34JfrAw/75rRwLpJkX8m1KlX68tDbfQeinA
 vjnwMmAW59shwODHdW0LT3he/LzHlPw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-rtPdVCqTN0Wako8-gpUvpg-1; Mon, 12 Jun 2023 15:16:12 -0400
X-MC-Unique: rtPdVCqTN0Wako8-gpUvpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6B5B801585
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 19:16:11 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E8F840D1B60;
 Mon, 12 Jun 2023 19:16:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH] migration.json: Don't use space before colon
Date: Mon, 12 Jun 2023 21:16:04 +0200
Message-Id: <20230612191604.2219-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

So all the file is consistent.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 qapi/migration.json | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 179af0c4d8..cb7cd3e578 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -67,13 +67,13 @@
 { 'struct': 'MigrationStats',
   'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
            'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
-           'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
-           'mbps' : 'number', 'dirty-sync-count' : 'int',
-           'postcopy-requests' : 'int', 'page-size' : 'int',
-           'multifd-bytes' : 'uint64', 'pages-per-second' : 'uint64',
-           'precopy-bytes' : 'uint64', 'downtime-bytes' : 'uint64',
-           'postcopy-bytes' : 'uint64',
-           'dirty-sync-missed-zero-copy' : 'uint64' } }
+           'normal-bytes': 'int', 'dirty-pages-rate': 'int',
+           'mbps': 'number', 'dirty-sync-count': 'int',
+           'postcopy-requests': 'int', 'page-size': 'int',
+           'multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
+           'precopy-bytes': 'uint64', 'downtime-bytes': 'uint64',
+           'postcopy-bytes': 'uint64',
+           'dirty-sync-missed-zero-copy': 'uint64' } }
 
 ##
 # @XBZRLECacheStats:
@@ -264,7 +264,7 @@
            '*cpu-throttle-percentage': 'int',
            '*error-desc': 'str',
            '*blocked-reasons': ['str'],
-           '*postcopy-blocktime' : 'uint32',
+           '*postcopy-blocktime': 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
            '*compression': 'CompressionStats',
            '*socket-address': ['SocketAddress'] } }
@@ -516,7 +516,7 @@
 # Since: 1.2
 ##
 { 'struct': 'MigrationCapabilityStatus',
-  'data': { 'capability' : 'MigrationCapability', 'state' : 'bool' } }
+  'data': { 'capability': 'MigrationCapability', 'state': 'bool' } }
 
 ##
 # @migrate-set-capabilities:
@@ -1567,7 +1567,7 @@
 # Since: 2.9
 ##
 { 'command': 'xen-set-replication',
-  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' },
+  'data': { 'enable': 'bool', 'primary': 'bool', '*failover': 'bool' },
   'if': 'CONFIG_REPLICATION' }
 
 ##

base-commit: 5f9dd6a8ce3961db4ce47411ed2097ad88bdf5fc
prerequisite-patch-id: 99c8bffa9428838925e330eb2881bab476122579
prerequisite-patch-id: 77ba427fd916aeb395e95aa0e7190f84e98e96ab
prerequisite-patch-id: 9983d46fa438d7075a37be883529e37ae41e4228
prerequisite-patch-id: 207f7529924b12dcb57f6557d6db6f79ceb2d682
prerequisite-patch-id: 5ad1799a13845dbf893a28a202b51a6b50d95d90
prerequisite-patch-id: c51959aacd6d65ee84fcd4f1b2aed3dd6f6af879
prerequisite-patch-id: da9dbb6799b2da002c0896574334920097e4c50a
prerequisite-patch-id: c1110ffafbaf5465fb277a20db809372291f7846
prerequisite-patch-id: 8307c92bedd07446214b35b40206eb6793a7384d
prerequisite-patch-id: 0a6106cd4a508d5e700a7ff6c25edfdd03c8ca3d
prerequisite-patch-id: 83205051de22382e75bf4acdf69e59315801fa0d
prerequisite-patch-id: 8c9b3cba89d555c071a410041e6da41806106a7e
prerequisite-patch-id: 0ff62a33b9a242226ccc1f5424a516de803c9fe5
prerequisite-patch-id: 25b8ae1ebe09ace14457c454cfcb23077c37346c
prerequisite-patch-id: 466ea91d5be41fe345dacd4d17bbbe5ce13118c2
prerequisite-patch-id: d1045858f9729ac62eccf2e83ebf95cfebae2cb5
prerequisite-patch-id: 0276ec02073bda5426de39e2f2e81eef080b4f54
prerequisite-patch-id: 7afb4450a163cc1a63ea23831c50214966969131
prerequisite-patch-id: 06c053ce4f41db9675bd1778ae8f6a483641fcef
prerequisite-patch-id: 13ea05d54d741ed08b3bfefa1fc8bedb9c81c782
prerequisite-patch-id: 99c4e2b7101bc8c4b9515129a1bbe6f068053dbf
prerequisite-patch-id: 1e393a196dc7a1ee75f3cc3cebbb591c5422102f
prerequisite-patch-id: 2cf497b41f5024ede0a224b1f5b172226067a534
prerequisite-patch-id: 2a70276ed61d33fc4f3b52560753c05d1cd413be
prerequisite-patch-id: 17ec40f4388b62ba8bf3ac1546c6913f5d1f6079
prerequisite-patch-id: dba969ce9d6cf69c1319661a7d81b1c1c719804d
prerequisite-patch-id: 8d800cda87167314f07320bdb3df936c323e4a40
prerequisite-patch-id: 25d4aaf54ea66f30e426fa38bdd4e0f47303c513
prerequisite-patch-id: 082c9d8584c1daff1e827e44ee3047178e7004a7
prerequisite-patch-id: 0ef73900899425ae2f00751347afdce3739aa954
prerequisite-patch-id: e7db4730b791b71aaf417ee0f65fb6304566aaf8
prerequisite-patch-id: 62d7f28f8196039507ffe362f97723395d7bb704
prerequisite-patch-id: ea8de47bcb54e33bcc67e59e9ed752a4d1fad703
prerequisite-patch-id: 497893ef92e1ea56bd8605e6990a05cb4c7f9293
prerequisite-patch-id: 3dc869c80ee568449bbfa2a9bc427524d0e8970b
prerequisite-patch-id: 52c14b6fb14ed4ccd685385a9fbc6297b762c0ef
prerequisite-patch-id: 23de8371e9e3277c374a47f9bd10de209a22fdd5
prerequisite-patch-id: d21f036dd106af3375fb920bf0a557fe2b86d98e
prerequisite-patch-id: ca717076e9de83d6ce370f7374c4729a9f586fae
prerequisite-patch-id: a235b6ab3237155f2b39e8e10d47ddd250f6b6cc
prerequisite-patch-id: 6db2aa3d8a5804c85dd171864f5140fadf5f72da
prerequisite-patch-id: a799b883f4cb41c34ad074220293f372c6e0a9c7
prerequisite-patch-id: 5e012c426aef7b2f07513cec68e7efa1cf85fe52
prerequisite-patch-id: 4e614e7e3395dda7bae5f9fa21257c57cce45a39
prerequisite-patch-id: 67f8e68622c9698280ff5c5dc7469f36daf9a012
prerequisite-patch-id: d86078331449a21499e3f955e27bc87294969346
prerequisite-patch-id: 3f30d10e0ac7f53307f6b462eaf5b47151b73631
-- 
2.40.1


