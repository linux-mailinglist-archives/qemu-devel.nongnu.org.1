Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA7077375F
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:12:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD8C-0008Dw-II; Mon, 07 Aug 2023 23:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD89-0008DQ-A4; Mon, 07 Aug 2023 23:11:33 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD87-0008Uo-QV; Mon, 07 Aug 2023 23:11:33 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-564cd28d48dso1759033a12.0; 
 Mon, 07 Aug 2023 20:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691464290; x=1692069090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHTYl0Q8/otY2A0K5afGJk1HMia3iXDDoE/2IoDVxBA=;
 b=m8H0z09XupGdQcf7dtTrGA4udh9frVLuCMK703pvWTvpDt9lzSdq8N/kvKRWX1SfYm
 cLV2/ZnoBGTaQ2lFtn+/YE1m3lRSRTdGCQAlO/Dc4rFQh49S/m/MH5MFBhJuX9GGeb24
 cINzOT0gIQIe8jGFQNXoixrZQo4LF0v0xqc2GaOyf+csczk0fmlmSnSwpixrXhzsz/tE
 ApomNwdoMNRqISu+PrHmPxZ7d+fWXzmvYJxQjNFL0k238ii1D5s4cMs/TDBgjP91xRjh
 4joVEwM8ri1TLLfPiQulPGNxGi1Y58k7zpmEu/hIStsF7yXf4j5XELSq8yfu0ZqhM2tt
 62qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464290; x=1692069090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HHTYl0Q8/otY2A0K5afGJk1HMia3iXDDoE/2IoDVxBA=;
 b=Fjdkpm92h2qvgfggL7wNaHylvYXzVstehp6LQkm0mOAQrJsUvLwYOieBi2tboszouE
 p61h/ZsumHvyzdFvpqmIhuOQnJyLI5aLd2lwLnWOYCez4XbKJU8w+RfSrzviVaktX6NF
 l1VyrZJIDTGSfiqk0dFuWKG3b/+QmlwdwAdbroUDoCgLSzY2oZ6vb5g57ZZG2hYzrf04
 suZXxeFY6r3A+0uM09+ABIe37hB3VpbY5+I4pktrtdaLZVzr9Gm/wuv9QZ5MbOfPKic8
 kI0kxXCcOwmTBBBAYcy+l4+0eURZVkkyv9oxBhWykyQ8mlis69KzdLoWqPgLKybyHw56
 xGuA==
X-Gm-Message-State: AOJu0Yworng+Jtxv6H274X+/dJc9XX35wKetX/93aXa4P5KxIIjDZxyK
 pNW3ab6I2I9IX5y56QGNHRQ=
X-Google-Smtp-Source: AGHT+IGY+J2Zzp989rztIaWGkP2Y+KYYOgip7Ua95B1HFzheg8nM68kDFxgtLnEVRzWz+PMbRrpjdQ==
X-Received: by 2002:a05:6a20:9151:b0:134:37bb:89be with SMTP id
 x17-20020a056a20915100b0013437bb89bemr10415613pzc.57.1691464289977; 
 Mon, 07 Aug 2023 20:11:29 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 i21-20020aa79095000000b00687ce7c6540sm482642pfa.99.2023.08.07.20.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:11:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 1/6] target/ppc: Remove single-step suppression inside
 0x100-0xf00
Date: Tue,  8 Aug 2023 13:11:11 +1000
Message-Id: <20230808031116.398205-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808031116.398205-1-npiggin@gmail.com>
References: <20230808031116.398205-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Single-step interrputs are suppressed if the nip is between 0x100 and
0xf00. This has been the case for a long time and it's not clear what
the intention is. Likely either an attempt to suppress trace interrupts
for instructions that cause an interrupt on completion, or a workaround
to prevent software tripping over itself single stepping its interrupt
handlers.

BookE interrupt vectors are set by IVOR registers, and BookS has AIL
modes and new interrupt types, so there are many interrupts including
the debug interrupt which can be outside this range. So any effect it
might have had does not cover most cases (including Linux on recent
BookS CPUs).

Remove this special case.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 74796ec7ba..06530dd782 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7410,8 +7410,7 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 
     /* Honor single stepping. */
-    if (unlikely(ctx->singlestep_enabled & CPU_SINGLE_STEP)
-        && (nip <= 0x100 || nip > 0xf00)) {
+    if (unlikely(ctx->singlestep_enabled & CPU_SINGLE_STEP)) {
         switch (is_jmp) {
         case DISAS_TOO_MANY:
         case DISAS_EXIT_UPDATE:
-- 
2.40.1


