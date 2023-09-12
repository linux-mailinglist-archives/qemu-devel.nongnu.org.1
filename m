Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B37A979D38D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:28:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4M6-0001VX-Iv; Tue, 12 Sep 2023 10:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qg4M3-0001Ux-2K; Tue, 12 Sep 2023 10:27:03 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qg4Lz-0006En-57; Tue, 12 Sep 2023 10:27:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id B7B70320097A;
 Tue, 12 Sep 2023 10:26:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 12 Sep 2023 10:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1694528815; x=
 1694615215; bh=G5lHCtMYsA3iCzT8iPwbnIJH7HD1zis9WPC+UUFA2DE=; b=X
 yiWQXA6gxyDBSRH+EwMC5WsxamX7w/hfQ3bJLxGvzwbIZLnSjXkmQrvreai0U90G
 BeOIGZwYEC3MNeRbrwoUkZmLPWVB1TgHL6BRxF/ogsiCIdKwvLVeFRfpWSROB063
 iPaAs3vbr50qUGcr5FT8sReu7sMydoENcpks2L4pB39E18o0ZxB9Pbsaer2qUYbI
 D07euAr5Ih7XqerMEEILm+8du6tfan7KuubzFTdDl/mslQmYhF6gmGllCA5bjmaP
 xBYOg7LMgqkgbPNk6xnbQRFJo2Zz+UG669qE4whStIxel1sspH8vxqn56g1/Wm/5
 xrIYm0hSvVgD9LAb9Ex3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1694528815; x=1694615215; bh=G
 5lHCtMYsA3iCzT8iPwbnIJH7HD1zis9WPC+UUFA2DE=; b=h2XTfXfxwzReg8ECF
 FZrUe2b12dPaeCj6swcHhG30wptLsUXKuXKs7dvv2P/oiW5qOY6y9r7P9nDRyBGM
 RESfwiRQdQZgFPaQj0ttqSxKVJQfEVRhcBzzcm0h9E2RnJSv4x4VmT61bO4AmrAS
 dYOatoSMmB7qzpG4i29WcfSAYTN2mSdz7Z0MbHMLuixdW7vpkX9mrtA4/VJ/OgVI
 VLPtJzt+P/JD9qp/JqBCXi+Jwi18Ls5ELYdW8e89cqRMn4AX+hFMmj5VZ6Jl8FPY
 +kbm08OlLVNoNjJRkhDFZdSKFIwXZC8d+/M/QomFSKMwIqOblcKSofYbKGnrrclW
 k3NTg==
X-ME-Sender: <xms:LXUAZYdZbb7qr6s1-C9y7Uu0ZYkJOCK2lLAYDIzUoRt5D5h2DKgdJg>
 <xme:LXUAZaOEaDWALmBE__IZxxQkI1mKIJOrBVa3FkCpeoDUUIeaLXnY8aJP7EIEK9OzF
 JrE3A4HER-B2jt_h7k>
X-ME-Received: <xmr:LXUAZZhDTzwFkBXK7LKBlPXhmron8QMoRVlMl7Kjh8CAW1tTI4s-EQR6nRnDC51HVjX40h0PAdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgjeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeffkeelkedtudeujeehjefghfeivdehteevtdeikeejkedvheeigeefleetfeeh
 ieenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhr
 vghlvghvrghnthdrughk
X-ME-Proxy: <xmx:LXUAZd_DfUlT9086G-wxxzVlWXKyBoMQbKDB2WpQMtbKcIc5JiHADw>
 <xmx:LXUAZUuEXnhEJLcRTF3Oo8r2ZU8QTWx5wzXfM0SIxKNElqCX-b5VqA>
 <xmx:LXUAZUFSJKslo2gW4a6n8OGdlPuTXzaYbelZETO215J6l5OjGu26Lw>
 <xmx:L3UAZWKalyIhAUcMob38oXDfC73h79Bw89swBI5JLRuMZ3HlAEcHrQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 10:26:51 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/2] hw/nvme: updates
Date: Tue, 12 Sep 2023 16:26:50 +0200
Message-ID: <20230912142649.11002-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401; i=k.jensen@samsung.com;
 h=from:subject; bh=DxFmuIz3ByNvtLRmxghUMTdttXF41Dr6fd0ltxw+k7E=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGUAdSkGXSsfrLoINI9gL0Rp733JLNDy33FMW
 afPmkHa+jITa4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJlAHUpAAoJEE3hrzFt
 Tw3pgSgIAIz7KQ5+aXhxBlKcywzcUmd5eSF48Y+qLEAyX9M1IEZkKX87GUYvlycXxXW1eNON/Kl
 EABIVvPQjt8P26Ufv7pe5XZFMOz/GkDenirZUL+uO9quf2/d9PjtIDxjY0MhlHDZmCo68zIrt4y
 K5W2ES/3wbSm3LMU4+28rIO+1eYM11dO7T0LmPBBqvYs5TYe/8R8pvmOCVLDQLzgrv7BoYK91Fd
 jSON5QcCh6Bzdr4TeZjKNa6f92vmXYoQmxYKrpA6XQmluc3U/48p6xiBLHHf8FzmgZwspMSSa6L
 11m0seah6+3vs3vYtWK8zqHUGXj5me++dNCZbuGNP0/+T8yhNZzNs6oV
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

From: Klaus Jensen <k.jensen@samsung.com>

Hi,

The following changes since commit 9ef497755afc252fb8e060c9ea6b0987abfd20b6:

  Merge tag 'pull-vfio-20230911' of https://github.com/legoater/qemu into staging (2023-09-11 09:13:08 -0400)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request

for you to fetch changes up to b3c8246750b7077add335559341268f2956f6470:

  hw/nvme: Avoid dynamic stack allocation (2023-09-12 16:17:05 +0200)

----------------------------------------------------------------
hw/nvme updates

Two fixes for dynamic array allocation.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmUAc8AACgkQTeGvMW1P
DelwhQgAxD7imw85V89Dz58LgrFoq5XZz2cq6Q5BsudyZd8FW5r7lOn9c1i0Yu2x
iiP93FX0b5LPQ9/8/liz3oHu1HZ7+hX+VeDZSQ1/bugfXM/eDSPA7lf7GG1np312
9lKRs8o+T4Di7v93kdiEi6G3b0jQSmZ722aMa54isk58hy1mcUTnGxvPZpVZutTP
lYhwuElQIsnnKXB0jaRlpcDkpXdHJ1wwziaYLM7pus+tElMiSkFP05j2pX9iigKu
7g+Hs+DaqrOzdoF/6uu72IKygq3/5H8iou1No/7OICWbFti5Qhhra0OKQE6nrlKd
51fnWA6VjpO5g9+diwRRYbjEiOrkqQ==
=wn4B
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Peter Maydell (1):
  hw/nvme: Avoid dynamic stack allocation

Philippe Mathieu-Daudé (1):
  hw/nvme: Use #define to avoid variable length array

 hw/nvme/ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.42.0


