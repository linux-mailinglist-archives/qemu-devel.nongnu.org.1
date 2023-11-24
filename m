Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C6F7F77B6
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 16:25:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Y2X-0004dY-Qj; Fri, 24 Nov 2023 10:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2V-0004cj-2z
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2T-00048N-FF
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700839456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAf9bM3eocErEa/U7AKj4Rew1Pss0mi+PtX9HD85dNU=;
 b=O8W4ClSRlbqbsV+kJt2rNN2ybNJD8NrG/tk+BqAfqigyUjUMk92JCc82sVRarqLOqI5mV+
 1Ab+dU9qmP00ydXz5aQ/uGJotP7W9TMMEu9kyEHAoVkTACGk7owaJGxcu51PfNAiRI7Qr7
 K9i6ASGfpXEWugX83mtbYXZRBd/D1eI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-Anr1tm9YPGC5RqdmRrDgKg-1; Fri, 24 Nov 2023 10:24:15 -0500
X-MC-Unique: Anr1tm9YPGC5RqdmRrDgKg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77d6854a3f9so217903685a.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 07:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700839454; x=1701444254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KAf9bM3eocErEa/U7AKj4Rew1Pss0mi+PtX9HD85dNU=;
 b=vsYrZ0vbXxgGZrM5GteVa460VUttY9DXVAmkKzIXWbvoA2Ei3O5u8kKQzzMAG4m9x6
 qCaWwRlc80lVBQw7RQ910MdmXxQx/8kh+toS0GyabYzG2U2KaBkM3THjt1LeaBZsJSso
 RzWccBbpAkCoK1HI3z2u0UXuIbus0GE54XiAVLgVr+FyoCikb/oclZ/ByWPP3scjQcxk
 UKBxV66yzgWeLiIQlEOVHdvAwdBkzWuWjFmUW3GApYO6eZU4YbyDkbKMeS0UKvheKx2z
 ujiL/3HVXzEuVE85Q5bW9HfPEn9nPooF8C+aMIUkDAGx7Pw3Z/jMqHWZ54AOhz/090u+
 Ib3w==
X-Gm-Message-State: AOJu0YzHFbkgLuVY1FrunIVc6H6aiVctmL9GrX60hiSNSgXKd9oE7Ieh
 qjDAXqlS0IjpBTEULFsDHjv/GxEB8PMFgncBcFwBKfPbP/xSslH9eiMUrU9d9t93ybbu9zF6fy4
 bkKaqqITWsAIMKFdaEA+KE3xwzmtJRToW0Kxao17l6WS68JjBj9cFTy6Iy6dg1ywWE5J9jOKdjq
 k=
X-Received: by 2002:a05:620a:3a4c:b0:76f:24bd:fef2 with SMTP id
 sk12-20020a05620a3a4c00b0076f24bdfef2mr2564410qkn.68.1700839453883; 
 Fri, 24 Nov 2023 07:24:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmdcP3ovBrn54VDDwvWCphg+z7eUFUXE2UWGxfmftZ2yIv6rUFAm1GUCPuITuz/0OHFxphXw==
X-Received: by 2002:a05:620a:3a4c:b0:76f:24bd:fef2 with SMTP id
 sk12-20020a05620a3a4c00b0076f24bdfef2mr2564379qkn.68.1700839453460; 
 Fri, 24 Nov 2023 07:24:13 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 ee17-20020a05620a801100b0077d84ad9744sm233508qkb.36.2023.11.24.07.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 07:24:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 01/10] coverity: physmem: use simple assertions instead of
 modelling
Date: Fri, 24 Nov 2023 16:23:59 +0100
Message-ID: <20231124152408.140936-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124152408.140936-1-pbonzini@redhat.com>
References: <20231124152408.140936-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Unfortunately Coverity doesn't follow the logic aroung "len" and "l"
variables in stacks finishing with flatview_{read,write}_continue() and
generate a lot of OVERRUN false-positives. When small buffer (2 or 4
bytes) is passed to mem read/write path, Coverity assumes the worst
case of sz=8 in stn_he_p()/ldn_he_p() (defined in
include/qemu/bswap.h), and reports buffer overrun.

To silence these false-positives we have model functions, which hide
real logic from Coverity.

However, it turned out that these new two assertions are enough to
quiet Coverity.

Assertions are better than hiding the logic, so let's drop the
modelling and move to assertions for memory r/w call stacks.

After patch, the sequence

 cov-make-library --output-file /tmp/master.xmldb \
    scripts/coverity-scan/model.c
 cov-build --dir ~/covtmp/master make -j9
 cov-analyze --user-model-file /tmp/master.xmldb \
    --dir ~/covtmp/master --all --strip-path "$(pwd)
 cov-format-errors --dir ~/covtmp/master \
    --html-output ~/covtmp/master_html_report

