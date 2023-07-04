Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A55746B87
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGb3m-0006mX-Gb; Tue, 04 Jul 2023 04:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qGb3k-0006lv-CQ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:06:52 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qGb3h-0000ta-5u
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:06:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6686708c986so4331631b3a.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688458008; x=1691050008; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBKn+fLwG4WbDopaOGiZKodHGjHZmzgCsifZztYw2kw=;
 b=o0RJ+dkUAlH8Zj4CiDZJIFG1GXrDPaFjdX1698RMOvY2i8GsYa9ONGIIEzFd5eIJXE
 IH+u9Ztl6j1BrJr8bywr1IxX7bsKA7W1hYguJa8eOQMSbwJZRlq7kiQ8insSiT5hOksc
 eQfs1NqooJ6ZCyculb81OMsNFhIWwPF4piOCwFJ6UzHFTjbfWG9xFNPTSuI+jIqL0uuw
 hWi0UQTq2WPZIGX9rRyiLMieJ5zv2FMViy1NdyRIw/5awFiWGvY4snrzXRZPGT6ZeOQx
 VZRqTpWEONqWpd5Ft2Rt4a7NLO8sGMtjJG0dMstOsjXczgOXHX/+OwcOmKt/PkQoRQnT
 U8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688458008; x=1691050008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iBKn+fLwG4WbDopaOGiZKodHGjHZmzgCsifZztYw2kw=;
 b=JpFJzcc+0+n9pdSQj+T/nQderxgFGcPzIN4KUFWC7aeBqwIucwbQ4u/Dc/4wqQWKWe
 3tJXpneGwtI0vR8DDP1avDvSFPQMZRK7/LCh0hPG0ar/Jrpm8aiJQEFTcOc5y+JH5Z9K
 Yj6I4UjtB0bBYRm+BYbTg+p92J+/DIq/LHuBum3rG36o8b1mNb5gIZI3qhdCIKr0NTf+
 qcItF3Ec6pfXAxDcnJjzKCsiUB4j3IMlrdpb96GlDHA+G70JNP7G2cTUmDyjlKQW161L
 wDgHhd0gfMZt6PnqF0Z65m+qJWQY8Ik6wXOhNV5Nf/8kPuuBfQpPlNESf014PQa95EHU
 wPTg==
X-Gm-Message-State: ABy/qLYdL+pvtJFw+bM5AuBTBhDkF+eCe09BhDBkzBddzJY9QLUe55+/
 fL60IKhInNel+ospJqtvvSdaLImyDPKvq9VX8WkDyw==
X-Google-Smtp-Source: APBJJlG4AXASuhwYZGfhChvCqxS3dwQFnDX/u1UJRPXZ+J4UDYPYwghEvTGyFvafNxAUAb3L213XsQ==
X-Received: by 2002:a05:6a00:2488:b0:681:142f:e8e3 with SMTP id
 c8-20020a056a00248800b00681142fe8e3mr17100221pfv.14.1688458007714; 
 Tue, 04 Jul 2023 01:06:47 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b00662c4ca18ebsm15113101pfm.128.2023.07.04.01.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 01:06:47 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 stefanha@redhat.com, David Hildenbrand <david@redhat.com>,
 john.levon@nutanix.com, Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH 2/3] softmmu: Remove DMA unmap notification callback
Date: Tue,  4 Jul 2023 01:06:26 -0700
Message-Id: <20230704080628.852525-3-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704080628.852525-1-mnissler@rivosinc.com>
References: <20230704080628.852525-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

According to old commit messages, this was introduced to retry a DMA
operation at a later point in case the single bounce buffer is found to
be busy. This was never used widely - only the dma-helpers code made use
of it, but there are other device models that use multiple DMA mappings
(concurrently) and just failed.

After the improvement to support multiple concurrent bounce buffers,
the condition the notification callback allowed to work around no
longer exists, so we can just remove the logic and simplify the code.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 softmmu/dma-helpers.c | 28 -----------------
 softmmu/physmem.c     | 71 -------------------------------------------
 2 files changed, 99 deletions(-)

diff --git a/softmmu/dma-helpers.c b/softmmu/dma-helpers.c
index 2463964805..d05d226f11 100644
--- a/softmmu/dma-helpers.c
+++ b/softmmu/dma-helpers.c
@@ -68,23 +68,10 @@ typedef struct {
     int sg_cur_index;
     dma_addr_t sg_cur_byte;
     QEMUIOVector iov;
-    QEMUBH *bh;
     DMAIOFunc *io_func;
     void *io_func_opaque;
 } DMAAIOCB;
 
