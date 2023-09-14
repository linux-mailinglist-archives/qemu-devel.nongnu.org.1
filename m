Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F727A00F2
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 11:55:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgj3C-0001Ax-OE; Thu, 14 Sep 2023 05:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qgj38-00019i-Uh; Thu, 14 Sep 2023 05:54:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qgj36-0003KB-6H; Thu, 14 Sep 2023 05:54:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 02C045C0750;
 Thu, 14 Sep 2023 05:54:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 14 Sep 2023 05:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1694685249; x=
 1694771649; bh=tuFXEEII/tmWylE1Um8EDWh81HZRCeIad38oMIIuPE0=; b=k
 odYiBoRbotVqJA6PH5BvJOkZGJN+SP+EpzqKXDKtxPocXxNdMm9w/xIap1tZpgV9
 64YwUaP5NbkY3AhvAOersqP/OUi/A4fXnqGcQ3vOzvgp5PBqMZUYy4u9xecM2cWM
 dYxOefT5ju7mrqBO7DAct25Nbjksmzkq53QbBDI9Tfnzoz89c/aCsJsogieYxTIM
 JtDGBLOYMsAEqHrnFdeokRbE/Daz0Dhp1jWZUAXbgcixgNA0P281lfus/L08+RRI
 ISjgl6k1sM86Ac+pxaOtocL5CNv5pwjIWQ3divv2e94SUaC7gwFoL/SOTKf2IlOs
 87u0nr3wqOcxo2/Lm9LDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1694685249; x=1694771649; bh=t
 uFXEEII/tmWylE1Um8EDWh81HZRCeIad38oMIIuPE0=; b=BbeQj9YRXQls/ohR9
 7XUZe5/KT70ivp7IgJ101BQAXPBvzCb8DbmEoxnnKG1T21U9AjQyFcPdaIzgVc2/
 thrdgH8Vl9zZQwt7drHJSYlX3dt+TdO3QgT0kE6x2PL30JIe/AlwkHI93Q7ZbTEB
 XaMu8PUEiX4eSUXQzgZqNYsEMi63A+LrTV5NrjeA7yd62UAfV/v17mWPymIxPOQO
 hI0zU1T+oUSJFaiX1AaJ+XBiIs3M8MDF9gKVsjSMNUALxIIquQ/8GrVtp076+kQw
 a9WlLiaShWolT+IYS8ehlSLZGVdXNiwFs0dRzQAaROEagDCgj3nTJkEyEKtxuXio
 t/OnA==
X-ME-Sender: <xms:QNgCZRwblKo009LtuNiIz9w3SfYHrv_Jg0q1PtDvwyQZNKlPXtjvxQ>
 <xme:QNgCZRTPMD_7AfdN7f5nawVA4kfJ7ww4HgCWzGIJzVTUHPxvhMqHdOV9wYNrfvo_h
 H1o7N8Rxf0bohyIxcY>
X-ME-Received: <xmr:QNgCZbV7pPdp7a0-hlX6JO1_QVfFh96Sz33Yz9tPffrT092C0anMarc6IQDN5U24ppJKUHtobyyCElPG1a4rUdaZTyVkwo30zmRRs0ODYjzBeBV7UDswoAvmsc4oK_M_pAEhxSRTqD8l8LAJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejtddgvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpedvfeetudekgfdtteduueeukedugfeigeelgfdttdekhffggfelveeuffehuddt
 veenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhr
 vghlvghvrghnthdrughk
X-ME-Proxy: <xmx:QNgCZTi27H3FO9UE1lwtSD7QIIlf0GBoAa1Qv9_c8OpG5wILkxckzA>
 <xmx:QNgCZTCqYxFsBo9AJHinK8ylFF3pPiKCDbRENCuj5_rJo_o74Ojq_Q>
 <xmx:QNgCZcIyfferVbHMAyuRFIakbY-RJjOP1_GJysXdpaXTx67JGtEw9g>
 <xmx:QdgCZbYVPeT8_uu3dhCYBJfBpneUth9dVJROeFFD9abzkRpAhKFruA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Sep 2023 05:54:06 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH v6 0/3] hw/{i2c,nvme}: mctp endpoint, nvme management
 interface model
Date: Thu, 14 Sep 2023 11:53:40 +0200
Message-Id: <20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACTYAmUC/1XMwQ6CMAzG8VcxPTtTC4PpyfcwHoAV6IFhNl00h
 Hd3kCjx+DX9/yYI7IUDnHcTeI4SZHRpFPsdNH3lOlZi0wZCytAQKTeIEmqUNZiz1TWXXED6vnt
 u5bVK11vavYTH6N8rHPPl+jWynxFzhYpqbE3BSSJ9CdUQnq47NOMAixL1Vp5Qb6VOJSIebVZSV
 ZL5L+d5/gC2zeUs2gAAAA==
