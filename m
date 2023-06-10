Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5350172ABBB
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:33:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhS-0004Z6-NS; Sat, 10 Jun 2023 09:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhM-0004XB-0o; Sat, 10 Jun 2023 09:32:08 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhK-0007c5-Js; Sat, 10 Jun 2023 09:32:07 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-39a3f26688bso1143535b6e.2; 
 Sat, 10 Jun 2023 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403925; x=1688995925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+ql3NleTmGh5ru6d/kV6UNZGKrMKMoBAs/SS/6QPzo=;
 b=ct/K0nGdCEncRR3uTYTZaaxDVdm9dyyuhCWL98dBcgvrs9u5IACU7LXs82qc4Kbzf5
 PWVOv7OO286OO8S0MCCxAZ39tzDEhQ6lh9+kG0So5XcjFpwwa+KguXDscM/LE9FHEKF8
 QTrefBoRNMDs7lXVbknA1qq70rewZ7KuK9hLahfCsecWCPlyO749QwoFeQ+3IcqMdakU
 rJfY0afcb7y2NBlKjXez687hpKTw7IxJaOQ+gn8HZY/ztjcvu7ECt+Ra/L2Qyjy07j1g
 bhiGpnIXPlU2kdoxiXS6Dzoj4C9PBGCjacYXqRyAxcLjh8oE5tLDcnSeFaM0RcekxU2W
 OKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403925; x=1688995925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+ql3NleTmGh5ru6d/kV6UNZGKrMKMoBAs/SS/6QPzo=;
 b=PjdZwxo/Fh6QeQ9byUYN8+1l1d7H+F048tJmmLi0cLJXYpg2H8nKp4PWHp0bCklTse
 6T/+ERpnpkuYtzAbAJ3ccP+LjC3Y9f42R2Wts6DW/beJTnvYsftSzlJSFhUOJQLrVMEH
 eQSI3mq+SNewD/BroE5f5yT1wdet5GwmmpD5i01+/P1U9K5FIDa69XnECgXy2iysEquV
 soHd3jkHENDpTycJcigWz4LTwdnKG/4kr402ZL/mowQjWGb1th4+5rbcVKTjJUAwM96E
 Y+KKkKtY4vsFRgyi86kd6ff4+knVz+ifm4AY8PBbXtImVkqgMMJPbhRbsJI+Hb1kQSD2
 HEUw==
X-Gm-Message-State: AC+VfDzDqpt9nrAZ+LSnUOXoIktFTwxqBNn9ndgc7TMVuEAGuSB0vP2u
 Zeoj3PhUXa38jSdyih8KX5otudJ4/UE=
X-Google-Smtp-Source: ACHHUZ5Tc+z64hAef5c+PpUXm1cUh56ZRezzhqKfBxV1soGqtN7mb9C/jvJGCyTuULvZvBXwjDILmA==
X-Received: by 2002:a05:6808:1523:b0:39a:a146:8bf1 with SMTP id
 u35-20020a056808152300b0039aa1468bf1mr1113723oiw.3.1686403925030; 
 Sat, 10 Jun 2023 06:32:05 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:04 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 10/29] target/ppc: Fix msgclrp interrupt type
Date: Sat, 10 Jun 2023 10:31:13 -0300
Message-Id: <20230610133132.290703-11-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22c.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

msgclrp matches msgsndp and should clear PPC_INTERRUPT_DOORBELL.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20230530130714.373215-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9ffcfe788a..de6ad121d2 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3071,7 +3071,7 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
         return;
     }
 
-    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_HDOORBELL, 0);
+    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_DOORBELL, 0);
 }
 
 /*
-- 
2.40.1


