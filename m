Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2F179964D
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:37:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfq-00019z-WC; Sat, 09 Sep 2023 00:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfn-00018r-GC
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:34:19 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfZ-0002yw-4x
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:34:18 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso2434542f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234040; x=1694838840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=km+tj6Z7RbqljDckWlqZ0FNouzbIsgoz91K6vZRTtrU=;
 b=P08Eq6n2fuRFX03OxJI43JhrYueh+cbopwwq/hzYZPtr5xKu6y/CadAiOyZMjsPBJU
 6OZILQs7tCTgiAkPeS50rAQccmjGfqQMP2J1WAK9qPmit2Kw26Iaq3Q8DwweYP8ihhy7
 2z7qGQb+DD2sSxAIlh9l4uHHeqp+oZJ9bQIoqLMZ6hCK/pPpyv6691wII5lTq8isK9bu
 ZUKKSkPlWM0FC7SsUOZuy43yJwTLyRZwq3xLaLLqdK9Ces4tIMoOhiDAvj4GCFs8ORDI
 O2QkKU710uISIU5uJ1v4rgBYNxyQN5T0IwrkGaZtmHpJspsmuIo8omTvqtCweVQEMCwz
 Jo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234040; x=1694838840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=km+tj6Z7RbqljDckWlqZ0FNouzbIsgoz91K6vZRTtrU=;
 b=sti5DevMbQ0Wqm7kDWarIZDUXkFxZ9nLuQKIprQc42C5Z3SkK49BygJCbeuquPJ9Na
 ZiculnIn3iUyIbotRaVaeeO5gMl+DhgxSf6GjSmS/OKwKsD+uOGSqwaKp3wa+9j3kV2p
 QgTCRhwpmZXoDibjZ9ropShyF0QHLTEHmotR+zQ3h2iJD6ynbGCInkFysl/2bffZc8u8
 aib7npDlSgEdDNL2cfCKdAXhE/TdcQI56kWEnYJWZppiVAcQVa2gTwziA7VkrGLr8aHk
 9MmB35Y6lBtm961/EI/yjQQj1R1Nqs2pbSDNsHQXeQA1olhTzGaSvSw0jj3svzPUdmx1
 0QUQ==
X-Gm-Message-State: AOJu0Yz0i5nxDIEuV45mLhLAyQPVoxeQ71+KdCR9qAXVRn+fLbUl6gec
 Sxsc0YyrhQQHxa3g76cvj8zqHeO1E1o=
X-Google-Smtp-Source: AGHT+IFz0q3WVo8xVx2Hylr8jZQkNlNOmcFF1vOPbTGn9NnHFQIRf0EoghknCyLeqhFvcITbw6wIeQ==
X-Received: by 2002:adf:e491:0:b0:319:6997:942e with SMTP id
 i17-20020adfe491000000b003196997942emr3370301wrm.8.1694234039738; 
 Fri, 08 Sep 2023 21:33:59 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:59 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 21/23] bsd-user: Implement shmctl(2)
Date: Thu,  7 Sep 2023 09:43:00 +0200
Message-ID: <20230907074302.79234-22-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-mem.h            | 33 +++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 27d4e7f079..dd506b8a15 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -304,4 +304,37 @@ static inline abi_long do_bsd_shmget(abi_long arg1, abi_ulong arg2,
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
+    case IPC_SET:
+        if (target_to_host_shmid_ds(&dsarg, buff)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(shmctl(shmid, cmd, &dsarg));
+        if (host_to_target_shmid_ds(buff, &dsarg)) {
+            return -TARGET_EFAULT;
+        }
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
index 52cca2300f..35f94f51fc 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -555,6 +555,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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
2.42.0


