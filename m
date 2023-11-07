Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A83E7E32F5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:32:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bsw-0008Ou-PK; Mon, 06 Nov 2023 21:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsu-0008CC-5T
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:08 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bss-00030C-DA
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:07 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc0e78ec92so33997355ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324325; x=1699929125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=moMPe6uUc9QOmEofZamDrb55KXQKMNIwTqkJuqeWprg=;
 b=UL4S9kCiIsyci8622grLwaB4hKma7GGq8BVeeRNFAQXu8yCvaUP2iUIVavXqC3cJzT
 c1itUeORiW7BnNKh/AL5qVLAOydS9eTjjCyhNOrYUN5ygH1/4SkbwP8GHXj0JM7UTYqb
 qomPEjJLaeJdwJyuHNS9fGPguxl3Xe4CxEp/fHmqTf+Lm31Acasnwah9jjJHYxbonSZs
 onDvTLSNXzRMfMpjgpIKSsvW700PlVg/Pn2r13CKeiwZwLI/zRdY+XyX56Pt50GNQLrE
 5bKKkCUvj6G1y1HRDtXe68J/ADO2pGnGNS4NG/If2208w3urd2m+s79o6fpbGTU5XQ1U
 xO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324325; x=1699929125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=moMPe6uUc9QOmEofZamDrb55KXQKMNIwTqkJuqeWprg=;
 b=CWd60YQX7c/Nk+AgsRxo6HrK1Ti8apXhQsliUghk/5JaWLcVniP6eCM5ofY8sW1TWA
 HTDcHayTPFpY7tpfKZ3K9GlW1kqxUgLEpfix5FQCC/NDweSxKQjeT/pg4IBgynBTSvz5
 2pRtk2AfEb2Jo9OXe6WvCdiEACB5EDW20fmaTC4vj4DJr6A9ZWSV7AHqYtUSTnuswMsN
 tgm3GzIGY1hKHwBTx/TK8/5k8k6WBE4PaSc+U2FeoBiy5RupHG89HliAU99oU36dCOGE
 lhODrBSoJ1DPhQB726wZIhQ1kNcMiKMDvvXHXKlCiFqk8LI81p1G2LTyuuwz6IwdI4Ef
 xOFw==
X-Gm-Message-State: AOJu0YxPrbikHYjRdtDQVHdwOGJRb+qZkUzQaBJdRV5NriE/dSfqPQOG
 EMz4xGB0TsaVO3NKBLS6r1zW/EXgQRQrCA==
X-Google-Smtp-Source: AGHT+IF7GyBA1NRBkgf19ZxRzOryFTORXVdF0GOSmeojZgZmyEpFi9ZJXK6ac1svdL04ia0gVMbBCA==
X-Received: by 2002:a17:902:db0f:b0:1cc:5ef7:e3dd with SMTP id
 m15-20020a170902db0f00b001cc5ef7e3ddmr20391988plx.47.1699324324732; 
 Mon, 06 Nov 2023 18:32:04 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:03 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 37/49] target/riscv: Expose Zvks[c|g] extnesion properties
Date: Tue,  7 Nov 2023 12:29:33 +1000
Message-ID: <20231107022946.1055027-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

Expose the properties of ShangMi Algorithm Suite related extensions
(Zvks, Zvksc, Zvksg).

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231026151828.754279-10-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 208faffbbf..f61ed7cf60 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -135,7 +135,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkng, PRIV_VERSION_1_12_0, ext_zvkng),
     ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
     ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
+    ISA_EXT_DATA_ENTRY(zvks, PRIV_VERSION_1_12_0, ext_zvks),
+    ISA_EXT_DATA_ENTRY(zvksc, PRIV_VERSION_1_12_0, ext_zvksc),
     ISA_EXT_DATA_ENTRY(zvksed, PRIV_VERSION_1_12_0, ext_zvksed),
+    ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
     ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
@@ -1400,6 +1403,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-zvkn", ext_zvkn, false),
     MULTI_EXT_CFG_BOOL("x-zvknc", ext_zvknc, false),
     MULTI_EXT_CFG_BOOL("x-zvkng", ext_zvkng, false),
+    MULTI_EXT_CFG_BOOL("x-zvks", ext_zvks, false),
+    MULTI_EXT_CFG_BOOL("x-zvksc", ext_zvksc, false),
+    MULTI_EXT_CFG_BOOL("x-zvksg", ext_zvksg, false),
 
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.41.0


