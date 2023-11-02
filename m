Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 136557DF07B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:47:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyVEA-0004Kv-G6; Thu, 02 Nov 2023 06:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyVE8-0004Km-NT
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyVE7-0004Gz-9s
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698922022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oc2URs9g4uejMS7/0prw85Fkn10A8XPCd0QKL/hl97c=;
 b=RGfE2/Yg3Awhbbosb8EZlSyh46OViRLGv9NEnKvub1SsdXZTR9LBJUbeG/IC4Ju7q8WtsA
 ZX2tGh2ASBwWuEy9Kw8KLgkc3tDnHGs6VXLlPYXDMUr7bFslw6WmyD9PzLlSwOrLpOvcLQ
 VJhdOP6UvuGdwgXltRnBUVC11PaEcDc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-CYiJV61ANCCnJIMxk4bcfA-1; Thu, 02 Nov 2023 06:47:00 -0400
X-MC-Unique: CYiJV61ANCCnJIMxk4bcfA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68B55810FC0;
 Thu,  2 Nov 2023 10:47:00 +0000 (UTC)
Received: from redhat.com (unknown [10.39.195.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FDB9492BE0;
 Thu,  2 Nov 2023 10:46:58 +0000 (UTC)
Date: Thu, 2 Nov 2023 11:46:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 eblake@redhat.com, den@virtuozzo.com
Subject: Re: [PATCH v3 1/8] qemu-img: rebase: stop when reaching EOF of old
 backing file
Message-ID: <ZUN+IYdAGZg2D7pN@redhat.com>
References: <20230919165804.439110-1-andrey.drobyshev@virtuozzo.com>
 <20230919165804.439110-2-andrey.drobyshev@virtuozzo.com>
 <b19cfb5c-658f-4bf2-a872-7eaa252d68b4@tls.msk.ru>
 <676efe0e-0c13-433b-9ca5-18c14920050d@virtuozzo.com>
 <0834e809-6255-42e7-b72c-e0a21dd15901@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0834e809-6255-42e7-b72c-e0a21dd15901@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 01.11.2023 um 18:51 hat Michael Tokarev geschrieben:
> 01.11.2023 18:38, Andrey Drobyshev wrote:
> > Hi Michael,
> > 
> > Since this series is already merged in master, I'm not sure whether it's
> > necessary to forward this particular patch to qemu-stable, or it should
> > rather be cherry-picked to -stable by one of the block maintainers.
> 
> It's been my job lately to pick something up for stable, once it gets
> applied to master.  But it is usually the patch author or subsystem
> maintainer to mark a change as a candidate for -stable, - I can't decide
> about every change out there, since I don't have enough expertise in
> every area.  You Cc: qemu-stable@ and I pick it up.  I do look at stuff
> being applied to master from time to time though, and ask if I see
> something which might be worth to pick, as in this case.

I didn't even think about it for this patch, but yes, it sounds like a
candidate for stable to me.

> BTW, there's another change in this series which might be a good candidate
> too, - "qemu-img: rebase: use backing files' BlockBackend for buffer
> alignment".  Once again, I dunno if it's worth to pick it up or not,
> it's basically up to you to decide.  Basically, you understand much
> better what the implications are and if the change fixes actual bug.

It's an optimisation, I wouldn't pick that one.

Kevin


