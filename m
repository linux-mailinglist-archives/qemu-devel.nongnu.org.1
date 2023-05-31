Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41136717ECE
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:49:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4KJk-0001bs-AE; Wed, 31 May 2023 07:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q4KJ3-0001OC-H9; Wed, 31 May 2023 07:47:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q4KJ0-0002xx-RN; Wed, 31 May 2023 07:47:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 86FF35C0195;
 Wed, 31 May 2023 07:47:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 31 May 2023 07:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1685533669; x=
 1685620069; bh=a1k2OEmy5YzcGYZ7zxNK0XmeUsHldEWsiG8FKet/Kx0=; b=X
 NqSbRdbM8GGItOMKjllLFbsNGVchuBn+jbgLLFVa09x+2NG657ftAgOFupAw+YOa
 7V9X+ZyDN/59F8G6oWVSDm+XvexkcPVW+MLBNhOXXtxIgM1WiXb4FkWibRv5aTsR
 iXVUzzofhoRdGLgTDwxn3tij33Z4gTSMlLfe+IYzIqYR10GvXlmP8PQbxELOW4k+
 xu9Uv289J+6sz69869EFf8n4G3ZUrW4je8rvn/5NU5KGa1/f74jll5UymnSi+aXH
 R/OJ8TXrrt8Qjv0gcD6DBc/jM/20cTjOMdUG5DtLmvMTPHLqJOcQ41vK2teQ3krs
 Qc3ierd1Mf5M6wfQFJfmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1685533669; x=1685620069; bh=a
 1k2OEmy5YzcGYZ7zxNK0XmeUsHldEWsiG8FKet/Kx0=; b=BRIdZs+O1t7XDHWCL
 Eyhry9Bb784Da6mXXd5XLMYse2a5lIynjyBQi56p9ZjP5acq/gNGA165i2NGCVEg
 NN//dG21KCrR/pbJoqI0rAsZz9uflq45JQSgsgkKifj8BmbeigNVfePEJUUGlh6C
 hv81ldJ3PeUwJaw6tI+/zSe/CbnAPd4L+2PjHW0+AjSnV4TBAMK1RW7ArKvcuN1N
 +GCe7zpbaR0qHALaEnII/7KXwgG/k4jfeBjijNEIPKpTVUATA5R4ziuLpxlviBoM
 Y3MNBQcnKgA7w0VKdXJRta9P/p7c+EImXhienQ1DmPXvWrVG0bNcfdE9bOtAjyQf
 S8bRw==
X-ME-Sender: <xms:4zN3ZLJrQjtFfJ24PdRXF3Qqz7DQAKFgJbi5zFC1byZI6x2ZV7CTTQ>
 <xme:4zN3ZPLiF9RekeXXTgr27UnEzBo2A53yvIJLoxMedceg9HHSxCWLgbF-8sRI6bE0m
 TWLDBo9H0KDnBlRhiI>
X-ME-Received: <xmr:4zN3ZDtlic5IONgErsOhepFsj-r9pojBrrVKCZ6BNtYpBYV0qqJ1eTnZqrLpS05FC-t5wgAgOtZRDEiFaH28ZAMWd2eQtvcGUwvwVRo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledggeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgtggfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeefgfehudefjedvgffhheelvddvvdehfffgtedvffeugeeigefggffggefhieej
 leenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:4zN3ZEaIuiK16peJSOs3AcyqeLY1MBLiNtszkjMu6NMNGOtXvUNoSw>
 <xmx:4zN3ZCaupvAWtKD-W-nRKRM4XMikMTcAP7ByIaWXLAPdeoiQiUOIug>
 <xmx:4zN3ZIDmXDdLWKRRZ0yuk5wdW_CCG6vND8R2u3oiIPZUOi3HpP3NFg>
 <xmx:5TN3ZHLhbANHMV5dalcSr78pur1xwi6w09wliP0p9QeHNoZw42pgvA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 May 2023 07:47:45 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>, Keith Busch <kbusch@kernel.org>,
 Jason Wang <jasowang@redhat.com>, Lior Weintraub <liorw@pliops.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
 qemu-arm@nongnu.org, Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>, Klaus Jensen <its@irrelevant.dk>,
 gost.dev@samsung.com
Subject: [PATCH v3 0/3] hw/{i2c, nvme}: mctp endpoint,
 nvme management interface model
Date: Wed, 31 May 2023 13:47:41 +0200
Message-Id: <20230531114744.9946-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.40.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3237; i=k.jensen@samsung.com;
 h=from:subject; bh=4j/eaYhClLaSlHdkVQI4N2TzX2t5KsyuOnHaHFUytnY=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGR3M919i45+JRsZuRLELXCLjRWydkvQqx8fZ
 aAZ7/tPASf6EokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkdzPdAAoJEE3hrzFt
 Tw3p//gIALovzf+ZLUwAMHTL5RqQhWvPjsAgsdQcSGU6SirKrvE5vebDIUUwMjrBMUIkxI7JRT+
 ve/6VQmkxtI6KCaH6m253Wwl83OrRKtpAYbwtRZLT7hAwr8vN6qakHnUa8lR1bbaP04PKn4h9Ny
 go2eWTIZ/UptmpUfUKiPojJefbpuvK6qA+R41p0P+U0FUKDSIrjTgmaf/Cex++4tvmNXUKlYk36
 nspTh0WWzsaJ085J6zrnYmnuFO8SoeokMvoS7wNBpN6u/712Gdp2fGpLnqTvo3RPI+or6ll3oD1
 C9ziZHTZH9l28SUOBRQSkz2uEL7uOqnEAtQmXeqm4HbEEq7tsyUAM6vI
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.29; envelope-from=its@irrelevant.dk;
 helo=out5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

This adds a generic MCTP endpoint model that other devices may derive
from. I'm not 100% happy with the design of the class methods, but it's
a start.

Also included is a very basic implementation of an NVMe-MI device,
supporting only a small subset of the required commands. Lior (CC'ed) has some
patches coming up that adds futher support.

Since this all relies on i2c target mode, this can currently only be
used with an SoC that includes the Aspeed I2C controller.

The easiest way to get up and running with this, is to grab my buildroot
overlay[1]. It includes modified a modified dts as well as a couple of
required packages.

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

  [1]: https://github.com/birkelund/buildroots/tree/main/mctp-i2c

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

Klaus Jensen (3):
  hw/i2c: add smbus pec utility function
  hw/i2c: add mctp core
  hw/nvme: add nvme management interface model

 MAINTAINERS                   |   7 +
 hw/arm/Kconfig                |   1 +
 hw/i2c/Kconfig                |   4 +
 hw/i2c/mctp.c                 | 398 ++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build            |   1 +
 hw/i2c/smbus_master.c         |  28 +++
 hw/i2c/trace-events           |  13 ++
 hw/nvme/meson.build           |   1 +
 hw/nvme/nmi-i2c.c             | 367 +++++++++++++++++++++++++++++++
 hw/nvme/trace-events          |   6 +
 include/hw/i2c/mctp.h         | 137 ++++++++++++
 include/hw/i2c/smbus_master.h |   2 +
 include/net/mctp.h            |  28 +++
 13 files changed, 993 insertions(+)
 create mode 100644 hw/i2c/mctp.c
 create mode 100644 hw/nvme/nmi-i2c.c
 create mode 100644 include/hw/i2c/mctp.h
 create mode 100644 include/net/mctp.h

-- 
2.40.0


