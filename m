Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F89773A83
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 15:37:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTMsc-0006Lh-Qe; Tue, 08 Aug 2023 09:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTMsa-0006LR-SR; Tue, 08 Aug 2023 09:36:08 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTMsV-0003gj-TY; Tue, 08 Aug 2023 09:36:08 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id AE1493200684;
 Tue,  8 Aug 2023 09:35:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 08 Aug 2023 09:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691501757; x=
 1691588157; bh=sjEAz7THfUt8NXson8EEb8Y+QkyANOsvQGA1EtZLENQ=; b=R
 JB37gpr2Awaww/shwwtkQLP7LgMqK/3YHW/Vl/IauUmqQwX7JbU+eW4x27HGlV/g
 pJyw9cNCnZcnR31+OHJB9/ZiaDDpOwvo7IYtYGLg9ssEZdcnBiX9fx3uXPMCn5r5
 l4Wxe0ZqdaDRM8qto1vTNJAlmHxr8RUhhWBTwkjD774+DS6GnHHgvERsP+V5ucQd
 DUDJ4vkmdaH9ozs/x8etCxu3rwrqftn4lKf301mEwqy7i34OvE782Z9XpEbd1Mfq
 6fsTN1j8xNuflpx+dU+gKJK7ShpA/tnlaAo1L9uwlCst1xPp0XUo/VKvq61uiH2i
 VVLqbyVeq7HJTT1S80ssA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1691501757; x=1691588157; bh=s
 jEAz7THfUt8NXson8EEb8Y+QkyANOsvQGA1EtZLENQ=; b=USQULb0z504Q2/iYL
 YHXoJXWLfe+QyTT3D/+p6jylwb7PD0eA//4CFcxyKcHydpHAoSHXIepi+1J9zyNW
 nL6g8v5JCayL3zcsSuo1ba8Fq6f9/XbB+uvMwNnW6kX1Ao4MWQ/OTWOPbJtfKGN4
 mrB0CrKMeuUBDskuHD5QroZxzGWNNdoUZBMgqzdVWxckFDVPnriQfgiul3NCsbUM
 RtGEQXFGAqxOepEAcjsC9SOZhIU+DgByMqXTOjM2FhssrErfCO3i+0Jq4Cy/7MXc
 YHh+gGgeDQKn2ETAd0ovMpPxt8L+zSH65aeSGh3Mga7E5u4dgS3vzcHaqe9q3Bxx
 tQTtg==
X-ME-Sender: <xms:vETSZNNG36-wPklCHyEFQqeRveM8WiklqY9PIaLI8ac1Sp9WMWED7Q>
 <xme:vETSZP_VLAh2FYf6oSkOfxxwerHXXNM3NFysw7iQcbJjsbAVnoDdMjoxemNL7V3ZE
 ur69ajN66_-Rz1MqKk>
X-ME-Received: <xmr:vETSZMSPziNV3kdKKJbFmYy-HK63nXmDnFDGlkKrM9TbjoZjFlve9bsZP2T2tIorNvNSKmQem5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdeiiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffotggggfesthekredtredtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhephfegteffffetgeefveeuieeiueejhfdvkeeljeevhfffudegtdevjeeijedttdeg
 necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:vETSZJu6sJnSrPaLS9pWGPsW5lldQ9MgKgKVxgZF-DxqIAMaGeJjKQ>
 <xmx:vETSZFd6DuXlYQKgLhAVWV-juTinJDJIkjVBE-VkWjAEF_BID3dRxA>
 <xmx:vETSZF3dLkTR62nVGTHbYyS9Yg2MNzTRcGUWDYUxXRMwdspgZfsSGQ>
 <xmx:vUTSZB64pTLkVqFxjFNQmDZUIC05Ibi3rxj7dhJlXNdAYYKNEyDQzQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 09:35:54 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL v2] hw/nvme fixes
Date: Tue,  8 Aug 2023 15:35:53 +0200
Message-ID: <20230808133552.77650-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=k.jensen@samsung.com;
 h=from:subject; bh=viYO4s5gFbiUKMYv6KOgQ03Ukw66ZybUSGjsbZWW128=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTSRLixqnha7ew8UDujpb7ZrDh/w5dPILQ1n
 5quv2GkM4hBjokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk0kS4AAoJEE3hrzFt
 Tw3p0msH+gKKKVd8IcvJJ4Jr0koZSyWyMJ1f4r0Jln+3AVazgbdpz/0qprKnqFWE3ut2sB1FDB8
 x4ZtD6nVv4g/we5mWQsfyCtoiXyTKCbGA7vTaj7RJYCdLx2VF1MSYERrz864534Cf0Zne0QwEOQ
 pYjgnQ2JIrhTPaXy+cYeG+5ARi1O1e3iX03dGneQKtvkLw8wu1KjxI/PIxnBlZbijuvwklO18aL
 u0ylPJko8CzNuUyiwn0T81Vgs+NhfjA07o7tFJb1Hf/SQV+QJ4RSBXMgdO+5bLNTTAVDx7gUyeI
 J/bBCmHM4e+tdUM1pKRBz/ntAa+9Ts6QXLkrsrUycfjekV5Y+Gi946/B
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

There was a small typo in the last pull. This replaces it.

The following changes since commit 0450cf08976f9036feaded438031b4cba94f6452:

  Merge tag 'fixes-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-08-07 13:55:00 -0700)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request

for you to fetch changes up to ec5a138ce63ce460575a44cf9ec3172c33eb0fd6:

  docs: update hw/nvme documentation for protection information (2023-08-08 15:28:05 +0200)

----------------------------------------------------------------
hw/nvme fixes

- fix for invalid protection information calculation
-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTSREoACgkQTeGvMW1P
DekH6Qf/e3gi0KloAUpbTQvGmBA6XmkJFAtOdZn7IJXVCowjYTIKU84DrdPyT1c1
rofL4w0klKG5c4Or/Cs4dH/ASxTWaQZRlFAYxsTW3nUX74MnaFDRZcN2geb30ws7
ryejVEKeHNWH/YYY4Ny55wO3tmy2ILAKnbiadiXhj4dQfCK1GzZnrx10PWxLNlkZ
KRhiXLNBHpPnDlrLq7/nLs+/0cMrrqEz6ISm/Ju4iUczAH/wmqEbR/yD3pAwmH07
PCaSeegOpwscovI5TWRelOJlzIXb6D8Xk9d3dGL5x/eeN7GlkgERX4MAcNYKwe8T
JNR8y2ErTEj2nLU/juES1EpiR2gYKw==
=vJlA
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


