Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F267A7F440C
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 11:40:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5kdC-0007Jh-Sn; Wed, 22 Nov 2023 05:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r5kdA-0007JP-TS
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 05:38:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r5kd9-00032R-7D
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 05:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700649530;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WuprI4wwMpGYywoXLzdlYmBGZhawH04hckdWscLohrg=;
 b=VT4ase6K+ta/dgZM5UoytXw4gIgmQ10FDC9slMHH09QGN+oMkc7X1wYMqYGoydiOfZHL0h
 JS3VTOAzMpST7RoTr0XObHd9F09rMP6NMKrEOmfSMJ0hPxlHX5K+4tS4yWTvOwNTumuSAw
 vV0nZdCkAQhxQUTENabDhUgG57OBRZw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-ElYpTiz8MEiJDUk5VYIWQw-1; Wed, 22 Nov 2023 05:38:47 -0500
X-MC-Unique: ElYpTiz8MEiJDUk5VYIWQw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 747FA811E88;
 Wed, 22 Nov 2023 10:38:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 077A3492BE0;
 Wed, 22 Nov 2023 10:38:43 +0000 (UTC)
Date: Wed, 22 Nov 2023 10:38:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 qemu-arm@nongnu.org, Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: Re: [PATCH-for-8.2 v4 10/10] hw/char/pl011: Implement TX FIFO
Message-ID: <ZV3aMYohaUsg5gWx@redhat.com>
References: <20231109192814.95977-1-philmd@linaro.org>
 <20231109192814.95977-11-philmd@linaro.org>
 <CAJ+F1CKFFU_VEA4nhgWw9RLDgc_gD0h-FPfvSP4LaFC1j4pP6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKFFU_VEA4nhgWw9RLDgc_gD0h-FPfvSP4LaFC1j4pP6Q@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Nov 22, 2023 at 02:31:29PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Nov 9, 2023 at 11:30 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
> >
> > If the UART back-end chardev doesn't drain data as fast as stdout
> > does or blocks, buffer in the TX FIFO to try again later.
> >
> > This avoids having the IO-thread busy waiting on chardev back-ends,
> > reported recently when testing the Trusted Reference Stack and
> > using the socket backend:
> > https://linaro.atlassian.net/browse/TRS-149?focusedCommentId=149574
> >
> > Implement registering a front-end 'watch' callback on back-end
> > events, so we can resume transmitting when the back-end is writable
> > again, not blocking the main loop.
> 
> I do not have access to that Jira issue.
> 
> In general, chardev backends should have some buffering already
> (socket, files etc).
> 
> If we want more, or extra control over buffering, maybe this should be
> implemented at the chardev level, rather than each frontend implement
> its own extra buffering logic...
> 
> Regardless, I think frontends should have an option to "drop" data
> when the chardev/buffer is full, rather than hanging.

Does anyone really want data to be dropped by QEMU ? Every time I've seen
a scenario where data has been dropped or lost, it has been considered
a bug to be solved.

Sure, we don't want QEMU to block on chardev writes, but we want that
more than throwing away data.

What's the use case for capturing data from the serial port, but throwing
it away if the other end of a socket doesn't read quickly enough ?

If someone does want lossy serial ports, they could configure the UDP
charedev backend already.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


