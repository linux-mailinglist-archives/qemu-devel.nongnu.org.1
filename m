Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D628D350F
	for <lists+qemu-devel@lfdr.de>; Wed, 29 May 2024 12:58:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGy2-0004rU-Ux; Wed, 29 May 2024 06:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxx-0004lv-2c
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxu-0003K1-MX
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxVJw5TuWBIXWCwJ9zO3CyeusMuhUsYWd65t84oOLp8=;
 b=fdg82bH9R0aBX4kbkbJbXzFyznasXRz/OUu2VS2Occpm0qVohnOf9Efka6U2b9E9aUVoV7
 JOfrpr6YPO9qcnl7opxiixVoJECUs6d6jDyNff0qNYCKqLQdCpPycaN3hsBM5DYJK9flWx
 FT0eqXvvOyeIGYsdouB6YXxYqSLdUo0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-ZzYrgfybMxiS2qgOpbwKPw-1; Wed,
 29 May 2024 06:55:26 -0400
X-MC-Unique: ZzYrgfybMxiS2qgOpbwKPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F9451C0512D;
 Wed, 29 May 2024 10:55:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 318A2105480A;
 Wed, 29 May 2024 10:55:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org,
	Alexander Bulekov <alxndr@bu.edu>
Subject: [PULL 15/22] fuzz: specify audiodev for usb-audio
Date: Wed, 29 May 2024 12:54:47 +0200
Message-ID: <20240529105454.1149225-16-thuth@redhat.com>
In-Reply-To: <20240529105454.1149225-1-thuth@redhat.com>
References: <20240529105454.1149225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

From: Alexander Bulekov <alxndr@bu.edu>

Fixes test-failure on Fedora 40 CI.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240527040711.311865-1-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/fuzz/generic_fuzz_configs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
index 4d7c8ca4ec..ef0ad95712 100644
--- a/tests/qtest/fuzz/generic_fuzz_configs.h
+++ b/tests/qtest/fuzz/generic_fuzz_configs.h
@@ -150,7 +150,8 @@ const generic_fuzz_config predefined_configs[] = {
         "-chardev null,id=cd0 -chardev null,id=cd1 "
         "-device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid "
         "-device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 "
-        "-device usb-tablet -device usb-wacom-tablet -device usb-audio",
+        "-device usb-tablet -device usb-wacom-tablet "
+        "-device usb-audio,audiodev=snd0 -audiodev none,id=snd0",
         .objects = "*usb* *uhci* *xhci*",
     },{
         .name = "pc-i440fx",
-- 
2.45.1


