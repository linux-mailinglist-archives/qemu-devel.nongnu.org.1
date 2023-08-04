Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 737127704C4
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:32:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwlP-0006bR-RO; Fri, 04 Aug 2023 11:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwl7-0006Nf-9n; Fri, 04 Aug 2023 11:30:34 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwl5-0004Su-GX; Fri, 04 Aug 2023 11:30:33 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1bbb9fcac6bso1497516fac.1; 
 Fri, 04 Aug 2023 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691163030; x=1691767830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmOCwr8scqpbH27tXqr8/twDH4Na3KfVNmq2dgwXruo=;
 b=ZE+Wzad5Hr3omCFnnpb1fJx5ORDOqPxVMOHhcf5cuAYh64SStqRFPnRh041K9sMhJU
 cF4ZTiGS4P6evyWwoU8p/QuCA6Az1QtXyIj+n6CsB1Y9sIbYwxXtv8RX7/w/hBP10787
 kEmM80Wnv1kZ5K+7a5L+tvpE9RaaRme9sH5l2/FtyBtY+0GamYrqyFRyrQ2e4u4ZdGGp
 aA++sT1z0+RGjs/XoRyNa5GyuydkzoELx+mKapImSCiVSSuBL5+lmlJQjsMhu8EYul/A
 /oNtt4/5/girIA2bqrn4ayXpheuhoxaqfqC11W43LckO6KDkU7WgWp0I2p3MrsNtLAbH
 rJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691163030; x=1691767830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmOCwr8scqpbH27tXqr8/twDH4Na3KfVNmq2dgwXruo=;
 b=iEPiIOk3oR2VCC6YTTJWf6hHMTBGGuv3OnmlDuny5fKUIoRQv10RQ8YOJxkePEQ4V+
 mjvTGVK0FcN2vVVs/NSZmLO46VpYETcpIqTLvpxZTgXNQHfYAeA5IVrqKjGzPQuDArGS
 7Hwxvy+4ryaweWS4oRUzOK5lw4coC61WDO2LOhlw06KyipcxtsCAd9zyPPmPCzy94ppP
 PEf3eXYAyN+er63FeRYnH2vmxprXeF96thcqGKRmxEJTWTopuWh41iJVj9p8NTHpzLCi
 DgJmN0Xv+ArbLVJR48h9OqXLhPo2WbIft+qkQKaoZ3UddwYcBUSNQYppTvrmy4zV3jDP
 xW3g==
X-Gm-Message-State: AOJu0YxZ0APxJBcGg8pwooig648xobO0D2fRzqSo3+TEZPn9qOExCurS
 Z1PFSyLuk/ToDicunDqDxm+X241Oe8o=
X-Google-Smtp-Source: AGHT+IFvuzSnoeNnFC0cAxR9l7CP5z4oisaBPa+xIFeQBHxJc1/oCw7/njgeWLtg53XojooSgAWz3Q==
X-Received: by 2002:a05:6870:c6a6:b0:1bb:7825:636b with SMTP id
 cv38-20020a056870c6a600b001bb7825636bmr30637oab.9.1691163029785; 
 Fri, 04 Aug 2023 08:30:29 -0700 (PDT)
Received: from grind.. ([177.197.108.190]) by smtp.gmail.com with ESMTPSA id
 q4-20020a4a4b04000000b00560b1febfdfsm1115761ooa.10.2023.08.04.08.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 08:30:29 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 6/7] target/ppc: Fix pending HDEC when entering PM state
Date: Fri,  4 Aug 2023 12:29:54 -0300
Message-ID: <20230804152955.22316-7-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804152955.22316-1-danielhb413@gmail.com>
References: <20230804152955.22316-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

HDEC is defined to not wake from PM state. There is a check in the HDEC
timer to avoid setting the interrupt if we are in a PM state, but no
check on PM entry to lower HDEC if it already fired. This can cause a
HDECR wake up and  QEMU abort with unsupported exception in Power Save
mode.

Fixes: 4b236b621bf ("ppc: Initial HDEC support")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230726182230.433945-4-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/excp_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 003805b202..9aa8e46566 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2685,6 +2685,12 @@ void helper_pminsn(CPUPPCState *env, uint32_t insn)
     env->resume_as_sreset = (insn != PPC_PM_STOP) ||
         (env->spr[SPR_PSSCR] & PSSCR_EC);
 
+    /* HDECR is not to wake from PM state, it may have already fired */
+    if (env->resume_as_sreset) {
+        PowerPCCPU *cpu = env_archcpu(env);
+        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
+    }
+
     ppc_maybe_interrupt(env);
 }
 #endif /* defined(TARGET_PPC64) */
-- 
2.41.0


