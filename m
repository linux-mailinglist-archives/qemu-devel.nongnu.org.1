Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5161E7ADA60
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:50:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmsj-0000cq-B2; Mon, 25 Sep 2023 10:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsN-0000ZV-Ow
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsJ-00082F-VW
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+ynynMgJ00sGhsDMCQzVUy7jtIudZ5+n2/lNWTNS1uM=;
 b=DmeLFmXQgfzeLvS3qIyH8hDp5+lip20NAhKHTNKZgsyZWFdE/PUZFbZp5CV2Fgs2sYTtyy
 tfWga+JNkxqImS1Ok/W4+X8l2/sfG8vz7RZIjYSI6gmyKdqybo+kRRDVLE6uzLXSql+l8r
 tL+t4LAqIjiotnA6K+pOCUuwY1QXpn0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-zkE0yReDMQmgee56BUZRgQ-1; Mon, 25 Sep 2023 10:47:48 -0400
X-MC-Unique: zkE0yReDMQmgee56BUZRgQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4053d832d51so49356865e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653266; x=1696258066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ynynMgJ00sGhsDMCQzVUy7jtIudZ5+n2/lNWTNS1uM=;
 b=ebM89zmxcYjAmMlpFb3eGzGSb/OVpp1Lvm9OW8rAF6HiCsi0jaUR/TUsGsAaIryZYW
 rEv1Tt3tXtUWTkceJ4c/CJgfjnH0BgABvDzlmAsNqWkRZ7vUtF5KcQ75kpzOk8BudJi3
 NypcNhVnFVTSlV9QTJqgBImR8toXnXcRwT5vJue2woxB/WkHj7DqT49+UgoBSCZxXEBo
 WmKsI6BICQ8f4ARtHdglRfHYGitcg2YFshqUBBfieVGbANKft/5KYP1n+S71eFZpWM6i
 frJ2nUV032HLadvbbYsieOdSgZ+qp/QnyCztIDB6RQRZZDyOjK29dYUTXu3EHnarTyzp
 f7Xg==
X-Gm-Message-State: AOJu0Ywn762jaLkcavXzslX9dDeFsKzdJvijOo1g27d0/gj7cXO1aoRV
 3l03e5wIpfiMEulB4Q6SquTY32x21WLSrJ7pDkVqBhbrQ3kpTZ5mVVJ4WvHzgJXmIka9SHF7MCn
 MCWLwn1kCyN0pPicvpNsC+PAYVUN2Nuvvophn/feSJjmzZsXRyBwm8CdRxWFeJ+eZf8ERVEzJ6Q
 o=
X-Received: by 2002:a1c:721a:0:b0:3ff:516b:5c65 with SMTP id
 n26-20020a1c721a000000b003ff516b5c65mr6018672wmc.30.1695653266605; 
 Mon, 25 Sep 2023 07:47:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjE1RYMgykv5A2EjOUaCIOxpuZMxOOxoaCHhQY1kZs+dqqlG0vlEwHqN3eUfwdzs7BbGOvwA==
X-Received: by 2002:a1c:721a:0:b0:3ff:516b:5c65 with SMTP id
 n26-20020a1c721a000000b003ff516b5c65mr6018654wmc.30.1695653266193; 
 Mon, 25 Sep 2023 07:47:46 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 23-20020a05600c229700b00403b63e87f2sm12556827wmf.32.2023.09.25.07.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:47:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] mptsas: avoid shadowed local variables
Date: Mon, 25 Sep 2023 16:47:38 +0200
Message-ID: <20230925144744.527958-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rename the argument so that "addr" is only used inside the for loop.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/mptsas.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 3de288b454c..75d3ab8bd18 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -192,7 +192,7 @@ static dma_addr_t mptsas_ld_sg_base(MPTSASState *s, uint32_t flags_and_length,
     return addr;
 }
 
-static int mptsas_build_sgl(MPTSASState *s, MPTSASRequest *req, hwaddr addr)
+static int mptsas_build_sgl(MPTSASState *s, MPTSASRequest *req, hwaddr req_addr)
 {
     PCIDevice *pci = (PCIDevice *) s;
     hwaddr next_chain_addr;
@@ -201,8 +201,8 @@ static int mptsas_build_sgl(MPTSASState *s, MPTSASRequest *req, hwaddr addr)
     uint32_t chain_offset;
 
     chain_offset = req->scsi_io.ChainOffset;
-    next_chain_addr = addr + chain_offset * sizeof(uint32_t);
-    sgaddr = addr + sizeof(MPIMsgSCSIIORequest);
+    next_chain_addr = req_addr + chain_offset * sizeof(uint32_t);
+    sgaddr = req_addr + sizeof(MPIMsgSCSIIORequest);
     pci_dma_sglist_init(&req->qsg, pci, 4);
     left = req->scsi_io.DataLength;
 
-- 
2.41.0


