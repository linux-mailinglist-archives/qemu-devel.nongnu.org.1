Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B464744CC3
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 10:35:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFsXR-00089l-CW; Sun, 02 Jul 2023 04:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFsXM-00089U-44
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:34:28 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFsXK-0003Dl-I5
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:34:27 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-263121cd04eso1565363a91.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 01:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688286865; x=1690878865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2Kmn54G8CgD57l6cpTCJUxI9DmtqSXfkmBYJ/UOAX8=;
 b=YUZesAEJ08QJjT6nQzrATbGdOK6TCRz+UDIPvWwTpvs7jmHYi+/YRpnJ9GY96NbfEk
 o+wYIdvVFtmkCDS7oOuNSbmL9rYJ/y1bfjXk6C6chVcelKImSfssKMuln66Zwk9Jmwcq
 xGkYjpB8ArjRREXTEWf78QxZqQjDKgHxtpU3gN8sJVKZhhXVtJVh2Z0STXOKK3th2bCa
 Svzs7gU5FykGr+wyPwz1678iz/OpoZ0O60hUuV+kamgol1xKDrw4zft0evgXfJSKnWfh
 ZzPaE6jCp3pb0JYQJWv/EYghoug7eY2lgU1Yz8v0rAFSz17LEn/6KHNvcJHzl3Z1j1hQ
 EVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688286865; x=1690878865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2Kmn54G8CgD57l6cpTCJUxI9DmtqSXfkmBYJ/UOAX8=;
 b=iGUefOR3MdAZvWoaaLmXXqH7BHsUCA/V6bDey2v+E58qOesa4IYxFtpvsZFiwDcc9x
 Y95gVQMZg4Qn2PrGk/DPXtRcCiOiqfySiMMd/CjYFOKKxYGPbwwKOi14siDUyQ1ffHI5
 6hgBHar0sbAiQxSFi/0pxipfge0rOU5Zq8Cq6W+gqkS85Q5Mxjlzk5ZPYjovkgAJk8LS
 6HVh2pkFr2bRoHQzOIosF/V3uMOFEPy/bu9zKTh0hUGoqjlHSqPFjUJ1Q1lxqP+40ad1
 Tkw60aIqC7//2eyJiKK6OdKko9KtTD9V5WbrTk5sIOlEEmlsVkFe83X+JNkj26b2OH8k
 8AwQ==
X-Gm-Message-State: ABy/qLYJp25nHy3jNu+HsNKZ4zoDks50KVShlc7A+qUjIYoHITsWiC9A
 VvTf8NiEtxdVQP6iGAywekrOaPbk1Cd9UExcif4=
X-Google-Smtp-Source: APBJJlHws5qK73MRnuIYCngC34IjnfJDAEcp6l7SSRiuP654rCnMt77ExtzpKgyyNgVkEGExYAaE4A==
X-Received: by 2002:a17:90a:c696:b0:263:33a9:9aed with SMTP id
 n22-20020a17090ac69600b0026333a99aedmr5518879pjt.24.1688286865013; 
 Sun, 02 Jul 2023 01:34:25 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 18-20020a17090a199200b0024df6bbf5d8sm7563069pji.30.2023.07.02.01.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 01:34:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 3/3] igb: Fix ARI next function numbers
Date: Sun,  2 Jul 2023 17:33:56 +0900
Message-ID: <20230702083357.13517-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702083357.13517-1-akihiko.odaki@daynix.com>
References: <20230702083357.13517-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1032.google.com
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

Fixes: 3a977deebe ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/igb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/igb.c b/hw/net/igb.c
index 1c989d7677..897386fc09 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -431,7 +431,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
         hw_error("Failed to initialize AER capability");
     }
 
-    pcie_ari_init(pci_dev, 0x150, 1);
+    pcie_ari_init(pci_dev, 0x150, 0);
 
     pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
         IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
-- 
2.41.0


