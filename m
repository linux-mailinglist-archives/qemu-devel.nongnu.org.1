Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5E17B1FA6
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 16:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qls59-0000iF-4n; Thu, 28 Sep 2023 10:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qls53-0000hL-Uc
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qls52-0001Uo-4j
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695911607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cRuhZ2cVNwXFM9ew53bX33CeBuy9ka/VN+tiyDpS8iw=;
 b=d5A1QfHQY1PKWwnVzTYvJS1KDscS19UKbh3QjibvB+r6oZuYH39qP3aDTRJW8oXbfbMEmd
 kLHWcoZk2NUZbt1v54+bxM/ob8Mvi5/f+HPD6uQajCHV+t6Vu2r/1CDHMjr8m5l3mdK+vj
 ZCMErSM94IkznEucjJDjxoi4V7ua8KQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-WFP0E7YXMBq3-UqEMw11PA-1; Thu, 28 Sep 2023 10:33:24 -0400
X-MC-Unique: WFP0E7YXMBq3-UqEMw11PA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0385101CC61;
 Thu, 28 Sep 2023 14:33:23 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8FFE215670B;
 Thu, 28 Sep 2023 14:33:22 +0000 (UTC)
Date: Thu, 28 Sep 2023 09:33:20 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH v7 01/12] nbd/server: Support a request payload
Message-ID: <2wnkvptrbyhfvvbkfubohfnfr4prkgzfjus3hh3cl3j4irmhjd@iv2hnge4fn63>
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-15-eblake@redhat.com>
 <523f5553-b62d-3e24-6fc7-8a350f2b6606@yandex-team.ru>
 <yi725wlzhqhumdyv7wswuubpprae5py5nuhl2fepdgx5ojo5np@d366mhjatqxc>
 <b21eccea-0e95-3ac3-96d2-4d9c9e085a15@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b21eccea-0e95-3ac3-96d2-4d9c9e085a15@yandex-team.ru>
User-Agent: NeoMutt/20230517-449-a10573
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On Thu, Sep 28, 2023 at 12:09:51PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 27.09.23 18:59, Eric Blake wrote:
> > We could also try to be a bit more complicated by peeking at the next
> > few bytes: if they look like a magic number of the next request,
> > assume the client set the bit accidentally but didn't send a payload
> > after all; for anything else, assume the client did pass a payload.
> > But adding in machinery to peek at a prefix is more complex than
> > either assuming a payload is always present (as done in this patch) or
> > assuming the bit was in error (and dropping the connection
> > unconditionally).  Preferences?
> 
> 
> Ohh, you are right, thanks for comprehensive explanation. I really missed some things you are saying about. Yes, now I agree that "payload always exist when flag is set" is the best effort. Finally, that was our aim of the protocol design: make it more context independent. Probably, we may fix that in specification as preferable or at least possible server behavior about non-compliant client.

One other possibility I just thought of: have a heuristic where the
flag set with h->request_length less than 512 bytes is likely to
indicate an intentional payload (even if for a command where we
weren't expecting payload, so still a client error); while the flag
set wtih h->request_length >= 512 bytes is likely to be a mistaken
setting of the flag (but also still a client error).  NBD_CMD_WRITE is
probably the only command that will ever need to send a payload larger
than one sector, but that command already has handling to accept
payloads of all sizes because we know what to do with them and where
the client is not in error.

> 
> r-b coming soon, I just need to take another look with corrected picture in mind.
> 
> -- 
> Best regards,
> Vladimir
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


