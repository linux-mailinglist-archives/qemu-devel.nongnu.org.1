Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF88A785285
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:16:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYj18-0005C8-72; Wed, 23 Aug 2023 04:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qYj14-0005BV-SR
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:15:02 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qYj12-0007Kc-VE
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:15:02 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 7A0165C011B;
 Wed, 23 Aug 2023 04:15:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 23 Aug 2023 04:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1692778500; x=1692864900; bh=jhwNyHyRRRG9aluKIDJ/n0qde
 iNlyRVnmYvsSGpCycw=; b=I41gAF0LeTKWtPU9KkewVWW1ODpDtGJ7lgrjE02ty
 MpySUfS9i5mtQtPNoCCI8bMktT+xDpQxXSQOwrvw3BMkqRD0Zjy2+gGgOjgx+5S0
 ndOS6xzCFqLQ6oAMryLSwN4v86Eu0XR7s+JZ4GAZ4pWzN/1+U77XnQj25f64YXVD
 O7LbcZ3bsy0vkagTs19AZlsQCNRhjR2FQtY/CEJmAg86EGLHsZPGPcnd7D+gelIg
 IZBdAtgLvk0xANtpgzIDJgBssTbAi8ZLtIqsKuRPdoJOY396oWxDJyGOxQoCW8Sk
 +GnDMd+LI1UGzW5FmD3YtDbyLzcxE/rtJLkpIDEo1aMQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1692778500; x=1692864900; bh=jhwNyHyRRRG9aluKIDJ/n0qdeiNlyRVnmYv
 sSGpCycw=; b=rRbIcP0Z1qDKHc20g8+MGjy3IND2o71cmUrEcgjRDHhdArqY+aI
 ui/00BY0sAkNLEHhqRl3sbDoIMz5ArfChXPryCMmXJ7Q0dZTqZU5++63H+EXd7xg
 Q1JRzHDsVnPZSUM1GKXLAFnV96RUhj1tFwNfOwI1dHtM3PYBKK+mbOmc+n0tP4eK
 5NVEh8SNt4aPbjLgmdje4O/1DXeJmpBJXKCfSl7lfq74wSzA/1jBOzN1H/z5uFOb
 7AOmj9ZlgZpoH0QXknrQfIjd+6sSdThGGIoGGHfCnI/i6anMqWQQTb8Scm3i5F3a
 nrPuW1bcv9NzKcKx8fNGChb7H/kK6K3rK8w==
X-ME-Sender: <xms:BMDlZJe8ATPRpRX-kDxr0_uLvdCm0ecRs8c60VFOnpUL9PC1E5GzSg>
 <xme:BMDlZHMSV1wDus-8zLa9Ga7w7tmfYtOxdkI0_7PVTy5ZgLdFHC9ZLZYuv-hJTLLeC
 3Gaff2SIeIN8q_SoYQ>
X-ME-Received: <xmr:BMDlZCiFCj-6NTX-tWGXXDFzrJViG2m83eGgsc2jFS8m-g2ueRWTMvm5cAAE4QM2eTk8hEQeGjPXt6MYeCdG3E72Wipc1qk_PaohMfU34oJrULSy93-JUyLBgC4pyEd6vfzJCRkTkuJofiZGOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgtdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeekiedvtdeuhefffedutdelfeekhfeitddtudevgefgffeiteevfffhhefg
 gefhffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:BMDlZC8O4ADtVb1nrB8wI8fWDjiEETIpUBEzXa3AAA6VlST9NxVaDQ>
 <xmx:BMDlZFsIvL0gtxWxIhAYvNiKVkTJPsyOJ96NtOs7EQDpae_yGEqmBg>
 <xmx:BMDlZBHtW9e6C3GCxireOzIWdCFqESgHCSGHtWjSFNjj7V4UctCgyA>
 <xmx:BMDlZLAHhaTY94QumOR6fY-UbeKGUYkK279UKyttJg6_oET4xQEe5Q>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 04:14:58 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 23 Aug 2023 10:14:42 +0200
Subject: [PATCH 2/2] hw/misc/Kconfig: add switch for i2c-echo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-i2c-echo-fixes-v1-2-ccc05a6028f0@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=AcC97RiaqAaF4qr7Ep5XurAhP+6NlkkcpwaIx5o6ssg=; 
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTlv/4sI+ufH/UgsT+loUA3HlHPTxSRp8jat
 IMjZW4mnhx4ZYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk5b/+AAoJEE3hrzFt
 Tw3p1XkIAKlbExVyx/0oVb0x+lObGZdN0qju2D31lreIXRBkOnII6/AbqA+YDLlpWC5LlpqFeK4
 KyIksbtFbTq/JgxuziFRbn20ZtKfv9OdMfqKmpJlPPe6yfJqADXKnYuFHpBNtNc29675HMYMo3w
 JPcBfqRWojCXu41kl39WPbb4QtMeq4P2S6t557+dRt+uj2u5UaRFzfHHUyklz7C12/W6kAxYy/U
 J92KoeNPUcbqHZWzCc3WXTeCXWCjLnkEdSuG+Clw3Dr6WNN5FEcxIZh2VLzJhQIe+wknyYts4kX
 guvRFSFHiyt130acV8SkY3O6GX+V9vs+qZ8ehGrKcRegO31ZPZqBZqkY
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

Associate i2c-echo with TEST_DEVICES and add a dependency on I2C.

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


