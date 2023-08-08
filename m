Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB87677382E
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 08:28:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTGBx-0004TV-Kh; Tue, 08 Aug 2023 02:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTGBu-0004SM-7F; Tue, 08 Aug 2023 02:27:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTGBr-0006zr-02; Tue, 08 Aug 2023 02:27:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id C2A6E5C0045;
 Tue,  8 Aug 2023 02:27:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Tue, 08 Aug 2023 02:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691476052; x=
 1691562452; bh=YaXbWOZtUa3s1CeLoMicMlPUq706Odh7v0zbxDH00l8=; b=T
 h0Bureepix6bvCpaClgJOPLOZCG6c/Uf6gWxlKZ8Q+fYHycEL0RWe1LlCCuNtY/8
 t5T8AZha0bq2N1toVb4qJZYDkLJKkAabNYkGSzV3XV/+URAFhdrbueWF8v/BsCiv
 aRurAcuMql3tbzBeParYkHBlAa3FqtV9Y4LgK+ZyKZBK1n2lyhvHF9ZdEdO9jIzm
 6kzgfhK9jGRftjhYOBeAV9YYHchNDZj7h3sFRMwMpO191ZrjQfTrhLAyH7uh4S0H
 NK0Kj6pm0etuZhM8HKF17DsMf97bTjUkrOZBz+SQQt8IFhXieqeq/i7tirc2e5r/
 Hv/mF8iXg4p9hiKmZXvzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1691476052; x=1691562452; bh=Y
 aXbWOZtUa3s1CeLoMicMlPUq706Odh7v0zbxDH00l8=; b=keaYo3AYfgKTy/5HY
 1dpATFAIE0JVMI4p1bBK0mPcI+ggdhZ48xjP+gqHdho90w+Sc5FzP56gnfNQBrhG
 RlyKBtSSnA1rGQZu/1+xS6FiftzqJatlvDtf74QW5EncATLcATJH40LAZoZAGRn6
 qmYJbeaimr7mTxuPozjT/TdfhB1bYWzv+I/YuMfTY1ecfcrXqI1PxOYIfVo9P7KQ
 Jp2IQRpJCSOFJ58wZazSiljFYTFXB7jTMtA6Pi5aW9c65bYO/EnNYFKLLbU9rfG5
 XzSBgRHbNe11THiwfhpZADlClffqofQbsoECrPAHwAMCWlBLzWCuOsqweatnHT74
 1xhog==
X-ME-Sender: <xms:U-DRZCZ4B-G8T9mMWollDz7aJMOwyVyDXaU6FS6Tp7VUJMGyVhNtAA>
 <xme:U-DRZFZoHoV9-OEvUkniSs4KrYWVcCLrhnrwm0894Uvn6KJAa5927btc3dH3Qa35l
 mFDvvNWX5-pRKvtB3Q>
X-ME-Received: <xmr:U-DRZM8IWLoO4Ch35dmtXxwFZ_Jz4OGN9xpuEK1N8wVqyMKY-o5vDl5qG_Gx6GiYeiyRKbwU35r3FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugddutdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgtggfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpefhgeetffffteegfeevueeiieeujefhvdekleejvefhffdugedtveejieejtddt
 geenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:U-DRZEomHVWl8fO3NWDpvWwm7svILtoW4loTW1udPKBMCndmfGUOvg>
 <xmx:U-DRZNqNSyIk9Y3U57_lzTKRf_infvxBFDKqn_1r2_eQd4j8KyiICw>
 <xmx:U-DRZCTee825SgBceFcTqkQ8ev98w3jixl21RXMpdC5Yf1e9cw3xbA>
 <xmx:VODRZI1tUA0QG0gd1a3RaK17Fa1ZV_AcUnpeITtDgzNsMtbI7sMcfw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 02:27:29 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/2] hw/nvme late fix
Date: Tue,  8 Aug 2023 08:27:28 +0200
Message-ID: <20230808062727.19263-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=k.jensen@samsung.com;
 h=from:subject; bh=+l+1DuJdd/CdpIR3hwlYocTFBGJgHeUs2vfAfiFceeA=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTR4E/cf5ElEl/bohuZ5yR0RA+p420JZnfFO
 KVi7c5L0fTtNIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk0eBPAAoJEE3hrzFt
 Tw3pAPoH/ihczT9cFSWZe0chkBloMkHHsm4vJTokHcWd2YECn0Aw71n1fvEDpATNFDgkUs4mVBc
 qcYbzY4+TgaemCo7nqKbjg8LhictzMgll6DwdpTNjpCowEB2tMSsb9cQW+sb7AR6eCqywRYVTpS
 8FHbBAv4KYo0QxSRSM1kl8IMjYIKJD4J3V6ZueUhecJhR97/AERokwDYwIjExi1pinG0PXNT1ty
 pan8p9m3coABM2PIBBTikjQipRX8DnoTBuilxiZMdmRxSpIMBHw9fpDtMRzn93XLP6/AZBvGp7l
 svsUli9E5HK2JWy2FNX3oTbNneYwPfvZqgjbTlvX8E/pIBXln1jUcaUq
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

Hi,

This is a fix for hw/nvme protection information discovered by Ankit
late in the cycle. This is not a regression, but a long standing bug and
not critical (obviously no users of this until now, no potential for
crash or similar, just plain wrong).

If this can make it for -rc3 that is great, but it can easily be deferred
to a stable release or -rc4 if other fixes require it.

Thanks,


The following changes since commit 0450cf08976f9036feaded438031b4cba94f6452:

  Merge tag 'fixes-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-08-07 13:55:00 -0700)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request

for you to fetch changes up to bb223df9403beada5b2ab408d2d9a82471432a21:

  docs: update hw/nvme documentation for protection information (2023-08-08 08:10:15 +0200)

----------------------------------------------------------------
hw/nvme late fix

- late fix for nvme pi
-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTR3uMACgkQTeGvMW1P
DenZzgf/T5pb1dQhYthpJ/OOLcvtttpRChQSvZJ8uxyzWoNS/9hKn5gd8buvdGwt
fO1QU3Ogh6ArwZ9GT5OqLV05d9vMuvJlPxpbqOs8XZACobH+nb3CqXBcX1F7TxqV
j9OmFH4UGPDo42hkT+jqa+kHc9hxmpwg+f6Wlpad+ZJ2UAel0/19JsQItln8JQ/I
Jxd07Q5qcj06RtwcPf/0WUOs4I6sTkifu7uZIrx1YjYN4/jQmaF2L0MQjUw1ktLF
hFXSW3iarDKh2fFlfR2fMkkoLLnoS6NoZnTj3fBDabcuMfpJlf7WZ5fuYpOlCKtB
kpN9/WaGpZtXmWAg82R7wlgR4D9vkw==
=EuEc
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Ankit Kumar (2):
  hw/nvme: fix CRC64 for guard tag
  docs: update hw/nvme documentation for protection information

 docs/system/devices/nvme.rst | 12 +++++++++---
 hw/nvme/dif.c                |  4 ++--
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.41.0