-static void dma_blk_cb(void *opaque, int ret);
-
-static void reschedule_dma(void *opaque)
-{
-    DMAAIOCB *dbs = (DMAAIOCB *)opaque;
-
-    assert(!dbs->acb && dbs->bh);
-    qemu_bh_delete(dbs->bh);
-    dbs->bh = NULL;
-    dma_blk_cb(dbs, 0);
-}
-
 static void dma_blk_unmap(DMAAIOCB *dbs)
 {
     int i;
@@ -101,7 +88,6 @@ static void dma_complete(DMAAIOCB *dbs, int ret)
 {
     trace_dma_complete(dbs, ret, dbs->common.cb);
 
-    assert(!dbs->acb && !dbs->bh);
     dma_blk_unmap(dbs);
     if (dbs->common.cb) {
         dbs->common.cb(dbs->common.opaque, ret);
@@ -164,13 +150,6 @@ static void dma_blk_cb(void *opaque, int ret)
         }
     }
 
-    if (dbs->iov.size == 0) {
-        trace_dma_map_wait(dbs);
-        dbs->bh = aio_bh_new(ctx, reschedule_dma, dbs);
-        cpu_register_map_client(dbs->bh);
-        goto out;
-    }
-
     if (!QEMU_IS_ALIGNED(dbs->iov.size, dbs->align)) {
         qemu_iovec_discard_back(&dbs->iov,
                                 QEMU_ALIGN_DOWN(dbs->iov.size, dbs->align));
@@ -189,18 +168,12 @@ static void dma_aio_cancel(BlockAIOCB *acb)
 
     trace_dma_aio_cancel(dbs);
 
-    assert(!(dbs->acb && dbs->bh));
     if (dbs->acb) {
         /* This will invoke dma_blk_cb.  */
         blk_aio_cancel_async(dbs->acb);
         return;
     }
 
-    if (dbs->bh) {
-        cpu_unregister_map_client(dbs->bh);
-        qemu_bh_delete(dbs->bh);
-        dbs->bh = NULL;
-    }
     if (dbs->common.cb) {
         dbs->common.cb(dbs->common.opaque, -ECANCELED);
     }
@@ -239,7 +212,6 @@ BlockAIOCB *dma_blk_io(AioContext *ctx,
     dbs->dir = dir;
     dbs->io_func = io_func;
     dbs->io_func_opaque = io_func_opaque;
-    dbs->bh = NULL;
     qemu_iovec_init(&dbs->iov, sg->nsg);
     dma_blk_cb(dbs, 0);
     return &dbs->common;
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 56130b5a1d..2b4123c127 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2908,49 +2908,6 @@ typedef struct {
     uint8_t buffer[];
 } BounceBuffer;
 
-static size_t bounce_buffers_in_use;
-
-typedef struct MapClient {
-    QEMUBH *bh;
-    QLIST_ENTRY(MapClient) link;
-} MapClient;
-
-QemuMutex map_client_list_lock;
-static QLIST_HEAD(, MapClient) map_client_list
-    = QLIST_HEAD_INITIALIZER(map_client_list);
-
-static void cpu_unregister_map_client_do(MapClient *client)
-{
-    QLIST_REMOVE(client, link);
-    g_free(client);
-}
-
-static void cpu_notify_map_clients_locked(void)
-{
-    MapClient *client;
-
-    while (!QLIST_EMPTY(&map_client_list)) {
-        client = QLIST_FIRST(&map_client_list);
-        qemu_bh_schedule(client->bh);
-        cpu_unregister_map_client_do(client);
-    }
-}
-
-void cpu_register_map_client(QEMUBH *bh)
-{
-    MapClient *client = g_malloc(sizeof(*client));
-
-    qemu_mutex_lock(&map_client_list_lock);
-    client->bh = bh;
-    QLIST_INSERT_HEAD(&map_client_list, client, link);
-    /* Write map_client_list before reading in_use.  */
-    smp_mb();
-    if (qatomic_read(&bounce_buffers_in_use)) {
-        cpu_notify_map_clients_locked();
-    }
-    qemu_mutex_unlock(&map_client_list_lock);
-}
-
 void cpu_exec_init_all(void)
 {
     qemu_mutex_init(&ram_list.mutex);
@@ -2964,28 +2921,6 @@ void cpu_exec_init_all(void)
     finalize_target_page_bits();
     io_mem_init();
     memory_map_init();
-    qemu_mutex_init(&map_client_list_lock);
-}
-
-void cpu_unregister_map_client(QEMUBH *bh)
-{
-    MapClient *client;
-
-    qemu_mutex_lock(&map_client_list_lock);
-    QLIST_FOREACH(client, &map_client_list, link) {
-        if (client->bh == bh) {
-            cpu_unregister_map_client_do(client);
-            break;
-        }
-    }
-    qemu_mutex_unlock(&map_client_list_lock);
-}
-
-static void cpu_notify_map_clients(void)
-{
-    qemu_mutex_lock(&map_client_list_lock);
-    cpu_notify_map_clients_locked();
-    qemu_mutex_unlock(&map_client_list_lock);
 }
 
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
@@ -3077,8 +3012,6 @@ void *address_space_map(AddressSpace *as,
     memory_region_ref(mr);
 
     if (!memory_access_is_direct(mr, is_write)) {
-        qatomic_inc_fetch(&bounce_buffers_in_use);
-
         BounceBuffer *bounce = g_malloc(l + sizeof(BounceBuffer));
         bounce->addr = addr;
         bounce->mr = mr;
@@ -3122,10 +3055,6 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
         }
         memory_region_unref(bounce->mr);
         g_free(bounce);
-
-        if (qatomic_dec_fetch(&bounce_buffers_in_use) == 1) {
-            cpu_notify_map_clients();
-        }
         return;
     }
 
-- 
2.34.1


