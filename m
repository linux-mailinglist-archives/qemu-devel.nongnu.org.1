Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E01A773AF0
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:17:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTORd-0008Hl-2g; Tue, 08 Aug 2023 11:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTORa-0008Fn-JV; Tue, 08 Aug 2023 11:16:22 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTORX-0000mq-IK; Tue, 08 Aug 2023 11:16:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 35E8D32000CC;
 Tue,  8 Aug 2023 11:16:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 08 Aug 2023 11:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691507775; x=
 1691594175; bh=szeMu+/cYIGmxA/94/iRo71wkAHwywUdhsDSfDvsxQM=; b=a
 +U5+QpjRd0734SJZj3dI4BRx/MpjMiFmsYZUWVdwAWTktSc0+DRy1q6+1JwvcWPW
 +euQePSMb2ioC4wgEHTNeResgTVB5clG0QlI/l9kjejCfPdS9SBa8LH4p5f4DgEU
 iRQe8PRXyUE77tTiQqWJuqgpCvBzRdSisHOWlep2fDpc/tHl/REWLpCWEN8HirZK
 MqkNsQDhl5b0NbeDCQR/IFteNt2neQ5Ik8QR02DjWIh8dKdmtc6M8vI8BGNd/Att
 1dykQbhGIoAW9bt2T/D/206zDvVAed8DkeIaAGgaQpG3dQZGPDHlyDZm8uYLOUTr
 j76BFufCPN+SZM2p3JHPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1691507775; x=1691594175; bh=s
 zeMu+/cYIGmxA/94/iRo71wkAHwywUdhsDSfDvsxQM=; b=sGkzMB4T/R6Pf1vOm
 nsMZH6Lzs4KB0Dj/569S5wg4/ZlJ6oqYX1wEg18j5gjHP2zzO6tEhnt7Tixu0HC8
 cZdlN03+dsszNenKZsoIue/EoKjXM5RZIWmp6sc4VJWcQr2vS+3YeRNqJaXq82f9
 GVkd3Zjl8VQ39rwQqE6XVnCW5vwYO0l5Pypr12pgNkFWn88fQ/45KPHEQY22xvDu
 LoUxlH0p+VOM/PHW2HnARiAW9tqcERX+HxwPw9/CsffP4j3djUvlNv+M8G3usEXa
 rxals9tc2wFviQ9ULs7NcSRiycWJccvTfo4OPrYEDgWWLsVgSmdOJSPpKGBXfKVR
 C5Qqw==
X-ME-Sender: <xms:PlzSZA4ufAmNfxUbOuUFZYPWfkjTaANRhHAg6UvPPKy0Utztc91MVA>
 <xme:PlzSZB5MHnyLqQTlWFXtOc15ffcZP5IWFj-nHzjome5SQW3Fs_jk7sNE9FsS2qILa
 PRt7Til7wZAfQDEdT0>
X-ME-Received: <xmr:PlzSZPe0UTi90dDVfFpbvTqVLeomsTC0NTkY-Ku41kIkZ9Vsmz-akgIe4uM8mVuOFpMVXrNPZaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdekhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffotggggfesthekredtredtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepudekvdfgueejvdfgvdefffffhfehiedtieejkeelfedvhfegvddvtdefueekgfeu
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:PlzSZFJj961qBIuq0bysNxOJI-qg-Hv9c_uW8KnzusGX5Z7ooI3LgQ>
 <xmx:PlzSZEK6bD3_MDg5tSFbDt5YRBjIQFb_GZ2YJve8L9du-KCF-e8KPA>
 <xmx:PlzSZGw2YUho-uePpGRBsXCYr3gC4E9J0PMo2OzjWextQOXjz8V3zQ>
 <xmx:P1zSZJHCtqD8mzGQVeYB6Ih8_AEn-3uFVHcqj5RToroVkJv0WhoMQA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 11:16:13 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <j.devantier@samsung.com>,
 Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 0/2] hw/nvme: two fixes
Date: Tue,  8 Aug 2023 17:16:12 +0200
Message-ID: <20230808151611.81933-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=274; i=k.jensen@samsung.com;
 h=from:subject; bh=OrENYWh3CB+gzABI7Okw/97VhskDS83YWvpeMdLU5UY=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTSXDsRosWqGyWyd2BF7fp6TgdysE2IQZ2Zu
 35cOBALz73pyokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk0lw7AAoJEE3hrzFt
 Tw3p+3QIAKr8GM0k2KdEiVOJSd3MoxKziusxWKAbyZVkge+uq+VIgwZVFE4MfU6YLNacgB/QRfy
 7HrXg+ga0hQyhfMn4+I0DtOCwCZbk9CqLtiXNkbIts3stOdYJ9JTRne9e+npDvIGAs5Nesn76uu
 30vUSgQmdwu8osmrffWPJpUYB8gA7jmkS3qPVJNNoBknOpskN7KeqsQCbBEMOdSLICLObKrPXyU
 TYSn/M1qX9VeOt0HdbK+JXzHG7//RDcj/Uq6mtn2SbZ1UirB6dztVbSA8TPmROknW1X/ZUQrWL2
 BTU8hdzPAJ5gbGnBas5EOd2vWKPtJpc9IOyZO2ceDao1bzRvAPOrNrDt
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.21; envelope-from=its@irrelevant.dk;
 helo=wout5-smtp.messagingengine.com
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

Fix two potential accesses to null pointers.

Klaus Jensen (2):
  hw/nvme: fix null pointer access in directive receive
  hw/nvme: fix null pointer access in ruh update

 hw/nvme/ctrl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.41.0


