Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C40C97881A3
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 10:10:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRsg-0001Gu-IZ; Fri, 25 Aug 2023 04:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qZRse-0001Ek-FQ
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 04:09:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qZRsb-0004F4-VK
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 04:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692950956;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=erqCcj6MjZhniixHXB0uTHtAibJhM/PM2yhTJqWvVOI=;
 b=R+ZRixSMcsa50VwnVS/iSEny/zmYzFSWrbCcvI1sI5CNqv1JFyRHkcMyLhEvRHEohY8LcQ
 x4ZZ8vugt3TR7yYB5zbuy5GxDHyo6RZi3E1W44PnuHEAFjzDShtRdVg7N6URcjWKEagvOW
 rrraQMxAHQhDBEP6v4ar1sFXJ8y7vRo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-B7AGYNn5OlK7EsslP0ogmQ-1; Fri, 25 Aug 2023 04:09:14 -0400
X-MC-Unique: B7AGYNn5OlK7EsslP0ogmQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A51DC3806713;
 Fri, 25 Aug 2023 08:09:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBEB2140E950;
 Fri, 25 Aug 2023 08:09:11 +0000 (UTC)
Date: Fri, 25 Aug 2023 09:09:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, kwolf@redhat.com,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Leonardo Bras <leobras@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/2] io: follow coroutine AioContext in qio_channel_yield()
Message-ID: <ZOhhpVJgNxMmAMEH@redhat.com>
References: <20230823234504.1387239-1-stefanha@redhat.com>
 <20230823234504.1387239-3-stefanha@redhat.com>
 <ZOc+TXIwqs5PTiV/@redhat.com> <20230824182642.GA1698358@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824182642.GA1698358@fedora>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Aug 24, 2023 at 02:26:42PM -0400, Stefan Hajnoczi wrote:
> I've done most of the audit necessary to understand which AioContext is
> used where. The call graph is large because qio_channel_yield() is used
> internally by qio_channel_readv_full_all_eof(),
> qio_channel_writev_full_all(), and their variants. They would all need
> a new AioContext argument.

Argh, I forgot about that usage. 

> I think it's not worth passing AioContext explicitly everywhere since
> this involves a lot of code changes and more verbosity to achieve what
> we already have.

Yeah, I agree with you.

> 
> However, If you think the QIOChannel API should pass AioContext
> explicitly then I'll go ahead and make the changes.
> 
> Here is what I've explored so far:
> 
> qio_channel_readv_full_all_eof
>   mpqemu_read - should be doable
>   qio_channel_readv_all_eof
>     qio_channel_read_all_eof
>       multifd_recv_thread - NULL non-coroutine
>     vu_message_read - coroutine AioContext
>   qio_channel_readv_full_all
>     hw/virtio/vhost-user.c:backend_read() - NULL non-coroutine
>     qio_channel_readv_all
>       nbd_co_receive_offset_data_payload - coroutine AioContext
>       nbd_co_do_receive_one_chunk - coroutine AioContext
>       qio_channel_read_all
>         hw/virtio/vhost-user.c:backend_read() - NULL non-coroutine
>         tpm_emulator_unix_tx_bufs - NULL non-coroutine
>         nbd_read - ?
>         zlib_recv_pages - NULL non-coroutine
>         zstd_recv_pages - NULL non-coroutine
>         multifd_initial_recv_packet - NULL non-coroutine
>         nbd_opt_read - iohandler
>         pr_manager_helper_read - NULL non-coroutine
>         prh_read_request - coroutine AioContext
>         prh_co_entry - coroutine AioContext
>         char_socket_ping_pong - NULL non-coroutine
>       nocomp_recv_pages - NULL non-coroutine
>       test_io_thread_reader - NULL non-coroutine
> qio_channel_writev_full_all
>   mpqemu_msg_send - should be doable
>   qio_channel_writev_all
>     nbd_co_send_request - coroutine AioContext
>     hw/virtio/vhost-user.c:backend_read() - NULL non-coroutine
>     qio_channel_write_all
>       tpm_emulator_unix_tx_bufs - NULL non-coroutine
>       multifd_send_initial_packet - NULL non-coroutine
>       multifd_send_thread - NULL non-coroutine
>       nbd_write - ?
>       prh_write_response - coroutine AioContext
>       prh_co_entry - coroutine AioContext
>       char_socket_ping_pong - NULL non-coroutine
>       ppm_save - iohandler
>     qemu_fflush - ?
>     nbd_negotiate_send_meta_context - iohandler
>     nbd/server.c:nbd_co_send_iov - cooroutine AioContext
>     test_io_thread_writer - NULL non-coroutine
>   multifd_send_thread - NULL non-coroutine
> qemu_fill_buffer - ?
> 
> What do you think?
> 
> Stefan



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


