Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DAA78D029
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:16:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7my-0000lG-Dx; Tue, 29 Aug 2023 19:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qb3WW-0007Kw-Mu
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qb3WQ-0007nb-6D
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693333981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dq0BSKP+wD0jwwBtnBMuCO6RVSdGVf6XErj22Bt5a8c=;
 b=QQO5FtYH7RVCJUCa5+Rx6SApdu4Nmf+vH1kwmQOskNiB5Ykcl+swK2eDzfrDYzzC1OGdcZ
 OSwex+lTIpVejyZ9nI53EkL2Vf9ibWSz4J99sWkHQOiD6Dk9IB4c2BqCII4Dfr6GQscQB4
 WxRdHvRxsLyouuMpEeFbFWXcsQfqd0A=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-KbSYU-52N_W32xbXlk7Mng-1; Tue, 29 Aug 2023 14:32:57 -0400
X-MC-Unique: KbSYU-52N_W32xbXlk7Mng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68F821C05EBA;
 Tue, 29 Aug 2023 18:32:57 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 473A5140E962;
 Tue, 29 Aug 2023 18:32:56 +0000 (UTC)
Date: Tue, 29 Aug 2023 13:32:50 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, farosas@suse.de,
 kwolf@redhat.com, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 2/4] nbd: drop unused nbd_start_negotiate()
 aio_context argument
Message-ID: <5qrn6pdc2p4xhj77lbudqv6rvwbpfnc7n6acmnmxqykjubu2zw@s5oh7bpimkhi>
References: <20230829160623.277411-1-stefanha@redhat.com>
 <20230829160623.277411-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829160623.277411-3-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 29, 2023 at 12:06:20PM -0400, Stefan Hajnoczi wrote:
> aio_context is always NULL, so drop it.
> 
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  nbd/client.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


