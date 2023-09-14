Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5907A0BBB
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgq7h-00087A-KV; Thu, 14 Sep 2023 13:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgq7e-00086C-3X
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgq7c-0003WH-Qh
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694712440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q04RWs9ZgWqGqgkxH40O901pxfLRagQWqC8H9sd54Gk=;
 b=ABh9ziM6u17eAmsxbisokl6shXwYTgB5CwJ883x2+bo/ESEuXPWUA4E+tsbMHIZjaKIVu8
 3bKTvFRhFDiccy4+DB0FpMfNyC2jScftoO5N18EOxGPsnEUcToLnf/XWwFwEtkUPlwqOd1
 CgMZqP82ixX15gTPanbyKc5LwzqgoLQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-MDOJ3IkoOP-GB-N5CAa3bQ-1; Thu, 14 Sep 2023 13:27:16 -0400
X-MC-Unique: MDOJ3IkoOP-GB-N5CAa3bQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C6F3101A550;
 Thu, 14 Sep 2023 17:27:16 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 780D940C6EA8;
 Thu, 14 Sep 2023 17:27:15 +0000 (UTC)
Date: Thu, 14 Sep 2023 12:27:13 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/4] virtio-blk: don't lock AioContext in the submission
 code path
Message-ID: <fgtwflbmonhcpxxjpsazmjskdnsp34fwgmt5jj5u3yeehxh5fv@gtwugrb4xnoo>
References: <20230914140101.1065008-1-stefanha@redhat.com>
 <20230914140101.1065008-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914140101.1065008-5-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 14, 2023 at 10:01:01AM -0400, Stefan Hajnoczi wrote:
> There is no need to acquire the AioContext lock around blk_aio_*() or
> blk_get_geometry() anymore. I/O plugging (defer_call()) also does not
> require the AioContext lock anymore.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/virtio-blk.c | 5 -----
>  1 file changed, 5 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


