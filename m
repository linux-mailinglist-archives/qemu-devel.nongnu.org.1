Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7180E7B755D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovx-0004k2-Uu; Tue, 03 Oct 2023 19:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovq-0004Vk-BE
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:36:02 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovj-0007Tu-P5
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:59 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79fa7e33573so58992439f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376151; x=1696980951;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Vsuy4csP7DLV7i/HttRGs3+j2Bhu0vejsp7G9mGTsU=;
 b=M59Z5raogs6+TpWLVQ6iHPKjprtsTaUXch+tExhjU9GUHxCrfcS0ElL0nZPqVrS5te
 w1j5X2WzWchCv3tZ62B7UEpH8nSQ3XfFesp+J3gLhygioOzqUi5QauY72OuY3c4ImD7j
 lFbMSTMRSZIkwOOlnLvZ96SUozy2B1Ut79n5lyz/K5CGrku8QKgNIpvVmx53RgynaXtg
 4JzrlrVfmADQAuWvLTfqM9R6tShJI+3d0oJSwT6qW0MEPmX3Dy690Ncx9xIsMaaykp08
 PEsWyGQ7Jofw3uO4Fu0sTAtUAnTX25QxKQdTzuggZe2dK6lX59atdEIrT4WsXRLiQAqW
 MxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376151; x=1696980951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Vsuy4csP7DLV7i/HttRGs3+j2Bhu0vejsp7G9mGTsU=;
 b=xACo9D8JXsI51B3gRBPgr/C/DU3dmwFLFsDtnRLv3e6JZ5Swy8ZFZaP3RfPgQP7nDi
 rF1cQvAoNCnsQMdDDERLhU0T0aXMCI7g/Zd1DAnYiymHNjhl2+2NTX3tI0/S/GbRf2V4
 XjMWGFEJgTc/hbJV4eu6hGBGAR6u16r80nX39/4fbjreaJT0XgboOfdQQ8WgwGk4meQ8
 twO81AwgDMAtycAnIX/96DmkFqUoA0RcvEJg3Eelh0Y0DDpCZ0/zcaGsaOdTWMD69gKc
 hGdtD/pBdrwFiPH8CNwTnQ9sFqMeRHd5OjQTfBqxRKus057Cdjv1Mi0cjur/15/RMSBf
 rUmw==
X-Gm-Message-State: AOJu0YymOgwb++qCkmLZuFP/GQQms+yyAGl5dIvl6bP/EGnMeywQHf6q
 zYZhYIJxlvcfz5s40Y9cx7zQcra0O7kNC8CT5a6L3A==
X-Google-Smtp-Source: AGHT+IFKM6vGvz5V+n5lUQ8G0tphd58TGHC6BBWwHIJMXox8P1sm8B9mdnB0Bl8PBb1CcY4B3xjyvQ==
X-Received: by 2002:a5e:dd0d:0:b0:786:7100:72de with SMTP id
 t13-20020a5edd0d000000b00786710072demr895824iop.16.1696376151658; 
 Tue, 03 Oct 2023 16:35:51 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:51 -0700 (PDT)
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
Subject: [PULL 49/51] bsd-user: Implement shmctl(2)
Date: Tue,  3 Oct 2023 17:32:13 -0600
Message-ID: <20231003233215.95557-50-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d34;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd34.google.com
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
Message-Id: <20230925182709.4834-22-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 39 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 43 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index c362cc07a30..b82f3eaa253 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -305,4 +305,43 @@ static inline abi_long do_bsd_shmget(abi_long arg1, abi_ulong arg2,
     return get_errno(shmget(arg1, arg2, arg3));
 }
 
+/* shmctl(2) */
+static inline abi_long do_bsd_shmctl(abi_long shmid, abi_long cmd,
+        abi_ulong buff)
+{
+    struct shmid_ds dsarg;
+    abi_long ret = -TARGET_EINVAL;
+
+    cmd &= 0xff;
+
+    switch (cmd) {
+    case IPC_STAT:
+        if (target_to_host_shmid_ds(&dsarg, buff)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(shmctl(shmid, cmd, &dsarg));
+        if (host_to_target_shmid_ds(buff, &dsarg)) {
+            return -TARGET_EFAULT;
+        }
+        break;
+
+    case IPC_SET:
+        if (target_to_host_shmid_ds(&dsarg, buff)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(shmctl(shmid, cmd, &dsarg));
+        break;
+
+    case IPC_RMID:
+        ret = get_errno(shmctl(shmid, cmd, NULL));
+        break;
+
+    default:
+        ret = -TARGET_EINVAL;
+        break;
+    }
+
+    return ret;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 4f67677eb92..0512d41db7c 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -867,6 +867,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmget(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_shmctl: /* shmctl(2) */
+        ret = do_bsd_shmctl(arg1, arg2, arg3);
+        break;
+
         /*
          * Misc
          */
-- 
2.41.0


