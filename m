Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4390980F2B5
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:32:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5fj-0005ty-Ev; Tue, 12 Dec 2023 11:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5fh-0005go-Cw
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:31:49 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5ff-0007e0-KJ
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:31:49 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2cb20b965dbso58321771fa.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398705; x=1703003505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VzQTFGtBulS+CCTLCLD2ExWe/+5Y5bIpgcbR//mYas=;
 b=TieBIuCx39PZux4zqfCdKwrxtjLu5TMwEn+9bQsLCwKu/6OeyKFQkOJhX6I2zlnmJT
 69Lz3kIQf9vIuIDo171jcJf7OanjV1YV/5QiptAd26jqhbo0PGgQZAtgxql2xB/ABeM2
 6DMrJw7awo/ZdsekaSXYGmtQnEsR1pYzVditV1IXkmZR2uaPGgp3nqKdHJe2PxAnqJnF
 tbjsnTnk9vxoG7ICTxp6t1Eg7KdGB2qI4awtctnKQi0R91KWEu5z8X/xMkv08vHlMt8w
 EO+lajLT4RtRUuY1szCci2GXqkjvWwwmky2xX3IzHchg9US4n0HbIISBhitH8eY62zFe
 Wxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398705; x=1703003505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VzQTFGtBulS+CCTLCLD2ExWe/+5Y5bIpgcbR//mYas=;
 b=bXbHswNl6AdUNydVFyWbP0ntnpN3W+oc9i3rnFHD0h3/L6NVDdVj80bq5nCmBAzg4H
 Y5qCK0OxiCf+sGFriprjHUMx62ZJYwZdsaImO6+hpB84zQGXTaYC4afjI2CLWszjgOyh
 LeOgSk4924AL30paIvbPimL0Ahz/JjkJ64tV6njR5CBpsUkykFAHHsD2xIZQXdTH5QoT
 DLEJ1K2PuhGgbIpgjjovsCSq/frN4abp0xYFIQP2co66WKNc1vRrSt8w4pG+7AYG4kX+
 Exe/0dIHiMIwpPSeboDpLHbeDlQ2TlSTPPxvzzvabE/STb1OFwvL6ewNs2aleCldVCaf
 4kdA==
X-Gm-Message-State: AOJu0YyrOfTxgDg+C8H2fKjwWS2fiuJAT73XLjz07U5Shf6vrwut4lLN
 R+UpD3hD0NdoW48Mikdh0MmVBGGxaLlMxAZxSZY=
X-Google-Smtp-Source: AGHT+IFBnm9rAQDi2fs5vLvHFewLB/RO8lqaDp/cJ+jC29KN9FDAkk2MRVDhxXxGADwABnMwfReOcg==
X-Received: by 2002:a05:651c:231:b0:2ca:cc7:d1d with SMTP id
 z17-20020a05651c023100b002ca0cc70d1dmr1243530ljn.194.1702398704821; 
 Tue, 12 Dec 2023 08:31:44 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 dh7-20020a0564021d2700b0054c76d0f755sm4827776edb.42.2023.12.12.08.31.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:31:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/33] hw/cpu/arm: Document more properties of
 CORTEX_MPCORE_PRIV QOM type
Date: Tue, 12 Dec 2023 17:29:17 +0100
Message-ID: <20231212162935.42910-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/cpu/cortex_mpcore.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/cpu/cortex_mpcore.h b/include/hw/cpu/cortex_mpcore.h
index 4697fd47c7..73627bc415 100644
--- a/include/hw/cpu/cortex_mpcore.h
+++ b/include/hw/cpu/cortex_mpcore.h
@@ -28,10 +28,17 @@
  *  some timers and watchdogs
  *
  * QEMU interface:
+ *  + QOM property "cluster-id" which set the cluster ID and its affinity.
  *  + QOM property "num-cores" which set the number of cores present in
  *    the cluster.
+ *  + QOM property "cpu-type" is the CPU model typename.
  *  + QOM properties "cpu-has-el3", "cpu-has-el2" which set whether the CPUs
  *    have the exception level features present.
+ *  + QOM properties "cpu-has-vfp-d32", "cpu-has-neon" which set whether the
+ *    CPUs have the FPU features present.
+ *  + QOM property "cpu-freq-hz" is the frequency of each core
+ *  + QOM property "cpu-memory" is a MemoryRegion containing the devices
+ *    provided by the board model.
  *  + QOM property "gic-spi-num" sets the number of GIC Shared Peripheral
  *    Interrupts.
  * QEMU interface forwarded from the GIC:
-- 
2.41.0


