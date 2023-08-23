Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8547D785286
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:16:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYj1A-0005Ci-AY; Wed, 23 Aug 2023 04:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qYj16-0005Bf-8O
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:15:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qYj12-0007KG-Pf
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:15:03 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id D1D5A5C00C9;
 Wed, 23 Aug 2023 04:14:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 23 Aug 2023 04:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1692778498; x=1692864898; bh=RCqOBsIHjHZMA8PalYDvZxs4f
 tUwtAoCXBOYmGnaIP4=; b=WQJuookFC4jfjjlrwGpLs3976qA2xXxoWdPqpgOZ+
 BXHti5aqNDkfSGG0WLvnkqGP/Mu/lBTCLd4Yys6+Yrfsn3ShlY3kaw1ztJ4ZAZxG
 GP6ZbhBptBfl/KGqfJXL5xjGV4vI0HIxG4xT0ZMQKjY9XDRQzTOtmhu+3ROHo8gX
 QNtbAl2ZbvidTetbQ+7x6tCRSftcpPXhKVBOzQ7bzvTmZNcQqZj3V6irGgTen1AH
 sxQd6pYVBovfOAyIz9VepQkw3szd71ZrP13/h8fzRHAvzkuUrUma0t0vMrvLiXXH
 Iy7T3KOOMI0EKpyIopzZSqEvUkwZrWdWYD5tQJya8g+8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1692778498; x=1692864898; bh=RCqOBsIHjHZMA8PalYDvZxs4ftUwtAoCXBO
 YmGnaIP4=; b=KYat+LJKU8liXemvdpixnxf64BvN09wfb74YALOQT8DKqjTEcaU
 ZMPQXiHH4UkE8LhVC1rh834TngK4cnpWcyIpNQgOaBeiKPc9OuNEWJ/2ZhewdOEs
 UzSwOk6jJbwrT00c2v2YEyeK+w8rp8FarQIPQBtRn+TGzihOEeKnvkaq+YxZKd5X
 rno9usNgquGLBOz2xEQ+fN8vMn89v9fyY6Kqdb/zYChrlhr8JX0XU3wZPFOPXNuG
 lsBU/O3Tdrh8Zby64Dslx+FfrqWN8bnmKZ9ETd/eFHVRAlNRvPV8oV79StPTMcNO
 kgNGtK7afV3Ymn4XqEIkY9nfbZ9R0IZEVbg==
X-ME-Sender: <xms:AsDlZPHaVlhIW-0_PeVgqnMslDcFwMyQDj6Uy8RRU_C27bfFAKlWqQ>
 <xme:AsDlZMXa0cE_13BbX2m75vgqdca_fbj_MjtM0MNtrktolXBR2K93n7_2EQpqGVKgm
 v36TsbQ3p_qj5wD7_c>
X-ME-Received: <xmr:AsDlZBJ844uwk7cNc_MyJZV4AE1wJKCRnc2ndOow_FvFRn9pCOam2XLPQR5mkLznB0zQkLRsjJR1d3IT8ciA7AQf8I5zgIaVzUiN0Gh3dQla6jk3SzluztFNnL54gYOruA45nd1hqwswMZWkoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgtdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeekiedvtdeuhefffedutdelfeekhfeitddtudevgefgffeiteevfffhhefg
 gefhffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:AsDlZNFrzzJfyh6OittBFX_A5uMzM3OKkkBEmBaWUPkiL8v-yLAR-w>
 <xmx:AsDlZFVyHtwsobW5nFX108tkMdZsu3odTM_WTOOuxldx-CzI0x29Vw>
 <xmx:AsDlZIOo8bAb0Cr1AEf8rGfxz0nNeNZmIuuvJ2zPflAcuMmXwtXFpg>
 <xmx:AsDlZBqNkXv-hrakslOfVhY-A-d13qbd9bX49IRHnmqecN2_mKBVQw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 04:14:57 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 23 Aug 2023 10:14:41 +0200
Subject: [PATCH 1/2] hw/misc/i2c-echo: add copyright/license note
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-i2c-echo-fixes-v1-1-ccc05a6028f0@samsung.com>
References: <20230823-i2c-echo-fixes-v1-0-ccc05a6028f0@samsung.com>
In-Reply-To: <20230823-i2c-echo-fixes-v1-0-ccc05a6028f0@samsung.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@aj.id.au>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=765; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=LZETYbn1C3Rfwlmbw2Fej8c1UyHcvkZtJb/63qF7A00=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTlv/54TvgAksASuqTw0e+r0YB721KmfGe2c
 MKEtdGblGPxZ4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk5b/+AAoJEE3hrzFt
 Tw3pMwUIAIBraSkUhhtHVQ+z1rPKzfEJ+szW4LyB08nvCthW/q3eUxe3BJpqj+SWhDLlBj3lC7T
 b/HyaMnwurTlcQfcaW3HCVhWJ95w9/GOUYAMpzathSr0VoQkvBx8bGTKQPp10IcXu1ale7G6sh7
 L0PeNHIE49sRvO/kZBiomcesK4rBiDeJppyOkx5dm+XHfrsGizsIfb9HV7gYq8dhlWsvhkeOvp2
 GksXZonDW5m3/GWS2CMCJmrqvhFPk0gh26KBkpqBMdxlHUIdgNN2Yv01j5p+aQKzvn7IAZXy9nY
 cBmmQKievOENiP3yfdo9pNDYE1h995guOwU2U6Pil1d8WqHCllXBYLHd
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=66.111.4.27; envelope-from=its@irrelevant.dk;
 helo=out3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

Add missing copyright and license notice. Also add a short description
of the device.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/misc/i2c-echo.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
index 5705ab5d7349..5ae3d0817ead 100644
--- a/hw/misc/i2c-echo.c
+++ b/hw/misc/i2c-echo.c
@@ -1,3 +1,13 @@
+/*
+ * Example I2C device using asynchronous I2C send.
+ *
+ * Copyright (C) 2023 Samsung Electronics Co., Ltd. All Rights Reserved.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"

-- 
2.42.0


