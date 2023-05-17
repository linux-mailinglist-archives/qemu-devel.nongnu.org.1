Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4107C706FE3
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLEB-0007py-3N; Wed, 17 May 2023 13:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDt-0007Kv-Jf
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDl-00045m-JT
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4UDkO3Kdy5NCRIXg9Om8yA7mbqwupVdh0F2UuY1x8M=;
 b=G4ASfSl0uwAj7ZyB1YO3W6HuEkRHPyVBYxAcNbc+voCVIYuHQoPIJ4dGZUvFXJdQlj0luN
 VWfxUDmDO9ZXf8iOv1AFLRZFMDhwRhBt3J0UbiNHYENooWI9VBrF2UwaNnAsnAcelMcGez
 U2pslFr8059Yw08nIXVNOVD3pSQQ4Sk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-KuTnZ1d8NO25jygKnVz8lA-1; Wed, 17 May 2023 13:45:50 -0400
X-MC-Unique: KuTnZ1d8NO25jygKnVz8lA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30479b764f9so451276f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345548; x=1686937548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4UDkO3Kdy5NCRIXg9Om8yA7mbqwupVdh0F2UuY1x8M=;
 b=iOx/92xCbxzjl7dPTN8hOvcZv1AzSsLZNLNnfw13pYUue7TX+2xODbCYeEmvoVc5Ce
 0uhYfMNe5ZL7fNE0P34VmPuOI/Hmk1L9LXcQvAqNtLbev320RmUsDlu63fbWH14IJgUa
 xaehioyPO6iWkohcWzSI8w2/G6RdXbLl/tQdwyNUgMbgmBpHOh30uWvO7rdm7rwFTcFt
 o80LsMRR4/rW7YZsJD2s+V92Cb3BQIP9GYibk9bUlYyYrbyL8N3Mh16U0wwfdGbJVyFq
 9X21HS5ZvFhBR3++AWoUpFzTUaj97CuYHf9rAOzq9+/u+qTJjXI54QN6VcnIs/mWjQ33
 zh6g==
X-Gm-Message-State: AC+VfDzGbK8jmR3igjEyvFW7CGDn8dSAq8Y7G5wao4Aordx9olXxtcor
 7wnpWOSwN0McjxXuMv/g//N4oggW/vrYr5Qaj7Ip5JHwIE/avIH2jcqq9mJcEAXXaTzgUgWPh3l
 6KxC7MG6qWrKRh2TxBfaIvowrEhh4zkHzeCoG4JN93uQiDECjahNXleMv0pVN6+7tfWU0QkCr/U
 4=
X-Received: by 2002:adf:db8f:0:b0:306:4125:5f61 with SMTP id
 u15-20020adfdb8f000000b0030641255f61mr1209058wri.44.1684345548642; 
 Wed, 17 May 2023 10:45:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Cdjx7f+zrEroDbjYC6CWe3y/K2J2dmlQTjmNZ92jEZWmBuHToPvuIIhdsHZ1g/20azpeZRg==
X-Received: by 2002:adf:db8f:0:b0:306:4125:5f61 with SMTP id
 u15-20020adfdb8f000000b0030641255f61mr1209048wri.44.1684345548137; 
 Wed, 17 May 2023 10:45:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 z26-20020a7bc7da000000b003f50d6ee334sm2831493wmk.47.2023.05.17.10.45.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/68] coverity: the definitive COMPONENTS.md update
Date: Wed, 17 May 2023 19:44:27 +0200
Message-Id: <20230517174520.887405-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The ordering here tries to be logical and matches the one in the
website.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/COMPONENTS.md | 45 +++++++++++++++++++----------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 7c48e0f1d215..883da95aff22 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -24,6 +24,9 @@ hppa
 i386
   ~ (/qemu)?((/include)?/hw/i386/.*|/target/i386/.*|/hw/intc/[^/]*apic[^/]*\.c)
 
+loongarch
+  ~ (/qemu)?((/include)?/hw/(loongarch/.*|.*/loongarch.*)|/target/loongarch/.*)
+
 m68k
   ~ (/qemu)?((/include)?/hw/m68k/.*|/target/m68k/.*|(/include)?/hw(/.*)?/mcf.*|(/include)?/hw/nubus/.*)
 
