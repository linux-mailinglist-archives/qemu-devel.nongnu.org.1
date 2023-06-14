Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C380572F1FC
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:33:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FEd-0003Wd-1b; Tue, 13 Jun 2023 21:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEJ-0003Da-P0
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:24 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEI-0004s8-4J
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:23 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-652d76be8c2so6520022b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705798; x=1689297798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QA+M14ZhEeFLD7dM1TXS8+1/+CqbWIar9yiZjOObFMo=;
 b=JFKh7mk4R76VkA40QVrCTyNZTw8Eesn/3RuNuLAptv8XoSYSkDDPTfBPo/2Hb2CR9x
 daxUiaYISJGemLiQO2WVFLotu+yTzZHj2UjdnQcA0NTQG/MBz4pBV1eqCuhxnJTHnwKH
 x43TJLT7M5P+9Jm8XndqLWhwD4UDJpQaJ8/JFCtCR3IAA8CzhLOxwty5X2ClzFKclJ2c
 n+zMViBL5nDIec/oMXSIbouhCVpw9Zko+YVEVQymkSmbQrqKt0Yb1KI+kPG/1/3EBwkj
 o892fjcq4kALjdCn5KH1jXc+08tMSqNvAN+5pBvywvHbxK25C7yZpygz3jsfalIlqIuV
 eTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705798; x=1689297798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QA+M14ZhEeFLD7dM1TXS8+1/+CqbWIar9yiZjOObFMo=;
 b=jciniLZNUC+PRGNRs8ry0ylmkWVr04Hug/DN1MQLkjS3d4WRyJy0iivmS9kahiW+FR
 ONxJ8LDcYOYGPWKSnv4eyZl3tLVXqt0Q/lAf3bXpmW58GR5EhRECgbC9bwYZQWqK3FJG
 SRXr3Tyij7Yio57/wvhGedG1DI+BJdItekXHYltzndMGcKQ6bDfnW5kRi+KGforpC1Cf
 iVWSp9BhH/3McPqsMs1/VWxl4mNrWmL6quJdzHacoQpilTAbKbHdFODJCzyiIZdjC6LQ
 263Zg3YAMsFUZpQHk8WLFqJbNO+WQTZ1ir4sCc/KdBQq27GotgxWyg9qBCtzV78uD3PW
 RKjg==
X-Gm-Message-State: AC+VfDx5NKKib3otSTrKiVvszpKv0dpSfmL3cHkDQdgpEeKnaG0tjRam
 Vt3abZhXQrasUwXLWeuTUKdt47jGyMRXRA==
X-Google-Smtp-Source: ACHHUZ5zpUjpCZ83KRWD2XPsS6mWAQsImoemr4sgYOkfJScRzCLgTPO7PWTEVsBMOefIFbMBr4suqg==
X-Received: by 2002:a05:6a20:3d01:b0:10d:d18b:95ce with SMTP id
 y1-20020a056a203d0100b0010dd18b95cemr527479pzi.22.1686705798127; 
 Tue, 13 Jun 2023 18:23:18 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:23:17 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 41/60] disas/riscv.c: Support disas for Z*inx extensions
Date: Wed, 14 Jun 2023 11:19:58 +1000
Message-Id: <20230614012017.3100663-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

Support disas for Z*inx instructions only when Zfinx extension is supported.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230523093539.203909-6-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 6659f92179..c9a81af662 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4598,16 +4598,24 @@ static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
             append(buf, rv_ireg_name_sym[dec->rs2], buflen);
             break;
         case '3':
-            append(buf, rv_freg_name_sym[dec->rd], buflen);
+            append(buf, dec->cfg->ext_zfinx ? rv_ireg_name_sym[dec->rd] :
+                                              rv_freg_name_sym[dec->rd],
+                   buflen);
             break;
         case '4':
-            append(buf, rv_freg_name_sym[dec->rs1], buflen);
+            append(buf, dec->cfg->ext_zfinx ? rv_ireg_name_sym[dec->rs1] :
+                                              rv_freg_name_sym[dec->rs1],
+                   buflen);
             break;
         case '5':
-            append(buf, rv_freg_name_sym[dec->rs2], buflen);
+            append(buf, dec->cfg->ext_zfinx ? rv_ireg_name_sym[dec->rs2] :
+                                              rv_freg_name_sym[dec->rs2],
+                   buflen);
             break;
         case '6':
-            append(buf, rv_freg_name_sym[dec->rs3], buflen);
+            append(buf, dec->cfg->ext_zfinx ? rv_ireg_name_sym[dec->rs3] :
+                                              rv_freg_name_sym[dec->rs3],
+                   buflen);
             break;
         case '7':
             snprintf(tmp, sizeof(tmp), "%d", dec->rs1);
-- 
2.40.1


