Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA537B755F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:43:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovr-0004UU-Uz; Tue, 03 Oct 2023 19:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovl-0004MC-KX
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:57 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnova-0007Rp-N3
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:53 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7a2a9e5451bso58473039f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376144; x=1696980944;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhtBcCLqYRdXH9l+jJ0/HOZSt1P08pHO71aNhpu5SkU=;
 b=KePwgqR+LjZVCeHEvB6Ra/e50uGGhPKZYGizutrfJfdpSl9FQ0VvQBMLhcXIR/278k
 QgMvNl50XRhtEhsAoOLyjxcuZsFvanDJP383WOJZqNsLEdG3DLCXzQuARkchJT9VroVo
 xBQFVJQdzxKH+pKiRjKXBD4HMCMiYfGl2qkd+acXUQLz/6LiodD6uhdfJFGNy/b/ZXJW
 XM5Bs0Z/eaaoX2m+1tFMsRhDb6Ny0GI0Q3HehJZ2zduWOxobi46RCu5jSTtASKAXp+4e
 wUQOdpsYXzFcIkhNgq4S1acd41Bs+Nzdn9YrVFYaGDp2nC3rZf4hGrGqjo1HD2eYCdwM
 pNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376144; x=1696980944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhtBcCLqYRdXH9l+jJ0/HOZSt1P08pHO71aNhpu5SkU=;
 b=Hx+X2TUIrz2OJZ8gq7Tngl8QYQUgqVbaldySasWNf/vdDEsk3MdJ5QjC3GX6ZBUOl6
 JxxUQu4cg6KZXOEA88mIOQn3vA8SHUhiTmSQMzyZBuq8Y6MYP5qwdhJDSrnphvQ6aO1Z
 BE1KbjXtTXCZyapLKU9pHD55L3chzfkecOKS6eGP8QWe0QuFvBcPrvOD9NAN1FJD30og
 WjCbkKbTaW+Zq3yoDTtvsHExUveOHohpHxQTZ/Sq0crdjAMHop7hvaR9mrpuSz9c0AUs
 /UFe0bwVjUU2WJjFNrEX1J+o1CscGTNtB88xiON55Hehhah/3Qf6XjzxFNXmEjUaper8
 kpfg==
X-Gm-Message-State: AOJu0YwdEUVnnUfw9GPZeJtJccBW/x3Td4x2ssgP99Ilj7SJFJJf0DXK
 HcclBK2vo+P4qr8ttD0eDCm0H4p9/3OC4nUMDJGrtw==
X-Google-Smtp-Source: AGHT+IFWNfpsiO8BvmONe6EdFceFlZ5Ap0NP1iqQnIsvyXBQdKEQZ0fgKkbxrsSMYcvwKQdwW8dbvg==
X-Received: by 2002:a6b:6816:0:b0:79f:b37f:98e6 with SMTP id
 d22-20020a6b6816000000b0079fb37f98e6mr839194ioc.20.1696376144232; 
 Tue, 03 Oct 2023 16:35:44 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:43 -0700 (PDT)
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
Subject: [PULL 41/51] bsd-user: Implement mprotect(2)
Date: Tue,  3 Oct 2023 17:32:05 -0600
Message-ID: <20231003233215.95557-42-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d33;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182709.4834-14-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 7 +++++++
 bsd-user/freebsd/os-syscall.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 76b504f70c5..0f9e4a1d4be 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -81,4 +81,11 @@ static inline abi_long do_bsd_munmap(abi_long arg1, abi_long arg2)
     return get_errno(target_munmap(arg1, arg2));
 }
 
+/* mprotect(2) */
+static inline abi_long do_bsd_mprotect(abi_long arg1, abi_long arg2,
+        abi_long arg3)
+{
+    return get_errno(target_mprotect(arg1, arg2, arg3));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index b03837d032a..2d8f1a953b2 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -807,6 +807,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_munmap(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_mprotect: /* mprotect(2) */
+        ret = do_bsd_mprotect(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.41.0


