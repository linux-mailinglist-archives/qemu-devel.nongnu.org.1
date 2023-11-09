Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 066697E6FB6
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:52:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18FK-00085o-KE; Thu, 09 Nov 2023 11:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r18F7-0007xF-PE
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:51:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r18F4-0002Wg-IO
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699548651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CiMj46Cw3K9bbBI96dXe6jtPwye3yXuEmqZbFQjbD6Q=;
 b=M1bKNNlS2zYrysl27zVpd1ZoT+p9yo4yITfq7yH0MD12eIY4d6WixkGDOC06NEzkA9+gRs
 LwOX1hNzGdBf2NlZ/nGsadNzxV0DTsH2tfTDJa9bOtuXQH4oPWcvfnVUi2mRAvX+wFgn3y
 K+AhTCT2X7fEyKQ7WCthFBsLplNgjH8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-2NNeieEFNLm735PeiklDSA-1; Thu, 09 Nov 2023 11:50:49 -0500
X-MC-Unique: 2NNeieEFNLm735PeiklDSA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3b40deadcb7so282818b6e.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 08:50:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699548648; x=1700153448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiMj46Cw3K9bbBI96dXe6jtPwye3yXuEmqZbFQjbD6Q=;
 b=Lm7ICLz3IxKduSD/7Vr2bIb6eEhBXxA4P6BDWc7xgN3/Ihh9eUbyTY8A+TPQaQkSJX
 nEEuPWvQIVcwJbDeg8f/tNkoTIJt+W1g0MUCaRbLllFKoGpzboMS8UpO1UE9+OBOLQvP
 0Hhcsmfyi7fhSqen6XjrLb4Lq01JU2l3fJccm1/donBtI/wyAx4GgAQqMeubT2D6SAUg
 t+z4zFHNa4J2dMmK99t5WraFv8hhmeMf4aYz0rqTSniwCQ0e5k4JKyRE2ruseCKz1Rvn
 4dC7qoZJAC8+SZlAVkJdLzLtnQBgicd2zslUtsgUY84t3sQhrTQJs+QMy3fp9Vd/hHEk
 Ec3Q==
X-Gm-Message-State: AOJu0Yy8EPQ/udHnHJWvWt3DXE+QIp6OA/0gbA5641B9zKMFJ9rZS/fH
 3V5Pd4Yv8dhVfhtNmNmzu0ZQwqcrUqed+nEWnecfp2/liZ1EP0TBeFXRhSqK0nBpIH4LKCkfVdI
 Y+DFzN8aWexP+L80=
X-Received: by 2002:a05:6870:9120:b0:1e9:a8ff:67e3 with SMTP id
 o32-20020a056870912000b001e9a8ff67e3mr6504600oae.4.1699548648506; 
 Thu, 09 Nov 2023 08:50:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXAmp9Q3hyo0dqKdpRCQLyvIHqOIZ2C/fsH1CI0gIktB3NxraiCemQhUp46EYPxQ3kV1hurw==
X-Received: by 2002:a05:6870:9120:b0:1e9:a8ff:67e3 with SMTP id
 o32-20020a056870912000b001e9a8ff67e3mr6504587oae.4.1699548648151; 
 Thu, 09 Nov 2023 08:50:48 -0800 (PST)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 j2-20020a05620a0a4200b00775afce4235sm14220qka.131.2023.11.09.08.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 08:50:47 -0800 (PST)
Date: Thu, 9 Nov 2023 11:50:45 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH RFC 3/7] migration: multifd_send_kick_main()
Message-ID: <ZU0N5UGFRFUNnH2b@x1n>
References: <20231022201211.452861-1-peterx@redhat.com>
 <20231022201211.452861-4-peterx@redhat.com>
 <87zfznvp0u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfznvp0u.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Nov 08, 2023 at 07:49:53PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > When a multifd sender thread hit errors, it always needs to kick the main
> > thread by kicking all the semaphores that it can be waiting upon.
> >
> > Provide a helper for it and deduplicate the code.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/multifd.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 4afdd88602..33fb21d0e4 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -374,6 +374,18 @@ struct {
> >      MultiFDMethods *ops;
> >  } *multifd_send_state;
> >  
> > +/*
> > + * The migration thread can wait on either of the two semaphores.  This
> > + * function can be used to kick the main thread out of waiting on either of
> > + * them.  Should mostly only be called when something wrong happened with
> > + * the current multifd send thread.
> > + */
> > +static void multifd_send_kick_main(MultiFDSendParams *p)
> > +{
> > +    qemu_sem_post(&p->sem_sync);
> > +    qemu_sem_post(&multifd_send_state->channels_ready);
> > +}
> > +
> >  /*
> >   * How we use multifd_send_state->pages and channel->pages?
> >   *
> > @@ -746,8 +758,7 @@ out:
> >          assert(local_err);
> >          trace_multifd_send_error(p->id);
> >          multifd_send_terminate_threads(local_err);
> > -        qemu_sem_post(&p->sem_sync);
> > -        qemu_sem_post(&multifd_send_state->channels_ready);
> > +        multifd_send_kick_main(p);
> >          error_free(local_err);
> >      }
> >  
> > @@ -787,8 +798,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
> >       * is not created, and then tell who pay attention to me.
> >       */
> >      p->quit = true;
> > -    qemu_sem_post(&multifd_send_state->channels_ready);
> > -    qemu_sem_post(&p->sem_sync);
> > +    multifd_send_kick_main(p);
> 
> There's a bug here in the original code:
> 
> It's not really safe to call any of these outside of the channel lock
> because multifd_save_cleanup() could execute at the same time and call
> qemu_sem_destroy() -> qemu_mutex_destroy(), which can assert because we
> might be holding the sem_lock.

If you meant "p->mutex" as the "channel lock", IIUC even holding that won't
work? Because it'll also be freed in multifd_save_cleanup().



> 
> It seems the reason we get away with this today is merely due to
> timing. A subset of this problem was already encountered here:
> 
> [PATCH] migrate/multifd: fix coredump when the multifd thread cleanup
> https://lore.kernel.org/r/20230621081826.3203053-1-zhangjianguo18@huawei.com
> 
> We could probably release the semaphores for all channels at once inside
> multifd_save_cleanup() in the main thread. We'd have a
> multifd_send_kick_main() in each channel when it fails and this:
> 
> void multifd_save_cleanup(void)
> {
>     ...   
>     for (i = 0; i < migrate_multifd_channels(); i++) {
>         MultiFDSendParams *p = &multifd_send_state->params[i];
> 
>         if (p->running) {
>             qemu_thread_join(&p->thread);
>         } else {
>             multifd_send_kick_main(p);
>         }
>     }
>     for (i = 0; i < migrate_multifd_channels(); i++) {
>         qemu_sem_destroy, etc...
>     }
>     ...
> }    
> 

-- 
Peter Xu


