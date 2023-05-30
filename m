Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF905716115
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:07:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3z4R-0008Rr-B2; Tue, 30 May 2023 09:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3z4O-0008Re-RX; Tue, 30 May 2023 09:07:24 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3z4N-0002vo-9S; Tue, 30 May 2023 09:07:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b039168ba0so21666835ad.3; 
 Tue, 30 May 2023 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685452041; x=1688044041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tpi4uUrPIrKJODHAjCZ8Cadqqn/VriijIXGRqfMyE9U=;
 b=HKzUZXXixFd4QUzHuFw1OGyWDWKrqlM9ZcplZWmRA8VqihTGOyGNaIPABpDJ6kX/BD
 M4RLToj8oEQgaI7uyDQxiOP/QipHMZ7eIger8bmDQg3cK+0kJXnxgLGp/NYMTV8tXKw8
 CmWMOcr3T5IWemsC5YXy0x2apFbqwftQ8e+B6SNE2eqLOuwxUAZnJV3O9rvwFskfoGrL
 clEp+JExFpwTft3yrdX1o7r+rXM8zK1TT+uy9ujs/muNd0YPFrF+iCK9ZCkdfYdFMNS4
 qVSN4ScSz/JAvkTrNkB+7wQ6lAOeBcC5mqlRRzhj3LXU0fEacSL3mTfQNjsFDGVD7WfG
 T7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452041; x=1688044041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tpi4uUrPIrKJODHAjCZ8Cadqqn/VriijIXGRqfMyE9U=;
 b=OCX2AYKRisfpcViCLjIjlSsOzfTRerTIBQ+VCjossJIOoAj0D+2spYsSNIA3L8K4e6
 1O77jyklmADoQg0OGmWebgCBKnYL687Cq609rC1YcuZerGU1lwJwyB8eMQ20tW16PRJ1
 yvUitZhF287bjGBZXEgZMeaGVxfjpQjTvVmLt+M4JKvxr/uaEux6wkMiaVMtKNaQzLoI
 ZtZYOWm0/WctqGUU6DkTsbt1hc5FEgTMXraCRL5J+NqJWxK2u5en6h71XfWR72xGLLVA
 b1AHrLibtW/TZSKuGMt69wu4afLS72E13BlBX+jdhqurQMwuqdgCaeKWeWeyn36NDh1c
 mUyA==
X-Gm-Message-State: AC+VfDyzvqkwU4YIxr8/L1kZehals0k8fSq7yoIjUS+3TgN71JAhXD7u
 Ie69ikyxsGIo/a0X41FwJt/7u4ELw7I=
X-Google-Smtp-Source: ACHHUZ5w/ZswTVSrn4jS0STDvLON9iQNZbrBZod5lxmBRDY/rkjGRo4MsmSLLnYm/KuwlPv8xTXsIQ==
X-Received: by 2002:a17:902:ced1:b0:1b0:6038:2982 with SMTP id
 d17-20020a170902ced100b001b060382982mr2180403plg.41.1685452041082; 
 Tue, 30 May 2023 06:07:21 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a170902f7d400b001aaed55aff3sm5840045plw.137.2023.05.30.06.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:07:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v1] target/ppc: Fix msgclrp interrupt type
Date: Tue, 30 May 2023 23:07:14 +1000
Message-Id: <20230530130714.373215-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

msgclrp matches msgsndp and should clear PPC_INTERRUPT_DOORBELL.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index add2bc6bfe..c13f2afa04 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3068,7 +3068,7 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
         return;
     }
 
-    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_HDOORBELL, 0);
+    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_DOORBELL, 0);
 }
 
 /*
-- 
2.40.1


