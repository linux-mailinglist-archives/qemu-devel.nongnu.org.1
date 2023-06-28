Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F6B740CB2
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:26:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERQQ-0006zI-PA; Wed, 28 Jun 2023 05:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQN-0006xy-0m; Wed, 28 Jun 2023 05:25:19 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQL-0001Mr-Aq; Wed, 28 Jun 2023 05:25:18 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 720635C0264;
 Wed, 28 Jun 2023 05:25:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Wed, 28 Jun 2023 05:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1687944316; x=
 1688030716; bh=KVT+ujvnzF3IlcRhQ+7c4hl6lloqDpHwzBWNFnFECaA=; b=u
 /Fhh4Rk+FAp03Zlwv6znXl7WsqLrPDvQJ7nUaE2wJQD6WN0KFpJUzcKRQTo0H/hd
 KHFj37gW+yJSMn/GqGUlVG7vSquT+G2tinjmi9xKZ5GPYBSovTkPp6uORmzo9VRH
 24wxxyY+owanmuYn/apBJ2QE4A8PHw+q5D1N8DkEZ/YlMNMATXKPOuXjooLL9Uvo
 Js+qPDZE4NtkZmoHUVsY43+q1NgJAvhRKuuHTBjq0KBHG4kpJiKDK8KxgRrXcpsh
 8TLiXXBgN+3NMjX+6cjKW/DGjiSwBP0Lu7gS2bhyNB/vDiM2vOy2AZ7szc4luiRT
 npXJG+jo92JI4gAlvZ3ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687944316; x=
 1688030716; bh=KVT+ujvnzF3IlcRhQ+7c4hl6lloqDpHwzBWNFnFECaA=; b=X
 d50PRzyx3GLVDBbkNiTxHTfS1aqanX34pEEam0X+aA2Mi8zOdt+yqlbSy21CWt2V
 CCXGr+t9Sgwkdz/A3K4KLFVHemuPaGKdt48ROWDQzkKos5OvMLL455BkAvMf1qWP
 MWWgvddSscCKkCF+BPteKmpQLuKz1h4/I3HnRnqox8Bu3tKaRFAMFuPLMWBvRCWo
 WstpqbSk33ye9gOTn4xLQ39svVl9Qv5hm5ZD1Bfgrrj0p2Bh6EXkWjtOA5FVJJD+
 Ley+vBM5bmzzT7Swio9FL/08UZu8dfVlq1F2NFJdAPbao4qARHFK5zzDvmlZv5wo
 Ya+578nJ9l1ILat2IlWIQ==
X-ME-Sender: <xms:fPybZGRZL2YTTfTrSeknpHJMxZr5M-z_C6oBwz-0s4-6tYiBzU6_tQ>
 <xme:fPybZLwDn3TH5rFBaPAaejPapNaA2N7qst4Kab1zdhjiQmfjVF-hbQN90mHpm05p8
 VxN9p5XmVk7vcmuY04>
X-ME-Received: <xmr:fPybZD3Xv_WvV6yX94J7sfJAGCPX1EB4Y8hseHoHtMcRGlUT5k0l5Ci_7p4oHvoNv-Z8QgCifRY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgddufecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfeilefgieevheekueevheehkeefveegiefgheefgfejjeehffefgedujedu
 geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:fPybZCDfLpWZFZDbKYpGhqTni0MFircxqxrAM7rtmt_ASELOA7gRWw>
 <xmx:fPybZPiEL099ZMaVtUWWi7B4D6bU_dC3DX6ENDqYmvU7K1Ef4a2DWg>
 <xmx:fPybZOoJOY7Dh4TPasRo0Dq04wIvkTRYMqsteS5Aa9EMTUD_ABiXJQ>
 <xmx:fPybZEZF4Uq4oIpz-ERHXx7iMy2jnwTaqCEGc2zW0UcD2fFV3TxCtQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jun 2023 05:25:14 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <j.devantier@samsung.com>
Subject: [PULL 7/7] docs: update hw/nvme documentation for TP4146
Date: Wed, 28 Jun 2023 11:25:01 +0200
Message-ID: <20230628092453.39602-16-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628092453.39602-9-its@irrelevant.dk>
References: <20230628092453.39602-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2327; i=k.jensen@samsung.com;
 h=from:subject; bh=kKPYV0y0niAhnY7vHefj6DX0B5zNNJSY0+WCys+kjrw=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGSb/Gb1Av7hkR21Mu5L/CobXQndKJaRwqFHN
 lz9Orc770Vs24kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkm/xmAAoJEE3hrzFt
 Tw3p9QUIAJBaTc87kBMkI5RCTP/oSt479WLNaEqUxRkK8+DsDHFET28cD2YHz1U4btzAAPti4gH
 nR1ls2PmcCBEoBQWaGmOsduVCrraGvvL/DC8HRSp9pP93cdOOQ73UMW2dMifcUivy/SYjV6SGNC
 pykEHH0W12qiilibLXoIC+PbK7Hkq0CPIu43ZNR0IKV1JWZExhhDsZY2XNIh/IdBsKoQi1SFyrV
 qp6cuNarZnn7FUrsf3IsgtSq9lQcC9vCqt0OVIxCHLLscsGrz6Un6fXgMZMNBvsBxujM8DgsGV4
 ef7cvUYnH77KIJ2R9bG+KLdY9ymrPPQxPAxb9UVP9jh59/pAS9JwQqT6
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

Update documentation for TP4146 ("Flexible Data Placement") emulation.

Reviewed-by: Jesper Wendel Devantier <j.devantier@samsung.com>
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
2.41.0


