Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED89479439A
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 21:10:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdxuE-00037K-3x; Wed, 06 Sep 2023 15:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qdxuB-00036u-9w
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 15:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qdxu8-0001NI-SF
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 15:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694027371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBiJpsxEnCUa3PwtibY0LzJhCfJp0vQxPQPp82OGlu0=;
 b=Y2soV0IgFUqseY5CuJYAg5dNTXkMLTJMuy83/ps+6ZUuC2R6jwBIoIVuwLyUOTbM1/Jcdk
 xi4J/NeteTOVHQ815JDUA5EVz/OVdOJxJ3GVGfWGSIEfFH8Kplck5tASpKRt9tBcZGB5F3
 l2Z1eeivspbFxhebsuRXMUherscVfNY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Ov1oq1XaMkuWFazzj0VHXA-1; Wed, 06 Sep 2023 15:09:29 -0400
X-MC-Unique: Ov1oq1XaMkuWFazzj0VHXA-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-77e41268d40so9012939f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 12:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694027369; x=1694632169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBiJpsxEnCUa3PwtibY0LzJhCfJp0vQxPQPp82OGlu0=;
 b=Jxau3N/+8iRV4vWHWhbAq0ui/liEbxP1RKamzSZ9X9M1Jll5aTaLnSxQmV1ojdcxUw
 ynkHtKEnIkes6DE4jLCvJIEyhfaTt7qNw0uwKwPp2fXA7P8OO6SWdO3bs8uCaXw8sDPa
 quR32A17MPFkVB5QNLuhV51FxvwRwapFc8ALjj7saSi0az3jDqjP7bLFCxxgHfVODzXv
 /2YEcGUd9rqnZ3JMdN+dpZzLHywRRHqCzj8qFTz0StDQvZKSztCiC+9boZ/+0BvNvLL4
 n1BhRqBBHCCQbTxtpkt5d4Tp9J59cJQOwp7XUEh+Yw+8wAZjsOHKz4HzxV1JyHQkcG8H
 qs1w==
X-Gm-Message-State: AOJu0YwO4z2xFRaKQIEz2lVQjjH1Mp7qeIKVeOBE1JM9iPJITPxRGOFB
 PAWiPT6VuK/y71Wm2jQuneGi8LVBZ6/6fqcDPKbJorOUXmgvGpcEpgTR2yJEt2Koylh85qm3T0G
 qvMXyomdk/oJtOp8=
X-Received: by 2002:a5e:8913:0:b0:783:47cd:27b5 with SMTP id
 k19-20020a5e8913000000b0078347cd27b5mr18405070ioj.3.1694027369176; 
 Wed, 06 Sep 2023 12:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIwb8l1rBKupGvO/NIh4YppbHFcz5OlESmGeW7rShwqPEpPPjwFjKVHqUfuhv7LL0h7xhusQ==
X-Received: by 2002:a5e:8913:0:b0:783:47cd:27b5 with SMTP id
 k19-20020a5e8913000000b0078347cd27b5mr18405055ioj.3.1694027368870; 
 Wed, 06 Sep 2023 12:09:28 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 x6-20020a5e8306000000b0077a1d1029fcsm5230316iom.28.2023.09.06.12.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 12:09:27 -0700 (PDT)
Date: Wed, 6 Sep 2023 13:09:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 clg@redhat.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 eric.auger@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 chao.p.peng@intel.com
Subject: Re: [PATCH v1 21/22] vfio/pci: Allow the selection of a given iommu
 backend
Message-ID: <20230906130926.5c66f9d6.alex.williamson@redhat.com>
In-Reply-To: <ZPjAn1Asi5ZE9yzB@nvidia.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-22-zhenzhong.duan@intel.com>
 <ZPjAn1Asi5ZE9yzB@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Wed, 6 Sep 2023 15:10:39 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Aug 30, 2023 at 06:37:53PM +0800, Zhenzhong Duan wrote:
> > Note the /dev/iommu device may have been pre-opened by a
> > management tool such as libvirt. This mode is no more considered
> > for the legacy backend. So let's remove the "TODO" comment.  
> 
> Can you show an example of that syntax too?

Unless you're just looking for something in the commit log, patch 16/
added the following to the qemu help output:

+#ifdef CONFIG_IOMMUFD
+    ``-object iommufd,id=id[,fd=fd]``
+        Creates an iommufd backend which allows control of DMA mapping
+        through the /dev/iommu device.
+
+        The ``id`` parameter is a unique ID which frontends (such as
+        vfio-pci of vdpa) will use to connect withe the iommufd backend.
+
+        The ``fd`` parameter is an optional pre-opened file descriptor
+        resulting from /dev/iommu opening. Usually the iommufd is shared
+        accross all subsystems, bringing the benefit of centralized
+        reference counting.
+#endif
 
> Also, the vfio device should be openable externally as well

Appears to be added in the very next patch in the series.  Thanks,

Alex


