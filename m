Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE376715A29
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vfp-00036S-3N; Tue, 30 May 2023 05:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q3vfn-000364-5l
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q3vfk-0007Fr-Mn
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685438983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6l0AhpgZh3s1w3/udsfaDrXpEkDMyC8VjpGGgpVzb4=;
 b=iIhpHiAmA2eUyKKSnMuAa8YJWUh8QXPvDnVYDGX79N0KLjL/sTuSfitY8aRCXc3g0gNo44
 Gt8z8rXSpl4iF60bLI1GYKSEiN+rH31TMiS95Dn9bL/gjI/wVqvdvxfNscJdl9BUvaYTh7
 oSBxxVVnIWDWtEvsYIO3Qg243FL5D2g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-cvbecjCUPZmygvRk1mRkgg-1; Tue, 30 May 2023 05:29:41 -0400
X-MC-Unique: cvbecjCUPZmygvRk1mRkgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EF3F381494A;
 Tue, 30 May 2023 09:29:41 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF01140C6EC4;
 Tue, 30 May 2023 09:29:40 +0000 (UTC)
Date: Tue, 30 May 2023 11:29:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: stable-8.0: block/export: call blk_set_dev_ops and Fix null
 pointer dereference in error path
Message-ID: <ZHXCA+bejh+7z3Gu@redhat.com>
References: <f4d89121-1b31-ae77-0ea9-67df940d2f15@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4d89121-1b31-ae77-0ea9-67df940d2f15@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 29.05.2023 um 23:24 hat Michael Tokarev geschrieben:
> Hi!
> 
> For some reason I picked up this commit:
> 
> commit de79b52604e43fdeba6cee4f5af600b62169f2d2
> Author: Stefan Hajnoczi <stefanha@redhat.com>
> Date:   Tue May 2 17:11:19 2023 -0400
> 
>     block/export: call blk_set_dev_ops(blk, NULL, NULL)
> 
> for stable-8.0.1.  However it turned out it fails iotests, up until
> the fix, which is
> 
> commit a184563778f2b8970eb93291f08108e66432a575
> Author: Kevin Wolf <kwolf@redhat.com>
> Date:   Wed May 10 22:35:55 2023 +0200
> 
>     block/export: Fix null pointer dereference in error path
> 
> It's a good question why I picked the first one up to begin
> with, but now, especially after not realizing iotests are not
> run within CI framework automatically - I ended up with broken
> v8.0.1 which I tagged earlier today.
> 
> What do you think, what is better for 8.0.1 - to revert first
> commit or to add second on top?

Both look like valid options.

But if you want a concrete recommendation from me... I would assume that
you picked it up for a reason even if you don't remember it now (maybe
it was a dependency of something else?). It also claims to be fixing two
other commits. So I think my tendency would be to pick the second one
additionally.

Kevin


