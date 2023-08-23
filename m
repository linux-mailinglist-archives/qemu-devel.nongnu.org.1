Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D67853C2
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYk4B-0005OZ-QU; Wed, 23 Aug 2023 05:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qYk45-0005Nl-GH; Wed, 23 Aug 2023 05:22:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qYk43-0005LJ-02; Wed, 23 Aug 2023 05:22:13 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 32E905C00DE;
 Wed, 23 Aug 2023 05:22:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 23 Aug 2023 05:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1692782529; x=
 1692868929; bh=20ITenHY9SaVI3QeBxMfm7q3tEtFSLMhSrUzH5wzjLg=; b=t
 M7QgqdG1eJmW65s+ookcd1WS23RB+TkP2WBWleDFKJxlCfkG4tZ/SO1gHLtuSAMn
 rTDLFUqUt8N+ioBcF9x6oHI4Xw2DDa9FMrRgj2zjDxg2KrG8xuez101RTp0r0mzV
 xeWz6dAvCMVsl1Bon7yoUP0P6ql1ZXqiIlPJrP7nMnWCSB9TaTtbi0tKqJarSINZ
 DvolUL/wXGUtxs2l2Zpta1Kgcx99vYOQjx3qKigbjNNymxEYor1r9tkGKTkHE40f
 PKu4vydpb+kzBLJEsMEDfOcU8NszGoJHCDXGUmLIqbUzh7RqMNlj3fOZgTOZXbqv
 Xyd7wQRu/yXLhii46idPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1692782529; x=1692868929; bh=2
 0ITenHY9SaVI3QeBxMfm7q3tEtFSLMhSrUzH5wzjLg=; b=cEYteBL8uXjJt3PBo
 YsNeQyFDIc/3aZUyo1Wo+h4ih8AlopfJC4Niwo9h7wTtKhogXV/rxbr0i4gJgnMQ
 hHYONgDGB1wAOTUWFuzNqlReTXZc7dAUFrXsz0M/046DnNlQvKDgYn+Vjm+dh4Id
 EpcsbwQTt5fpIeaIu5sPOz0Hbr9J0DxaLCuiThWiExaY18nes5yugnYU6OxXNsh6
 QMW7klb7tXKSL3yUGZ6CcjVPktsLt6sUoo1Q7m1/bYI2hvbLpjeyHEmDwvbgh880
 yrRRqhcpRm+ruPAHWC3TyBJCQHhNBoAJ5BC4Nxl5AGGv6qqYzwp1fLip/qgcy8PD
 5ZVBw==
X-ME-Sender: <xms:v8_lZC-mHUKGGtIu4O24Df5Q2wn4Ji-bsFCYW0R_LTvdSR56JrGFgA>
 <xme:v8_lZCsYOAfZlTPHm0i5Yih1GtD0KmcyetRdaXKr5W4eqj7biSeylv--6xM7z-8j6
 7kxdjAB89L3wM7Gvo0>
X-ME-Received: <xmr:v8_lZIBEnQFMTcmBonSkSiJ8qIDp0BXG3NsQjEtgbcdI20tn3FYkezXDv8zOu22b4AsihJJcf3a7P-0QvY__L8Zrk1u_lQ390o52abluha3nExDVEoIoGbBSojC0GJLrEaspDXjw1u9LUr_NEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgudegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeduffduheffffeihfeuleekgfejkeefkeegheetheegiefgudetudevieejgeff
 leenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:v8_lZKeWZGbQEMdAbr73wNywOiCuvvuDPNOARCT5YhSXPkOMhKXk4w>
 <xmx:v8_lZHPzZeiTKCtupxcEovtWB3DOazFNh2bm_gGKSvQuQ6ZcOJPjxQ>
 <xmx:v8_lZEmWDDXwnIylybliPw4uCau5yyDA77gPdjL4b6DOvzEKroaUSA>
 <xmx:wc_lZFvtEaqeYKzcqa1VpTlvr6tSeZItTJLy2R9eCW4r4Yl5EWXvxA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 05:22:05 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH v4 0/3] hw/{i2c,nvme}: mctp endpoint, nvme management
 interface model
