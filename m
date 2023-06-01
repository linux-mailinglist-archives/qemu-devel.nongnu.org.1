Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167A71A2AA
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:28:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kC5-0004ZM-UI; Thu, 01 Jun 2023 11:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4kC3-0004XL-DN
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4kBq-0003VC-FF
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685633173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZ5BNX4c5KUjeA09sd5fBjLXzeUNTb+dTFMcgwON1rg=;
 b=bE6rK6I/0tid1D28TYhciFJi4wHXRqaOPrMa8YT4rXtGS1cNgLUiaa142mY1UnLqFg/3/K
 lXB8VIBKkKKnck9CGR02YOuEylEpgjCKt3BvWPf7TpLxIIBA6abRSiH3glKRrOzaiDLrhV
 6V9J8fhXNPtXzWkFpw5W9cvaoP1i+HU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-A75QHkCMNk6EcxhtamKjMA-1; Thu, 01 Jun 2023 11:26:12 -0400
X-MC-Unique: A75QHkCMNk6EcxhtamKjMA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27CDE817050;
 Thu,  1 Jun 2023 15:26:11 +0000 (UTC)
Received: from localhost (unknown [10.39.194.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F5AF492B0A;
 Thu,  1 Jun 2023 15:26:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, Thomas Huth <thuth@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, kvm@vger.kernel.org
Subject: [PULL 8/8] qapi: add '@fdset' feature for
 BlockdevOptionsVirtioBlkVhostVdpa
Date: Thu,  1 Jun 2023 11:25:52 -0400
Message-Id: <20230601152552.1603119-9-stefanha@redhat.com>
In-Reply-To: <20230601152552.1603119-1-stefanha@redhat.com>
References: <20230601152552.1603119-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefano Garzarella <sgarzare@redhat.com>

The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports the fd
passing through the new 'fd' property.

Since now we are using qemu_open() on '@path' if the virtio-blk driver
supports the fd passing, let's announce it.
In this way, the management layer can pass the file descriptor of an
already opened vhost-vdpa character device. This is useful especially
when the device can only be accessed with certain privileges.

Add the '@fdset' feature only when the virtio-blk-vhost-vdpa driver
in libblkio supports it.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-id: 20230530071941.8954-3-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/block-core.json | 6 ++++++
 meson.build          | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 98d9116dae..4bf89171c6 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3955,10 +3955,16 @@
 #
 # @path: path to the vhost-vdpa character device.
 #
+# Features:
+# @fdset: Member @path supports the special "/dev/fdset/N" path
+#     (since 8.1)
+#
 # Since: 7.2
 ##
 { 'struct': 'BlockdevOptionsVirtioBlkVhostVdpa',
   'data': { 'path': 'str' },
+  'features': [ { 'name' :'fdset',
+                  'if': 'CONFIG_BLKIO_VHOST_VDPA_FD' } ],
   'if': 'CONFIG_BLKIO' }
 
 ##
diff --git a/meson.build b/meson.build
index bc76ea96bf..a61d3e9b06 100644
--- a/meson.build
+++ b/meson.build
@@ -2106,6 +2106,10 @@ config_host_data.set('CONFIG_LZO', lzo.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
 config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
 config_host_data.set('CONFIG_BLKIO', blkio.found())
+if blkio.found()
+  config_host_data.set('CONFIG_BLKIO_VHOST_VDPA_FD',
+                       blkio.version().version_compare('>=1.3.0'))
+endif
 config_host_data.set('CONFIG_CURL', curl.found())
 config_host_data.set('CONFIG_CURSES', curses.found())
 config_host_data.set('CONFIG_GBM', gbm.found())
-- 
2.40.1


