Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8B27A3E87
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:27:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bd-0006SY-5p; Sun, 17 Sep 2023 18:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0BZ-0006Rr-IW
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:13 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0BX-0002tZ-EL
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:13 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31ff2ce9d4cso2441546f8f.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989450; x=1695594250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUP8g2y0GYSaHwIi9+PE/D/jagxt1ep3Rybvm1zGJcc=;
 b=UhQYn8SMBpPcZ2QTHAL83B929cI+sM8WJt/6HATziETv0Ls8du/TUrP1mVGFidJv4C
 ZWXV/WxrHl3hlSGAN2z+uNyZzgdWk1eHHKphNvIEtCk8CJX220NCAkxwEBiZsz+IIw+Z
 RyPEbaGCVxvmFmmXWi2cGRtruuCuRK6f+vJFV0+dUaZZz0YJF++fKbGEDBeiEzkc5Sys
 YjRnkma1KKNwV1rKxq/uEsyaOXC35PjFItPdIH2Z+fBQDmbg0sxk3P/cQgBuKrNwoMsA
 61IxSNREAkzdfG7nu39mD17hsYBD/BEn9vl+lkG0+KVKu2rG72Fr9jN2qye+cQ+rHCtX
 33jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989450; x=1695594250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rUP8g2y0GYSaHwIi9+PE/D/jagxt1ep3Rybvm1zGJcc=;
 b=JbxQwMc3USUxRxhG5FB+VuaYJY32ovpkNt9Z/d4oTEsHfxfq9/opiKg/AcFhDrhQXG
 AjIsRtLs3kJ+6vGjiaG8K25QHiLC018os26YHMa0YgIBVs/3AzdDUrsA35FSHJD/Y0xp
 niaQN0wIsnHn1AwsQvblKVXm/pKXq3nxzRD9oI/Sk3XtrZPtHiqK78yP9DqGXRoZ5bPN
 QnM5VLCMJB5ZpP8fUXfjH0PwKd90P5rrcW4V56kRAFsj/pWPT2SMUMhiFdzCXlhtBTgv
 mo75SJjbAoeU05oCBHM6aVIKb2EYrHjtCHz+vhuMOudyNF7Y5XUa0haCfoK3WwZA5iHJ
 IS9w==
X-Gm-Message-State: AOJu0YyqrhDe/0+38MmZBBDdbj6rUpOqwt8pkJ7KG6O8gQbcP15O7Yy9
 0VgBZ2BYKmfElUnMzv+Nj4Hao0R9i1o=
X-Google-Smtp-Source: AGHT+IEWyt+Y2elFGMsoLkSd/tKdJJ/S750XQH+UNpGzwH4hnR3N3KPS7rmn2sO2iVyEaMXW1EXcOQ==
X-Received: by 2002:adf:9dcc:0:b0:31f:fb02:4dcd with SMTP id
 q12-20020adf9dcc000000b0031ffb024dcdmr4157230wre.4.1694989449642; 
 Sun, 17 Sep 2023 15:24:09 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:09 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 02/28] bsd-user: Define procctl(2) related structs
Date: Mon, 18 Sep 2023 01:22:19 +0300
Message-ID: <20230917222246.1921-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
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


