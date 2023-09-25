Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 088F87ADE9E
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:26:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHY-0001GL-HE; Mon, 25 Sep 2023 14:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHV-0001F5-9B
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHT-0007Hz-HB
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:04 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4056ce55e7eso37816055e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666361; x=1696271161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWYm7HyQrlRuQgYVJcs9dh5OBv161buo5dw6WbXP5iU=;
 b=bAVPsRk3hvfTGx+BFFVDgJYA1WsIjlxOXhyh8w0j3K0lBRn6T4psuqladH3iYGAgpr
 qDxFDzg+p42IRM1M/r8rd5gFirLN1BVDM6+//EQ+0qZ5bV5qJY45G7vvEX1CyVLsyx8p
 WRF6vNt31tVIA8VFY+XOHz0gPMh5JzOOeR51VJ+ay0JKEtGBujHe2+8bt5/j5xQXgGG6
 dR5jzCv6wdNJjRBYiHX7PRvZwfyEhPcgrK7c5qH0WcHu0REcCXu5Tl4PaANlvPdwhfnv
 XOfMAH9Rnp3RDxaLcuEdkHDh0BqDLIVe2Hcxd5kQ/CJJMVm89TASjYk6vqrzExCyOXy6
 sHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666361; x=1696271161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWYm7HyQrlRuQgYVJcs9dh5OBv161buo5dw6WbXP5iU=;
 b=dM9qCSVs7t+Uq0B2/xPYCbmCQ0O4djmP5m1Xhm5rwFKxqal18LIGD3WlUmT/3CdKQe
 UY9f+EAEvvH3iCOnfq4GQ94IdTFlyqZ8ghW/HrT1L6A5OuDcU6nHk5Pv+r3beYGMsXHl
 bxCx1gV90zYePt2s7N47IUvfYfNdHlrEfLFhJl9fBihyL13brYuVjkt4akNDHdWWibns
 sNnX2mzVSP4ghrpxjV2AegHLqhw9nYnmCHXKtaJ9yhfdbMTU/SAzNS4ugCYc0iQAcNBD
 RIb7PQpDAzz7t36yYyGut/hK+DNRdR+PcvR7dS+ilCAgJcI/C0TzceFisOzTnAilcGlU
 9hFQ==
X-Gm-Message-State: AOJu0YyS6JIoYTKek/0AtfJ8wTNBAwVOUsVmrpiwiUURBDekKilBFMBc
 tYqhch4j2J21AKy7w6dqibrwTA4k9yg=
X-Google-Smtp-Source: AGHT+IEE5GCtQvEyrJPaLKUMI1CdTSmHy4u4jm4w/1FGHXCrnXg15gDsHoJBsjGrs1BxwRSiAlMTxA==
X-Received: by 2002:a7b:ce11:0:b0:3fe:1af6:6542 with SMTP id
 m17-20020a7bce11000000b003fe1af66542mr6630746wmc.33.1695666361282; 
 Mon, 25 Sep 2023 11:26:01 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:00 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 08/28] bsd-user: Implement host_to_target_rusage and
 host_to_target_wrusage.
Date: Mon, 25 Sep 2023 21:24:05 +0300
Message-ID: <20230925182425.3163-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
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


