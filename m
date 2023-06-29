Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8E674298E
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:26:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEtWo-0001WA-VL; Thu, 29 Jun 2023 11:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qEtWm-0001Vp-JJ
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:25:48 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qEtWk-0007P8-Fw
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:25:48 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b84c7a2716so4505445ad.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688052344; x=1690644344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HmgMf7kcAkbtSqwr/THHCevyTJD9eMkkS6z3PJl/C4M=;
 b=qD41gkyhkn086LqHwFRZMqzucQGfoixHiahkt63rtlqkIQfixcmxUbpkQvb16H8DSl
 TXl5FciWWE9cXyMl9KRDn3ESjUR1zxefoUVQoCP5fkahcgi+v09ctM0Iy93zENTSzzbq
 eXYhfqv9HArbfjHQvpAte62CN5YzzICwNX15h6GPqddjxZ6YWcVN9jRbY9LPhRcoPp21
 mfCLrGcPNtI5pad9bx1wqCOIV1lTDkKVeP4Ny7GY5yQENO38Bwmy9n2j86ZkTaEo74ju
 V8BD1/Nao/2zzk0LsX81EOJCh5v/n2HNNc9D8thX6p3LntRk2a0R5utixKuytXtdxweb
 If1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688052344; x=1690644344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HmgMf7kcAkbtSqwr/THHCevyTJD9eMkkS6z3PJl/C4M=;
 b=i6j1mblL8T1TDBL/6UnPOTrxEYpVerGzhly9Iz8Ly6152STeC/iPFFu1Ei45xsGNbV
 6vGhr8zpybnWqESCMxDxYtCL/PHGFbmynE3/893aGW316zlthX9NowidJLaoBu8XkZbo
 8w0QFNjyncYaSMw5rYIrHmfJERLiVEEloQbkpU7rxThqCwaPCGGTeKZiVzYmWDyJ/0zc
 eW/mr7G7OMNI0coC62jbuphm52HjX+hUYj0/vHYLhDwv9gnpepQc1jTPSDZh20oUlCEj
 9GuAJqb+6rm8akQB3XmNtrWkrxPvVOjmUEhSDiSWtIdFJj6xbys4U7rMrUG/I6tIGP9V
 IrKw==
X-Gm-Message-State: AC+VfDzIjaEqT+mpAcdlszbm59UqkM7aEd9v29R267OmpqdnzhlvyCcf
 Joe4AP3tlyUNM7DY5zwKS4Y=
X-Google-Smtp-Source: ACHHUZ7aborz2CPflufQn8C4RI6tsF+d7dmfdC+UgNpKrKLYVDQoUBM5cAUHZ6Zd76DVNygHd9w4Ng==
X-Received: by 2002:a17:903:32d0:b0:1b3:d8ac:8db5 with SMTP id
 i16-20020a17090332d000b001b3d8ac8db5mr14757342plr.40.1688052344293; 
 Thu, 29 Jun 2023 08:25:44 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 u5-20020a17090282c500b001b7ebb6a2d4sm8538611plz.163.2023.06.29.08.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 08:25:43 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC v2 0/4] Vhost-vdpa Shadow Virtqueue _F_CTRL_RX commands
 support
Date: Thu, 29 Jun 2023 23:25:31 +0800
Message-Id: <cover.1688051252.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This series enables shadowed CVQ to intercept rx commands related to
VIRTIO_NET_F_CTRL_RX feature through shadowed CVQ, update the virtio
NIC device model so qemu send it in a migration, and the restore of
that rx state in the destination.

Note that this patch should be based on [1], which have not
been merged. I will submit a new version of patch after it is merged.

[1]. https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg05909.html

Changelog
=========
v2:
  - refactor vhost_vdpa_net_load_cmd() to accept iovec suggested by
Eugenio
  - avoid sending CVQ command in default state suggested by Eugenio

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg04423.html

Hawkins Jiawei (4):
  vdpa: Use iovec for vhost_vdpa_net_load_cmd()
  vdpa: Restore MAC address filtering state
  vdpa: Restore packet receive filtering state relative with _F_CTRL_RX
    feature
  vdpa: Allow VIRTIO_NET_F_CTRL_RX in SVQ

 net/vhost-vdpa.c | 198 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 188 insertions(+), 10 deletions(-)

-- 
2.25.1


