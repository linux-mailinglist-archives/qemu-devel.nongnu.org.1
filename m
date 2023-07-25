Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EACCD7619AA
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:19:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOHvl-0002Pe-5R; Tue, 25 Jul 2023 09:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qODo8-0004jz-0V
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:54:16 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qODo4-0006aM-Mr
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:54:15 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b9c368f4b5so40964725ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690275242; x=1690880042;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0pzAJZrHU0KbHpFBeHsykcJ01QyEBVPYtIC3to6C0k=;
 b=h1afFDPx9gvUAIGy3LiSw5RdUwpbXAHoMODFm+NCyo2LG8XDCTk3RvYRyaAKsOZVXw
 SE/ecpS9mSgrkHKwt3bkfkbz+ZgZ72UmQnsQy71sc1iQA+ycV1o2Eqde0QalapYHvz2T
 k5WKTwCPH0UFi4kxPGBPEdWiyyWCyStPZKVMsXvwnBM7kYbkvodrzHhpSLSLzOCGpmHp
 XFL+QKxdA5QAvcTyu/WJ8Eb1+o4+mF5NzleDLpiwQl0iOZI2pwEhghmkrF2dupLTQ55h
 d2Z3dSjQ5mELhJwWBUMoQWiKBjRHMlAXp2ny6qD8B6MedXDCvhHfknYSJBcEZkjQimIV
 QqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690275242; x=1690880042;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0pzAJZrHU0KbHpFBeHsykcJ01QyEBVPYtIC3to6C0k=;
 b=drQ7TW6nATwFTmmeLy1aJexqgDWNKqEfOWW/VZsA+PBl+IjVHiTb1EVSYOCEocXP2F
 +zw+8VpMm1UrrjcgZiFxvxvSZksVAK3IQ68hsAB6uKAbZigsOnNgykU09h7IxzKPRe95
 purwa7tmIrlfoKTom9J0B8DCm+ycdLl1rWy9L7t01fEqQbOm+iXyFHx64vUuVhTvM1po
 0LwGBBFTAIBS2Xnl7Py7wdhFyTBjdKy7MRpmaHgdG6MNk+Ra8QheBD3Ea0US8uWnyc9L
 l4rqKpTxre5oAWdNT6qFMcftEJlfGaB1Yfp4yfsWW/KbdnDqBvqs2elfKkiqgyjYZ4mo
 WDUA==
X-Gm-Message-State: ABy/qLZPM57RctoezP10T15r3t0yCGlpopqjm1aVi3goG46EXrl26mSz
 ZHJVOvfxrzu29vltWqnhKUglUoPubaFqnt9EhbYrVw==
X-Google-Smtp-Source: APBJJlEz52k/TzvIQtMSuzdQgHrvyX4Td6XlZrK8jhMvMLdRJFHHUlv2ykh/aj4IKB3Eb3mFwC7fog==
X-Received: by 2002:a17:903:41c9:b0:1b9:d335:1b7d with SMTP id
 u9-20020a17090341c900b001b9d3351b7dmr2356542ple.6.1690275242181; 
 Tue, 25 Jul 2023 01:54:02 -0700 (PDT)
Received: from n149-064-218.byted.org ([106.38.226.75])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090341c100b001b882880550sm10409992ple.282.2023.07.25.01.54.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jul 2023 01:54:01 -0700 (PDT)
From: hongmianquan <hongmianquan@bytedance.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	hongmianquan <hongmianquan@bytedance.com>
Subject: [PATCH] memory: avoid updating ioeventfds for some address_space
Date: Tue, 25 Jul 2023 16:53:56 +0800
Message-Id: <20230725085356.1425400-1-hongmianquan@bytedance.com>
X-Mailer: git-send-email 2.11.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=hongmianquan@bytedance.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Jul 2023 09:18:23 -0400
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
index 7d9494ce70..77042d3f93 100644
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
+        as->ioeventfd_notifiers--;
+    }
+
     listener_del_address_space(listener, listener->address_space);
     QTAILQ_REMOVE(&memory_listeners, listener, link);
     QTAILQ_REMOVE(&listener->address_space->listeners, listener, link_as);
-- 
2.11.0


