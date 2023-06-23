Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9541973B0EA
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 08:50:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCaby-0000yD-AR; Fri, 23 Jun 2023 02:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCabn-0000wv-Bt
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 02:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCabl-0006aW-FU
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 02:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687502964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psfLqAfE0Hv4N1b6wWokyZ0g+210HhVWq4ITeVKW32k=;
 b=dmZAO7SzfXEj/iiZ4Cw35u6pPIMVECA5JrhQlYqCiFuvktOr9KofAEptc1svDT5MNbj9Kx
 dt8/Oxg4kjaTorC1JJ+ymugBXkTHRAxqN7aT7Pp1K4Z6pMhpUdC9TEJcZSPn4PEd+QoGfU
 /BfOaYrwqvEaXQBd3NgX7jYe2SX7HD4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-2AJie1fzOmCIf8E2cBQogA-1; Fri, 23 Jun 2023 02:49:15 -0400
X-MC-Unique: 2AJie1fzOmCIf8E2cBQogA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f9b12b55cfso2314805e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 23:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687502954; x=1690094954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psfLqAfE0Hv4N1b6wWokyZ0g+210HhVWq4ITeVKW32k=;
 b=Ez2obNZvMsjdMVQgomw6j9LteCnsG+7P5BNFYnxMn70bPv6YAA89dD9gx3QkV+G9Ji
 rKLd0Y9jkyK9+iZmI9FTJiavUa5Qlk27L5OOLBRr8rsOOe0E+DY94tQIP4lxxzCGZF8L
 7ilmYz/fDe3kFktk62Wycv0YfgGdiR/Ee5vFqBZEfkjcV2NoFIl5ypFv4TlRBLHU80OQ
 GvADpK4UeAONZocOlj0UCfmSswQsulXiU8mjPDuuISZpAgZ8acdoqcw0eDHQ2p9UFkkY
 ihj6LaxvntLFa3xhYkt6ffayad7k9ck/eMB0FlZq2kDeW17DpcHKegZGRYYD6lgtBYdj
 y6Wg==
X-Gm-Message-State: AC+VfDw9L0kK9dIWvRrhf0eKza/Vbat73rAiSKteMpewWqhxvK1TWofW
 OMIQT9EBbYnQTJBfXCeRrg1FB4fso6g1cwzq/SG9kCSnlj4a8fNRxyDQbO/SF4jrk0wkRnOlwnF
 ofjvQnyvP1BH5Gsc=
X-Received: by 2002:a1c:4c05:0:b0:3fa:7d67:74f with SMTP id
 z5-20020a1c4c05000000b003fa7d67074fmr473861wmf.31.1687502954774; 
 Thu, 22 Jun 2023 23:49:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MvKqKLcl5/pyBuiM6a5KVY+jQri0oxVYkc2s+MCJelGGuvNqRdDAKplZ3EiaJW0UucbLnyA==
X-Received: by 2002:a1c:4c05:0:b0:3fa:7d67:74f with SMTP id
 z5-20020a1c4c05000000b003fa7d67074fmr473850wmf.31.1687502954422; 
 Thu, 22 Jun 2023 23:49:14 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 y20-20020a05600c365400b003f74eb308fasm1348644wmq.48.2023.06.22.23.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 23:49:13 -0700 (PDT)
Date: Fri, 23 Jun 2023 02:49:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@gmail.com,
 cohuck@redhat.com, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 0/4] Virtio shared dma-buf
Message-ID: <20230623024836-mutt-send-email-mst@kernel.org>
References: <20230524091333.201767-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524091333.201767-1-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 24, 2023 at 11:13:29AM +0200, Albert Esteve wrote:
> v1 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg00598.html
> v2 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04530.html
> v2 -> v3:
>     - Change UUID hash function strategy to djb
>     - Add qemu_uuid_is_equal wrapper

Posted some minor comments. Pls address and I'll merge.


> This patch covers the required steps to add support for virtio cross-device resource sharing[1],
> which support is already available in the kernel.
> 
> The main usecase will be sharing dma buffers from virtio-gpu devices (as the exporter
> -see VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID in [2]), to virtio-video (under discussion)
> devices (as the buffer-user or importer). Therefore, even though virtio specs talk about
> resources or objects[3], this patch adds the infrastructure with dma-bufs in mind.
> Note that virtio specs let the devices themselves define what a vitio object is.
> 
> These are the main parts that are covered in the patch:
> 
> - Add hash_func and key_equal_func to uuid
> - Shared resources table, to hold all resources that can be shared in the host and their assigned UUID
> - Internal shared table API for virtio devices to add, lookup and remove resources
> - Unit test to verify the API.
> - New message to the vhost-user protocol to allow backend to interact with the shared
>   table API through the control socket
> 
> Applies cleanly to 1c12355
> 
> [1] - https://lwn.net/Articles/828988/
> [2] - https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-3730006
> [3] - https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-10500011
> 
> Albert Esteve (4):
>   uuid: add hash_func and equal_func
>   virtio-dmabuf: introduce virtio-dmabuf
>   vhost-user: add shared_object msg
>   vhost-user: refactor send_resp code
> 
>  MAINTAINERS                               |   7 ++
>  docs/interop/vhost-user.rst               |  15 +++
>  hw/display/meson.build                    |   1 +
>  hw/display/virtio-dmabuf.c                |  90 +++++++++++++++++
>  hw/virtio/vhost-user.c                    |  90 ++++++++++++++---
>  include/hw/virtio/virtio-dmabuf.h         |  59 ++++++++++++
>  include/qemu/uuid.h                       |   2 +
>  subprojects/libvhost-user/libvhost-user.c |  88 +++++++++++++++++
>  subprojects/libvhost-user/libvhost-user.h |  56 +++++++++++
>  tests/unit/meson.build                    |   1 +
>  tests/unit/test-uuid.c                    |  27 ++++++
>  tests/unit/test-virtio-dmabuf.c           | 112 ++++++++++++++++++++++
>  util/uuid.c                               |  14 +++
>  13 files changed, 549 insertions(+), 13 deletions(-)
>  create mode 100644 hw/display/virtio-dmabuf.c
>  create mode 100644 include/hw/virtio/virtio-dmabuf.h
>  create mode 100644 tests/unit/test-virtio-dmabuf.c
> 
> -- 
> 2.40.0


