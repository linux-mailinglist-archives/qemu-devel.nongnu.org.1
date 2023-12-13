Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD328122AA
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 00:12:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDYNT-0001j8-ID; Wed, 13 Dec 2023 18:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rDYNR-0001ir-J9
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 18:10:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rDYNP-0005E4-Pv
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 18:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702509050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HalX62OhWHGdYyXU2BzEnaXb9F+Bzu3+U2ORmUixNmI=;
 b=TNAgzyc+Pv2XEZxrbmJXXPE82SoE6sJYiJovxFuF27KcKzeVFcG8BHdL3+Y3xmuXV8Kvmk
 vIwKjC0B6jT+NKx35XGkLHIoT8l4pQduVgkcT7rU3V9adMIvIM+OtzsrYeLunWBnTwiFVR
 5+kh9647ttDogeZ8l8j1z4TUkdoxyug=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-gSYaTo6qOTym0pV1GKRTUw-1; Wed, 13 Dec 2023 18:10:48 -0500
X-MC-Unique: gSYaTo6qOTym0pV1GKRTUw-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6d9f6188d3aso7987429a34.1
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 15:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702509048; x=1703113848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HalX62OhWHGdYyXU2BzEnaXb9F+Bzu3+U2ORmUixNmI=;
 b=ERg88N+LQ/pnIVe4RI3ntlplj++e8ecgxiBG7gPvLlpQX58qXd8eiH6VLnDfVj0fSA
 vRETxSe1NAHTiyMIVx6QKZR4pe1cPGXFyb0zHhEZR4/U6kav+BsorHYd9KH3i5Ivdrdu
 XzwkfngxzrCImo7LwjM8BU+aGnYnRJeL8jpIQ6dFK9pXCctYO0ObVocQqr3p8LpzKwJj
 5LQQcXQI9fn28TKkizq5+oyxOUKxV7hCU+5oncYALwaBZhhhxGlswPF6Q7k86LfmHTho
 /ghnxLTgJazblVrNV2i9EO08uhnLxnrC6lmp2R304lELCxcJhxcGt4Qs1Y3VEVOS8gYz
 FK7w==
X-Gm-Message-State: AOJu0YxIMOn6YPXhrTFQ4c9i2PCTSYTZOiCi7C7KUMDViglBTpYSTHu7
 rVCIXDZRT6l8Tjqfvu7dDh8vDfNt09TVoJoT//I0plIIGw0F2JgtHaFULz3bN95GcpYv5MJD6pw
 gTr2RaMoTgycC0GBLKx6sCf8Wp+Dpv7A=
X-Received: by 2002:a05:6830:c7:b0:6d8:74e2:7ccc with SMTP id
 x7-20020a05683000c700b006d874e27cccmr9045856oto.39.1702509047746; 
 Wed, 13 Dec 2023 15:10:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAdhqreEmrg3et7vIef2eX12Sj8haC4ot2UclIbTb2LWtza49IG7cVlcMYb7DFLZbscXWYM2/KBTETyxQchsw=
X-Received: by 2002:a05:6830:c7:b0:6d8:74e2:7ccc with SMTP id
 x7-20020a05683000c700b006d874e27cccmr9045851oto.39.1702509047477; Wed, 13 Dec
 2023 15:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20231213211544.1601971-1-stefanha@redhat.com>
In-Reply-To: <20231213211544.1601971-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 14 Dec 2023 00:10:32 +0100
Message-ID: <CABgObfaTb8n66wqNxObnvgWdzu2=mgLHjX0fCPH99=-P918Apg@mail.gmail.com>
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fiona Ebner <f.ebner@proxmox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Dec 13, 2023 at 10:15=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
> Alternatives welcome! (A cleaner version of this approach might be to for=
bid
> cross-thread aio_set_fd_handler() calls and to refactor all
> aio_set_fd_handler() callers so they come from the AioContext's home thre=
ad.
> I'm starting to think that only the aio_notify() and aio_schedule_bh() AP=
Is
> should be thread-safe.)

I think that's pretty hard because aio_set_fd_handler() is a pretty
important part of the handoff from one AioContext to another and also
of drained_begin()/end(), and both of these things run in the main
thread.

Regarding how to solve this issue, there is a lot of
"underdocumenting" of the locking policy in aio-posix.c, and indeed it
makes running aio_set_fd_handler() in the target AioContext tempting;
but it is also scary to rely on the iothread being able to react
quickly. I'm also worried that we're changing the logic just because
we don't understand the old one, but then we add technical debt.

So, as a first step, I would take inspiration from the block layer
locking work, and add assertions to functions like poll_set_started()
or find_aio_handler(). Is the list_lock elevated (nonzero)? Or locked?
Are we in the iothread? And likewise, for each list, does insertion
happen from the iothread or with the list_lock taken (and possibly
elevated)? Does removal happen from the iothread or with list_lock
zero+taken?

After this step,  we should have a clearer idea of the possible states
of the node (based on the lists, the state is a subset of
{poll_started, deleted, ready}) and draw a nice graph of the
transitions. We should also understand if any calls to
QLIST_IS_INSERTED() have correctness issues.

Good news, I don't think any memory barriers are needed here. One
thing that we already do correctly is that, once a node is deleted, we
try to skip work; see for example poll_set_started(). This also
provides a good place to do cleanup work for deleted nodes, including
calling poll_end(): aio_free_deleted_handlers(), because it runs with
list_lock zero and taken, just like the tail of
aio_remove_fd_handler(). It's the safest possible place to do cleanup
and to take a lock. Therefore we have:

- a fast path in the iothread that runs without any concurrence with
stuff happening in the main thread

- a slow path in the iothread that runs with list_lock zero and taken.
The slow path shares logic with the main thread, meaning that
aio_free_deleted_handlers() and aio_remove_fd_handler() should share
some functions called by both.

If the code is organized this way, any wrong bits should jump out more
easily. For example, these two lines in aio_remove_fd_handler() are
clearly misplaced

    node->pfd.revents =3D 0;
    node->poll_ready =3D false;

because they run in the main thread but they touch iothread data! They
should be after qemu_lockcnt_count() is checked to be zero.

Regarding the call to io_poll_ready(), I would hope that it is
unnecessary; in other words, that after drained_end() the virtqueue
notification would be raised. Yes, virtio_queue_set_notification is
edge triggered rather than level triggered, so it would be necessary
to add a check with virtio_queue_host_notifier_aio_poll() and
virtio_queue_host_notifier_aio_poll_ready() in
virtio_queue_aio_attach_host_notifier, but that does not seem too bad
because virtio is the only user of the io_poll_begin and io_poll_end
callbacks. It would have to be documented though.

Paolo


Paolo

>
> Stefan Hajnoczi (3):
>   aio-posix: run aio_set_fd_handler() in target AioContext
>   aio: use counter instead of ctx->list_lock
>   aio-posix: call ->poll_end() when removing AioHandler
>
>  include/block/aio.h |  22 ++---
>  util/aio-posix.c    | 197 ++++++++++++++++++++++++++++++++------------
>  util/async.c        |   2 -
>  util/fdmon-epoll.c  |   6 +-
>  4 files changed, 152 insertions(+), 75 deletions(-)
>
> --
> 2.43.0
>