@@ -36,11 +39,14 @@ mips
 nios2
   ~ (/qemu)?((/include)?/hw/nios2/.*|/target/nios2/.*)
 
+openrisc
+  ~ (/qemu)?((/include)?/hw/openrisc/.*|/target/openrisc/.*)
+
 ppc
   ~ (/qemu)?((/include)?/hw/ppc/.*|/target/ppc/.*|/hw/pci-host/(uninorth.*|dec.*|prep.*|ppc.*)|/hw/misc/macio/.*|(/include)?/hw/.*/(xics|openpic|spapr).*)
 
 riscv
-  ~ (/qemu)?((/include)?/hw/riscv/.*|/target/riscv/.*)
+  ~ (/qemu)?((/include)?/hw/riscv/.*|/target/riscv/.*|/hw/.*/(riscv_|ibex_|sifive_).*)
 
 rx
   ~ (/qemu)?((/include)?/hw/rx/.*|/target/rx/.*)
@@ -54,12 +60,12 @@ sh4
 sparc
   ~ (/qemu)?((/include)?/hw/sparc(64)?.*|/target/sparc/.*|/hw/.*/grlib.*|/hw/display/cg3.c)
 
-tilegx
-  ~ (/qemu)?(/target/tilegx/.*)
-
 tricore
   ~ (/qemu)?((/include)?/hw/tricore/.*|/target/tricore/.*)
 
+xtensa
+  ~ (/qemu)?((/include)?/hw/xtensa/.*|/target/xtensa/.*)
+
 9pfs
   ~ (/qemu)?(/hw/9pfs/.*|/fsdev/.*)
 
@@ -73,7 +79,7 @@ char
   ~ (/qemu)?(/qemu-char\.c|/include/sysemu/char\.h|(/include)?/hw/char/.*)
 
 crypto
-  ~ (/qemu)?((/include)?/crypto/.*|/hw/.*/crypto.*)
+  ~ (/qemu)?((/include)?/crypto/.*|/hw/.*/.*crypto.*|(/include/sysemu|/backends)/cryptodev.*)
 
 disas
   ~ (/qemu)?((/include)?/disas.*)
@@ -100,7 +106,7 @@ net
   ~ (/qemu)?((/include)?(/hw)?/(net|rdma)/.*)
 
 pci
-  ~ (/qemu)?(/hw/pci.*|/include/hw/pci.*)
+  ~ (/qemu)?(/include)?/hw/(cxl/|pci).*
 
 qemu-ga
   ~ (/qemu)?(/qga/.*)
@@ -108,9 +114,6 @@ qemu-ga
 scsi
   ~ (/qemu)?(/scsi/.*|/hw/scsi/.*|/include/hw/scsi/.*)
 
-tcg
-  ~ (/qemu)?(/accel/tcg/.*|/replay/.*|/(.*/)?softmmu.*)
-
 trace
   ~ (/qemu)?(/.*trace.*\.[ch])
 
@@ -126,9 +129,27 @@ user
 util
   ~ (/qemu)?(/util/.*|/include/qemu/.*)
 
+vfio
+  ~ (/qemu)?(/include)?/hw/vfio/.*
+
+virtio
+  ~ (/qemu)?(/include)?/hw/virtio/.*
+
 xen
   ~ (/qemu)?(.*/xen.*)
 
+hvf
+  ~ (/qemu)?(.*/hvf.*)
+
+kvm
+  ~ (/qemu)?(.*/kvm.*)
+
+tcg
+  ~ (/qemu)?(/accel/tcg|/replay|/tcg)/.*
+
+sysemu
+  ~ (/qemu)?(/softmmu/.*|/accel/.*)
+
 (headers)
   ~ (/qemu)?(/include/.*)
 
@@ -137,9 +158,3 @@ testlibs
 
 tests
   ~ (/qemu)?(/tests/.*)
-
-loongarch
-  ~ (/qemu)?((/include)?/hw/(loongarch/.*|.*/loongarch.*)|/target/loongarch/.*)
-
-riscv
-  ~ (/qemu)?((/include)?/hw/riscv/.*|/target/riscv/.*|/hw/.*/(riscv_|ibex_|sifive_).*)
-- 
2.40.1


