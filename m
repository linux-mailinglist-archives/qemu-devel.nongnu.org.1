Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C51FB79D38E
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:28:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4MH-0001a4-7H; Tue, 12 Sep 2023 10:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qg4M8-0001XB-MI; Tue, 12 Sep 2023 10:27:08 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qg4M6-0006Fv-Fc; Tue, 12 Sep 2023 10:27:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 22814320098B;
 Tue, 12 Sep 2023 10:27:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 12 Sep 2023 10:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1694528822; x=
 1694615222; bh=T5/wSFH5UysJriXBNU9TNxkLsFcDhOioChngTaRpK3Q=; b=r
 +UKaOfFmRHyyKX4TeQay5uu+FLIM6px5K0cDkbN02JZTpT34mR9sqhnc6afpthV6
 cT/rZMXepDEP9LGkVpbwQf8hJzBg41z0Rd7vcyfhXmkN5KX7deJZdlEorygi5yxA
 Atqi/KEfecdtz47L69uojEIdoyrYSWwM3X+NgF5U7vLOVOcdoNjXDcYCsXiDnCGz
 3qPrKPwfRG0hlCI1I92iJZ+4dfvKn61GO7KBcBv1pRABOMaxwBUFjFvSXnsdnuLp
 VCioXKeDqC64uhRon9QUiJMBXw557Ok/h4TNni0S3aaKyizqFaKa7kBge0gIDH1q
 lFesa4iPIz83WYXr6+IwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694528822; x=
 1694615222; bh=T5/wSFH5UysJriXBNU9TNxkLsFcDhOioChngTaRpK3Q=; b=R
 ynVoW7S6tMus41nELXFqG362gTwDaHvk2T8dc6vKtMzas1NvdgseYAaEdgHTzIYS
 1oWSBVYl5btZDiYNu2730sITKv8rfQkf8+Z/JtUEkZfWQO1vLLEsREFuoICBKVcr
 9ZmxOeOCgZMVN89VqXvORILzD7y72qcPP7ze+pKcfvlWSA4o+67fX9W78E2K0Qbp
 jG3Ut3dO1e2oZcbulRL3dvS2+m1yJCrnFErbevfeN1SkCvwNM7COWCHj129OP2Ma
 OCHJ9aklJp1rHZkDNaBVgTCD4F7Nx2DeLG8Gk3PeUJiVzhxXl3nWZD9vearCQtH4
 O2El84+LplqiOd9oHH+9w==
X-ME-Sender: <xms:NnUAZT83lqKrhSstFwxTUXoVi2sEJmp5t6Bqkfj_CEHUw1ynM_VNvg>
 <xme:NnUAZfs7ogdntKXbJb0p5zbrkBitTo81kTPjdrbS4drog6GBPvuTuM_whXS8iJW9N
 E2oPvU4y_N-lykWwFs>
X-ME-Received: <xmr:NnUAZRBku-5fdVUmOOdXS7NuuUs0kqh6iHlyHSCqd939_j-Jrccf_ezX6EK_e74tx0aqf-WeO4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgjeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:NnUAZfdmU2Vqe0ge-udadO6wwgNfjHCyi5BZLSFdCz6NoB-KRMk8ZQ>
 <xmx:NnUAZYOF_Gxglx8PSpgrnZ_W5NWBkSIg4Ns2g2KHpeg_UUzbCIv83w>
 <xmx:NnUAZRknI3fE7g1oSvennfg-2pfTh6tJvS23gU34Bok-sme8ZQjyxg>
 <xmx:NnUAZXoz_MX-AlZKQ15_t1rUc6y1BIxD68nqfKTH1jmGHTaBSFqkrg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 10:27:00 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 2/2] hw/nvme: Avoid dynamic stack allocation
Date: Tue, 12 Sep 2023 16:26:52 +0200
Message-ID: <20230912142649.11002-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912142649.11002-4-its@irrelevant.dk>
References: <20230912142649.11002-4-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=k.jensen@samsung.com;
 h=from:subject; bh=k8Y7iQz7gOK9fuxUsAHHCrYcflluV+Qz2N+9aldrpJE=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGUAdSrjujEk+l6HiX1de5lsZ3HThXQrBQkwU
 Xa9JxrwkYN8EIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJlAHUqAAoJEE3hrzFt
 Tw3pGFIH/ijZb901m/wUU0yApw6ONIxcyLqh4GM3mnHwFukiBb7iAEyhUVWbwl1hfq6uxB61Vkc
 giEcT+l5FSxZp8bfMlNeNKwmx0fs+qyx1HNmMuUYC0nyAawyC/QZnwDIQCap5geVCmZYCdNPoU/
 SrphZxi4qQ6Oj1/YOmeoGy31vJSRB2DJvXOOiX3roqk+P0M9F7N4A2jyx8Qa8qDxRy/ymGnaoHv
 yKHtVsW3POY/0X+akDXLVTTJlle/oitBqEqYqPpIpLVj4NGzq23/tJYQHElAZQ9X/FF7SNp+lz0
 QKaRrXX1P3BabH7NXJEeorjbC1sf9rmDvCvd3WAw2/UwZPIlql3QV6hD
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.24; envelope-from=its@irrelevant.dk;
 helo=wout1-smtp.messagingengine.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Instead of using a variable-length array in nvme_map_prp(),
allocate on the stack with a g_autofree pointer.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index d99a6f5c9a2e..90687b168ae1 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -894,7 +894,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, NvmeSg *sg, uint64_t prp1,
     len -= trans_len;
     if (len) {
         if (len > n->page_size) {
-            uint64_t prp_list[n->max_prp_ents];
+            g_autofree uint64_t *prp_list = g_new(uint64_t, n->max_prp_ents);
             uint32_t nents, prp_trans;
             int i = 0;
 
-- 
2.42.0


