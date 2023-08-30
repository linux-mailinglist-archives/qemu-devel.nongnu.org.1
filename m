Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA7E78D28B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 05:30:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbBtY-0005ga-53; Tue, 29 Aug 2023 23:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qbBtU-0005gN-U7
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 23:29:25 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qbBtR-0004KZ-Ue
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 23:29:24 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-573921661a6so1543992eaf.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 20:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1693366154; x=1693970954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DGCRNbBwmZ4s8ixMmG7/3/DWcT05SXPfhcLELFSgqk4=;
 b=MdxNFagMeawzAOQ5qfNmvmhdZI+MvcKaQuweVlwKakeDKLoXmx6WCUB5JVlymcCrhU
 DNpmubDOx3X28425F8weYvxTNycgO1XOZs4zki3bELnB7kEspyQ3BJ0KKuBiv5tnATKP
 DRNd5F+plsw49siuYYKS1UpEQTQ1ET7beOUS5Pt1H4Mp8CoT2aOkWfIXOgcb68znil6w
 v2H1FWIMq+k4IFd5Ja+9f81KRtl8djzTcuq9TkrvFNRa8bDQx/0WnKhARvHUKfjYRmz5
 HvIMjUfQwd7EM38wWU9h6H7iyWRGyDrvZLsPKdG7Vp25FkLy38JJIG8AG3DmVSY8fRaZ
 4+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693366154; x=1693970954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DGCRNbBwmZ4s8ixMmG7/3/DWcT05SXPfhcLELFSgqk4=;
 b=CV0seP6wmz+IKKFcetzQ8kWkOYXYI0d/Vnp3lVDtf2px+NQNwTQwkmyaufO/CZCvSD
 CighryI4NVX0n0G+4F8uZ/0hES5l2dAfxdUM+pQA6YxSrrV2WOKLymGaUN6DuzJ1CF7t
 AQ5+jFkezpu1FoOWEyIbYso/dB1TprHV1onLO7wO7oOUBneGVI/rgD2fkWu8OlaKFn5t
 FNFs6Jjrh7N0v3KiPsTLDwTRZ7hQ3JmNSAJu5TMni9SBVK4VnrwS20kGW8so7zKO3bJY
 QJ0651EQUlq75UTHwM2380bLbIo5Ds5f/PW4wBR86H8xTxxLaf/E+UvZuSsdzVA/1Oc8
 wdsA==
X-Gm-Message-State: AOJu0YxniIN3l+UBfZqSXS8gBJaYDg7HGSB+0sUAjEIu0pY4MFVVj9rO
 RWqTFZygUEHZBrT4yQur8Acir0XKaBd8h2zFUVw=
X-Google-Smtp-Source: AGHT+IFBkdGdCDkhuAnFYDjqsLh2ajOFSfWYvljo733Z3FDvjer9XKSKFNLmNHN7wY92d01T0EGoCQ==
X-Received: by 2002:a05:6808:2a78:b0:3a8:5001:e077 with SMTP id
 fu24-20020a0568082a7800b003a85001e077mr858359oib.53.1693366154526; 
 Tue, 29 Aug 2023 20:29:14 -0700 (PDT)
Received: from D491Q0MXRG.bytedance.net ([139.177.225.234])
 by smtp.gmail.com with ESMTPSA id
 j10-20020a62b60a000000b0063b898b3502sm9109077pff.153.2023.08.29.20.29.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Aug 2023 20:29:13 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, david@redhat.com, philmd@linaro.org,
 peterx@redhat.com, hongmianquan <hongmianquan@bytedance.com>
Subject: [PATCH v2,
 1/1] memory: avoid updating ioeventfds for some address_space
Date: Wed, 30 Aug 2023 11:29:06 +0800
Message-Id: <20230830032906.12488-1-hongmianquan@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=hongmianquan@bytedance.com; helo=mail-oo1-xc30.google.com
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
Reply-to:  hongmianquan <hongmianquan@bytedance.com>
From:  hongmianquan via <qemu-devel@nongnu.org>
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
Reviewed-by: Peter Xu <peterx@redhat.com>
---
v2:
-nothing has changed, just pick PeterXu's review.
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


