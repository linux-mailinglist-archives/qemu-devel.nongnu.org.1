Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8749E7AB4A2
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:19:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhwG-0000Gl-AJ; Fri, 22 Sep 2023 11:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjhvv-0000FL-55
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjhvt-0006ES-4D
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695395942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UDLmIcdBsBDoEE5odHUZMJmKJyLXcNoXLMSqQYlJk6M=;
 b=AyG/aH4oOc6Gplf/OHVX707ihZFqCiVo0Vpx41urmcyeHMts7w156JaeoEoClQCqOK49j1
 C7PJOdKTDR3jj49Ud1viSRxqZpMwin1rhdctFHDzJ6XDSMzV0IGwL8CKTEPirfAiflNWZ8
 sDlmdGP7no5fElB6eqLeimFR34v3Ur8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-692-oIcUFQumOyegDyv4pXy7QQ-1; Fri, 22 Sep 2023 11:19:01 -0400
X-MC-Unique: oIcUFQumOyegDyv4pXy7QQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7485185A79B
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 15:19:00 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2894C51E3;
 Fri, 22 Sep 2023 15:18:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] audio: don't abort on f32 audio format in wav backend
Date: Fri, 22 Sep 2023 16:18:58 +0100
Message-ID: <20230922151858.263447-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

Print a debug message as is done for other unsupported audio formats
to give the user the chance to understand their mistake.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 audio/wavaudio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 6445a2cb90..e70e5ee0c3 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -97,6 +97,10 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
         dolog ("WAVE files can not handle 32bit formats\n");
         return -1;
 
+    case AUDIO_FORMAT_F32:
+        dolog("WAVE files can not handle float formats\n");
+        return -1;
+
     default:
         abort();
     }
-- 
2.41.0


