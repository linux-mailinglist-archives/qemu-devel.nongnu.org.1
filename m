Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D07D6744CC0
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 10:35:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFsXH-00087D-FZ; Sun, 02 Jul 2023 04:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFsXF-00086r-JI
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:34:21 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFsXD-0003CY-09
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:34:20 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-26304be177fso1567253a91.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 01:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688286857; x=1690878857;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4qT5iuEHNM9nGlAhrdukAwM7s3uG3WS5mSSZ33AOXrM=;
 b=Z3VOyY5SV+0yhm0fqof/kDnfCOCgsg2Pbt6pfsytdtZfbBpW+BfqvA4OT7GNm+TPmK
 SNiiOe3O6D08+Sun62GzWp+NC9qEpJ+x9G/FPX3RSdR2Oi09dlMZ3I1jl13vLXTwZ0dq
 34eMH8J26a0B1xv4Bi8EppwfuoQYnvCt03kBoUKPIkshcxphglB5bveeRVT/4Y9joVMH
 EBqQGrvC/59FKx60Oxrt9oi9RSDzKrg1Z99dOTsLjyAkmhG5/hVay+Dkg7heuF3iEHLn
 yGL10354K9Hwh88vv5tqEE+Ue4rilAhxO15hOgsa6TboRfRxXw3ieKu4PJsowyiLAjVK
 HYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688286857; x=1690878857;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4qT5iuEHNM9nGlAhrdukAwM7s3uG3WS5mSSZ33AOXrM=;
 b=J69NrFbZ0TsYqnST5rCGgCO6Yhn5THW7NIyvtLO0HodztvAdzmFi0i6BXwK8SR5MJa
 MIIX+GF21nx7UAQo/jpuDSJnJUZa1gAjc+UJHF/Dgc+YTPdT1viuxZOXn2PllcXbNfNk
 NZdCp1+Xq9wJ3l8bS9rfFGmgYX7H+iir4E8io/6WyFzt939dM74WRvuXLrB3T0IE3iJO
 03Rd5/wH1ePihKqgcU5ly1bK/HOSpyFf0yhY1Aq6kJSLrGJMEgRhWWuE4PkDndK08NbC
 Gxf6yx/LdG+SuvTKDzddBYCHQPcuwweA6sz5ft3VgESLBE3IrQgnHicFv2SMJeLplwdM
 /kyw==
X-Gm-Message-State: ABy/qLZUXpfw7b9Zm1CaZ5Y2Rue5Qh8gMKgxTx6XwBMONrmeYTBRcxyZ
 MFs/0OJ3IeEMLk103Kq2TtPjwBC4NrrkvvN991Y=
X-Google-Smtp-Source: APBJJlGPldO/O0MHLaNxG6Q1sb4O9Q6vzCzfHCLdqtoobVpENl093dGpCK32KZxRRnRtUYXji+KMDA==
X-Received: by 2002:a17:90a:194e:b0:263:c247:28bd with SMTP id
 14-20020a17090a194e00b00263c24728bdmr163876pjh.29.1688286857058; 
 Sun, 02 Jul 2023 01:34:17 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 18-20020a17090a199200b0024df6bbf5d8sm7563069pji.30.2023.07.02.01.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 01:34:16 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/3] pci: Fix ARI next function numbers
Date: Sun,  2 Jul 2023 17:33:53 +0900
Message-ID: <20230702083357.13517-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
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

Akihiko Odaki (3):
  docs: Fix next function numbers in SR/IOV documentation
  hw/nvme: Fix ARI next function numbers
  igb: Fix ARI next function numbers

 docs/pcie_sriov.txt | 4 ++--
 hw/net/igb.c        | 2 +-
 hw/nvme/ctrl.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.41.0


