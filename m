Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72174B3E16E
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Sep 2025 13:25:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2ea-0000Om-Ae; Mon, 01 Sep 2025 07:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ut2eR-0000JJ-3G
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ut2eP-0006Cz-40
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756725879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JKbrB0s6B1hxtiguHSN3mL4QozFKLp4LyEThmokh9/o=;
 b=H3kzfdmp8avHViZYn4HYkkgCD5aAei0Oi1bufD8INLtvSVJGweHDdwwUSUxk5323zoB+jH
 FkyXw55woy3+BMolDBDUeVlBnT0WpN5FRsfMHrd3YGgNLE4PjKrkMtzUP2QZQ6xTjATHO8
 4g7LCoD01KcUIQOnbJtbrq9fwNCN8B4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-14bvx3jKObWLuH2DO3mx2A-1; Mon,
 01 Sep 2025 07:24:35 -0400
X-MC-Unique: 14bvx3jKObWLuH2DO3mx2A-1
X-Mimecast-MFC-AGG-ID: 14bvx3jKObWLuH2DO3mx2A_1756725874
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 656141800289; Mon,  1 Sep 2025 11:24:34 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.80])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8750B1800294; Mon,  1 Sep 2025 11:24:32 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 7/9] qga-vss: Write hex value of error in log
Date: Mon,  1 Sep 2025 14:24:11 +0300
Message-ID: <20250901112413.114314-8-kkostiuk@redhat.com>
In-Reply-To: <20250901112413.114314-1-kkostiuk@redhat.com>
References: <20250901112413.114314-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

QGA-VSS writes error using error_setg_win32_internal,
which call g_win32_error_message.

g_win32_error_message - translate a Win32 error code
(as returned by GetLastError()) into the corresponding message.

In the same time, we call error_setg_win32_internal with
error codes from different Windows componets like VSS or
Performance monitor that provides different codes and
can't be converted with g_win32_error_message. In this
case, the empty suffix will be returned so error will be
masked.

This commit directly add hex value of error code.

Reproduce:
 - Run QGA command: {"execute": "guest-fsfreeze-freeze-list", "arguments": {"mountpoints": ["D:"]}}

QGA error example:
 - before changes:
  {"error": {"class": "GenericError", "desc": "failed to add D: to snapshot set: "}}
 - after changes:
  {"error": {"class": "GenericError", "desc": "failed to add D: to snapshot set: Windows error 0x8004230e: "}}

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250825135311.138330-1-kkostiuk@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/requester.cpp | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index bc260abb96..5615955b6f 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -28,8 +28,9 @@
 
 #define err_set(e, err, fmt, ...) {                                         \
     (e)->error_setg_win32_wrapper((e)->errp, __FILE__, __LINE__, __func__,  \
-                                   err, fmt, ## __VA_ARGS__);               \
-    qga_debug(fmt, ## __VA_ARGS__);                                         \
+                                   err, fmt ": Windows error 0x%lx",        \
+                                   ## __VA_ARGS__, err);                    \
+    qga_debug(fmt ": Windows error 0x%lx", ## __VA_ARGS__, err);            \
 }
 /* Bad idea, works only when (e)->errp != NULL: */
 #define err_is_set(e) ((e)->errp && *(e)->errp)
-- 
2.50.1


