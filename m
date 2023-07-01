Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C695744786
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 09:03:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUcL-0007VX-Ls; Sat, 01 Jul 2023 03:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFUcJ-0007Uy-6Y
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:01:59 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFUcG-0000jz-Vp
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:01:58 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5440e98616cso1587215a12.0
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688194915; x=1690786915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzSXskDD/v1lHw+o43R3dD1EMa38NVV+qos1D4KGb28=;
 b=tmf+3ZX1n4IsswZCdO5pgd83VKy2DfGPbjscSf4CvjggaqBVYZfyHeOEVBx0fw8P/s
 qw7+1k13xRcabwjeL+y3K7wm4KHDgk7f19T/rW0ZRzgSOo56jB62gh/lfQCw64Gmo26H
 hd5Oy6i9KhtHd86PLB8VtLXy/dtHdL1JPOG0He3nZAtJ3ok2ny58j6+HHDsctn41u6Dl
 9XhGahPgUEtF+5N9E6CnFyfVdd8JBjgzY2tNbdn/nHWqjwLRa8pbRxrZFn/OGecvmAC8
 E5A/1xszqXRg5X5vLDzbgT3AFAiJEq6xRrRwvE1v080YnnFKkFpEc6MGx4/ND6q5giw3
 XgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194915; x=1690786915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uzSXskDD/v1lHw+o43R3dD1EMa38NVV+qos1D4KGb28=;
 b=DyH2iRitzVeXfgh9ESD8mxcuhOBE9A04wNqR1bnM+94UcwdmozAQ1xfD237vGVcm9n
 BWlWzLciAxWaylO+nCjHwUmoeXwku6Eca0E2eDD0jr+We5/M/ADNel1reO7PEmi9ZhXl
 wWdxUCZabMekRG5dP7IXK8gJjJzP4guSrAWqlJZZlTEFr+kVT0Tz2TuMaLsXmF0tIvnM
 VN4OWOXddnlcTtvAnNReZYSNkSazYHAwl5wqDC7RR8EZk0zMJCa24HJLcE0cCti+u/md
 D4JeuVAN6pqLFzebOKJm59aFsWCgjqqAalpc3PzILiYHJSfh3PGt+8zlZqEC2+FPb4cE
 Xkng==
X-Gm-Message-State: ABy/qLYXIoU4ym5hqOagtfw64ueeveKYsMnMQIdNfE1DKTzgbr5ewZfB
 4SLeq6hFRakqeZz5B0XFDSroplvAtjrbUF17GeQ=
X-Google-Smtp-Source: APBJJlEmVllYlwT+VxwsvPobpenmx898PoKEa9nQTpLzQKkppsAMMxBrilcjPRPGAswx8PAIcxPAPg==
X-Received: by 2002:a17:902:e743:b0:1af:e302:123 with SMTP id
 p3-20020a170902e74300b001afe3020123mr8110555plf.3.1688194915460; 
 Sat, 01 Jul 2023 00:01:55 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 jd4-20020a170903260400b001b1920cffdasm5592452plb.204.2023.07.01.00.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Jul 2023 00:01:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 1/4] docs: Fix next function numbers in SR/IOV documentation
Date: Sat,  1 Jul 2023 16:01:19 +0900
Message-ID: <20230701070133.24877-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230701070133.24877-1-akihiko.odaki@daynix.com>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x534.google.com
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

The next function numbers are expected to form a linked list ending with
0.

Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/pcie_sriov.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index 7eff7f2703..cc4232e49a 100644
--- a/docs/pcie_sriov.txt
+++ b/docs/pcie_sriov.txt
@@ -48,7 +48,7 @@ setting up a BAR for a VF.
       ...
       int ret = pcie_endpoint_cap_init(d, 0x70);
       ...
-      pcie_ari_init(d, 0x100, 1);
+      pcie_ari_init(d, 0x100, fun_offset);
       ...
 
       /* Add and initialize the SR/IOV capability */
@@ -76,9 +76,10 @@ setting up a BAR for a VF.
    pci_your_vf_dev_realize( ... )
    {
       ...
+      uint16_t nextvfn = pcie_sriov_vf_number(dev) + 1;
       int ret = pcie_endpoint_cap_init(d, 0x60);
       ...
-      pcie_ari_init(d, 0x100, 1);
+      pcie_ari_init(d, 0x100, nextvfn < total_vfs ? fun_offset + nextvfn * stride : 0);
       ...
       memory_region_init(mr, ... )
       pcie_sriov_vf_register_bar(d, bar_nr, mr);
-- 
2.41.0


