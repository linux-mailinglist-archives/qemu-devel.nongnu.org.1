Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD274785369
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjku-0006u2-N8; Wed, 23 Aug 2023 05:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qYjkj-0006lt-RE
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:02:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qYjkf-0001jF-H0
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:02:11 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id E15D35C0165;
 Wed, 23 Aug 2023 05:02:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 23 Aug 2023 05:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1692781328; x=1692867728; bh=vSBvGzxgyAhnUvesHRh16JC+o
 ijj3Egvu8YzN/RdT1o=; b=FOXzkrwL9quJkE8bK/+KdgDPO3SScGRUEBOzOWH8N
 5RZm+N1bN9KBnb7kIDVT/861+8L+YyzRWNbb56cYPowa/aRnAGNlEd8eexjKwmOb
 udyHPhVB38pWdT4hE9mNFEls0sozhevDk+uR31Wfa7j8QjraKYdxIx1m4cUc8k7K
 oHkx56LVLQfVSMbWElooXvg8KJwNyHAhQ3/dckL/IB3lLwGvZZHvSEn8mT1+Qyd+
 qip5GCD8dB6a2qBfJzrHt+okuj9nJdnT3lNw8WE9/HNmQiRZ67c1zEp5azSEehIF
 9sDCzqymBKIPOZdpxhjOGBLAr+65TPkcl6AAMVFJzU/Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1692781328; x=1692867728; bh=vSBvGzxgyAhnUvesHRh16JC+oijj3Egvu8Y
 zN/RdT1o=; b=uwHDiedNz9YLOaMqcEEqvtM0380nYPulz17gK8dKDrM9DKhjsda
 q6r46HFYuqMoS9n6lY+dpUd/a4t88aB45qvnNoC61vZyBSlYTwXiTA3NeKLNMabo
 iAGdj63vEOhSNpKf50dd4m+4XHA5/3svOz5f43er+sh/pBgfhLViUaL27KL1dZT7
 c+xcVGNNSddSYGG+EJGI8fqHaX7OrgQTLwOh9XWs9G4jQdNKH9xkeKyuFzlk5Y/3
 L9S77oVkcvn4ZWHt2vasVzzKsZkCM8Lgzu5CJlCrL/vMZHMkW9+cFLhcVTtQTnvL
 GH1XCcVyWgDUFx4PTcciLXGXYRXk03VCdNA==
X-ME-Sender: <xms:EMvlZO1u0h6gNzfSO2mN-qjB7fx4t_-SvvOeMiNVwjy59GiNX8wgIQ>
 <xme:EMvlZBFFtD-FFem-_C-dODUgwQsgzyHM0-DpEB4os-OKD4yoiqVa98b-Q1S3Fvw87
 9npS71yaSSZCPD-2AI>
X-ME-Received: <xmr:EMvlZG4G23Zx4tz50R9UAxJHeEVi80EGVahMQfzZcHdhMW7Ldnqg7oeoLaEQtowGCXm95IY0BQd3MzmZPqEft5y5VzY4URVsUL9N8JDCmVPUZVYe2zXbvLvZqJOwr3hSmlYfpMiHhkjpVNfarA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgudduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeekiedvtdeuhefffedutdelfeekhfeitddtudevgefgffeiteevfffhhefg
 gefhffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:EMvlZP38U_mCYPBlBilqyMttOW9KFReaUeE3AIPWzWVbXXXgDFuxYw>
 <xmx:EMvlZBHKjXksPhwykFLQsbHXlmverzQUXqsvlsOBqBJLr-CYq6pscQ>
 <xmx:EMvlZI_rfKtzQLR0MGJ8hWFvz6ZXbdoM41fGafgX6ncVV3rKYys8oQ>
 <xmx:EMvlZHZmMEU8w5K4qRrik0i4sz6G7a8xLrieKv5E6Xv6qix7ITtkbQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 05:02:07 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 23 Aug 2023 11:01:46 +0200
Subject: [PATCH v2 2/2] hw/misc/Kconfig: add switch for i2c-echo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-i2c-echo-fixes-v2-2-ff404db1bf99@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=1r3ywVqF6LXS7a3DDFRj7cXxeh5U8TKq5l5QUJn44yg=; 
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTlywohXfC+zWYXwFeU27u/xbzMIgZ+FfSsf
 kPBA609Qmnu7IkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk5csKAAoJEE3hrzFt
 Tw3pHuAH/0FZU6WjmZEKzyp5yV6pdob8+OiWU8JKZGtB5ByRcdiPnM3YINjT9P4AaPqC4hlu7AG
 9qy8V83Mvqs5oCsNrhW6+Xr1eJEJ1Z/y+vVn1wGPDh8lU0usF/MT3o+jtKQ6ijice1Uzo2JPw0w
 H/iSZZbWkFAKp2UXOUaCc2/Rze5mzo/b2pCl1DGBFuDd4uqHHvK6nPPZzK8Q/WP0UvD7+EkQnGA
 fzPpy3WlA8yiCqN00FLlEs5cfgws/e3QpTIRLVuVeHT2hrjPNpv7mL3xTVKFQE1AtA8KNJvOuzd
 VC7x3Sr1po9lF+pT7n7tyijwdXnH543ZfLiMuGz/XvibXcLcdK0gbLVG
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

Associate i2c-echo with TEST_DEVICES and add a dependency on I2C.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/misc/Kconfig     | 5 +++++
 hw/misc/meson.build | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 6996d265e4c5..9ec7a40f973a 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -34,6 +34,11 @@ config PCA9552
     bool
     depends on I2C
 
+config I2C_ECHO
+    bool
+    default y if TEST_DEVICES
+    depends on I2C
+
 config PL310
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 892f8b91c572..fbea23f8b27f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -132,7 +132,7 @@ system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_rng.c'))
 
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_ahb_apb_pnp.c'))
 
-system_ss.add(when: 'CONFIG_I2C', if_true: files('i2c-echo.c'))
+system_ss.add(when: 'CONFIG_I2C_ECHO', if_true: files('i2c-echo.c'))
 
 specific_ss.add(when: 'CONFIG_AVR_POWER', if_true: files('avr_power.c'))
 

-- 
2.42.0


