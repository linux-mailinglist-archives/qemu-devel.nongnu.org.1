Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF207ACE44
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSh-0003EI-4j; Sun, 24 Sep 2023 22:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSc-00038u-FE
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:34 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSa-0008UV-Fn
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:34 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso4920267f8f.0
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609390; x=1696214190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPIs14X11Sc9cA1eWwig5Uq4t5+72rZFcQQRqTUVNMo=;
 b=E98GeXw1jeJub2B5V8zNjk5LanTMDBIspDIF2uBxSsBuI6OdjtRZ6iXfNaeGHMhiO/
 CrM4VaO00ETs7fs9BTmL0hM6CxbIAiJJATgcC72seda/tNHcxItsC1PVoPHfBj+NHrUC
 AtX01el7VpRnhU2BoA6PzyJOSdH1n3QmDZRXFfHnroRFzlPhKdhcaJN/GxWnA52yoeKF
 uAbBgVq5K8A+seL3XI/BOFcYNU8V4S8VIwUEjRMwXJiIdAh0FTp/HI4obqZBLD+elh8c
 Xtv2yQJ6/ZE7K3BBGfrnDLWI9pXyLdl3C8O7NOP88dMdJyDjM2s83S1e0TSXfSSlUVRp
 wJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609390; x=1696214190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hPIs14X11Sc9cA1eWwig5Uq4t5+72rZFcQQRqTUVNMo=;
 b=quW5iDqc/Ma9NLpBd7krZ5r2LjkUibhfXOTcEZh122vOnRClah1uy8AHjp3ieBZ1kD
 Qzg0HjPBQcVbURFQp9ypOjmAj8CKaXDP4vNSdKiKRSbIbnDMwO+b8jyy5EJ19uMRaUeq
 12P6FlrwdLWYKxDXSTL0nNRGPc/aXN6TJA/p+7yiRgPR/fViFdYKAi51QtQjkMAJbCK4
 WwihP/KnPfRg5+Po5SN3tXkdO5a1bYlFit7b7Bws9wQMA4vCtfzQmY5XBl4v4Vq3dePA
 Oz8OrVhUB3VrQjuJjvj5PmKiPo1os1L0LDQBwFAcNWGf/0sDPb0vjVFFMtdtwnk4+1ot
 pf9Q==
X-Gm-Message-State: AOJu0YyZ8VR3G7QgcJf2wJAsQYSehrEcRYwpZzkOieg+JkBWSWKJVLsV
 GVVeyfNWYS7XKOp9ZIxMBjzue+w32uQ=
X-Google-Smtp-Source: AGHT+IE8eXZYhm389TAWRzFX7FK2Fra5VRxlQJ3e29TGg6ITrml27tHc01oWtND6spZeGSMPpGBQYQ==
X-Received: by 2002:a05:6000:1c7:b0:31f:bdfd:5d30 with SMTP id
 t7-20020a05600001c700b0031fbdfd5d30mr5594157wrx.57.1695609390634; 
 Sun, 24 Sep 2023 19:36:30 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:30 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 02/28] bsd-user: Define procctl(2) related structs
Date: Mon, 25 Sep 2023 00:01:10 +0300
Message-ID: <20230924210136.11966-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x432.google.com
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


