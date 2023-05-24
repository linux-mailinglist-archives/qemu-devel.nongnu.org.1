Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB16470F03B
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:09:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jXt-0007r1-Px; Wed, 24 May 2023 04:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1jXs-0007qs-1K
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1jXn-0001pf-DY
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684915706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtyDgeve/qnGaPE92shW9EZgBMKYja34N8neosaUrjA=;
 b=aSrXYIItHG0SoAUbNOmeN30HihO2b7AF42xMOeuepq5cynjIpb3h+EWgOYWcTK8ukFeupI
 sYknpFcZDbmXeLYYPbiGgLRQ+WjZAgj8YPP2ffiYH9qx6zFj01yhIu02mGdUgoJw1ATLgW
 E0O8W3v0TiUFLDn0OQ2dOS7h6roQlZE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-1yUbA_gFMeGF2qNbNtOyLw-1; Wed, 24 May 2023 04:08:24 -0400
X-MC-Unique: 1yUbA_gFMeGF2qNbNtOyLw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3094e661decso183059f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 01:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684915702; x=1687507702;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtyDgeve/qnGaPE92shW9EZgBMKYja34N8neosaUrjA=;
 b=Ik29EwPrKdB2Qud1k2pN8B8Py6BDIvf8Guhr2tIa1X6VbAoUb2pG71Gvh6Gh/p94NR
 p1OlzE0UBmdrsoqdp2cj9I33J1lq6IG58b0RW6vMxRC4eDwuyb0zHJKgAql83XFw30mI
 7UTNG5IZxZOYWRVkcBGk9qsJvLghRxj4oM5Ae39PwLeMQQkE+smdHpCZ90+qDBoQWawO
 xaoFwHy9aoKUQ7WzMLgfZ2yCsAoWbZXoVoy4HvMdrURxbCQJbC55O0a7+/b4A5OXOZWd
 FZOFCAkMCLK0U4KOx4cbwysGQQnYP0zhvx5aOxqx5fU2AR2sxBaSI9Euf9kD+eu4dLwU
 nAEg==
X-Gm-Message-State: AC+VfDxG7hlT3/AA03lTV9LPr5vdUzlsgKHk6rJ8WzCNWP3JFWB6KuRS
 K5aINfT5fOQZG7CyN8v79yXP5Nd4HoP0gHHczNcM+Gt6Xj3ZT159S3T2vyvT3+6LC8Eum8zSo7+
 5jn06P2xRD90uNdh0OPuUkQM=
X-Received: by 2002:a05:600c:2152:b0:3f6:938:1001 with SMTP id
 v18-20020a05600c215200b003f609381001mr4316375wml.8.1684915702808; 
 Wed, 24 May 2023 01:08:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OZ1cIk0Dqc8AIrN6VBJlUyMvP0RkdvvnqSAdc1TcTNBSiUtLIy6saUk6qZOkQyyZ9l92FHg==
X-Received: by 2002:a05:600c:2152:b0:3f6:938:1001 with SMTP id
 v18-20020a05600c215200b003f609381001mr4316360wml.8.1684915702550; 
 Wed, 24 May 2023 01:08:22 -0700 (PDT)
Received: from sgarzare-redhat ([134.0.5.107])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a1c6a08000000b003f41bb52834sm1408937wmc.38.2023.05.24.01.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 01:08:21 -0700 (PDT)
Date: Wed, 24 May 2023 10:08:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 xen-devel@lists.xenproject.org, 
 eblake@redhat.com, Anthony Perard <anthony.perard@citrix.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 1/6] block: add blk_io_plug_call() API
Message-ID: <dpbl4aehbrgii34tibg3pzgkdsi56vxtvk66657ksqedho3cnv@fhbd2jozlhdp>
References: <20230523171300.132347-1-stefanha@redhat.com>
 <20230523171300.132347-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230523171300.132347-2-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, May 23, 2023 at 01:12:55PM -0400, Stefan Hajnoczi wrote:
>Introduce a new API for thread-local blk_io_plug() that does not
>traverse the block graph. The goal is to make blk_io_plug() multi-queue
>friendly.
>
>Instead of having block drivers track whether or not we're in a plugged
>section, provide an API that allows them to defer a function call until
>we're unplugged: blk_io_plug_call(fn, opaque). If blk_io_plug_call() is
>called multiple times with the same fn/opaque pair, then fn() is only
>called once at the end of the function - resulting in batching.
>
>This patch introduces the API and changes blk_io_plug()/blk_io_unplug().
>blk_io_plug()/blk_io_unplug() no longer require a BlockBackend argument
>because the plug state is now thread-local.
>
>Later patches convert block drivers to blk_io_plug_call() and then we
>can finally remove .bdrv_co_io_plug() once all block drivers have been
>converted.
>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>Reviewed-by: Eric Blake <eblake@redhat.com>
>---
>v2
>- "is not be freed" -> "is not freed" [Eric]
>---
> MAINTAINERS                       |   1 +
> include/sysemu/block-backend-io.h |  13 +--
> block/block-backend.c             |  22 -----
> block/plug.c                      | 159 ++++++++++++++++++++++++++++++
> hw/block/dataplane/xen-block.c    |   8 +-
> hw/block/virtio-blk.c             |   4 +-
> hw/scsi/virtio-scsi.c             |   6 +-
> block/meson.build                 |   1 +
> 8 files changed, 173 insertions(+), 41 deletions(-)
> create mode 100644 block/plug.c

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


