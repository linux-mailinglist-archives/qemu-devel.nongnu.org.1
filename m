Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEB67ADEAE
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:28:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHQ-0001BP-3p; Mon, 25 Sep 2023 14:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHO-0001Ah-2j
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:25:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHM-0007H0-H3
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:25:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-405e48d8cfdso6905605e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666354; x=1696271154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPIs14X11Sc9cA1eWwig5Uq4t5+72rZFcQQRqTUVNMo=;
 b=aowcC+kE0faKWr4uhl5V/TL7TPP/M2wIcO7XUwYEfT3ARhDnVk663oPKv0ew1GLXv2
 dyfY973F60uV8AOYkcMsKsDUX5ecQYZogVlDHhD5y+Xh0hKZ+YrLhpJypGrJy3wK6OHq
 PJCUm+dm0rOnoA3cVNxdBbHWXxXGsbmbP6kLs0C7Ry4O2lHvPgKMGEgav9Dl2QVs8yL3
 gfUnR9gsnHPFPI5w6ofxh7Cwj6F6/uLNJaLtHuaSwJnzlOwlhc08r11vYS+PJR3VBOQY
 x4zeAcvLKAOB0AWVoFIMym+DLpUIP0K8Q2WYHtkmCJFb7uVpnRzWnb57YQRpDbxslp6c
 +/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666354; x=1696271154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hPIs14X11Sc9cA1eWwig5Uq4t5+72rZFcQQRqTUVNMo=;
 b=JQVUwFBsxp2sl/lymHzszh0fsU2817XXbAmDaXWYP6nfXfywVmqeZfodq1tYSkPryj
 rlAqes1gbDBvbynGRp4LKspfEzo/O3rg12WIYmWk3qUHP4s7Nr+6Wi9LFvJm9n+KHofF
 GlSFItsaeDdQZ7Gg/jhb9S6QOJE+G4Uo4LgPZand8k9jxrAk1iQti9D596Lr9TwceDB5
 /ZtBGMMkTQ3UilL+Hg1scpCnRDMwZ13v9d1fLfK8ehDux8XgG13U4sxgJBamQfYHRKd/
 fsOT9X6jbLp1xnH1/MAGsUyJi5jC2Wr79W8SXBXUPoAdCcWSCgRBKq/IIqTu9EMwEsrh
 /esg==
X-Gm-Message-State: AOJu0YyOA4C2BKwJTAUqSdDtOEMh/4B37XQhTGMMRwD6rwLBSTQCh5q2
 zq2g/XWoGcSdHDQ4b+PRort3Ne2VBBM=
X-Google-Smtp-Source: AGHT+IGfgItIOmJ1GmcEKAc51IZvOYe9j7c2i/enI3ASHpjyheRmKUs79Ni+LXMQJuArMJOXR/K9Gw==
X-Received: by 2002:a05:600c:1c02:b0:405:7400:1e42 with SMTP id
 j2-20020a05600c1c0200b0040574001e42mr5089270wms.41.1695666353997; 
 Mon, 25 Sep 2023 11:25:53 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:25:53 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 02/28] bsd-user: Define procctl(2) related structs
Date: Mon, 25 Sep 2023 21:23:59 +0300
Message-ID: <20230925182425.3163-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
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

Implement procctl flags and related structs:
struct target_procctl_reaper_status
struct target_procctl_reaper_pidinfo
struct target_procctl_reaper_pids
struct target_procctl_reaper_kill

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index ddd38c13e0..a3bc738ff8 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -390,6 +390,48 @@ struct target_freebsd_flock {
 /* user: vfork(2) semantics, clear signals */
 #define TARGET_RFSPAWN (1U << 31)
 
+/*
+ * from sys/procctl.h
+ */
+#define TARGET_PROC_SPROTECT            1
+#define TARGET_PROC_REAP_ACQUIRE        2
+#define TARGET_PROC_REAP_RELEASE        3
+#define TARGET_PROC_REAP_STATUS         4
+#define TARGET_PROC_REAP_GETPIDS        5
+#define TARGET_PROC_REAP_KILL           6
+
+struct target_procctl_reaper_status {
+    uint32_t rs_flags;
+    uint32_t rs_children;
+    uint32_t rs_descendants;
+    uint32_t rs_reaper;
+    uint32_t rs_pid;
+    uint32_t rs_pad0[15];
+};
+
+struct target_procctl_reaper_pidinfo {
+    uint32_t pi_pid;
+    uint32_t pi_subtree;
+    uint32_t pi_flags;
+    uint32_t pi_pad0[15];
+};
+
+struct target_procctl_reaper_pids {
+    uint32_t rp_count;
+    uint32_t rp_pad0[15];
+    abi_ulong rp_pids;
+};
+
+struct target_procctl_reaper_kill {
+    int32_t  rk_sig;
+    uint32_t rk_flags;
+    uint32_t rk_subtree;
+    uint32_t rk_killed;
+    uint32_t rk_fpid;
+    uint32_t rk_pad0[15];
+};
+
+
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.42.0


