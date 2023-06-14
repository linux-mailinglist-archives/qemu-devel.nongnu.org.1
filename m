Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 086CD72F212
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FE7-0001kj-SL; Tue, 13 Jun 2023 21:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDg-0001Sf-Ai
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:44 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDe-0004oG-Oo
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:43 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-3f9b5ec058aso14586891cf.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705761; x=1689297761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hw/fmIMjG1mx6PleV6CiPqb2RfagwK9ZTs4fpLYe9zw=;
 b=AfekKBzPWO2AdWMgFRDaTBHA6HKMG+cNTtfh22BGxms6saiJoXTe0vdPEgqf7daCcM
 /rjODtb77uHFJ/7t9pv85Bz5DLxtgt/IAfS3UgfkKtlDOdHnyC837bQ0Fn9JIxe9ntR+
 XW7SNuSNs7ooa9k5/wHSBEManEFnuvY1MRIn18M8mcF54QrOi4v0fzhHj/HkkWeBLbgJ
 EZcDsGb8mf5UZapbUVEGnms1V4UdPklQDxwv7nYImJdvoHKyVW+FZM5w9aLIEIcCiQoA
 OmlKa7UO7AOO18Ig2ar+aeRNAbJhz5B94G7BeP9K/KlnwDkmzsb/fDDzgX0sy3A1deKd
 6Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705761; x=1689297761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hw/fmIMjG1mx6PleV6CiPqb2RfagwK9ZTs4fpLYe9zw=;
 b=Z42Z0g/mwWrUTiS+nQXYAcCJennE412jG5Je4hDDVGSTdQBTrYniIvAANoOhwhLClp
 S8Vsyehx2GVMtmc2OmgRyze9mlQBqKtpXCcXsooKgFtSvUyl2P8q/Rl0RkvHmCmEJbG9
 Qi87GNUp5vVGbM6RwzriO73CRRe9OSAKIeCFPlCOGF7oZXAK7kqIkK9hkMU9rSH0OI5o
 CJmSwRsr3ECHABYieY6RNc7Kb0k0z2Vw+VRs2/OiWCws3tWeyDqpJkl8ucELM33V1Ahw
 jzURuJEpoEmO4QvEdonSzk4R/fmHpB2AdKZhbD0guxPynco/yvnpjcAivd7ldY+SxdBN
 E01w==
X-Gm-Message-State: AC+VfDy46Dx53vx8W/AlHn06wY2bU9Vuxtf5NLjFCwPnnTcd3ZT+LrIz
 Dw2St4o1zKjU4CwDm38KvKdrwIFWFpGufA==
X-Google-Smtp-Source: ACHHUZ46Zvv92cWqCm2ejIcAVa3KI1HZQxIDhEsn/2htO3j0vBqRbRXQ7HbGdhqqIYC0+KAGZ4L3cQ==
X-Received: by 2002:a05:622a:2:b0:3f3:8e79:5742 with SMTP id
 x2-20020a05622a000200b003f38e795742mr736903qtw.19.1686705761535; 
 Tue, 13 Jun 2023 18:22:41 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:40 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/60] target/riscv: Fix pointer mask transformation for vector
 address
Date: Wed, 14 Jun 2023 11:19:49 +1000
Message-Id: <20230614012017.3100663-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=alistair23@gmail.com; helo=mail-qt1-x82b.google.com
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

actual_address = (requested_address & ~mpmmask) | mpmbase.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-Id: <20230524015933.17349-2-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8e6c99e573..7505f9470a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -169,7 +169,7 @@ static inline uint32_t vext_get_total_elems(CPURISCVState *env, uint32_t desc,
 
 static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
 {
-    return (addr & env->cur_pmmask) | env->cur_pmbase;
+    return (addr & ~env->cur_pmmask) | env->cur_pmbase;
 }
 
 /*
-- 
2.40.1


