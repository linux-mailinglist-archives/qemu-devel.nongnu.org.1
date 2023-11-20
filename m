Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DC67F1F5E
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:41:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Bxr-0002GN-39; Mon, 20 Nov 2023 16:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bxi-0002FG-Kh
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:37:46 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bxg-0004Ts-1S
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:37:46 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32d9d8284abso3241688f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516262; x=1701121062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/MsY2VFHgbOiPtWRWKtDZy46HK6KETJnE5K0HuwqNo=;
 b=O5RQUENCCErWTYTEnoNxkniRinvV1FB17+hMpcT7/e8VCKb5QLe3rQ/Wq6AlvGfaDF
 GJ8XH3AZjkmOUdawnnxaU/syG9EEHJ9GVdbwPcJhCw2V1ajahla7O0mPLlPAnx2+SI4P
 WCM86gqW1ta3w5GPv++QmY6fMqgb+XqGDhMbDRgHDnTpuWf81FiRB9y/yHQzP8ZZZ+fE
 yAucheq0DppBU3eBqTj6jgPKOqAP6L/6kB6lvpY2Hjg1cuRZ34ErYdqvekHjUheY1jok
 gp8b7n09c4qf2GC4ET5AQW66CampadO3lMYDDDONh2ctfOb+aqc5bQj7VTuuYG0BMgno
 FgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516262; x=1701121062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/MsY2VFHgbOiPtWRWKtDZy46HK6KETJnE5K0HuwqNo=;
 b=Fp5N8yH76YIFfHsYwCPGuyUSXZX5ffoTYW0akpj7L7FtGcXjgOPRfraxnxaMfejUDe
 oKakCtnslW07b8BfXorNlQ9soyhfBuuG8AJTnXdsXvQBB4UYXdom3BxX7ljX/4P9hl84
 WGoEXySQrUTra72+aAbAtaOU9LP3NWqcseB9FYaQamORvoWSjLfCiPeQqRd/U6OcPQxK
 rd2qRhgBcVQnSDsZuxzchHwZ2NTbrFJxC9LL2dxhD9T0FGnS0WaNoWpjb8WuJR+uegiF
 meKdhi/zdaO4U98qjhdpsOQV13WmJlcWx/Ly7+kBnTRAVj/ydGeCvNOe/dUeSi4rMruv
 n91g==
X-Gm-Message-State: AOJu0YyQyZn7JgU48LEY0n2gmhbKPHzYRiCMZ1pMt0j6EfKF9bdZb/LS
 8/TVqipuPYwF6A4tBsR8JxsW2a7OamOHyiVVUro=
X-Google-Smtp-Source: AGHT+IE8gBcwoSYEGtKWmwdpw3yHY8HAAZKAHltL7GBuNQW31gMUJeCsu5m5xUdBC6ykAj0kPtWBKw==
X-Received: by 2002:a05:6000:1050:b0:332:c6d1:b6e1 with SMTP id
 c16-20020a056000105000b00332c6d1b6e1mr3068944wrx.14.1700516262358; 
 Mon, 20 Nov 2023 13:37:42 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a5d5606000000b00331698cb263sm12119027wrv.103.2023.11.20.13.37.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:37:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-9.0 19/25] misc: Simplify qemu_prealloc_mem() calls
Date: Mon, 20 Nov 2023 22:32:53 +0100
Message-ID: <20231120213301.24349-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 75ee38aa46..12dc39e0b1 100644
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


