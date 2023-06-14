Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E414072F1DB
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FEA-0002Ea-EP; Tue, 13 Jun 2023 21:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FE1-00021I-2Z
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:11 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDt-0004qB-MG
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:59 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6664a9f0b10so91477b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705776; x=1689297776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahV50yAj7Ld2OM9lZb6ayFZpGqFcf63OHt/ogsT/R+s=;
 b=Nzx5sI95e391Zakr+3GWkXSOQQ0rC6QW94NwwquDD/VbdAA/nizjeyQZdN0kEOb1SF
 ylDs2lB0TryT0eBu3bka8cQLo+T6pQQBjli12f7Se2izwpc2k/vue9DnFVb2gdGyoUSP
 8TmHPetN5nQp9M/j+tumJajgH+2w3czKg2ao4xQgJxtyG0UtyKAxHA4D/oQGNm/DezS0
 KBm0jK/SsC3dRLoT6x62fFWBkDdeQmyLSlpJNmadmF0oWg3xAed/Y5mqcMyAuSy/ausI
 39mzsOW6sZ5zfaseMaUKTzlKBtbzNHMbZVrN2jFWFj6jajGdfrNYHHv2z/ngxAv8zEOs
 q72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705776; x=1689297776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahV50yAj7Ld2OM9lZb6ayFZpGqFcf63OHt/ogsT/R+s=;
 b=UJUIifyh65ID80CUphACh1wtxql4AVv+QBi/GktI/P7HxxO2wGebxjlu5l/VMHX3QD
 QtT9tzdSEvWLRW9MYGLaZggZL66ITrW3JRzjUmeTJoC9XWXmUadZq8fxlPwl9uKVQ1/G
 RVCMCwra2d22MmfUCyQc/ZjTaZc/J/5Cp2TNBan5vCmggxyryZJ+WOrH0cEWtr1JoPeP
 cAvFu+++ehX/HKHJiRRzf7cO6xB89jI4u1GBCFVuW6kOc9f6XHO8XOj5IsP9V+LU0/by
 nGzBz7SZpMfF9oAh7zCl2YCPV4pvbgT8EYurmwuRSzZ/0aojwI9aJRcQlNe4DFHsZMOA
 rTnQ==
X-Gm-Message-State: AC+VfDyZfPHCZwCl4whSyuK7v7VNxjknkvcTwJWLsDvd3ZvBZMTvlG6D
 ksx7QfJBbj5UuIG1aVVeyp/C2PRthwOLaw==
X-Google-Smtp-Source: ACHHUZ7dhF7LuZz007ZV5vviqS7QHWpiL4j9FRRhSEqgQzpNIOpmICKMjOHnMbBgL2+F10CYKA/S9w==
X-Received: by 2002:a05:6a00:3981:b0:663:8c28:61d7 with SMTP id
 fi1-20020a056a00398100b006638c2861d7mr476610pfb.32.1686705775963; 
 Tue, 13 Jun 2023 18:22:55 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:55 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 36/60] target/riscv: smstateen knobs
Date: Wed, 14 Jun 2023 11:19:53 +1000
Message-Id: <20230614012017.3100663-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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

From: Mayuresh Chitale <mchitale@ventanamicro.com>

Add knobs to allow users to enable smstateen and also export it via the
ISA extension string.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Weiwei Li<liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230518175058.2772506-4-mchitale@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e67c78f860..d23b4c4d16 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -119,6 +119,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
@@ -1601,8 +1602,8 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
     DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
 
+    DEFINE_PROP_BOOL("smstateen", RISCVCPU, cfg.ext_smstateen, false),
     DEFINE_PROP_BOOL("svadu", RISCVCPU, cfg.ext_svadu, true),
-
     DEFINE_PROP_BOOL("svinval", RISCVCPU, cfg.ext_svinval, false),
     DEFINE_PROP_BOOL("svnapot", RISCVCPU, cfg.ext_svnapot, false),
     DEFINE_PROP_BOOL("svpbmt", RISCVCPU, cfg.ext_svpbmt, false),
-- 
2.40.1


