Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 035B47B69F1
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 15:15:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnfDY-0006Ws-Rj; Tue, 03 Oct 2023 09:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnfDX-0006Vj-2n
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnfDU-0000f8-4P
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696338814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jHk6Rr16a1LOwWIdrCC05PI1KU+eOkIS3AMPOVD4AcM=;
 b=eRQCpTGLGVL9x8WNqi9d92dnWWl1pRkvi4b5mJR52uvQGS8pcARQXloCalzT7R3MMNyAKC
 UwvHtMNJvxB3KMJw0gnBeOE/dlJaGkxIXn+T6G8IZtZ2DrmKliNvpo/CwEbmdSvvM6e6xe
 Z9Aj4ARo1K8IjRjQNDLCMucmwY4rV68=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-gueCJeFCMkGOmj5ws2T9vA-1; Tue, 03 Oct 2023 09:13:33 -0400
X-MC-Unique: gueCJeFCMkGOmj5ws2T9vA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31f79595669so1764599f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 06:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696338812; x=1696943612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHk6Rr16a1LOwWIdrCC05PI1KU+eOkIS3AMPOVD4AcM=;
 b=JMyeOuFuVkTJujQ4HB44319iMjdu8xJHg0A7zUOWLOxIzidtpR72I5sAtCII2wbDZX
 k/7DLzox33IK3HPQpyyMcdmQhEo0uTNMMaAWfaZ88wdZeyU1JANmDrAn/faAm0pENXiC
 3jNYrR713t/KCATsGD0Kg7AqMNHCa7YJK/7DYUTq+eyaOTpqY7XpOqcGADHC0JpTvmai
 mcg/uLYVHK490bsQ8QTdlCDE1PUJr+zOM0AdigTZVr0luklFywZNXs17zp9KnDLy5015
 LOPNSnduVFiCu0jvSlEAZepdLEmh/rO4GMYUeUOjPDOg4ZlEppFoD1762dTxln3s7C0m
 V6lQ==
X-Gm-Message-State: AOJu0YzRUyK+i1rsh3aiijZM7xJdLkwKcH+oNqMtMRRMUsQmNbsj8Isg
 YVBH4FbVb0sGcjpZMxJYptSiJCz5Cofm45UUQm+jQOB5hszXM3Y+UySYP7n5Li+Tg1TCWMbeBpZ
 Pz0EeMGvL+TXEtm4=
X-Received: by 2002:adf:db4d:0:b0:318:720c:bb3 with SMTP id
 f13-20020adfdb4d000000b00318720c0bb3mr1962874wrj.20.1696338812054; 
 Tue, 03 Oct 2023 06:13:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrbNnX4S+17+bq8+RYrr37Nd1cy0DPOeiM96qXIi8KBvp/EcaOii5OYI/RDdwufvK+nQvi5Q==
X-Received: by 2002:adf:db4d:0:b0:318:720c:bb3 with SMTP id
 f13-20020adfdb4d000000b00318720c0bb3mr1962845wrj.20.1696338811674; 
 Tue, 03 Oct 2023 06:13:31 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 a10-20020adfeeca000000b0032008f99216sm1551925wrp.96.2023.10.03.06.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 06:13:30 -0700 (PDT)
Date: Tue, 3 Oct 2023 09:12:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 0/2] virtio-blk: add iothread-vq-mapping parameter
Message-ID: <20231003091237-mutt-send-email-mst@kernel.org>
References: <20230918161604.1400051-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918161604.1400051-1-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 18, 2023 at 12:16:02PM -0400, Stefan Hajnoczi wrote:
> virtio-blk and virtio-scsi devices need a way to specify the mapping between
> IOThreads and virtqueues. At the moment all virtqueues are assigned to a single
> IOThread or the main loop. This single thread can be a CPU bottleneck, so it is
> necessary to allow finer-grained assignment to spread the load. With this
> series applied, "pidstat -t 1" shows that guests with -smp 2 or higher are able
> to exploit multiple IOThreads.
> 
> This series introduces command-line syntax for the new iothread-vq-mapping
> property is as follows:
> 
>   --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothread":"iothread0","vqs":[0,1,2]},...]},...'
> 
> IOThreads are specified by name and virtqueues are specified by 0-based
> index.
> 
> It will be common to simply assign virtqueues round-robin across a set
> of IOThreads. A convenient syntax that does not require specifying
> individual virtqueue indices is available:
> 
>   --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothread":"iothread0"},{"iothread":"iothread1"},...]},...'
> 
> There is no way to reassign virtqueues at runtime and I expect that to be a
> very rare requirement.
> 
> Note that JSON --device syntax is required for the iothread-vq-mapping
> parameter because it's non-scalar.
> 
> Based-on: 20230912231037.826804-1-stefanha@redhat.com ("[PATCH v3 0/5] block-backend: process I/O in the current AioContext")


Acked-by: Michael S. Tsirkin <mst@redhat.com>

More of a block thingy so pls use that tree.

> Stefan Hajnoczi (2):
>   qdev: add IOThreadVirtQueueMappingList property type
>   virtio-blk: add iothread-vq-mapping parameter
> 
>  qapi/virtio.json                    |  30 +++++
>  hw/block/dataplane/virtio-blk.h     |   3 +
>  include/hw/qdev-properties-system.h |   4 +
>  include/hw/virtio/virtio-blk.h      |   2 +
>  hw/block/dataplane/virtio-blk.c     | 163 +++++++++++++++++++++-------
>  hw/block/virtio-blk.c               |  92 ++++++++++++++--
>  hw/core/qdev-properties-system.c    |  47 ++++++++
>  7 files changed, 287 insertions(+), 54 deletions(-)
> 
> -- 
> 2.41.0


