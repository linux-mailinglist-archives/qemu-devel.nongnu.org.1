Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E1A772327
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 13:55:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSyoR-0001Wc-N3; Mon, 07 Aug 2023 07:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qSyoQ-0001Vs-7G; Mon, 07 Aug 2023 07:54:14 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qSyoO-0007u0-Dp; Mon, 07 Aug 2023 07:54:13 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 0AFB4320095B;
 Mon,  7 Aug 2023 07:54:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 07 Aug 2023 07:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691409248; x=
 1691495648; bh=JuIqZ1lKO1qu1M7dOjuCMFT+dWdiAaliE0a0dIPMhHk=; b=A
 l4u6Sbsb+vzk1gS6tptMVpk+abQ54hdUlvK3TQ38XBkF21LvbvSHCAC6tTGrjxsp
 kIZ4mJ9EQDgHxwPY7OO/Y+79WRQQqotP5PhhGKFiFmIVkr9rLM++LERRULHfDTP5
 Tdo3ES4gTDLmtxzIr2YasQ1rpzzEmc/IEg/n9JZ8IYx1ZWo9gGC3w3qnPX1Va9Ke
 7plIHOsdoajbXO4tE5a6hz7zM2h0Hfu0GpxClid8z7cqZZ463LrwE+UDbcFNjk91
 va5SSvPOcCQNXKv4nf9NF9v6dphzkukuvXNIU7Ot71HzfLftg4Mo59zh7IhiolQt
 13501dV1das8wfGGxJnEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1691409248; x=
 1691495648; bh=JuIqZ1lKO1qu1M7dOjuCMFT+dWdiAaliE0a0dIPMhHk=; b=a
 3NQOIP9x3oli6cobuQ7pcttaDh1F9mle7lUMLEXiZf1rSV6FGCfHe/dj8/ZgTkn6
 N18Vze7LOUFVgjeJN3a3OqbTogbqyhHJRQ5ESp2VKqg873a/2TVmzHBf2oG2iFOf
 iDBC7r36nZ9v91JQ17OPHwRnXbFB9Y/djbzxccZBRZwCtKZu438Ebg+wtjNzc46Y
 jLU4rwvswcZ2h1uyvcQYQiymFuNWve824DhrqkHLY6vplI6dNuR0izxNbjjr+HOt
 8J994fmEw6uO8BiDX7G0EoMv2NQbnvyFs6+eopjBHYUbL3T2ZK7jGWXyeI9nl1OS
 Y/D73T2OvObGZdLjxVIlg==
X-ME-Sender: <xms:YNvQZHc_qw1I2qywyjrnVRrOXsYf5M6rq2kOq9vQcUehxkHLfQpXtA>
 <xme:YNvQZNMLmagHSkWzwNEetXt3wW3AdFjFvpoUI8gtYRWcdrD0gfSC-4u0VfIKfHxoj
 vAOFMcLAceBJUk_Fzo>
X-ME-Received: <xmr:YNvQZAjzrSH57V-pcfP1Mh_UL54zPeonr5CLKozgBKN8mnJ20QIk2gi8vIpVfTZ9Se-j4-jGr1e1YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdeggecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfeilefgieevheekueevheehkeefveegiefgheefgfejjeehffefgedujedu
 geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:YNvQZI8Wrd_84RKj25VPOK1zCunpbc3n-AQEMA-aXVPInfGwqF6EeA>
 <xmx:YNvQZDvZDsm05-YPb5fj2zLGG3FZKp06l6aFybz1qBVkOclwlQSsVw>
 <xmx:YNvQZHEcyN-zPzaJYAM1JjXjeUKUf_y1Vj4Hm0rlQzjc6fwlF43Qhg>
 <xmx:YNvQZBL5ABupSq372omWQI-ZGRHSGjspyzJFpMCwm4MqB7fS9eAPCw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Aug 2023 07:54:06 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 1/2] hw/nvme: fix oob memory read in fdp events log
Date: Mon,  7 Aug 2023 13:54:01 +0200
Message-ID: <20230807115359.123-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807115359.123-4-its@irrelevant.dk>
References: <20230807115359.123-4-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; i=k.jensen@samsung.com;
 h=from:subject; bh=Wwbuyim3FkkfQuNb85Ar+XHxUpYm7q9olERA4mQ7heI=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTQ21hDDCvuj4kadAeYuj1nmHWzLmJqUiNS4
 OGJkShr0EvqiokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk0NtYAAoJEE3hrzFt
 Tw3pGOIH/12cP0RcZBvxSRPkb8aVNUfVjNnqqn1plTAmluvLkhE84ea5tJQmFLiAp53LGN37+cl
 QI+iJ9ha/Iu2t4pui/FPSPVdGCAk8/WspOdy3DpbFuDuGWg4Cm2mTBqOmnjGteHPhEAsJM4zZVV
 CiBZO4y6rAIREE94IjnsjBNuQopwrEcb4xxj+9jnFexHBt3Qo2SHQIdbTIqJKRgkPrfCAbfY5lQ
 MUrA9Xw54hAnnH/RzUREXWtBDEbCtYNZWm2ai+lnqtqX90/ny7jxya37JOdAul2SECrZK+ar6Gm
 H78dKAYobgGc92vEUG//0Km3tMu5Vu4PmZhIhvOhSdfdiI3+Q+OkAal5
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

From: Klaus Jensen <k.jensen@samsung.com>

As reported by Trend Micro's Zero Day Initiative, an oob memory read
vulnerability exists in nvme_fdp_events(). The host-provided offset is
not verified.

Fix this.

This is only exploitable when Flexible Data Placement mode (fdp=on) is
enabled.

Fixes: CVE-2023-4135
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Reported-by: Trend Micro's Zero Day Initiative
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f2e5a2fa737b..e9b5a55811b8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5120,6 +5120,11 @@ static uint16_t nvme_fdp_events(NvmeCtrl *n, uint32_t endgrpid,
     }
 
     log_size = sizeof(NvmeFdpEventsLog) + ebuf->nelems * sizeof(NvmeFdpEvent);
+
+    if (off >= log_size) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
     trans_len = MIN(log_size - off, buf_len);
     elog = g_malloc0(log_size);
     elog->num_events = cpu_to_le32(ebuf->nelems);
-- 
2.41.0


