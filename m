Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A617619AD
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:19:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOHvl-0002Pg-9t; Tue, 25 Jul 2023 09:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qOG60-0005PX-SU
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:20:53 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qOG5x-0004A5-Gj
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:20:52 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bbc2e1c6b2so1477305ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690284043; x=1690888843;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=broNGonemM+rDaH5unXMoBs7zFx3WjEl12fq4zi9yeU=;
 b=OYzi5MHmVRWnoAdnfkmG0ZeQKqqm6yyergRQLyl9nWyI0oCNqBbCDBWTWI6qP5BkXD
 KHykyJB1GrKazaDNruA7uNVeV4d7DcpXvjdGbt/HsibXZC7fnJdFPkkUxFC2c5+HydNO
 iKMN2gfaqpSDp5embA3yrEz8d3FUM0MUaav53qmKWpmhEs+gXH4lsOhy9gBqUBaRM/kp
 nCkygLkvwIBwFp+J5X+J1mDycOQMzQgRd6xx5ceHBdzEGuLQFvK4PYf1s8UJZjdjL70t
 /4N1wnFGE8SqxwEbuVEjlANn76gaAw646r4vbMG6oZ22WYbViPIF6ohm8rdWqhQcwmuy
 f3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690284043; x=1690888843;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=broNGonemM+rDaH5unXMoBs7zFx3WjEl12fq4zi9yeU=;
 b=NHBqe9x0D9uXB6lClKx1vXpmEe2clHApVyNS12ITr/OUb5DmQHQ/SP1LsKEi30EOfD
 EgeXcAEAjyyTbpQZ0pchBBc25mtkyWpYrMV+FOOnConjxaFsd09GzpgQ/w+Ok4syGQyd
 dKvwS3Vm47/YQGE3dCDD06fMQe/hb1P7/xJqPAeSmNEIWshgA7b3Zs4Frrroeb+I7INZ
 cHM7CY28/bj+Hs5kVwAnXPox9mfTsoyZHDXdgYb1ZPhO812BBNSf+lk6mutC9XAkuJOD
 flEhj3etWuJtpQeFOxFZX734wMfbbRi7G2sdgsZIeSDp+2By0PugFaQcUf8x2uFFqrD6
 emsg==
X-Gm-Message-State: ABy/qLYyZPy9oBZ0ZCZyDof6xCCEJGvfyQfW7IpU3RpKOL/t3D2oE+Cx
 n+QdEeRKb2kkvE8fhf2XieSh3gUd2hKHa5GeS9g=
X-Google-Smtp-Source: APBJJlFFxVM6kAYKd1/AGWW5GE/DdZFwi2t12NWEs+Iw4MZuMwYWBxbe3n+2NGbcdi32VaJ8krO6Lw==
X-Received: by 2002:a17:902:b20e:b0:1b6:8a99:4979 with SMTP id
 t14-20020a170902b20e00b001b68a994979mr8629782plr.22.1690284042889; 
 Tue, 25 Jul 2023 04:20:42 -0700 (PDT)
Received: from n149-064-218.byted.org ([106.38.226.215])
 by smtp.gmail.com with ESMTPSA id
 p23-20020a1709028a9700b001b7f9963febsm10688550plo.175.2023.07.25.04.20.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jul 2023 04:20:41 -0700 (PDT)
From: hongmianquan <hongmianquan@bytedance.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, philmd@linaro.org, david@redhat.com,
 hongmianquan <hongmianquan@bytedance.com>
Subject: [PATCH] memory: avoid updating ioeventfds for some address_space
Date: Tue, 25 Jul 2023 19:20:37 +0800
Message-Id: <20230725112037.1762608-1-hongmianquan@bytedance.com>
X-Mailer: git-send-email 2.11.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=hongmianquan@bytedance.com; helo=mail-pl1-x62a.google.com
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


