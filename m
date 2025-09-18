Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4363BB1E42E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Aug 2025 10:09:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukI9W-00076W-CE; Fri, 08 Aug 2025 04:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9S-00072b-PC
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9Q-0006TO-Ri
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754640511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1r0cQ0Q83RNcWR+DFapG2wZddI27l+q5A5mrQBO+m4A=;
 b=QrsEzqaPJ3mZwnGCx6JGNUtnC1d/D1OrAgdGT5XH9tuOI6sG1gu8jQiQuTPjV064YxpJXy
 NHaGznwlCk1cCxiH/FmD/sV6HwShFsr8uaezuDkIjnVc9NdKCsjaYvq4yq85C6Rzm6k3ZO
 EOdV7rkISHdFF+2zn6rwnwlnofB+M00=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-SshKzHkhOcqdug5awLg9ng-1; Fri,
 08 Aug 2025 04:08:28 -0400
X-MC-Unique: SshKzHkhOcqdug5awLg9ng-1
X-Mimecast-MFC-AGG-ID: SshKzHkhOcqdug5awLg9ng_1754640507
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02F611800451; Fri,  8 Aug 2025 08:08:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0368B19560AD; Fri,  8 Aug 2025 08:08:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4BA1A21E6925; Fri, 08 Aug 2025 10:08:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 02/12] tcg: Fix error reporting on mprotect() failure in
 tcg_region_init()
Date: Fri,  8 Aug 2025 10:08:13 +0200
Message-ID: <20250808080823.2638861-3-armbru@redhat.com>
In-Reply-To: <20250808080823.2638861-1-armbru@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

tcg_region_init() calls one of qemu_mprotect_rwx(),
qemu_mprotect_rw(), and mprotect(), then reports failure with
error_setg_errno(&error_fatal, errno, ...).

The use of &error_fatal is undesirable.  qapi/error.h advises:

 * Please don't error_setg(&error_fatal, ...), use error_report() and
 * exit(), because that's more obvious.

The use of errno is wrong.  qemu_mprotect_rwx() and qemu_mprotect_rw()
wrap around qemu_mprotect__osdep().  qemu_mprotect__osdep() calls
mprotect() on POSIX, VirtualProtect() on Windows, and reports failure
with error_report().  VirtualProtect() doesn't set errno.  mprotect()
does, but error_report() may clobber it.

Fix tcg_region_init() to report errors only when it calls mprotect(),
and rely on qemu_mprotect_rwx()'s and qemu_mprotect_rw()'s error
reporting otherwise.  Use error_report(), not error_setg().

Fixes: 22c6a9938f75 (tcg: Merge buffer protection and guard page protection)
Fixes: 6bc144237a85 (tcg: Use Error with alloc_code_gen_buffer)
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tcg/region.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 7ea0b37a84..74e3b4b774 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -832,13 +832,17 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads)
             } else {
 #ifdef CONFIG_POSIX
                 rc = mprotect(start, end - start, need_prot);
+                if (rc) {
+                    error_report("mprotect of jit buffer: %s",
+                                 strerror(errno));
+                }
+
 #else
                 g_assert_not_reached();
 #endif
             }
             if (rc) {
-                error_setg_errno(&error_fatal, errno,
-                                 "mprotect of jit buffer");
+                exit(1);
             }
         }
         if (have_prot != 0) {
-- 
2.49.0


