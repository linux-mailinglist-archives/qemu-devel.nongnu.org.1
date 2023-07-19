Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C0575997E
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM904-0001Eu-C8; Wed, 19 Jul 2023 11:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qM902-0001ES-GG
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:21:58 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qM900-00037C-0p
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:21:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31297125334so644737f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689780114; x=1690384914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H+xVImpKU6HqvfIrhNXVCI2bYevO88CMC+Dvv3jYGHE=;
 b=xCnBef44l2It/IOVg9ZhHYi1VATPIrHtG7Mzspms+l7iRhapVOB2Zy8tsvnSwqih0B
 GejYnzMCReEh8qjkZeWYgwQDmQSUK+HxIBEBWLNuSVzKkc4Jry1/iOCqh1xs1p7pYmdv
 xgiPrJLRWxcINLArYwp18Lvn5piAuqpXNEoL7v0QqPfxFxIFzaePb7lGELFmxUAs7u4j
 kPh7hNqBSooAwbQ45s4n9rb8jq/esN2kSTqrliyreWAwzrMf+Kw0rsZO/NJCko5X+ifJ
 9+Epsw07cLhSbCdHNonyAroUmDQkgruIgE8c/Nl77OZNTCN32NNW+ROWqptQBWtMZzqP
 g5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689780114; x=1690384914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H+xVImpKU6HqvfIrhNXVCI2bYevO88CMC+Dvv3jYGHE=;
 b=JRVqMGiz5bTuNSgJCoRMzRVJ5k6FNLfLHPAT3rsqHXnuGHvjCf5aHN38ko5TPMiIrS
 owetvou5FriJ1I2FddyzOv+mrFuzzyyprG6QQ0mb9o4uqtNwnzGU7zg4cuGhQ5Ig6Lit
 mVg2gC9r6odbx+e7fF3UVGoXtRCfRTIo1nJxlIKEKNIetYKUpzFabnJKBRkcS+AnGQAf
 8ZgmgImdy4LUwzgYHdVdVgA0TYri253YSyEvjgMedHy96NqcGtmLruI8u0/LPUUV4yax
 CbgftGY0iKseCRMAOnAUHO1lS4I+4wydXDyUP7+BwWqqtSClc6hy2cc4aALTV1t9VnAg
 2p8A==
X-Gm-Message-State: ABy/qLYzwGailaPqcqogKZbXqx3n8VNPgNKjdCtFCoUdcPi+u9Ltnuip
 7ZUWfDoYx9r4METajWOkte8W0Q==
X-Google-Smtp-Source: APBJJlEG9LXnktKht3U4OMsfQnGVVxwtuXt4O3TPaDhZaD6m4Xj4eDjMu2UW0HHgrvVXIs0sMD7lDw==
X-Received: by 2002:a5d:664f:0:b0:317:6c3:c94d with SMTP id
 f15-20020a5d664f000000b0031706c3c94dmr75760wrw.14.1689780113650; 
 Wed, 19 Jul 2023 08:21:53 -0700 (PDT)
Received: from localhost.localdomain
 ([2a06:c701:46e6:7e00:c5bb:d943:dc1b:8245])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a5d6349000000b0030e52d4c1bcsm5626775wrw.71.2023.07.19.08.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 08:21:53 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, mst@redhat.com,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: yan@daynix.com,
	andrew@daynix.com
Subject: [PATCH 0/4] virtio-net: add USO feature (UDP segmentation offload)
Date: Wed, 19 Jul 2023 18:21:35 +0300
Message-Id: <20230719152139.1316570-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::429;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Starting from 6.2 the kernel supports UDP segmentation offload, the
kernel uses GSO_UDP_L4 to mark packets with USB sermentation request 


Andrew Melnychenko (3):
  tap: Added USO support to tap device.
  virtio-net: Added USO flags to vhost support.
  virtio-net: Added uso check

Yuri Benditovich (1):
  virtio-net: added USO support

 hw/net/e1000e_core.c |  2 +-
 hw/net/igb_core.c    |  2 +-
 hw/net/vhost_net.c   |  3 +++
 hw/net/virtio-net.c  | 35 ++++++++++++++++++++++++++++++++---
 hw/net/vmxnet3.c     |  2 ++
 include/net/net.h    |  7 +++++--
 net/net.c            | 13 +++++++++++--
 net/tap-bsd.c        |  7 ++++++-
 net/tap-linux.c      | 27 ++++++++++++++++++++++++---
 net/tap-linux.h      |  2 ++
 net/tap-solaris.c    |  7 ++++++-
 net/tap-stub.c       |  7 ++++++-
 net/tap-win32.c      |  2 +-
 net/tap.c            | 18 +++++++++++++++---
 net/tap_int.h        |  4 +++-
 net/vhost-vdpa.c     |  3 +++
 16 files changed, 121 insertions(+), 20 deletions(-)

-- 
2.34.3


