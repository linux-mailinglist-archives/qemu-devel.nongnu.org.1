Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B8A7737E5
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:22:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTEDP-00077L-8o; Tue, 08 Aug 2023 00:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDM-00073U-Fy; Tue, 08 Aug 2023 00:21:00 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDK-0007m6-TL; Tue, 08 Aug 2023 00:21:00 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3a6f87b2993so3890699b6e.3; 
 Mon, 07 Aug 2023 21:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468457; x=1692073257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXQlPOmsz3SjSWtdP/kN0DEGncm9HuckmpRysy+KsOg=;
 b=iXon6G0ynGcFtSWGwdyaNAyFNOLiKE1vMtijB0k9CXWGk1wWgtlP3o0brORxAOZNio
 AtGTQKPbC6WXCMJ4qyPTkdBGUK4lnm7CDYApmv5vVZgAklitGoe8GdzQPchsHRiAhK5I
 EF1iKw/fLJId1Gg6v2xdxzzP0ptI573kHs+rH2QLYR5ufBCsBveTCaNv+u7Sf88hG/gy
 WCx7a4yfKgOGTYn0fCChCKVVMrTbki86G3j55StTdb6ZOXFF7AktIUfhi4GeiuuxM5HU
 jrBKMjf1qbkJIo45k6AcIgt9KgV7WMFxSyidP9urlGvw4MlXIg5Bfh7H6Jmvmk5v3yAd
 aAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468457; x=1692073257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IXQlPOmsz3SjSWtdP/kN0DEGncm9HuckmpRysy+KsOg=;
 b=F2HkeF2p22o/K8MUlgSs0hs8I94Yu/ct5KC3X6aLN+5mg2CpfCh96ToUWl8kUWjjBM
 QreiBwMOawb3OJKNGf+dA/ua82uWhmlwcH9mu6aYzPZtW1tlvFiJ3Oa3dmtcni1yDpjz
 zX/p4njKE+X22bNTDoTMd1iDcLawycO0WW088tOKOf0Ca+IIbbGlUS2kIRjFjrLCTxrw
 ZNGe6nmt70bhIYHkji7ZbbADjAEMy5owXNWls6lxz1LmKSFxXkjIofBdq0j97nk2smIe
 0IcxkvbGxzzCtBcmkYWVbctInW3nLkRsNWWNjg5YBfG3RFJnrSvRr6hyP70jrNCMxksV
 W55g==
X-Gm-Message-State: AOJu0YyezUwv2Aqd61tZvfbNnm17sxWZVYkwN5t2x9leCY+u+qCboCm5
 nCDi8P/XqL/E8LvVwcLoDdk=
X-Google-Smtp-Source: AGHT+IFO3M/gUCOgAh3u7XWMFCibEM5Aj7UIOnwtuE3iuoF/LCsOkUvhZ8eFEHoABDjaN1jzsfcZIg==
X-Received: by 2002:a05:6808:180a:b0:3a7:44da:d5e6 with SMTP id
 bh10-20020a056808180a00b003a744dad5e6mr14946928oib.38.1691468457418; 
 Mon, 07 Aug 2023 21:20:57 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:20:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 10/19] target/ppc: Migrate DECR SPR
Date: Tue,  8 Aug 2023 14:19:52 +1000
Message-Id: <20230808042001.411094-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22c.google.com
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

TCG does not maintain the DEC reigster in the SPR array, so it does get
migrated. TCG also needs to re-start the decrementer timer on the
destination machine.

Load and store the decrementer into the SPR when migrating. This works
for the level-triggered (book3s) decrementer, and should be compatible
with existing KVM machines that do keep the DEC value there.

This fixes lost decrementer interrupt on migration that can cause
hangs, as well as other problems including record-replay bugs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/machine.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 8234e35d69..8a190c4853 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -209,6 +209,14 @@ static int cpu_pre_save(void *opaque)
     /* Used to retain migration compatibility for pre 6.0 for 601 machines. */
     env->hflags_compat_nmsr = 0;
 
+    if (tcg_enabled()) {
+        /*
+         * TCG does not maintain the DECR spr (unlike KVM) so have to save
+         * it here.
+         */
+        env->spr[SPR_DECR] = cpu_ppc_load_decr(env);
+    }
+
     return 0;
 }
 
@@ -319,6 +327,12 @@ static int cpu_post_load(void *opaque, int version_id)
         ppc_update_ciabr(env);
         ppc_update_daw0(env);
 #endif
+        /*
+         * TCG needs to re-start the decrementer timer and/or raise the
+         * interrupt. This works for level-triggered decrementer. Edge
+         * triggered types (including HDEC) would need to carry more state.
+         */
+        cpu_ppc_store_decr(env, env->spr[SPR_DECR]);
         pmu_mmcr01_updated(env);
     }
 
-- 
2.40.1


