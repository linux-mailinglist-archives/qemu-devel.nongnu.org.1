Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 470C88292EA
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 05:03:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNPnP-0003xr-Tc; Tue, 09 Jan 2024 23:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rNPnJ-0003wQ-8q
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 23:02:21 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rNPnF-0007wV-Ld
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 23:02:20 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5ce99e1d807so274473a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 20:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704859334; x=1705464134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pZf1hyWR1m2tNHwFIBBr/aCRqXfcHRnMqh91SNDt++A=;
 b=I0sO+jJ/Av/MMTufWhMhNDmpcYtiu3LxLxRLnd/b5nHSJDchScL4S1pTxvyQc945FK
 nWJE31PnDqm89i04dme78xf6Vgz/UxN8klk/j7OMYJ0gGzQYW3cJjmqzJviWJR8DLO39
 nzGh5c6Kj+4Kt8b81j1wG1waVkEOY/wxT8mPcSTqLjHNwIGhpZM6u79Bh36g+xCLzvhi
 KmFUNU95J9rUBSjrafdzZOl/1peAwBKMJ/L8I2KOhtk6xRbLiz24UXxnRmeMhRpBeT8J
 4yciyu6gcFkf88RTIbmXg8z4SGD33N095jFY5RKf/m6I9iMmp39dI5wg4kUCoJmqMMFJ
 B86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704859334; x=1705464134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZf1hyWR1m2tNHwFIBBr/aCRqXfcHRnMqh91SNDt++A=;
 b=m31cEZ5Lk6te3HvyEBvGDAqrkFd+Pyo4sKVx/o4yg0OAfpxUmUWe7yUo/LtRFj8vhU
 RXh44w3Yj2N73SWBdSgyv5HFJRqz8D2uwwxACB6LzyD6iJItb4IlLUuBg66XcbpifpW/
 +uNxMrUAIqRnP5WZQMt9f4FdQO7lO/gxJflphZTergdv0tiEt4RD5hDiI9GeOJTiLwIt
 OkigZa5Ly38N8dlZ9ODSaWZnu/H/wQFjjHxWG2WAFJTm1a3wL3vdXfE3oIovwu6PwA/1
 X32GiWiuu2Xm7Bi9kTQ5d/7UQb0lZVs+oJRFmgZA5pqpxbZ5dU+eUg69CKPjC69sWQzK
 pbdA==
X-Gm-Message-State: AOJu0YyGA9qzheBrY3Z93BUhW4DxT1AHufR9r+mW2ZJV25GaSGVjbwoG
 /ga1SPJTl5mpkcP6T8+mXfOKq4YqrOjPyJeuCvUYQg9Haq8=
X-Google-Smtp-Source: AGHT+IGrTUQRxIWWr6AHH+0g6yp9b7ByJaIhbB27xF9gDUZZ+sLhBBM/awSGe4DAwapRDV2dCeBDKQ==
X-Received: by 2002:a05:6a20:3d8b:b0:199:dad4:d821 with SMTP id
 s11-20020a056a203d8b00b00199dad4d821mr811963pzi.1.1704859333653; 
 Tue, 09 Jan 2024 20:02:13 -0800 (PST)
Received: from brahaspati.localdomain ([152.58.210.84])
 by smtp.gmail.com with ESMTPSA id
 ca8-20020a17090af30800b0028cf4cb2c85sm313893pjb.40.2024.01.09.20.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 20:02:13 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/riscv: Raise an exception when sdtrig is turned off
Date: Wed, 10 Jan 2024 09:32:03 +0530
Message-Id: <20240110040203.1920924-3-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110040203.1920924-1-hchauhan@ventanamicro.com>
References: <20240110040203.1920924-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When sdtrig is turned off by "sdtrig=false" option, raise
and illegal instruction exception on any read/write to
sdtrig CSRs.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 target/riscv/csr.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c50a33397c..b9ca016ef2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3854,6 +3854,10 @@ static RISCVException write_pmpaddr(CPURISCVState *env, int csrno,
 static RISCVException read_tselect(CPURISCVState *env, int csrno,
                                    target_ulong *val)
 {
+    if (!riscv_cpu_cfg(env)->ext_sdtrig) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
     *val = tselect_csr_read(env);
     return RISCV_EXCP_NONE;
 }
@@ -3861,6 +3865,10 @@ static RISCVException read_tselect(CPURISCVState *env, int csrno,
 static RISCVException write_tselect(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
+    if (!riscv_cpu_cfg(env)->ext_sdtrig) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
     tselect_csr_write(env, val);
     return RISCV_EXCP_NONE;
 }
@@ -3868,6 +3876,10 @@ static RISCVException write_tselect(CPURISCVState *env, int csrno,
 static RISCVException read_tdata(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
+    if (!riscv_cpu_cfg(env)->ext_sdtrig) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
     /* return 0 in tdata1 to end the trigger enumeration */
     if (env->trigger_cur >= RV_MAX_TRIGGERS && csrno == CSR_TDATA1) {
         *val = 0;
@@ -3885,6 +3897,10 @@ static RISCVException read_tdata(CPURISCVState *env, int csrno,
 static RISCVException write_tdata(CPURISCVState *env, int csrno,
                                   target_ulong val)
 {
+    if (!riscv_cpu_cfg(env)->ext_sdtrig) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
     if (!tdata_available(env, csrno - CSR_TDATA1)) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
@@ -3896,6 +3912,10 @@ static RISCVException write_tdata(CPURISCVState *env, int csrno,
 static RISCVException read_tinfo(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
+    if (!riscv_cpu_cfg(env)->ext_sdtrig) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
     *val = tinfo_csr_read(env);
     return RISCV_EXCP_NONE;
 }
-- 
2.34.1


