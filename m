Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 342947B9A55
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:46:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFGQ-0001IY-Cm; Wed, 04 Oct 2023 23:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGM-0001H4-9A
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGK-0007zN-Pz
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NW2NOMzgBdCNK5ZXMj4UrgviAiZWrBVJEYGFoltgO4I=;
 b=gkj6KACqsmoUoFIcy4NfKY/yMeZeEz8yRNp27KYx6o/+VIssSEK9WKOuBy6ps+YCaHNAis
 iJ9ABkaoWfqark4SoiJ+fnd/AebpQQEMH1wBxEt2XePlpF0xJTPMDkTaiLPEBv6sHXMEjE
 6s6I1HxiHqLRWm9uxWkMK9UIYQ0Xmcs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-lj1SKyVfPGK5XO4RmZ1HbA-1; Wed, 04 Oct 2023 23:42:49 -0400
X-MC-Unique: lj1SKyVfPGK5XO4RmZ1HbA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso3144215e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477367; x=1697082167;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NW2NOMzgBdCNK5ZXMj4UrgviAiZWrBVJEYGFoltgO4I=;
 b=gLtUzq/WWzGlo6KKEOc/Md+WyMgxMSqLBR64CH3KETf9XfEnZ9NdSQLMPdDkvwpWbw
 JxeQVw2TplJ80nHnK2gDkQwKfFVFE03um7cBFjvGgNRA9Z0i5H2K1/edcD7+QosCd1En
 kqKbs16OPXxgdVYaNxPRuNmKHev8XoGNB/ZEXwTGmkFMxkvmPA8mC8DnMRynnSdti0yW
 9DA7hTEsPMwXolVq1QCxWLiflB/y5BaeX/liFuS0SCK6NQITh9N1Dnla17QwLY6DYglQ
 8KA/Y6S+AcO/baAHNHOmWKQciZwljQylrv+Fs2y7OyGd1jepo/3uaFUo4gNTspuQuMUD
 bnog==
X-Gm-Message-State: AOJu0Yxg1doQBP6QkaJT9htM3G3lnOFLmW58xPjg4N1Ry/wMYEIo46F5
 gMTOWUzo3WnRQ5I588stESyLDuLBQaJDjJ+ipoc07KzqeOQEj5msXGkQ6tiMJDZhwHqnXtWE29S
 rmsFul3OZkHAUB3qSXHW6QcpX3zStEp2BSto7ev+RwxxxJ5p6c6w6SMfR5ox1dvxhQ+KA
X-Received: by 2002:a7b:c851:0:b0:406:5301:4320 with SMTP id
 c17-20020a7bc851000000b0040653014320mr3855862wml.16.1696477367089; 
 Wed, 04 Oct 2023 20:42:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvVfT5Ph3zky850qCUlsOmGrymPhsw/odVy9qMIpBfh8LB/8KbM6XZ7J3X4vTjLW8BKazvJQ==
X-Received: by 2002:a7b:c851:0:b0:406:5301:4320 with SMTP id
 c17-20020a7bc851000000b0040653014320mr3855850wml.16.1696477366867; 
 Wed, 04 Oct 2023 20:42:46 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 x2-20020a1c7c02000000b003fe23b10fdfsm2760216wmc.36.2023.10.04.20.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:42:46 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:42:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL v2 06/53] hw/virtio: Build vhost-vdpa.o once
Message-ID: <05632635f84311f241ad4dbffdb591f97339a5dc.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The previous commit removed the dependencies on the
target-specific TARGET_PAGE_FOO macros. We can now
move vhost-vdpa.c to the 'softmmu_virtio_ss' source
set to build it once for all our targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230710100432.84819-1-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 13e7c6c272..9737450afd 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -18,7 +18,8 @@ if have_vhost
     specific_virtio_ss.add(files('vhost-user.c'))
   endif
   if have_vhost_vdpa
-    specific_virtio_ss.add(files('vhost-vdpa.c', 'vhost-shadow-virtqueue.c'))
+    softmmu_virtio_ss.add(files('vhost-vdpa.c'))
+    specific_virtio_ss.add(files('vhost-shadow-virtqueue.c'))
   endif
 else
   softmmu_virtio_ss.add(files('vhost-stub.c'))
-- 
MST


