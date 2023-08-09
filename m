Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23731776163
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 15:40:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTjPI-0002lZ-76; Wed, 09 Aug 2023 09:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTjPF-0002k0-IB; Wed, 09 Aug 2023 09:39:21 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTjPC-0002hL-Vh; Wed, 09 Aug 2023 09:39:21 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id CC8315C012C;
 Wed,  9 Aug 2023 09:39:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Wed, 09 Aug 2023 09:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691588355; x=
 1691674755; bh=wCay5dbNnQDqO2GlNeVpeAedGu4LOH6JZR1cxTrIzyY=; b=P
 jXgM+BNUORCR7XZW1uoPtoA7CZv80QiotoAapW6yqyhZsSYW8nyZuCKN/gr1PzRK
 auPSyS8kqcM7xSzkAUqoZ6ArJc5MYmsv0eqPH6wsDd+waSeQddafsP4e6i3r/p5r
 d6eRj5QECAB2Nt/reqgUv/M02BpTHBYo6CTLCG0Jqo5icL0NP7yPH9w0xQhLNfZb
 AJOboLJeKK0PwhHDKBtBBZyyCiE8QwRtpoDljj1D4JuuT/KnTQKMTeZBYFDZs4iK
 ilzbvmIIx3oDZIpDBku6IclphHrbw8C/jn0sQl8lmYaBN/K0q7o6iF5wZAp5Ul/0
 j3t4bNHZkFJPYBYLuPLcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1691588355; x=
 1691674755; bh=wCay5dbNnQDqO2GlNeVpeAedGu4LOH6JZR1cxTrIzyY=; b=N
 ZXIMeBzNXLurO1TD0+OMF6T87uDv72v6Q/GX7vUeoHhuO2e3kHopcz+2Y5kzYggn
 0KMfq0hRc01N08BiNfMgie/AhD/dftCnve7A/UMATztcTzumoYnBTMBD+L/zNZsv
 iG27m+G01SoFvrEv5rOBl3YMDIo1Ku0mGBqHRPtZE1n2YGF8SMc/jCxO013X7GLf
 siANLLuu6AxC2CWBYa8dpfZbd0Q/GB1nnORNPvn13iE6BPvQVO+13SzCOgYwHxgo
 bMFubYxyu0TOJzzyfcMk75wUQdrvHGvKHb/Koh1AFlUDDNEB2TG0TcWmm0edyFdv
 agSkSww6u+wij9igXbkmg==
X-ME-Sender: <xms:A5fTZKyrRxPL7-ipkeH-zLS0lPDA6udD2nngo1gC77i0WsLPl321bw>
 <xme:A5fTZGS8RkwdxEQGSQB3NmVBfjTCkd3Ei3nq6dRFH-q7T-jJttVabWdrA-gj1UNZa
 MwUYvylXXTitMOK0ZM>
X-ME-Received: <xmr:A5fTZMVm8GLmcynAHgcE5MGmpHVn5UXg-MROpEIA18z0J3YPbL4ZgzCw_5X8w0eaHMoOm3b6ofU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeggdeihecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeefheetgeehffefgeekgffhgeeijeekveffhfejveefkeduieeiveehteeludej
 udenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:A5fTZAgsMPUdTjRv52D1DxTQ9YXUexNDAgCz-D_8wazlGaWMXBNwGg>
 <xmx:A5fTZMCztXCWftdrhpN3ZOP7afng_GugfVnbtGytjcTCUbqnDbYZlw>
 <xmx:A5fTZBKlwvKz4KXXfkp7ek8dVa1wr5auQRLEFhRO67NezJjbehbS7Q>
 <xmx:A5fTZO1T52mQGxyRvNQ01wzF9cvP3K3ulIH89eWAXwepqHwb7LpEEg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Aug 2023 09:39:14 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org, Jesper Wendel Devantier <j.devantier@samsung.com>
Subject: [PULL 1/2] hw/nvme: fix null pointer access in directive receive
Date: Wed,  9 Aug 2023 15:39:11 +0200
Message-ID: <20230809133909.45818-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809133909.45818-4-its@irrelevant.dk>
References: <20230809133909.45818-4-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=k.jensen@samsung.com;
 h=from:subject; bh=8zxP4G6hW0k+nMxUcpBk6P+QkGbwFl0Xn43SbCWW3Fw=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTTlv6M3bujKrYRAAelElbz+RSpdsCkbpD/8
 Htl+/pVtzWFmokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk05b+AAoJEE3hrzFt
 Tw3pIg4H/1B6mIfmHeDCDOrNVWd/+vyzbZaGWL/HyrAalRJDMJnjD2U4c2J2JwU5EWil0EiL/Pu
 sy8oZ/AQQw0qo+Vm2/GwG+1hYo0OIr091dZR36gZieouoL4QrfQsBHyTmE+SGzLPubJuEqU6oew
 Va76YjX/Ge+sj3OTRWxJ11ASaXPyGduPXfP4ClaXoN6wCzOZIRCXqZcg47EQM9AxJ1RNabFPmw9
 f2wJR+Ucwf2JbPds1DgrrjcOXp5HKvSLJDlRFUe6UYH3Mg4LaP9dXWYLjVFxGPyaWsQXs3KBuvu
 Uqdntnf1pjWqG4U637sscHqbsMxPwSnMMbkTr9KBKvBkPBqb0yan5KtC
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
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

nvme_directive_receive() does not check if an endurance group has been
configured (set) prior to testing if flexible data placement is enabled
or not.

Fix this.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1815
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Reviewed-by: Jesper Wendel Devantier <j.devantier@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index d217ae91b506..e5b5c7034d2b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6900,7 +6900,7 @@ static uint16_t nvme_directive_receive(NvmeCtrl *n, NvmeRequest *req)
     case NVME_DIRECTIVE_IDENTIFY:
         switch (doper) {
         case NVME_DIRECTIVE_RETURN_PARAMS:
-            if (ns->endgrp->fdp.enabled) {
+            if (ns->endgrp && ns->endgrp->fdp.enabled) {
                 id.supported |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
                 id.enabled |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
                 id.persistent |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
-- 
2.41.0


