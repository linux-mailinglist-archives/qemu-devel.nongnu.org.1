Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B64C775F7E6
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:11:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvIW-0005Pz-N1; Mon, 24 Jul 2023 09:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvHi-0004S3-2b
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvHf-0002fi-R2
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690204049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfpWTfZ+3x5RyL6taoFNi43rXXPurwpmB4npR5ydTnc=;
 b=SpEWjxWYpthrzbJo/K0iznVqz5PVN8Gy5JD7xr1Pe1EQDm9Vb9gn1BWUul0ty3el7fsAlT
 3nuyH9kWcaFQidJuy67DNtow+46ZAngBTJ5Ul9qrZrkPCVuLd9JZVHGD6qXF3sRen9TbBX
 9dsO/oB8WCIv8wMMd3m4RSVmpN2QYOw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-684-VlCWPl40MuSijTpiYnSYJw-1; Mon, 24 Jul 2023 09:07:15 -0400
X-MC-Unique: VlCWPl40MuSijTpiYnSYJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCB2C283476C
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 13:07:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23007F782D;
 Mon, 24 Jul 2023 13:07:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 15/26] migration.json: Don't use space before colon
Date: Mon, 24 Jul 2023 15:06:28 +0200
Message-Id: <20230724130639.93135-16-quintela@redhat.com>
In-Reply-To: <20230724130639.93135-1-quintela@redhat.com>
References: <20230724130639.93135-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20230612191604.2219-1-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 qapi/migration.json | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index ebc15e2782..7ccb28e64f 100644
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
@@ -276,7 +276,7 @@
            '*cpu-throttle-percentage': 'int',
            '*error-desc': 'str',
            '*blocked-reasons': ['str'],
-           '*postcopy-blocktime' : 'uint32',
+           '*postcopy-blocktime': 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
            '*compression': 'CompressionStats',
            '*socket-address': ['SocketAddress'],
@@ -551,7 +551,7 @@
 # Since: 1.2
 ##
 { 'struct': 'MigrationCapabilityStatus',
-  'data': { 'capability' : 'MigrationCapability', 'state' : 'bool' } }
+  'data': { 'capability': 'MigrationCapability', 'state': 'bool' } }
 
 ##
 # @migrate-set-capabilities:
@@ -1634,7 +1634,7 @@
 # Since: 2.9
 ##
 { 'command': 'xen-set-replication',
-  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' },
+  'data': { 'enable': 'bool', 'primary': 'bool', '*failover': 'bool' },
   'if': 'CONFIG_REPLICATION' }
 
 ##
-- 
2.40.1


