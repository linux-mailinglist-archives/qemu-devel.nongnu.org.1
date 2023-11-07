Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C47E3302
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:33:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bsz-0000Sg-Si; Mon, 06 Nov 2023 21:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsx-0000CJ-N8
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:11 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsw-00030q-0H
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:11 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc1e1e74beso47122765ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324328; x=1699929128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1KIEByJmDKMfSuQuHab7Q3UDm70XcCikhm4aHWpV8+c=;
 b=Z6m8+lGFrfkRurGluywafEWEQYnOntK1XI/r5pYSXxB8yB8gyt9m3pITl2aUOKVY07
 RYQRCr2lD/gbOzXdo4oH5bl9PJjRM2Tcl5OlCVen9A8bbMiKAjd19jZMwv0XRGfZ24MV
 a021/70f4RXnugo35HQKDxRM2bltHcVzMXOEMlRqMxyqeWW0rcYydTKKW/cH+3eQONfB
 93ldo6030x4PY3meg7OPhy/DkDlak/BijdKLlH+975omlKlWEDPFTtf+9CMhTKWqOO0k
 C7lrUZC5utM2KwFE1CbOq209AoNcKDtzQKK0kJnlzyURYWRWB3VVcL4jHsCqsvcDo/FI
 oyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324328; x=1699929128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1KIEByJmDKMfSuQuHab7Q3UDm70XcCikhm4aHWpV8+c=;
 b=ZR6qMvsrn5Fl7IVFPnwdI8GGVXQ9qJnoKiNxcCWgkTdxuFlF6aDBBU/XiaeZtmgbfe
 fVFMM8jN8v9XYLxSXoXjKvjiBAz1JSLFHkAqTor226LmDoygMgB3Y1ziWFM5Kma8VgN8
 sGFqWy2htBHl1C8GtVLD9nUkXqEs5WcgxthE4S3AOSNq7T4XWwY/y1d2kmW7yB16On9A
 uIkjPriUxzS+/vNLum22CY64A4pA00hDf3syE6NDhHKUECjjjPf5J517xH4wss45vbWR
 m7l/rHt23ntIWRxkOij10o746KL4L1FtERkQp0rRM4Bd35JjRC2s8WESrnBy63mu0Bq5
 8qJg==
X-Gm-Message-State: AOJu0YxKz1U+/p/06bcW+aoc7tUMZIXHl5aEWz0CsQJ92zqg8pn7ev+d
 w2a7INU/+21Vo1eatbONZiN5QnuQLxmJLw==
X-Google-Smtp-Source: AGHT+IEWqy0LV9zsz6C73DMgci2fmmbAQXi7Dsx0t4sXimdV08GeA3CM2g82GDZRa4jqwHWAeaIc3Q==
X-Received: by 2002:a17:902:ccca:b0:1c5:ce3c:c399 with SMTP id
 z10-20020a170902ccca00b001c5ce3cc399mr40052496ple.39.1699324328344; 
 Mon, 06 Nov 2023 18:32:08 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:07 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 38/49] target/riscv: Move vector crypto extensions to
 riscv_cpu_extensions
Date: Tue,  7 Nov 2023 12:29:34 +1000
Message-ID: <20231107022946.1055027-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

Because the vector crypto specification is ratified, so move theses
extensions from riscv_cpu_experimental_exts to riscv_cpu_extensions.

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231026151828.754279-11-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f61ed7cf60..d73e1da2a2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1357,6 +1357,24 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
     MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
 
+    /* Vector cryptography extensions */
+    MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
+    MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
+    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkg, false),
+    MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
+    MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
+    MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
+    MULTI_EXT_CFG_BOOL("zvknhb", ext_zvknhb, false),
+    MULTI_EXT_CFG_BOOL("zvksed", ext_zvksed, false),
+    MULTI_EXT_CFG_BOOL("zvksh", ext_zvksh, false),
+    MULTI_EXT_CFG_BOOL("zvkt", ext_zvkt, false),
+    MULTI_EXT_CFG_BOOL("zvkn", ext_zvkn, false),
+    MULTI_EXT_CFG_BOOL("zvknc", ext_zvknc, false),
+    MULTI_EXT_CFG_BOOL("zvkng", ext_zvkng, false),
+    MULTI_EXT_CFG_BOOL("zvks", ext_zvks, false),
+    MULTI_EXT_CFG_BOOL("zvksc", ext_zvksc, false),
+    MULTI_EXT_CFG_BOOL("zvksg", ext_zvksg, false),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1389,24 +1407,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-zvfbfmin", ext_zvfbfmin, false),
     MULTI_EXT_CFG_BOOL("x-zvfbfwma", ext_zvfbfwma, false),
 
-    /* Vector cryptography extensions */
-    MULTI_EXT_CFG_BOOL("x-zvbb", ext_zvbb, false),
-    MULTI_EXT_CFG_BOOL("x-zvbc", ext_zvbc, false),
-    MULTI_EXT_CFG_BOOL("x-zvkb", ext_zvkg, false),
-    MULTI_EXT_CFG_BOOL("x-zvkg", ext_zvkg, false),
-    MULTI_EXT_CFG_BOOL("x-zvkned", ext_zvkned, false),
-    MULTI_EXT_CFG_BOOL("x-zvknha", ext_zvknha, false),
-    MULTI_EXT_CFG_BOOL("x-zvknhb", ext_zvknhb, false),
-    MULTI_EXT_CFG_BOOL("x-zvksed", ext_zvksed, false),
-    MULTI_EXT_CFG_BOOL("x-zvksh", ext_zvksh, false),
-    MULTI_EXT_CFG_BOOL("x-zvkt", ext_zvkt, false),
-    MULTI_EXT_CFG_BOOL("x-zvkn", ext_zvkn, false),
-    MULTI_EXT_CFG_BOOL("x-zvknc", ext_zvknc, false),
-    MULTI_EXT_CFG_BOOL("x-zvkng", ext_zvkng, false),
-    MULTI_EXT_CFG_BOOL("x-zvks", ext_zvks, false),
-    MULTI_EXT_CFG_BOOL("x-zvksc", ext_zvksc, false),
-    MULTI_EXT_CFG_BOOL("x-zvksg", ext_zvksg, false),
-
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


