Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDEE92FB44
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jul 2024 15:26:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGHk-0003KL-6b; Fri, 12 Jul 2024 09:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGHI-0002jn-N5
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGHG-0003wc-8A
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720790733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRSe/YzoH9Rhej0RUrw4QjNxQSFXekPD7YTrSp4mDRw=;
 b=AyNQvv92TMvXiMBbE0nf0IZnhrGIZVreMx19xi6dyq/K5wXACGuehCfoDOrG/DYClzMMBH
 uOu7JvNLGfKPlIb4BC99RoTmJ3SJ/eZJ4MnikwpfPuSKSgNGq5AzJiY2tJm+zgMBb1ghfs
 3oPqtrouO8kyQUzLx1oU1jF+QD5n4ac=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-vytljU4UPd68Xmy9kGt3iw-1; Fri,
 12 Jul 2024 09:25:31 -0400
X-MC-Unique: vytljU4UPd68Xmy9kGt3iw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1717A19560AD; Fri, 12 Jul 2024 13:25:30 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14FA01955F40; Fri, 12 Jul 2024 13:25:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH v3 07/22] qga: move CONFIG_FSFREEZE/TRIM to be meson defined
 options
Date: Fri, 12 Jul 2024 14:24:44 +0100
Message-ID: <20240712132459.3974109-8-berrange@redhat.com>
In-Reply-To: <20240712132459.3974109-1-berrange@redhat.com>
References: <20240712132459.3974109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
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

Defining these at the meson level allows them to be used a conditional
tests in the QAPI schemas.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build           | 15 +++++++++++++++
 qga/commands-common.h |  9 ---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 6a93da48e1..3f125d1b02 100644
--- a/meson.build
+++ b/meson.build
@@ -2186,6 +2186,19 @@ have_virtfs_proxy_helper = get_option('virtfs_proxy_helper') \
     .require(libcap_ng.found(), error_message: 'the virtfs proxy helper requires libcap-ng') \
     .allowed()
 
+qga_fsfreeze = false
+qga_fstrim = false
+if host_os == 'linux'
+    if cc.has_header_symbol('linux/fs.h', 'FIFREEZE')
+        qga_fsfreeze = true
+    endif
+    if cc.has_header_symbol('linux/fs.h', 'FITRIM')
+        qga_fstrim = true
+    endif
+elif host_os == 'freebsd' and cc.has_header_symbol('ufs/ffs/fs.h', 'UFSSUSPEND')
+    qga_fsfreeze = true
+endif
+
 if get_option('block_drv_ro_whitelist') == ''
   config_host_data.set('CONFIG_BDRV_RO_WHITELIST', '')
 else
@@ -2422,6 +2435,8 @@ config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
 config_host_data.set('CONFIG_DEBUG_REMAP', get_option('debug_remap'))
 config_host_data.set('CONFIG_QOM_CAST_DEBUG', get_option('qom_cast_debug'))
 config_host_data.set('CONFIG_REPLICATION', get_option('replication').allowed())
+config_host_data.set('CONFIG_FSFREEZE', qga_fsfreeze)
+config_host_data.set('CONFIG_FSTRIM', qga_fstrim)
 
 # has_header
 config_host_data.set('CONFIG_EPOLL', cc.has_header('sys/epoll.h'))
diff --git a/qga/commands-common.h b/qga/commands-common.h
index 8c1c56aac9..263e7c0525 100644
--- a/qga/commands-common.h
+++ b/qga/commands-common.h
@@ -15,19 +15,10 @@
 
 #if defined(__linux__)
 #include <linux/fs.h>
-#ifdef FIFREEZE
-#define CONFIG_FSFREEZE
-#endif
-#ifdef FITRIM
-#define CONFIG_FSTRIM
-#endif
 #endif /* __linux__ */
 
 #ifdef __FreeBSD__
 #include <ufs/ffs/fs.h>
-#ifdef UFSSUSPEND
-#define CONFIG_FSFREEZE
-#endif
 #endif /* __FreeBSD__ */
 
 #if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
-- 
2.45.1


