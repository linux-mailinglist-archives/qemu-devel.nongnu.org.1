Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A86E72F1C2
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:26:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FFz-0006H1-0A; Tue, 13 Jun 2023 21:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FFe-0005nV-TK
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FFU-00053t-Fl
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-66577752f05so2325429b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705875; x=1689297875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgK4bxXOYWNquzr7OgnHi2SewH75uRulMmWDwRwzDe8=;
 b=ClGnDA00xY4RtOGTpcc+kwe4sfxttwtjU1vm0TCEzrfPkzPy/ZL1zQwOqbiddWEFeH
 EoFwJfDsK060BHCEx7wZ6A8kWNp6GWxeTU/kxPYgyyB0wt4YgAUcFNtz7/WcVBS9p/5T
 ZDuRU3aESa7lNogau/jySAr+ZBQqtuK3w965P9rXjFXAIZkycnCFxihvKZ1PkX1R8tOn
 6/qhm1Z7Skp01eWXX7Y30WN5H12oIxj3ThZys+fflIcJkhwNXtH5Px9+Z5ooMEA0PFNa
 NaUEZib6/YZWTzrQ+I+6ImRCe6X32dJqohlEZiyE6FicVcsIYje+bYxd5ryGZFmWFjbW
 CwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705875; x=1689297875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgK4bxXOYWNquzr7OgnHi2SewH75uRulMmWDwRwzDe8=;
 b=g5ylLuatj1H+VhWKb7XyE8GtVjvIfdn9Z+mSKrsjKD3wCo5jlq89uwg2DHbJFCIOqo
 5Uqb0LeSv+Wr5+R7OcsW1o/EYRA1e9gt5Dr67iwgaNQkZd8Kd8p5U9gQFQwyd/lH7YQ3
 Y2cALIUpjk9EiQuoLbyyHV7DErt6QH2yCds2T338akIl1O6AjDOROa4VkAHBDfdG4KrX
 5P51iXN9ebC8m/4ASCqkYTMp3AdZbtAa1MgdWP1PZzeJssFPXVLbRFn22JEhSFQIQqH0
 AR4r1dAkQzbYIYduZOHsqj/Ivd4JQOWhGaysnyTmfNiFlc15JQd53nvVbY1QTMB6L8uS
 zNWQ==
X-Gm-Message-State: AC+VfDy/krwVvI5wZbKs2zlAwjvcX/0DrjQzDR9o8GKMaZpYLhJxT+cC
 0V93T93oBDAKYs/B+cGKHazLKqudnB5Ykw==
X-Google-Smtp-Source: ACHHUZ51Z5OGMyibDVzTbN4ciBAXyXGj+hemic9/lTnlnvtidc5OR7TvPlBMFXO9NiBhPrB7I2+twA==
X-Received: by 2002:a05:6a00:1821:b0:646:59e4:94eb with SMTP id
 y33-20020a056a00182100b0064659e494ebmr1082090pfa.15.1686705874968; 
 Tue, 13 Jun 2023 18:24:34 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:24:34 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anup Patel <anup@brainfault.org>
Subject: [PULL 60/60] hw/intc: If mmsiaddrcfgh.L == 1,
 smsiaddrcfg and smsiaddrcfgh are read-only.
Date: Wed, 14 Jun 2023 11:20:17 +1000
Message-Id: <20230614012017.3100663-61-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

According to the `The RISC-V Advanced Interrupt Architecture`
document, if register `mmsiaddrcfgh` of the domain has bit L set
to one, then `smsiaddrcfg` and `smsiaddrcfgh` are locked as
read-only alongside `mmsiaddrcfg` and `mmsiaddrcfgh`.

Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Message-Id: <20230609055936.3925438-1-tommy.wu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index afc5b54dbb..4bdc6a5d1a 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -688,13 +688,13 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
          * domains).
          */
         if (aplic->num_children &&
-            !(aplic->smsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
+            !(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
             aplic->smsicfgaddr = value;
         }
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_SMSICFGADDRH)) {
         if (aplic->num_children &&
-            !(aplic->smsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
+            !(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
             aplic->smsicfgaddrH = value & APLIC_xMSICFGADDRH_VALID_MASK;
         }
     } else if ((APLIC_SETIP_BASE <= addr) &&
-- 
2.40.1


