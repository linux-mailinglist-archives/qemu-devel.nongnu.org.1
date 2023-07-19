Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 220E5758F31
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:38:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM1jS-00046k-HQ; Wed, 19 Jul 2023 03:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qM1jP-00045t-FT; Wed, 19 Jul 2023 03:36:19 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qM1jN-0005Q1-5T; Wed, 19 Jul 2023 03:36:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id D84193200931;
 Wed, 19 Jul 2023 03:36:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 19 Jul 2023 03:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1689752170; x=
 1689838570; bh=nHcsobU8LwoRjP/bpxiKdu3YUaJn7DzC4vY1II2Ym1Q=; b=A
 d5Oo/l5aGsYFPwb7M+TQ20hLiF/oDn2Bsdw8qu4J4DFQaTUrdqSFQZQLnWAsjzkm
 0sCyFgSSzj2XDcW5tMyIHlryrQqyM62VWEck5yTj/5XVDaSolET4g7ur/nu7nDVE
 FKf7upj/MCESS0VewBBA3govis8UXDSVrVlJnbKa/xgEtfmz2Me0sD/FMgWRsme9
 cyccPUaHkfV2zA/S+ymD/5I9yWQGPdq7UGQ7OfD/2aJzKmMdm6wIlApW+XY7Q7Xg
 nMxL4ySGqLJ9isuyogrPYWr80Oa3+1p/mEEfrvh1sqzAHODvbV4jYb3m87KcnlDQ
 ny5jw9WRGYEkWECqyL14A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1689752170; x=1689838570; bh=n
 HcsobU8LwoRjP/bpxiKdu3YUaJn7DzC4vY1II2Ym1Q=; b=1Fe4s5c6KgnrG0wrI
 Q+tiPeyBF5LMv0nctZhaH1grmQPep0mv11u9oTrs9HTQ+EkN9vCE9olpkQ3F5/LV
 q2jje/VBTAUjTX5H+kTl2ZUiWNAUGmIXQtT7kz7ggW23KnzOSRHEW4jvNII0cCyP
 kfiWZ41ye/2WVML5vui3PBY0ziFyUi/5BobRCDlqJFfj7HTkoiihUhknwKtx6R6Y
 TZwIIVu+qqMcRBJSevaJ0bPYUDroFlVOd00hcFIlgu/AktyTF1xpUwT5Zl3Dtb/P
 82+v8m1NkqEn8vSarqqbHCo+S9MhfXWoN6NxjIqKp/slh3ZkflFMmG0FBWLGS7Zl
 6RccQ==
X-ME-Sender: <xms:aZK3ZK-s5r8jEytVkhx7C0Fp9cXIOr5FHd8I5UpFvUdtH2VpCbbnBg>
 <xme:aZK3ZKvcpi--5buUsnBua2HTHX1bhr_vNqgU6r-g6i1eJ5EhWiYI8prrsROfLVRfx
 CPZ3L-7RHHjoLdwAWA>
X-ME-Received: <xmr:aZK3ZADvUeOCiTmHFFv-bH9BzcU4bT87Y7MvppT9wVEmGbIy9oQTuCO92MD0D713wbZM5wsZt5CG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeehgdduvddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeekvddtvdetiedvjeehjeeujedvkeefvedvkeeftefffffhfeeihfeijeelueef
 geenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:aZK3ZCcvgP_ZSWUlKNxqaWubCODA3UHCplZIH7anEFhSyCBMkzL8MQ>
 <xmx:aZK3ZPPhKHomXdxBeCYzrOZpMP58ZD8o2vjp4Nlit034vMw9h1Y-sw>
 <xmx:aZK3ZMkiU0WXtLFEribhc1kqjCGGoMZn4yFyFDguncznlSVbBUMJ1w>
 <xmx:apK3ZKpnq_qidp-qh1-WnAiBlgVQsZN_YGeJl4lDQBXyWB3CFh39hQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jul 2023 03:36:07 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/1] hw/nvme fixes
Date: Wed, 19 Jul 2023 09:36:06 +0200
Message-ID: <20230719073605.98222-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=k.jensen@samsung.com;
 h=from:subject; bh=1GgVNXgVl+F5ah66HaEBXad/via4pcyDVbj9wvFwpF8=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGS3kmWKPPGFRcTWBiZhI1yxsJfaiCWPancNM
 t8I7BE0XI2lNYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkt5JlAAoJEE3hrzFt
 Tw3p2RUH/Ati7twwqW8cEJGjLRJ0nmcgkM8U7FLAkQh69+tq9jrUlcQNkGZgGsZme+/luuuRD3k
 zlIqHBWdFuocSeQdf+l59Y2/2VvMb+vOJv4vHZX6wCx5FuoydHBdr286710R+O19q7EU/+0EltI
 ftjsMwmKZfOBETPSpM6xqDhtOp3avTmUn9Zg0VsfapPWpJfrFSZY/n1zb5LFqwjQSwZ+Wvt6nR4
 kj1KQnMXZbIOZ0qPg5Oz4J82KUG6rOYbLYOPVzC/1XpWMbtSZwIgpQqioyYcsZjiYQNhcXCVhMw
 LXq+vk6+TEaTwVKfKMs0KvYM4dvxS9yqsO6Q61/0YqajRLKrG/ommqwM
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.19; envelope-from=its@irrelevant.dk;
 helo=wout3-smtp.messagingengine.com
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

Hi,

The following changes since commit 361d5397355276e3007825cc17217c1e4d4320f7:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-07-17 15:49:27 +0100)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request

for you to fetch changes up to ea3c76f1494d0c75873c3b470e6e048202661ad8:

  hw/nvme: fix endianness issue for shadow doorbells (2023-07-19 09:33:54 +0200)

----------------------------------------------------------------
hw/nvme fixes

* fix shadow doorbell endian issue
-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmS3kkAACgkQTeGvMW1P
DenG1ggArIHi1dQQBIG1ubzHx/C+93cybpKwT73/5wfO7BT8CCh1v+qrH/6SsYUT
5O7y1MaCLDV4ocf5dRQseXFK0tpjo7EqDnr25UhcSunQ+d2Tn7MAIuubQOFD+Axh
5gIwOEJbKqw9apJgnVWnInTBd//ManOgh6OyC1uJ+DEJE7ISJzLlJeWaBekiWpAA
hNL1zsR5+eTcwnewDRmMs4FlKBlSfgcNgNYnz8tfpnW0DzXKuiY4ITnk6kX9eMAM
kDlbjFjlgoTPZ8IsYcyhVCJMcH8jqY/LuZcaF7XHHsdX7fa5p17C6rR1hxVyDs+E
rydOtWetQDhXlyakE+Jp2RB3HLcSmg==
=j1TL
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Klaus Jensen (1):
  hw/nvme: fix endianness issue for shadow doorbells

 hw/nvme/ctrl.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

-- 
2.41.0


