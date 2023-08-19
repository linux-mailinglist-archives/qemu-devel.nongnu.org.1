Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DF67818A3
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:50:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIab-0001R6-61; Sat, 19 Aug 2023 05:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIaY-00017i-Fr
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:46 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIaW-0004V4-8C
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31771bb4869so1527174f8f.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438583; x=1693043383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8exV3yGEz7WY1shJuX9lY3GrexPeAxEd4BeLNUOtn40=;
 b=COXuRg2J/O0vzsu4Z02XurXcnBGPID3XEw1524yyMPAWNZ/I1HBOPZ+TVHZc3phsb8
 +LRzxIwHIY7UIXYHp/wXx4/RER7yMqR+SPTBbwb77HqgSzpWa2SLatjWhscAD/no7+IX
 wKw8oZ1TbgYQiDkbqkWxlNGdZrNLDfjNSKLzA42cRZjVSHw3Yf/k6NiottHKeRqmmWrg
 oN8ab+8dca1VJjXUVFIu5kOiL1P5+p0BUnujG8Jx3YW2jtTFoUmr1gTeP0ifec7Dmcj3
 L3Icf2I7+xXrnL7qyce5F/a19ZIsCll1OFnmU114G6VXY1v6vYh5JkJ1F366qTbZV2ED
 62IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438583; x=1693043383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8exV3yGEz7WY1shJuX9lY3GrexPeAxEd4BeLNUOtn40=;
 b=IhLfDmidEI1lqyZVotVuBS+aVPsk45IdJ2xhclZ+9lLcOt6DiH++W6OIPnlj7b0OuE
 OEV2iI5Hu3MSUx+Mnt4SiiVlTkc/2xwFYne8P5ZH3XLrmyAKxXjAK0Lv0TaXwaD3jnlY
 /hsjvhs0QfP+7ep7WEffjjK/mfmuwo07rG9ENNvpbcpuUOPzqyivjEGFNimldV0IbJA0
 J8yJNqTxNtQrzsuIiGVzwPKTzrRwNRYy95fqZdOTte2s1ZzokZ3AuMIJeDW6j1yYg0Yk
 2KUL69pF+KXBnVwiGI1TKj/seElyQ25LhpORshDpdwPjPya9h1fEv+lbTaB21KASdxkl
 IGbQ==
X-Gm-Message-State: AOJu0YyE+Vjs34HMzWt8ssQZu5ueBUvzeqR+v+AyXT/iVQkvSx0DiBLd
 PGROe0dHcPKj00a/PCVXAJ1BFRRBuZs=
X-Google-Smtp-Source: AGHT+IFboCsi42EbFDMZvtnrwzMzMMTEY3JU9GoaF1K2rz11RnVWzDQMY0vguvA+wnLtqsB+RyTbgA==
X-Received: by 2002:a05:6000:889:b0:31a:d6cb:7f9e with SMTP id
 cs9-20020a056000088900b0031ad6cb7f9emr1178952wrb.21.1692438582670; 
 Sat, 19 Aug 2023 02:49:42 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:49:42 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 20/22] Implement shmctl(2)
Date: Sat, 19 Aug 2023 11:48:04 +0200
Message-Id: <20230819094806.14965-21-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x433.google.com
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
---
 bsd-user/bsd-mem.h            | 33 +++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 3d91d3eb30..221ad76d8c 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -302,4 +302,37 @@ static inline abi_long do_bsd_shmget(abi_long arg1, abi_ulong arg2,
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
index a7db78b9b4..9681c65ce9 100644
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
2.40.0


