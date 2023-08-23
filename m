Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4CE785368
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjkw-0006u3-PN; Wed, 23 Aug 2023 05:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qYjkf-0006lB-Ow
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:02:11 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qYjkc-0001gn-I2
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:02:09 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 360715C00DC;
 Wed, 23 Aug 2023 05:02:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 23 Aug 2023 05:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1692781325; x=
 1692867725; bh=R5ooKiIuylaaowGGgydLdGlhTaLyjGKEEseXK53c8u4=; b=j
 QXm6oN+0/DxvnJ57dQa4oKcJW/iNnzqx29xlr8Qe/cbD9J0Qh+k0fGRiscXvF7fu
 XAih7JRs+jTbhnLaoop4AVe/DuqKpXmzovZxznMmrP1/c4VqMEZMPp/OgV1uB/GY
 h1VmwX4W2dRdqU1b+l7M+aNXTo8NG9TGYE4ZeeXN09uKbhlgnbcnYfuZZl0VTXvn
 8KEoodtxIiTXmtEV1ssVLIIyiayfybD0YWYO406AYohHFm/5xWaV4c9OTo2iTA8t
 Y59ySMQFakbdCbTkI94npGLV5M8Oil0AVWHAEL/06gXS6I9M64e2fsbP8wYTIadz
 xxrL/0KuUrSjsTQLxUKaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1692781325; x=1692867725; bh=R
 5ooKiIuylaaowGGgydLdGlhTaLyjGKEEseXK53c8u4=; b=jq/6VeDkD6fg0fJPH
 54X3b7Dyg3Yu+8XMfn7iO+PE+JSLzlVtBaQBqYyVyOlAhHnW0I8TNe4C6kInYV6G
 Z+6kyjBlmngXDIt/BY7S9ysxF6pMRHI6kpN1xqbpwvYu4HH9FY6WyRdXTl8KXc6r
 QPLtFvdVuXiowAjg8nPAmZUFboh7Rbx4Z/YD4vkcXf/LaNlZq5k2dYNMlKM5jrUG
 h4FLFFNLJG0nUzPbR0ey0963YZeQgJeBgN21/K85Nph9A99RpYsYMb83Hesh3uNZ
 JXlkxPOARi/aluHObPixCmq0wNH6vVQBwseNMOZe+rj94pzcMYzrJrTpMh5KidME
 3FLCg==
X-ME-Sender: <xms:C8vlZNJRX0ko7vxE3910G149ILryJhvrJh7U7Nx6tw6Dx0NM80JMfg>
 <xme:C8vlZJKeprJpzB2sOVEMQVvnfWdKo8RkZlOSi_dQtiauNquyHjY9P1jv6X_iJAyRu
 1kID0nIj7CO3UlI0Iw>
X-ME-Received: <xmr:C8vlZFsIYYUEHLCZiA5xGjRswRgLgeJamRDKzqr8i5a0ngk4FW13XEsMkFgBiBj1DNVWUhWmdyUQP1rgKDsBWmGXZks1gG8q_D1vskusqFdMVbeOXmaEpb6ueWyV_sSIcg_Wfjf-d4iJ_xxZ8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgudduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeffjeevleekgeevveevudetieeiieehveffffegtefgjeevjeehledvteffkedt
 ffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:C8vlZOa8mdrGzUOeBbjq3n4ubxsCmKYMzrwMOd1ZxmJj4bW5DcDh7A>
 <xmx:C8vlZEbWdwddWP95aIHSk39EIScH-Eo5fW3PrcpAxSew3zaQkBJ7uA>
 <xmx:C8vlZCC895U5sEKFPdpISgjunWyWrZ79gkmWfhBSj6Cp52f4KRTi0w>
 <xmx:DcvlZKO9nsCOyY6DwqL33evfIySyvt3n6orP7DRWLo1r-tyceZyPnQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 05:02:02 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH v2 0/2] hw/misc: small fixes for i2c-echo
Date: Wed, 23 Aug 2023 11:01:44 +0200
Message-Id: <20230823-i2c-echo-fixes-v2-0-ff404db1bf99@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPjK5WQC/3WMQQ6CQAxFr0K6tqYMjgFX3sOwgFqgCxgzVaIhc
 3dH9i7f/3lvA5OoYnApNoiyqmlYMrhDATx1yyio98zgyFVUuwrVMQpPAQd9i2Fz8kz9QL7pPWT
 pEWU/snNrM09qzxA/e38tf+vf1FoiITOT787k6oGu1s32WsYjhxnalNIXc2KuUK4AAAA=
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@aj.id.au>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=712; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=zYYjriKQVobzQtdt8AIJPXlI5gUqeSQUBeFOrtq3gyY=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTlywk6FJYtfM51ocGx45gI+rpncfjrqZPyp
 3ZkcLacinCxs4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk5csJAAoJEE3hrzFt
 Tw3peyAIAJgQkIyym2DFK6Wr1Q/8E15eLaZQdzRNGFmdpOPxOTX1s9tLGp3FobIKeeHATpE87ya
 lecWJajXzpB2zhwg2kL8lW03sASoxjxxKl9TTd3d1pfQTvCeMaIcoa+2M1x1WO4F6kfH0AZWcY/
 YsfGtnV3iWfH+Or1EKT87KL1z7k0E0M4Slf+5L4yO3bQ8zWIy4PLMCY409d4sJo7fpj+zn+hnzF
 t1loNyfuuEb8jRaemkyWkUh5nOzL4xKP7zKLLxqJJEeQCGOnZYdxf5dioVS+4eajkUEjW32IkCm
 KZ2eiiDHnRJNmoHeznXW8o4gXDXZzZsyKzDoFgVTjyQ16UlKZyENRafV
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

Add missing copyright/license note and add a Kconfig entry.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Changes in v2:
- Use SPDX for license note (Thomas)
- Link to v1: https://lore.kernel.org/r/20230823-i2c-echo-fixes-v1-0-ccc05a6028f0@samsung.com

---
Klaus Jensen (2):
      hw/misc/i2c-echo: add copyright/license note
      hw/misc/Kconfig: add switch for i2c-echo

 hw/misc/Kconfig     | 5 +++++
 hw/misc/i2c-echo.c  | 8 ++++++++
 hw/misc/meson.build | 2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa
change-id: 20230823-i2c-echo-fixes-945c0bf059b5

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


