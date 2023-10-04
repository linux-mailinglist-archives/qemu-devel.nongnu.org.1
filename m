Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 953E97B7A9C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:49:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUz-0005cG-Di; Wed, 04 Oct 2023 04:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUn-0004yZ-Hi
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUm-0001p5-1Q
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4Cix+xhRSqfwmTscFGe9trJu0iYTGmnsDB5+Bia4t8=;
 b=MWOfBDNoqnN5Fh/3fQHodkCI2pLXsJo3J3IhPr9t6LcoD7w+eluejeSy438nbHRO5z5ItS
 4/k/2tcsnn90ZOvne+uHLqWqO0+Poo6au8UvkdDutl47taexXD9rGCxc71sBsXHNSIlVao
 66KRvKhhvONpTlxepfG7a/xUj6o77eo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-x7eftrEBMTO-Sv-4RauYmw-1; Wed, 04 Oct 2023 04:44:28 -0400
X-MC-Unique: x7eftrEBMTO-Sv-4RauYmw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3251bc06680so1463247f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409066; x=1697013866;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U4Cix+xhRSqfwmTscFGe9trJu0iYTGmnsDB5+Bia4t8=;
 b=MybRhtRUvwcHsJPuluTTlcatDtrP1PfVe1ASPKPrcwiYNf3xLrwZ55Ju3k+NkN4D2r
 JnmcqY/8flW46TYNrz7OdHH5Ocz94Tv2SQesGrKTYaMA6SgsdDK3030djjPCfjmVM8hY
 AZNI82ChFBVjjkBKsIvqMjuI9Yf3iN0k0VGRvKX0F9DXhrE6+uvTwjIPw/q11256klwH
 iU/JiejPnZeXw4kBwN+GfuD3IR375BO2yFOngc5a+EykeAbqsSYeiagnYU3lxFLVXXer
 j8ZkZy5Z86yRWwO7nQ13EkEITfNravCsGNW20nUW13TZdyqsxn17yump86MOfGq275GL
 eBlA==
X-Gm-Message-State: AOJu0YyCBqtPK183bil4hsthIbYOhAzB92F9MfiFrEml3TbuRnqK/VPs
 a/s6ejou1mu4YvoGExtYHJ1OVvbbpEfyrW0zRsLFlgsuvs48N1Xg3UutHFbtMnZOBLiMf9Oyj3B
 yJJqoo2kfdQlBr57piqBZEIMDMuj1ZU9m5p5YUjUDr/v0799nLBrn8+Te4G3dDNiFRPau
X-Received: by 2002:a05:6000:1815:b0:317:e1fb:d56a with SMTP id
 m21-20020a056000181500b00317e1fbd56amr1332479wrh.40.1696409066210; 
 Wed, 04 Oct 2023 01:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS6osEgUkCwH+6F5T8UKC37qfNWFa2OQQhEA2S5hHIb6baRa9RiqoWXrG0efMaa6c+VBVDmA==
X-Received: by 2002:a05:6000:1815:b0:317:e1fb:d56a with SMTP id
 m21-20020a056000181500b00317e1fbd56amr1332456wrh.40.1696409065883; 
 Wed, 04 Oct 2023 01:44:25 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with UTF8SMTPSA id
 u12-20020adfa18c000000b00327de0173f6sm107044wru.115.2023.10.04.01.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:25 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Laszlo Ersek <lersek@redhat.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Liu Jiang <gerry@linux.alibaba.com>,
	Sergio Lopez Pascual <slp@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Albert Esteve <aesteve@redhat.com>, Philippe@redhat.com,
	Mathieu-Daudé@redhat.com, &lt@redhat.com
Subject: [PULL 24/63] vhost-user: strip superfluous whitespace
Message-ID: <1487a89a54913ad88cd44b999d059c0b72dbf18d.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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
Message-Id: <20230830134055.106812-2-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé &lt;<a href="mailto:philmd@linaro.org" target="_blank">philmd@linaro.org</a>&gt;<br>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index a096335921..f4c06ecb10 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -377,7 +377,7 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
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


