Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E17708751
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 19:52:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzhmj-0002oA-JG; Thu, 18 May 2023 13:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1pzhmh-0002kk-8m
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:51:27 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1pzhmd-0001il-OK
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:51:26 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-195ee1be41aso1743451fac.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684432282; x=1687024282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ry93EuiL339cXmTcSwW+O/TAemEHyYi1HmGB8rjIeQg=;
 b=CwZBPU9aEPdq8QhrQx1I57TUAK/Yb/uXITlDuXFTsRRUHJ8/r9DiRSodwnS7qgvcvp
 TqT9jP5u1vcqKon0B62+7NRtIw+LtJ5WFxcZHnO+J410JrLeoRzJ0/QfdiEWT1rXJBOQ
 i4ehtfjkc1mlklVteXuSyUY8dhNEvHEqQUDnicgT9zqjkQD8i4VFa2403IHWkAjUsL29
 KwRE+b7oJVAdZ+RDPENd0Pxyy6ZzeS0Bnr49tyDVzGB66kLnnd0HB1lZYp+08zoetQ1v
 h3qR5bEQ5sGI6X2uN483reGYFd2KgANzl72tBr6iKtelyGGIQ2TFbl+nRJfNBRX4Pl8e
 u9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684432282; x=1687024282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ry93EuiL339cXmTcSwW+O/TAemEHyYi1HmGB8rjIeQg=;
 b=KWLjo816XK9f7iXgNBDI2Fl8JKqTV+Ltzh2RJqK2u/j1U1VgBh0tEy+n6O/BNIhtQe
 HYnK+GmEuH5kveLj8jyf1L4QYjN8IFQx8UCooe9iaSSWTGth2QL6upgeoGhhfMZ7b1g/
 EuRAZNCWTUDBiiBMbXO/tHSATUoTslayJgx3ICQr20ghQTiXrZAXpq59uHzWPNasQ9eZ
 PvuU+c0FUN9pHknyKb6M+6GvcZw2rlwtXeyxeSeZxQQNLHB8P0Msct+aHFBhButWZiL5
 2lefgoqy+e+eAou/XXL4HOph6fca5vP8QctUhBXpv2LzxoxTKXFbLSwfJrlBjQqzdvj1
 jD/Q==
X-Gm-Message-State: AC+VfDyhtcmyMcj61M/0gkddRr8rnII1TepGtVmZtPHjK3XkaC9CTtgE
 +OyurumlFyTkPrWQWgwOxE/uiX/XO4D7IAMMu3432A==
X-Google-Smtp-Source: ACHHUZ6xG0nQIzmibottF0PzhokVUvePgPhBpqOQlDbcmRHaocQry1JfKNMwyEiYAuj8UXVLkRSOSQ==
X-Received: by 2002:a05:6870:3884:b0:18b:15cd:9b45 with SMTP id
 y4-20020a056870388400b0018b15cd9b45mr908685oan.40.1684432282359; 
 Thu, 18 May 2023 10:51:22 -0700 (PDT)
Received: from mchitale-vm.. ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 t13-20020a05683014cd00b006ab22bb324asm890832otq.10.2023.05.18.10.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 10:51:22 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	alistair.francis@wdc.com
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Barboza <dbarboza@ventanamicro.com>, liweiwei@iscas.ac.cn,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 3/3] target/riscv: smstateen knobs
Date: Thu, 18 May 2023 23:20:58 +0530
Message-Id: <20230518175058.2772506-4-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518175058.2772506-1-mchitale@ventanamicro.com>
References: <20230518175058.2772506-1-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=mchitale@ventanamicro.com; helo=mail-oa1-x2c.google.com
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

Add knobs to allow users to enable smstateen and also export it via the
ISA extension string.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Weiwei Li<liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index befa64528f..9420cd670e 100644
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
@@ -1498,8 +1499,8 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
     DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
 
+    DEFINE_PROP_BOOL("smstateen", RISCVCPU, cfg.ext_smstateen, false),
     DEFINE_PROP_BOOL("svadu", RISCVCPU, cfg.ext_svadu, true),
-
     DEFINE_PROP_BOOL("svinval", RISCVCPU, cfg.ext_svinval, false),
     DEFINE_PROP_BOOL("svnapot", RISCVCPU, cfg.ext_svnapot, false),
     DEFINE_PROP_BOOL("svpbmt", RISCVCPU, cfg.ext_svpbmt, false),
-- 
2.34.1


