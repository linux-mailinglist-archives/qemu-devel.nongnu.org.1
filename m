Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E6B7730A2
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 22:48:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT790-0005Lc-DM; Mon, 07 Aug 2023 16:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qT78u-0005IZ-Vm
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qT78t-0006hz-7q
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691441274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsm/L74A5zo+k+IhFT6hYdMP2C4/39xIKWiR3NcA1Dc=;
 b=gGTM+31hTdc7G09GqSYS6qC88LqZoiok+P5dsNQH9KBLlSDCqQmHAQliw+RPUOjxMTtpEg
 RskWp5rBzIol7G6pKKmul9D2sWH7S1sJGxKSuIUeBZzM5OlPvw7cgZg0UBwASyqr4RWU6d
 nZ0GSlPv+NuTw25WNp3ymjtKWrqXGHo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-UUm_1RxVPxSWgSnd9DPIIg-1; Mon, 07 Aug 2023 16:47:48 -0400
X-MC-Unique: UUm_1RxVPxSWgSnd9DPIIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB7EA800159;
 Mon,  7 Aug 2023 20:47:47 +0000 (UTC)
Received: from localhost (unknown [10.39.208.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B79840C2076;
 Mon,  7 Aug 2023 20:47:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dongli Zhang <dongli.zhang@oracle.com>, Joe Jin <joe.jin@oracle.com>
Subject: [PULL 4/6] dump: kdump-zlib data pages not dumped with pvtime/aarch64
Date: Tue,  8 Aug 2023 00:47:15 +0400
Message-ID: <20230807204717.2483983-5-marcandre.lureau@redhat.com>
In-Reply-To: <20230807204717.2483983-1-marcandre.lureau@redhat.com>
References: <20230807204717.2483983-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Dongli Zhang <dongli.zhang@oracle.com>

The kdump-zlib data pages are not dumped from aarch64 host when the
'pvtime' is involved, that is, when the block->target_end is not aligned to
page_size. In the below example, it is expected to dump two blocks.

(qemu) info mtree -f
... ...
  00000000090a0000-00000000090a0fff (prio 0, ram): pvtime KVM
... ...
  0000000040000000-00000001bfffffff (prio 0, ram): mach-virt.ram KVM
... ...

However, there is an issue with get_next_page() so that the pages for
"mach-virt.ram" will not be dumped.

At line 1296, although we have reached at the end of the 'pvtime' block,
since it is not aligned to the page_size (e.g., 0x10000), it will not break
at line 1298.

1255 static bool get_next_page(GuestPhysBlock **blockptr, uint64_t *pfnptr,
1256                           uint8_t **bufptr, DumpState *s)
... ...
1294             memcpy(buf + addr % page_size, hbuf, n);
1295             addr += n;
1296             if (addr % page_size == 0) {
1297                 /* we filled up the page */
1298                 break;
1299             }

As a result, get_next_page() will continue to the next
block ("mach-virt.ram"). Finally, when get_next_page() returns to the
caller:

- 'pfnptr' is referring to the 'pvtime'
- but 'blockptr' is referring to the "mach-virt.ram"

When get_next_page() is called the next time, "*pfnptr += 1" still refers
to the prior 'pvtime'. It will exit immediately because it is out of the
range of the current "mach-virt.ram".

The fix is to break when it is time to come to the next block, so that both
'pfnptr' and 'blockptr' refer to the same block.

Fixes: 94d788408d2d ("dump: fix kdump to work over non-aligned blocks")
Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230713055819.30497-1-dongli.zhang@oracle.com>
---
 dump/dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 1f1a6edcab..d4ef713cd0 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1293,8 +1293,8 @@ static bool get_next_page(GuestPhysBlock **blockptr, uint64_t *pfnptr,
 
             memcpy(buf + addr % page_size, hbuf, n);
             addr += n;
-            if (addr % page_size == 0) {
-                /* we filled up the page */
+            if (addr % page_size == 0 || addr >= block->target_end) {
+                /* we filled up the page or the current block is finished */
                 break;
             }
         } else {
-- 
2.41.0


