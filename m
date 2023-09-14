Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CD27A0A8F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 18:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgoyN-0004r6-Ub; Thu, 14 Sep 2023 12:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgoyL-0004q5-Dx
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgoyB-0004Si-9b
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694708009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d5bsce2Es4w8oP8/hH+a3p63mYKl30zg7Q5oDiP7WyA=;
 b=Kd1ZuHewjBQKRI1jsGTdyBLaOpkScp+Tt/wffz9KdcguAKTtw5B528OHL+JH8sL45UxpCA
 N/vFXme0y2BbhWF1herzuUzZEo70ifSHiUjmEJa6FtOVP0TGdgyj9nkTRbgBv8uk6exhxu
 nMeisHDQRqbxXxystxnj2S6m00zun4g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-tWEVW3RpMAaLYT1DgJAlrQ-1; Thu, 14 Sep 2023 12:13:28 -0400
X-MC-Unique: tWEVW3RpMAaLYT1DgJAlrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA6BD18811A6;
 Thu, 14 Sep 2023 16:13:27 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92FD6200E4BE;
 Thu, 14 Sep 2023 16:13:21 +0000 (UTC)
Date: Thu, 14 Sep 2023 11:13:19 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/4] virtio-blk: add lock to protect s->rq
Message-ID: <rylr6nlqmm2fhvkhp2uutc2ddwwtt4xqmo3ybavbba24ifnfb4@c2bx3stypfo7>
References: <20230914140101.1065008-1-stefanha@redhat.com>
 <20230914140101.1065008-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914140101.1065008-3-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Thu, Sep 14, 2023 at 10:00:59AM -0400, Stefan Hajnoczi wrote:
> s->rq is accessed from IO_CODE and GLOBAL_STATE_CODE. Introduce a lock
> to protect s->rq and eliminate reliance on the AioContext lock.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/virtio/virtio-blk.h |  3 +-
>  hw/block/virtio-blk.c          | 67 +++++++++++++++++++++++-----------
>  2 files changed, 47 insertions(+), 23 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