To: Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 Keith Busch <kbusch@kernel.org>
Cc: Lior Weintraub <liorw@pliops.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, Peter Delevoryas <peter@pjd.dev>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2758; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=CXfMJrx3JUjcAOjBsXpN3COBAumITS7aToglb51KKsM=; 
 b=kA0DAAoBTeGvMW1PDekByyZiAGUC2D2jNORQ9z+V1gQJcnu10ZQq6xKkoK04DUz8wFOCNIo8h
 okBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJlAtg9AAoJEE3hrzFtTw3pPu4H/Rag
 MfXm9ONgHx8dYf7BHkjmQ3w6jk4HIe+oi7/kpXK03LeDcPpyFDSiZZbWmgCpjccuLgTkY1SXqrc
 ZqLsF1cVlY3EvYSfgcP95CTHKZ4x+YfQsOx052o49bMa+tKwUXK6acPc46rTA97fEgGwa1baO48
 xy+b3XtcoE2bFjffh3YN9FZ7nVmTmsTJorX1OaoyNDgaZgPBHmcb1pfzpAM6eSYCtpndQYw4AKZ
 UbXpVZ3rjah72Jv35jspWusuQMj04INCpFiOsNukq+iVYWGxtEcp089qOkRXdFsELyHfeRTaMZj
 Kar9TMo+9W1ZDcBUP7GgQE3V1QLrS5HDOMWyHkk=
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

This adds a generic MCTP endpoint model that other devices may derive
from.

Also included is a very basic implementation of an NVMe-MI device,
supporting only a small subset of the required commands.

Since this all relies on i2c target mode, this can currently only be
used with an SoC that includes the Aspeed I2C controller.

The easiest way to get up and running with this, is to grab my buildroot
overlay[1] (aspeed_ast2600evb_nmi_defconfig). It includes modified a
modified dts as well as a couple of required packages.

QEMU can then be launched along these lines:

  qemu-system-arm \
    -nographic \
    -M ast2600-evb \
    -kernel output/images/zImage \
    -initrd output/images/rootfs.cpio \
    -dtb output/images/aspeed-ast2600-evb-nmi.dtb \
    -nic user,hostfwd=tcp::2222-:22 \
    -device nmi-i2c,address=0x3a \
    -serial mon:stdio

From within the booted system,

  mctp addr add 8 dev mctpi2c15
  mctp link set mctpi2c15 up
  mctp route add 9 via mctpi2c15
  mctp neigh add 9 dev mctpi2c15 lladdr 0x3a
  mi-mctp 1 9 info

Comments are very welcome!

  [1]: https://github.com/birkelund/hwtests/tree/main/br2-external

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Changes in v6:
- Use nmi_scratch_append() directly where it makes sense. Fixes bug
  observed by Andrew.
- Link to v5: https://lore.kernel.org/r/20230905-nmi-i2c-v5-0-0001d372a728@samsung.com

Changes in v5:
- Added a nmi_scratch_append() that asserts available space in the
  scratch buffer. This is a similar defensive strategy as used in
  hw/i2c/mctp.c
- Various small fixups in response to review (Jonathan)
- Link to v4: https://lore.kernel.org/r/20230823-nmi-i2c-v4-0-2b0f86e5be25@samsung.com

---
Klaus Jensen (3):
      hw/i2c: add smbus pec utility function
      hw/i2c: add mctp core
      hw/nvme: add nvme management interface model

 MAINTAINERS                   |   7 +
 hw/arm/Kconfig                |   1 +
 hw/i2c/Kconfig                |   4 +
 hw/i2c/mctp.c                 | 432 ++++++++++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build            |   1 +
 hw/i2c/smbus_master.c         |  26 +++
 hw/i2c/trace-events           |  13 ++
 hw/nvme/Kconfig               |   4 +
 hw/nvme/meson.build           |   1 +
 hw/nvme/nmi-i2c.c             | 407 +++++++++++++++++++++++++++++++++++++++
 hw/nvme/trace-events          |   6 +
 include/hw/i2c/mctp.h         | 125 ++++++++++++
 include/hw/i2c/smbus_master.h |   2 +
 include/net/mctp.h            |  35 ++++
 14 files changed, 1064 insertions(+)
---
base-commit: 005ad32358f12fe9313a4a01918a55e60d4f39e5
change-id: 20230822-nmi-i2c-d804ed5be7e6

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


