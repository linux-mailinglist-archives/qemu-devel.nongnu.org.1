Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F687A3DF5
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUN-0004S9-Pb; Sun, 17 Sep 2023 17:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUL-0004RT-8R
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUJ-0004Eb-ER
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-401f68602a8so42727085e9.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986770; x=1695591570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUP8g2y0GYSaHwIi9+PE/D/jagxt1ep3Rybvm1zGJcc=;
 b=DQhqIskI6oYTMtyQqRJXvvUvZVQk75JLuAlv3r9uvxgpDING0rP390iZllgnDH8BgX
 jrEnAbB+TO6IMZlGrEUC87kBOtLMe5/kGK3uCHK/w8VNxoeRczgN9T/hr2L+OgT7UeVl
 svN9MdpqMX6E0dVPX0b5E05a5KfEzvfvPra8mcNZY36nmTnDU9fvLhoWO9LwF8suVUS8
 SOTVHOLSBZTU3VjZIWPx7EDVeNzk0iz7qTQWclomV+zrWITnO9JSIC+XlC7iiUw1Q0dV
 fDfGefzmhfZDqFymSr7CM7iuZ93Ij7Kfns2N365V/4YGHkyNNsLfrixeHCpbYEZuy8Bv
 s0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986770; x=1695591570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rUP8g2y0GYSaHwIi9+PE/D/jagxt1ep3Rybvm1zGJcc=;
 b=MGpUe409zxlzoJ4tC1weRnU0TI5moIP6WrZA6pp2UoFTYsBYamCZJ0Yrd0pOq2hjM0
 ajU9YTmffhG8c5sQuHd4FEKCKLJvDTqUX1Tc8u429JWbnRzwLWTRyJCCGnfzRvRAIexT
 AKn1WsqagVM6Bl5XuRolgM3w9LRWqErLVxoLnkk5yfaTDWm4E3D0ubOxN2at5tb0r2NY
 EBj6WlTzaCH/0zNBR2czJDJVNDiEK/KeB+ak5MfQxU5hPGpNopvgKuy9bQKmMgzlofcv
 XRB4lCiBLmEZbVbin/M0Z3alHIVK8uPVbJ5smmsk0KPZvjzlF/HH/ufzYHq96K+M3BMX
 DYhw==
X-Gm-Message-State: AOJu0YynH6m0mfs8cWcK0fQCjot+8/oUSncZDtX6cTt4gZZwY9/CR4kD
 Gy57zEn4jvvXOzeWs1mxdFIoBnE1fsA=
X-Google-Smtp-Source: AGHT+IEu6+H1TV9SN2OO0w5uFO6jrj2x/ArxAIdBmUyeed0Y69p2DshPjvvMXkFjzTkSWF1muPf8PQ==
X-Received: by 2002:a05:600c:2057:b0:3fe:d1b9:7ea9 with SMTP id
 p23-20020a05600c205700b003fed1b97ea9mr6743705wmg.36.1694986769709; 
 Sun, 17 Sep 2023 14:39:29 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:29 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 02/28] bsd-user: Define procctl(2) related structs
Date: Mon, 18 Sep 2023 00:37:37 +0300
Message-ID: <20230917213803.20683-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x335.google.com
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


