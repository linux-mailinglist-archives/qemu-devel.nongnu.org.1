Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DED297AF16D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:00:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBPf-000250-Ul; Tue, 26 Sep 2023 12:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPR-000241-9W
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPO-0006dv-TF
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ynynMgJ00sGhsDMCQzVUy7jtIudZ5+n2/lNWTNS1uM=;
 b=GSTx97yl0He5Bdok/Hjhf21TmPiX3TrcHKrZJqYLmyYEa4zH9A5hAlj2HWXV/50s2r+sHc
 adVS6fouIbgDOWGN1A7E3hEIuJ8Fs+nKZmsPojUhoaOHmnoYuViTzNEnTKDj+TNsUzZwGF
 Wb8obcJupwGhOQHCkM3WdaoC24CFIPI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-xPOFnlTfO76DxHDCZy3Jog-1; Tue, 26 Sep 2023 12:59:35 -0400
X-MC-Unique: xPOFnlTfO76DxHDCZy3Jog-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40526a782f7so85256015e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747573; x=1696352373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ynynMgJ00sGhsDMCQzVUy7jtIudZ5+n2/lNWTNS1uM=;
 b=YoEEFKFDQqeulyab823Qhlq9958pCI6f71pLE7/yfa8kN//kWZ0v4L9cr3XX9RUbRF
 wT2IB6LgECUSECq9Mb5dGrRD+RDmxANVb2VEFjA/wGVxF1c5csinrFSSlfWQsT/EBauA
 OwQk/Srfqkg/xWogYvHesnZf0iAAehI5GWzU7W8AxrYgaJxKMcl4Ilmbdt7enNucGRXH
 d+hQ+Xi397ACbkM5unUEswoZCXq1gF1mj9+kKMZLExsNlawzEv7q5pDzLN2mrSmxOElj
 +C4tkhYJTDUHD7ojDbi3BO+jsc01BxPMW47Qvfneu6C1inkaWgICfpHqk52qTK7VMbHM
 ylWw==
X-Gm-Message-State: AOJu0YzxEtxcMIT62ON9VSuq8Bdx7O8GvF3GHxdP4H3n5Uvk84CTtfn0
 YVjjocLfDUvsM2PMG1LbFqwsPU3VVePbK+jTjZhyhJgQGE0jXyCLqUAmDbt4iYdH9f1RSmg2xMJ
 JUIUbxG0/LqQiDPgDPrrT32bv3fSp/aPpTEUFMVt4UvOxQkdQJs+nVmVwCxZuQE6Yhu0sIwYrW6
 Q=
X-Received: by 2002:a05:600c:2309:b0:405:3fcc:5af5 with SMTP id
 9-20020a05600c230900b004053fcc5af5mr9887632wmo.17.1695747573484; 
 Tue, 26 Sep 2023 09:59:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKKuaTbW5Ik1V69dzXijP2Yn15+pYdS9EqRdOdHXTC/F4+DrrMMv48uF0aSq7KIYsyfhmPOA==
X-Received: by 2002:a05:600c:2309:b0:405:3fcc:5af5 with SMTP id
 9-20020a05600c230900b004053fcc5af5mr9887616wmo.17.1695747573157; 
 Tue, 26 Sep 2023 09:59:33 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a05600c1d9300b0040531f5c51asm15841878wms.5.2023.09.26.09.59.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/19] mptsas: avoid shadowed local variables
Date: Tue, 26 Sep 2023 18:59:04 +0200
Message-ID: <20230926165915.738719-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


