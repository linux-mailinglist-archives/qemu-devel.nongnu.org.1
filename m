Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AAE90349C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jun 2024 10:01:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwQw-0008Ao-9a; Tue, 11 Jun 2024 04:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sGwQu-00089z-GC
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:00:44 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sGwQr-0006l9-P3
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718092842; x=1749628842;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XL3qUJ/s4JKxW1z/Q1moGl6f6RxBIByPE7Pu6LcLU94=;
 b=Q92XVMt63PSf5Dbu026+jDj8FgKH3mY6/XBM7e8zt9E+FlhDXppnmiRt
 tsY4E4pKO2ZfsL/lGikGJD8NVHjL3Nh+Fxfy9vqVYk8MDpO5zkJTvpEJk
 YtTal00CpN+JV+hWv/83IfUsIW9BUIlLpK8DiQSBDLH5Zropsq/YyTxSr
 91uz1TpWsaGLX/DREVzifuSlH8lCPNSoztZypa1uLzVk0Ye6OrIonNQaE
 ZT5pCUVIKHAedcErMLX4dsZAJeqGt9j5V2wX9w5AQuAd+7CCq3v7rSqYp
 WgMXPLGg3jhsC/9Z2V5Dx9z6rzHchL8YUhPV2EVDB3tye902DvQ1BJZsx w==;
X-CSE-ConnectionGUID: KXLGkQJZSniSDVO1UfX2HQ==
X-CSE-MsgGUID: gzNh1/GdRO2iJyUzGSvkGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14510014"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="14510014"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2024 01:00:40 -0700
X-CSE-ConnectionGUID: 1hO77vkqRuaHSkN5OMn+Lg==
X-CSE-MsgGUID: +iiORHKoSDSUpnBjyVmkKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="39184817"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmviesa007.fm.intel.com with ESMTP; 11 Jun 2024 01:00:37 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v8 2/7] migration/multifd: put IOV initialization into
 compression method
Date: Mon, 10 Jun 2024 18:21:05 +0800
Message-ID: <20240610102110.900410-3-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610102110.900410-1-yuan1.liu@intel.com>
References: <20240610102110.900410-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.143, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Different compression methods may require different numbers of IOVs.
Based on streaming compression of zlib and zstd, all pages will be
compressed to a data block, so two IOVs are needed for packet header
and compressed data block.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-zlib.c |  7 +++++++
 migration/multifd-zstd.c |  8 +++++++-
 migration/multifd.c      | 22 ++++++++++++----------
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 737a9645d2..2ced69487e 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -70,6 +70,10 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
         goto err_free_zbuff;
     }
     p->compress_data = z;
+
+    /* Needs 2 IOVs, one for packet header and one for compressed data */
+    p->iov = g_new0(struct iovec, 2);
+
     return 0;
 
 err_free_zbuff:
@@ -101,6 +105,9 @@ static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
     z->buf = NULL;
     g_free(p->compress_data);
     p->compress_data = NULL;
+
+    g_free(p->iov);
+    p->iov = NULL;
 }
 
 /**
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 256858df0a..ca17b7e310 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -52,7 +52,6 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int res;
 
-    p->compress_data = z;
     z->zcs = ZSTD_createCStream();
     if (!z->zcs) {
         g_free(z);
@@ -77,6 +76,10 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
         error_setg(errp, "multifd %u: out of memory for zbuff", p->id);
         return -1;
     }
+    p->compress_data = z;
+
+    /* Needs 2 IOVs, one for packet header and one for compressed data */
+    p->iov = g_new0(struct iovec, 2);
     return 0;
 }
 
@@ -98,6 +101,9 @@ static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
     z->zbuff = NULL;
     g_free(p->compress_data);
     p->compress_data = NULL;
+
+    g_free(p->iov);
+    p->iov = NULL;
 }
 
 /**
diff --git a/migration/multifd.c b/migration/multifd.c
index f317bff077..d82885fdbb 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -137,6 +137,13 @@ static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
         p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
     }
 
+    if (multifd_use_packets()) {
+        /* We need one extra place for the packet header */
+        p->iov = g_new0(struct iovec, p->page_count + 1);
+    } else {
+        p->iov = g_new0(struct iovec, p->page_count);
+    }
+
     return 0;
 }
 
@@ -150,6 +157,8 @@ static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
  */
 static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
+    g_free(p->iov);
+    p->iov = NULL;
     return;
 }
 
@@ -228,6 +237,7 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
  */
 static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    p->iov = g_new0(struct iovec, p->page_count);
     return 0;
 }
 
@@ -240,6 +250,8 @@ static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
  */
 static void nocomp_recv_cleanup(MultiFDRecvParams *p)
 {
+    g_free(p->iov);
+    p->iov = NULL;
 }
 
 /**
@@ -783,8 +795,6 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
-    g_free(p->iov);
-    p->iov = NULL;
     multifd_send_state->ops->send_cleanup(p, errp);
 
     return *errp == NULL;
@@ -1179,11 +1189,6 @@ bool multifd_send_setup(void)
             p->packet = g_malloc0(p->packet_len);
             p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
             p->packet->version = cpu_to_be32(MULTIFD_VERSION);
-
-            /* We need one extra place for the packet header */
-            p->iov = g_new0(struct iovec, page_count + 1);
-        } else {
-            p->iov = g_new0(struct iovec, page_count);
         }
         p->name = g_strdup_printf("multifdsend_%d", i);
         p->page_size = qemu_target_page_size();
@@ -1353,8 +1358,6 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
-    g_free(p->iov);
-    p->iov = NULL;
     g_free(p->normal);
     p->normal = NULL;
     g_free(p->zero);
@@ -1602,7 +1605,6 @@ int multifd_recv_setup(Error **errp)
             p->packet = g_malloc0(p->packet_len);
         }
         p->name = g_strdup_printf("multifdrecv_%d", i);
-        p->iov = g_new0(struct iovec, page_count);
         p->normal = g_new0(ram_addr_t, page_count);
         p->zero = g_new0(ram_addr_t, page_count);
         p->page_count = page_count;
-- 
2.43.0


