Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5FF832C55
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 16:27:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqkQ-0002OL-He; Fri, 19 Jan 2024 10:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqkK-0002LU-Ba
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqkG-0001B6-Cz
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705677922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cycEAQ+H04gmOBvbTA9wDlHKZUvT/g78GgLcwOjOpvA=;
 b=Hj3UO1vXz3IpEdUrWIJxk/97WNn8rWqMUh37aatXaFIfm+LybAW4qjFignNg0CAZY3h7f6
 DNCOiRScOUNqoB/k0ZdMQVcOS14+ovcdhwk8+SQNExd2TPch6GqoQ3yTKV/XZtgCY6GGVH
 Lra6pmCSAU6s54CmNGmUD9etbRm9b58=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-Px3IJeOTOmW92VYpdo3njA-1; Fri, 19 Jan 2024 10:25:21 -0500
X-MC-Unique: Px3IJeOTOmW92VYpdo3njA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7157185A784;
 Fri, 19 Jan 2024 15:25:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0431140C95AD;
 Fri, 19 Jan 2024 15:25:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 08/11] qapi: Remove deprecated 'singlestep' member of StatusInfo
Date: Fri, 19 Jan 2024 16:25:04 +0100
Message-ID: <20240119152507.55182-9-thuth@redhat.com>
In-Reply-To: <20240119152507.55182-1-thuth@redhat.com>
References: <20240119152507.55182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This member has been deprecated before the 8.1 release, in commit
34c18203d4 ("qmp: Deprecate 'singlestep' member of StatusInfo").
Time to drop it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240117151430.29235-2-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst  | 14 --------------
 qapi/run-state.json        | 11 -----------
 system/runstate.c          |  8 --------
 tests/qemu-iotests/183.out |  4 ++--
 tests/qemu-iotests/234.out |  8 ++++----
 tests/qemu-iotests/262.out |  4 ++--
 tests/qemu-iotests/280.out |  2 +-
 7 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 9a2c994617..25527da423 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -151,20 +151,6 @@ accepted incorrect commands will return an error. Users should make sure that
 all arguments passed to ``device_add`` are consistent with the documented
 property types.
 
