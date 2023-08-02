Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A56E76D91E
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:03:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRIyj-0003Nr-NM; Wed, 02 Aug 2023 17:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qRIyh-0003NP-RC
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:01:55 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qRIyf-00066m-O6
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:01:55 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ba0f27a4c2so440251fa.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 14:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691010111; x=1691614911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5CvkVUG/rFbGDmNQ3Ija41k3IytXalwMnMufBPhU0E=;
 b=H/Jr02EZevMG6H1bioE3rgjvXwW3bI4HVMyYhoqVLqNlhZHOFusjODPHRIhm1V8RGs
 lfynVUnsdCzhuJY6akBec80jUhqrchKqfP4EO+oJMA64L0HgyPVM9N6dK2n151azzgmW
 jmCccgPpSVR+9Us6pLq0RGjpsxvo4CXA/Ik8fdc3FPp8zLPnCr9EOcdXR0gOUwLIzJy0
 4LH+4yEj4cCJB2U1C7i+dfSboWAK40XHcF3Fi3ClstbHKvqGGY2YwIyri9WSADyOh1Ld
 o5jZU8MZ3tuUwzfhFVnxQL3kA61fcGOAKUrNoIcWHXeBAehb6G26N2JffLvvB79kRoyA
 N48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691010111; x=1691614911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5CvkVUG/rFbGDmNQ3Ija41k3IytXalwMnMufBPhU0E=;
 b=QluyGa4UFuBBxTS7NLya2bJ9XTwGLhX5SBpJYL4PWDBvsQ6LcZS9tDtePJ0WDY7+aa
 m30mj04X12NdriSZV3MwkB50mIkjcC5uFQRs3oolnnjR3tudVhLYGp33IsoNmw64oOrA
 Q/aDnmuIk6hlFd0twt0LEUWQSMOozmLPAEzYt2XU+nZ1k2VUpcfwPQ4/x8j86zX9JUl6
 /i0Gfe8t09yRoE0AB8o52KE0enwaZWZpQs8dfuut/f3mApXBUkig+Haocw47WyKmdmeR
 0u6jRZmskzZtSEJ7jFkU3azsHez9/OSz5tkBAYkyTtd9D5VEQU7amg2Olv1gNVsTyh5I
 Bi0Q==
X-Gm-Message-State: ABy/qLb3fmc0/xTkL69Skj2ZAOGSgaML4Mx9zaPHeabL0m5Mshi9AzYj
 jA71u8TSZxmt+UHcDPAK8M/yew==
X-Google-Smtp-Source: APBJJlGYdrWt7t4rGJLvQy5nisBmM+X2ko4tbzIXapMY/DFVcSgJ0mufNnDL/Y2V4DZ6EtdTNlEHJQ==
X-Received: by 2002:a2e:9d05:0:b0:2b6:d700:fbdd with SMTP id
 t5-20020a2e9d05000000b002b6d700fbddmr5543949lji.15.1691010111052; 
 Wed, 02 Aug 2023 14:01:51 -0700 (PDT)
