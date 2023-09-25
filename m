Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 875C97ADF13
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:37:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqK7-0008Dr-Kf; Mon, 25 Sep 2023 14:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK4-0008Ag-Bg
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:44 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK2-0007kU-Lx
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-405361bb93bso68153745e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666520; x=1696271320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZEj0PmQKtrSTSS1pylbPvyIf7jZoRzyI7RzMk4h4sk=;
 b=fDmdRcu6GMugS/LFj8dqJWuJq/TOd6XqoVJmmsqdU73Q2B4QF1tbwBj1wmnMGbI3bx
 pK6maNddnSfx/JEZ3KAIgmEJcz6HZ+tT+TSRPLNJDFWcaWIbZR8A/az37AbUVBWiauV+
 v02RwdiRm+BIGL7+CAYAfQt51cA6rEx/Ysr6Eh2d5id8qtiNlubXcKlMEJAMWoBFyqXa
 PM0OFHydE2uU9CO46q1+A8i1h808zjBq/UHdXpE1sJQblGhAj44ZW2o35cObl5imVq1M
 tHoIXXiiG6otmQCmvLM4nB3Y/13xTXUiz3SoDA9tyzFow2flK5CJKos9EboE5zeKN96K
 T4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666520; x=1696271320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZEj0PmQKtrSTSS1pylbPvyIf7jZoRzyI7RzMk4h4sk=;
 b=G8W6dXXt9DSXsPOtv8STlhbkjZTcyaG76+0ylUfmp6S+DbNhb/ykZZ95lbnqibEFPh
 DGrUvGA+vHMBXnjLcIEQDw26AnRJkRtKywKGjQKEECKAnYzkDW49nCZgPXg0Vvtdgzhh
 epy46BIec7NnuU4mkF1XE7yjGkQSypkn2Vutrh2H/kgHwZ9/29Qjje2+CwPM6MFyHpY0
 250ocvLtZhf/NUBH8aaR6+c9vhA9HQpQsJNtNJmJl5QYMLvl5PksoLTn3Zq+VtOaDC7/
 60jbeIQQxrA8Y1ea0+1LTPfczWPElH8GPs0B0JexTZwnVBP6rJh//nMHCC6jfr/HiNIV
 B+rg==
X-Gm-Message-State: AOJu0YzAjlB35u8APxTk2nASjwX2CDZqDCINa2q9k6s/t1ZANFpkc7Y5
 /TTzmld1BgeEkiz4duhwq7RuFf7I4ts=
X-Google-Smtp-Source: AGHT+IEirFy1icC30NRTO7tr1ci4hnXyq96P+DgNHKYq9eBjVivG+4djzB+Kr3LhqYWC/mU+w2sy7Q==
X-Received: by 2002:a7b:c3d9:0:b0:401:bf56:8ba6 with SMTP id
 t25-20020a7bc3d9000000b00401bf568ba6mr6323240wmj.28.1695666519993; 
 Mon, 25 Sep 2023 11:28:39 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:39 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 06/23] bsd-user: Implement shm_rename(2) system call
Date: Mon, 25 Sep 2023 21:26:52 +0300
Message-ID: <20230925182709.4834-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x330.google.com
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-misc.h    | 24 ++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 6b424b7078..67e450fe7c 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -66,5 +66,29 @@ static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
 }
 #endif /* __FreeBSD_version >= 1300048 */
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
+/* shm_rename(2) */
+static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulong toptr,
+        abi_ulong flags)
+{
+    int ret;
+    void *ufrom, *uto;
+
+    ufrom = lock_user_string(fromptr);
+    if (ufrom == NULL) {
+        return -TARGET_EFAULT;
+    }
+    uto = lock_user_string(toptr);
+    if (uto == NULL) {
+        unlock_user(ufrom, fromptr, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(shm_rename(ufrom, uto, flags));
+    unlock_user(ufrom, fromptr, 0);
+    unlock_user(uto, toptr, 0);
+
+    return ret;
+}
+#endif /* __FreeBSD_version >= 1300049 */
 
 #endif /* OS_MISC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 74146d8c72..ae92a2314c 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -603,6 +603,12 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
+    case TARGET_FREEBSD_NR_shm_rename: /* shm_rename(2) */
+        ret = do_freebsd_shm_rename(arg1, arg2, arg3);
+        break;
+#endif
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.42.0


