Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C97D7B9A72
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:49:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJE-00006C-Iz; Wed, 04 Oct 2023 23:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIj-0008Cj-PE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIh-0000bg-RQ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fi0K9Am3IfJincw8VDTgn5xt0/GGjlt5fWIa13TNowA=;
 b=afeIcArU9JS81kPTVRZjxfEJFhRUSOojmbCy72llYoIaUR7UerdoWEvgJt1MuiwKQfkdm3
 BGqTVZjW6mdtx1qOxrKFu39G9NPm7kfKv/BGCRVmReG2HNOVsUqxsONhGe71kolWz7JqxH
 Ze3tWoTUkJXgnf+WdDQT37ldHxnCCl8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-uPndyjheMfWVliu_GDzquQ-1; Wed, 04 Oct 2023 23:45:14 -0400
X-MC-Unique: uPndyjheMfWVliu_GDzquQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-313c930ee0eso408187f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477512; x=1697082312;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fi0K9Am3IfJincw8VDTgn5xt0/GGjlt5fWIa13TNowA=;
 b=W2L4FLa1Iq6zYJmslIPp46BVB2pR8iHs6DGGzdZOJvvc4vlHy1sqxFZrL8pVweFe5b
 pFZHaX/gLOChcnghjka56u3KrCchz7/4jjGTfQyku5QwS+Dr5KmP0jVVRKFsSSo+zq6f
 ZFpkBiCmXPM4QUFjGaqQkONk1q2YWuK/IzjE4ztnfHCVgSufjSSBFKYIEDNgObZ/Q7Ab
 4FrMqbpQCclaroZb2EBFHqmwD5ah0HFTz29cwwMVjMOE+dvOx218G+4dkkt9+bpfgn+m
 4SM7yEl86/BKeumY/budMMOD8iElN57nW3YuZotCVnzi/+kACMRYIBRDlQe5j75eQaAQ
 ABgQ==
X-Gm-Message-State: AOJu0YzYP6eQRuw4p2GshWu2GMADE4MqVNnv88AAqJtW25sZJySzuDCs
 J4XgSIUG9MZ/MBF9LI2OOX2qLyz3w0lCzfYXG5yYB4CYZo2Py4EygeX2hn8O3DdpeN5NP1EKzFO
 IPi5bHv1BAQ6bVRQaafrB5VJDk8OV/G7xXkgV6AIajrdK5O7jEYYHS9U5p2BdimhB8RRL
X-Received: by 2002:a5d:56ca:0:b0:319:6e74:1637 with SMTP id
 m10-20020a5d56ca000000b003196e741637mr3461631wrw.27.1696477512490; 
 Wed, 04 Oct 2023 20:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHWk/Px8OO6gJkgolgaKQIrECYd33pSKdauB0QN0onKNFpHbeBdFpeW0VCHDt7rLL2r4b16w==
X-Received: by 2002:a5d:56ca:0:b0:319:6e74:1637 with SMTP id
 m10-20020a5d56ca000000b003196e741637mr3461619wrw.27.1696477512285; 
 Wed, 04 Oct 2023 20:45:12 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 v11-20020adfedcb000000b0031fd849e797sm621531wro.105.2023.10.04.20.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:11 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL v2 40/53] vdpa net: fix error message setting virtio status
Message-ID: <cbc9ae87b5f6f81c52a249e0b64100d5011fca53.1696477105.git.mst@redhat.com>
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

From: Eugenio Pérez <eperezma@redhat.com>

It incorrectly prints "error setting features", probably because a copy
paste miss.

Fixes: 152128d646 ("vdpa: move CVQ isolation check to net_init_vhost_vdpa")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230915170836.3078172-2-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index fe519d908d..650125bb0f 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1368,7 +1368,7 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
 
     r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
     if (unlikely(r)) {
-        error_setg_errno(errp, -r, "Cannot set device features");
+        error_setg_errno(errp, -r, "Cannot set status");
         goto out;
     }
 
-- 
MST


