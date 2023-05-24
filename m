Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB42E70F4EF
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 13:19:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1mWa-0001Bp-4T; Wed, 24 May 2023 07:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q1mWX-00016Q-6E; Wed, 24 May 2023 07:19:21 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q1mWV-0005Vy-KD; Wed, 24 May 2023 07:19:20 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id B36AA3200CAF;
 Wed, 24 May 2023 07:19:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 24 May 2023 07:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1684927157; x=
 1685013557; bh=Grh6DrHEmcAnFn1Qk0dmK9BQaoWAbv7gLcA+ZNpjdiQ=; b=Z
 Ei+suiG5diXS45Pc/9CPN/nvehraRpTBaEzz7u3cVmNEBhFnGWWvNEaMiKJcMalO
 eZNlltMia10Bi8HCE0laUK66l619MlzBdsJcTx7vRvNBp/bxy6oeY1SdTuetar1F
 27kTQ10SHLU462C3rDBDWAewnnN7E5wJCNcOhTxNpiKwA2o8qFckSprr+ypzEef3
 3tkf4Wc4KDbIqasRD01u4X+P3injy+X+WP2W6etyqWPJKi1XuXcwCcqTPxa8Vxme
 PR1Pg5AWWt3/zW07pkt9zv3BQvw0MA/+ruqDSKAEC1vB4Q4Bb7ivzLGAeybn1efR
 qOC++jvoNFSsJP29obXrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684927157; x=
 1685013557; bh=Grh6DrHEmcAnFn1Qk0dmK9BQaoWAbv7gLcA+ZNpjdiQ=; b=x
 4skSto7qPmsv7zC2TQAHuDWMNxGgyU91hFbnfLYwTAVTnEh03HgpUoOQckBHILaE
 SMzqAurMkFqj/ky3pxgIRY/9G87cMUq/2w2xC6/cVoVTsTioF9qxRUWB9J2+IF9M
 H5P3HM/WrJzPmyVhOql6C27XceH8xcnfT7gi4uYuIbCvre2HP4UQhk8Pby6rTeLW
 HPzP1h78pYH2BzkPsyduHFdmVJqHQEl5x+fvEOSU8mhlajrMLhU8mwfu5L23/7MH
 qMrgD47nPzwSsCrnElMf+JjMpXE3PUpODZ7DqIpYLsx6RAW8Kq8iDnYNFThPL8es
 Epr1OZDXRThU0SZrWkHjQ==
X-ME-Sender: <xms:tfJtZKGSYz-DCH8JmxO2sP9IQzR7z_xl3T-z_qDjsS9Dt0ZHewSYEQ>
 <xme:tfJtZLUwhIXCHST2yHBzFZ_dKYd318_w2ua6zZRJgGE3lo619Xt5Jj7zz4SJb4ymg
 4wlvdtuINTIC97dPyU>
X-ME-Received: <xmr:tfJtZEKzR3FIXyHYn1ZMPQXBORoMH6IBL8HTQyV6Ygk35YdTwEH68ggSuGs8DvFdv69tI9qWvABB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgfeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:tfJtZEELUGg3HBC5A7K44A44wgfnGHRYU9kVbaPjU2jxCWFVn8sR2w>
 <xmx:tfJtZAX1YE5YTTMP047xiejs7CW-SODFJillValgDlfTetzwe3aJTA>
 <xmx:tfJtZHNt7TIhb42_mh6q2J1mqxRvfNxrqWk2LguCr1WIF29ErSTsmg>
 <xmx:tfJtZOxe0W5E1KfQpZD_AU22ABvmrFFQQYEzji9bO5Xigts6HXe7Yw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 May 2023 07:19:16 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <j.devantier@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 4/4] docs: update hw/nvme documentation for TP4146
Date: Wed, 24 May 2023 13:19:04 +0200
Message-Id: <20230524111904.91179-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230524111904.91179-1-its@irrelevant.dk>
References: <20230524111904.91179-1-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2263; i=k.jensen@samsung.com;
 h=from:subject; bh=TJrB+rTXW0/5/nfN8WmCGPKxSketd2L0e0mYGODsu48=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGRt8qidaynVoM7JkWbVCgT3GK/7MsuuGfpSo
 XPqMRdhn7ciTokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkbfKoAAoJEE3hrzFt
 Tw3pQzAH/jWVyAyW9A/zHR1e8l2nOytsm/ozfnff+WZQtXyLW4zCCZCkAQeMumtCvRQezyj5+xw
 yn+DTxcV6h7ciSnHz5OSKWS8V02Gxv9NdfF8eB/lABH5DP+FB49Dv2jDi13R5EjJoo71M2wwQ5X
 GYnWhI0xchM25DBMWJGlQVHXB04xIALr1+FADiaBP75zMymquYkYoylU1it7Akn2kgBbg3wjmeU
 zxI5K7OWPWEVkQWzZ0KP5EfOf5BCAaTLT8StDsfzq8/5r2c/Npy7mUvDs6oMeGQbDEDhxN390vN
 1yRJGtIZVRS06Rmuj1zd+HAeLGxRQyHROtjq9jejS9bc7ERGozUU76Qx
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.25; envelope-from=its@irrelevant.dk;
 helo=wout2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Update documentation for TP4146 ("Flexible Data Placement") emulation.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/system/devices/nvme.rst | 37 +++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 30f841ef6222..a8bb8d729cd2 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -212,6 +212,41 @@ The namespace may be configured with additional parameters
   the minimum memory page size (CAP.MPSMIN). The default value (``0``)
   has this property inherit the ``mdts`` value.
 
+Flexible Data Placement
+-----------------------
+
+The device may be configured to support TP4146 ("Flexible Data Placement") by
+configuring it (``fdp=on``) on the subsystem::
+
+    -device nvme-subsys,id=nvme-subsys-0,nqn=subsys0,fdp=on,fdp.nruh=16
+
+The subsystem emulates a single Endurance Group, on which Flexible Data
+Placement will be supported. Also note that the device emulation deviates
+slightly from the specification, by always enabling the "FDP Mode" feature on
+the controller if the subsystems is configured for Flexible Data Placement.
+
+Enabling Flexible Data Placement on the subsyste enables the following
+parameters:
+
+``fdp.nrg`` (default: ``1``)
+  Set the number of Reclaim Groups.
+
+``fdp.nruh`` (default: ``0``)
+  Set the number of Reclaim Unit Handles. This is a mandatory paramater and
+  must be non-zero.
+
+``fdp.runs`` (default: ``96M``)
+  Set the Reclaim Unit Nominal Size. Defaults to 96 MiB.
+
+Namespaces within this subsystem may requests Reclaim Unit Handles::
+
+    -device nvme-ns,drive=nvm-1,fdp.ruhs=RUHLIST
+
+The ``RUHLIST`` is a semicolon separated list (i.e. ``0;1;2;3``) and may
+include ranges (i.e. ``0;8-15``). If no reclaim unit handle list is specified,
+the controller will assign the controller-specified reclaim unit handle to
+placement handle identifier 0.
+
 Metadata
 --------
 
@@ -320,4 +355,4 @@ controller are:
 
 .. code-block:: console
 
-   echo 0000:01:00.1 > /sys/bus/pci/drivers/nvme/bind
\ No newline at end of file
+   echo 0000:01:00.1 > /sys/bus/pci/drivers/nvme/bind
-- 
2.40.0


