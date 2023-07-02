Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E29744D0F
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 11:48:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFtfH-0003jF-Ed; Sun, 02 Jul 2023 05:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFtfG-0003j7-9q
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:46:42 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFtfE-0007gH-5v
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:46:42 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-55b1238a024so2773912a12.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688291198; x=1690883198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FrvGzOrPb5QZre060LHjoJFUhojDSLsxExvyHpt6mC8=;
 b=rxOcUHcSGsXHQe8AGmixZwnY4mdeL7AGloRmWkRL00gxZc/uXiQ0i3gyC8yGvkw46x
 Ib3YEUaOpDUxvtUDH2tc1krad4QuGqoQJmplJHrkR+Jv7bCIjV5zolJqvA3QlAHivDJT
 Tr+n8yERC0QHHrXoSSrbj6bLrKQpkigJ6NR5bflQpIQEewLZ/UwIU+ei0WOadn/r2kVv
 fLRtUAtgLknH+O+caUx6jgh9bGaCUNLMYSo6CA8ZrJVyyPHJRzZNHWrtrONG0RBO0Y+a
 uI3zTo6j6bxmAxcScBDc61dK7jGmBdWOVtXM301tcZX6LZI066D1NAmxX1gra9q51Gvp
 iECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688291198; x=1690883198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FrvGzOrPb5QZre060LHjoJFUhojDSLsxExvyHpt6mC8=;
 b=jey9plUbkLHngGZsjrB1TX4KD+pmY098HtC01LoXilIg4a6oKr9+i9pjVzATYk3zgI
 WPDfypCWPtTL0lj47SDna1DLJ8uRSuV6gJNEkmwqjW7Ej1juEyHomhqlq+Ncx8YUfmQm
 JUxp2BKpjTxWFWSxsfeaPmzY9vrzK7R7M6W99k59ptFvzMacCRw3lqJ3oDfc9CswU2wR
 UN46W12/801bdR2aXb+9PJre5Pkrhd0ip4CGOJ3xrFet1Pyr8vRrU7lfraNNHe6/cIJD
 OdbS7+cftm2ndN+5GCIOAK0Zc7L4mteXBb/0orLJgFJRvOiR6jKwb/PRNXT11wZCGp6U
 TDbg==
X-Gm-Message-State: ABy/qLYG+qMtY6LdR3GZZXljBxS8GqB0IaHJJw1I2wOFJOrA/ewJj3eR
 RJ+U2vCNznxdsAMG7XBrvqOf2xJNm4Y5t8HKUAE=
X-Google-Smtp-Source: APBJJlE5FRV0THHINzrVucPCsCVKB/bJVkddB2pL11876wkAmWkO0Uy+Z/woxMDYPMCzxXVcv4kwEw==
X-Received: by 2002:a05:6a21:3381:b0:12d:10b6:98f9 with SMTP id
 yy1-20020a056a21338100b0012d10b698f9mr9428380pzb.56.1688291198585; 
 Sun, 02 Jul 2023 02:46:38 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 i1-20020a635841000000b005348af1b84csm12934067pgm.74.2023.07.02.02.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 02:46:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/4] pcie: Fix ARI next function numbers
Date: Sun,  2 Jul 2023 18:46:24 +0900
Message-ID: <20230702094631.39111-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The ARI next function number field is undefined for VF. The PF should
end the linked list formed with the field by specifying 0.

Supersedes: <20230701070133.24877-1-akihiko.odaki@daynix.com>
("[PATCH 0/4] pci: Compare function number and ARI next function number")

V1 -> V2:
  Fixed migration. (Michael S. Tsirkin)
  Added a caveat comment. (Michael S. Tsirkin)

Akihiko Odaki (4):
  docs: Fix next function numbers in SR/IOV documentation
  hw/nvme: Fix ARI next function numbers
  igb: Fix ARI next function numbers
  pcie: Note a caveat regarding ARI next function number

 docs/pcie_sriov.txt   | 4 ++--
 hw/nvme/nvme.h        | 1 +
 include/hw/pci/pcie.h | 7 +++++++
 hw/core/machine.c     | 2 ++
 hw/net/igb.c          | 5 ++++-
 hw/nvme/ctrl.c        | 3 ++-
 6 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.41.0


