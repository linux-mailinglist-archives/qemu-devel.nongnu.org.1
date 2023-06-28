Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C130E740CB3
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:26:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERQE-0006rl-P6; Wed, 28 Jun 2023 05:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQB-0006qS-II; Wed, 28 Jun 2023 05:25:07 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQ9-0001JL-9u; Wed, 28 Jun 2023 05:25:07 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 8A1AE5C01EA;
 Wed, 28 Jun 2023 05:25:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 28 Jun 2023 05:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1687944304; x=
 1688030704; bh=nc9Hvjg/exthUfwyl9oW072OtPhq6B/BaXkQeS2Ls+I=; b=B
 nex0vNq/qenAE2RYI5skwK6vNMKX2Bk+puXj5rqY8iZYJPOEx+ZoTxPv/ny9eWnX
 BuMBGffLnlmDS7LT493gurfd0i0QPnhc4CWHoxV4AKHe7lil/vK+uFGMdDW0PwL6
 AKgQlPwJ2JrTd50Xjs3MfzrmkKzI+4XtAFH+E+ynNum6sVTe38QdIDaYrtwgK1jx
 FOTWNsF6kmh6ynjfenT7HXXtZCavlX5bzcbALZSCQylYZ29VewWQwQJp0k8PuWbW
 f25QvUq02uSXdd25/D5JRlPb98IuVKgdnQZC1bc1/Ii0+ybuD/wSZWpcznmy0pfP
 tzaoeQ+6Gaim9f8AvAgKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687944304; x=
 1688030704; bh=nc9Hvjg/exthUfwyl9oW072OtPhq6B/BaXkQeS2Ls+I=; b=m
 WyMBgukHjzVdcd+oJWvAU+5L+0rW7k8Up4GmtHZXFcFw5u7SonvzI+Wil4fgkwA2
 PhGZ6G6MwJ9VrEmAd1y+HZJJNHpuVH5UCoHBzeekymbVppfqC36y/ZqNta1A3QKk
 cLXQyak7BQAxQ4GGq13Z2AvRdVBUi4FB+aBAQhr5O/QVNKmuh0YJMLfunhQJR2pN
 8ZUJZGpT2dyyA9R9rP8OtYB2vsTNuZejyKPpxWlNGoBs4XQg9kAaGluK3G4KPSdn
 S/9CnP2ltbc0u1Xi+LGP7MUfkw2YqmCJUob1hHDqpGaRaG6UZwrHaU47ZM0s4Old
 +0eMqRbgAmoRIQ3ZYN5PQ==
X-ME-Sender: <xms:cPybZAwbom-eNj8GUj0rUpBPKFgMhSiQM8V8-F3JVABNcTe0eYYxcg>
 <xme:cPybZERoWMuyPZFxxojmJDtId9Vr4RHzFjakTfmp2ux7uJa0evZDfRaPWPNYRkkjP
 kUjMt0_R0TLLV9H32s>
X-ME-Received: <xmr:cPybZCXVYRDidmscfc30oOZmJ6Fzzr7OKKXr9egxuKxelSZ-eWiNyMLuKDgJZraP-JuWEUWHbo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgddufecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfeilefgieevheekueevheehkeefveegiefgheefgfejjeehffefgedujedu
 geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:cPybZOhqJrh4F2vMMfZmgLKK3pr20G6nPQMJJJL0aPrD1BhzO9HsHw>
 <xmx:cPybZCC5i-aBauFz4VbgPH45b8Zj3XQMph70M14cV6niqaUt4Prryw>
 <xmx:cPybZPIuN5wNpBPbycxEWzS4_wokvu0G0mPE9qyxLPGLqCxnOGVUgQ>
 <xmx:cPybZG7T0hNkG813gCbDNbWdXAJSmh-0u_Ii1U0pknFAyt2wmfhI_w>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jun 2023 05:25:02 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Minwoo Im <minwoo.im@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 2/7] hw/nvme: consider COPY command in nvme_aio_err
Date: Wed, 28 Jun 2023 11:24:56 +0200
Message-ID: <20230628092453.39602-11-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628092453.39602-9-its@irrelevant.dk>
References: <20230628092453.39602-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=k.jensen@samsung.com;
 h=from:subject; bh=SzPvUmf1mwaRcbQQTu9QRtcGmSDNxD8XoXG5+zbb4zI=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGSb/GYe8JeNk/d+RclM8ACvIRty+82BulKac
 0KHZbf85ecoxokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkm/xmAAoJEE3hrzFt
 Tw3pZ04H/1UwsbdnxRqYd56fl6TMIBMtozx0ASK/RXz44JKznq969ysT/AAqd/RWtl9MW/YZK3Q
 0xOvkIuN1Hm/AlcnmKbZ7BnXuVCjIAsR/8WbvSmV3WhJquJff3xjJlv9vLieXFekFTPonjZFYlW
 bCB7Gb/n5sCizTu5Y0bd9k5MiJ/+bhvbUm32eIcdM6SUD/YPupX3oX+9/YLuZlO2TJ4jO63KXQa
 aMQCA6wv8B5pnkFzbaJihBp2+nkuu5JNk6oa/exSvUY0IvZMCm8bt5s+zmgSKKSVhM4ijyBG9dR
 W5c54+9LrEajTwH9wOY9E9Vj6KVJPETnOOLRM+POWASb3OvIT55Z1LOl
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

If we don't have NVME_CMD_COPY consideration in the switch statement in
nvme_aio_err(), it will go to have NVME_INTERNAL_DEV_ERROR and
`req->status` will be ovewritten to it.  During the aio context, it
might set the NVMe status field like NVME_CMD_SIZE_LIMIT, but it's
overwritten in the nvme_aio_err().

Add consideration for the NVME_CMD_COPY not to overwrite the status at
the end of the function.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 020f37a780e0..e031c2250a84 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1755,6 +1755,7 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
     case NVME_CMD_WRITE:
     case NVME_CMD_WRITE_ZEROES:
     case NVME_CMD_ZONE_APPEND:
+    case NVME_CMD_COPY:
         status = NVME_WRITE_FAULT;
         break;
     default:
-- 
2.41.0


