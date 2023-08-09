Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F63F776161
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 15:40:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTjPG-0002k1-2q; Wed, 09 Aug 2023 09:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTjPE-0002iz-5A; Wed, 09 Aug 2023 09:39:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTjPB-0002gw-Ux; Wed, 09 Aug 2023 09:39:19 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 1FF695C0150;
 Wed,  9 Aug 2023 09:39:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Wed, 09 Aug 2023 09:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691588354; x=
 1691674754; bh=LFdXSmqDPsntv7+6yKh//Cq9nim02/PIH0SxMKnHKJA=; b=Y
 78qHlR7Hi1/bVUTr2s5HbggpzeyyngnJmjYx59fRB5ndkutInD9VBPC8BQ+aivVC
 gV/Hx+qko2KLnN1dCOflrRk9i1wUXgLowzxL57a6A6Tw6frzY7EpIo4yhSMhJ0ei
 Eh1T8mm0DBpjk6FxlfhOBPwkJyK4L+Eel879D+qCCx8w550k7f4lr1ccTX2A0a96
 WMD6QL0xSoyqAxF/G3hXB+oa2iiGnhEDtrsqcFSkpVLr2S2kTbypx8wfwfZ0V3Ud
 +kxyDZQQsmL0wVP9Xg7aOAsiL8RhK1N5yurNK++Mr8tZcP6EuV12fknJUoX3wZW+
 qBnY3XABOwP0eNNvWDsnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1691588354; x=1691674754; bh=L
 FdXSmqDPsntv7+6yKh//Cq9nim02/PIH0SxMKnHKJA=; b=rGysmSS789FaYMvYo
 xPBzN+SQKJIquMqETtyyX768x8iSGFsLwhqAnxWAteh5lIuRpnVTVAwnO+wyxN0w
 InWcgsBYVJupiaH1A7YwthQaIrnrySYw7JyfNjenj3dkyRkCLKNzmhCPh5rANhQa
 VrCCcjfIfh62b/UgJgLQaTEBV075AuQnbH6pvIOkJlA3XilAZU6jNiCyLKTxEAIs
 dJmvxmO2Gkoao+NWqIYk8QCFawb2JoY8pplV5Blhow3Sqi2jbLg4yECPspU8wIcA
 svF9NsE7yiJXBYOw99n12EGNlrz5FWhKKLluXsx/V+SUYWEULo0Kv/BQJLO5i30s
 W6/ng==
X-ME-Sender: <xms:AZfTZOfAbB2hhRbWreLASeP_57jI-CurmaNlR9I76MbFj_EvzKF3jA>
 <xme:AZfTZIPIh6tz1WQ5IE7u-Qqa7TWsVNUJ0zwbzcf-D1YeX7c0iMvYIP-WlMlVVFRji
 QQ6GnPJGg_P0hSfvAY>
X-ME-Received: <xmr:AZfTZPhpGnFJfHMzvZ-OGHwt6lCeiuZov5NxdAXQFdaE1vK5-cKUrZIhTewm0gXzLVRZP_7k0jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeggdeihecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffotggggfesthekredtredtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhephfegteffffetgeefveeuieeiueejhfdvkeeljeevhfffudegtdevjeeijedttdeg
 necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:AZfTZL9a9-ibIevHfThX5o6SZbooT96te14Q4CDfNEUZG5Ukg8cNQw>
 <xmx:AZfTZKsBMfPd930Tbpi7QeJKOvTfL2SXYlxPqfpVtKSHGVcDL73i3Q>
 <xmx:AZfTZCH05-dlnOCmbj7d_1-r43zl_KrPxEI8g3KGI0-OyjjoR3Y27w>
 <xmx:ApfTZMI3amJJXJ_APP-veJK7DrUKdhB-qANlZyk42V0BQjdULpt2fA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Aug 2023 09:39:12 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/2] hw/nvme: more fixes
Date: Wed,  9 Aug 2023 15:39:10 +0200
Message-ID: <20230809133909.45818-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353; i=k.jensen@samsung.com;
 h=from:subject; bh=nWhoMVJbcirY57FxzJatWyS2udlVJ8ztAy+C9mFIVCs=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTTlv2/A/g5NMBnEP23D5YtJz/M/hFYgskuC
 6oiC0vJ/pZWkokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk05b9AAoJEE3hrzFt
 Tw3pViwH/jnXfmeeNDlAMR3DDXUNAbOQsIcQ4siAlWhG6XqUGVl+xnmgctlonL+Enr5dMHpYqsT
 CvHUxO9W6bBoqLwqCvySKdJGjSUoJZ6byA6+0nM6Hsk/9Ctmihsm+iBnmXGz++2cpyXmTXbLYUc
 hpGTrN3O/ecqWeZaWOnM31ZI2HnO+GgVlo9EyAQj0B8rXyRhOXTBEy7BqabcYOpbIf/s6XOs6Pj
 1q+rHGh8gst63E7vaZXNcOp9RCeXEot42gU7bl7hvbLLYavRrm+yCGPnZJDah/USZzD4PwThSQu
 LntFSf7mNy4f+Y55EJASzGwOPGrurOLRN70SNaw2oSgYR1OaNgJT8qpd
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

The following changes since commit a8fc5165aab02f328ccd148aafec1e59fd1426eb:

  Merge tag 'nvme-next-pull-request' of https://gitlab.com/birkelund/qemu into staging (2023-08-08 16:39:20 -0700)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/nvme-fixes-pull-request

for you to fetch changes up to 3439ba9c5da943d96f7a3c86e0a7eb2ff48de41c:

  hw/nvme: fix null pointer access in ruh update (2023-08-09 15:32:32 +0200)

----------------------------------------------------------------
hw/nvme: fixes
-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTTlmcACgkQTeGvMW1P
DemjjggAnhEvaJ4fgS9rsvtxCwtzLNc405xMpNxh6rPaxa+sL3RXPIrW6vWG13+W
VcHw8DI8EV4DzAFP919ZmTUq9/boRbgxx84bStlILUPHWol8+eGYVVfT75wFKszx
d4Vi3nyPSGlrxieSrosARqimcUDtFtDGGAxjvEcKgzhkcU3a8DVYAOmx/hdlWJJQ
KSk4h/E1pKItFbvv+w9yszsbToeZN65oIy7kQtFgx0JOULyWvEYSVygotw/AruF3
FPQ0nrJuZ115w3cJWDszznVJ6+3EcWbD3luQc3zE1FOPp76EkAOkcnPh1XbBJrE2
2BsCX/XnXcZT7BWSJbEzGXLsHjqsPg==
=Zy0+
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Klaus Jensen (2):
  hw/nvme: fix null pointer access in directive receive
  hw/nvme: fix null pointer access in ruh update

 hw/nvme/ctrl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.41.0


