Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DD0830962
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:14:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7cv-0000A3-Ko; Wed, 17 Jan 2024 10:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7cr-0008Qu-QG
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:14:45 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7co-0005nx-Ae
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:14:44 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-559533e2503so3830541a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705504480; x=1706109280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRFIo+sANtkcthPh6i5AZChRwskxcATVI00RZjMZ6v0=;
 b=JHIPfVcpyky+QkKsmwfyQCsEmaj2BGHQNEM4ja5ey4whywEtXxto0L8stQ4BAuyQuu
 mo37SlMWMVihQARDXiiYujDsMd20Qstwcecd+IrDFNGYKh8topd8QSX0HpkqLIBYjWnR
 o2DQHCc12+lW3VAv/t9W9z7rqCU0FJIqaArHOv+Ip6zrGJshxuuS6OK7z1X53QVR1UsT
 Nzu5Buzvhjl2CVxSrUcHTPslFpc/6q7ZmLZ521nv/RdFttk8RtPHaDJ4/BceVDK1YPNF
 QVVjnR2UJFPy8aAUVyRcFRwgyKa533NZgK0G33TwET54CWHEuTH8u9Fr9hj4vxKfQnSx
 ANaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504480; x=1706109280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRFIo+sANtkcthPh6i5AZChRwskxcATVI00RZjMZ6v0=;
 b=RBtsh7LvIKHuzG9d1gAYQQvDXIDAgeOOcyC7Js35G3AqKcyHuVo2RGmvxuE6SX9N0M
 +Doo7YP+OWUJIUce+z3Z8DxDmwyZTSRk4O9++uU0hJCHEcIEahus6xB1LmobjCRBa8e8
 1h247TcOoRIDkoYY6pdeo1Podo8AgY3twqyaAu0QvpvGhj2/KLbz+GwdtiD2L+E18mOc
 CEn/d2Hkgs+GzuZMMhZceCjgTEQ72bGO/QsIBpaFDxzv4BfZ8rGD5U2JX4iF68orpUb+
 wOKvzbIhEuvcbm3v42n+Q0Bxv9xFYZR57FA1ZnHBn+KJ0AjdqGYkxlpqWA59BMbNdb/q
 /ddw==
X-Gm-Message-State: AOJu0Yyuh2o3UJ4Zh/cM5mnCj5N7zfHoytCmJhtAeHHn20AHG2+/G3CD
 hg1a/Jt/jUwm+ftMjkztjPeOwkHmWyEhLMt/Oc4SqvAB5ng=
X-Google-Smtp-Source: AGHT+IEXwcYUmgqXF16vOM/+/oFy9A/Ro5mBV176cwKMucJagcvWN+WBedGv8AhMkw6CHlZrfkOqNw==
X-Received: by 2002:a05:6402:5241:b0:557:8a58:ebdc with SMTP id
 t1-20020a056402524100b005578a58ebdcmr6015904edd.9.1705504480473; 
 Wed, 17 Jan 2024 07:14:40 -0800 (PST)
Received: from m1x-phil.lan ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 b23-20020a056402139700b0055920196ddesm5111488edv.54.2024.01.17.07.14.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jan 2024 07:14:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, devel@lists.libvirt.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] qapi: Remove deprecated 'singlestep' member of StatusInfo
Date: Wed, 17 Jan 2024 16:14:28 +0100
Message-ID: <20240117151430.29235-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240117151430.29235-1-philmd@linaro.org>
References: <20240117151430.29235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This member has been deprecated before the 8.1 release, in commit
34c18203d4 ("qmp: Deprecate 'singlestep' member of StatusInfo").
Time to drop it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.41.0


