Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE18F7B86CC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:42:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5k5-0003bW-8U; Wed, 04 Oct 2023 13:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5k3-0003aw-DI
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:32:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5ji-0000zz-1S
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:32:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3231d6504e1so102555f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440756; x=1697045556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0f/S9sk5n4iTXtNvEpxFckitQTJsYOjTpjl0/I1BCA=;
 b=PmqwI1mTj7JMI2SxH81d4YYnLWp5gevd4JSRKqgkEmuJAr3oBEUXQnduWReC14Wvhp
 iWML/SAKHzI4H+YxidQM0MMBjo9ti/nuk2csQSNwvSofFKr16VRTQHC9LdlmobptxNiA
 coFD6jynmjbhOqN5vRm/D/LbHpJ1COYPZUBNncYaP5X62uBJ4DIALCKhfjo3Ys2fl0f0
 iMz2tjGhI+5RvA3bc1aPv4BcUVXQcM5ryu+uobH8EYqrDTgUxhepXskfhffUVHJVKaPW
 +dWzaCqlZx5mua+un7N0UceFS6fcKFS6PwXkGj3reyeX/cKLjymsHH/QEh9s91ZOT0ZK
 u0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440756; x=1697045556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0f/S9sk5n4iTXtNvEpxFckitQTJsYOjTpjl0/I1BCA=;
 b=O5VuYvDRje6t3EiwSq/YS1FkmopPVMXZjiWptm5Hlc2kbu+CFqr8A5qAQv+DjY6jHC
 PrBo/53LQxHksyidOtcVGNYuA34AU9xNodymc/PEHTErmf980Ma8MerScH2lqWC/aIfZ
 5fLiTn37llSxJP4mQ07MxE5dYyFCAq6KzQEeITmEWcR7c4DVRbBqoUsGIoNm4K+diMTG
 dFax4U57f257Ees4c6SjnZAcRKqKNNTwGKEiVWNWByRctYSrysiBcbZ/fsUU9fct7RsR
 /2PafiyhwenFhiLD6e0n/l8dtCEDmKEow7uIB35q8j5h7BJrylF+NUI09JfIDSjDnKaS
 9i7A==
X-Gm-Message-State: AOJu0YxOwMmo/9BmGThdUZOwZv0jwqHcBAQwYKYNdU4YBFB4IaQ0j/0S
 Sv4OAPMQm4BWmnsaKMoqDO8upBhYZF8RsY6Qgxs=
X-Google-Smtp-Source: AGHT+IEyJRF13iyLbNh6DMzMUU/xyLRb/9FWN5daRf86NmsoNelUul76wjR8GQLPMWAtW6Oyc61i+w==
X-Received: by 2002:adf:efd1:0:b0:31f:fc96:9af1 with SMTP id
 i17-20020adfefd1000000b0031ffc969af1mr2729111wrp.59.1696440756089; 
 Wed, 04 Oct 2023 10:32:36 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 j6-20020adfff86000000b0031423a8f4f7sm4508086wrr.56.2023.10.04.10.32.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:32:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 05/21] qapi: Inline QERR_INVALID_PARAMETER definition
 (constant parameter)
Date: Wed,  4 Oct 2023 19:31:40 +0200
Message-ID: <20231004173158.42591-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using the following
coccinelle semantic patch:

    @match@
    expression errp;
    constant param;
    @@
         error_setg(errp, QERR_INVALID_PARAMETER, param);

    @script:python strformat depends on match@
    param << match.param;
    fixedfmt; // new var
    @@
    fixedfmt = f'"Invalid parameter \'{param[1:-1]}\'"' # Format skipping '"'.
    coccinelle.fixedfmt = cocci.make_ident(fixedfmt)

    @replace@
    expression match.errp;
    constant match.param;
    identifier strformat.fixedfmt;
    @@
    -    error_setg(errp, QERR_INVALID_PARAMETER, param);
    +    error_setg(errp, fixedfmt);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 dump/dump.c        | 6 +++---
 qga/commands.c     | 2 +-
 ui/ui-qmp-cmds.c   | 2 +-
 util/qemu-option.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index d4ef713cd0..e173f1f14c 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1810,7 +1810,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
 
     s->fd = fd;
     if (has_filter && !length) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "length");
+        error_setg(errp, "Invalid parameter 'length'");
         goto cleanup;
     }
     s->filter_area_begin = begin;
@@ -1841,7 +1841,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
 
     /* Is the filter filtering everything? */
     if (validate_start_block(s) == -1) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "begin");
+        error_setg(errp, "Invalid parameter 'begin'");
         goto cleanup;
     }
 
@@ -2145,7 +2145,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     }
 
     if (fd == -1) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "protocol");
+        error_setg(errp, "Invalid parameter 'protocol'");
         return;
     }
 
diff --git a/qga/commands.c b/qga/commands.c
index 09c683e263..871210ab0b 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -154,7 +154,7 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **errp)
 
     gei = guest_exec_info_find(pid);
     if (gei == NULL) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "pid");
+        error_setg(errp, "Invalid parameter 'pid'");
         return NULL;
     }
 
diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index debc07d678..41ca0100e7 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -44,7 +44,7 @@ void qmp_set_password(SetPasswordOptions *opts, Error **errp)
         assert(opts->protocol == DISPLAY_PROTOCOL_VNC);
         if (opts->connected != SET_PASSWORD_ACTION_KEEP) {
             /* vnc supports "connected=keep" only */
-            error_setg(errp, QERR_INVALID_PARAMETER, "connected");
+            error_setg(errp, "Invalid parameter 'connected'");
             return;
         }
         /*
diff --git a/util/qemu-option.c b/util/qemu-option.c
index eedd08929b..fb391a7904 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -612,7 +612,7 @@ QemuOpts *qemu_opts_create(QemuOptsList *list, const char *id,
 
     if (list->merge_lists) {
         if (id) {
-            error_setg(errp, QERR_INVALID_PARAMETER, "id");
+            error_setg(errp, "Invalid parameter 'id'");
             return NULL;
         }
         opts = qemu_opts_find(list, NULL);
-- 
2.41.0


