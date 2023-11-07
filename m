Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F158E7E3309
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:34:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bsi-0006Sk-Hy; Mon, 06 Nov 2023 21:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsf-0006Ce-L4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:53 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsd-0002wU-Vb
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:53 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5b980391d70so3925110a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324310; x=1699929110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9HqSNXSuFKooYGNBtkzh7Uy0+DXv9/0XEuy91CKkiDg=;
 b=GRNqdH6xl+oWnd2S+GvRmVt+FjXBuLjC69vJjh1r1Gdlk3WFkj4wtxOCaO0xDJtOhD
 +2Go7+nZLvWnzC6PAw+I+Z3aDODGxXmsp7xhEeCfdR/Y7Z97dJz+rQC5JicmxKF5AxKS
 ehYzjkvFDDyzPD5u3v2lsVpbXHOsYaGvgEb7BBGSCy0jAaNfHbeFNpiG8XhQ1MgCw9Y2
 uqzYnPwFux/G3ABZKx8P1WrKhb+RT/X6210SmpE9IrXn0ZxxUL2M9tjKyvsSkEP/NmS8
 pM3U3+a6WSoa1WrEwEjHgFcjALexbri/P989v9bLG06GmVEsiO/romgqEmRW02C1dY+x
 OSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324310; x=1699929110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9HqSNXSuFKooYGNBtkzh7Uy0+DXv9/0XEuy91CKkiDg=;
 b=gPe+kYHXyUfTmsXFzzFqdfmhsunS4FF5IR2y9UrgasIPC1k6tRmEHaSAa9EjHQP1CU
 ppWXq5aMage2WC5wSohczxp1Ff48+ATuRaryRxXdIzy/kD7lEEKP3wQSplFj+Uu1Dgyi
 OymikeL9BkWuT1KDxRKATAbcushW/dfJ5KBDq7auY5nvwz+81cJQNu2ZyBmLAe4g4gvY
 G434NPeAOiEQ6oq99emmlfpU7/INlb70c4boQsDUfale35n2qefVY2FyPAv0NVQDTAXE
 JPie4EZqQJkTlhHGHqSMhLfbWuubEsmfpKYFdBSAf5wjWCctWDFe3g6ALgXdGdFyCPxM
 vsvg==
X-Gm-Message-State: AOJu0YxFjl0EFejzNrRi04RjNSn6R9lDy6d2k+ghw74+ptXQEsIsJfSh
 v2EMaRQwaTYLh+esFRy32EacdaWpYYHIsQ==
X-Google-Smtp-Source: AGHT+IGQZGJnYB3fkeq4QTHMHMgZpLYfLNwYPFyGrOIQ6GcjiPjSMj4f6jAzNVW3jkI0Wh5BCCMFDw==
X-Received: by 2002:a05:6a20:7da5:b0:181:3649:2a31 with SMTP id
 v37-20020a056a207da500b0018136492a31mr20849600pzj.33.1699324310340; 
 Mon, 06 Nov 2023 18:31:50 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:49 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 33/49] target/riscv: Expose Zvkb extension property
Date: Tue,  7 Nov 2023 12:29:29 +1000
Message-ID: <20231107022946.1055027-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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
Message-ID: <20231026151828.754279-6-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9604ba6171..3eedf8b7ce 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -127,6 +127,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
     ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
     ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
@@ -1385,6 +1386,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     /* Vector cryptography extensions */
     MULTI_EXT_CFG_BOOL("x-zvbb", ext_zvbb, false),
     MULTI_EXT_CFG_BOOL("x-zvbc", ext_zvbc, false),
+    MULTI_EXT_CFG_BOOL("x-zvkb", ext_zvkg, false),
     MULTI_EXT_CFG_BOOL("x-zvkg", ext_zvkg, false),
     MULTI_EXT_CFG_BOOL("x-zvkned", ext_zvkned, false),
     MULTI_EXT_CFG_BOOL("x-zvknha", ext_zvknha, false),
-- 
2.41.0


