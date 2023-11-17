Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEB37EEF54
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 10:54:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3vXo-0007w3-Qz; Fri, 17 Nov 2023 04:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3vXm-0007vG-Hu
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 04:53:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3vXk-0006gO-5H
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 04:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700214823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6cbCYNLHF0NIsDi2D2CBu22BfsrTQ+DBusODmGd61c=;
 b=afWD89KBIX91HYgkaq/zZmmWVZw7qfmyhcwsdFK5DvoRvWvEvDksBn9G2GyBtrhnU3zrPA
 Lra0ck2yqo8Wb5MYWZuEgcgeasiNHZqxAVYBiin2LVZ7xZd7lYSR1xb0LBUMRbCs1v3WqK
 octhoa9dT0w1qEXXEC9wI8KbMzfqL2E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98--0iq6q-0M06dQ4rH3w4MeA-1; Fri,
 17 Nov 2023 04:53:37 -0500
X-MC-Unique: -0iq6q-0M06dQ4rH3w4MeA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F192528237C5;
 Fri, 17 Nov 2023 09:53:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D00091121308;
 Fri, 17 Nov 2023 09:53:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9E0C21E6923; Fri, 17 Nov 2023 10:53:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 7/7] target/i386/cpu: Improve error message for property
 "vendor"
Date: Fri, 17 Nov 2023 10:53:34 +0100
Message-ID: <20231117095334.1819613-8-armbru@redhat.com>
In-Reply-To: <20231117095334.1819613-1-armbru@redhat.com>
References: <20231117095334.1819613-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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

Improve

    $ qemu-system-x86_64 -device max-x86_64-cpu,vendor=me
    qemu-system-x86_64: -device max-x86_64-cpu,vendor=me: Property '.vendor' doesn't take value 'me'

to

    qemu-system-x86_64: -device max-x86_64-cpu,vendor=0123456789abc: value of property 'vendor' must consist of exactly 12 characters

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20231031111059.3407803-8-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[Typo corrected]
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 358d9c0a65..cd16cb893d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5192,7 +5192,8 @@ static void x86_cpuid_set_vendor(Object *obj, const char *value,
     int i;
 
     if (strlen(value) != CPUID_VENDOR_SZ) {
-        error_setg(errp, QERR_PROPERTY_VALUE_BAD, "", "vendor", value);
+        error_setg(errp, "value of property 'vendor' must consist of"
+                   " exactly " stringify(CPUID_VENDOR_SZ) " characters");
         return;
     }
 
-- 
2.41.0


