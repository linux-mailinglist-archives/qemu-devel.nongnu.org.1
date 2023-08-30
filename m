Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2D078D793
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:23:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNxm-0006uq-R8; Wed, 30 Aug 2023 12:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbNxk-0006ue-MA
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbNxi-0005wa-AL
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693412553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zYremA7+3O409HZ258Uz+eSqFuAvqxGAl0QW8PH44TE=;
 b=FtY7ghWmyxp29S7lOiK5rNRhbWCUVUNldU2deDpaTX/yDKEkFIwe2LwMvDNnTPr+lmPcx0
 olbN5HxA7RFwkHMewwz2hxFwj9srD+uQUgPe3yMLiJXbD4pOH6j3BgIrHw4eNRTRJx5c1P
 2Z9irb72FVlJwuOo2xz9zUOvn00WK38=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-LculeX38OruvnP6TOU67NQ-1; Wed, 30 Aug 2023 12:22:31 -0400
X-MC-Unique: LculeX38OruvnP6TOU67NQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76f025ed860so68708085a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693412550; x=1694017350;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYremA7+3O409HZ258Uz+eSqFuAvqxGAl0QW8PH44TE=;
 b=PqhVu0mGlJLkmjrM3Cpwyn7z1D3kMJUuVxxk4uH+rRnjQcE+pmGEOc6NAOFW7GDN9Y
 l428/BcYz1tU2imVRJcZDP9hSiSY6w2I8Q8sN1kSpHVK5jnwndB8NBOMNErkEBjTk3zv
 QIdcvPHUJHkxkhu7EJvcw5zbvuVJPNBbKPP/fnT//fpzjbvGR+ZOfJPyEYGHiUMaIScA
 oAIQYZbCqeGLpqj3GR1zQ/UnPyfCfcoJ0vDyJIebapK0YHRUAX/0T/zq9Wg8s5/Ome+t
 QxLZ5QmBjyM4UpWKpU+hq7QtxHhkakwBGI7zTAA7quUh+FzDbZc59AlFxSHAUi2fuUtQ
 9bIg==
X-Gm-Message-State: AOJu0Yx242lWMhqkLnxSEIZePJOF4p431Z1HhQGDjySt7HlNatHWB9i/
 z0ncS7MQFM0kxfN4egFQY8JXftO0RhKMQLiSJ/QCpSgQjycASt03LRW9FdfDtHjuwot7PSzGQR7
 7IXOWGg7hYFY4qPE=
X-Received: by 2002:a05:620a:1a8f:b0:76c:a3bb:f8c0 with SMTP id
 bl15-20020a05620a1a8f00b0076ca3bbf8c0mr2793011qkb.0.1693412550611; 
 Wed, 30 Aug 2023 09:22:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVAGVrS9k7LOG53z/I9excLs2lnLgbPiv5hRVATGdGrXRKGfbrftqwXVNU4fmu+6hvw+jH6w==
X-Received: by 2002:a05:620a:1a8f:b0:76c:a3bb:f8c0 with SMTP id
 bl15-20020a05620a1a8f00b0076ca3bbf8c0mr2792989qkb.0.1693412550282; 
 Wed, 30 Aug 2023 09:22:30 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b16-20020a05620a119000b00765ab6d3e81sm3870425qkk.122.2023.08.30.09.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 09:22:30 -0700 (PDT)
Date: Wed, 30 Aug 2023 12:22:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V4 04/11] migration: preserve suspended for snapshot
Message-ID: <ZO9swx34WPRS/cJZ@x1n>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1693333086-392798-5-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Aug 29, 2023 at 11:17:59AM -0700, Steve Sistare wrote:
> Restoring a snapshot can break a suspended guest.
> 
> If a guest is suspended and saved to a snapshot using savevm, and qemu
> is terminated and restarted with the -S option, then loadvm does not
> restore the guest.  The runstate is running, but the guest is not, because
> vm_start was not called.  The root cause is that loadvm does not restore
> the runstate (eg suspended) from global_state loaded from the state file.
> 
> Restore the runstate, and allow the new state transitions that are possible.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/savevm.c | 1 +
>  softmmu/runstate.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index eba3653..7b9c477 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3194,6 +3194,7 @@ bool load_snapshot(const char *name, const char *vmstate,
>      }
>      aio_context_acquire(aio_context);
>      ret = qemu_loadvm_state(f);
> +    migrate_set_runstate();

I see that some load_snapshot() callers manage the vm states on their own.
Take snapshot_load_job_bh() as an example:

    s->ret = load_snapshot(s->tag, s->vmstate, true, s->devices, s->errp);
    if (s->ret && orig_vm_running) {
        vm_start();
    }

I assume you wanted to unify the state changes here.  Need to fix the
callers too?

>      migration_incoming_state_destroy();
>      aio_context_release(aio_context);
>  
> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
> index f3bd862..21d7407 100644
> --- a/softmmu/runstate.c
> +++ b/softmmu/runstate.c
> @@ -77,6 +77,8 @@ typedef struct {
>  
>  static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
> +    { RUN_STATE_PRELAUNCH, RUN_STATE_PAUSED },
> +    { RUN_STATE_PRELAUNCH, RUN_STATE_SUSPENDED },
>  
>      { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
>      { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },

Many of the call sites also starts loadvm under RUN_STATE_RESTORE_VM.  Do
we need more entries for that?

-- 
Peter Xu


