Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3CA7BB6AC
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:41:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9J-00058E-HZ; Fri, 06 Oct 2023 07:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8w-00051n-Cl
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8t-00009r-5X
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gx49RQwNuraS/UYpmM3v82biY3hwQbEu08fblmGBqMg=;
 b=CS6LkZ2gg8TRvSqb7pSQ+PYJApVrIVqBwm9fCkwovTMmPDAKRZVXaIfibrE78R0dEj+STG
 VqcRTFgHRj4QXYIqNPlAQdiTLUKzgLh4wlAXg/RWuCbL+f46G/8iwad6gpcS2yZnH/FCf2
 3HxxmhSn9TE9KK926jLiC4+tOIydxhc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-yhrStZ2PPJGgCoDGwrICSw-1; Fri, 06 Oct 2023 07:36:58 -0400
X-MC-Unique: yhrStZ2PPJGgCoDGwrICSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84C001C06375;
 Fri,  6 Oct 2023 11:36:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 634041054FC1;
 Fri,  6 Oct 2023 11:36:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5D65221E690B; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 03/32] target/ppc: Rename variables to avoid local variable
 shadowing in VUPKPX
Date: Fri,  6 Oct 2023 13:36:28 +0200
Message-ID: <20231006113657.3803180-4-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@kaod.org>

and fix such warnings :

  ../target/ppc/int_helper.c: In function ‘helper_vupklpx’:
  ../target/ppc/int_helper.c:2025:21: warning: declaration of ‘r’ shadows a parameter [-Wshadow=local]
   2025 |             uint8_t r = (e >> 10) & 0x1f;                               \
        |                     ^
  ../target/ppc/int_helper.c:2033:1: note: in expansion of macro ‘VUPKPX’
   2033 | VUPKPX(lpx, UPKLO)
        | ^~~~~~
  ../target/ppc/int_helper.c:2017:41: note: shadowed declaration is here
   2017 |     void helper_vupk##suffix(ppc_avr_t *r, ppc_avr_t *b)                \
        |                              ~~~~~~~~~~~^
  ../target/ppc/int_helper.c:2033:1: note: in expansion of macro ‘VUPKPX’
   2033 | VUPKPX(lpx, UPKLO)
        | ^~~~~~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230929083143.234553-1-clg@kaod.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/ppc/int_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 6fd00684a5..0a5c3e78a4 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2020,13 +2020,13 @@ void helper_vsum4ubs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
         ppc_avr_t result;                                               \
                                                                         \
         for (i = 0; i < ARRAY_SIZE(r->u32); i++) {                      \
-            uint16_t e = b->u16[hi ? i : i + 4];                        \
-            uint8_t a = (e >> 15) ? 0xff : 0;                           \
-            uint8_t r = (e >> 10) & 0x1f;                               \
-            uint8_t g = (e >> 5) & 0x1f;                                \
-            uint8_t b = e & 0x1f;                                       \
+            uint16_t _e = b->u16[hi ? i : i + 4];                       \
+            uint8_t _a = (_e >> 15) ? 0xff : 0;                         \
+            uint8_t _r = (_e >> 10) & 0x1f;                             \
+            uint8_t _g = (_e >> 5) & 0x1f;                              \
+            uint8_t _b = _e & 0x1f;                                     \
                                                                         \
-            result.u32[i] = (a << 24) | (r << 16) | (g << 8) | b;       \
+            result.u32[i] = (_a << 24) | (_r << 16) | (_g << 8) | _b;   \
         }                                                               \
         *r = result;                                                    \
     }
-- 
2.41.0


