Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D788B744CC2
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 10:35:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFsXJ-00088Y-UT; Sun, 02 Jul 2023 04:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFsXG-00087B-UU
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:34:22 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFsXF-0003Cq-Hs
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:34:22 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-55b66ce047cso832308a12.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688286859; x=1690878859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJPRtuvbHAsqaGR1Ln6VUbGyabvHfWSFqdv+KVApqEU=;
 b=kwGb58lJyVFoIe+PC3fQV85nt/5xaJD+hS7MVGPS5jYzqu/bXWSsXc9tzShwpIMK7J
 DxWQqyCUUw6HiAxVR6BxgrksTp1ogMqYuhPbpd2b9tytBO3e7eFnjDDh2N0Mm8uiyqRo
 JIS3L1MjaAgjFd2QhpNyiBvo0iXXhj1Z3WWOiRqMJgMdFeR1U44iOLgwtUuzf+5NB0Pr
 qDI/6Jx/UuobTJEeMDw3ETivZZoDlXKvttd22BwPssWooV5CLicDlDyhaxypwCgDK4j3
 verYM6HKIPj5ePFd+cgu+WC6gg1a6odNy4yqUuklzLTkUqsE67l+2YWOpS0b4/cMBnE7
 Iwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688286859; x=1690878859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJPRtuvbHAsqaGR1Ln6VUbGyabvHfWSFqdv+KVApqEU=;
 b=DGw8q4m3IID8hgeLgq1xdLxKdclfHbx7srWowDBxVV/IgGTX7vUpe+RDDPZrzlX2t/
 hhSR5Ggh+um2Dsx0P7aSwwatMVI1kdUvyTCxl1an+Em8F6p+xPRq2XX3Pz1McGQHpLeF
 +BhBgw6SBquFPg34Hc/0kuzP8w1zFB/973M7wv+kNzbfvsEOgyJnoEYrqBtFZ/1E47Zg
 okw4GVUudpAWz5nf42QCbPh/mAl/0UiIAKV5KTdhb1NNkxSZTa29q6YIGgyLd81LiOgH
 8UqCUQ3jA7yDDCIRX04dj+XUX45wiWYqZIjoPFzCPJgEvRmc1r0B1zOnpHmTjLzs8kSz
 hB8Q==
X-Gm-Message-State: ABy/qLaysS6ufw3e7QGFKoJ64z+hUrRrwd0qbgRmtDrdQ4ovbu1iDBVa
 Y5qeGnVNB64PnMBLx0j6ox6SJUAbcvhHf/IiQFM=
X-Google-Smtp-Source: APBJJlEaiDosFIWzDPlQsZcO/eVn6YZJpdWp96r3cojnhf/LdRGZDhmYjqitE9mzB6l/zQImoYh86A==
X-Received: by 2002:a17:90a:35b:b0:263:7d4a:4d43 with SMTP id
 27-20020a17090a035b00b002637d4a4d43mr5171005pjf.1.1688286859631; 
 Sun, 02 Jul 2023 01:34:19 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 18-20020a17090a199200b0024df6bbf5d8sm7563069pji.30.2023.07.02.01.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 01:34:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 1/3] docs: Fix next function numbers in SR/IOV documentation
Date: Sun,  2 Jul 2023 17:33:54 +0900
Message-ID: <20230702083357.13517-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702083357.13517-1-akihiko.odaki@daynix.com>
References: <20230702083357.13517-1-akihiko.odaki@daynix.com>
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

The ARI next function number field is undefined for VF so the PF should
end the linked list formed with the field by specifying 0.

This also changes the value of the field for VF; it seems to imply the
value has some meaning if it differs from one of the PF, but it doesn't.

Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/pcie_sriov.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index 7eff7f2703..2b7094dc47 100644
--- a/docs/pcie_sriov.txt
+++ b/docs/pcie_sriov.txt
@@ -48,7 +48,7 @@ setting up a BAR for a VF.
       ...
       int ret = pcie_endpoint_cap_init(d, 0x70);
       ...
-      pcie_ari_init(d, 0x100, 1);
+      pcie_ari_init(d, 0x100, 0);
       ...
 
       /* Add and initialize the SR/IOV capability */
@@ -78,7 +78,7 @@ setting up a BAR for a VF.
       ...
       int ret = pcie_endpoint_cap_init(d, 0x60);
       ...
-      pcie_ari_init(d, 0x100, 1);
+      pcie_ari_init(d, 0x100, 0);
       ...
       memory_region_init(mr, ... )
       pcie_sriov_vf_register_bar(d, bar_nr, mr);
-- 
2.41.0


