Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 624437D019A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:32:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhj-0001TC-0U; Thu, 19 Oct 2023 14:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfL-0006iW-FR
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfJ-0000mw-Rh
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axsLHZnyDqeJsUPQJ6Te7VvBOL93A3E/3UAHlG8ASYU=;
 b=CnULL/FSToWvWQVU/zRZyPVtFrzB/5NKebbG2/OVn2CtZZpJUWkRGHzVUb+AAAlGg1rnXL
 +bfUN755RrLgsz462MJt2ibEj3QXq8GAByYFxZaEaFDLsQrO8pfR7MBe8gaHvK4mbH18M7
 bDkNgVi0pNDHqoUiE9FBIZ25sQ1mZOA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-6nEXEqlYM3-U90KglTq8FA-1; Thu, 19 Oct 2023 14:22:19 -0400
X-MC-Unique: 6nEXEqlYM3-U90KglTq8FA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-406de77fb85so51412205e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739737; x=1698344537;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=axsLHZnyDqeJsUPQJ6Te7VvBOL93A3E/3UAHlG8ASYU=;
 b=oXbVMzkSYXvxZIPZO04BSP6Y9CYwq5EsHEKc3n1ffQtC92hsTaFfPQycihGWVz+Zsg
 hmRb1WVRwtUnYMsb0a3iStkcD25EJ+NgESuwmO9B5Xzu6U/bVzG9El4fFC4xwFVBWh9X
 tzo38DDTXHjPshZDJwV+z4qu6rqoETJ92tJmAAAexwQaBzM5kUdvsFuo03mB0Uf4X2z0
 gm3exR0zvCSQb/zNGgH9RbkHPp3Udh+CPK+013kMlRZAe1pBNTfny4ljo2LqFhegEGl3
 HQCT955kKPzAoJ30L6cYx7wXI4B8i++zP3sEX8WaI3WTvSBRJi2vG+Y4VS92s9yzr27V
 hcTA==
X-Gm-Message-State: AOJu0Yx4I96+FgAXaYbXTSH8RDbsb35OXk4Z9QFomwIFM2FsbWNPCHKP
 iKFxZlYQ25AtsyGYNweKcGntKSsPnZNZTZ0f6oAHKrV91vjBBymw2OSaBhbNTosW2nU+IBYjJ9P
 8bO2xRSLGqrikeAXnTP8skYdvjKNn7XygvMcTBSwCm6QQEkrhOf63bNsHV+7xFLgg4YzV
X-Received: by 2002:a05:600c:4752:b0:401:bcd9:4871 with SMTP id
 w18-20020a05600c475200b00401bcd94871mr2562078wmo.21.1697739737380; 
 Thu, 19 Oct 2023 11:22:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbmzlvgyY9XM3FKv1d4UTM1eaEomlch6V5eKLzoP1RX4FBvReFnUJhS1x1HoxMBR0zFHLp5w==
X-Received: by 2002:a05:600c:4752:b0:401:bcd9:4871 with SMTP id
 w18-20020a05600c475200b00401bcd94871mr2562057wmo.21.1697739737090; 
 Thu, 19 Oct 2023 11:22:17 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a05600c339800b0040303a9965asm5004032wmp.40.2023.10.19.11.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:16 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL v2 24/78] vhost-user: strip superfluous whitespace
Message-ID: <4620730c9787898f30b59ba5b84c05f52a79db2d.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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

From: Laszlo Ersek <lersek@redhat.com>

Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
Cc: Eugenio Perez Martin <eperezma@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Liu Jiang <gerry@linux.alibaba.com>
Cc: Sergio Lopez Pascual <slp@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20231002203221.17241-2-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 68eb1f0c99..3e33a2e9e0 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -388,7 +388,7 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
      * operations such as configuring device memory mappings or issuing device
      * resets, which affect the whole device instead of individual VQs,
      * vhost-user messages should only be sent once.
-     * 
+     *
      * Devices with multiple vhost_devs are given an associated dev->vq_index
      * so per_device requests are only sent if vq_index is 0.
      */
-- 
MST


