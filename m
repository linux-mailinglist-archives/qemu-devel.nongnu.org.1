Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E9C7AD6BE
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 13:11:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkjUJ-00013E-6l; Mon, 25 Sep 2023 07:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qkjU5-0000vQ-IA
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:10:41 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qkjU3-00063O-US
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:10:37 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c5c91bece9so43878915ad.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695640234; x=1696245034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BvX2+sVn3mYCB1tN/Qo4MV8jbyR8oE8a/ORQJtmCsgc=;
 b=ZM8SPrZ/PmtYSeBF+n8ADEBDIoTSuaYSy6XzHMxxKivlFegsgw19LCZ0TSZF4FujtJ
 ejv2ZpKvCleR99+p35u1BE9u5XyAYNA7PtJxPvwzruX+nJYtWq511qJ3QdBXuUPdKDL5
 7t84cvppuTppI0Dakav0OU71h9fBLO8H3V20Bhjro/qQ/CO8ZYILvqIF7sRrHWfJBt/C
 cLS9CZnpxzSd1nnkm95bzEmWCqi1OiMh34URQGkAyTjj04XJ2b6Mq3k31GiEsfY9ojkQ
 sKhOxJontvcoCFOYzG/r+sc4o3pvZ9IJJUuxfHMAXA/0ispuPmXBvbyWt6R+10NBSruZ
 XxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695640234; x=1696245034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BvX2+sVn3mYCB1tN/Qo4MV8jbyR8oE8a/ORQJtmCsgc=;
 b=rm7sFZFWHgImvGtHj6hT8jCbEoPDd0chY9gArzS1I++6N10k/AYdsgfqxacUw2z2vB
 ls02psWw4BPBVVYezImcy38gcTc+bXevwG5TxOaYI9cAoN2WrAFglAf/EyuOEKV9RkwL
 dVVAP/pJGqL9wBRMmcMlh84ThoM61RPjuW6RRYizxSMntZdljRQoTirxzPU/uaBQ8Vh4
 CzFrO5Vr7M6mQW9+4fFIfZU+TsTzNGii23lgtDAXpGWfsfp3jOiiwVVxlV2/3kO8faNp
 0fnVFOze07C2NDh6R3ZTMThanMs3RMK5SzOR4XgoXKHK7lHqiB0wg13KyxhAeBvYfMSl
 IZlw==
X-Gm-Message-State: AOJu0Yw6MnBlrdPFYIZ4kqra3kISaUz7RO/DuvJXAALaxWGBUIhBV8Vb
 AWh7iapZ8BW8WweBFQSD1cdLSQ==
X-Google-Smtp-Source: AGHT+IHZL8Q7lLAUUnCqbzWnlc1zd8CEkgGl1WcMIWfpOuk/KZGaEFEIPuTXhKUKMHY0bK/vDQNXOQ==
X-Received: by 2002:a17:902:ab1a:b0:1c5:cc30:7329 with SMTP id
 ik26-20020a170902ab1a00b001c5cc307329mr4466578plb.54.1695640234560; 
 Mon, 25 Sep 2023 04:10:34 -0700 (PDT)
Received: from mchitale-vm.. ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 n11-20020a170902d2cb00b001c06dcd453csm8527791plc.236.2023.09.25.04.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 04:10:34 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2] target/riscv: pmp: Ignore writes when RW=01
Date: Mon, 25 Sep 2023 16:40:25 +0530
Message-Id: <20230925111025.543094-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=mchitale@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

As per the Priv spec: "The R, W, and X fields form a collective WARL
field for which the combinations with R=0 and W=1 are reserved."
However currently such writes are not ignored as ought to be. The
combinations with RW=01 are allowed only when the Smepmp extension
is enabled and mseccfg.MML is set.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 target/riscv/pmp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 5b14eb511a..8e25f145e0 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -120,6 +120,11 @@ static void pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
         if (locked) {
             qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - locked\n");
         } else {
+            /* If !mseccfg.MML then ignore writes with encoding RW=01 */
+            if ((val & PMP_WRITE) && !(val & PMP_READ) &&
+                !MSECCFG_MML_ISSET(env)) {
+                val &= ~(PMP_WRITE | PMP_READ);
+            }
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule(env, pmp_index);
         }
-- 
2.34.1


