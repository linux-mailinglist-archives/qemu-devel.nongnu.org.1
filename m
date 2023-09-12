Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC14C79D38F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:28:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4M9-0001Wr-7j; Tue, 12 Sep 2023 10:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qg4M4-0001VH-9F; Tue, 12 Sep 2023 10:27:04 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qg4M1-0006FV-Vm; Tue, 12 Sep 2023 10:27:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 81CFC3200034;
 Tue, 12 Sep 2023 10:26:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 12 Sep 2023 10:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1694528819; x=1694615219; bh=oiN0GeCq/ks9Q7gseTFkhe2yF
 Z2NQWahiVOVHZ3K6HE=; b=Ccmrng3NaZWLJtA3QSMafH/inciAZb7VsWra0qEsa
 mH0i0jj5goRy0WUItU+eGwPe8fO4nuUY+AfukyWY00H4AlDK1CoTeVX8t+dMYDe9
 G0UjSFVSNUpvu49TXHpMLs14OItJLSIZzoteozBJo8tBvwLzoamtk8rXopLlq98w
 e6eVCoNPQnGzxQ+JKpWR1Fj0W7GeXQydblF6LYf0+KGdHlHxY5PbfAFyeNhR0YRa
 3hKq0ia6dFg7bv6Lw2ENilje2n47DjJHvbZ1iufwpndD21t/pvGDh0w02GyZfJOA
 jN4MW1GMyn3WnRxvtjG7oEqCif8sAt52vzGBaUu/YGv9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1694528819; x=1694615219; bh=oiN0GeCq/ks9Q7gseTFkhe2yFZ2NQWahiVO
 VHZ3K6HE=; b=iBl/sDf6EH/OBg0uHwVsZjJvvC0XKHChc0s7iHolqdf+G9Rzbzk
 anW+pKHXty40BuG+bUdUyyLrBJpkm5HzYACmPGqzQIrncCqYaDZ7VYxTG9lSj8jC
 MNqHeEJ9/3Ya3ha7nCZ5T2hci6A5cPUWib22+/9yeb12TF68tL91UtjHbnYTNaM+
 AEFaifbZrQApW6BHzUPrItmbw4zCMVetMgaaRIckU4DSZm3ik30gO5YO+s+1Dupy
 4C6QBJ8aDdpnHNlNWAfEernisULDaImTmwaNe0xAsCBA7K3JJqc4t88t9BqH96nc
 klLtlU1iJ2SHRy6KcwDAAI5EmZ4+di6p3RQ==
X-ME-Sender: <xms:MnUAZXghamiBw_uNhi5TKa7n_wwnPRU2R2yPp9-hfc7ZbKBNC7EjEw>
 <xme:MnUAZUAs2AGShTggiY1i-LDi-VcmEVKlcu328kYk7xNTROyB7KKaiPDVheyBC0Ro2
 Qo5gtAdjjV5g19rrT8>
X-ME-Received: <xmr:MnUAZXGvLEMmdYX_jt6xpXi-4OyZGB-r9U8eHToIWnAtcCVjpjG0kRXKrhL8LsZ7kgEDFaXuqeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgjeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeefvedtueetueduffevgffgtdeftdeuleffhfeigeffkeegfeejfeffteej
 iefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:MnUAZUSltb4ebDAGw9N6b0OaVGAHfd8CGEZlvS9H32EWWBXepvFb6Q>
 <xmx:MnUAZUw6xvSyN7ybkHEECh4PvtDmBWHMIUMVAQhZ6_VtxOGUczqWiQ>
 <xmx:MnUAZa62vXep6fclpVErIzQH-BTpd1r_qkFnAwtbLi20y9unz37aLg>
 <xmx:M3UAZZr3ny3_a5fMi5oibtdtM61zlfh27Q-TaFy70JV9_V2oJs74GQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 10:26:57 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 1/2] hw/nvme: Use #define to avoid variable length array
Date: Tue, 12 Sep 2023 16:26:51 +0200
Message-ID: <20230912142649.11002-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912142649.11002-4-its@irrelevant.dk>
References: <20230912142649.11002-4-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1587; i=k.jensen@samsung.com;
 h=from:subject; bh=E7DjdRj14im2VetumRoAJOcha10LzkLK3x/G/8tlZSg=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGUAdSr6/qYO46V3EqWovW+IbGsg1gu0edN6q
 5TRTBw14ybxnYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJlAHUqAAoJEE3hrzFt
 Tw3pmTkIAKDoVQIHzlcjatjeXVTO9cX8C0kb2HrFURVHNSVYqE8UJZyAMVb3nvGBuRGAOP3hj2G
 vQrdRNIo22vwU1JjhTzdxsmP7iv6QRmn87l5iJyCGsNMYMptWer/fcPRjQ5t840syI1RTcKnVA1
 CuVOlx9CiOOWHgBmwBKdv1Kht9PizzaFAPX59OhQFWq0mK7vlMFOOn4V8YeaUikQA91AHfwBUmL
 vOm7jil2MLJGzyGH6llHWCQh4BfTi8IMIpyiscI3X0lZWfkO16/19sY7Le1a+omrItmzp53zur5
 ObGEIXsHHgvtANeLv2+3lOEyL70bAuGBM04Uk3k84FVqq/DT9LOcgKXg
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In nvme_map_sgl() we create an array segment[] whose size is the
'const int SEG_CHUNK_SIZE'.  Since this is C, rather than C++, a
"const int foo" is not a true constant, it's merely a variable with a
constant value, and so semantically segment[] is a variable-length
array.  Switch SEG_CHUNK_SIZE to a #define so that we can make the
segment[] array truly fixed-size, in the sense that it doesn't
trigger the -Wvla warning.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

[PMM: rebased (function has moved file), expand commit message
 based on discussion from previous version of patch]

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 539d27355313..d99a6f5c9a2e 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1045,7 +1045,7 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, NvmeSg *sg, NvmeSglDescriptor sgl,
      * descriptors and segment chain) than the command transfer size, so it is
      * not bounded by MDTS.
      */
-    const int SEG_CHUNK_SIZE = 256;
+#define SEG_CHUNK_SIZE 256
 
     NvmeSglDescriptor segment[SEG_CHUNK_SIZE], *sgld, *last_sgld;
     uint64_t nsgld;
-- 
2.42.0


