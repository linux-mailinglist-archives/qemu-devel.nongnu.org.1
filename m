Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A28BD82463F
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:31:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQbW-0007OT-3f; Thu, 04 Jan 2024 11:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLQbU-0007Ny-PC
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:29:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLQbT-0002ID-9z
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704385794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rVj6nCDx65EnoyU5kHdnOBdbNMcvZ69M6R4yaiUA6k=;
 b=NKotqHZ1cUH6W1GNhXhNPgIl3P0jU3ksBntvBAPVtnozTwrtNB+gwgwJ2yjTlJhDT6xPzq
 6VQBr1fNL56TLBxojWpqHh6n53HSLMhA2KLaOGcExRhGFZD/JjBNARYX+sUuAw88ssviXI
 04FJep6eIXtKqBj7SWLQWq2tDJYNUW0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-G04xxI1BNCSBOi8gllR68g-1; Thu,
 04 Jan 2024 11:29:51 -0500
X-MC-Unique: G04xxI1BNCSBOi8gllR68g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF4CF3806729;
 Thu,  4 Jan 2024 16:29:50 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B5B31C060AF;
 Thu,  4 Jan 2024 16:29:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/6] Revert "osdep: add getloadavg"
Date: Thu,  4 Jan 2024 16:29:38 +0000
Message-ID: <20240104162942.211458-3-berrange@redhat.com>
In-Reply-To: <20240104162942.211458-1-berrange@redhat.com>
References: <20240104162942.211458-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

This reverts commit dc864d3a3777424187280e50c9bfb84dced54f12.

This functionality is not required after the previous revert

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/osdep.h | 10 ----------
 meson.build          |  1 -
 2 files changed, 11 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index d30ba73eda..475a1c62ff 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -779,16 +779,6 @@ static inline int platform_does_not_support_system(const char *command)
 }
 #endif /* !HAVE_SYSTEM_FUNCTION */
 
-/**
- * If the load average was unobtainable, -1 is returned
- */
-#ifndef HAVE_GETLOADAVG_FUNCTION
-static inline int getloadavg(double loadavg[], int nelem)
-{
-    return -1;
-}
-#endif /* !HAVE_GETLOADAVG_FUNCTION */
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/meson.build b/meson.build
index 6c77d9687d..67f4ede8ae 100644
--- a/meson.build
+++ b/meson.build
@@ -2296,7 +2296,6 @@ config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul'))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
-config_host_data.set('HAVE_GETLOADAVG_FUNCTION', cc.has_function('getloadavg', prefix: '#include <stdlib.h>'))
 if rbd.found()
   config_host_data.set('HAVE_RBD_NAMESPACE_EXISTS',
                        cc.has_function('rbd_namespace_exists',
-- 
2.43.0


