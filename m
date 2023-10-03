Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFFC7B6927
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:37:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnedM-0006ce-IA; Tue, 03 Oct 2023 08:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedA-0006Xv-Ua
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qned9-0000EG-C6
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kHKeeeH94oH3Fv5hQDj3tNMYo+vezijw4ZCisFMeCCY=;
 b=OD43Nw4q0dZMrFH75KhR6k83wWjE8Krs2F1JPU0PHwZhklO2oM7m1kg1daQxI/g8hOEMXB
 hB6Rse4AFMvYSKm5+Vz/FLW1XDa/LG/uB/mEKs36kuSiN+99R+QYmGzKNkdXdSo8ukmEgR
 c5lP8hsKzsJnYUuhtBIcsuBtnsvqkn8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-BNMwDJExMz2J86zhE2lAqQ-1; Tue, 03 Oct 2023 08:36:00 -0400
X-MC-Unique: BNMwDJExMz2J86zhE2lAqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 343A929A8AE4
 for <qemu-devel@nongnu.org>; Tue,  3 Oct 2023 12:36:00 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E78640C6EBF;
 Tue,  3 Oct 2023 12:35:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 03/13] ui/console: only walk QemuGraphicConsoles in
 qemu_console_is_multihead()
Date: Tue,  3 Oct 2023 16:35:32 +0400
Message-ID: <20231003123543.1360795-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
References: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
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

From: Laszlo Ersek <lersek@redhat.com>

qemu_console_is_multihead() declares the console "c" a "multihead" console
if there are two different consoles in the system that (a) both reference
"c->device", and (b) have different "c->head" numbers. In effect, if at
least two consoles exist that are different heads of the same device that
underlies "c".

Commit 58d5870845c6 ("ui/console: move graphic fields to
QemuGraphicConsole", 2023-09-04) pushed the "device" and "head" members
from the QemuConsole base class down to the QemuGraphicConsole subclass,
adjusting the referring QOM properties accordingly as well. As a result,
the "device" property lookup in qemu_console_is_multihead() now crashes,
in case the candidate console being investigated for criterion (a) is not
a QemuGraphicConsole instance:

> Unexpected error in object_property_find_err() at qom/object.c:1314:
> qemu: Property 'qemu-fixed-text-console.device' not found
> Aborted (core dumped)

This is effectively an unchecked downcast. Make it checked: only consider
such console candidates that are themselves QemuGraphicConsole instances.

Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com> (odd fixer:Graphics)
Cc: Gerd Hoffmann <kraxel@redhat.com> (odd fixer:Graphics)
Fixes: 58d5870845c6
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230913144959.41891-3-lersek@redhat.com>
---
 ui/console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index d17b4ee397..4fe26c08fb 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1442,6 +1442,9 @@ static bool qemu_console_is_multihead(DeviceState *dev)
     uint32_t h;
 
     QTAILQ_FOREACH(con, &consoles, next) {
+        if (!QEMU_IS_GRAPHIC_CONSOLE(con)) {
+            continue;
+        }
         obj = object_property_get_link(OBJECT(con),
                                        "device", &error_abort);
         if (DEVICE(obj) != dev) {
-- 
2.41.0


