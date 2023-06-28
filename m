Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F55740CB1
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:26:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERQF-0006s9-Kb; Wed, 28 Jun 2023 05:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQC-0006qs-Ib; Wed, 28 Jun 2023 05:25:08 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQ8-00018T-Eo; Wed, 28 Jun 2023 05:25:08 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 549015C0208;
 Wed, 28 Jun 2023 05:25:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 28 Jun 2023 05:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1687944302; x=
 1688030702; bh=pKSgGPugpMae8P+g9ZSMuUMtsFuKLPdDV3W3UFsC10o=; b=V
 SPJT51i1zATjq7SBgHSO1Tv3/IZSzYgBptIU36t6ZjmUF9+LCBkjN7lTNhpDrzj6
 BFRLap9MITtKqYKgPVjGyDycTc1iUhiPOJGXeVWXTUEXSfqq7xHTV+L0JM3LwZos
 f8HUSBOKoYESfGZwOiUyH+IQPjL7NYBAM5rdmfe68Wpc3aMCjYyPWjqccMPgMPwt
 DxvP+J2CabzJqorxVVr3xMNozknMivH+NdMw3aCASlc7hGByY0kMFTFFi+ZWBIc+
 aXbmkxPNNhtWnyGsZxB+d1/IiWnt/WRrpkvKjal2vIwwep3Hc0GpCwDNJbLvZg4D
 PTTiGiBS/krZt29WzfnTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687944302; x=
 1688030702; bh=pKSgGPugpMae8P+g9ZSMuUMtsFuKLPdDV3W3UFsC10o=; b=R
 y6V3/n3tdUtckIQetO0z2p0T8szrrjVvztV1M/E08/+JjTIldGUQX6MuM47s51MW
 fk/X722xiOKRolnSKJMp7kjFX6gjyYDzIAD9gOMy1Gxaw0jmLmG2J/yp7Puh5nGQ
 013bphJFGTUY9916glETZ8lxB5KvEnJ96CTEnbQcoQ9sFc9dW9W7iRS5O6SAtf/9
 EnE33cryJixn1/LhvkJat5yWAwaVxVmYfNheb51a3DQiClkNAT/JW3aSTZGTV+E7
 nfOEdtN3DRWDUJMGGWFiU2pFGEfz5Vu9a4B09J/fU//2++PoWD20XgcBAJIBuJr7
 5tzcAkfJLjCaTdxgwH4vg==
X-ME-Sender: <xms:bvybZKQkw5TjUGYgEpK0dbrNi-GAQxEmiaTH0PuLjWATjlRiM5QnOQ>
 <xme:bvybZPwNKPFmBy0AY3X5v1YpIFZxZOGrtiZ2o7RkfcQLMdqu_DA1pQVbnZiSXe0Aa
 zqYa1KFX334wtUTFUc>
X-ME-Received: <xmr:bvybZH20Tg7sYgveRIVxavfhLUvw2YIec-SYpDHAGVjwhZ2LG9KsG3Th8wwx2EUIdIgLBQQuTyk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgddufecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfeilefgieevheekueevheehkeefveegiefgheefgfejjeehffefgedujedu
 geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:bvybZGCTytu2WBH0gY3nl1NILbe0vWLtOxq0FcglvcKPSPZEpJW_hw>
 <xmx:bvybZDjEbO7jmiu29CCzev10bQoS1UTB2JXmOsNpWIdtR5TVHsLKig>
 <xmx:bvybZCp4IDGJALrzmAXqBgo1KYrsC4Q_QkjaQ0o98Mq3UhE0b_bLqw>
 <xmx:bvybZIbU7NycP-FBVpgwxxdKgpWxmhA0_kam4QYH2TI6cUS88lOT8A>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jun 2023 05:25:00 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Minwoo Im <minwoo.im@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 1/7] hw/nvme: add comment for nvme-ns properties
Date: Wed, 28 Jun 2023 11:24:55 +0200
Message-ID: <20230628092453.39602-10-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628092453.39602-9-its@irrelevant.dk>
References: <20230628092453.39602-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=k.jensen@samsung.com;
 h=from:subject; bh=d6hLJrNAEXhZ3XBWCPuox7FQ1uK+b1JaB9MdsfsOYLY=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGSb/GVVib31dxosdNPemWevyS1/kC/GzCerU
 FREuOzK4sWgF4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkm/xlAAoJEE3hrzFt
 Tw3poq8IALRpj7bSFi0rkfFbJiI/L/ZoiD4jOQT4bDKpxqLtPohxyBNMZAXgrLvA37YRrmQYjU4
 7appKTooGypbQiOPD/NS5mxP6583pZbcfSKzeJPyS2tfRo72bw60eI7LMVqkZSFuxCUxpEc1Pvj
 RVsX2SL0YMHAP7cgOlWjtbcc8/c8WfNaDlVj3/fVynf0Z+YIwkdYtkuniuX5C5/ARy0PkG/2TPi
 /jcmNMip6hq+QtpahuarPQF8WKkzwIUdmmX5sG3TYWhMyZ1oCZgw/xsY+XB81AQtY/pgMe4JIzv
 1EEjK2XaiEcwrdKLzUEMV7I0wzhgxoDzxfQSIk+rY8Io6bIVWnXzHK62
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

From: Minwoo Im <minwoo.im@samsung.com>

Add more comments of existing properties for nvme-ns device.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index fd917fcda1f5..020f37a780e0 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -43,7 +43,14 @@
  *              subsys=<subsys_id>
  *      -device nvme-ns,drive=<drive_id>,bus=<bus_name>,nsid=<nsid>,\
  *              zoned=<true|false[optional]>, \
- *              subsys=<subsys_id>,detached=<true|false[optional]>
+ *              subsys=<subsys_id>,shared=<true|false[optional]>, \
+ *              detached=<true|false[optional]>, \
+ *              zoned.zone_size=<N[optional]>, \
+ *              zoned.zone_capacity=<N[optional]>, \
+ *              zoned.descr_ext_size=<N[optional]>, \
+ *              zoned.max_active=<N[optional]>, \
+ *              zoned.max_open=<N[optional]>, \
+ *              zoned.cross_read=<true|false[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now. By default, the
-- 
2.41.0


