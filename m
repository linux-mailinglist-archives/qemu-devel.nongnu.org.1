Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3F3792119
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 10:40:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdRat-0002w1-EA; Tue, 05 Sep 2023 04:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qdRaF-0002tR-1r; Tue, 05 Sep 2023 04:38:51 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qdRaB-0002ft-Q6; Tue, 05 Sep 2023 04:38:50 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id E18CF3200903;
 Tue,  5 Sep 2023 04:38:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 05 Sep 2023 04:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1693903122; x=
 1693989522; bh=5rOMuVjk2MxgTUN7h7BeAoEki+VsmHKrN7uWoeNu8uY=; b=B
 DTSOzzfpqzG7vSDdKRNSuZU3Y4NscvTUBNbbYXWj5ISM64VN1+wRdTvKCqQGf4DY
 VqCSRoLfNmkge6NTnawB8v1kun60GFJzBqXqAyxADe6c+HconvxZBSWdfcVBch/e
 oFHcspdHJ/g4bRPD1icU0TaeA0twKdIPq/EePLgb713GMJOJZN95BjUKoaPdrpWT
 xkYrCSOgrB81/V6tTEXPXAaiE1ReJqfVCLHbY4o3B+T6x16jnE3nIbzYe1F72MSW
 QW1DxAYe8lbuUrxWAMYVmEGH167j1KAKnHFQ7kgM4Iyimy/a+n9PRYuYRfoFHnz8
 STAIDyd2yuBHI/I2HTL8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1693903122; x=1693989522; bh=5
 rOMuVjk2MxgTUN7h7BeAoEki+VsmHKrN7uWoeNu8uY=; b=zh5FGecb7oneQgoXv
 2WyCPCDkAItpIDDB+4+XaiADBYV8MYKXJeSGGNK+LHi18VQGypHz/cyd1gvqqf4N
 FlI9Zj/ntl5DJ7DK4dHYabyPZXeMVSK8LFcvJtrzxGum4OqKoGzLr9kkgNtaCtLC
 TVjcCldzOZsMIWrqgf68T39/DpgUlWU27LZGU+pXYqctt20JQPuTfN7w661enX0m
 yI6WHvsIUL4v4PT70s2bh77pBVIcpvZRJwdruNRd472rOAWL2pVrBxwwnlN+CnvO
 aUfaUz2dR24zFRgv0WjM82vgxy6oOk2FLXP01sJF2M47vILHauD3SgMzsP81YTiW
 28fKw==
X-ME-Sender: <xms:EOn2ZPqUBklY9bUZSoB1GSvluQQiJgOlGUjnmEEihBkCX3kfJ0QbCA>
 <xme:EOn2ZJomFGxEs-hTxwGdTUXePSl8stxZrAGygpIwvZ03MQ-9LxUuUw_jlYq1FkGxA
 wCkwViy-VmuZj2WUCI>
X-ME-Received: <xmr:EOn2ZMMjmzhdNRDP4vHUfMNyas9W1j9rRmlLl_guYc3s0tSnkUKXTqAjDw7bqceqYrArq-xq3GegtMdHR8bid6VFhhfN4BN_oyc2EcjE3KXp5enZxhb-wVe3QYMGgf3l2Ix33zkBDIbcKSQ_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehtddgtdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpedvfeetudekgfdtteduueeukedugfeigeelgfdttdekhffggfelveeuffehuddt
 veenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhr
 vghlvghvrghnthdrughk
X-ME-Proxy: <xmx:EOn2ZC7Y1tIXTOKMO_0L9_VpBzJTopxSEGK0lLTZ4MfEMsztN-Ml5Q>
 <xmx:EOn2ZO4jXzaCMoE6qnSdfFQZgpXwLUdac3lsY7SfvEuxmEwOFhjT-Q>
 <xmx:EOn2ZKi8GKU6-pCMvUVy3AMJ3SwyWjzfzB1ewmx1PFJ42KP-d1fWzw>
 <xmx:Eun2ZBIM3L2b5aOU-iG-nHisvAyilEVe5gwZSuaGBxXwByBM8ywv_Q>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Sep 2023 04:38:39 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH v5 0/3] hw/{i2c,nvme}: mctp endpoint, nvme management
 interface model
Date: Tue, 05 Sep 2023 10:38:31 +0200
Message-Id: <20230905-nmi-i2c-v5-0-0001d372a728@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAfp9mQC/z3MQQ7CIBCF4as0sxZDplCJK+9humhh2s4CaqAST
 cPdxSa6/F9evh0SRaYE12aHSJkTr6GGPjVglyHMJNjVBpTYSoMogmfBaIUzUpHTI12og/p+RJr
 4dUj3vvbCaVvj+4Cz+q4/o/0bWQkpcJST6ahKqG9p8OkZ5rNdPfSllA9mXOXYoAAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2562; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=sgcXdAGP8l8kBLZ8CsxZV1DNoVN5Bki9pO/V+L770Tg=; 
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGT26Q65W8FfjH6TcMdrxevXPyjvoPimpyy+B
 uDd50jtxNM0FokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk9ukOAAoJEE3hrzFt
 Tw3p2N8H/RqajECxU/LwCmZuXNKbkvGq8v6/Sc3xgx5higGuQhqBlmLI2JdHPIpwVNhv0QB2DDk
 kHybGc9WHsmhFIkg+zGS/18KABjmwqOw3QGJsmNx2M/VSUFT5aT6ecZ/zn++CRZk/HuNdrz5r4w
 9evfAIhCkc0TOQq3oUZBQAI47DPo2ZksB7GEUCj5K9eRByg0MX0S6liIVf6WWEf6U0CR70H51cd
 Snx6LCp/k1A5YudMKTquEeFRthYqMUeGnLBlddIpwV4kLkCJoIY2NUMiLwNzB9Ol8QWdrPuyElb
 KcyWfqJT4K8i08vC7ikh7DhBlMgSx1dEFmax1R4YHevh/mXa1LX3xazU
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=64.147.123.19; envelope-from=its@irrelevant.dk;
 helo=wout3-smtp.messagingengine.com
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
 hw/nvme/nmi-i2c.c             | 424 +++++++++++++++++++++++++++++++++++++++++
 hw/nvme/trace-events          |   6 +
 include/hw/i2c/mctp.h         | 125 ++++++++++++
 include/hw/i2c/smbus_master.h |   2 +
 include/net/mctp.h            |  35 ++++
 14 files changed, 1081 insertions(+)
---
base-commit: 17780edd81d27fcfdb7a802efc870a99788bd2fc
change-id: 20230822-nmi-i2c-d804ed5be7e6

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


