Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DA0740CA5
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:25:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERQJ-0006tz-3i; Wed, 28 Jun 2023 05:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQE-0006rn-Hb; Wed, 28 Jun 2023 05:25:10 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQD-0001Jj-1f; Wed, 28 Jun 2023 05:25:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 0D5555C0256;
 Wed, 28 Jun 2023 05:25:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Wed, 28 Jun 2023 05:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1687944307; x=
 1688030707; bh=0SAFqxK4V1/WoZqNqzV4M1fFbLLbqOGk3I++tVFYBTA=; b=c
 pXCUS87GhOiBzcL7vJuqh4Qc/Lk2CXKW6GnSmoZzMou2CVU69OVe45fqikgY/J1W
 MJQwfpfN9gaVeF4fMMlvjHR5AFrGZOxsTVDKFjDiYGyL/sqrhUZRPeJLGExhfeua
 d8LphmdJXqq/foNvCAApY9RDUWRE4BpoT3oasRO7y78y92G8KTNciEvl6nYoQunz
 mNZ1oFOtRPePCFDlTxW0SwuITvg9SR4PN7Th1nDw2ZQCBc1FT+b+oOg73395B53J
 dBYfBDlw1ryPAtY2O2G35cezr7mEaL47uMq22gHWHQAu1zoGqwAzLrRGHYEeo/Mb
 VKMPRD4lqlpaA1Ciy63mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687944307; x=
 1688030707; bh=0SAFqxK4V1/WoZqNqzV4M1fFbLLbqOGk3I++tVFYBTA=; b=p
 ekQkUvhU190GwF32KkqItKNOtBuHsE5DOStpgeGowHSsDNSo7P0fGd4HPqf7nZuo
 kzKETiTtQTzr/KHl6SG7Xh1OLoxWdUU9DdFKXxiKjoJIc1zu1T9MYx0aiAN+TnAu
 KRsLSyd+PvoW2bXiv9vwYaj5CjFoVoWyDEvSZgzDoNmgZyWNTR0h0IhqB936bE2S
 NCstEFUHxaURNQ2ymX4SLxdF2H91WD39TP9VaifGV/3uapQbSUf0yGEpgdbYpp1f
 nWXkZN/e0zI0TZmgIYXzy/dvPvwASevlVMZna7VTSAYSx3DW875/UG5cuw+SzHJ8
 dInrG+MWrVa9DRHgXuZsw==
X-ME-Sender: <xms:cvybZAQn2IaY9TDIIe_Y8ZoBTjMawbWNuqB9FT5TO0SE6V-q3pcQaQ>
 <xme:cvybZNxQvFRtwnR973U85rC2A5MmrnaV8JAPAjw1lWDBOeZeN-gzpSI2rtdBAFHJm
 BxjfaA8ajYYNLjaSO8>
X-ME-Received: <xmr:cvybZN1tBI_g0rk9TiWrgeoMyUb2f1r4XTwFVV_DTBn8q9jYyLz3jAVuPIeq-73u8NamHxNOX_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgddugecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfeilefgieevheekueevheehkeefveegiefgheefgfejjeehffefgedujedu
 geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:cvybZEDBNhJ3BTBbsERs4SDFo1qX6dyNOmnqrO2Ew2F65mNvbBlO7Q>
 <xmx:cvybZJiMM9b8cROnl-aAZAmE-KoeUWTkXNeoMTtdXyGFspb-E9jVEQ>
 <xmx:cvybZAoJSnECsHkOENzbRkJDEvfWwQbvoTHagkhfTFurmntEVEBanw>
 <xmx:c_ybZOZ0dg-JWJSsaCoXVzAMmKMq_ZZmi3lNZBIsvTmXEaTkoa2xCg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jun 2023 05:25:04 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Minwoo Im <minwoo.im@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 3/7] hw/nvme: check maximum copy length (MCL) for COPY
Date: Wed, 28 Jun 2023 11:24:57 +0200
Message-ID: <20230628092453.39602-12-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628092453.39602-9-its@irrelevant.dk>
References: <20230628092453.39602-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1670; i=k.jensen@samsung.com;
 h=from:subject; bh=eKUVEUgODcXz3wtxTeNtY/83NRFFRhmOiWfERAFAsk0=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGSb/GYzacgX39Slxe3kS6GMf1Yo1H8sMKI4a
 tDbINuyDls5iYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkm/xmAAoJEE3hrzFt
 Tw3pKWkH/ReLj8LT5xIYZZPu6eJw/cWAulu/ojIAMeJvHimSjUiTwSPdRoFOJbHyOsGhuoYiY3a
 fonU00RBfRVh1eramn2uHUPccP4WFkFRlZ0hTNDWrnTt15te7wHpw3wbO1/J6w2AJ1gd1BBfimA
 bAXbRFtWANCprA7yvNuhA0o8iosl1ieYhk4dD0n4Qee9E0hLKkcV1QFEgc8Fk+jCLwqYMtoOUe+
 KL26YQHp1n5qn3dSVc1rElaw+YylAfDNOjE7xI/nrs19GG1NpI+7cssEsdJzKP+Q7MUODZPAc/Y
 ix5E3xzgh7VWMccSme3KKF3ERHKMrYMzLh+Rp9l7Y8/yttjwyEK05q2F
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

MCL(Maximum Copy Length) in the Identify Namespace data structure limits
the number of LBAs to be copied inside of the controller.  We've not
checked it at all, so added the check with returning the proper error
status.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e031c2250a84..355668bdf87e 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2855,6 +2855,25 @@ static void nvme_copy_source_range_parse(void *ranges, int idx, uint8_t format,
     }
 }
 
+static inline uint16_t nvme_check_copy_mcl(NvmeNamespace *ns,
+                                           NvmeCopyAIOCB *iocb, uint16_t nr)
+{
+    uint32_t copy_len = 0;
+
+    for (int idx = 0; idx < nr; idx++) {
+        uint32_t nlb;
+        nvme_copy_source_range_parse(iocb->ranges, idx, iocb->format, NULL,
+                                     &nlb, NULL, NULL, NULL);
+        copy_len += nlb + 1;
+    }
+
+    if (copy_len > ns->id_ns.mcl) {
+        return NVME_CMD_SIZE_LIMIT | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
 static void nvme_copy_out_completed_cb(void *opaque, int ret)
 {
     NvmeCopyAIOCB *iocb = opaque;
@@ -3167,6 +3186,11 @@ static uint16_t nvme_copy(NvmeCtrl *n, NvmeRequest *req)
         }
     }
 
+    status = nvme_check_copy_mcl(ns, iocb, nr);
+    if (status) {
+        goto invalid;
+    }
+
     iocb->req = req;
     iocb->ret = 0;
     iocb->nr = nr;
-- 
2.41.0


