Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEF1740CB4
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:26:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERQG-0006sg-CB; Wed, 28 Jun 2023 05:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQC-0006r0-Ue; Wed, 28 Jun 2023 05:25:09 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qERQ7-000189-TO; Wed, 28 Jun 2023 05:25:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 0553B5C0216;
 Wed, 28 Jun 2023 05:25:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Wed, 28 Jun 2023 05:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1687944299; x=
 1688030699; bh=vy5BhqxcDkVXS8ADfgp6WXz4dzIex5lOEFi4uP+wdDY=; b=o
 q/MznWzXEjBeXzq3Wx/VSEHz5baChHSOaKoqVwGAkKlq0Pu/b28rRdVU9/UYdUyh
 kSschMFpao3aUofikg7zKP7Vk5Gd20og3wWWcbRjdcYFyJVGQKb+dMLajkmEd8ak
 lzWs6IS/oNwvwlhwP2bvYN7ZiSao+iiwKvxmsggfnreQQCpwDv4hNy2tecCXzOJL
 CZJlJj3ELjfhmEVbsVoOG4mKVCrEIXyKfVjouUKeuFQNQvR4ShM31TU6pD8lnLXP
 35De30Uc9KBKoCpKB63akCY61YMyywGBhjrO4WnB6uNPk3wPzY/QGG/dXh8UZRrv
 QpzSj/PbbDlyYmvSYRsHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1687944299; x=1688030699; bh=v
 y5BhqxcDkVXS8ADfgp6WXz4dzIex5lOEFi4uP+wdDY=; b=QpJQHlXQ4xPLR61qa
 oWRpVVMOpy4VSKNorsbZ5CdyWLl7su2lYBP6RsblLJfvtqwDmaaVcMoHz2biWd9T
 cQmk4lLymWB5kTde3CNMU7EWkBC1krTCCKxCtYtcw9n3mzNite7tWz7dqJ2YHXNs
 HMMJoGK8JPcWv8uGhm2SEh3ROKsmZIkzSCLeEZ/RdYrp72mtV0MGEreNWT6gXtgo
 dVh7Ldpot/t/Hyqtj7t8O2eHqgVR9Ms+R+8HJw+h4qnPltRN5XSF2tIeFYmllCsU
 dmY3GC+uXnuN0R/+ncevgTQPpV1i/mie12+Il1V8pIR31dPFCMOKDbxjbIhE0S2k
 Ap7AQ==
X-ME-Sender: <xms:avybZC04dpMMyOYepWiEaF7JtSYdxxQ9s6d7rGOUr18Z64QIEw68eA>
 <xme:avybZFF1QBdc7cB5gOVCMsXG4nDjkWO6QaZdwPPeMPRSp1dyGjvtj3ZioPDyHcH2g
 qlq4DsBDWYOflz7FYQ>
X-ME-Received: <xmr:avybZK4R5Svty9bzmZCyuTmSpUqELElPoWznUz8re7JcRaX8laf5HWwF093oYsswOpdL-Fyic2U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgddugecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffotggggfesthekredtredtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhephfegteffffetgeefveeuieeiueejhfdvkeeljeevhfffudegtdevjeeijedttdeg
 necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:avybZD1HtvPiloPATNK926NXDcLqv0ss12am1lpA5XlQvTCrPgmhUA>
 <xmx:avybZFHnHFf5YkkvxELOMXEGA8xKcmIccJlKxRilwuNP_tdJVaPK1g>
 <xmx:avybZM_fswyWDxh0b9rOZlD8IoqlLpL3IDO2U0EZZYoUKsxGKVZxlA>
 <xmx:a_ybZECxj5LD1jViu_6BNYX8xKyELjLjM9m-A-vIHt1IAmeE8IWDHw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jun 2023 05:24:56 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/7] hw/nvme updates
Date: Wed, 28 Jun 2023 11:24:54 +0200
Message-ID: <20230628092453.39602-9-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=k.jensen@samsung.com;
 h=from:subject; bh=Po2a7WOXx0aMB8jhoQuMUQ6ftdkrCHcxRGo+S+YL4uY=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGSb/GVVfxTn5mvF7oNbBvl0LAmrLdNghy1y2
 4PZ1hRYocfBNYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkm/xlAAoJEE3hrzFt
 Tw3pnvQH/iHZFUjFwKyIB9Q2uX36VkJOyjgiOdUh0b4SxEFW70v0JeWaUojYw3xH3FrKVcZcX/F
 QjtlU1oQ9P82S5RI8ZiZ1XViYzULVDX3Aur1bI4Y/9y0ific2mNSJc4dBRaNdcpZnH/XguixmKe
 wurXmjWAJe4fawL5GdYdgIACw/l+bJjn9myNHI0VQHj1P1Sd8chThC0v0gRFzc7MHc7Ihtb2Lpf
 lGaFpdpQwXf4W/u2YrzifrYFvXgvqXQeRVXLIpWDRLX6SLs7GabremJpEr7KcCSQYuYEHW1tohp
 ziPQUHAaJBINY54Nn8yfrdtNSAmPT2xh5xaFjMlU5nyaayAptEk1lq4y
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
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

The following changes since commit 4329d049d5b8d4af71c6b399d64a6d1b98856318:

  Merge tag 'pull-tcg-20230626' of https://gitlab.com/rth7680/qemu into staging (2023-06-26 17:40:38 +0200)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request

for you to fetch changes up to e409c9057b55e890a6e5f70386a36932a5137bcf:

  docs: update hw/nvme documentation for TP4146 (2023-06-28 11:22:49 +0200)

----------------------------------------------------------------
hw/nvme updates

Small set of fixes and some updates for the FDP support.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmSb/D4ACgkQTeGvMW1P
DemziAf/eQfjnVr57A+Kglf8J15MCW0GiArbHCJfcl9vf0HPP/iY1c9V4cCZjTLG
vkkkU6W+TFaYALGOVgAldHWC7OCpOi7GHrlqRJDuw86d2dyLDn/l+GQin/rVoocD
fzF2gRVQU4x9qzmjRUikVhRzZbrB4F/AH6QQ8EV3wx2wrljyusItEGe53FEuCugx
pwtKrG990188+UCT1ofr2JYhLq3OmYQi3o2fWgzMp9jP+NeROgKaevWG4UEhFonG
CdeL9BMlSRAfrdR1gTvZpG2mFsrroeBCCjXcrKSwkAxBqpMJDSLvbGqoGJo6kDWm
c9x82Zy2/wVuQaDk+atmcTF1+Pddgw==
=//ks
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Klaus Jensen (4):
  hw/nvme: fix verification of number of ruhis
  hw/nvme: verify uniqueness of reclaim unit handle identifiers
  hw/nvme: add placement handle list ranges
  docs: update hw/nvme documentation for TP4146

Minwoo Im (3):
  hw/nvme: add comment for nvme-ns properties
  hw/nvme: consider COPY command in nvme_aio_err
  hw/nvme: check maximum copy length (MCL) for COPY

 docs/system/devices/nvme.rst | 37 +++++++++++++++++++++++-
 hw/nvme/ctrl.c               | 34 +++++++++++++++++++++-
 hw/nvme/ns.c                 | 55 ++++++++++++++++++++++++++++--------
 hw/nvme/subsys.c             |  6 ++--
 4 files changed, 117 insertions(+), 15 deletions(-)

-- 
2.41.0


