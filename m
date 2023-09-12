Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CAB79D740
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 19:09:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6sK-0002AF-RE; Tue, 12 Sep 2023 13:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qg6sA-00029R-4T
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 13:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qg6s7-0007Au-Pl
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 13:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694538498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gP0Sg7VddzAmSbBvpcymmzHX+ZR2qIRyshOMXYvbN0Q=;
 b=CAlab+Xip2Y6W+0YUQPnbmHkTVIhXPzNb8YKPqOcZ5UAVpbNSs2yW91yhX+z/8bggoyLA9
 CGnpdDxzugYYUVpwU5WJW86SEYZl1w0NEJ7pHtQfsxD5zUOJ6psNbYAg/dCQp67AZCQisK
 qdbCeL36svYfaO5m94YNimHyfB+69+8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-up99_WvHNDmF9HEo_XirFw-1; Tue, 12 Sep 2023 13:08:15 -0400
X-MC-Unique: up99_WvHNDmF9HEo_XirFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B08AB8BF4A4;
 Tue, 12 Sep 2023 17:08:14 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45F6247CD4;
 Tue, 12 Sep 2023 17:08:13 +0000 (UTC)
Date: Tue, 12 Sep 2023 19:08:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC 0/3] qmp: make qmp_device_add() a coroutine
Message-ID: <ZQCa/DxAAQnau3JR@redhat.com>
References: <20230906190141.1286893-1-stefanha@redhat.com>
 <1fa3ad95-c335-7e97-42f0-00dca5c5ba48@redhat.com>
 <20230907140006.GA1363873@fedora>
 <CABgObfZXE+AupVGZTbm-W4RXbQPBiqSAgo+U4k1Eza=U1sortA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZXE+AupVGZTbm-W4RXbQPBiqSAgo+U4k1Eza=U1sortA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 07.09.2023 um 16:25 hat Paolo Bonzini geschrieben:
> On Thu, Sep 7, 2023 at 4:00 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > While I agree that the issue would not happen if monitor commands only
> > ran in the iohandler AioContext, I don't think we can change that.
> > When Kevin implemented coroutine commands in commit 9ce44e2ce267 ("qmp:
> > Move dispatcher to a coroutine"), he used qemu_get_aio_context()
> > deliberately so that AIO_WAIT_WHILE() can make progress.
> 
> Ah, you are referring to
> 
> +        /*
> +         * Move the coroutine from iohandler_ctx to qemu_aio_context for
> +         * executing the command handler so that it can make progress if it
> +         * involves an AIO_WAIT_WHILE().
> +         */
> +        aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
> +        qemu_coroutine_yield();
> 
> > I'm not clear on the exact scenario though, because coroutines shouldn't
> > call AIO_WAIT_WHILE().
> 
> I think he meant "so that an AIO_WAIT_WHILE() invoked through a bottom
> half will make progress on the coroutine as well".

It's been a while, but I think I may have meant an AIO_WAIT_WHILE() that
is executed by someone else and that depends on the coroutine. For
example, I imagine this is what I could have seen:

1. The QMP command handler does some I/O and yields for it (like
   updating the qcow2 header for block_resize) with increased
   bs->in_flight

2. Something else calls drain, which polls qemu_aio_context, but not
   iohandler_ctx, until the request completes.

3. Nothing will ever resume the coroutine -> deadlock

> However I am not sure the comment applies here, because
> do_qmp_dispatch_bh() only applies to non-coroutine commands; that
> commit allowed monitor commands to run in vCPU threads when they
> previously weren't.
> 
> Thinking more about it, I don't like that the
> 
>     if (!!(cmd->options & QCO_COROUTINE) == qemu_in_coroutine()) {
>     }
> 
> check is in qmp_dispatch() rather than monitor_qmp_dispatch().
> 
> Any caller of qmp_dispatch() knows if it is in a coroutine or not.
> qemu-ga uses neither a coroutine dispatcher nor coroutine commands.
> QEMU uses non-coroutine dispatch for out-of-band commands (and we can
> forbid coroutine + allow-oob at the same time), and coroutine dispatch
> for the others.
> 
> So, moving out of coroutine context (through a bottom half) should be
> done by monitor_qmp_dispatch(), and likewise moving temporarily out of
> the iohandler context in the case of coroutine commands. In the case
> of !req_obj->req you don't need to do either of those. qmp_dispatch()
> can still assert that the coroutine-ness of the command matches the
> context in which qmp_dispatch() is called.
> 
> Once this is done, I think moving out of coroutine context can use a
> BH that runs in the iohandler context.

Non-coroutine handlers could probably stay in iothread_ctx, but I don't
think we can avoid switching to a different for coroutine handlers.

So maybe we can just move the rescheduling down to the coroutine case in
qmp_dispatch().

Kevin


