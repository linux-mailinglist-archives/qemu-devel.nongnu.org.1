Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAE271290F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 17:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YyS-0004LD-9U; Fri, 26 May 2023 11:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q2YyP-0004Jk-Np
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q2YyO-00069i-3Y
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685113399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YK3XQHcYhqlcBukeuGWEe8d/R/PU0qLq2Uekkg/vHIU=;
 b=AWJwTzMD/C7l+6n80ACCOCwMfquKgkY+NUxAZcMhNfbqQ5U6WSfQBAu9bH5TjBbFUVRGIh
 Z8nBuadKemxby3YRwze/TPaWXzb5cui0TJMlDkVRWUWo/28InIQ9f9cOe0uSIl6jw4KKc0
 UgUo/ytPbs7/l4Zs3j6bFo5ZcPXN2pQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-IMiNBJ7tMCSpMXk3gDE4pg-1; Fri, 26 May 2023 11:03:18 -0400
X-MC-Unique: IMiNBJ7tMCSpMXk3gDE4pg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96fae2a13a5so82884966b.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 08:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685113397; x=1687705397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YK3XQHcYhqlcBukeuGWEe8d/R/PU0qLq2Uekkg/vHIU=;
 b=QRXRkG3EjQnzZ05KdknL9SFI9ZqBxUP7FUX659ycIuYQAg0mdWmWWDOe6nvQpyS27E
 DxMpm8joIkJ0782EkiuxvxjUncJpL0cSOeSKM1mGTzwnvv/OKrz0P5vdpTLV2u6xgPtK
 qJQHsVQ12mKoP9ImEvLRKNrcts7ho1/cZEBH8inpcy3XgBkPyFn8gkCMIVQ9HVm4pdGB
 0DKEhrZzvNqUt0aSDsDbAR2hsJsYtnKC/pb7kejpX3pZqhHbho8mOQRRcneJg8AuEdho
 9mnW3GmP1YWH8cEjWzIrHa2TbzeZVxOsWy71jY+3ESryTi9AErrnJdP55CT2FwzWlFef
 QOgg==
X-Gm-Message-State: AC+VfDz1QUcevZcMEI5uMp+AZ8Ke0PoDbqD5+JQg5bYVMFimRrXZ219U
 j+60KH8lh1F2Q6JBVMBXCC3LH+pS1/c0rmyrLy6m1QExzHRvg3IwRB8kXxqVQ78DJVN8SrEbmY6
 l1u8DqMWNboXiPasW2O7lDjt6/6hRtbm7Fgydu8NWn5DD4vJPtYtzUoIHKCsu8qSsh9WAfPUSS1
 M=
X-Received: by 2002:a17:907:930b:b0:94e:ec32:ba28 with SMTP id
 bu11-20020a170907930b00b0094eec32ba28mr2317054ejc.29.1685113396699; 
 Fri, 26 May 2023 08:03:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ndf8M68H1YLG0GHmt5qafQB6ThhM8SWvJ5dDtfJrn0TrbRRSlIFtnuI/lAXTHDi3ONuMBrw==
X-Received: by 2002:a17:907:930b:b0:94e:ec32:ba28 with SMTP id
 bu11-20020a170907930b00b0094eec32ba28mr2317008ejc.29.1685113396172; 
 Fri, 26 May 2023 08:03:16 -0700 (PDT)
Received: from step1.. (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 q15-20020a1709066b0f00b0096b4c3489e6sm2274066ejr.177.2023.05.26.08.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 08:03:15 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonathon Jongsma <jjongsma@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 2/2] qapi: add '@fdset' feature for
 BlockdevOptionsVirtioBlkVhostVdpa
Date: Fri, 26 May 2023 17:03:04 +0200
Message-Id: <20230526150304.158206-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526150304.158206-1-sgarzare@redhat.com>
References: <20230526150304.158206-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v4:
    - added this patch to allow libvirt to discover we support fdset [Markus]

 meson.build          | 4 ++++
 qapi/block-core.json | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 78890f0155..8ea911f7b4 100644
--- a/meson.build
+++ b/meson.build
@@ -2108,6 +2108,10 @@ config_host_data.set('CONFIG_LZO', lzo.found())
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
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 98d9116dae..1538d84ef4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3955,10 +3955,16 @@
 #
 # @path: path to the vhost-vdpa character device.
 #
+# Features:
+# @fdset: Member @path supports the special "/dev/fdset/N" path (since 8.1)
+#
 # Since: 7.2
 ##
 { 'struct': 'BlockdevOptionsVirtioBlkVhostVdpa',
-  'data': { 'path': 'str' },
+  'data': { 'path': { 'type': 'str',
+                      'features': [ { 'name' :'fdset',
+                                      'if': 'CONFIG_BLKIO_VHOST_VDPA_FD' } ]
+            } },
   'if': 'CONFIG_BLKIO' }
 
 ##
-- 
2.40.1


