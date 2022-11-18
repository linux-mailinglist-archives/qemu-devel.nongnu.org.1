Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1813474A9CF
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 06:12:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHcoE-0000ud-TU; Fri, 07 Jul 2023 00:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qHcoA-0000rv-BH
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 00:11:02 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qHco8-0006l7-He
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 00:11:02 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 153D311F0F0;
 Fri,  7 Jul 2023 04:10:59 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Fri, 18 Nov 2022 10:08:54 +0800
Subject: [PATCH QEMU v8 1/9] softmmu/dirtylimit: Add parameter check for hmp
 "set_vcpu_dirty_limit"
MIME-Version: 1.0
Message-ID: <168870305868.29142.5121604177475325995-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <168870305868.29142.5121604177475325995-0@git.sr.ht>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hyman =?utf-8?b?SHVhbmco6buE5YuHKQ==?= <yong.huang@smartx.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~hyman <yong.huang@smartx.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>

dirty_rate paraemter of hmp command "set_vcpu_dirty_limit" is invalid
if less than 0, so add parameter check for it.

Note that this patch also delete the unsolicited help message and
clean up the code.

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 softmmu/dirtylimit.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
index 015a9038d1..5c12d26d49 100644
--- a/softmmu/dirtylimit.c
+++ b/softmmu/dirtylimit.c
@@ -515,14 +515,15 @@ void hmp_set_vcpu_dirty_limit(Monitor *mon, const QDict=
 *qdict)
     int64_t cpu_index =3D qdict_get_try_int(qdict, "cpu_index", -1);
     Error *err =3D NULL;
=20
-    qmp_set_vcpu_dirty_limit(!!(cpu_index !=3D -1), cpu_index, dirty_rate, &=
err);
-    if (err) {
-        hmp_handle_error(mon, err);
-        return;
+    if (dirty_rate < 0) {
+        error_setg(&err, "invalid dirty page limit %ld", dirty_rate);
+        goto out;
     }
=20
-    monitor_printf(mon, "[Please use 'info vcpu_dirty_limit' to query "
-                   "dirty limit for virtual CPU]\n");
+    qmp_set_vcpu_dirty_limit(!!(cpu_index !=3D -1), cpu_index, dirty_rate, &=
err);
+
+out:
+    hmp_handle_error(mon, err);
 }
=20
 static struct DirtyLimitInfo *dirtylimit_query_vcpu(int cpu_index)
--=20
2.38.5


