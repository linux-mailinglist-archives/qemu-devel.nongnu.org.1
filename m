Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2BF76A433
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 00:33:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQbRR-00011d-5v; Mon, 31 Jul 2023 18:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qQbRP-00011D-8W
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 18:32:39 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qQbRN-0002Ti-HI
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 18:32:39 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5222b917e0cso7364753a12.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 15:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690842755; x=1691447555;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=noJRsMWrXqZ8CbewAnBQvTuIkOeRLbws6veGvOiLNq8=;
 b=JUhLVgb0wZ1QS8QokEJ9jQszvBfehBSnkMjIMMMVndJzh7eDV2Y3MnkRtLRjTGhQO1
 SkuPeAGDZyXZiyT3cpv/+pwYtnKBanExe7VQj3lxffwrD0u79kvuuH2e4HixTpEx2OHk
 wFGDDK5h/tRf7wKwEbFuFU5SA7mNhNO4cFFM3XNOajpW7hWg7tfR8F1uZYmFejstESEC
 kAwhJ5fY0qMCIjYVVe5XKhizYHaBHFJKLysNKuZSB7gavwAGCrFe7mIXkL0QJvpCb8RO
 Mlbi1qg908dGjV0ZHXnwG3kjj5isPqHW6OQ924dJ4hlx0XLj7wWKEDUORS0skbqWGXvk
 +LHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690842755; x=1691447555;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=noJRsMWrXqZ8CbewAnBQvTuIkOeRLbws6veGvOiLNq8=;
 b=LSb84zxxvdGfTYJFpbatDQFMdzLj4GoehnhkaYoV7slGoghs22fJuIaG4O51NDnUTZ
 XGu+wNpyF1zDmuMvZBzMDYTMgr+H4io9Fq9vSeuHIVHXPMUvqJ5tZKhxTzSkNdWFzjP6
 168Lv3Ka74hp0QB71hVa00Y/SPKmU+qmLG+ogsmEgVdniguO1J98Q6JYbfHS27ZVHD7d
 mts1HgAoUCG+RtGFqISVmchDd6ihiUgLTAjJiK2wtQiZUfBB9kFI8hZ/4VkNT6T70Xfa
 hyBIm03qQlVamteahciP29f8M5nsEBLzQIyaGJM5vaw/pEOtz8Ak2kSxdxtJXPk/nCib
 6guQ==
X-Gm-Message-State: ABy/qLZxKeSY98DvU+zJw1NlkVtWx3ev1Z69yTvv2qAYaZ3I4hfWqYnX
 lsELczrgTs+3G2VfHmvOWokhlQ==
X-Google-Smtp-Source: APBJJlE9zL0lXjwlb3LFLP+sBzJGzHgCm6lN0a31kZZh20+sgvGYXeogZ1lLSYdAHUqRj153y8R98g==
X-Received: by 2002:aa7:d149:0:b0:522:1dce:ca09 with SMTP id
 r9-20020aa7d149000000b005221dceca09mr911012edo.29.1690842755499; 
 Mon, 31 Jul 2023 15:32:35 -0700 (PDT)
Received: from localhost.localdomain
 ([2a06:c701:46e5:f400:91e1:5f50:afab:4c79])
 by smtp.gmail.com with ESMTPSA id
 x5-20020aa7dac5000000b005223c34259fsm5915088eds.57.2023.07.31.15.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 15:32:34 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 mst@redhat.com, sw@weilnetz.de, qemu-devel@nongnu.org
Cc: yan@daynix.com
Subject: [PATCH v2 0/4] virtio-net: add USO feature (UDP segmentation offload)
Date: Tue,  1 Aug 2023 01:31:44 +0300
Message-Id: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::536;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-ed1-x536.google.com
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

Starting from 6.2 the kernel supports UDP segmentation offload, it=0D
uses GSO_UDP_L4 to mark packets with UDP sermentation request=0D
=0D
v1->v2:=0D
 Enable USO features by default starting from 8.1=0D
 Move command-line parameters to the last patch=0D

Andrew Melnychenko (2):
  tap: Add USO support to tap device.
  virtio-net: Add USO flags to vhost support.

Yuri Benditovich (2):
  tap: Add check for USO features
  virtio-net: Add support for USO features

 hw/core/machine.c    |  4 ++++
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
 17 files changed, 125 insertions(+), 20 deletions(-)

--=20
2.34.3


