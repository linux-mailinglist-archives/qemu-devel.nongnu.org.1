Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D7890773E
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jun 2024 17:44:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmck-0005Qg-BR; Thu, 13 Jun 2024 11:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmcj-0005QM-7K
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmch-0003bG-2N
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718293461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04g3Ryn/8uQJtUsWp4KXRhdfUhJwq5WxgS5WanuKC5g=;
 b=cNI4i+873V5744D9HNP6wUhXLNClsDiF5vlcCly0ROb6rs1lUJpnn/EEPcIlQgGu4a0bsj
 zCMx3lhPCqxxpwauQR9R5BklSwM0tlSLL85NkmTwPkJpdwBG1WPlT8+4P0Z0m2RIa862Lo
 iHKwMZ7U5IbHD5X2SpBJ0fImRwyGC/w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-FGE4_3KdNXSiP4eCalJP-w-1; Thu,
 13 Jun 2024 11:44:16 -0400
X-MC-Unique: FGE4_3KdNXSiP4eCalJP-w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3398719560B4; Thu, 13 Jun 2024 15:44:15 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AD9D3000219; Thu, 13 Jun 2024 15:44:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 07/22] qga: move CONFIG_FSFREEZE/TRIM to be meson defined
 options
Date: Thu, 13 Jun 2024 16:43:51 +0100
Message-ID: <20240613154406.1365469-2-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-1-berrange@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
index 91278667ea..d9f3349b0a 100644
--- a/meson.build
+++ b/meson.build
@@ -2145,6 +2145,19 @@ have_virtfs_proxy_helper = get_option('virtfs_proxy_helper') \
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
@@ -2379,6 +2392,8 @@ config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
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


