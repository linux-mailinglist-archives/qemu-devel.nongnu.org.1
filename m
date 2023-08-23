Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7B578536A
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:03:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjlE-00072O-In; Wed, 23 Aug 2023 05:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qYjkj-0006lu-RV
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:02:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qYjke-0001hG-Cb
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:02:10 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id D32545C00BC;
 Wed, 23 Aug 2023 05:02:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 23 Aug 2023 05:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1692781326; x=1692867726; bh=SWryM8qJbSZUbBEaPcvF4vOpv
 h+S9bV29xIlr2wRCEI=; b=u5gWEm5AtlhJ+79q9lj00Jpjr6Mgf9sxBkWS7Tbyi
 hVcMpitAuDrXPwBEpXIp6QFTMnPmXAgsCv1G7EcX3Jwufu2nLlHkOqwfDgWE3BDj
 wAjkxHQfWeVKxPrgHPw/L52RmyFqTw/79dRQbjDtZOUVX3LJE/GwgsL1uuP3eYdy
 3HK3Yt5rmO6McY80qOtj85Swg+1fKXGT4eEsPcWTIjr5Hg1DllD3TrzeJ+r3NPEw
 +p1RTSO/NQKoEU6CKISmu3gERNiAQDdQ5DGqDQmI3ujZw4fh28bjpQnDNxSE1QF+
 P/ku/leEQQayeIgdyDPhaHZ8T9bSmq09/c85IAUUx/SJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1692781326; x=1692867726; bh=SWryM8qJbSZUbBEaPcvF4vOpvh+S9bV29xI
 lr2wRCEI=; b=QP8A5wVuGdouMxFhc//TEHXOMo5yaLGXVp138iS5mnOAnOy55Uk
 PIMWu8yaKXlce062jjsTEKS8RbLRJh7xsCCBWmVN47htIAUbvnGtK3sKT2Al4CVW
 FQpafBRXT/srw886KKtbQ8pfUmtD/zxsASLwyjNkQDV7Pn/fQYyLs//AeJPnKMFK
 A67BSuBoIPfBRmUJFWCa0SgDp64TzvBoNX9TkUxMg26T6Vx7S13/L4EHPCC1Ddzc
 8Wk8H1OkxRtTrqzRRylOUrwv9T7ofP2IJAMazSaeEwQa+q5bU+IFifHq38TibPAX
 Tv5mu67m8Yg/tceVk4xcXQyG7gG5ngcQIZQ==
X-ME-Sender: <xms:DsvlZMBoUpVHOnZN5O2fNnOOn4G2c6hjJZvls-cTl-130wl3LWJVPw>
 <xme:DsvlZOg1KfczVVPHWIrc1Hbg9PBW9wTRB-WJlVyvrtFipcuXMGkwBurWSQ6hMMEFL
 rJCUC5XnA3vV6cYF8M>
X-ME-Received: <xmr:DsvlZPm7OhxLzTDbOSf6Rx237yVHyWQUARBb4N9IVkJ6owt2iIodnHu-js2Aerg0BVdMzid7DG6Il1XDc60o5RKAVNv2bMUQAw1_85-xwiaLMGgFFgyhtQWkuLavamnGoFNdqSBUxKpTk915BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgudduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeekiedvtdeuhefffedutdelfeekhfeitddtudevgefgffeiteevfffhhefg
 gefhffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:DsvlZCwrU0YWrM9B8T7Bbo7U_OT85S58P9YFC1V80wXJp2zHY-kadw>
 <xmx:DsvlZBSuBttBVxCspymoD2oBbYq0mUGROnjToYZIE9V0PcSwcjguIA>
 <xmx:DsvlZNaylJUIkGLrQus_0v2R8KsAPUBaTs4KYixOJ4MwLa_vPUpo7Q>
 <xmx:DsvlZMGU5GSF17Rz9m9Gh75F-vrpCXviQit5z7V5712aVHv_5JwlHQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 05:02:05 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 23 Aug 2023 11:01:45 +0200
Subject: [PATCH v2 1/2] hw/misc/i2c-echo: add copyright/license note
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-i2c-echo-fixes-v2-1-ff404db1bf99@samsung.com>
References: <20230823-i2c-echo-fixes-v2-0-ff404db1bf99@samsung.com>
In-Reply-To: <20230823-i2c-echo-fixes-v2-0-ff404db1bf99@samsung.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@aj.id.au>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=678; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=8znLwL+kaz9D8g+Wg+lXO/+Bz8SVXSWIO3uRmjQ7FlE=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTlywrcZ9MoXRmZVa5rWtAOThEaOTOKLRgKv
 0MKr/Eqr6A1IokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk5csKAAoJEE3hrzFt
 Tw3pqCkH/3918BrWVjNacKUFGYgo4pEbX+uvlkqwSNGTe+lVM5XUhxXHrTVgk4s6w3t2Nzs0FLv
 P1Bgd8E51ek0yiSq7NnIiOrMxOFwoK3jmv6XjXDXxhebapZgHk+3MCaQMjbcw26tP/D3Luli5nR
 3IopBed1yA4v3+cOWBF5WR031SOe1w5prJJ8cAvNkR4LzQtXoYGksCKKujWEB6VY2fTCuN/DlM9
 +irzPL4jScj+3NYsE4Floguk0uG11Vu72iiNS50c+kO6wSyYSnIrzuKwR4aZQMc9q3tYNsWtYsf
 0UKP10mUCD1O0Py1KfrUYMzY4hz4M2uSflz5o2EccLnP2bmY5rEKk6mE
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=66.111.4.25; envelope-from=its@irrelevant.dk;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/misc/i2c-echo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
index 5705ab5d7349..8ee03cb5632b 100644
--- a/hw/misc/i2c-echo.c
+++ b/hw/misc/i2c-echo.c
@@ -1,3 +1,11 @@
+/*
+ * Example I2C device using asynchronous I2C send.
+ *
+ * Copyright (C) 2023 Samsung Electronics Co., Ltd. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"

-- 
2.42.0


