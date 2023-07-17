Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8B0756313
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:48:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNd7-0007Pd-0y; Mon, 17 Jul 2023 08:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNct-0007HU-2t
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNcr-0008MN-Ll
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689598013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dt1ZK5Q+hUpKLxd8NdpCQ4LNP1XKHpwMbwszUVNWgEc=;
 b=R7fm8Uq9FGbaX1biLG23JX0Oc7mL2gzepths4ikAVamaMMhKwIscA1QVlRDlznC0KnZRGw
 YUuwu2Av7rwFK2E7zvPpvyIJ1a9akOc0oQ7A/IIUEvUZCs/UwCxmMRKfSu2PN5heu/X7Fs
 MLhEQpCLgMD/0Kg3iQVMXPkkGrxcoZ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-Rtoldcb_PZOJ3oPm_vHSLg-1; Mon, 17 Jul 2023 08:46:49 -0400
X-MC-Unique: Rtoldcb_PZOJ3oPm_vHSLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A76D1044597;
 Mon, 17 Jul 2023 12:46:49 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCB4A40C6F4F;
 Mon, 17 Jul 2023 12:46:48 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 14/19] audio/pw: add more details on error
Date: Mon, 17 Jul 2023 16:45:39 +0400
Message-ID: <20230717124545.177236-15-marcandre.lureau@redhat.com>
In-Reply-To: <20230717124545.177236-1-marcandre.lureau@redhat.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

PipeWire uses errno to report error details.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20230506163735.3481387-8-marcandre.lureau@redhat.com>
---
 audio/pwaudio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 2b12b40934..d0bc4680a6 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -750,6 +750,7 @@ static int wait_resync(pwaudio *pw)
     }
     return 0;
 }
+
 static void
 on_core_error(void *data, uint32_t id, int seq, int res, const char *message)
 {
@@ -793,19 +794,19 @@ qpw_audio_init(Audiodev *dev)
     pw->dev = dev;
     pw->thread_loop = pw_thread_loop_new("PipeWire thread loop", NULL);
     if (pw->thread_loop == NULL) {
-        error_report("Could not create PipeWire loop");
+        error_report("Could not create PipeWire loop: %s", g_strerror(errno));
         goto fail;
     }
 
     pw->context =
         pw_context_new(pw_thread_loop_get_loop(pw->thread_loop), NULL, 0);
     if (pw->context == NULL) {
-        error_report("Could not create PipeWire context");
+        error_report("Could not create PipeWire context: %s", g_strerror(errno));
         goto fail;
     }
 
     if (pw_thread_loop_start(pw->thread_loop) < 0) {
-        error_report("Could not start PipeWire loop");
+        error_report("Could not start PipeWire loop: %s", g_strerror(errno));
         goto fail;
     }
 
-- 
2.41.0


