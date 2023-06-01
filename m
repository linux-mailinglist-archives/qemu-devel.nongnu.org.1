Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F37719EC7
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:49:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4igP-0005GK-FI; Thu, 01 Jun 2023 09:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4igM-00051f-A2
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:38 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4igK-0000SS-Bn
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:37 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-65242634690so37070b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685627374; x=1688219374;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ahPC1cPtV0qi1LQg79/SimC+0KWmuMtx+CYP9Ne1Ihc=;
 b=HgMvPmQF8VF2ddfmUnMpU7XEOiL9b/wPHHbayojtjpA8yMHcv0pUPZ8WsZtZdL/SNh
 y5m3QawA8H2GqQKAoekx6c/OwiEvCCh7OsvzM/vOqylTbnJu4tW444WX0t/OFBoCCOef
 c9Zu21AP136/kzOCkBZi0s7O3tB1LxfxnL2az+NtKSpkEDIRt+J/BKBGBZb0sFJz7Wkc
 laCs2Gg7OjdfGz/WEiFOXVZLzt9xSiMmuGGf7a+HymKsi5O61U819J5jLtZHXd7uxpw1
 NLzc91fxPMbDoAmJxn5GjPh7tZV4/5588TbbWaHWhtYVwgj7HOR1zU16dcqf07xe+ViQ
 B/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627374; x=1688219374;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ahPC1cPtV0qi1LQg79/SimC+0KWmuMtx+CYP9Ne1Ihc=;
 b=bCzH6hLd99+bIVDpsnRGk5NfomTW4oR9ufcK9KhuaZYeth6s+LaeFBtkk2UC0LS3an
 BO9LAj4zPzfGMn142O1xxy3T/+1Mza9D1QyXJVHdjHJVW2JjNLSLNVI/N8etsRBDT1NZ
 Ki3C7gAMMEaaOHvwF9fen88sTVtfXFkVbbs9Ev1gpHZEZFI5IA+UJRV9aRr3kCH4MgtO
 gUcrzFcwParUzR5E0dcfaRjAgwMZk9XqxElAAWTK9TC/tOH1BJHI4sgXE2LW1neNnrkc
 TvUHZqzICBS0dmRaFQ9e4soh5ftTelvpbdIos7AMRJLI6zdqDbBSnBU6asg++AiXgzp2
 BDfw==
X-Gm-Message-State: AC+VfDx3RfPpc345elrtgD8cV5G4qhD36mRH61G0fNxNeNtkt0ZvIFUc
 Z69iE7/oVmuCauKbt+uOpCs=
X-Google-Smtp-Source: ACHHUZ5oYqjSsCuSFZvF4v9/oZdzwCtW34KFk0SKdJ3vsx+dtwbsmu6kbtae3Z8IWF7uiiM76onsHw==
X-Received: by 2002:a05:6a20:8f2a:b0:10b:f980:18d3 with SMTP id
 b42-20020a056a208f2a00b0010bf98018d3mr8363369pzk.1.1685627373913; 
 Thu, 01 Jun 2023 06:49:33 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 c24-20020a62e818000000b0064cb464e08fsm5279546pfi.15.2023.06.01.06.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:49:33 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 0/6] Vhost-vdpa Shadow Virtqueue Offloads support
Date: Thu,  1 Jun 2023 21:48:19 +0800
Message-Id: <cover.1685623090.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x42b.google.com
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

This series enables shadowed CVQ to intercept Offloads commands
through shadowed CVQ, update the virtio NIC device model so qemu
send it in a migration, and the restore of that Offloads state
in the destination.

Changelog
=========
v3:
  - refactor the commit message in patch
"virtio-net: expose virtio_net_supported_guest_offloads()"

v2: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00044.html

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg07198.html

Hawkins Jiawei (6):
  include/hw/virtio: make some VirtIODevice const
  vdpa: reuse virtio_vdev_has_feature()
  hw/net/virtio-net: make some VirtIONet const
  virtio-net: expose virtio_net_supported_guest_offloads()
  vdpa: Add vhost_vdpa_net_load_offloads()
  vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ

 hw/net/virtio-net.c            |  2 +-
 include/hw/virtio/virtio-net.h |  1 +
 include/hw/virtio/virtio.h     |  2 +-
 net/vhost-vdpa.c               | 45 +++++++++++++++++++++++++++++++---
 4 files changed, 44 insertions(+), 6 deletions(-)

-- 
2.25.1


