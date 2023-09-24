Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 549B27ACE34
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:37:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbT9-0003fg-Rn; Sun, 24 Sep 2023 22:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT6-0003f2-VK
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:04 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT5-00009w-AQ
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:04 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31ff985e292so5152651f8f.1
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609422; x=1696214222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hAKBN+FJFhjMRdTpRlb02p0v4uScFILIgAl2mVAC1ik=;
 b=UCx5rpgqvGpl7Dv/Inc9PVtDpe5A6Wkg80mQub6mouBPtzSnW3PCmBiGeAcbqQ3CG8
 NkZIydbXdBEzJgGJ+5DFVO7Fom7RHmBLJv/CKhFBHzW9/wiZxvehbK9X+Jj/KS7i6RG8
 ZSfQICX/UaqUffSS7b7aSBO74dSe5RltkUu3d9be6OwafNl341N27C2Cywl2+4E3yAxj
 iN6NjJNnmXxor7kjwvgZ174ZOAT9CV6rE9fLlo5B7DSStfzAJMznDwk2SKSgzH15M6vU
 Ldb2X/XmqcAZhJdJSOSvtibh2JhWnfmXhoZOv4wYVaFWKWv0BbkCyE4l2oeh9DWa9oyC
 cH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609422; x=1696214222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hAKBN+FJFhjMRdTpRlb02p0v4uScFILIgAl2mVAC1ik=;
 b=T/ES1w6MnjfWqLPDoQCKvS9KysUTA6IJC7ngwQB4WEvLuHxtbFPBK0icVNPOmalaxW
 WmJPTZqBvz+L9I7ZrAHc3aktI87OG93lRgGtQMlsggm4pT7Zuzx0T9wrPSl1Lr3Yd1ay
 uKXyRx+EmHSXgs3q+fAXV4rNcfjsq+YLhlRKNihvrPtL+lQRlJTfZvrhoS5z0fG4Anim
 8o+lulOkz4SuWaP6iOgfPeeNE/ptGL45JoOHa/7QyInuV7UdS3xsPC6CiNVhSTmlgXr2
 xXhIkFzs6lB0auRIP1LF3sFdwKHoDmCGE0TxXnOOD/Ad1ObVltvjLMYux5Bo+MYOMZJx
 NF7Q==
X-Gm-Message-State: AOJu0YwoXZTQ/dI4UkcGvxhohtLOoyQAtbKwNb1kLB4huR9mq5zHy31C
 CB9QzHWHV7nEMQVPI63N5CMIaNJDqkY=
X-Google-Smtp-Source: AGHT+IFxQOQggnmeqnj4xbJO8I4lG+/GcvaODYAcfvDwFG+m+E7IhU6vwoy3P1yatVgoMk5NVpzo/Q==
X-Received: by 2002:a05:6000:10e:b0:311:1dba:ca65 with SMTP id
 o14-20020a056000010e00b003111dbaca65mr4875930wrx.51.1695609421685; 
 Sun, 24 Sep 2023 19:37:01 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:37:01 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 25/28] bsd-user: Implement pdgetpid(2) and the undocumented
 setugid.
Date: Mon, 25 Sep 2023 00:01:33 +0300
Message-ID: <20230924210136.11966-26-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-proc.h    | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 2eaba141dc..42bdd61904 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -34,6 +34,8 @@ pid_t safe_wait4(pid_t wpid, int *status, int options, struct rusage *rusage);
 pid_t safe_wait6(idtype_t idtype, id_t id, int *status, int options,
     struct __wrusage *wrusage, siginfo_t *infop);
 
+extern int __setugid(int flag);
+
 /* execve(2) */
 static inline abi_long do_freebsd_execve(abi_ulong path_or_fd, abi_ulong argp,
         abi_ulong envp)
@@ -162,4 +164,25 @@ static inline abi_long do_freebsd_getloginclass(abi_ulong arg1, abi_ulong arg2)
     return ret;
 }
 
+/* pdgetpid(2) */
+static inline abi_long do_freebsd_pdgetpid(abi_long fd, abi_ulong target_pidp)
+{
+    abi_long ret;
+    pid_t pid;
+
+    ret = get_errno(pdgetpid(fd, &pid));
+    if (!is_error(ret)) {
+        if (put_user_u32(pid, target_pidp)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+/* undocumented __setugid */
+static inline abi_long do_freebsd___setugid(abi_long arg1)
+{
+    return -TARGET_ENOSYS;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index d614409e69..99af0f6b15 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -383,6 +383,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_getloginclass(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_pdgetpid: /* pdgetpid(2) */
+        ret = do_freebsd_pdgetpid(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR___setugid: /* undocumented */
+        ret = do_freebsd___setugid(arg1);
+        break;
+
     case TARGET_FREEBSD_NR_utrace: /* utrace(2) */
         ret = do_bsd_utrace(arg1, arg2);
         break;
-- 
2.42.0


