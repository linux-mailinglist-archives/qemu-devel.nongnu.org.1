Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC87744787
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 09:03:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUcI-0007UZ-L8; Sat, 01 Jul 2023 03:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFUcG-0007U6-F7
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:01:56 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFUcE-0000je-3f
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:01:56 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1b012c3ce43so2408110fac.3
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 00:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688194912; x=1690786912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=//rGd4GEENbHbmmZJzKOteqwpD3W0oCdkWg30hzQwnU=;
 b=bqUZtAzKYqo4E0E0J9RMo/aBYM5Up/DhSDYhFpxVfSl94cNwpiyBWtw/ympaKqElrc
 +w/+BFPiODUUb0vf7aRrqfWJ71f2pvSeSvpPES4Onjly3DCoyfo5KsVzapWihFnnqYBC
 +Jgv/UWSZhoGFxAwnjNz97VHaQV9DwkgPB+EFYgoQqs7fbtYGnhSFQ48C4bIlnydWEjz
 IMQg05ozqYwCz/BC036shG/2OtnIf0RFR/nXre2emp0vaVuMMha7JHpoUkgpXI86V1Aa
 NUU2JRbDFPPJcgybr3PGbx+vIWXbgNml3IRBJAumDqy556Dpb+FMeTOVkJnAHNx5sOTO
 QLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194912; x=1690786912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=//rGd4GEENbHbmmZJzKOteqwpD3W0oCdkWg30hzQwnU=;
 b=bDHgjHyYj4JS3r6c0VKsaA6lVeNDItDOCBtBbz5JjuDn4tUf6XlzF6TJe2PcP3MANw
 dgqxdwdzDnHuNoAg7TZMybhKUqEgcuIQtRxCkXPQ3Of2Kbpd2v/5ieIc6XxB+1CV9UeS
 tUuiZ3fAfS08tOQL6zmPC+Vq7ZWpk0JlXZscGlAUvbVszwEAyI4aGS4JHp/+0JXDKi8x
 4zR/w+MAAV0+A+bhC7XZFMU5ntN0QsH+Uh0gpZ0zcwtL/Tw/SVL6i0nfKmdpg8nsUrgU
 lr72a+nOh5ytiAzmIwemk40USgA9mLZdUh5n4nn2bXlS4OTbplmxzw8+WhIePyTzJeKA
 THzA==
X-Gm-Message-State: ABy/qLY+y2SKqidlLil9uzvHdZ3nOf6IxB+/KHVl+4pltaNtp+8cktZd
 e55qr/8rFxrj+rkAXsH6hCyFtW+wsuZnTekYXOA=
X-Google-Smtp-Source: APBJJlGqrBbWI1WOBwAwMneq8h/CzcZ3VRJ1U5MTLOHKuJyd8CPnkFZTxcSXQgO+U7rVVWT64xERcw==
X-Received: by 2002:a05:6870:2b0e:b0:1b0:1a20:7e34 with SMTP id
 ld14-20020a0568702b0e00b001b01a207e34mr5618918oab.48.1688194912723; 
 Sat, 01 Jul 2023 00:01:52 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 jd4-20020a170903260400b001b1920cffdasm5592452plb.204.2023.07.01.00.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Jul 2023 00:01:52 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/4] pci: Compare function number and ARI next function number
Date: Sat,  1 Jul 2023 16:01:18 +0900
Message-ID: <20230701070133.24877-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::2f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2f.google.com
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

The function number must be lower than the next function number
advertised with ARI. Add a check to enforce this.

I suggested this change at:
https://lore.kernel.org/qemu-devel/bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com/

Implementing this change, I found the devices implementing ARI do not set the
correct next function numbers, which is also fixed in this series.

Akihiko Odaki (4):
  docs: Fix next function numbers in SR/IOV documentation
  hw/nvme: Fix ARI next function numbers
  igb: Fix ARI next function numbers
  pci: Compare function number and ARI next function number

 docs/pcie_sriov.txt |  5 +++--
 hw/net/igb_core.h   |  3 +++
 hw/net/igb.c        |  4 +---
 hw/net/igbvf.c      |  5 ++++-
 hw/nvme/ctrl.c      |  7 ++++++-
 hw/pci/pci.c        | 15 +++++++++++++++
 6 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.41.0


