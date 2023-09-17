Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D57A3E85
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bu-0006aJ-BC; Sun, 17 Sep 2023 18:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bq-0006YO-77
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bl-0002w9-2G
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-401f68602a8so42974575e9.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989463; x=1695594263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBFk+yreDDX0nWyL6EEcBdBkcxtfOjeuNT23emez/IU=;
 b=Ot+DQePFnrb5ILObqNtAuX0PFRpUj1gY3KemeHn/tAEwgpd7Cvh09jm1TBgL5uHkRl
 iIT48OPcQJ6qxXmjzBE97Zo/ApvMgyiIScrTrsQIg760biHjPLFKxz3wAvZTuuf0NJtA
 omiqyL/22/N32PIeiD9o/LntsmPjtamTFL6eJJ/i+XlbwdiyYINm1JdGsIeA1ucXnB82
 MCuJA7wiQUjWkoritITezti0urSEOaFB0klSXgfY1n11KoUmJcD4Vy7xXb17mxewoVqE
 Rck8rcLdsiaLH6Q4O/Yj0wttSuirTlQg/M0sa8mc00LmQNO3volmixqIK6tXmmmvhHN1
 hmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989463; x=1695594263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBFk+yreDDX0nWyL6EEcBdBkcxtfOjeuNT23emez/IU=;
 b=Nilov+4ekHmZZIsa3khjP6WKh5SC5A/yGSybfUPHurFFKJvtI0GdZOV0U5cndb1fSc
 x3SGEsKS7SfbUYn2ekZZlnC8kCc92XjQX55u1YWZRa16XekC6gkvVvq21IQ5GgAQSFYf
 v+ZkgwIjLuFxepSJSBIcu3a0SjY7pOz5BRJo3c+C7pfhQZzxpIzrNCvoCf8jaofMm/Qp
 TF5Pk6aOUqYSCN/fmWfnYCLMO73lLRz4yo+vL16rJS6g0GUIp0qR1Yn3BZuX0HQrnHlb
 M5VsVLX0ycJ+r0rbEYVwajcigreMCZzKc2mWAk25YMOHg9Jz5f6ThtGY5FQFr3+tsPeb
 gcIw==
X-Gm-Message-State: AOJu0YxYz3i5e54qi+UMvESM7Hgvfpf5QPUgHSt20K0B+HBfKzwWamXd
 A2IIrQ4Jce2q6nGMwCesmMXnBoZlrJk=
X-Google-Smtp-Source: AGHT+IH+a8oYE+fdHN4mCrf5Kak3EgYNqtE3x1JP4oFeSP2vwr4E3gMtakbyWrQ1WBXnXf8O+hDe9Q==
X-Received: by 2002:a05:6000:706:b0:321:5218:9434 with SMTP id
 bs6-20020a056000070600b0032152189434mr811616wrb.3.1694989463223; 
 Sun, 17 Sep 2023 15:24:23 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:22 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 13/28] bsd-user: Implement getrusage(2).
Date: Mon, 18 Sep 2023 01:22:30 +0300
Message-ID: <20230917222246.1921-14-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


