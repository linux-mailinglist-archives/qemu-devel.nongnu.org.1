Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CAC7ACE4A
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:39:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSp-0003II-9z; Sun, 24 Sep 2023 22:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSk-0003Ha-K3
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:42 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSj-00005Q-15
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:42 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so5263457f8f.0
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609399; x=1696214199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWYm7HyQrlRuQgYVJcs9dh5OBv161buo5dw6WbXP5iU=;
 b=TNOSMUnPX2/Lew+84gijP9A1gbt6+J4BKJwOkaSaXs1qo5D05Cqmapdqv0D2kvlWk/
 3F48dkAw2JscTEvsNZe64c1mDc2d8fIo/E5vOGQWdTCmOepC6ppySGCOH0YXln/VEIMu
 5wLJCOoJ/dRX7VTr92EIEdj6AdDE7I91NljBmsLx+ZNOMj/IlMc2jdZsB1eZFAGZii+I
 KtW/5FxQve6jna3qlYHScGn5KI75mfRIrL+qorbCT+R4LCSuRIX+6YEx8GadCCcrmcA3
 27NdhlerqOasWYWQwXYjWKR990AAzpCnFAgxr/yrAu0VTvzQzmyZQOxBPeOwAqsSwArY
 vgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609399; x=1696214199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWYm7HyQrlRuQgYVJcs9dh5OBv161buo5dw6WbXP5iU=;
 b=pAMCv4/d8yzmCSXnduEunnLl8zXlR+ZBEegdLkMksB1HHnYZL2oaeM9/DYmq9PASRS
 1uMyU7IWpibrxJ/ojo0msnC/vVpcPAdQIMUtjRytL32sKrtieR0Rya4E5RS5urS2x/v/
 biKFVF+PPbW/hndSJqs2fYPUnxvTrVIC09hNzkrKy5qyz2eRgvLtV6QpuyG+zCiqyxfw
 EkWSqv7Wonw9w+S0SaXSJdEsq/q+6frd0sR+GsGP2Y2EdxQkBBff1Zz6EHv3gAKpcdc3
 6CCCW6Zs1I/aXAWbFsAzFprE5TsW8xUnopCpHb2u3pWuAh4rh5aZbbN8oU6o0so9hels
 qMkg==
X-Gm-Message-State: AOJu0Yzjl7KfqlZddUGD/gkdMihaWpjJRoUsWFPxCGT6O87bledWBrYx
 uwV7BnREEedcGcau1T/VUGNARlKSz+Q=
X-Google-Smtp-Source: AGHT+IEW/EO0g7gNHODR8ZJlE/kTTljDZhdYV01RelHOGdGYJR4OQGHzvnxXO2/T1Rbkc6hGZ820iw==
X-Received: by 2002:a5d:5582:0:b0:31f:ffd1:6cf4 with SMTP id
 i2-20020a5d5582000000b0031fffd16cf4mr4985118wrv.12.1695609399151; 
 Sun, 24 Sep 2023 19:36:39 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:38 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 08/28] bsd-user: Implement host_to_target_rusage and
 host_to_target_wrusage.
Date: Mon, 25 Sep 2023 00:01:16 +0300
Message-ID: <20230924210136.11966-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42c.google.com
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
 bsd-user/bsd-proc.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 19e39a2f76..aa386ff482 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -48,3 +48,57 @@ abi_llong host_to_target_rlim(rlim_t rlim)
     return tswap64(rlim);
 }
 
+void h2g_rusage(const struct rusage *rusage,
+                struct target_freebsd_rusage *target_rusage)
+{
+    __put_user(rusage->ru_utime.tv_sec, &target_rusage->ru_utime.tv_sec);
+    __put_user(rusage->ru_utime.tv_usec, &target_rusage->ru_utime.tv_usec);
+
+    __put_user(rusage->ru_stime.tv_sec, &target_rusage->ru_stime.tv_sec);
+    __put_user(rusage->ru_stime.tv_usec, &target_rusage->ru_stime.tv_usec);
+
+    __put_user(rusage->ru_maxrss, &target_rusage->ru_maxrss);
+    __put_user(rusage->ru_idrss, &target_rusage->ru_idrss);
+    __put_user(rusage->ru_idrss, &target_rusage->ru_idrss);
+    __put_user(rusage->ru_isrss, &target_rusage->ru_isrss);
+    __put_user(rusage->ru_minflt, &target_rusage->ru_minflt);
+    __put_user(rusage->ru_majflt, &target_rusage->ru_majflt);
+    __put_user(rusage->ru_nswap, &target_rusage->ru_nswap);
+    __put_user(rusage->ru_inblock, &target_rusage->ru_inblock);
+    __put_user(rusage->ru_oublock, &target_rusage->ru_oublock);
+    __put_user(rusage->ru_msgsnd, &target_rusage->ru_msgsnd);
+    __put_user(rusage->ru_msgrcv, &target_rusage->ru_msgrcv);
+    __put_user(rusage->ru_nsignals, &target_rusage->ru_nsignals);
+    __put_user(rusage->ru_nvcsw, &target_rusage->ru_nvcsw);
+    __put_user(rusage->ru_nivcsw, &target_rusage->ru_nivcsw);
+}
+
+abi_long host_to_target_rusage(abi_ulong target_addr,
+        const struct rusage *rusage)
+{
+    struct target_freebsd_rusage *target_rusage;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_rusage, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    h2g_rusage(rusage, target_rusage);
+    unlock_user_struct(target_rusage, target_addr, 1);
+
+    return 0;
+}
+
+abi_long host_to_target_wrusage(abi_ulong target_addr,
+                                const struct __wrusage *wrusage)
+{
+    struct target_freebsd__wrusage *target_wrusage;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_wrusage, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    h2g_rusage(&wrusage->wru_self, &target_wrusage->wru_self);
+    h2g_rusage(&wrusage->wru_children, &target_wrusage->wru_children);
+    unlock_user_struct(target_wrusage, target_addr, 1);
+
+    return 0;
+}
+
-- 
2.42.0


