Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D013B76F2F2
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 20:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRdJM-0005nX-4S; Thu, 03 Aug 2023 14:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qRdJJ-0005mz-MX; Thu, 03 Aug 2023 14:44:33 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qRdJG-0007Ez-TI; Thu, 03 Aug 2023 14:44:33 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 6200A320098A;
 Thu,  3 Aug 2023 14:44:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Thu, 03 Aug 2023 14:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1691088266; x=1691174666; bh=Ju
 IqZ1lKO1qu1M7dOjuCMFT+dWdiAaliE0a0dIPMhHk=; b=Anx0sevxbbj4YWe95D
 HfBgZl7IY1ZWhtq1Nsyr1GrDETHd+2D91V7Pzc99mRtgcnXxK5/0csAiMiNyIRSt
 YJbk89CppkUcdAncg2fhVIhH3JkHlgNovYNAbRPlg8y8+ejniVL8AOiFNIw6gtyZ
 oujKyVfyferIpnZIN5Emof2H6i4taX3TfSUCJ7loofjHA8mwUuaP5JseSrMby4Xz
 rJAorBz/74KlRsAyVj31DqDLMrIYpFNZwdjY9xS1WDbP4Xbnlr7D/vF4BJNwwohW
 2SPMGXHEEVUWUCPaHkxktfzt808NSOLTwldmfsRTRKOpKrSc9MlMnzODE8qM4VXV
 CrKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1691088266; x=1691174666; bh=JuIqZ1lKO1qu1
 M7dOjuCMFT+dWdiAaliE0a0dIPMhHk=; b=bBFKDSR0rUUp+LRdfQ/vpYQ58N4n5
 nLmtPFZW0N2LvVcXKjuQOIBlK9chwbO85nwU8sTQ53YGJYyaTq4YMk3s1ZY6T2KJ
 MhAnCeCiKuJ8QNvJ21dO9jjZxbaD74PZr8VFM/SmZXGJPVj755NWpSEcmrxXPN7F
 4Y4q7ZNwBwZfDQkr+DNT4ldSYZDRFFQT5H4VDdnS03w9ar//Ou51HwvhoR1NeWtP
 kX3U8dy/yk950f2w84fzmYg23bfVhzaoJj/R7HzlxZ5fpWHufom5M6mEZ83tV9lJ
 V44Kx09uLWPdZyV58yE60T0yLSL/w5WzwWSKkGIfNYJy0JgJX5aYGn1JQ==
X-ME-Sender: <xms:ifXLZA5Hgy_SZ_SaO8XLN6uz-7T9QsnLdjyJnwsoXusIDROeupkOhQ>
 <xme:ifXLZB7xmRkbayLgO78dM7sv2QJFoKV1ihCJduKGlC1lXnMruRcz3-NOo_NFSxKW9
 vFAXg0_Dy1YV0FDIgI>
X-ME-Received: <xmr:ifXLZPf1NHjU3GF7FT9f_3dYN7xNHCQmhXOsjRACYNpmZcOiSbeagWIEEFJrUpW4KN26W6V0Wuo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedvgdduvdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnheptdeludfhgeelheelledtjefffeejtdeluedvgfetveffgeetvdevkeehieeikeet
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:ifXLZFIQIPoOvkg-jO1HhEgoMhqjdj8ioZhSV8rtdxzCLgVI9zfRHg>
 <xmx:ifXLZEJjLLJbub-Pha8I59asUHVnwCXYPyCq0XfTNRwvQcDKGv3Pfg>
 <xmx:ifXLZGwr0vt95dQvWzO_YIHglykERyS4PBQ5g7qzeozp2Ad5liLqCQ>
 <xmx:ivXLZM-LqDQmJ35ydwip-hZKrOA62EB5yvX-r63BouCLebf7ynzNpA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Aug 2023 14:44:24 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-security@nongnu.org,
 Keith Busch <kbusch@kernel.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 zdi-disclosures@trendmicro.com, Klaus Jensen <its@irrelevant.dk>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH] hw/nvme: fix oob memory read in fdp events log
Date: Thu,  3 Aug 2023 20:44:23 +0200
Message-ID: <20230803184422.27521-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; i=k.jensen@samsung.com;
 h=from:subject; bh=Wwbuyim3FkkfQuNb85Ar+XHxUpYm7q9olERA4mQ7heI=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTL9YZDDCvuj4kadAeYuj1nmHWzLmJqUiNS4
 OGJkShr0EvqiokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJky/WGAAoJEE3hrzFt
 Tw3p2FYH/2Ja/NClCG6upjqmHWf0YPQoQR8v5UoJUkd1T2PpgvXf1SdIf4fftGeXpSQz1R0vSdm
 NmGbdx7bNwkZdBfzqw5x2bxx7kZUoZgfNigsRaIWUdQ9wAA4LfEswY1pYSeHOdNZlQJAEbXlBz0
 PBfeF9pp9w/lUsDinS9dWZEqwP3h6Rkbcy+Qabckaz4AievcIs2Xf5r4HeKH+DzpfwrdQlzFwTb
 21VxiOfGDiuuXJAIIFcDgcxs72MW6ikJ5czGBhQL9c7rFRLfckyh2hDW+UwhnoWgmFHhQR1HXOw
 P+FIo1Lr087DMerbGEyaIMwYwkZUej3C2XHKkGddZq1MQOaWS89jWKTS
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.20; envelope-from=its@irrelevant.dk;
 helo=wout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


