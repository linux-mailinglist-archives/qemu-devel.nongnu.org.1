Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D157C74E1F8
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwg-0003jf-KA; Mon, 10 Jul 2023 19:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwR-000306-OA
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwJ-0004mQ-II
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lr23N/kbsARVVr5iF+Jste9DzcTEbZfcy58ahS6NDeE=;
 b=e5smPRA2/l96QhTLog8h9OPyArZMjwsbfW5DN5S8o0k/xuwfd+6WlhLBRD9L6jyqDso2j6
 dLnzlMXqYJ44tQLprzFB1jAZfM/ZCYEOVIHe3peoUWyvSa4A5WPkGd+Cd0onSXFirGUHNs
 F2thQUcsdEfV0RCC6+t5S260UIFEpC8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-lG3QSu20NqCodVKUi7eNGA-1; Mon, 10 Jul 2023 19:05:05 -0400
X-MC-Unique: lG3QSu20NqCodVKUi7eNGA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fa9a282fffso29964105e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030303; x=1691622303;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lr23N/kbsARVVr5iF+Jste9DzcTEbZfcy58ahS6NDeE=;
 b=eb5pF/Qwhmt4gJ3TCbBSkk2GjjIj468pJ7X3RuBgz/kAYSzELSxOXtI6lx+JSnPq3i
 ZwKYCrZjKgqKdakLizRmWSRDe+Cqj2s/REzVyjAsclnHgbZIYFS2nSt1pcbreOh+GOg+
 +gJZRyjY4NdeIMrXVY4EgKahdXk1HPAN6T2zNrg9KzunKgKK+je582bqAErou4qQthHA
 /cMgJnWVviYbjDrQhFoOuj191Ya44cQ1BHK7rzODYNhsTVi/NiPoxxMTkonJnZPgVeUe
 RKdzw0d4+PjRZBtAS7/EFmHR12fyV3crfz3wm5p0rE62ZysuPlWkHif/plRN0lkiEGUG
 Mmpw==
X-Gm-Message-State: ABy/qLaVj1EjZ4126OJalhzKpbUHfnWEGGOdKZnuUCWwQ85Xm+QU4CZO
 Pl9X76GGN+8z6xddVbhfWzP5rf8xUkVV3ezOYRz9eRq18npRqtLN9wvT5chlxMHyqzu464CdWem
 T2r6mLFySuRdPW2mDRd06m2ZpFuGyAirTtvcm2N46eBW1je/g517+dIGq30jy3HRPUzl0
X-Received: by 2002:a5d:4d4d:0:b0:313:ed1d:39d5 with SMTP id
 a13-20020a5d4d4d000000b00313ed1d39d5mr11259275wru.35.1689030303517; 
 Mon, 10 Jul 2023 16:05:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFDJU2buaWcSt8ZU/tuCkUzqbYAWhnEiATIyHNBl4kgNTqJEjaYitvNy1JjG7XCLsoaToF63w==
X-Received: by 2002:a5d:4d4d:0:b0:313:ed1d:39d5 with SMTP id
 a13-20020a5d4d4d000000b00313ed1d39d5mr11259264wru.35.1689030303312; 
 Mon, 10 Jul 2023 16:05:03 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 q10-20020adfdfca000000b003144b95e1ecsm565441wrn.93.2023.07.10.16.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:05:02 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:05:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 54/66] include/hw/virtio: add kerneldoc for virtio_init
Message-ID: <3b6256c2c57061c365cfad7857e12fd8d15ca3c8.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230710153522.3469097-6-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 0671989383..631490bda4 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -219,6 +219,12 @@ struct VirtioDeviceClass {
 void virtio_instance_init_common(Object *proxy_obj, void *data,
                                  size_t vdev_size, const char *vdev_name);
 
+/**
+ * virtio_init() - initialise the common VirtIODevice structure
+ * @vdev: pointer to VirtIODevice
+ * @device_id: the VirtIO device ID (see virtio_ids.h)
+ * @config_size: size of the config space
+ */
 void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size);
 
 void virtio_cleanup(VirtIODevice *vdev);
-- 
MST


