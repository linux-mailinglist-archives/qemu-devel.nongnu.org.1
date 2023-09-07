Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E6A79963F
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfC-0000y2-Ht; Sat, 09 Sep 2023 00:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepf9-0000xP-Gx
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepf7-0002v9-Ar
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401d2e11dacso24610105e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234015; x=1694838815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJTRK8Tm4oCBWcEts58SyC6/NTwYSAeOzRKwQE1l8qs=;
 b=GKkKDcIsYzOUR4w8nnRN+waNbJ4+wy55gvzWfJyf0mwAA55TKrbPKb2kP+3lPIvQwr
 Y60pTneZ/+1l948eWE34h15qhlBTS9l4A7GRWd1fs1vh8ZZ4U5PpNecE6nNJNwu1eJNt
 ph0d4YF+NwIzlIwyfoFph253nOpkgOR5WNDdnB+MMOBmQKWDpDV7glFXaha00/b4nemB
 roW7tVeUEkv/q32ignYuzEQ88aI+oXfZaUndcxWfP+TpYbjdXhO+/4s8yGK0p5McudZ4
 Z41Rnu3D3sz+2WqA8aG/rJGux7+OAmvimQOmqhKA4ZaP+2HZdgF37K2GVlapOSo8cGBg
 o9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234015; x=1694838815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJTRK8Tm4oCBWcEts58SyC6/NTwYSAeOzRKwQE1l8qs=;
 b=Ox3ecU85ykdJis/9NMlOTQmfxw4X8qnBEUXb6gjxiTIZhBgQGqFsb9+H30sRQVlQmK
 MNJPkKh+KFSPx7n+mq4SnrVGJUj7udV6IzdjaRENwY6oYLO9Jd7vKn9uspPWLyr4R8n+
 hVcDZZIpUwYkuLKSEj/UaAqnx+CYkLRANddAOlTajpt462KI0tsR5J2Sz317q6hH0BTJ
 /EF+mxXsL9XCoesYzpaKjg9Jsg10/d0JtBAu7rM/P3Gm0bQTFKPCipRKRiHfaRb2MXSh
 VBtNsW82paNVZmqVZxjX2aJJ98adhnrkeoMmaogF1RuxF6QEfRVVm1X2KRTA/J5PkPWk
 JiuA==
X-Gm-Message-State: AOJu0YwY9LjG+Va0BG5aTu47dEzbD4wMIXuj7T0guVidgO1XJP6Kecbt
 y+XgV/9Avgmuo6aJzRmS6lktgA81d1s=
X-Google-Smtp-Source: AGHT+IEZfLO4se87DVRkbAjQuAQtuMSHgJwMznfdsQthsu5cDNUOP9oPIrmLgpbjdAyjHy22ZNCklQ==
X-Received: by 2002:a05:600c:20d1:b0:3ff:516b:5c4c with SMTP id
 y17-20020a05600c20d100b003ff516b5c4cmr2695993wmm.18.1694234015025; 
 Fri, 08 Sep 2023 21:33:35 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:34 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 01/23] bsd-user: Implement struct target_ipc_perm
Date: Thu,  7 Sep 2023 09:42:40 +0200
Message-ID: <20230907074302.79234-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index e4825f2662..39a9bc8ed7 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -55,6 +55,23 @@ struct target_iovec {
     abi_long iov_len;   /* Number of bytes */
 };
 
+/*
+ * sys/ipc.h
+ */
+struct target_ipc_perm {
+    uint32_t    cuid;       /* creator user id */
+    uint32_t    cgid;       /* creator group id */
+    uint32_t    uid;        /* user id */
+    uint32_t    gid;        /* group id */
+    uint16_t    mode;       /* r/w permission */
+    uint16_t    seq;        /* sequence # */
+    abi_long    key;        /* user specified msg/sem/shm key */
+};
+
+#define TARGET_IPC_RMID 0   /* remove identifier */
+#define TARGET_IPC_SET  1   /* set options */
+#define TARGET_IPC_STAT 2   /* get options */
+
 /*
  *  sys/mman.h
  */
-- 
2.42.0


