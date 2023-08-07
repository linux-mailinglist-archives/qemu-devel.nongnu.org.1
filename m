Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F967772326
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 13:55:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSyoR-0001WP-Iz; Mon, 07 Aug 2023 07:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qSyoO-0001VX-PD; Mon, 07 Aug 2023 07:54:12 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qSyoM-0007tk-BU; Mon, 07 Aug 2023 07:54:12 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 727223200901;
 Mon,  7 Aug 2023 07:54:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Mon, 07 Aug 2023 07:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691409244; x=
 1691495644; bh=3N3avKZ+kZ2x4wu5+p8bZ7YZlO+UQbtrFGqd95/RFss=; b=f
 ucRKoTk5CYZVkvdTc2HJsbtGZ7shwGLsg82YieR2ub/Pu0SsdPlVitJi3AYgOrwg
 JNNVsug3rQY54MbSDSbWCEPP3SE5Jltya51dFbl8MpAytY5JDNoNnpjchmPX7DCE
 8qJfmsyVngmqUD3DBAEVsGTgvPVdAwj5g5P/b1yjKBW7iPKiobbw3iDLfRXzUnxU
 NwTMFoLivmgUwEQcS3eqSQpmhFyU7MP4nkN99da7+VAo8JPZVzAQfcE6CWgq5WaW
 kziIJ8ooD4N3ytLvBU4ZfEHnlfgcyvmZNd1ICnPb4Z+H2pTJ9puohJnAXkMjf13h
 8ensqf81wgpbMvWRaKXmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1691409244; x=1691495644; bh=3
 N3avKZ+kZ2x4wu5+p8bZ7YZlO+UQbtrFGqd95/RFss=; b=0DlyMhDW9t4WuoOEA
 0Vn3fIECNrxTwFjj995RaWdItkaL3GbY48oT37qDoneKpeyRArSF9RjScx5ZuQm/
 R2JBDObhVWxkJ+kq2dlL1p9lRRBi3gQGQLypb4REvjUJQ0gPuXRH+mza83HwOoZ2
 hrOAxZTlesfFtLmCUUCMnvnxuCAOiGF5+B4sw1Sxh1g4aYzCDf/U7lKkc8kdgren
 6jMFRowp9TVRLEqcovWeV0EzhBPIXs048gBrChHyOeeSdd9K7OQnwxosh/KQzu6u
 v8Ut6O+ZfGd7Um3ioNFhdh0wYMhFEFQv6VdUdXZ2llBTzSf669EW6g2OM2/xmYt+
 cWN9w==
X-ME-Sender: <xms:W9vQZIHf-ZJ29YMisSwbi8rya6PfDSdXsudIUN8FV9RpBast6kPRXQ>
 <xme:W9vQZBUsFERsxKgIddcqjTC24wXxV04mWLmf_3DKcSKojOjTq1FsQebEDkVyaLCBx
 ykx9MUqQiy3GLpSJI8>
X-ME-Received: <xmr:W9vQZCL77ey2uxyd1Pw2mzMGhsq_GIg5Eoi8srZw6syMzZhqQKhQSTmV4FDH3KapT2juFP3_WCrVGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdeggecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffotggggfesthekredtredtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhephfegteffffetgeefveeuieeiueejhfdvkeeljeevhfffudegtdevjeeijedttdeg
 necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:W9vQZKHlL_WSq2VKG7AAU9IlizC8BSoXjHKj5uGiIeA3cCBlCTbeSw>
 <xmx:W9vQZOUvY_i-oKa_Rn7KVnxaD06JHF_3DdVCJdSYI_vwiGsfxy6crg>
 <xmx:W9vQZNO-RR2hV_8X6mFs9JhEwe7go03aw9inTTD0fbBMNXMlfdi6bg>
 <xmx:XNvQZKSw_Sq6NG7piYAfeJ5oui1TLzKBJy8ZgQopxLvzN4X1Ueds-w>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Aug 2023 07:54:02 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/2] hw/nvme fixes
Date: Mon,  7 Aug 2023 13:54:00 +0200
Message-ID: <20230807115359.123-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=k.jensen@samsung.com;
 h=from:subject; bh=qxlhpHt1JuiUUkt1RSKKfaloepiOncuHpg8MrlxlnV4=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTQ21je/iS0pLAwRyAMccGv2aQQKoGPOgYzn
 /S+u0hihxjEhIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk0NtYAAoJEE3hrzFt
 Tw3pxYkH/0AdRLkEHidisChHng2L+NekEAXb0O9M3t/9w14KgzHOmy0GftWbb5a798mNwW1m6FW
 fi80zzoQ2N2Evm6cS/3p83Wevziq8qXtCDhj7ephrjOfJ2KF8zckvrIcZm6hkM7Zqogelu0SNmW
 9MRKbKRdJHka4oPHKsO9gQzJEl2eXT7VqtItypfclXLAze+QHfE2piNxh+yElTaPqO0GxKXg1Cp
 KAz6WfWrkMYrEER5aFCiztBtElR1EoyBma2qM5D1GpOc13QVYboC+QwUR0HEpLwqGz+0PPeYDr4
 8GNHAqfFXjS0ugy5i/SuBPPFd+CnvHbypnWwIKOG+bxgSuTb731zx69T
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.25; envelope-from=its@irrelevant.dk;
 helo=wout2-smtp.messagingengine.com
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

The following changes since commit 9400601a689a128c25fa9c21e932562e0eeb7a26:

  Merge tag 'pull-tcg-20230806-3' of https://gitlab.com/rth7680/qemu into staging (2023-08-06 16:47:48 -0700)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request

for you to fetch changes up to 6a33f2e920ec0b489a77200888e3692664077f2d:

  hw/nvme: fix compliance issue wrt. iosqes/iocqes (2023-08-07 12:27:24 +0200)

----------------------------------------------------------------
hw/nvme fixes

- two fixes for hw/nvme
-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTQ2y4ACgkQTeGvMW1P
DenpWQf/WFgEljzgTcgxlfZhCyzWGwVNgKqRxlTuF6ELqm8BajCuCeA5ias6AXOr
x/gZ0VqrL91L5tRIH5Q0sdC+HBFC1yMs66jopdzc1oL1eYu1HTrLIqMDtkXp/K/P
PyGah2t4qEMtacSkad+hmB68ViUkkmhkxrWYIeufUQTfLNF5pBqNvB1kQON3jmXE
a1jI/PabYxi8Km0rfFJD6SUGmL9+m7MY/SyZAy+4EZZ1OEnp5jb3o9lbdwbhIU5e
dRX4NW4BEDiOJeIcNVDiQkXv2/Lna1B51RVMvM4owpk0eRvRXMSqs2DQ5/jp/nGb
8uChUJ0QW68I4e9ptTfxmBsr4pSktg==
=0nwp
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Klaus Jensen (2):
  hw/nvme: fix oob memory read in fdp events log
  hw/nvme: fix compliance issue wrt. iosqes/iocqes

 hw/nvme/ctrl.c       | 51 +++++++++++++++-----------------------------
 hw/nvme/nvme.h       |  9 ++++++--
 hw/nvme/trace-events |  1 +
 3 files changed, 25 insertions(+), 36 deletions(-)

-- 
2.41.0


