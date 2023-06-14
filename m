Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C60F72F19F
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:22:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FD5-0005rE-4t; Tue, 13 Jun 2023 21:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCk-0005bf-Ri
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:47 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCh-0004fj-7u
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:46 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-662f0feafb2so4528901b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705700; x=1689297700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRCoabc8uB3VJTPTpSDNJQJE1zMHM32zfK6KgSmYcdc=;
 b=EVel1QkrlLlxfLvdMKVKReiEaNFXcKmiGqGCCire7hhq1NkSEhhQB3JhXtqj4nWIKB
 O13hqS2xip3YuMTjGvj6ZGljB/SGDy69Jyl2j0W5GxnAfxVfLdmXqVeNY5Sel2uyXIGW
 RDvJWat1cSMNhwj7OdW9mqhqLGXbItePntgFwk0TBrUiEowAVPjDle4UlBolsH28FUqw
 4rFrBSt3afIK1cNClfA+BaKQ3zmurPC1rIeB/le6EnFSFLkgmSas829ROR4oSsLNx524
 WbsQMuH3lzQjL5E8luARHuuOzb6qo0lUFNNaXUWRwlSAQuDYFhS9lBnif6gJm06S0izh
 y2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705700; x=1689297700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRCoabc8uB3VJTPTpSDNJQJE1zMHM32zfK6KgSmYcdc=;
 b=H3zzaWd9s/W3JceFbYWtmVMOFxjBTL4wtyNe1lkUg5Yb6yQ1tVz665fghu5AEdFmOE
 eJU04SLZty8VA+x6joFLcddTViEwAk4Glt2WQ3sN1KN4+H/ECNcA0oSrxmLFhfjx7Yqb
 uguV5qZUr54iFG7qEH/VMd1JT7gg801SAqWgk/bmBb59B8otlHyCVlfQJt6n/QIAjbrL
 PIPa74xBcjTEH7f51TxlRxfYz7cCx3qwcLAwl3TvQ62U6Yjbq93FJmXxUocyeGrsqsgA
 zU5W40Ti/8rQqvG9xDE+LRfZ1tpwzkymNstqJwMWdeQEO3DH6F41DfFejBPt0+bku8rp
 8DrA==
X-Gm-Message-State: AC+VfDwirJqnldqd3xU0sa40c6vC0QOcMKs7OSZHuRRfSvC5uPOiKWf3
 bmVYC4qkkBJ9fs5El7LLMNEyUybPSE6Lpw==
X-Google-Smtp-Source: ACHHUZ61BszzHy5pFlSCPmmCVYqd1q2NvUuGotDcwtaUOQc9dw7kUYuopJzhSTCtaWVsa+TTLqvVPg==
X-Received: by 2002:a05:6a00:2312:b0:659:f4ed:42bc with SMTP id
 h18-20020a056a00231200b00659f4ed42bcmr291719pfh.4.1686705700480; 
 Tue, 13 Jun 2023 18:21:40 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:21:39 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/60] target/riscv: Make the short cut really work in
 pmp_hart_has_privs
Date: Wed, 14 Jun 2023 11:19:33 +1000
Message-Id: <20230614012017.3100663-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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

Return the result directly for short cut, since We needn't do the
following check on the PMP entries if there is no PMP rules.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517091519.34439-4-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 2bc924340a..3c90562d55 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -316,6 +316,7 @@ int pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
                                        allowed_privs, mode)) {
             ret = MAX_RISCV_PMPS;
         }
+        return ret;
     }
 
     if (size == 0) {
-- 
2.40.1


