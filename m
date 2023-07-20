Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 128BA75AFAD
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTe4-0006E8-7o; Thu, 20 Jul 2023 09:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMTe0-0006Ay-He
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:24:36 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMTdz-0003b6-4c
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:24:36 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-56344354e2cso561153eaf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689859474; x=1690464274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Xzqzvlq/fczPOvED6oSPV8obPxnbl+y0QN9GyZTXPQ=;
 b=TWI8+hdxJOFa1hmJgUiBL0uxFrnsq0JcEZnjhUxUSL3nhHxmoE7fqjDcp6Wcrv7fAz
 7d5m2JSaHbyAU4km4HaTlMdHQvtDHDQh/6iwxgzv/ZCGSKYe2/X2EhxmDQoHpnNVkR4w
 nJIWojE8nHPgdx5EauRQDshwsl/W9d+qKnDIKMBB7B8X4yiKbvP8QsM51ptil1IUQhIp
 8FJ0XUpeGpPizvPdNQIZxSkM6wU/Pc3ZF5gCnZqEn+cNeuU4XhP2JrADlTkVlzYvnkvA
 mkM99hBSfh8MxWiZEPOgVGo8TWZFLvcYZJCyfLAQisSjyKQheZ0ldafG9MwzZeYoLHsU
 sm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689859474; x=1690464274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Xzqzvlq/fczPOvED6oSPV8obPxnbl+y0QN9GyZTXPQ=;
 b=iHAmWkcTByFGp3fyUofMGEAXzzNNj8ol6DxreeYhGRzioe28cgfrgsfLHdEtdszi7I
 7+cyefs+FmXNqITYvLkNhnFOicKTapVXzDT3pvC8m9VSk2bI4BoycjTm4WdGfsd6CtEf
 ca0iLOXVRyKxaueDNxFjeNYN52fSz5WDy6Xq9by7lundJ2sKtjQonfo5N3VpAdBGT7t2
 KPcGuA+Zz4zKKXDBm0yLj0n6gyxzo00numzI9+dGG4gLpsjk/rL/X/nHhJPU7P53q5/3
 PtxCO/gWw3M/ybw4h5o/J/GddEsMjD5lwmfiIOnvBIG4sMBtv9h12EztIOzm70UtmO50
 IJoA==
X-Gm-Message-State: ABy/qLbtseqYo8d4ugLSpXkfnVjcKnqFoR85py0PWp1mNN5QC+PiWRsi
 IIFd2b2tkkqm5nqq5UlFPUxaA9ng6aId3QkYQMVTDw==
X-Google-Smtp-Source: APBJJlEo3Z4Us2V7ZmA7oC9+4bsMzz0x2pxJUEi2jTy/noTKM0D7Xy7IIWRKjZtOeeeyasca5kRfNw==
X-Received: by 2002:a4a:5802:0:b0:566:ebc2:cb5b with SMTP id
 f2-20020a4a5802000000b00566ebc2cb5bmr2506983oob.0.1689859473870; 
 Thu, 20 Jul 2023 06:24:33 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 p186-20020a4a48c3000000b0054f85f67f31sm421361ooa.46.2023.07.20.06.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 06:24:33 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/2] target/riscv/cpu.c: add zmmul isa string
Date: Thu, 20 Jul 2023 10:24:23 -0300
Message-ID: <20230720132424.371132-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720132424.371132-1-dbarboza@ventanamicro.com>
References: <20230720132424.371132-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

zmmul was promoted from experimental to ratified in commit 6d00ffad4e95.
Add a riscv,isa string for it.

Fixes: 6d00ffad4e95 ("target/riscv: move zmmul out of the experimental properties")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9339c0241d..d64ac07558 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -88,6 +88,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
+    ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
     ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
-- 
2.41.0


