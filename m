Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A357737DD
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:22:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTEDJ-0006zm-GA; Tue, 08 Aug 2023 00:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDH-0006zV-Pg; Tue, 08 Aug 2023 00:20:55 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDG-0007k2-7Z; Tue, 08 Aug 2023 00:20:55 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a37909a64eso3643974b6e.1; 
 Mon, 07 Aug 2023 21:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468453; x=1692073253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPClgIZ1e7ypLFEW8b3J7zgdfUJQG0EgyV1eca3pY7g=;
 b=IBje1fsKw1oDIn/kFbtz5Y+w6KNu5Vz7g2+PrxvTKTmgBoRI6895O0p8XU44Hzw4nZ
 XQZpNO3K5oWpTYVpfnPXBK0GyJTz4PZ3kCBps65mPoMEl59RMl1YP5k5+tPL02k37UOT
 uD32B8OMJT2pnOw6/2H2kUtB8RoXpPe7Y4oQXrIwzzAsn9UsznajoA8IqsB/rxMB6mJR
 QFmlpXPEZ6C6+VI75C7Ay4+sbQdz8uDKR4ZVf1U4W/eDZ/XitYvaxdgmL68/OxwJ7Om0
 HGh6fopaCaznZfl9V0FjokSQBR9Y11MJx8TbGkgXw7QPpMHpC3+J5qdr3lmHuQdMuPhx
 pj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468453; x=1692073253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPClgIZ1e7ypLFEW8b3J7zgdfUJQG0EgyV1eca3pY7g=;
 b=NkjY9+3jx/mgu3dnz6LTO1wJnEHuuoIu4/e5wjYoMtcGB3+fKfGxO+60Dtn/rePVvq
 vfsbwzPIHTXjSwh+rYmnjMHQbV3ZxzpXbxLBTpQnvxi0vFxkwDhCSIEfj/SDmHZe3h3H
 wqSm/4joJyqYqhoDZEDiAzVP3rwbBAV4q2XCD+uqDPTCxR/dtKWVo/mypw3EQ+TNqE3+
 A64EKQYmWq2d91XTzwLPaooUuQ1rNU+WRFEjU3hONrT9wcwWcqfYcwKsq1znGbC+G63h
 OlbCdBCHxnyf+bcG0k+uj5C9sClcr/P6D8XhbetlXIR8yc6BaATvHyS3a98+eczCCtKx
 4iuw==
X-Gm-Message-State: AOJu0YzEZEQhRNTyOCd+6yzGGZB0WL0EuodcOawRNML6DW0MFpfCcFa6
 Zsi/+yMm4eObOGHzvqp0w7U=
X-Google-Smtp-Source: AGHT+IE39aaQQsdUqzud7qgIWpboLpXiqn2y4oaQ1caBP+1B1ixX3SaWhgdMBo9TGc+hYJZbjUrUOA==
X-Received: by 2002:a05:6808:bd5:b0:3a7:3ce0:1ae5 with SMTP id
 o21-20020a0568080bd500b003a73ce01ae5mr15162302oik.47.1691468452745; 
 Mon, 07 Aug 2023 21:20:52 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:20:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 09/19] hw/ppc: Always store the decrementer value
Date: Tue,  8 Aug 2023 14:19:51 +1000
Message-Id: <20230808042001.411094-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22d.google.com
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

When writing a value to the decrementer that raises an exception, the
irq is raised, but the value is not stored so the store doesn't appear
to have changed the register when it is read again.

Always store the write value to the register.

Fixes: e81a982aa53 ("PPC: Clean up DECR implementation")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index fb4784793c..d9a1cfbf91 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -841,6 +841,16 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
         return;
     }
 
+    /*
+     * Calculate the next decrementer event and set a timer.
+     * decr_next is in timebase units to keep rounding simple. Note it is
+     * not adjusted by tb_offset because if TB changes via tb_offset changing,
+     * decrementer does not change, so not directly comparable with TB.
+     */
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    next = ns_to_tb(tb_env->decr_freq, now) + value;
+    *nextp = next; /* nextp is in timebase units */
+
     /*
      * Going from 1 -> 0 or 0 -> -1 is the event to generate a DEC interrupt.
      *
@@ -862,16 +872,6 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
         (*lower_excp)(cpu);
     }
 
-    /*
-     * Calculate the next decrementer event and set a timer.
-     * decr_next is in timebase units to keep rounding simple. Note it is
-     * not adjusted by tb_offset because if TB changes via tb_offset changing,
-     * decrementer does not change, so not directly comparable with TB.
-     */
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    next = ns_to_tb(tb_env->decr_freq, now) + value;
-    *nextp = next;
-
     /* Adjust timer */
     timer_mod(timer, tb_to_ns_round_up(tb_env->decr_freq, next));
 }
-- 
2.40.1


