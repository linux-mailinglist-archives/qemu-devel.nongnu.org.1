Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BBC71568A
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 09:21:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3tem-0001OL-3y; Tue, 30 May 2023 03:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q3teI-0001Bd-6t
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q3teE-0004yo-7E
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685431201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iD7g8SG5NfDEouyxjItNuwDXx/YbyC0EvPCvFUKOIOA=;
 b=LQ2fT4nJ256RQAzX5tvUvOg9znAJgNFb3PgfQRMuEK+CwvKlRAiUPDoihGWZDw2v9DxmEp
 TMGeBfH3lfvyG4aNcoIkJ26NHfZuczr731YWIbMnmxiaNSq/arUpeVgstP7CwwBqAd1mcc
 MNsI9yvkIbaWycSxpvBcjz0TDMUT+Kk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-CZl5e2QCO8C8qDwA7k7fmQ-1; Tue, 30 May 2023 03:19:59 -0400
X-MC-Unique: CZl5e2QCO8C8qDwA7k7fmQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-75b06a31daaso650369885a.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 00:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685431198; x=1688023198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iD7g8SG5NfDEouyxjItNuwDXx/YbyC0EvPCvFUKOIOA=;
 b=fiydumqzQxQ93LiRGliamJfv/Lu0C4Puk19iDZsqD6Eszzyq8PjcMvw4jYoPbc1R8h
 N5+Npzo9sdmwBHkUT3517D2n2LgNxUWzoJnFk8ikl5Epk7DL1fYrFtUHarMnclvk3iXY
 Km2MY10ajHQjLw0kjhwsCLD+beM2d6ARKcbgDDqBHfDwAM9LHYtWbEYQ4OFlW9Ccxdc+
 fzOGVOS3yX5R8EOdVpAtGW7/2abppx8wmFcGx/J9f+AbNIwGm49sq+tkxqKnplG/lgM/
 xJB0EO9dxNwlWXfwztO6DfQxAoj+lcmyFm/cgP27dziLW9fyxF9xsBtIOKSAflDL1T16
 dBXw==
X-Gm-Message-State: AC+VfDzL1LulBqJDzgHe8WmMZ+ItAem2MTFvq18Qhh2AlqTYAt+GuEgI
 a6KewKh/ajtx+8kr88IpqhVmJSDBXzZ5Dk0oo7GljR4PElsxt+6Iqq5sv3MGbgJklDHlHO+gu9x
 xtIfGEFYDpGSBxNPBpGIBmLXl3mRasPjFWwQMuk/CrbpbL8lOfd+4cE/NDZBFFoYL41rbLoORbH
 o=
X-Received: by 2002:a05:620a:6005:b0:75b:23a0:deb2 with SMTP id
 dw5-20020a05620a600500b0075b23a0deb2mr1129360qkb.48.1685431198330; 
 Tue, 30 May 2023 00:19:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LhTTgwV/SODu3ky/bP06IxjQX0qpdlUSFaTUtFeduQ6hvA9Ty6NCIb5ajIPyin4nzh4M/FA==
X-Received: by 2002:a05:620a:6005:b0:75b:23a0:deb2 with SMTP id
 dw5-20020a05620a600500b0075b23a0deb2mr1129336qkb.48.1685431198075; 
 Tue, 30 May 2023 00:19:58 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 p24-20020a05620a133800b0075b01970aaasm3886705qkj.32.2023.05.30.00.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 00:19:57 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jonathon Jongsma <jjongsma@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 2/2] qapi: add '@fdset' feature for
 BlockdevOptionsVirtioBlkVhostVdpa
Date: Tue, 30 May 2023 09:19:41 +0200
Message-Id: <20230530071941.8954-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530071941.8954-1-sgarzare@redhat.com>
References: <20230530071941.8954-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v5:
    - moved `features` to the object level to simplify libvirt code [Jonathon]
    - wrapped a line too long in the documentation [Markus]
    v4:
    - added this patch to allow libvirt to discover we support fdset [Markus]

 meson.build          | 4 ++++
 qapi/block-core.json | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/meson.build b/meson.build
index 2d48aa1e2e..4a9fa4c435 100644
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
-- 
2.40.1


