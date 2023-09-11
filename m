Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AD979A3BF
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:47:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfago-0005tV-51; Mon, 11 Sep 2023 02:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagl-0005ab-8D
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:27 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagi-0005HT-Us
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:26 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ab244ef065so3152543b6e.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414783; x=1695019583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0AugPxvR0Xk9MuYdUUIr4+5lfDeBI452w5K1Z6wU4Oo=;
 b=gfQ8VCfAWU70sVX49r5Rslx72mer9AoRf/QGxcsoHDlxNRANHNOFCJIIpEfYIPooK9
 vbZLWcC/OMQvWP+ItKTR6l4sQCfEmPOUXxFcU8u5/QJQN0m7ksSWapxkp0eQ1Q2FNShW
 2CwtJP0DVNj9doIIVHHMQccWIHtvf9sDSF6vW0DZC++D7PYMDFI1mJx6009SkIBWSint
 vCEM0tkoOH8jvdYyvlv1hh12oW6YlA6MOZ0zIM/WxhkSiPDmi1tZTlk4ochrx6ohMQao
 zkz4pDtyxDkqw9/gGoert1vf9NW2zf4+ND6BzPii44v2u3gclhvFuHOJ1K8onuhEnzWj
 nSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414783; x=1695019583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0AugPxvR0Xk9MuYdUUIr4+5lfDeBI452w5K1Z6wU4Oo=;
 b=rB2F12GQIYsa3YAPHvpo7vlz893z/CA1WSQ9JuVsCJIeprpCW2wdS0RU3f0Wjder8t
 NmcDz/4ndr5k5MyC75iURxH8kYNrpHHRVUHk9pBshoJB/DQ9p9EjOoesNrrkInGQ7nWI
 s+y4EkxrIU3L54SyauyNLmR47kwo0Gs7yyfoDFBWcTgfxkA9IDdV9VKH1pgNab8+yqPR
 Yk+Uktk7gXIk+2JyQcN0Bfi6x04NYnHPSjzXw4LUo85A375M7AYdkI40N/C151QOTcmT
 8nKBVQgnSG3p237it9W+IHxdyy3I7Kbh7FBLh6V9bdvXY7Pke6tW2uBeMG4hwCxmNY/a
 98LA==
X-Gm-Message-State: AOJu0YykyhGmt98DEF80W7heo0mLg3Rco4S/Ero4mJn4d2l9upbhzMxj
 deL9Yo0ELCQsdExSUywFulwapAj1mxBZJA==
X-Google-Smtp-Source: AGHT+IEVLVEcX79DeXQ3kBd8e1QJoa73XblKltDC7W915UcLk/DVGmWAx1033QvwyS3QFjyiSQxieg==
X-Received: by 2002:a05:6808:2390:b0:3a7:48eb:2de2 with SMTP id
 bp16-20020a056808239000b003a748eb2de2mr12430226oib.26.1694414783561; 
 Sun, 10 Sep 2023 23:46:23 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:46:22 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Leon Schuermann <leons@opentitan.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 43/45] target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX
 changes
Date: Mon, 11 Sep 2023 16:43:18 +1000
Message-ID: <20230911064320.939791-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22a.google.com
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

From: Leon Schuermann <leons@opentitan.org>

When the rule-lock bypass (RLB) bit is set in the mseccfg CSR, the PMP
configuration lock bits must not apply. While this behavior is
implemented for the pmpcfgX CSRs, this bit is not respected for
changes to the pmpaddrX CSRs. This patch ensures that pmpaddrX CSR
writes work even on locked regions when the global rule-lock bypass is
enabled.

Signed-off-by: Leon Schuermann <leons@opentitan.org>
Reviewed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230829215046.1430463-1-leon@is.currently.online>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 9d8db493e6..5e60c26031 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -44,6 +44,10 @@ static inline uint8_t pmp_get_a_field(uint8_t cfg)
  */
 static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
 {
+    /* mseccfg.RLB is set */
+    if (MSECCFG_RLB_ISSET(env)) {
+        return 0;
+    }
 
     if (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_LOCK) {
         return 1;
-- 
2.41.0


