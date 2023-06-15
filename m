Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9C773139C
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 11:22:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9jBC-0003H9-8h; Thu, 15 Jun 2023 05:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9jBA-0003GC-0B
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 05:22:08 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9jB8-0002dQ-Ib
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 05:22:07 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-38e04d1b2b4so4663778b6e.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 02:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686820925; x=1689412925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WEHITo7+8H3wYsbs6qFg2VqKn3O3Hw3sbjYP6T0WrgQ=;
 b=FMXDHuaDf9ckZsgDeuaGbfVMvQN52RVCONTiqsT0eC5MuXS2UbkFG74aft0afjcs0e
 M85sjiyK1JaHVidoSeTw+jlxMmQkfArv3B9ppTsBwPC8Tng5FmtsEukACCR7L0B1GwWG
 bvimXUT/S6LfG0VONxl99+xr8SgPayfgAGXBGWzA8nQXMwrQhmpbfdbZ3+ZHXjv6Q0D8
 MZzApIdH66UHs25MWipVZIBud6uZWo/vDBooXAHc5jE7mYyoG+CCFhaZFGty+P9UnLPR
 KaEzAmegzcRBCea5s4LUH6OAaa6uK6+qf7L/AULsqdTPqjf35C6tVb+ueWQWKkE8KdgB
 PURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686820925; x=1689412925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WEHITo7+8H3wYsbs6qFg2VqKn3O3Hw3sbjYP6T0WrgQ=;
 b=lIfh02yiYLreRcKLEBdqn1jYPJIcFCiy8u2Z0ORTfNZDw3NuQMVslDR9qdYqI3rzw6
 JbYh+iCLIkIHtTrPkE9WU+gl46wz3prooEekQeEumoyrutYDSuIUR+l9ONjo5K99i4zx
 4TnKrGwisVkUPtgq1kS2DU1IXwy4HDmScInJuRS16gKEHcPXp3IHPbbruMx62Pz/szeU
 yC/HtofQYpbsdS56ePl+1FiFTUDFrSUXbR5BlSwNKQVwsye8g7wtj6/HFOYGzWU8xIPy
 O1Z9cCloOBBi3yMbxZytW0nxOZ2PiOBGozPkS6PMhXtb+6WpgkffUnljqJqHeBp0GXhG
 P8eA==
X-Gm-Message-State: AC+VfDzqwBwHGu0pXUQJmBxJVW2mqeXhpBuEtU7J0b3etict1E7OIkPD
 5+T2XCOKHu9S4kMEmZ24Sfo80cDtn35ekyYY1XA=
X-Google-Smtp-Source: ACHHUZ6WIiXZmCoYcUPHLRA6l97UE19vdEXWaJZQ/Gbk107hUnx4q4y9OIkbCT3g3SDnB4W35Nij5g==
X-Received: by 2002:a05:6808:13c6:b0:39b:f548:3f6 with SMTP id
 d6-20020a05680813c600b0039bf54803f6mr14744065oiw.13.1686820924792; 
 Thu, 15 Jun 2023 02:22:04 -0700 (PDT)
Received: from grind.. ([177.170.117.210]) by smtp.gmail.com with ESMTPSA id
 e10-20020acab50a000000b003942036439dsm7214279oif.46.2023.06.15.02.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jun 2023 02:22:04 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-trivial@nongnu.org
Subject: [PATCH] hw/riscv/virt.c: fix typo in 'aia' description
Date: Thu, 15 Jun 2023 06:21:48 -0300
Message-Id: <20230615092148.612875-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x234.google.com
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

Cc: qemu-trivial@nongnu.org
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 95708d890e..3464abd226 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1690,7 +1690,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                   virt_set_aia);
     object_class_property_set_description(oc, "aia",
                                           "Set type of AIA interrupt "
-                                          "conttoller. Valid values are "
+                                          "controller. Valid values are "
                                           "none, aplic, and aplic-imsic.");
 
     object_class_property_add_str(oc, "aia-guests",
-- 
2.40.1


