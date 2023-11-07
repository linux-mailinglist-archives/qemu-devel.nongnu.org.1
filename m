Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A427E48F7
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 20:09:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RRE-0004Xj-7w; Tue, 07 Nov 2023 14:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r0RR6-0004WB-82
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:08:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r0RR3-0005op-9d
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699384104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSK7TY/1g7Gf5t/DbU+U3KaUgEFAOOa8D7RZh8hYb64=;
 b=V8D5Pw8U7pFOPDAdzw3Ya11xFRm8HEpT3oHcpLn6SZtP7AkI19HPND9+hotsCeQsFDvbbp
 IN5rbokYvECrSiPQSuxaFePZ51aYNu6PP+vxL5Bp0+7kDLaNcWGHDLaaMFSC78Q0R+7Ftr
 O0Jqvgcjg3fk3q6EsbCdmTIUacA2p44=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-D4eJ8KngN7SwItvE6i6AMw-1; Tue,
 07 Nov 2023 14:08:23 -0500
X-MC-Unique: D4eJ8KngN7SwItvE6i6AMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A23F0383DC6C
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 19:08:22 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B88EE25C0;
 Tue,  7 Nov 2023 19:08:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 3/5] audio: don't abort on f32 audio format in wav backend
Date: Tue,  7 Nov 2023 19:08:15 +0000
Message-ID: <20231107190817.1607710-4-berrange@redhat.com>
In-Reply-To: <20231107190817.1607710-1-berrange@redhat.com>
References: <20231107190817.1607710-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Print a debug message as is done for other unsupported audio formats
to give the user the chance to understand their mistake.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 audio/wavaudio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index ea20fed0cc..a8798a1c42 100644
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


