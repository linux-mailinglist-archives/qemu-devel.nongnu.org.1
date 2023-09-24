Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A47A57ACE4B
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:39:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbT0-0003Yy-KT; Sun, 24 Sep 2023 22:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSw-0003Vf-HN
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSv-00007R-0N
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:54 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-404314388ceso60771565e9.2
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609411; x=1696214211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhivGYb84XE/TlLEmop+Tew1vEbaCLi2YOrvGhy8DCw=;
 b=DTc/8nxN6cFQf6Z8b25P25wbH/xgbZlyqPa97vUgRMTcrjtZ15ZAPmxjNgmmFTLsSk
 gJq7N2GnTE9nfy6ikJuiRUD4kMk6erhviI+u38ghU8tU/4A8YqeKQm/w4FKMeIFOnzMK
 iCN8tc1rOnyem06oK/bZHwjokjMAhwvpjujmg9XKnoAiVrRYWvvOd3tEt1QIl8TsF4ID
 1SrrylRh/Rt2xvxwzpHPgyD1Lw6qFdumMifjilVIDrqn2zmLJMloX8axl0Hs9g2nElSC
 1+7RxhHm/R2v9OCQoVupkynbg7zwmwVGChgGgD6/m1Duwu9Izjl7jNqJOuWDzgO+iLc/
 P6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609411; x=1696214211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhivGYb84XE/TlLEmop+Tew1vEbaCLi2YOrvGhy8DCw=;
 b=UEFhmh+RSMn5osWEW6492GYaCCrX+c9UfZuEWWXHzLs04E/hLBtMnBaBX7clioEaAy
 hAjD2dWi82zeDF0g8MD22RDY2Kwv+Y3YhuZz8U6Ffk3CzQYzubtO9snN6ysWYf1HlilB
 ndf/EpZbeygdbSLW+yE3p765B/MTdwdJoh1XmwIm0ExYp7TmCkE1zsKleMjn4/a5jiYY
 RPYio2pEsjZsRLLdrDD6rJ/lEBCVSrHencqfb3EtJn6ReMRLP4OF6lSPFrNv+hRPcNCk
 +11COqEqw+XumbOv/A+P5ZicyFVWVwGEpOJAbZi6NupK1OCFelMwbchg5NIhZrkEBJzO
 07vQ==
X-Gm-Message-State: AOJu0Ywry7FRPWe2j8eMz7VsmiapBKqZynirbgT08qJYGtlbQpO2UoWG
 PR1c3Hf57EV5YItH6VR70sFEHf40rNI=
X-Google-Smtp-Source: AGHT+IG1MqMDYN3DAuKPH9SZU3IkrPm+hA0BRB+xC0oWlkS7lnxpUvv8G930MYTpTTTwQYBTRpfefw==
X-Received: by 2002:adf:ed82:0:b0:31a:ed75:75e9 with SMTP id
 c2-20020adfed82000000b0031aed7575e9mr5905924wro.13.1695609410878; 
 Sun, 24 Sep 2023 19:36:50 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:50 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 17/28] bsd-user: Add stubs for profil(2), ktrace(2),
 utrace(2) and ptrace(2).
Date: Mon, 25 Sep 2023 00:01:25 +0300
Message-ID: <20230924210136.11966-18-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32b.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.h           | 28 ++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index a5f301c72f..2c1a9ae22f 100644
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
index 7b51f4f16e..1a760b1380 100644
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
2.42.0