Date: Wed, 23 Aug 2023 11:21:57 +0200
Message-Id: <20230823-nmi-i2c-v4-0-2b0f86e5be25@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALbP5WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDI2MDCyMj3bzcTN1Mo2TdFAsDk9QU06RU81QzJaDqgqLUtMwKsEnRsbW1AA2
 4YLRZAAAA
To: Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 Keith Busch <kbusch@kernel.org>
Cc: Lior Weintraub <liorw@pliops.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, Peter Delevoryas <peter@pjd.dev>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3795; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=rBAEmt0JsBGp/GN3Q5V2cSgy3EXakcIYEMcJk82QxDQ=; 
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTlz73/tVI8B9iob50DMlkUASZE8IKKtAFYz
 Y6d2Ap32txyY4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk5c+9AAoJEE3hrzFt
 Tw3pSLIIAL6QAZJEgRawiTkBTJqOZgSW/nk6hx/EdHbHnrNRdV+lpCU1oM+TaY6jhhHiQCSpbUI
 95mGpY5sZdnG2W6wMiLRgrjWuFCtync2w1DqJ22pDg62J2mijYFYdFpPwh/bc0T8W69fdgx+YDk
 Pe95H4L9s4y6dkdYRN8Cqg4TMhhEdk+l355QO0A66HPMIjhnIh9fUVoGZAcWU4ZE41hhP5+Qcr9
 SEUzI/1FtUfpzmFvXX6KW0GTBXoeGxPv0PdSCNtLWuAw1nEafSL3Z2VEsjaUCrGrWRltDD9CNPg
 o4swDFz7ks3XJZXVjHwDQgUWZ6uWSqVp7AgICI+BJu+rfXYJbDzz6aYF
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

Changes since v3
~~~~~~~~~~~~~~~~

  - Inlined the POLY define in the crc8 function (Philippe)
  - Changed a bunch of fields to use registerfields.h

  - From Jonathan:
    + Added references to specs defining the structures.

  - From Corey:
    + Reworked the buffer handling (again) ;)
      Derived devices can now never write into the mctp core buffers. Instead,
      the mctp core will request a buffer pointer and copy from there.
      Internally, within the mctp core, writes to internal buffers are also
      checked.

Changes since v2
~~~~~~~~~~~~~~~~

  - Applied a bunch of feedback from Jonathan:
    + Moved a lot of internally used structs out of the include headers
      and into the source files.
    + Added spec references in various places
    + Split the patch for i2c_smbus_pec() into its own
    + Fix a compile error (and bug) in nmi-i2c.c.

  - From Corey:
    + Reworked the buffer handling. The deriving devices now returns a
      pointer to their own buffer that the mctp core copies into.
    + Added a couple of extra debugging trace events.

Changes since v1
~~~~~~~~~~~~~~~~

  - Fix SPDX-License tag for hw/nvme/nmi-i2c.c (Philippe)
  - Add some asserts to verify buffer indices (by request from Corey).
  - Drop short packets that could result in underflow (Corey)
  - Move i2c_smbus_pec() to smbus common code (Corey)
  - A couple of logic fixes (patch from Jeremy squashed in)
  - Added a patch to handle messages with dest eid 0 (Matt)
    Maybe squash this as well.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Klaus Jensen (3):
      hw/i2c: add smbus pec utility function
      hw/i2c: add mctp core
      hw/nvme: add nvme management interface model

 MAINTAINERS                   |   7 +
 hw/arm/Kconfig                |   1 +
 hw/i2c/Kconfig                |   4 +
 hw/i2c/mctp.c                 | 428 ++++++++++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build            |   1 +
 hw/i2c/smbus_master.c         |  26 +++
 hw/i2c/trace-events           |  13 ++
 hw/nvme/Kconfig               |   4 +
 hw/nvme/meson.build           |   1 +
 hw/nvme/nmi-i2c.c             | 418 +++++++++++++++++++++++++++++++++++++++++
 hw/nvme/trace-events          |   6 +
 include/hw/i2c/mctp.h         | 127 +++++++++++++
 include/hw/i2c/smbus_master.h |   2 +
 include/net/mctp.h            |  35 ++++
 14 files changed, 1073 insertions(+)
---
base-commit: b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa
change-id: 20230822-nmi-i2c-d804ed5be7e6

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


