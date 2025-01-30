Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B118EA234E7
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Jan 2025 21:12:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdatB-0003v2-Cq; Thu, 30 Jan 2025 15:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdat9-0003us-R2
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:11:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdat8-0000V7-5o
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738267905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q+NQ37vl/TPyPgnq2x9aijTlcUSOU7iH95lXz+Wmsrw=;
 b=A1MjlPUWIX5yXKDNzyvAhLJhYRuxrwgDTUZssyhM/nz8PCACjrXj8Ldh2XcmbJo0YnNtmx
 tC17VbhDa343+pi3slTITPbG+LFCyMmXRHigYCi7s612byOYiLZ75XOXdtEto7nZfmMasp
 jD6LcDyThM/EMPI5lZgLBcArumSyZEE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-ow7dpCoOMyqwUP0nlAj4yg-1; Thu,
 30 Jan 2025 15:11:42 -0500
X-MC-Unique: ow7dpCoOMyqwUP0nlAj4yg-1
X-Mimecast-MFC-AGG-ID: ow7dpCoOMyqwUP0nlAj4yg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 883081801F19; Thu, 30 Jan 2025 20:11:41 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 442E51800955; Thu, 30 Jan 2025 20:11:38 +0000 (UTC)
Date: Thu, 30 Jan 2025 14:11:35 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 06/15] block: Fix crash on block_resize on inactive node
Message-ID: <2c3avkfdfd6lq3vugk4wc73gitcaqacbvigil7oqdthwejceiq@xhahvfdlojxe>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-7-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-7-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 30, 2025 at 06:12:37PM +0100, Kevin Wolf wrote:
> In order for block_resize to fail gracefully on an inactive node instead
> of crashing with an assertion failure in bdrv_co_write_req_prepare()
> (called from bdrv_co_truncate()), we need to check for inactive nodes
> also when they are attached as a root node and make sure that
> BLK_PERM_RESIZE isn't among the permissions allowed for inactive nodes.
> To this effect, don't enumerate the permissions that are incompatible
> with inactive nodes any more, but allow only BLK_PERM_CONSISTENT_READ
> for them.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c               | 7 +++++++
>  block/block-backend.c | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


