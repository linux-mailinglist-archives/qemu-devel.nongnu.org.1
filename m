Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5106E7A3DE5
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUZ-0004Yz-SO; Sun, 17 Sep 2023 17:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUX-0004Yd-Q4
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUW-0004GW-BD
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-404fbfac998so12917865e9.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986782; x=1695591582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBFk+yreDDX0nWyL6EEcBdBkcxtfOjeuNT23emez/IU=;
 b=GDDu2FNe7vbPWOI9Xsv+AxykHPpxB9VbgLIyKQ6b4sfbk0UKvwxWC8RKpK61VdSRky
 CJUGSmME3zSd9qlrtWJ+Kg5YdbEYPtnGE/mKA0/capklxihu0YlJpntrdMraqBx5KKTp
 nyio5xp74gBvVVgyCvt57uZou8++lzMiqjVGc8h5uPCY5qGfDCuaKZuVxmvEQdZWf22z
 jmozsRpt8GnTjoPPvvolbD8TVjrqpNWKPrOegr4zWnfbU08bnNtxWe+3PwR8V1EtYXM+
 zar35VmEgaxRGMXh5ETFJYNxDuYorkUE24IPqY44GV/MMq86RMyN4LKV9evdCscaGfZK
 Xsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986782; x=1695591582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBFk+yreDDX0nWyL6EEcBdBkcxtfOjeuNT23emez/IU=;
 b=U0KfzfioCCGD4BnFLX0WPP9VRCbmdoqkWYFmw42mbEbUxcJcdtaU/L8m6R9JH1wycH
 DC9A81PvzwbkP3o43VyhTITkGUiYstXH8nx3xMiBQx45nmBBo06enIp0h4F9aFoyoNel
 IpCtAFkIeQUN59E/OCM60Cjtd5pDrVq8JZpBSOlBEN5plIvJQrZ+hCDqwdcboxvQoJY/
 IAatGex0qstIheU+XZJXquUf42V5MW95iiJ4e2VyW7Lli6Rton75FHvJxGP63KqiXd8o
 jQlOL03SYDlxefr26S3BvVq943m5QVdZl6kqxjRZOY60/n+Tz/5ipWQP6GLNPt+APs2C
 asyg==
X-Gm-Message-State: AOJu0YwIxjsRA1d8I+psv1xHuSea1yIUuZkGH1hmCMvJeChARuSkM61r
 kAIvJBCo/fNnyuAnVLXKMRHtRvLKbvQ=
X-Google-Smtp-Source: AGHT+IHre4pbkUDPTd0KDxPLXSA8cvp5PC7He+YTsZ71MuSc7PUn7fCEDgLdcPv1a+zdRilPG5j0iw==
X-Received: by 2002:adf:a296:0:b0:321:4d1d:26f with SMTP id
 s22-20020adfa296000000b003214d1d026fmr1156365wra.29.1694986782536; 
 Sun, 17 Sep 2023 14:39:42 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:42 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 13/28] bsd-user: Implement getrusage(2).
Date: Mon, 18 Sep 2023 00:37:48 +0300
Message-ID: <20230917213803.20683-14-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-proc.h           | 13 +++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index fd05422d9a..57fea173c2 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -124,4 +124,17 @@ static inline abi_long do_bsd_getlogin(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* getrusage(2) */
+static inline abi_long do_bsd_getrusage(abi_long who, abi_ulong target_addr)
+{
+    abi_long ret;
+    struct rusage rusage;
+
+    ret = get_errno(getrusage(who, &rusage));
+    if (!is_error(ret)) {
+        host_to_target_rusage(target_addr, &rusage);
+    }
+    return ret;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 44cbf52f08..5d8693ed55 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -243,6 +243,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_getlogin(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getrusage: /* getrusage(2) */
+        ret = do_bsd_getrusage(arg1, arg2);
+        break;
+
 
         /*
          * File system calls.
-- 
2.42.0


