Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349177382D
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 08:28:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTGBy-0004UN-HS; Tue, 08 Aug 2023 02:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTGBv-0004St-Ig; Tue, 08 Aug 2023 02:27:39 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTGBt-00070X-Mx; Tue, 08 Aug 2023 02:27:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id A08975C00CF;
 Tue,  8 Aug 2023 02:27:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 08 Aug 2023 02:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691476056; x=
 1691562456; bh=LiVaiUPQkEJAbjOQlo74CUcpKHBAY/5caLUVHR53Y9Y=; b=D
 IYnj1oT68R46ZAqiCW4zQGgjWNvFpML0ZTcTLgpVZr/gAOseWJ9dJKtmnxMC7YoY
 uVUFoKxs6+ehTZsID+skPYoue8G6P/KXBvBDBWu3vzvvPjVUm78nchGCrE9Mvy1N
 X4YxbdzcvKlHcoQMGOecMSgxxRhvJ6LCTbAhP7Lh6cdBLSIiKPajtI5te5kXua7m
 kO1PkiMYdCqrL/estbEdbARmlEo9Tfp9LNIiHB5IRdzERbwQA+XljrJPdTorVUJ8
 jTQr2M96aJoUodFcDhWffkrF1Lo+YwlcZMZW0Imhp87eWF+s/3M5e4UB8njBzm5k
 rhpcjlPrsr7Rmn1+HcPPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1691476056; x=
 1691562456; bh=LiVaiUPQkEJAbjOQlo74CUcpKHBAY/5caLUVHR53Y9Y=; b=H
 qWAEy2eLBvSq+g1rzBVN2siZYO9pd7wRETYSMKBg0mXDHYwFphmTvXquJSmzTHRE
 /OrzMtOWquMysuv8o7mFA3xsAShX8TPq57ZEVV7lLwoUbIPyVhloztEb0pFVnc1V
 NFT6mAWXvoW7yCOqZ4/YzXorxd1dgAvKxYprP7rv4ijgW+mGLVMmqzqYMBHANCsb
 AVkF1j8pxJGwxjP3DiPngtmwv9aMlSWzK9S9Sx0FnzjPjOmSnXiBTnnHW9qwY6i0
 gMfyK4NEbcBE5GL/J0vYfHUjQ7SBj92zrZfJDAn37CgJYfbQq+eh45dnZ6rMtKje
 4tWd1IvofDus1aRyiZ+og==
X-ME-Sender: <xms:WODRZGlAf9QMr1p7XCO2ONWj1rmgq3G6Ezae5vO61sx0Cdkoc6XeSw>
 <xme:WODRZN3ezoShGy9F__3sI3j83N931UFbSTsJLGu9tdBNmMIY8ZdEe8A-m8YL-vb5T
 Umi-cvjm4HZYX8FqGA>
X-ME-Received: <xmr:WODRZErKa3nUOPG4_C6iBYYbrpeg5kSpbhn1jXchPlnJkqYrZV_HRDWfZhewnIZwfkbh34nUhXHoMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugddutdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:WODRZKkJv3cGSoRHkr9f1bYEHSIMoeYJw7htiw1Szs_HGU7m58jZHw>
 <xmx:WODRZE23FFEURXDG5VUefaiE1g9jyIa-P1T7ZVSmk_4I1oEmu3yt-w>
 <xmx:WODRZBvWY2TAd3TIOroyIptOVtxHHm_Sd8FrViGNw7nn0Ik6uz7Z_Q>
 <xmx:WODRZNu2-z7WsXi6EDo-0Su940djhyiclx8TXhadLX33cra-XnqYrQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 02:27:34 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ankit Kumar <ankit.kumar@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 2/2] docs: update hw/nvme documentation for protection
 information
Date: Tue,  8 Aug 2023 08:27:30 +0200
Message-ID: <20230808062727.19263-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808062727.19263-4-its@irrelevant.dk>
References: <20230808062727.19263-4-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608; i=k.jensen@samsung.com;
 h=from:subject; bh=7PyhBW87ohtkKzfN7XuRW2ocbhNYaJUMLfDxUacHVr8=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTR4FBaXSNtgmRZ4xk997G5oewRRdynp8UNL
 BcmTZAA4kdW6okBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk0eBQAAoJEE3hrzFt
 Tw3pwP4H/AvkP8Eb2qEHX89tGCj2iiixiuZw5ggC1FvKdbYb2KdNSXFnOxI4MPkeBjJzLW7oe8v
 TDQPV5a+zSydY+Vl0xaHI49rT18ZwFAW9S2u3Eq7xkbo5WdUtlE98kLfhaxiLfyO4wYibb4Inwd
 3mHc1jZY78suW/1t4PrSw95M760Q6I2EYADtgKkECWPOyTPgFjhiRrk6TQ4eebyFk7wEkvZp8zu
 2S2fUGvXNmGiRhj6qpIrbGGXdfsFL9wAg5MK3cHV0wfWreOyq12I2Z+aa85IBOb+zymXSsbwRhf
 GWHoHI1sFebxAE8gDMSTJ4ye43JJXfe+pdOv1c/29VawWlVQvhvcwKmX
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

From: Ankit Kumar <ankit.kumar@samsung.com>

Add missing entry for pif ("protection information format").
Protection information size can be 8 or 16 bytes, Update the pil entry
as per the NVM command set specification.

Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/system/devices/nvme.rst | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 2a3af268f7a5..32ff287cd78e 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -271,9 +271,15 @@ The virtual namespace device supports DIF- and DIX-based protection information
 
 ``pil=UINT8`` (default: ``0``)
   Controls the location of the protection information within the metadata. Set
-  to ``1`` to transfer protection information as the first eight bytes of
-  metadata. Otherwise, the protection information is transferred as the last
-  eight bytes.
+  to ``1`` to transfer protection information as the first bytes of metadata.
+  Otherwise, the protection information is transferred as the last bytes of
+  metadata.
+
+``pif=UINT8`` (default: ``0``)
+  By default, the namespace device uses 16 bit guard protection information
+  format (``pif=0``). Set to ``2`` to enable 64 bit guard protection
+  information format. This requires at least 16 bytes of metadata. Note that
+  ``pif=2`` (32 bit guards) are currently not supported.
 
 Virtualization Enhancements and SR-IOV (Experimental Support)
 -------------------------------------------------------------
-- 
2.41.0


