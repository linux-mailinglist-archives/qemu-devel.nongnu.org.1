Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D2B75AFAB
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:26:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTe5-0006Et-Pt; Thu, 20 Jul 2023 09:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMTe4-0006Ei-KW
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:24:40 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMTe2-0003bX-Ea
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:24:40 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5675add2980so540830eaf.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689859477; x=1690464277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KiRcrMQAwWhLmjgR2GJRyi/vgtuVczWcDY/DGH8KrK0=;
 b=fFfvvnAaEzd6KltBTEEmLOOpcfrDQdSXBJtAIPEccl5r/WJaGQLzyZNhRUSky03VA5
 A8iTvmqJDx1uhNdVs+cwmAFP5S2OQNU0qibY9sTxIH6jhEbBg4pi8e60i+2yR98zltjW
 9Wz0RT+KoOlt2+DMaPjvsqYCJdPO7VUbRpVBQcjsjhpYlPHZeZfQQGb1pPxvhwIXpYy4
 qntKt/2meO5TfbC8wAFKPqzIrawhMe+Br9C0OXqfe/a9q6P/g8JH+xxC9Qtc24yr9ESp
 1yDY3V8BlUZM4qReqZ6M8HXY9aDK09k6YhMe6Grva9vOytpIu9JKQY7Oh8PULTJier4w
 /hPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689859477; x=1690464277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KiRcrMQAwWhLmjgR2GJRyi/vgtuVczWcDY/DGH8KrK0=;
 b=QNeZN2ZgKM7unDZUmEXUuCqxDUFpSo7Zo0UK3scvNzuB8sqa+YwoE6wgyYLvQQroqw
 cXf0ZictHbfFFr5gPozUQxiewDMv2WXhmO0/uj54bQ738pkntTskbueNFndCkTpfhlRi
 zD0vRpPmV/YW1YsUtKKfY5ibt130rd5zViZbqLYDzq6d1m8wquBtt0zt9V76L/B0TDbB
 yQ2IptNrgT9SBr8hkPbfXT25RS6WQ3Qj1iY45UBjykmwG0XXkyTeOuwRs4gATwE8NwRJ
 MuVDqRaU+4bcAd6/k9h0viWjT3Vty57qQm9qD+O+F146wN2Ou4Y0M8+70sfUFzDN6kua
 uF9A==
X-Gm-Message-State: ABy/qLbaE0CtG0QXA4hFTLVeAHld2EMxtOWBUuo4h54nN7esxrflDBeH
 hsGg4OkvtPHDKJuRL76tigCfTN6g3P1xyKcKv9e+Xg==
X-Google-Smtp-Source: APBJJlGcNJfP9ENSul8FrSLDLiMWsZMNTIXe1SoeFeoyfytwKMKcEgs2h3Dr6qAN3si9csaJa3z/5A==
X-Received: by 2002:a4a:49c7:0:b0:565:9e41:85d8 with SMTP id
 z190-20020a4a49c7000000b005659e4185d8mr2265099ooa.6.1689859477000; 
 Thu, 20 Jul 2023 06:24:37 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 p186-20020a4a48c3000000b0054f85f67f31sm421361ooa.46.2023.07.20.06.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 06:24:36 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/2] target/riscv/cpu.c: add smepmp isa string
Date: Thu, 20 Jul 2023 10:24:24 -0300
Message-ID: <20230720132424.371132-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720132424.371132-1-dbarboza@ventanamicro.com>
References: <20230720132424.371132-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2e.google.com
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

The cpu->cfg.epmp extension is still experimental, but it already has a
'smepmp' riscv,isa string. Add it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d64ac07558..8c9acadd3b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -130,6 +130,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, epmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
-- 
2.41.0


