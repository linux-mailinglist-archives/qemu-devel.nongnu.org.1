Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4C9768779
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 21:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQC76-00062Z-Om; Sun, 30 Jul 2023 15:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qQC70-00061n-HC; Sun, 30 Jul 2023 15:29:54 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qQC6y-0005LH-8b; Sun, 30 Jul 2023 15:29:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 931965C0088;
 Sun, 30 Jul 2023 15:29:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Sun, 30 Jul 2023 15:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1690745387; x=
 1690831787; bh=Nv+3JqwDwzmeHwH/T5CYdkGxStotVFplaM8rvT+hCfA=; b=V
 6cHYxJt04z2aLTuQ8xyVM7tLi9wufGSPIiDYs3JBHa4RN7OdSxlNyO4jNizrGXCN
 Um6NGOCLGeABS+F4uZ2H5wRRN2CZtfSMS3vxlcCkERkhs6gZbuiTbIdVwp/0/n+P
 WYJMA0/cMFvbeoocmhjKRE1GozJzeO5zc3cR7d2Hg802ccCFPjO9VnnkT92li3TL
 J07q13zDbU17WVzcZBCoy1LabjFBYt+WIBiBNEgkeyKmKaO+ktIr/lvobOohrT21
 TBuCITYrBDCw9I5GEpbsVsgwIUk5S62RnQClNNGVZ0i2vzE3XAU7EgSB+SCFJryw
 Gr4BiS07pHi1wDBJXuukw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1690745387; x=1690831787; bh=N
 v+3JqwDwzmeHwH/T5CYdkGxStotVFplaM8rvT+hCfA=; b=UTplew20bELkDlIaR
 n3e0mi74Ru4S37/lTVCH8AVLN9vozvUROaIw8QJGd4uUS61PBk04MUUxIaZ74u8Q
 Qkojj1q20iKXq1c68XBweCs20ihUSwJxa9NCbtWKDy21hQ+SiqDEF2xsG7XXbF3p
 oNpJzVKIREl6ydioCoM7KPWPmDYVP3p6GxwzB2JDaNzUTo+B2I4LH/3CE1ihRFN4
 T+lzaEw4rqGdGFnwVdPcAWEevuw7QoWeQH9tnJDDwAAZEBJksbZXrEcEBse//T5Q
 Rhfla9vA7g6AxAlPqQnP7oPr9SuN7tX6Q3EYLf9d8KtYYEWmqXH2tDfu/VgP4TAb
 Zne9Q==
X-ME-Sender: <xms:KbrGZO18T1vSafu8hVzfAAnOWfzaXSvprqS2xueB_iIItW_BqkWTrA>
 <xme:KbrGZBE7h0NpYwrYPYF4NIqk0HC9Z4yWJ5Ar73gIVTt9b2p8Y6RalRamf9ufxKABv
 -hJQal8ZSwLZWpSQpA>
X-ME-Received: <xmr:KbrGZG7EsWiF7-mr0G4X9eKJZoBLCRs1BEb41X_bdl7_cvLAX0YWBqXSu7wLU9BS7qG1togYoRE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedugddufeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeehjeevvedugfehfeeiieegudetgeetudeufffhheekheelueeukeevueffkefg
 ffenucffohhmrghinhepohhrrdgtiidpghhithhlrggsrdgtohhmnecuvehluhhsthgvrh
 fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgr
 nhhtrdgukh
X-ME-Proxy: <xmx:KbrGZP3idgiIIfI5Er6UJQ3rEahJ75uDf67_PhyJp2BKa4NVj091ug>
 <xmx:KbrGZBG4DU6MFoeuP8kJeM_-heKcwPkH5qx6Brlz5kecxzGrui97ow>
 <xmx:KbrGZI9ByX1iXzbt5vj3S2NrUuaKYFj9seE8nYZ0IiR95DnZxLXzTQ>
 <xmx:K7rGZAC9rutsc8w1dVnmCNNTcy7Rk3EdO9mhItckzhPQ-jiEU98DMA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jul 2023 15:29:43 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/1] hw/nvme fixes
Date: Sun, 30 Jul 2023 21:29:42 +0200
Message-ID: <20230730192941.44019-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=k.jensen@samsung.com;
 h=from:subject; bh=vCyuqQFabVIJZlR18WCIaaHHU6M3FQFQhMnIl72HuzA=;
 b=kA0DAAoBTeGvMW1PDekByyZiAGTGuiWju35pg7Q+Nmmm1gMwu353BMFUfU6xE3lHHhStyul+l
 YkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkxrolAAoJEE3hrzFtTw3pl0EH/2PD
 4c+VrlDFLV4dUy7lQjZx7uUPI5hlKO9LYfvX+mVn/QSvukOLIRJGtdHoZQPHoH4AYTUCFna2ybM
 /bfMVtHy36DLwUqAwSMzFz7KGm8xvhGHCv3ZzrtzygEVgfrsm8CAvxIJTjI7ESyR9J04Og6mIOu
 xt2g7BuYVZns0atRaX6ie7ab9MQLlYcmOwDxPmJVf0TrYjuZRvklrIMP1cmPk6TfqSn9Qja4kpS
 lJETGBtB9KBvEmBIZudBkAkODnVvGl8QEbqIDwxAstT+FPuS95JwbZ3n2BUU+oNcn6/V8DNzxk/
 IeG2wpqnVqkpozD7X21pEsq4ZTYwp6IXgmEjMIM=
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.29; envelope-from=its@irrelevant.dk;
 helo=out5-smtp.messagingengine.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

This should also fix coverity cid 1518067 and 1518066.

The following changes since commit ccb86f079a9e4d94918086a9df18c1844347aff8:

  Merge tag 'pull-nbd-2023-07-28' of https://repo.or.cz/qemu/ericb into staging (2023-07-28 09:56:57 -0700)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request

for you to fetch changes up to c1e244b6552efdff5612a33c6630aaf95964eaf5:

  hw/nvme: use stl/ldl pci dma api (2023-07-30 20:09:54 +0200)

----------------------------------------------------------------
hw/nvme fixes

- use the stl/ldl pci dma api
-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTGuc8ACgkQTeGvMW1P
Dek41wgAwqgRmtUhmmaQJJpF5Pya3J7n3Zkbp+cULdnSp/su7W7yIUTcTzdbr34d
9LbNHmWerXYinlIxG08ZWw2lq0TwApKj+8gv/wf8H7dG86/pBYfoQvOlkNx2QKyR
vtRNlILCEbJpbSfY3LbFNvRGOkArr6HkzT4hZprUIfCvRg58u5oIxEx/ZYa+m3WU
ED0y/46e7HbVbmbwJKrn4EK3k0zGdFyeINRZ5TB5DML3lCTX6eaZTLUXGIb7LLcK
Xyv6/TCkPTggDszTam24kx0A7DhC+3f2C8DsJg7H8jnWb1F+oq/2EJam/0HU22Uk
n348MrWOusuF7kbHMCP9h28gYT3aWw==
=KjVO
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Klaus Jensen (1):
  hw/nvme: use stl/ldl pci dma api

 hw/nvme/ctrl.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

-- 
2.41.0


