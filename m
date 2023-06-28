Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C09740CA6
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:25:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERQK-0006vV-7h; Wed, 28 Jun 2023 05:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQI-0006u0-Fj; Wed, 28 Jun 2023 05:25:14 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQH-0001Ll-0R; Wed, 28 Jun 2023 05:25:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 262ED5C0241;
 Wed, 28 Jun 2023 05:25:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 28 Jun 2023 05:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1687944312; x=
 1688030712; bh=jIrNQjCeIfQAQMFuWqOGIuTcnSKlPmEGEl2PPVtk0HM=; b=L
 ql5oL57sG9NscJAZKs1IExCMhiay3wLT7zPqDV/WNuMMtLQODjXscU9HraEEW0VD
 JCgcUbqwYbqoeC/c73ysn4kw+hbArVQeArmZScg7nR4/JKK1MRrQQENfjfHJOPjt
 DzcWWPJnBg7aaR2wP46HGnCzGGQtQsR2p6PEHk76OQZ9cA3XWE+scIwDyxRoOq0W
 MDKXf2UwsDv7pEGJuluoXPGo7/kKjswP44lro1q63Jm8QAvPEL2ylMkdl4DR1niG
 PfxQXMzliJir+ysDAp/TMlrhoMZdFT9X2/fjWpZ3CsRtx9lnAKe7y2pKl4Ka41+g
 dfDXoTDgZ4Rtc6CJiavtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687944312; x=
 1688030712; bh=jIrNQjCeIfQAQMFuWqOGIuTcnSKlPmEGEl2PPVtk0HM=; b=R
 0N35L4xgzDv/gt+HWr+ce3udSeDXw20JHCJyllx/nJZYe7bOysJdXTDzZ+oXWLuQ
 GHBRcqiij07+a3rnTZzeDoSuGByjxp79NirsYte1IwQKX934mbCNAjwOiUe4GFrh
 AgfBGhU3DvNT3/FuRvIJuRYF5ICNwWZ3BP+3lrW3usyyxqMUlK6wQFOMiFpjzAo8
 54yrAk+wk44BvAeKpmn6MqBqpp0+eAVsSqatJPJB6j9baBybzLixxQxIFtslk/KG
 3YErCLw0t4Ov1ourKhnkT1iOvWJQddEMrrDP5v3PlVvnkxpekn/3CHiqCyn7lBPB
 8E3PtB6oF5pUOyELGMA/Q==
X-ME-Sender: <xms:d_ybZDZ4bcMwKN3rwP-kDrn3JQIUkSDk2HYNuqgAUhpSy_aJA1PwbQ>
 <xme:d_ybZCbPWn08SfxOu5oSCXqpWG124ENtgieEsWNTKyLBc8WCATMCrU4tMgXSIUocR
 _YnSG2DukcMNTT9WqQ>
X-ME-Received: <xmr:d_ybZF-vLthIt_nA3QAHdDMGef2VmDLNysH91LoGSRtedi-siltThfWkXaUpZuDYG0JrgT2p3DM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgddugecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfeilefgieevheekueevheehkeefveegiefgheefgfejjeehffefgedujedu
 geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:ePybZJpx50-GSVSySwBZwH7eqUwO1NI45nyW8eoIZhwXUWMk3KE62A>
 <xmx:ePybZOp-13dJgJPQBUO1GHdYLXEmOOsJxcG7Ufnp3mkCOuyo4pBfGA>
 <xmx:ePybZPThZQ-n4jMxY2z-10bRSaqJMKFg9EL1WmPXbkbb9PyobLXsFQ>
 <xmx:ePybZLifI-8Cbv9kLOR_jCCiBXNAxC0xD9FZr5H5l6iJrocoWqNzBg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jun 2023 05:25:10 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <j.devantier@samsung.com>
Subject: [PULL 5/7] hw/nvme: verify uniqueness of reclaim unit handle
 identifiers
Date: Wed, 28 Jun 2023 11:24:59 +0200
Message-ID: <20230628092453.39602-14-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628092453.39602-9-its@irrelevant.dk>
References: <20230628092453.39602-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; i=k.jensen@samsung.com;
 h=from:subject; bh=3vltZ98tCm0E+zi8rOmVK306W6qCc37UtTzfMKwuHWw=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGSb/GZlVPZdBnHJlXT7sY1N/72wNPJRO93uF
 NTfauZ56FzUPIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkm/xmAAoJEE3hrzFt
 Tw3p5o0H/1+2+uIvWmJHLqfu7A4HnLzL82rhLgrtEIcPZOYYBPtQGL6UmluubWwp143aPkmDXlj
 KuPty9xL+oRdRcDJJkdScJqS+BSwzXExVH2H2EYLYzc04dAbrAoWtCh2l2+w07O+0JFjOLdpxzr
 kvimQY/47tL8pQpoL/kMpzcKBc0BvXvxgopdfp0BSXfsv/T/9FnUckyxByMCttbkuyrT0YIwpxZ
 4Npi9RmOENRJyPKpnBNJ17Yo8vXIfYzbL7QMDDnjCT++GwBj8rr+dJfFIilcBzMUORBIS8CjW7l
 b1nImCN7L9FdunKru1wqJrzVz15DZOwUCHWzJTskkYAEcDWbPxCdNarj
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

Verify that a reclaim unit handle identifier is only specified once in
fdp.ruhs.

Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Reviewed-by: Jesper Wendel Devantier <j.devantier@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 050fdaf50fcd..c4ea2033bb1c 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -453,6 +453,17 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
 
     free(r);
 
+    /* verify that the ruhids are unique */
+    for (unsigned int i = 0; i < ns->fdp.nphs; i++) {
+        for (unsigned int j = i + 1; j < ns->fdp.nphs; j++) {
+            if (ruhids[i] == ruhids[j]) {
+                error_setg(errp, "duplicate reclaim unit handle identifier: %u",
+                           ruhids[i]);
+                return false;
+            }
+        }
+    }
+
     ph = ns->fdp.phs = g_new(uint16_t, ns->fdp.nphs);
 
     ruhid = ruhids;
-- 
2.41.0


