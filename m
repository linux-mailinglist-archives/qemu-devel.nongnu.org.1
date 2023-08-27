Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C972278B92E
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiYW-00084Q-Ew; Mon, 28 Aug 2023 16:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYU-00084I-VA
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:46 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYS-0007Ke-Qn
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:46 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so4780541a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253383; x=1693858183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFNgHRhY13yJagY0ZOeRM3jCRo6vXgEQlGw8Bpoa4tg=;
 b=d9I3ClXVkBbT9zoJ/GspOYLvTozatz0OOWwFZ/o4WnkDTaZWHqo3ESs2XE4jkce7Lg
 MzpAL/iqycClSvLMrEyL9Xpux5ztqECvPk5Qg3Je5OuJtofs9M/MGiNlsl9W55fHbInw
 YW3tt3qsrR/BMqu6+Dm6z61v8F8CtNCQJjyoRIrWW+nUSNAMaDlKfkuZN3B9VU10z/Eh
 j4lzT1wVyQx2ecUimPM+mOTz+rEsozTCnJkzmxImxAObRu3/3/Okuh8a3rHbe5RbZR35
 6hkx/+lDB2/kv3zINKP6P6+y1ludv0UUOgflxhb/EC44Xs/WanjX1lWNE4RJLP+N4c39
 UWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253383; x=1693858183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFNgHRhY13yJagY0ZOeRM3jCRo6vXgEQlGw8Bpoa4tg=;
 b=IDluuW3FM7uxTrhfad8c5bmPj9nHoq/J2AIGw89+d7izXsP/nQkJ/iVx5YFgiN9TFK
 2+DHnrf+G5Bj/xVmoMX68hx6nItyCUJdlhhyNQbDW4uqVFo8x5DoN5U3ZxRNb2s66Kau
 +CIxks+CVRtb2G2nTrYxH6Qv6gz0XHwSGmqnyCaLlU/LV6SS3ykTVSSY4aL8KkGlTW0f
 entjwvIhKBWqeZzPeTg97tVeuxNcQroX4leJxujIG9B+84z6NvXAZQJ9HBBV/2c+zXgI
 laBrtnHH9I8Wj9T2qzyTWU9nRpO9t7kzXOXzgIK1j812xq7QII6S6E68Z2OelSO3idXE
 QVPg==
X-Gm-Message-State: AOJu0YxbRWZ0J6jZSa0NmWNrFyTaPpFWvHccT2OYSYIPmSaIOeuz5yHg
 YrhJMtdA7oGSb5KeNiLqv6bTvlXspC3kdQ==
X-Google-Smtp-Source: AGHT+IFYJBISP2tuD6rfeRXdnhlfTJ4u/TdgQgJ0Fqovb7M2IdAgofwZ6S7EaAKmdnavb6hTc9njzw==
X-Received: by 2002:a17:906:30da:b0:9a1:2a25:197e with SMTP id
 b26-20020a17090630da00b009a12a25197emr20191674ejb.50.1693253382852; 
 Mon, 28 Aug 2023 13:09:42 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:09:42 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 02/32] bsd-user: Implement procctl(2) system call.
Date: Sun, 27 Aug 2023 17:57:16 +0200
Message-Id: <20230827155746.84781-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ed1-x52a.google.com
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

Implement procctl flags and related structs:
struct target_procctl_reaper_status
struct target_procctl_reaper_pidinfo
struct target_procctl_reaper_pids
struct target_procctl_reaper_kill

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/syscall_defs.h | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index daf7f5637e..25b3d304ca 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -183,6 +183,48 @@ struct target_freebsd__wrusage {
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
2.40.0


