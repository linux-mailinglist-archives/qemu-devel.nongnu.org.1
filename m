Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C495772CF26
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 21:15:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8mzD-0005aa-U2; Mon, 12 Jun 2023 15:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q8mzC-0005aB-7d
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q8mzA-00020A-Bw
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686597230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PGDpvPBKnFYLlU+em7dtFYBnVBjeRlrb4ESIAODT5TQ=;
 b=YHaterhCWEZk28U6wNd/fR2RF5PdguRlFmF6U1r5nQRQz3XJ1QfW3Tr92JmnLLnjYbZTK3
 Eb3l1RKAo7dpsopFsg/WM0/Fv6+BfJNoDppnTLHbfLGitoeiYJWZpeJQ03YkERAJzcMI5V
 lZIVUzgiOBRYRDa8WG9uP7IsbD0nlfk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-srgltRR3NzSBVTqkMUAawg-1; Mon, 12 Jun 2023 15:13:47 -0400
X-MC-Unique: srgltRR3NzSBVTqkMUAawg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A284D85A5BA;
 Mon, 12 Jun 2023 19:13:46 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D54F492CAC;
 Mon, 12 Jun 2023 19:13:45 +0000 (UTC)
Date: Mon, 12 Jun 2023 14:13:43 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, libguestfs@redhat.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 06/24] nbd/client: Simplify cookie vs. index computation
Message-ID: <cjaslqexf3x5bgk7nghtuod443hjeay3jfbjaatarnicmvn75h@prynubowgy7r>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-7-eblake@redhat.com>
 <c85245c5-cfa9-bb52-a1a7-a260ad194b60@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c85245c5-cfa9-bb52-a1a7-a260ad194b60@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Mon, Jun 12, 2023 at 05:27:19PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 08.06.23 16:56, Eric Blake wrote:
> > Our code relies on a sentinel cookie value of zero for deciding when a
> > packet has been handled, as well as relying on array indices between 0
> > and MAX_NBD_REQUESTS-1 for dereferencing purposes.  As long as we can
> > symmetrically convert between two forms, there is no reason to go with
> > the odd choice of using XOR with a random pointer, when we can instead
> > simplify the mappings with a mere offset of 1.
> 
> Should we go further and use (uint64)-1 as a sentinel cookie value, and just use index as a cookie?  Or, using zero cookie in a wire looks too asymmetric?

I thought about that too, but in the end I decided it would require
auditing more lines of code to make sure I was catching all places
where we currently expected a zero sentinel (where some of those uses
are not obvious, because of things like hiding behind g_new0).  And
there is indeed the argument that if data corruption is going to
happen, it's harder to tell if an all-zero field on the wire was
intentional than a non-zero field.

> 
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks; for now, I'll just leave this one as-is.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


