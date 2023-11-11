Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5F97E8B5D
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 16:30:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1pvU-0003l6-9F; Sat, 11 Nov 2023 10:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pvR-0003kS-W3
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pvQ-0008Hb-5w
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699716570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHkeGUPmavsIi7HKiUulQNhockj+WbBWmmVCMYWLGg8=;
 b=cMzYtirSDTY5LiqeeFJEUtcrOAmltrOVzFfg3iV6BjBZJGZ/SEvJ5f7KPBNc8yZ6UECX1L
 02mGPVdRfKbLGo3nIT0tTtibp6u6QxNsf+Bec5NA6HV3ipP3hbc3iV8UrEZXFvyU3Cpfbz
 tFSYtXaqGsCPR1Gyvhqk77gVjudLYQ8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-wVvBcGTJOzG80-VLYD6OEg-1; Sat, 11 Nov 2023 10:29:29 -0500
X-MC-Unique: wVvBcGTJOzG80-VLYD6OEg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9dd489c98e7so218414066b.2
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 07:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699716567; x=1700321367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHkeGUPmavsIi7HKiUulQNhockj+WbBWmmVCMYWLGg8=;
 b=Zo9rjKwftMjX9cahL5z+YpVtvzzA4Cp0+D0BxEw0KwCj3gMYKkbev+FjPZQ9udcmVz
 zdOxdh3AcPXSPcqlyyxbNSe3UTCHgKh9VJeOgwDco3pGOgr0gC1oa7iVAqYfMS4qfz9P
 JLqRG6PGAPcLOZ4eznX1wFPmeAjK+89ORwoDRavjnclLNpMV+w2TAiaSUtgdfLsZSwml
 jHRMpslXoSg+RRc6QJi6a3vela7H9iH77KseVWbXd6qKJ7tRjKXEuVwi+tfdgjhd3Ou2
 65Ixn3koEpriURoC3JnJUETA7ATBYrZmzAEYtCmEr0Rh38s29HrS/YQ1G6pHWQaU5y4T
 42yw==
X-Gm-Message-State: AOJu0YxOWiqQySmcysIMZsxcHjVJC2Q4DPvFoby8odGmczTiK2m09iZ9
 3ViXXfiWeCvfKCGqLQaYtSepo76osQbPz3gXCtMAazJaOVm6ksjGxPDx7sLmVlnjDWiS+NhQUxo
 iBgHOzwMu5VvttpN80SWKex7qqQPtjjbzXjhc5dxDmvMXf5S1vGezYwdIXj5FkpmcyHN9yQwRT0
 Y=
X-Received: by 2002:a17:906:710c:b0:9dd:7536:2b0 with SMTP id
 x12-20020a170906710c00b009dd753602b0mr1340279ejj.50.1699716567118; 
 Sat, 11 Nov 2023 07:29:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKhOKfOI43dIQuhy+6jOvYwwFJAaqpxlGBLym0nhferCC+fKhYGyt5f2ooFsmFWfShnnyR4g==
X-Received: by 2002:a17:906:710c:b0:9dd:7536:2b0 with SMTP id
 x12-20020a170906710c00b009dd753602b0mr1340267ejj.50.1699716566614; 
 Sat, 11 Nov 2023 07:29:26 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 ay18-20020a170906d29200b009ce03057c48sm1210463ejb.214.2023.11.11.07.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 07:29:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 1/6] coverity: physmem: use simple assertions instead of
 modelling
Date: Sat, 11 Nov 2023 16:29:18 +0100
Message-ID: <20231111152923.966998-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231111152923.966998-1-pbonzini@redhat.com>
References: <20231111152923.966998-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.41.0


