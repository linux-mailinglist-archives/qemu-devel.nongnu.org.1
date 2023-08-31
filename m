Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C2478EEB0
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:32:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhmL-0000qk-Sz; Thu, 31 Aug 2023 09:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qbhmI-0000nJ-NV
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qbhmF-0000S8-CJ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693488722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OaK8IcVZICMzLRTGCC3/+Lrr46gvyxBAfgRdo29JaoM=;
 b=VIurpW4+GFN2TXR2PWupopbPm01Atev30Nj+MarhmDEuKikGwC5f32fM1kpq2nEpyQntUV
 jc8V85mOBviUVUgDuIUvg4susTG6dn3kKtFnZ98lLU0QBIneYRbit7NY4LCcgKqMKBK9g4
 xLXtK2tKD35l78vBAJYmYlNK5ve26t0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-iPyVmwKDO8yIDmE0zcEMbA-1; Thu, 31 Aug 2023 09:32:01 -0400
X-MC-Unique: iPyVmwKDO8yIDmE0zcEMbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAB3485CCE0;
 Thu, 31 Aug 2023 13:31:58 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9939B40C2063;
 Thu, 31 Aug 2023 13:31:57 +0000 (UTC)
Date: Thu, 31 Aug 2023 08:31:55 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel Berrange <berrange@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Leonardo Bras <leobras@redhat.com>, farosas@suse.de, 
 Hanna Reitz <hreitz@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 kwolf@redhat.com, 
 Coiby Xu <Coiby.Xu@gmail.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 0/4] io: follow coroutine AioContext in
 qio_channel_yield()
Message-ID: <laoon23ktbihykampsby4dupw3n7tpkuzzfkdmrtylmwrlq2kz@lmivgwlmfdwv>
References: <20230830224802.493686-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830224802.493686-1-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 30, 2023 at 06:47:58PM -0400, Stefan Hajnoczi wrote:
> v3:
> - Fix wrong copy-pasted function name in doc comment [Eric]
> - Fix "match" -> "matches" in comment [Eric]
> v2:
> - Add Patch 1 & 2 to remove unused NBD aio_context arguments and dead code [Fabiano]
> - Remove attach/detach prototypes from "io/channel.h" [Daniel]
> - Add utility function to set fd handlers [Daniel]

I'm queuing this version (and not v2) through my NBD tree.

> 
> The ongoing QEMU multi-queue block layer effort makes it possible for multiple
> threads to process I/O in parallel. The nbd block driver is not compatible with
> the multi-queue block layer yet because QIOChannel cannot be used easily from
> coroutines running in multiple threads. This series changes the QIOChannel API
> to make that possible.
> 
> Stefan Hajnoczi (4):
>   nbd: drop unused nbd_receive_negotiate() aio_context argument
>   nbd: drop unused nbd_start_negotiate() aio_context argument
>   io: check there are no qio_channel_yield() coroutines during
>     ->finalize()
>   io: follow coroutine AioContext in qio_channel_yield()

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


