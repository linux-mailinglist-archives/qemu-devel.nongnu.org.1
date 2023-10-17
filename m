Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D9A7CBE0F
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfkO-0003ij-Rt; Tue, 17 Oct 2023 04:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qsfkK-0003dX-MV
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qsfkI-0000go-Rs
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697532489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Onxd6Z56MJnw/gkMCiLBu0/HEs9NQeuz3rC1HQolSgs=;
 b=Qwl+SCXznr0WXY/ff18CDDeizYYll5q22W5w3eAIGPUAnkjeQ/MkAYZqTGETr9lRqHDROW
 KUxfSwrJdeEHIp6kS9dmKIXXlWkSoCYUdPgIOxc6ll2E7T7tJpozWT+4lCy/nx/CwjigE+
 F104LYMAsJaCewfHVIvqw+0gQ1PW2WQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-nG2NEPW2NfCUKTcwE24muA-1; Tue, 17 Oct 2023 04:48:06 -0400
X-MC-Unique: nG2NEPW2NfCUKTcwE24muA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA44A1C0651F;
 Tue, 17 Oct 2023 08:48:05 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31DA1492BEE;
 Tue, 17 Oct 2023 08:48:03 +0000 (UTC)
Date: Tue, 17 Oct 2023 10:48:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 2/2] virtio: Drop out of coroutine context in virtio_load()
Message-ID: <ZS5KQk1fqa+dm8yE@redhat.com>
References: <20230905145002.46391-1-kwolf@redhat.com>
 <20230905145002.46391-3-kwolf@redhat.com>
 <0f479df3-2563-4186-b83b-be1dc2fcae8a@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f479df3-2563-4186-b83b-be1dc2fcae8a@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 17.10.2023 um 07:19 hat Michael Tokarev geschrieben:
> 05.09.2023 17:50, Kevin Wolf wrote:
> > virtio_load() as a whole should run in coroutine context because it
> > reads from the migration stream and we don't want this to block.
> > 
> > However, it calls virtio_set_features_nocheck() and devices don't
> > expect their .set_features callback to run in a coroutine and therefore
> > call functions that may not be called in coroutine context. To fix this,
> > drop out of coroutine context for calling virtio_set_features_nocheck().
> ...
> > Cc: qemu-stable@nongnu.org
> > Buglink: https://issues.redhat.com/browse/RHEL-832
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> 
> It looks like this change caused an interesting regression,
>   https://gitlab.com/qemu-project/qemu/-/issues/1933
> at least in -stable.  Can you take a look please?

Huh?! This is an interesting one indeed.

I can't see any direct connection between the patch and this regression.
Random memory corruption is the only explanation I have. But I'm not
sure how this patch could cause it, it's quite simple.

The next step is probably trying to find a simple reproducer on the QEMU
level. And then maybe valgrind or we could get stack traces for the
call to virtio_set_features_nocheck_maybe_co(). Also the stack trace for
the crash and maybe the content of 's' would be interesting - we can ask
the reporter for that, the core dump should be enough for that.

Another potentially interesting question is whether after yielding, the
coroutine is indeed reentered from the aio_co_wake() call in the patch
or if something else wakes it up. If it were the latter, that could
explain memory corruption.

> BTW, Kevin, do you have account @gitlab?

Yes, @kmwolf.

Kevin


