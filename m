Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEC5784538
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:15:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYT5m-0000qe-Kd; Tue, 22 Aug 2023 11:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qYT5a-0000q5-6J
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:14:39 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qYT5V-00023v-A1
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:14:37 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68a529e1974so1601984b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1692717266; x=1693322066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=broNGonemM+rDaH5unXMoBs7zFx3WjEl12fq4zi9yeU=;
 b=Gh5xCAy/01T5N49qDMP31YfGdnojg8O1P1WvZ9nCIadhohfm+jS2VsFxWt9ta9FzDl
 hnelO0Sik5QJOHEexL6aei71ou7EKUE5Z3wvuzXyskHK5rJBOkRwnOZkhPzAmPg81QS5
 LbPnDFBj131EZ2YEhI7lEEz6TLld5H5/hiPwN6pFrH2RYEJhj7D3nNKEkTHd5n1UhjSK
 HKuKCzjbHt3qv6cGW6MYOnh4fGrhapBuWewOuR7Aa8vVgT2HCVRtc8l5xyQoomwos3kj
 vpDPY6E0kuyrR4SfB8cotrWV7Q5/8+5ALpaoIGsvGDA3bG7m+PKQadvrQ0tUIOqGNenq
 Ueeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692717266; x=1693322066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=broNGonemM+rDaH5unXMoBs7zFx3WjEl12fq4zi9yeU=;
 b=f0whWhzJrwIwh+1VaZlFblp4lvL/JT+cgyE0LeP2A+ZpALdg5nUmH6HhDRufz21mwi
 5Nnb9KgplKYxuCoBNak6z+t511h+cULwRm6iKHmGcinZgyRevtSrF6e2rGDKt4BZndAS
 P9hSUxwuiwhH+1CBNx1ntM3jQopwttZs3ykasFHg6ofYZh1lg4kQ+5umFmhsip/0sXyU
 MXhCZOf4T3h2ms5b4jt7xii4s+tj8wvYBqU/VvREImunPZcApdOidpkbi5gV57YPs4hg
 NRVN6s3eoNt1k8upswn52GacmcBQGlrMYe50SgZGP6tdc1IJEuCxRF3UYUr9r6J2AYhP
 wQ8Q==
X-Gm-Message-State: AOJu0Yw9wmXuxhR4RUV72qXAXPF52DaLDf9vsnHJLbDJVXWDqzXSWIrr
 tB9A7NpyONQ85hmSG0pDSz+hqgBc1b3dtdQGjf8oag==
X-Google-Smtp-Source: AGHT+IHaEM3GK7bDy8vS9CV1ZpYxwZ7cIIC2wdQ+un1Vo4DWo9X+dG3Y2IA6aYErSmREmMVekBPTkg==
X-Received: by 2002:a05:6a20:96cb:b0:142:8731:bed1 with SMTP id
 hq11-20020a056a2096cb00b001428731bed1mr6333665pzc.41.1692717266453; 
 Tue, 22 Aug 2023 08:14:26 -0700 (PDT)
Received: from D491Q0MXRG.bytedance.net ([139.177.225.234])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a62be0e000000b00686f0b15b06sm7856948pff.188.2023.08.22.08.14.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 08:14:25 -0700 (PDT)
From: hongmianquan <hongmianquan@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, david@redhat.com, philmd@linaro.org,
 hongmianquan <hongmianquan@bytedance.com>
Subject: [RFC] memory: avoid updating ioeventfds for some address_space
Date: Tue, 22 Aug 2023 23:14:17 +0800
Message-Id: <20230822151417.85429-1-hongmianquan@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=hongmianquan@bytedance.com; helo=mail-pf1-x42b.google.com
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


