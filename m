Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ED481C012
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:26:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQWl-0007TR-8Q; Thu, 21 Dec 2023 16:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWg-00077O-Ps
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWe-00083Y-PL
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWUG+/vsuwVMMI/WEzyBjviKScAVAqyDegAmnDDXdWk=;
 b=XrkWPFokYG29giLnmqSne0iM9F70K9+AkSmek7Kdadf0VGF6bG16c1HoIDFOR3yjBEAjYf
 b+NOIaRtzxHon+P2dLyPuAeJvLUN8ixX+UVvzEM19u/Le0CKEEsWHaJFj5eT9BC08zbjUI
 S1gVS1ARcx4dFZ4leHGb2xt2Bh+wOss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-HCHQs6AMPN6lfcfb6Bk0zg-1; Thu, 21 Dec 2023 16:24:10 -0500
X-MC-Unique: HCHQs6AMPN6lfcfb6Bk0zg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E586185A782;
 Thu, 21 Dec 2023 21:24:10 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4E3DC15968;
 Thu, 21 Dec 2023 21:24:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 09/33] vl: Improve error message for conflicting -incoming and
 -loadvm
Date: Thu, 21 Dec 2023 22:23:14 +0100
Message-ID: <20231221212339.164439-10-kwolf@redhat.com>
In-Reply-To: <20231221212339.164439-1-kwolf@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Currently, the conflict between -incoming and -loadvm is only detected
when loading the snapshot fails because the image is still inactive for
the incoming migration. This results in a suboptimal error message:

$ ./qemu-system-x86_64 -hda /tmp/test.qcow2 -loadvm foo -incoming defer
qemu-system-x86_64: Device 'ide0-hd0' is writable but does not support snapshots

Catch the situation already in qemu_validate_options() to improve the
message:

$ ./qemu-system-x86_64 -hda /tmp/test.qcow2 -loadvm foo -incoming defer
qemu-system-x86_64: 'incoming' and 'loadvm' options are mutually exclusive

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231201142520.32255-3-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 system/vl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index 2bcd9efb9a..6b87bfa32c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2426,6 +2426,10 @@ static void qemu_validate_options(const QDict *machine_opts)
           }
     }
 
+    if (loadvm && incoming) {
+        error_report("'incoming' and 'loadvm' options are mutually exclusive");
+        exit(EXIT_FAILURE);
+    }
     if (loadvm && preconfig_requested) {
         error_report("'preconfig' and 'loadvm' options are "
                      "mutually exclusive");
-- 
2.43.0


