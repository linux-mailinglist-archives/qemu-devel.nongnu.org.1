Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F98D7E330E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:34:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bsc-0005ni-9c; Mon, 06 Nov 2023 21:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsZ-0005bQ-H5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:47 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsT-0002uP-RY
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:47 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28023eadc70so4296510a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324300; x=1699929100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NGrUfNZLzWmNH09Z5GuoFNdhcJQ/OgpnjZLsButO4A=;
 b=nN/ZrwLJApr9+l7BiVVVqkfSVK6lY4ZyynRDM4gP6rTlK3Ee6MQEGhRHaAGPwIcjx7
 FYg/7VglraCLXlIHrDtrAEs2V0AMivT6MRCC61Rs1tqaQEE1GfzOQwJQBcUejF2NZw7x
 cdvSwLaBmy1Ta0Tj/RXDfu2hlP+Nwy5D+IMC93YhFgVxotHaKPHoJrBqildwYpySUMr4
 XjupuQpVzTB734374hRcnNOZ0LSimq9IgGENtePCLE0uutpo8kWXzU7+0aT8HzicFoj8
 +8ZAO7iR9iKhmPlFpkNp74OeUaoebR+LojHroLsX02spVjoNx8eV8oHzCRGXSY/iJEXX
 pNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324300; x=1699929100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NGrUfNZLzWmNH09Z5GuoFNdhcJQ/OgpnjZLsButO4A=;
 b=E6xmfHGYT+rkHNhcWYwfNd3dOhFku202Eh418I16WlJsT787z7NBGV0GbcMR4uFOCa
 SHTxP/TKKN0TAo+rd+5GJ2kniEYBAN5u8jSJbNgVwcDGSanmVOnAiTPO8A8Iwo/Iqqv2
 R0XNlVHD/pjxW6hsh39Li8B9Kpbqd6NOElEafc1NwMSiDiWrVoQoXzUws95Qa4RaEtEo
 bLCmm1knSDuJkUuvBRahCVd4su3YD0E9YozZYoru9zSjZXTahZZqnHNigSXw5vgcxrWS
 UxuHX15SebCY/qcC/WWs00bymDZbagbbQ/ADhBMW+geHOAgKl6yH+aScOfjxyBe6DcWJ
 NusA==
X-Gm-Message-State: AOJu0YyPYC5zS3Cyzq69roN2TF36jiITZL9F5+8dl8wiXtmV/Sj0+peE
 e1ZR6dAevr7jz08vCgNcNIIaTWhlX/Wzmg==
X-Google-Smtp-Source: AGHT+IFfvN30fqpCGK3Gr0JuHYuSxqPqP6Ok44EMExsqzfdHHh7qs4aKWFaVtp6gfn/bAV1B0MYvtg==
X-Received: by 2002:a17:90a:fd01:b0:27f:ebfa:1112 with SMTP id
 cv1-20020a17090afd0100b0027febfa1112mr25045844pjb.5.1699324299726; 
 Mon, 06 Nov 2023 18:31:39 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:38 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 30/49] target/riscv: Expose Zvkt extension property
Date: Tue,  7 Nov 2023 12:29:26 +1000
Message-ID: <20231107022946.1055027-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231026151828.754279-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f40da4c661..9604ba6171 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -133,6 +133,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
     ISA_EXT_DATA_ENTRY(zvksed, PRIV_VERSION_1_12_0, ext_zvksed),
     ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
+    ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
@@ -1390,6 +1391,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-zvknhb", ext_zvknhb, false),
     MULTI_EXT_CFG_BOOL("x-zvksed", ext_zvksed, false),
     MULTI_EXT_CFG_BOOL("x-zvksh", ext_zvksh, false),
+    MULTI_EXT_CFG_BOOL("x-zvkt", ext_zvkt, false),
 
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.41.0


