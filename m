Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7FB938985
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jul 2024 09:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn49-0002q8-PF; Mon, 22 Jul 2024 03:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3t-0001SE-Kc
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3p-0006VW-5d
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721631721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcrI6GYzSR24bBpvmlViN4vLayyZCi/l3RU57NSYOWw=;
 b=PZHEfPPvIg71rfsl7AF/gffsoDBqgp13H+RmwTamhka9FQeEfNCzb7O1hxgr24F7ejLsKS
 yFiJofRBrzT/LtCoxBoWtS4FwLGYZaSsUICiyt/6kenQB6EUcZ0IsXrqERi1JGz11ZgJTV
 VuSqFIluS1pUEn9rjWXvr5Xu91v5EEU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-a5n0T4IpM2yhYieWNxqxFQ-1; Mon,
 22 Jul 2024 03:01:56 -0400
X-MC-Unique: a5n0T4IpM2yhYieWNxqxFQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC7EB19792EE; Mon, 22 Jul 2024 07:01:49 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.252])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BEAD1944A9A; Mon, 22 Jul 2024 07:01:46 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 09/25] qga: conditionalize schema for commands unsupported on
 non-Linux POSIX
Date: Mon, 22 Jul 2024 10:01:06 +0300
Message-ID: <20240722070122.27615-10-kkostiuk@redhat.com>
In-Reply-To: <20240722070122.27615-1-kkostiuk@redhat.com>
References: <20240722070122.27615-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Rather than creating stubs for every command that just return
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
fully exclude generation of the commands on non-Linux POSIX
platforms

The command will be rejected at QMP dispatch time instead,
avoiding reimplementing rejection by blocking the stub commands.
This changes the error message for affected commands from

    {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}

to

    {"class": "CommandNotFound", "desc": "The command FOO has not been found"}

This has the additional benefit that the QGA protocol reference
now documents what conditions enable use of the command.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240712132459.3974109-10-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix.c | 66 --------------------------------------------
 qga/qapi-schema.json | 30 +++++++++++---------
 2 files changed, 17 insertions(+), 79 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 0dd8555867..559d71ffae 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -887,56 +887,6 @@ void qmp_guest_set_user_password(const char *username,
 }
 #endif /* __linux__ || __FreeBSD__ */
 
-#ifndef __linux__
-
-void qmp_guest_suspend_disk(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-}
-
-void qmp_guest_suspend_ram(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-}
-
-void qmp_guest_suspend_hybrid(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-}
-
-GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return -1;
-}
-
-GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-GuestMemoryBlockResponseList *
-qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-#endif
-
 #ifdef HAVE_GETIFADDRS
 static GuestNetworkInterface *
 guest_find_interface(GuestNetworkInterfaceList *head,
@@ -1272,22 +1222,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
 /* add unsupported commands to the list of blocked RPCs */
 GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
 {
-#if !defined(__linux__)
-    {
-        const char *list[] = {
-            "guest-suspend-disk", "guest-suspend-ram",
-            "guest-suspend-hybrid", "guest-get-vcpus", "guest-set-vcpus",
-            "guest-get-memory-blocks", "guest-set-memory-blocks",
-            "guest-get-memory-block-info",
-            NULL};
-        const char **p = list;
-
-        while (*p) {
-            blockedrpcs = g_list_append(blockedrpcs, g_strdup(*p++));
-        }
-    }
-#endif
-
 #if !defined(HAVE_GETIFADDRS)
     blockedrpcs = g_list_append(blockedrpcs,
                               g_strdup("guest-network-get-interfaces"));
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 2f0215afc7..38483652ac 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -566,7 +566,8 @@
 #
 # Since: 1.1
 ##
-{ 'command': 'guest-suspend-disk', 'success-response': false }
+{ 'command': 'guest-suspend-disk', 'success-response': false,
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
 
 ##
 # @guest-suspend-ram:
@@ -602,7 +603,8 @@
 #
 # Since: 1.1
 ##
-{ 'command': 'guest-suspend-ram', 'success-response': false }
+{ 'command': 'guest-suspend-ram', 'success-response': false,
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
 
 ##
 # @guest-suspend-hybrid:
@@ -638,7 +640,7 @@
 # Since: 1.1
 ##
 { 'command': 'guest-suspend-hybrid', 'success-response': false,
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestIpAddressType:
@@ -751,7 +753,8 @@
 { 'struct': 'GuestLogicalProcessor',
   'data': {'logical-id': 'int',
            'online': 'bool',
-           '*can-offline': 'bool'} }
+           '*can-offline': 'bool'},
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
 
 ##
 # @guest-get-vcpus:
@@ -766,7 +769,8 @@
 # Since: 1.5
 ##
 { 'command': 'guest-get-vcpus',
-  'returns': ['GuestLogicalProcessor'] }
+  'returns': ['GuestLogicalProcessor'],
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
 
 ##
 # @guest-set-vcpus:
@@ -809,7 +813,7 @@
 { 'command': 'guest-set-vcpus',
   'data':    {'vcpus': ['GuestLogicalProcessor'] },
   'returns': 'int',
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestDiskBusType:
@@ -1103,7 +1107,7 @@
   'data': {'phys-index': 'uint64',
            'online': 'bool',
            '*can-offline': 'bool'},
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @guest-get-memory-blocks:
@@ -1120,7 +1124,7 @@
 ##
 { 'command': 'guest-get-memory-blocks',
   'returns': ['GuestMemoryBlock'],
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestMemoryBlockResponseType:
@@ -1144,7 +1148,7 @@
 { 'enum': 'GuestMemoryBlockResponseType',
   'data': ['success', 'not-found', 'operation-not-supported',
            'operation-failed'],
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestMemoryBlockResponse:
@@ -1163,7 +1167,7 @@
   'data': { 'phys-index': 'uint64',
             'response': 'GuestMemoryBlockResponseType',
             '*error-code': 'int' },
-  'if': 'CONFIG_POSIX'}
+  'if': 'CONFIG_LINUX'}
 
 ##
 # @guest-set-memory-blocks:
@@ -1195,7 +1199,7 @@
 { 'command': 'guest-set-memory-blocks',
   'data':    {'mem-blks': ['GuestMemoryBlock'] },
   'returns': ['GuestMemoryBlockResponse'],
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestMemoryBlockInfo:
@@ -1208,7 +1212,7 @@
 ##
 { 'struct': 'GuestMemoryBlockInfo',
   'data': {'size': 'uint64'},
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @guest-get-memory-block-info:
@@ -1221,7 +1225,7 @@
 ##
 { 'command': 'guest-get-memory-block-info',
   'returns': 'GuestMemoryBlockInfo',
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestExecStatus:
-- 
2.45.2


