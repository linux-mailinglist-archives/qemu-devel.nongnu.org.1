Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEB1719E5D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:38:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4iTu-0007Sn-P1; Thu, 01 Jun 2023 09:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4iTl-0007PY-By
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4iTg-0006UY-MQ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685626592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W3LQ83c41LxF9ylqy4nUO4fu7ooymh6S6L5vo+q+gls=;
 b=NT+BoBb1YwpuBd3g1joqn7bnaV3ugUxKeY3N3leEBNq6WqWYLRD/1bogXc/qqLqhKc0IgF
 xypWgxgWBrsI0IPYlPVlvlyP7CjpuDkFRElSDYZiB3/Qd8G3wO9pouMLmRL9IRoDMCMJ3U
 0WWI8DR9hZCRKJ69ICdCwef4d+ELmh8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-k2qGmXHxNR6GO3HBHidtAw-1; Thu, 01 Jun 2023 09:36:28 -0400
X-MC-Unique: k2qGmXHxNR6GO3HBHidtAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9566B811E88;
 Thu,  1 Jun 2023 13:36:28 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D28BC154D7;
 Thu,  1 Jun 2023 13:36:27 +0000 (UTC)
Date: Thu, 1 Jun 2023 08:36:25 -0500
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH v2 1/4] block: rename the bdrv_co_block_status static
 function
Message-ID: <a46ks2cedzkl42mc6xxm36qenia6sfigptu3eknmfhvlly5dp4@tvgoksqh2khn>
References: <20230601115131.196234-1-pbonzini@redhat.com>
 <20230601115131.196234-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601115131.196234-2-pbonzini@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 01, 2023 at 01:51:28PM +0200, Paolo Bonzini wrote:
> bdrv_block_status exists as a wrapper for bdrv_block_status_above,
> but the name of the (hypothetical) coroutine version, bdrv_co_block_status,
> is squatted by a random static function.  Rename it to bdrv_do_block_status.

bdrv_co_do_block_status

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/io.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

> @@ -2509,8 +2509,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
>      for (p = bdrv_filter_or_cow_bs(bs); include_base || p != base;
>           p = bdrv_filter_or_cow_bs(p))
>      {
> -        ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
> -                                   file);
> +        ret = bdrv_co_do_block_status(p, want_zero, offset, bytes, pnum, map, file);

Did you intend to rewrap this line at 80 columns at a different parameter?

With those minor fixes,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


