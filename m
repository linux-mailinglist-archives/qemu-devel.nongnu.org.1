Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AFC7B9E50
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 16:04:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoOxj-0001Ui-BA; Thu, 05 Oct 2023 10:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoOx9-0001LI-DR
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:03:57 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoOx6-0003aR-Hz
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:03:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:b9a4:0:640:eb37:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 3628A5E9FD;
 Thu,  5 Oct 2023 17:03:36 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b584::1:2f])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id S3ZG5c4OcuQ0-u9kSpZIR; Thu, 05 Oct 2023 17:03:35 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696514615;
 bh=+ijQGzf9+1Vmu+joIt+FN5yLOHI/eKxM5/GLqNhvo3k=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=AzpQvaO+uYITsj33Jw5q4m0PtUyhufPZwonY9xS1CAzSI6I7K0UUoxKCwY9bc4X3p
 ySf4f3/lp2sv+PrAmLeVY+c4nQVKGUAw2rC94iapJMjA5ulEzIm9age+G1LT//68+w
 2bgjQGRfnUyWcsGiV0xsYi2mH2VPsIoW+FpzoBuo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, david@redhat.com, peterx@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru
Subject: [PATCH v2] coverity: physmem: use simple assertions instead of
 modelling
Date: Thu,  5 Oct 2023 17:03:26 +0300
Message-Id: <20231005140326.332830-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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
---

v2: add a-b by Devid

 scripts/coverity-scan/model.c | 88 -----------------------------------
 softmmu/physmem.c             | 18 +++++++
 2 files changed, 18 insertions(+), 88 deletions(-)

diff --git a/scripts/coverity-scan/model.c b/scripts/coverity-scan/model.c
index 686d1a3008..a064d84084 100644
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
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 309653c722..03e2f9bee6 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2714,6 +2714,15 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
             l = memory_access_size(mr, l, addr1);
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
+
+            /*
+             * Assure Coverity (and ourselves) that we are not going to OVERRUN
+             * the buffer by following ldn_he_p().
+             */
+            assert((l == 1 && len >= 1) ||
+                   (l == 2 && len >= 2) ||
+                   (l == 4 && len >= 4) ||
+                   (l == 8 && len >= 8));
             val = ldn_he_p(buf, l);
             result |= memory_region_dispatch_write(mr, addr1, val,
                                                    size_memop(l), attrs);
@@ -2784,6 +2793,15 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             l = memory_access_size(mr, l, addr1);
             result |= memory_region_dispatch_read(mr, addr1, &val,
                                                   size_memop(l), attrs);
+
+            /*
+             * Assure Coverity (and ourselves) that we are not going to OVERRUN
+             * the buffer by following stn_he_p().
+             */
+            assert((l == 1 && len >= 1) ||
+                   (l == 2 && len >= 2) ||
+                   (l == 4 && len >= 4) ||
+                   (l == 8 && len >= 8));
             stn_he_p(buf, l, val);
         } else {
             /* RAM case */
-- 
2.34.1


