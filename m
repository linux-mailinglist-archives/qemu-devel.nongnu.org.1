Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 913CC84D346
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Feb 2024 21:54:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXouj-0007w0-Bw; Wed, 07 Feb 2024 15:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXoui-0007vm-1K
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:53:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXouf-0005Ni-Fh
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707339173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oVxxakaHNHa5CM/m6xHS2gSVkA+xOXvlRnbAxgQDvc=;
 b=T98il4NSPAhoUQhxnQK9OjsPyXKM0XVAbKuGGzy1KGBrUS70p4XpPglviSuPurWvCGYQeP
 VQc32QZNULFKzm9lB4S/GBulGnNxDFyS+G/bf0+bisan2to+S6ct7MOpUMI5KlIU9+Kkar
 SyzsCV1KkHQDB6UPXgrvkFge2oAXZJI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-ChLHvZzMM3ywHKXqyVpYow-1; Wed,
 07 Feb 2024 15:52:50 -0500
X-MC-Unique: ChLHvZzMM3ywHKXqyVpYow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9250729AC00E;
 Wed,  7 Feb 2024 20:52:49 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26CAA4011FF1;
 Wed,  7 Feb 2024 20:52:47 +0000 (UTC)
Date: Wed, 7 Feb 2024 21:52:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 0/3] virtio: Re-enable notifications after drain
Message-ID: <ZcPtmYx1vb_JIs4S@redhat.com>
References: <20240202153158.788922-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202153158.788922-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 02.02.2024 um 16:31 hat Hanna Czenczek geschrieben:
> Hanna Czenczek (3):
>   virtio-scsi: Attach event vq notifier with no_poll
>   virtio: Re-enable notifications after drain
>   virtio-blk: Use ioeventfd_attach in start_ioeventfd
> 
>  include/block/aio.h   |  7 ++++++-
>  hw/block/virtio-blk.c | 21 ++++++++++-----------
>  hw/scsi/virtio-scsi.c |  7 ++++++-
>  hw/virtio/virtio.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+), 13 deletions(-)

Thanks, applied to the block branch.

Kevin


