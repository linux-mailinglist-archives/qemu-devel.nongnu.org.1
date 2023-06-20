Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D821736CDC
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:16:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBbD6-0003fb-8B; Tue, 20 Jun 2023 09:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBbCq-0003Yj-Re; Tue, 20 Jun 2023 09:15:39 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBbCm-00015g-Kh; Tue, 20 Jun 2023 09:15:33 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-25eb817b92fso2016089a91.3; 
 Tue, 20 Jun 2023 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687266930; x=1689858930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DbdL4TjRIf7QQwhWq8z2PckkRpte8dSen0gz0QPkWhA=;
 b=bV/kC677hVaSVzetTymkULyWhPF53gOTdbJqKtqDcYv6JYgLp3iHLuGZ9JIR5/Vq94
 a3XXgK3jIWIK+d+Erq8evSnNmr2kS4lg8XHRGwaJ1jd/lHcxMim83TbDS3FkdqVdSULm
 hQ+VczIcayZ8F1LX6OJC0n/UpogE/Ihb2Fi3RP8Wd89MNgCYxf9bmLUMXrdDrfte8FQc
 dlwdnVhsJlrJFNNK3mcUZElcUy4usygFomYrhh4Mns/RlC1Nkb4AOJ5HKLHYBBf6xXy9
 s/92hwmWR9u+7SKLRRxpp1hZn3oocIff+Hk1ygEPs/+MzmUX2QADdZLT4Z91GLw3dqST
 veJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687266930; x=1689858930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DbdL4TjRIf7QQwhWq8z2PckkRpte8dSen0gz0QPkWhA=;
 b=DkozxiFDycN54M6yk0lAYGukfO3+J95Pjy3e1x/RZTRzUaBYcs3QLgzaR8U2CzJ5RW
 G9peqNvamt+xdLqe1bHuwB8v0XMSrD1xunDILoUa5pGRepSMLbKvQBGuJYR0qdLbd4BL
 X5lUByeaO2heeBv5wsZsjnZBxVwPOjZyWVfdMRkoHth/2UKqZz2IaQj/gQDjpuiafY/E
 r1TBpZBJcUBJRVT6KRvGMHb11LYNlNmiGb6c5fpuH7srJSkl46ylvz7SY6FXJR11MCOk
 mV7cHJgv+RtkzmFES/ZVfHVExM7lvAZGm3tg0t9i46QZCe/bhP7y7g5M/SeIW22Pas1H
 uPeQ==
X-Gm-Message-State: AC+VfDxLft0jH+2qvt26pl497uH30MLktW89YLlVZNjhIX/5YRn/mZrH
 AGK6TUOvHCOuZfPKge5za4gySAYB9iI=
X-Google-Smtp-Source: ACHHUZ4UIq8J5mHl49DMtQ7Cqkm5ZrPwCNGHLIkMbrrwC/a47Gm4PJ+g2tkmDUqgY+cDUckyLue5CQ==
X-Received: by 2002:a17:90a:8812:b0:256:857f:823d with SMTP id
 s18-20020a17090a881200b00256857f823dmr6612027pjn.48.1687266930420; 
 Tue, 20 Jun 2023 06:15:30 -0700 (PDT)
Received: from wheely.local0.net ([124.170.190.103])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a17090aec0400b0025c2c398d33sm1491004pjy.39.2023.06.20.06.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 06:15:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH] target/ppc: Better CTRL SPR implementation
Date: Tue, 20 Jun 2023 23:15:23 +1000
Message-Id: <20230620131523.169340-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
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

The CTRL register is able to write the bit in the RUN field, which gets
reflected into the TS field which is read-only and contains the state of
the RUN field for all threads in the core.

TCG does not implement SMT, so the correct implementation just requires
mirroring the RUN bit into the first bit of the TS field.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
This is also unchanged from last posting except improved changelog.
The pseries TCG SMT patches depend on this one, but it is good to go
by itself too (this is what CTRL appears like to hardware KVM guest).

Thanks,
Nick

 target/ppc/translate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b591f2e496..1ade063616 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -418,7 +418,14 @@ void spr_write_generic32(DisasContext *ctx, int sprn, int gprn)
 
 void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
 {
-    spr_write_generic32(ctx, sprn, gprn);
+    /* This does not implement >1 thread */
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    tcg_gen_extract_tl(t0, cpu_gpr[gprn], 0, 1); /* Extract RUN field */
+    tcg_gen_shli_tl(t1, t0, 8); /* Duplicate the bit in TS */
+    tcg_gen_or_tl(t1, t1, t0);
+    gen_store_spr(sprn, t1);
+    spr_store_dump_spr(sprn);
 
     /*
      * SPR_CTRL writes must force a new translation block,
-- 
2.40.1


