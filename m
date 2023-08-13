Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EEB77A6DB
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:19:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpv-0008GC-Jj; Sun, 13 Aug 2023 10:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpo-0008DI-6Z
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpm-0000vB-P0
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:47 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fe2048c910so32148685e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935965; x=1692540765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4TDGnSVrOnvNGdNPNB2y8HJgZ+Gw6JDP/CgVEdN2Ss=;
 b=I5hdk8uwSPICA5+06rpx+zyJBow9uCViKPEeTbphC9Hc2Z5/e6GiBlxCDl2Y3Pin3q
 rz0mhjPndMZ45pj4cXMI0DcOITRno+Mqx5DHbQ/bUInRg356sPVfyboOwLLeNpm4dvKe
 5sEwInXuSVboAgGN9ONI0rGj32WnZequUahKqTyKJDR/WOb6TtHFvoY0tBlOS62FGsrr
 l0UG+ncrPmTP7PQnWKiQJTrYGf23LfyMbrvmT5aGcO+NC1DfOtBbL5aOPFBCgv4zskLA
 W2kwmW1ZAZLfH1cAUDygL4iSdrwAN3nPS0fAOjzI4zAgRHB+ULLt12xR7KtF5mAZs54K
 bqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935965; x=1692540765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4TDGnSVrOnvNGdNPNB2y8HJgZ+Gw6JDP/CgVEdN2Ss=;
 b=LwqVTP2QwOiIY22VKvCyeWi7h9FPywHDAxHBNarhlVOf65m94ghn+K5prb3MSHRtVI
 UIE83L+9Li3z/s7QAFChCWwG6ZSXCSzbvClXgXjNEcF3OdA1374mRwsXQA6BTvv834Or
 m/tAZ8d9RZDaQ77A3qZVi6/kUJPTbj7elLWQcfs5dwOqwLvd9HErW/T+Ju2ShnKKSmnr
 At5QkJw+M77SVLzdO7zti1Zaop8C6eAPfRZ9AG+hK2RDFUp0BmxacxO19cx3MuxAIw/x
 fhBvYqVKpbcj3hoWUUEtYjc3b8GeiDCZxN6zu0tdxDg4lWk+j/c3PBb8JHlfSEof6zvf
 zL0A==
X-Gm-Message-State: AOJu0Yyb7zaL/Cd5hI6nqpQ5ndp7DqeCZfeSGohwIw2mXzQQV6PdFste
 MQIo8pCoJZEWR8QBLhtejjUnOWCgNxQ=
X-Google-Smtp-Source: AGHT+IF6tj1Tz5g7z42pTdBafhs8uApcHWWpSOKb8nXRRXCj60tUZeoCmkH0OBf7sqFYxOQImae6/A==
X-Received: by 2002:a05:600c:b44:b0:3fc:5a3:367c with SMTP id
 k4-20020a05600c0b4400b003fc05a3367cmr5730102wmr.32.1691935964687; 
 Sun, 13 Aug 2023 07:12:44 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:44 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 30/32] Add glue to call the following syscalls to the
 freebsd_syscall function:
Date: Sun, 13 Aug 2023 05:10:11 +0200
Message-Id: <20230813031013.1743-31-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
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

getfh
lgetfh
fhopen
freebsd11_fhstat
freebsd11_fhstatfs
fhstat
fhstatfs

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-syscall.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index ade47a0d2f..73616a5be0 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -524,6 +524,34 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd11_nlstat(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getfh: /* getfh(2) */
+        ret = do_freebsd_getfh(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_lgetfh: /* lgetfh(2) */
+        ret = do_freebsd_lgetfh(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhopen: /* fhopen(2) */
+        ret = do_freebsd_fhopen(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fhstat: /* fhstat(2) */
+        ret = do_freebsd11_fhstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhstat: /* fhstat(2) */
+        ret = do_freebsd_fhstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fhstatfs: /* fhstatfs(2) */
+        ret = do_freebsd11_fhstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhstatfs: /* fhstatfs(2) */
+        ret = do_freebsd_fhstatfs(arg1, arg2);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.40.0


