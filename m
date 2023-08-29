Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAEF78BCC7
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 04:25:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaoOt-0002OT-95; Mon, 28 Aug 2023 22:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qaoOp-0002OI-Rk
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 22:24:11 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qaoOn-0002A6-7W
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 22:24:11 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so30857565ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 19:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1693275842; x=1693880642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=broNGonemM+rDaH5unXMoBs7zFx3WjEl12fq4zi9yeU=;
 b=G2+ss+io9qffsslWYu5d0fuVAP9eYS61Y/AwEY0YJdYMv2oIy/FOWYReCb9q1bhueI
 Wnmm5KsF/pD6bK/i4xnmdiwKHnPrVHcGOeLTVQlNCx2vHiQ85F1HVhmVHt9/35Lk1aDT
 +otSvtPQQJyWz7qIKM4Zlx3yWsLE6F1QoK6FJTUPiMptk7SV0UFrJR/xvjmc1e67Xh9M
 ezIZ8JMi0yGlOB/1tZ/LHIiP0xSYJ+7L/vJi2GOrnFzua6R95cDcQtAPUw82skqLFHjT
 M8jKLUFceevTFR+TGxclq+0jiKEPZN95u+iyWVDrPyk6XC13tPOmaOMmPjqfc+ApxMpE
 Iz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693275842; x=1693880642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=broNGonemM+rDaH5unXMoBs7zFx3WjEl12fq4zi9yeU=;
 b=VPWxa27UdiKBBXA2WSMxXzEoZAQjPaLveJcfHtmcdvtiTgFY4HGsAzKYoXfQFYK1au
 SUZ9/VTmgUA9AKaVPqohm+Hq3x0HKHPSSD4q/iEhSF5GzJpc4mxZt+dhym+el4L3Fam+
 /TLvM9ANGOjj2H1a3kYenq743ZpmJBznvaD3ReXKtZDotoOxkDJxVUJCLNenF++6Toio
 SfujMqvpZyHkrwQLSoLaxbwTNGdhfJL2IJzgrLbADTX6avrFFMIR4Auunoe2v25NXc+F
 DPc89cBZxfd/smjnnKrMM/uqi4fbIS76RHNZ+JeBU/FDqwFYBGDYB6g14UpJiHMvIEwz
 Tb/g==
X-Gm-Message-State: AOJu0Yztr+Iq8huOAgvQd0DiNh1OW5Cv9J+S9S5aWrsvrqzXdhyN3QTe
 8k91yRVSsZUrjF/Hg4wz8f8DbQ1fBWdPK2CPdRo=
X-Google-Smtp-Source: AGHT+IFfH7vZ8UusHI0IxYj975/YKyvq6pTTHtrb7u+boXlebelOX+8058rSYu23rYexcVc917jHJQ==
X-Received: by 2002:a17:90a:df95:b0:26f:e9fd:8287 with SMTP id
 p21-20020a17090adf9500b0026fe9fd8287mr10714877pjv.20.1693275841636; 
 Mon, 28 Aug 2023 19:24:01 -0700 (PDT)
Received: from D491Q0MXRG.bytedance.net ([139.177.225.234])
 by smtp.gmail.com with ESMTPSA id
 ci24-20020a17090afc9800b00265a7145fe5sm9612706pjb.41.2023.08.28.19.23.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Aug 2023 19:24:01 -0700 (PDT)
From: hongmianquan <hongmianquan@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, david@redhat.com, philmd@linaro.org,
 peterx@redhat.com, hongmianquan <hongmianquan@bytedance.com>
Subject: [RESEND] memory: avoid updating ioeventfds for some address_space
Date: Tue, 29 Aug 2023 10:23:54 +0800
Message-Id: <20230829022354.94149-1-hongmianquan@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=hongmianquan@bytedance.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When updating ioeventfds, we need to iterate all address spaces,
but some address spaces do not register eventfd_add|del call when
memory_listener_register() and they do nothing when updating ioeventfds.
So we can skip these AS in address_space_update_ioeventfds().

The overhead of memory_region_transaction_commit() can be significantly
reduced. For example, a VM with 8 vhost net devices and each one has
64 vectors, can reduce the time spent on memory_region_transaction_commit by 20%.

Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
---
 include/exec/memory.h |  1 +
 softmmu/memory.c      | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7f5c11a0cc..556f4f1871 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1089,6 +1089,7 @@ struct AddressSpace {
     struct FlatView *current_map;
 
     int ioeventfd_nb;
+    int ioeventfd_notifiers;
     struct MemoryRegionIoeventfd *ioeventfds;
     QTAILQ_HEAD(, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 7d9494ce70..178816c845 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -842,6 +842,10 @@ static void address_space_update_ioeventfds(AddressSpace *as)
     AddrRange tmp;
     unsigned i;
 
+    if (!as->ioeventfd_notifiers) {
+        return;
+    }
+
     /*
      * It is likely that the number of ioeventfds hasn't changed much, so use
      * the previous size as the starting value, with some headroom to avoid
@@ -3075,6 +3079,10 @@ void memory_listener_register(MemoryListener *listener, AddressSpace *as)
     }
 
     listener_add_address_space(listener, as);
+
+    if (listener->eventfd_add || listener->eventfd_del) {
+        as->ioeventfd_notifiers++;
+    }
 }
 
 void memory_listener_unregister(MemoryListener *listener)
@@ -3083,6 +3091,10 @@ void memory_listener_unregister(MemoryListener *listener)
         return;
     }
 
+    if (listener->eventfd_add || listener->eventfd_del) {
+        listener->address_space->ioeventfd_notifiers--;
+    }
+
     listener_del_address_space(listener, listener->address_space);
     QTAILQ_REMOVE(&memory_listeners, listener, link);
     QTAILQ_REMOVE(&listener->address_space->listeners, listener, link_as);
-- 
2.11.0


