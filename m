Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C51C5B2DA55
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Aug 2025 12:48:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uogLo-0002OE-7l; Wed, 20 Aug 2025 06:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uogLl-0002Ny-Jo
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 06:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uogLi-0004e9-Kw
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 06:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755686840;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4T3uE8x8REJmVdBfTwhN+aQ18WSOXNAlm07/HYRwO8Q=;
 b=PjZyu4N2Ol8/cJMNFdiiTbyQfvD4XCiC2g4bFC2tl3NLwCO7XFgEZMVBdbQ1dLC2GZomCS
 y35II6EME24rRFzVrKEeI3N70HCKCjQEL4tU7wXjg5TLt7d23Tt2DvTc0dcwla/SxJnTAH
 CItLOTbDskTRlAKukIR/+aVIN+3J/14=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-VYqp0yCwPg-qnhsHVmiORA-1; Wed,
 20 Aug 2025 06:47:17 -0400
X-MC-Unique: VYqp0yCwPg-qnhsHVmiORA-1
X-Mimecast-MFC-AGG-ID: VYqp0yCwPg-qnhsHVmiORA_1755686836
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF46D1802AB7; Wed, 20 Aug 2025 10:47:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F09E0300019F; Wed, 20 Aug 2025 10:47:09 +0000 (UTC)
Date: Wed, 20 Aug 2025 11:47:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Stefan Weil <sw@weilnetz.de>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 05/12] util: add API to fetch the current thread id
Message-ID: <aKWnqqSdt0CFctcZ@redhat.com>
References: <20250819202708.1185594-1-berrange@redhat.com>
 <20250819202708.1185594-6-berrange@redhat.com>
 <aKUKPsen9jOvi_O0@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKUKPsen9jOvi_O0@gallifrey>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 19, 2025 at 11:35:26PM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > For logging it is useful to include the current thread id. On
> > POSIX there is no standard API for this, so try the Linux gettid()
> > syscall preferentially, otherwise fallback to casting the result
> > of thread_self() to an integer.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  include/qemu/thread.h    |  1 +
> >  util/qemu-thread-posix.c | 11 +++++++++++
> >  util/qemu-thread-win32.c |  5 +++++
> >  3 files changed, 17 insertions(+)
> > 
> > diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> > index 3a286bb3ef..96eee82679 100644
> > --- a/include/qemu/thread.h
> > +++ b/include/qemu/thread.h
> > @@ -215,6 +215,7 @@ void *qemu_thread_join(QemuThread *thread);
> >  void qemu_thread_get_self(QemuThread *thread);
> >  bool qemu_thread_is_self(QemuThread *thread);
> >  G_NORETURN void qemu_thread_exit(void *retval);
> > +uint64_t qemu_thread_get_id(void);
> >  
> >  struct Notifier;
> >  /**
> > diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> > index 121d7ed69b..f240a93632 100644
> > --- a/util/qemu-thread-posix.c
> > +++ b/util/qemu-thread-posix.c
> > @@ -532,3 +532,14 @@ void *qemu_thread_join(QemuThread *thread)
> >      }
> >      return ret;
> >  }
> > +
> > +uint64_t qemu_thread_get_id(void)
> > +{
> > +#ifdef CONFIG_GETTID
> > +    return (uint64_t)gettid();
> > +#elif defined(SYS_gettid)
> > +    return (uint64_t)syscall(SYS_gettid);
> > +#else
> > +    return (uint64_t)pthread_self();
> 
> My reading of the manpage is that is not guaranteed to be castable.
> It also explicitly says it's not the same as gettid.  Albeit probably is.

Yeah, technically pthread_t could be a struct. Guess it depends how much
we care about strict standards portability, vs portability to our tested
set of platforms (macOS, *BSD)[1]. We could hardcode to 0 as an alternative.

With regards,
Daniel

[1] admittedly i've not actually compile tested this yet on non-Linux,
    aside from Windows which uses the non-pthreads code.
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


