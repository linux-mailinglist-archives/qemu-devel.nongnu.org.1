Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E17B7514
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:36:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovJ-00047l-Am; Tue, 03 Oct 2023 19:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovF-00045N-Qx
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:25 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovE-00070n-0F
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:25 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79f8e4108c3so64861039f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376122; x=1696980922;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zC6tWs4rfSzDMqqF62xFCimHfrup5j1pBNgITHNb/0k=;
 b=nYSR44qxyJvpGlWBujbeUWKVeRqCNBi3k8iapNP4q44j5o2P/tDnjgkQoAFNU1rVMc
 bI1VJFERW/8yMF+aC1X9nYXEpTnJY6iozCbYFcbqSh1IKsCACg7mLRN/dg5OzEUkWhaS
 ILEPfZkGmMIh4wzVfww6hTo+Hk7tBYQQaNVzQUntEd1HZRc1agy4dfcBZ8kM7sU/LuVr
 cSADprbKSqT3gQQUngJeIjmNx1ic21LQ6fMmApn+pEvLNgoZF0uA69HVybq5m/0FFeJt
 QVxeMNW7x2ErWjqLFD0SN2IlYKmIYNYQPp1gI+jdbAvZ0jPv91GpoRYOdX/MDRmxLj38
 KhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376122; x=1696980922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zC6tWs4rfSzDMqqF62xFCimHfrup5j1pBNgITHNb/0k=;
 b=Rwsca4QRdZ3NC9Tr7g1AdJjhnJHd+Qt0dTt2/noKR3r74HS5JulMdwgW6nijSdCI5O
 95dC2qgNtGAOtdr888iOJ8x5RFNAaEsGNFHwjJyXTebPvdQ0anH6yc5DNPBND39m8tqv
 QYpCP2vAMQUYRuPI3Ilm9+cMhxR5R7/B9UaoRoi3v3mMOjpqVgirIwW9I40TsKd1v7ND
 iZkKMGdkU1BIiW3nRlnjS7jubZWdNE9zowtaorwXd7c8VFGKtjHG+YUEIJrzHPDizU8t
 UesU8Nzl7VfWo4ykIf0giXuOlGvYFOyURPt0I83QVmAPP5gYxKnKwcos0Lk8nmY6x1ya
 EKFA==
X-Gm-Message-State: AOJu0YyVF6HtnQIY6l7lN9rInbW25n4UN5UOolR+aFLN6SYO2/QHe10m
 lkSxQqGRYzN0hV9Ww5vn8N45apzd+8bpqK3VYy2SRw==
X-Google-Smtp-Source: AGHT+IEgvy38efNg4J5FZthuXhfl+xpTKfx0io9lT/m+8ulb/uQBYchlvjujBlkp7JFAZ9HxxboU9Q==
X-Received: by 2002:a6b:f209:0:b0:79f:9574:b93c with SMTP id
 q9-20020a6bf209000000b0079f9574b93cmr879342ioh.0.1696376122486; 
 Tue, 03 Oct 2023 16:35:22 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:22 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/51] bsd-user: Add stubs for profil(2), ktrace(2),
 utrace(2) and ptrace(2).
Date: Tue,  3 Oct 2023 17:31:41 -0600
Message-ID: <20231003233215.95557-18-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-18-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.h           | 28 ++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index a5f301c72ff..2c1a9ae22fa 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -362,4 +362,32 @@ static inline abi_long do_bsd_issetugid(void)
     return get_errno(issetugid());
 }
 
+/* profil(2) */
+static inline abi_long do_bsd_profil(abi_long arg1, abi_long arg2,
+                                     abi_long arg3, abi_long arg4)
+{
+    return -TARGET_ENOSYS;
+}
+
+/* ktrace(2) */
+static inline abi_long do_bsd_ktrace(abi_long arg1, abi_long arg2,
+                                     abi_long arg3, abi_long arg4)
+{
+    return -TARGET_ENOSYS;
+}
+
+/* utrace(2) */
+static inline abi_long do_bsd_utrace(abi_long arg1, abi_long arg2)
+{
+    return -TARGET_ENOSYS;
+}
+
+
+/* ptrace(2) */
+static inline abi_long do_bsd_ptrace(abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4)
+{
+    return -TARGET_ENOSYS;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7b51f4f16e4..1a760b13808 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -343,6 +343,22 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_issetugid();
         break;
 
+    case TARGET_FREEBSD_NR_profil: /* profil(2) */
+        ret = do_bsd_profil(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_ktrace: /* ktrace(2) */
+        ret = do_bsd_ktrace(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_utrace: /* utrace(2) */
+        ret = do_bsd_utrace(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_ptrace: /* ptrace(2) */
+        ret = do_bsd_ptrace(arg1, arg2, arg3, arg4);
+        break;
+
 
         /*
          * File system calls.
-- 
2.41.0


