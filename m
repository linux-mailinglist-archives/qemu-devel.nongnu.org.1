Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C952825724
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:52:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmTD-00017W-TM; Fri, 05 Jan 2024 10:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmRy-0007o3-VX
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:49:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmRw-0000I0-GL
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:49:34 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d5f40ce04so17306865e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469770; x=1705074570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Woygxb5I84iWcYNaobFk5BQd3UxVH0KFWr0IJtclL9o=;
 b=Ckxd5aEW30HBEabc+kyoDNBFSBgsK9nVKTqm+JR4jlJZiGUiEzLETvaGonHR/xPErY
 v4JYS+DhetyLJ5Lp9XuaeV69NgP/UrjbUjesSPq5e+d1CirGxcH0QFC+NONjtlZp4lU1
 ATEOfPaph8R3nl+29iPXEIWBcJWYnPmQtmHxLaDjnssMb172xzIT/aJauGT9+u9FSJro
 +ajmymCY8Lb4hMG80nG5M/qYaeIPGgT/KlqqVqfEHHmYFRmP+/40vFOEao9aA8SPG0xQ
 addq9KrNO2PuhJfkA7SOpU3qV6pBzvQqRgVMXsiVUYtnJb99S/qtEncycLulbYrkCocW
 6wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469770; x=1705074570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Woygxb5I84iWcYNaobFk5BQd3UxVH0KFWr0IJtclL9o=;
 b=MHRtK8UFl563qUnOnMi1scnHC2AjT9iIuWibDepqe4FIIxzp+hF0M4X7Hm84kzZ/e3
 i05GW7L8DDObeLCpVgfMMaXI/wb+KOFmc2n2Lwg7LlV2pC549A0MMW9/cV2+ozbxMotP
 uh1oYEtcgey8D9GVb3iJyigOsoDhBvHwIOfRQLSzMCFzdabB6R6o7+cnj0S1k5Cwk5fd
 0crBK3P5CZpANTG0Xndo6mvsOR7NllC+8fDQeCVrQNu9VAytNtsqDJlPZvvtyJUx9u4q
 6vuM6HmgRbxtHJzyuA3RtXiHpOy8xUAbPofVh6NsyawnCHgRhQceYk1Wpca32LVUeAr/
 +s1Q==
X-Gm-Message-State: AOJu0Yxa/4iYpikvhy3ibeX05ZCaijGAUY6SgHA735h9AgGuspaKFaTq
 JilbeHPmPZflnuqanU3VzYymFwz0eUk6FzwkafyBOS/+U/Y=
X-Google-Smtp-Source: AGHT+IFj7g+Jiz/gUa6sy6goPKZ431YyH55zl8uNAkLJs6GWTCq2clGafVgdd1ErZrmHAKEqnxbUWg==
X-Received: by 2002:a05:600c:4fc1:b0:40d:fc98:b88f with SMTP id
 o1-20020a05600c4fc100b0040dfc98b88fmr1258706wmq.49.1704469769865; 
 Fri, 05 Jan 2024 07:49:29 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 t1-20020adfd001000000b0033672971fabsm1603944wrh.115.2024.01.05.07.49.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:49:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gavin Shan <gshan@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 62/71] misc: Simplify qemu_prealloc_mem() calls
Date: Fri,  5 Jan 2024 16:42:55 +0100
Message-ID: <20240105154307.21385-63-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Since qemu_prealloc_mem() returns whether or not an error
occured, we don't need to check the @errp pointer. Remove
local_err uses when we can return directly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-Id: <20231120213301.24349-20-philmd@linaro.org>
---
 backends/hostmem.c     | 22 +++++++---------------
 hw/virtio/virtio-mem.c |  6 ++----
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 1b0043a0d9..30f69b2cb5 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -219,7 +219,6 @@ static bool host_memory_backend_get_prealloc(Object *obj, Error **errp)
 static void host_memory_backend_set_prealloc(Object *obj, bool value,
                                              Error **errp)
 {
-    Error *local_err = NULL;
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
 
     if (!backend->reserve && value) {
@@ -237,10 +236,8 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
 
-        qemu_prealloc_mem(fd, ptr, sz, backend->prealloc_threads,
-                          backend->prealloc_context, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!qemu_prealloc_mem(fd, ptr, sz, backend->prealloc_threads,
+                               backend->prealloc_context, errp)) {
             return;
         }
         backend->prealloc = true;
@@ -398,16 +395,11 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
      * This is necessary to guarantee memory is allocated with
      * specified NUMA policy in place.
      */
-    if (backend->prealloc) {
-        Error *local_err = NULL;
-
-        qemu_prealloc_mem(memory_region_get_fd(&backend->mr), ptr, sz,
-                          backend->prealloc_threads,
-                          backend->prealloc_context, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
+    if (backend->prealloc && !qemu_prealloc_mem(memory_region_get_fd(&backend->mr),
+                                                ptr, sz,
+                                                backend->prealloc_threads,
+                                                backend->prealloc_context, errp)) {
+        return;
     }
 }
 
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index dc4709790f..99ab989852 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -605,8 +605,7 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
         int fd = memory_region_get_fd(&vmem->memdev->mr);
         Error *local_err = NULL;
 
-        qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err);
-        if (local_err) {
+        if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
             static bool warned;
 
             /*
@@ -1249,8 +1248,7 @@ static int virtio_mem_prealloc_range_cb(VirtIOMEM *vmem, void *arg,
     int fd = memory_region_get_fd(&vmem->memdev->mr);
     Error *local_err = NULL;
 
-    qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err);
-    if (local_err) {
+    if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
         error_report_err(local_err);
         return -ENOMEM;
     }
-- 
2.41.0


