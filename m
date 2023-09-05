Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4E3793038
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 22:46:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdcvf-0002YL-8j; Tue, 05 Sep 2023 16:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qdcvZ-0002Xz-O0
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 16:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qdcvX-0001HG-69
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 16:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693946734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbw/uy0XD1sTwB2IrQAqn+1Wh/2UzB5st2kl2B4wp60=;
 b=AFJ2G2HLKDpb4xQ7YB/qsgAy5h83kPvOiUwM1P5cru3g6VXrKVmCAWd5TMhF66unJeJFvj
 mkcovfAouaD3235QfpQSSdXimZ0S2yNsfDTy3VytxfZ1glA5bysDLeTnZMBXfn3+DHIDwr
 6scFRb+k+1hL4Fnsyas1zYUfw34gs4E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-4LribBW5MVWbDg72m924ww-1; Tue, 05 Sep 2023 16:45:32 -0400
X-MC-Unique: 4LribBW5MVWbDg72m924ww-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51a5296eb8eso2134554a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 13:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693946731; x=1694551531;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gbw/uy0XD1sTwB2IrQAqn+1Wh/2UzB5st2kl2B4wp60=;
 b=QX/Q2XCQbXczwVrIrq0DBeAwSZ1jRJG84Lupy8ecm6+dzREsDdvUnGOvl5Ze5IlglC
 zf1ZmiEEgd1FOPA3NqvQAE/ZvTJXLONqiMkMP/YQClClc12DQ4e1RLlQqm+I3q7ixm5s
 j8IQZSSk5+t0RkGAq1gRI54JdBoHY/W6WPHd7IaOKsgyctNAuJM/+6Cmg1X6HTFw896b
 HN/C4M1fMdlZ+EPrNBOFgfUBHI0fWUKhR+qAsvT7fQ0vudp8gr9vJUEk4B1CBZs+LFh9
 8oGHJUIh2WwHobaUVKVrfr2/Lxp55ylxBjdttjzUDsZaZ0Q/+TzoNrCbuqHpUcZCMRgL
 IzOA==
X-Gm-Message-State: AOJu0Yw+vANm/4KDO3mVE5he4rWH9EZ5f7skJIK5fW7xbOw7yS6HUXF2
 FdWBqGdeKZe8J+I+ATIssE7wQxHvInrXBFtH68SA8JM0pX3f3BZwDZCQmmvwCJa+B1SCFsCOSd7
 l1JtlrQBC2pWyQHU=
X-Received: by 2002:a05:6402:124b:b0:522:ae79:3ee8 with SMTP id
 l11-20020a056402124b00b00522ae793ee8mr775259edw.5.1693946731584; 
 Tue, 05 Sep 2023 13:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3eYYMvX3xMGJf/Jq6kFEL4sDn0ajAu/5kbCr1DMsfLUyjxhiDgpezhm4JzdGzqh0exwa03w==
X-Received: by 2002:a05:6402:124b:b0:522:ae79:3ee8 with SMTP id
 l11-20020a056402124b00b00522ae793ee8mr775250edw.5.1693946731274; 
 Tue, 05 Sep 2023 13:45:31 -0700 (PDT)
Received: from redhat.com ([2.52.23.134]) by smtp.gmail.com with ESMTPSA id
 f24-20020aa7d858000000b0052544441babsm7606659eds.72.2023.09.05.13.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 13:45:30 -0700 (PDT)
Date: Tue, 5 Sep 2023 16:45:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, kraxel@redhat.com,
 cohuck@redhat.com, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v5 0/4] Virtio shared dma-buf
Message-ID: <20230905164451-mutt-send-email-mst@kernel.org>
References: <20230802090824.91688-1-aesteve@redhat.com>
 <CADSE00JRMvQ6Ye445xon0GoCDSsp7oAY_B--rABooabMTraoaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00JRMvQ6Ye445xon0GoCDSsp7oAY_B--rABooabMTraoaQ@mail.gmail.com>
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

