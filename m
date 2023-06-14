Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3612E72F1EF
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:31:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FEX-0003SC-HS; Tue, 13 Jun 2023 21:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEJ-0003DZ-Ke
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:24 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEF-0004rw-CW
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:23 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-65314ee05c6so4961794b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705793; x=1689297793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUHnE2P7VZxRGdyuHNBXBOqkF5jaVDQrNwyjd5LDDLI=;
 b=Md2YVt3Ec3Hf6AFhqsJJHOhE1smFMBn9GVqAWnrq86r9lUZp1hyX7agxJcCpBmtQ5k
 IeRg5YVQ8wMSH0RqgBk2C56ISNrX6VqCGTcDw1CBIn4xTjdz2RVC5Z7brLrBh5ePQqE7
 2SexufzgAHAXe2oux8K7Ot54VFZBk8fyNJ/sTRvLvFXeU/T867NK4PtUtx65aUbFvSSY
 uCKC3pZT/JGH6ohZx+te8UaxCSSQEKeB0XGRcQaABritE7ezDHy/9r1xX9vX4jQw9+lW
 EjNz5U05yxKu86rZizkakNWBYjfeBhtCAI0kEjlg5/6sJ3sxcqB2GBa8v2+fn1Pc4NUM
 iSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705793; x=1689297793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUHnE2P7VZxRGdyuHNBXBOqkF5jaVDQrNwyjd5LDDLI=;
 b=bG9UPD8xxUQnW56u61fiH5S/k0qrFRdTqF+3jtqq42z7Q3f3NskqzTn9EOLIJG4ni5
 oi0gkxD5p/5CcuCNgWvMng9vUEJeAWEZtALP4tlBxff4RcbhEshZIGdJsVQAE6reXJd8
 O6tZCU45NmQ59JCq28ic2+HzD7IzqV6KhBpHTwPqcP3w6GSUCWB+yi/2+hgO3F6jleeN
 +C8uVeujkjeb7t9O0eqNqeVPZknQHsuwi4gFEx2PuKomum2zMMgKrXsHRjVgE3MLkiBw
 gzNSEaTORr8zKXlddVoCE3/HSZlu/DPYaA7wxlcc8j+RZ2LkelCLF82enPyV2KycxKv1
 0gJQ==
X-Gm-Message-State: AC+VfDyekU/WfUxLJyys1ZjdHK2cIqPkpNJmH2++M3esh8Whrx4K0veS
 vD0/QWsrMC+JvIWqwZZIQUH5m2VKngCx4g==
X-Google-Smtp-Source: ACHHUZ59kfFUv+34AD4kvx94bGquC5IJun+gkaoMaJLSON0rSasw3W5Ag7sCoGmNKTp4qI5dVvZ+CA==
X-Received: by 2002:a05:6a00:1307:b0:646:3c2:4d30 with SMTP id
 j7-20020a056a00130700b0064603c24d30mr649472pfu.30.1686705793287; 
 Tue, 13 Jun 2023 18:23:13 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:23:12 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/60] disas/riscv.c: Support disas for Zcm* extensions
Date: Wed, 14 Jun 2023 11:19:57 +1000
Message-Id: <20230614012017.3100663-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
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

Support disas for Zcmt* instructions only when related extensions
are supported.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230523093539.203909-5-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index f2dd5fd531..6659f92179 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2505,7 +2505,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 op = rv_op_c_sqsp;
             } else {
                 op = rv_op_c_fsdsp;
-                if (((inst >> 12) & 0b01)) {
+                if (dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
                     switch ((inst >> 8) & 0b01111) {
                     case 8:
                         if (((inst >> 4) & 0b01111) >= 4) {
@@ -2531,6 +2531,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 } else {
                     switch ((inst >> 10) & 0b011) {
                     case 0:
+                        if (!dec->cfg->ext_zcmt) {
+                            break;
+                        }
                         if (((inst >> 2) & 0xFF) >= 32) {
                             op = rv_op_cm_jalt;
                         } else {
@@ -2538,6 +2541,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                         }
                         break;
                     case 3:
+                        if (!dec->cfg->ext_zcmp) {
+                            break;
+                        }
                         switch ((inst >> 5) & 0b011) {
                         case 1: op = rv_op_cm_mvsa01; break;
                         case 3: op = rv_op_cm_mva01s; break;
-- 
2.40.1


