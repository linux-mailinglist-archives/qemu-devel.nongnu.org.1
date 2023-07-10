Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7B774DA0D
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsyQ-00086v-Ny; Mon, 10 Jul 2023 11:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qIsyN-00083h-Tx
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:38:47 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qIsyM-0005PM-3X
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:38:47 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6687466137bso2933911b3a.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689003524; x=1691595524;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OQVG0WczUwFHNB5hIJRSSA6bKrrYeaqnBNBrhJ/4o90=;
 b=C6atOdX/5rc+m2r/csOp9RwEGk69PBNOzTu8cF3G6XYzf3oevd2b8sa/GO5eI2nD+q
 2eHuYB+qJIkzqdAeDpgOxYS3yORxPkIUUwZ6GZI6t14TzVGdD6qyIc8e23LjcCN4qgFf
 70NRdp1uGs7YmXN/aCJAqX3b/Qu7BVAXFcldCenkSdggbB7B4MjAFlm6/7YLNYoON0h2
 4JNWIiShNVc3maC3ox7y5RGzs5sODX2UNqsGbg+B0d/RBpVpfX2RmPjRtmJ2PwZAa5EC
 LcLCOdNKbIPm2xZdZWU9GYB74cqCz/Sm0YyS5zkB3g+Me9dg4PQLki1YCX9TvMTDxFPL
 i1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003524; x=1691595524;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OQVG0WczUwFHNB5hIJRSSA6bKrrYeaqnBNBrhJ/4o90=;
 b=i9XTslLFmD7haagxD+7NDV7OpB2FDlnYIgZ4FRx/G5OXRzHXZGrY1mmr1XtLAg+/Mf
 2F8dHARMsEXk3Z+0AfgfIxF/a3eCT7uiekdYJxpfk0jyh7Zh7WtxcxgpOD0CMQN9QOzp
 2YWKZQ/N5ReUKa6vKBaWVoAnU1alXcfxckh+ULNd9ABpppXIUddjtIO7cLiUQL7+zMma
 B2sTtAm5+PRcpwn35e/vcxc8fRcWC3fGlvHwtt0Hc9s6DVWZG3jkOkMHgpDVP+XKZjoX
 AJ185flW46irvM4dzc1DoqWAjfy8UQWDn40uNyIxRTCe9mOpdFy0dGakzg+cG+Mmj8qx
 iOPA==
X-Gm-Message-State: ABy/qLZaPIhPIZecbmxpaxWhRbhSFPF9uWnJ05JCuO1r2fhq30rrRdQV
 nDa+uvvYSycO+/K+mkzgnT9Iogs4nWcUfN0Yguw=
X-Google-Smtp-Source: APBJJlGtzxF5jeDYScUkzNayyjPwqxmqRusNdnwO8KAHKVx8ZfwQJH2uCODVvHDYatkVOPMkKOV3Ug==
X-Received: by 2002:a05:6a20:3b1d:b0:130:e9f5:171 with SMTP id
 c29-20020a056a203b1d00b00130e9f50171mr5549482pzh.24.1689003524487; 
 Mon, 10 Jul 2023 08:38:44 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a170902b60900b001b9e1d5f8e0sm48345pls.91.2023.07.10.08.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:38:44 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v7 0/2] pcie: Fix ARI next function numbers
Date: Tue, 11 Jul 2023 00:38:34 +0900
Message-ID: <20230710153838.33917-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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

The ARI next function number field is undefined for VF. The PF should
end the linked list formed with the field by specifying 0.

Supersedes: <20230701070133.24877-1-akihiko.odaki@daynix.com>
("[PATCH 0/4] pci: Compare function number and ARI next function number")

V6 -> V7:
  s/old virt models/old virt models/ (Ani Sinha)

V5 -> V6:
  Clarify that the requirement to end the linked list of Function numbers is
  not specific to SR-IOV. (Ani Sinha)

V4 -> V5:
  Added references to the specification. (Igor Mammedov)

V3 -> V4:
  Corrected the default value of x-pcie-ari-nextfn-1. (Igor Mammedov)
  Added an explanation for migration compatibility. (Igor Mammedov)

V2 -> V3:
  Moved the logic to PCI common infrastucture (Michael S. Tsirkin)

V1 -> V2:
  Fixed migration. (Michael S. Tsirkin)
  Added a caveat comment. (Michael S. Tsirkin)

Akihiko Odaki (2):
  pcie: Use common ARI next function number
  pcie: Specify 0 for ARI next function numbers

 docs/pcie_sriov.txt   | 4 ++--
 include/hw/pci/pci.h  | 2 ++
 include/hw/pci/pcie.h | 2 +-
 hw/core/machine.c     | 1 +
 hw/net/igb.c          | 2 +-
 hw/net/igbvf.c        | 2 +-
 hw/nvme/ctrl.c        | 2 +-
 hw/pci/pci.c          | 2 ++
 hw/pci/pcie.c         | 4 +++-
 9 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.41.0