I was hoping for some acks from Gerd or anyone else with a clue
about graphics, but as that doesn't seem to happen I'll merge.
Thanks!

On Mon, Aug 21, 2023 at 02:37:56PM +0200, Albert Esteve wrote:
> Hi all,
> 
> A little bump for this patch, sorry for the extra noise.
> 
> Regards,
> Albert
> 
> 
> On Wed, Aug 2, 2023 at 11:08 AM Albert Esteve <aesteve@redhat.com> wrote:
> 
>     v1 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/
>     msg00598.html
>     v2 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/
>     msg04530.html
>     v3 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/
>     msg06126.html
>     v4 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-06/
>     msg05174.html
>     v4 -> v5:
>     - Allow shared table to hold pointers for vhost devices, in a struct that
>     defines the types that the table can store
>     - New message VHOST_USER_GET_SHARED_OBJECT to retrieve objects stored in
>     vhost backends
>     - Minor additions to support the previous items (e.g. new test usecases).
> 
>     This patch covers the required steps to add support for virtio cross-device
>     resource sharing[1],
>     which support is already available in the kernel.
> 
>     The main usecase will be sharing dma buffers from virtio-gpu devices (as
>     the exporter
>     -see VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID in [2]), to virtio-video (under
>     discussion)
>     devices (as the buffer-user or importer). Therefore, even though virtio
>     specs talk about
>     resources or objects[3], this patch adds the infrastructure with dma-bufs
>     in mind.
>     Note that virtio specs let the devices themselves define what a vitio
>     object is.
> 
>     These are the main parts that are covered in the patch:
> 
>     - Add hash function to uuid module
>     - Shared resources table, to hold all resources that can be shared in the
>     host and their assigned UUID,
>       or pointers to the backend holding the resource
>     - Internal shared table API for virtio devices to add, lookup and remove
>     resources
>     - Unit test to verify the API
>     - New messages to the vhost-user protocol to allow backend to interact with
>     the shared
>       table API through the control socket
>     - New vhost-user feature bit to enable shared objects feature
> 
>     Applies cleanly to 38a6de80b917b2a822cff0e38d83563ab401c890
> 
>     [1] - https://lwn.net/Articles/828988/
>     [2] - https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/
>     virtio-v1.2-csd01.html#x1-3730006
>     [3] - https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/
>     virtio-v1.2-csd01.html#x1-10500011
> 
>     Albert Esteve (4):
>       uuid: add a hash function
>       virtio-dmabuf: introduce virtio-dmabuf
>       vhost-user: add shared_object msg
>       vhost-user: refactor send_resp code
> 
>      MAINTAINERS                               |   7 +
>      docs/interop/vhost-user.rst               |  57 +++++++
>      hw/display/meson.build                    |   1 +
>      hw/display/virtio-dmabuf.c                | 136 +++++++++++++++++
>      hw/virtio/vhost-user.c                    | 174 ++++++++++++++++++++--
>      include/hw/virtio/vhost-backend.h         |   3 +
>      include/hw/virtio/virtio-dmabuf.h         | 103 +++++++++++++
>      include/qemu/uuid.h                       |   2 +
>      subprojects/libvhost-user/libvhost-user.c | 118 +++++++++++++++
>      subprojects/libvhost-user/libvhost-user.h |  55 ++++++-
>      tests/unit/meson.build                    |   1 +
>      tests/unit/test-uuid.c                    |  27 ++++
>      tests/unit/test-virtio-dmabuf.c           | 137 +++++++++++++++++
>      util/uuid.c                               |  14 ++
>      14 files changed, 821 insertions(+), 14 deletions(-)
>      create mode 100644 hw/display/virtio-dmabuf.c
>      create mode 100644 include/hw/virtio/virtio-dmabuf.h
>      create mode 100644 tests/unit/test-virtio-dmabuf.c
> 
>     --
>     2.40.0
> 
> 