Received: from localhost.localdomain ([194.126.180.172])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05651c00c800b002ba045496d0sm391880ljr.125.2023.08.02.14.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 14:01:50 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, qemu-devel@nongnu.org
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v5 1/5] ebpf: Added eBPF map update through mmap.
Date: Wed,  2 Aug 2023 23:41:19 +0300
Message-ID: <20230802204125.33688-2-andrew@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802204125.33688-1-andrew@daynix.com>
References: <20230802204125.33688-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::22e;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Changed eBPF map updates through mmaped array.
Mmaped arrays provide direct access to map data.
It should omit using bpf_map_update_elem() call,
which may require capabilities that are not present.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 ebpf/ebpf_rss.c | 117 ++++++++++++++++++++++++++++++++++++++----------
 ebpf/ebpf_rss.h |   5 +++
 2 files changed, 99 insertions(+), 23 deletions(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index cee658c158b..247f5eee1b6 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -27,19 +27,83 @@ void ebpf_rss_init(struct EBPFRSSContext *ctx)
 {
     if (ctx != NULL) {
         ctx->obj = NULL;
+        ctx->program_fd = -1;
+        ctx->map_configuration = -1;
+        ctx->map_toeplitz_key = -1;
+        ctx->map_indirections_table = -1;
+
+        ctx->mmap_configuration = NULL;
+        ctx->mmap_toeplitz_key = NULL;
+        ctx->mmap_indirections_table = NULL;
     }
 }
 
 bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
 {
-    return ctx != NULL && ctx->obj != NULL;
+    return ctx != NULL && (ctx->obj != NULL || ctx->program_fd != -1);
+}
+
+static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
+{
+    if (!ebpf_rss_is_loaded(ctx)) {
+        return false;
+    }
+
+    ctx->mmap_configuration = mmap(NULL, qemu_real_host_page_size(),
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   ctx->map_configuration, 0);
+    if (ctx->mmap_configuration == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration array");
+        return false;
+    }
+    ctx->mmap_toeplitz_key = mmap(NULL, qemu_real_host_page_size(),
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   ctx->map_toeplitz_key, 0);
+    if (ctx->mmap_toeplitz_key == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key");
+        goto toeplitz_fail;
+    }
+    ctx->mmap_indirections_table = mmap(NULL, qemu_real_host_page_size(),
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   ctx->map_indirections_table, 0);
+    if (ctx->mmap_indirections_table == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection table");
+        goto indirection_fail;
+    }
+
+    return true;
+
+indirection_fail:
+    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
+toeplitz_fail:
+    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
+
+    ctx->mmap_configuration = NULL;
+    ctx->mmap_toeplitz_key = NULL;
+    ctx->mmap_indirections_table = NULL;
+    return false;
+}
+
+static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)
+{
+    if (!ebpf_rss_is_loaded(ctx)) {
+        return;
+    }
+
+    munmap(ctx->mmap_indirections_table, qemu_real_host_page_size());
+    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
+    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
+
+    ctx->mmap_configuration = NULL;
+    ctx->mmap_toeplitz_key = NULL;
+    ctx->mmap_indirections_table = NULL;
 }
 
 bool ebpf_rss_load(struct EBPFRSSContext *ctx)
 {
     struct rss_bpf *rss_bpf_ctx;
 
-    if (ctx == NULL) {
+    if (ctx == NULL || ebpf_rss_is_loaded(ctx)) {
         return false;
     }
 
@@ -66,10 +130,18 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
     ctx->map_toeplitz_key = bpf_map__fd(
             rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
 
+    if (!ebpf_rss_mmap(ctx)) {
+        goto error;
+    }
+
     return true;
 error:
     rss_bpf__destroy(rss_bpf_ctx);
     ctx->obj = NULL;
+    ctx->program_fd = -1;
+    ctx->map_configuration = -1;
+    ctx->map_toeplitz_key = -1;
+    ctx->map_indirections_table = -1;
 
     return false;
 }
@@ -77,15 +149,11 @@ error:
 static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
                                 struct EBPFRSSConfig *config)
 {
-    uint32_t map_key = 0;
-
     if (!ebpf_rss_is_loaded(ctx)) {
         return false;
     }
-    if (bpf_map_update_elem(ctx->map_configuration,
-                            &map_key, config, 0) < 0) {
-        return false;
-    }
+
+    memcpy(ctx->mmap_configuration, config, sizeof(*config));
     return true;
 }
 
@@ -93,27 +161,19 @@ static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
                                             uint16_t *indirections_table,
                                             size_t len)
 {
-    uint32_t i = 0;
-
     if (!ebpf_rss_is_loaded(ctx) || indirections_table == NULL ||
        len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
         return false;
     }
 
-    for (; i < len; ++i) {
-        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
-                                indirections_table + i, 0) < 0) {
-            return false;
-        }
-    }
+    memcpy(ctx->mmap_indirections_table, indirections_table,
+            sizeof(*indirections_table) * len);
     return true;
 }
 
 static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
                                      uint8_t *toeplitz_key)
 {
-    uint32_t map_key = 0;
-
     /* prepare toeplitz key */
     uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] = {};
 
@@ -123,10 +183,7 @@ static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
     memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
     *(uint32_t *)toe = ntohl(*(uint32_t *)toe);
 
-    if (bpf_map_update_elem(ctx->map_toeplitz_key, &map_key, toe,
-                            0) < 0) {
-        return false;
-    }
+    memcpy(ctx->mmap_toeplitz_key, toe, VIRTIO_NET_RSS_MAX_KEY_SIZE);
     return true;
 }
 
@@ -160,6 +217,20 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
         return;
     }
 
-    rss_bpf__destroy(ctx->obj);
+    ebpf_rss_munmap(ctx);
+
+    if (ctx->obj) {
+        rss_bpf__destroy(ctx->obj);
+    } else {
+        close(ctx->program_fd);
+        close(ctx->map_configuration);
+        close(ctx->map_toeplitz_key);
+        close(ctx->map_indirections_table);
+    }
+
     ctx->obj = NULL;
+    ctx->program_fd = -1;
+    ctx->map_configuration = -1;
+    ctx->map_toeplitz_key = -1;
+    ctx->map_indirections_table = -1;
 }
diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
index bf3f2572c7c..ab08a7266d0 100644
--- a/ebpf/ebpf_rss.h
+++ b/ebpf/ebpf_rss.h
@@ -20,6 +20,11 @@ struct EBPFRSSContext {
     int map_configuration;
     int map_toeplitz_key;
     int map_indirections_table;
+
+    /* mapped eBPF maps for direct access to omit bpf_map_update_elem() */
+    void *mmap_configuration;
+    void *mmap_toeplitz_key;
+    void *mmap_indirections_table;
 };
 
 struct EBPFRSSConfig {
-- 
2.41.0