Generate for me the same big set of CIDs excepept for 6 disappeared (so
it becomes even better).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: David Hildenbrand <david@redhat.com>
Message-ID: <20231005140326.332830-1-vsementsov@yandex-team.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/model.c | 88 -----------------------------------
 system/physmem.c              | 22 +++++++++
 2 files changed, 22 insertions(+), 88 deletions(-)

diff --git a/scripts/coverity-scan/model.c b/scripts/coverity-scan/model.c
index 686d1a30089..a064d840849 100644
--- a/scripts/coverity-scan/model.c
+++ b/scripts/coverity-scan/model.c
@@ -42,94 +42,6 @@ typedef _Bool bool;
 
 typedef struct va_list_str *va_list;
 
-/* exec.c */
-
-typedef struct AddressSpace AddressSpace;
-typedef struct MemoryRegionCache MemoryRegionCache;
-typedef uint64_t hwaddr;
-typedef uint32_t MemTxResult;
-typedef struct MemTxAttrs {} MemTxAttrs;
-
-static void __bufwrite(uint8_t *buf, ssize_t len)
-{
-    int first, last;
-    __coverity_negative_sink__(len);
-    if (len == 0) return;
-    buf[0] = first;
-    buf[len-1] = last;
-    __coverity_writeall__(buf);
-}
-
-static void __bufread(uint8_t *buf, ssize_t len)
-{
-    __coverity_negative_sink__(len);
-    if (len == 0) return;
-    int first = buf[0];
-    int last = buf[len-1];
-}
-
-MemTxResult address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
-                                      MemTxAttrs attrs,
-                                      void *buf, int len)
-{
-    MemTxResult result;
-    // TODO: investigate impact of treating reads as producing
-    // tainted data, with __coverity_tainted_data_argument__(buf).
-    __bufwrite(buf, len);
-    return result;
-}
-
-MemTxResult address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
-                                MemTxAttrs attrs,
-                                const void *buf, int len)
-{
-    MemTxResult result;
-    __bufread(buf, len);
-    return result;
-}
-
-MemTxResult address_space_rw_cached(MemoryRegionCache *cache, hwaddr addr,
-                                    MemTxAttrs attrs,
-                                    void *buf, int len, bool is_write)
-{
-    if (is_write) {
-        return address_space_write_cached(cache, addr, attrs, buf, len);
-    } else {
-        return address_space_read_cached(cache, addr, attrs, buf, len);
-    }
-}
-
-MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
-                               MemTxAttrs attrs,
-                               void *buf, int len)
-{
-    MemTxResult result;
-    // TODO: investigate impact of treating reads as producing
-    // tainted data, with __coverity_tainted_data_argument__(buf).
-    __bufwrite(buf, len);
-    return result;
-}
-
-MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
-                                MemTxAttrs attrs,
-                                const void *buf, int len)
-{
-    MemTxResult result;
-    __bufread(buf, len);
-    return result;
-}
-
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
-                             MemTxAttrs attrs,
-                             void *buf, int len, bool is_write)
-{
-    if (is_write) {
-        return address_space_write(as, addr, attrs, buf, len);
-    } else {
-        return address_space_read(as, addr, attrs, buf, len);
-    }
-}
-
 /* Tainting */
 
 typedef struct {} name2keysym_t;
diff --git a/system/physmem.c b/system/physmem.c
index fc2b0fee018..a63853a7bc9 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2699,6 +2699,17 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
             l = memory_access_size(mr, l, addr1);
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
+
+            /*
+             * Assure Coverity (and ourselves) that we are not going to OVERRUN
+             * the buffer by following ldn_he_p().
+             */
+#ifdef QEMU_STATIC_ANALYSIS
+            assert((l == 1 && len >= 1) ||
+                   (l == 2 && len >= 2) ||
+                   (l == 4 && len >= 4) ||
+                   (l == 8 && len >= 8));
+#endif
             val = ldn_he_p(buf, l);
             result |= memory_region_dispatch_write(mr, addr1, val,
                                                    size_memop(l), attrs);
@@ -2769,6 +2780,17 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             l = memory_access_size(mr, l, addr1);
             result |= memory_region_dispatch_read(mr, addr1, &val,
                                                   size_memop(l), attrs);
+
+            /*
+             * Assure Coverity (and ourselves) that we are not going to OVERRUN
+             * the buffer by following stn_he_p().
+             */
+#ifdef QEMU_STATIC_ANALYSIS
+            assert((l == 1 && len >= 1) ||
+                   (l == 2 && len >= 2) ||
+                   (l == 4 && len >= 4) ||
+                   (l == 8 && len >= 8));
+#endif
             stn_he_p(buf, l, val);
         } else {
             /* RAM case */
-- 
2.43.0


