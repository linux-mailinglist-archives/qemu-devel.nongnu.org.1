Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7129B77A6C2
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:14:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpw-0008GT-DS; Sun, 13 Aug 2023 10:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpm-0008D9-W5
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:48 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpl-0000uv-2x
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:46 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3180fd48489so2832630f8f.3
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935963; x=1692540763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/pm7PUDTlSRoOOpzR5gtIrbIF/DxYO36NC9GLHOZYTQ=;
 b=RCfgJC2/fKLYOvK4cly6OQ1xtzLROl0jgz1p/tpQs6eZUgJtQ9yrcRIxPaFuu4bk1a
 2Z52XFXgOFUOWwJVz4pQo+cBWDoiZCZci04Dn6OqFo8uglx6CAMxDYE8GBA4/mnpkJer
 b+x9uN9/5aeahz4wHt5zlMRLqyQQrr23Xx5pnKg8ln8oLdXzEyLBxMjbvlv5DRxw7vU2
 L+6fM+2lEV12/O092lDJG1v4GDWIQjFyNh/eM3acV0glGk0/+ZTtxudim0EshsQOpH7r
 zv/PvlWnpbZR60+tPVxTbO7m4yVn5ojzV0hp6zhnNZ+foROyF6/hNSvLxCttz/4vzO+h
 /kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935963; x=1692540763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/pm7PUDTlSRoOOpzR5gtIrbIF/DxYO36NC9GLHOZYTQ=;
 b=jNRhj6TtY2H/cEGdlVFPi2Won8z3+c656kBkrXDdPBeeQMW0cmtOeoCWrQcctsKDMS
 tp1qptEvBgmFdCjEF8CjC63HWA1vW78HKO6nc6E8PPZumnpnTLYNOXzOfNrBBjiWag14
 xf6GFwSQzW51gg0EhKOEcJ7yyCSz2/U2SEQtrt/eUYIrcTstX2V7LlRRlWGbW41cFCZl
 kHTBE31dzssVcJiJvHlYwZl9Ggoi237/xQOMGe0UqLtUFiLuCXPuNS1ZHxCw90Vo09S9
 Z0cEfhX429mMvU72m+Tb0Lk296CXfeq61t4FKONdK+gpRZzHOZ+M2V/ayKrjZhCrr7f3
 77yA==
X-Gm-Message-State: AOJu0YyTZc0Z9SNapUlZcAc7+DF7pD2nanP8+OpujesMB8rWW+U3tf3Z
 288sg/9I2TZyT0FZUUSQiHJ6hL+gqNE=
X-Google-Smtp-Source: AGHT+IGTFfd3BESnRPUo6anvB6vhT3bdhVM6bzCH0NTfImauFYjWrWa1Q4tVyb9apziI61DkOdfj2Q==
X-Received: by 2002:a5d:500f:0:b0:317:759a:8ca8 with SMTP id
 e15-20020a5d500f000000b00317759a8ca8mr4453849wrt.67.1691935963528; 
 Sun, 13 Aug 2023 07:12:43 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:43 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 29/32] Add glue to call the following syscalls to the
 freebsd_syscall function:
Date: Sun, 13 Aug 2023 05:10:10 +0200
Message-Id: <20230813031013.1743-30-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Warner Losh <imp@bsdimp.com>

freebsd11_stat
freebsd11_lstat
freebsd11_fstat
freebsd11_fstatat
freebsd11_nstat, freebsd11_nfstat, freebsd11_nlstat
fstatat
fstat

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-syscall.c | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 2224a280ea..ade47a0d2f 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -36,6 +36,9 @@
 #include "bsd-file.h"
 #include "bsd-proc.h"
 
+/* *BSD dependent syscall shims */
+#include "os-stat.h"
+
 /* I/O */
 safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode);
 safe_syscall4(int, openat, int, fd, const char *, path, int, flags, mode_t,
@@ -482,6 +485,45 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_undelete(arg1);
         break;
 
+        /*
+         * stat system calls
+         */
+    case TARGET_FREEBSD_NR_freebsd11_stat: /* stat(2) */
+        ret = do_freebsd11_stat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_lstat: /* lstat(2) */
+        ret = do_freebsd11_lstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstat: /* fstat(2) */
+        ret = do_freebsd11_fstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fstat: /* fstat(2) */
+        ret = do_freebsd_fstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstatat: /* fstatat(2) */
+        ret = do_freebsd11_fstatat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_fstatat: /* fstatat(2) */
+        ret = do_freebsd_fstatat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_nstat: /* undocumented */
+        ret = do_freebsd11_nstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_nfstat: /* undocumented */
+        ret = do_freebsd11_nfstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_nlstat: /* undocumented */
+        ret = do_freebsd11_nlstat(arg1, arg2);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.40.0