-``StatusInfo`` member ``singlestep`` (since 8.1)
-''''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``singlestep`` member of the ``StatusInfo`` returned from the
-``query-status`` command is deprecated. This member has a confusing
-name and it never did what the documentation claimed or what its name
-suggests. We do not believe that anybody is actually using the
-information provided in this member.
-
-The information it reports is whether the TCG JIT is in "one
-instruction per translated block" mode (which can be set on the
-command line or via the HMP, but not via QMP). The information remains
-available via the HMP 'info jit' command.
-
 QEMU Machine Protocol (QMP) events
 ----------------------------------
 
diff --git a/qapi/run-state.json b/qapi/run-state.json
index ca05502e0a..08bc99cb85 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -106,25 +106,15 @@
 #
 # @running: true if all VCPUs are runnable, false if not runnable
 #
-# @singlestep: true if using TCG with one guest instruction per
-#     translation block
-#
 # @status: the virtual machine @RunState
 #
 # Features:
 #
-# @deprecated: Member 'singlestep' is deprecated (with no
-#     replacement).
-#
 # Since: 0.14
 #
-# Notes: @singlestep is enabled on the command line with '-accel
-#     tcg,one-insn-per-tb=on', or with the HMP 'one-insn-per-tb'
-#     command.
 ##
 { 'struct': 'StatusInfo',
   'data': {'running': 'bool',
-           'singlestep': { 'type': 'bool', 'features': [ 'deprecated' ]},
            'status': 'RunState'} }
 
 ##
@@ -140,7 +130,6 @@
 #
 # -> { "execute": "query-status" }
 # <- { "return": { "running": true,
-#                  "singlestep": false,
 #                  "status": "running" } }
 ##
 { 'command': 'query-status', 'returns': 'StatusInfo',
diff --git a/system/runstate.c b/system/runstate.c
index fb07b7b71a..d6ab860eca 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -242,15 +242,7 @@ bool runstate_needs_reset(void)
 StatusInfo *qmp_query_status(Error **errp)
 {
     StatusInfo *info = g_malloc0(sizeof(*info));
-    AccelState *accel = current_accel();
 
-    /*
-     * We ignore errors, which will happen if the accelerator
-     * is not TCG. "singlestep" is meaningless for other accelerators,
-     * so we will set the StatusInfo field to false for those.
-     */
-    info->singlestep = object_property_get_bool(OBJECT(accel),
-                                                "one-insn-per-tb", NULL);
     info->running = runstate_is_running();
     info->status = current_run_state;
 
diff --git a/tests/qemu-iotests/183.out b/tests/qemu-iotests/183.out
index fd9c2e52a5..9277643853 100644
--- a/tests/qemu-iotests/183.out
+++ b/tests/qemu-iotests/183.out
@@ -30,13 +30,13 @@ read 65536/65536 bytes at offset 0
        'arguments': { 'uri': 'unix:SOCK_DIR/migrate', 'blk': true } }
 {"return": {}}
 { 'execute': 'query-status' }
-{"return": {"status": "postmigrate", "singlestep": false, "running": false}}
+{"return": {"status": "postmigrate", "running": false}}
 
 === Do some I/O on the destination ===
 
 { 'execute': 'query-status' }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
-{"return": {"status": "running", "singlestep": false, "running": true}}
+{"return": {"status": "running", "running": true}}
 { 'execute': 'human-monitor-command',
        'arguments': { 'command-line':
                       'qemu-io disk "read -P 0x55 0 64k"' } }
diff --git a/tests/qemu-iotests/234.out b/tests/qemu-iotests/234.out
index 692976d1c6..ac8b64350c 100644
--- a/tests/qemu-iotests/234.out
+++ b/tests/qemu-iotests/234.out
@@ -15,8 +15,8 @@ Starting migration to B...
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 completed
 completed
-{"return": {"running": false, "singlestep": false, "status": "postmigrate"}}
-{"return": {"running": true, "singlestep": false, "status": "running"}}
+{"return": {"running": false, "status": "postmigrate"}}
+{"return": {"running": true, "status": "running"}}
 Add a second parent to drive0-file...
 {"return": {}}
 Restart A with -incoming and second parent...
@@ -32,5 +32,5 @@ Starting migration back to A...
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 completed
 completed
-{"return": {"running": true, "singlestep": false, "status": "running"}}
-{"return": {"running": false, "singlestep": false, "status": "postmigrate"}}
+{"return": {"running": true, "status": "running"}}
+{"return": {"running": false, "status": "postmigrate"}}
diff --git a/tests/qemu-iotests/262.out b/tests/qemu-iotests/262.out
index 8e04c496c4..b8a2d3598d 100644
--- a/tests/qemu-iotests/262.out
+++ b/tests/qemu-iotests/262.out
@@ -13,5 +13,5 @@ Starting migration to B...
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 completed
 completed
-{"return": {"running": false, "singlestep": false, "status": "postmigrate"}}
-{"return": {"running": true, "singlestep": false, "status": "running"}}
+{"return": {"running": false, "status": "postmigrate"}}
+{"return": {"running": true, "status": "running"}}
diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
index c75f437c00..546dbb4a68 100644
--- a/tests/qemu-iotests/280.out
+++ b/tests/qemu-iotests/280.out
@@ -12,7 +12,7 @@ Enabling migration QMP events on VM...
 VM is now stopped:
 completed
 {"execute": "query-status", "arguments": {}}
-{"return": {"running": false, "singlestep": false, "status": "postmigrate"}}
+{"return": {"running": false, "status": "postmigrate"}}
 
 === Create a snapshot of the disk image ===
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-top", "size": 0}}}
-- 
2.43.0


