Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC0C77AB04
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:50:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVH00-0007y0-Ea; Sun, 13 Aug 2023 15:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzz-0007xP-0V
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzx-0002U2-KW
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb724cso34232115e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955815; x=1692560615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4TDGnSVrOnvNGdNPNB2y8HJgZ+Gw6JDP/CgVEdN2Ss=;
 b=JCd8W9NgQQGMyIOy5fORR+Ix62tcOxDNLy/4+C14nPeKWkna6TdWDwIf45CZV3YH79
 vXBbZG8xrqqBciebZrQcwdULpapjLkW7KFhA95/aJfZsdMNbCvIJq7hnbH1y2820OrSf
 vCaBVltzkNBP8I0jdQlLwe4LUHxcqJ7GRpXdczAYar8rFmJ85+DpS53vut2DReRlpAvV
 /7RhFjwZAPtUdJM5vpu8TkNuj/loKmx2fwhw3Q3InsWQkKZR8vpbMHOqTrMFC0Ak//4U
 xpAcCPSLn0d+FPDmyDzPuQvmlQZzc2ya7l60IvCeHV05GJsWYgN8Un/djTsCqcKiaYku
 9/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955815; x=1692560615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4TDGnSVrOnvNGdNPNB2y8HJgZ+Gw6JDP/CgVEdN2Ss=;
 b=JsxCHnZXy96qAyx0/+upzn/vFPVJPCkhfCnO1CzQqJr23XfooMX/fw8WA7gFde/XTh
 xnv3LC5OkBI2+m2z1DsfWvtZiNOeMTjcgLJ/hCbsGd53k/qWjKGsT2eHwbNPRLd/gR4M
 VcH0Hp/cosDjEGbJgk1EiSszdYcJV0aCFu/bnTN/R4+A+X4rqDYxv2+uxgvnRlLfYpeo
 zDZAjB26otOLl5WWk6tG7/aVp7PPDv0w/kuErb01zMeM1cXCPB7K8SfyIN8BH455CWW0
 yc9jXx4feT4tN619PagJsFrdSWcwFhHkNZWH/cyBatodpWTLBuXtmTuxwUZDfcs77icX
 p3Vw==
X-Gm-Message-State: AOJu0YwpBeDLnbrIN9dCYgu/RAjiBaTPfV7vtvIOO2QYTCfJfejSyE6Q
 uqeaTMDD9vEE6nS9i/sHPYJoW7S7lj8=
X-Google-Smtp-Source: AGHT+IEPenw1mzgdnwuhd/127SMQNZ6IG1XrWA4YoZGeZK2l9xQFaE0buvdpQt9B1ZVkGm0xpchG4g==
X-Received: by 2002:a05:600c:2301:b0:3fe:1f98:deb7 with SMTP id
 1-20020a05600c230100b003fe1f98deb7mr6274383wmo.35.1691955815610; 
 Sun, 13 Aug 2023 12:43:35 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:35 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 30/32] Add glue to call the following syscalls to the
 freebsd_syscall function:
Date: Sun, 13 Aug 2023 10:41:51 +0200
Message-Id: <20230813084153.6510-31-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32a.google.com
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


