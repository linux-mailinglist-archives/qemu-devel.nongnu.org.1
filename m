Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC677FFE59
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 23:12:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8pFD-0003pg-9F; Thu, 30 Nov 2023 17:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8pFA-0003pX-3H
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 17:10:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8pF8-0006b2-4S
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 17:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701382245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sIKFMbVheVFpCUwDzLVHjBcqkbg28uW28HyrlxBcNr0=;
 b=V5ctfbof7/NCuXhMerPQEmQ//97JYgOiMt3ruu/T5ijwCcx9cEbhRCtPrqkGdrgD6ZUUxh
 /FIqfMcICnOc0XOEWGZ9gVs8wPC2CohUlADaVZpZGlpojYXNzE//FxH0xhsQDFIJJ695yt
 4hBQsM7/b5ku9CdMp4gObj997BAiTcs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-hzt5kiSGPcu_7559lAaBWA-1; Thu, 30 Nov 2023 17:10:35 -0500
X-MC-Unique: hzt5kiSGPcu_7559lAaBWA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-423f3c6c904so3743831cf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 14:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701382234; x=1701987034;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIKFMbVheVFpCUwDzLVHjBcqkbg28uW28HyrlxBcNr0=;
 b=uX5k7Cpg/x5XRNNDZRKaXI451eIifB4cVmyYkJc3IVTYL4pyJNe/aTSBlJl/I1jhJC
 8EqGgq/pRwHHEs9eNfL81phg26P9ml7ahB8RTJhbIaH+pvoVP8UG8doXlzs5S5rMiyWK
 QQ+s+WNeSx4ZAfa1QW0ezFg2hOAteIX1vIdzq8OWi0W7nKYOH9tglSMifm/zOzev4mXy
 LaVOyMQviJIL5muobmFbQRvd0NufcedjNTek6iMBhf6Sp/E+MV3vGcQKRar33ToUrPhz
 +Ub3+rpOb/Q2TuE9/qzgNisKK4U6z0bbdPMolzAtqtmhwG30uBdLXJqysUKwxDsZ/8mr
 9ldQ==
X-Gm-Message-State: AOJu0Yzzr/yFB6wH6nt4nwfvi/4FotNult5YdxfNWsH4brsM7L1lOpuV
 zzZcTpmYSsGOFQ+N3LigMX80pvmLK88rwcTnoqWHOLrMzpzk+syX2X/O+sA33T6q2BYq28wf3FZ
 qR1+8v7cUPcd8xHI=
X-Received: by 2002:a05:622a:4d03:b0:423:a6c5:1923 with SMTP id
 fd3-20020a05622a4d0300b00423a6c51923mr3670760qtb.4.1701382234525; 
 Thu, 30 Nov 2023 14:10:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJLeZQ0d+VmKp9AHRBoU44NJK07H6G/+3W9CVLTkVL3w6y7Had4N5Bwq4Gx3gGAazxz13EDA==
X-Received: by 2002:a05:622a:4d03:b0:423:a6c5:1923 with SMTP id
 fd3-20020a05622a4d0300b00423a6c51923mr3670745qtb.4.1701382234235; 
 Thu, 30 Nov 2023 14:10:34 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 w3-20020ac86b03000000b003f6ac526568sm878733qts.39.2023.11.30.14.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 14:10:33 -0800 (PST)
Date: Thu, 30 Nov 2023 17:10:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH V6 03/14] cpus: stop vm in suspended runstate
Message-ID: <ZWkIV1k7n7xW5doM@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-4-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1701380247-340457-4-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Nov 30, 2023 at 01:37:16PM -0800, Steve Sistare wrote:
> Currently, a vm in the suspended state is not completely stopped.  The VCPUs
> have been paused, but the cpu clock still runs, and runstate notifiers for
> the transition to stopped have not been called.  This causes problems for
> live migration.  Stale cpu timers_state is saved to the migration stream,
> causing time errors in the guest when it wakes from suspend, and state that
> would have been modified by runstate notifiers is wrong.
> 
> Modify vm_stop to completely stop the vm if the current state is suspended,
> transition to RUN_STATE_PAUSED, and remember that the machine was suspended.
> Modify vm_start to restore the suspended state.
> 
> This affects all callers of vm_stop and vm_start, notably, the qapi stop and
> cont commands.  For example:
> 
>     (qemu) info status
>     VM status: paused (suspended)
> 
>     (qemu) stop
>     (qemu) info status
>     VM status: paused
> 
>     (qemu) cont
>     (qemu) info status
>     VM status: paused (suspended)
> 
>     (qemu) system_wakeup
>     (qemu) info status
>     VM status: running

So system_wakeup for a stopped (but used to be suspended) VM will fail
directly, not touching vm_was_suspended.  It's not mentioned here, but that
behavior makes sense to me.

> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Since you touched qapi/, please copy maintainers too.  I've copied Markus
and Eric in this reply.

I also have some nitpicks which may not affect the R-b, please see below.

> ---
>  include/sysemu/runstate.h |  5 +++++
>  qapi/misc.json            | 10 ++++++++--
>  system/cpus.c             | 19 ++++++++++++++-----
>  system/runstate.c         |  3 +++
>  4 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index f6a337b..1d6828f 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -40,6 +40,11 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>      return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
>  }
>  
> +static inline bool runstate_is_started(RunState state)

Would runstate_has_vm_running() sound better?  It is a bit awkward when
saying something like "start a runstate".

> +{
> +    return state == RUN_STATE_RUNNING || state == RUN_STATE_SUSPENDED;
> +}
> +
>  void vm_start(void);
>  
>  /**
> diff --git a/qapi/misc.json b/qapi/misc.json
> index cda2eff..efb8d44 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -134,7 +134,7 @@
>  ##
>  # @stop:
>  #
> -# Stop all guest VCPU execution.
> +# Stop all guest VCPU and VM execution.
>  #
>  # Since: 0.14
>  #
> @@ -143,6 +143,9 @@
>  #     the guest remains paused once migration finishes, as if the -S
>  #     option was passed on the command line.
>  #
> +#     In the "suspended" state, it will completely stop the VM and
> +#     cause a transition to the "paused" state. (Since 9.0)
> +#
>  # Example:
>  #
>  # -> { "execute": "stop" }
> @@ -153,7 +156,7 @@
>  ##
>  # @cont:
>  #
> -# Resume guest VCPU execution.
> +# Resume guest VCPU and VM execution.
>  #
>  # Since: 0.14
>  #
> @@ -165,6 +168,9 @@
>  #     guest starts once migration finishes, removing the effect of the
>  #     -S command line option if it was passed.
>  #
> +#     If the VM was previously suspended, and not been reset or woken,
> +#     this command will transition back to the "suspended" state. (Since 9.0)
> +#
>  # Example:
>  #
>  # -> { "execute": "cont" }
> diff --git a/system/cpus.c b/system/cpus.c
> index ef7a0d3..cbc6d6d 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -277,11 +277,15 @@ bool vm_get_suspended(void)
>  static int do_vm_stop(RunState state, bool send_stop)
>  {
>      int ret = 0;
> +    RunState oldstate = runstate_get();
>  
> -    if (runstate_is_running()) {
> +    if (runstate_is_started(oldstate)) {
> +        vm_was_suspended = (oldstate == RUN_STATE_SUSPENDED);
>          runstate_set(state);
>          cpu_disable_ticks();
> -        pause_all_vcpus();
> +        if (oldstate == RUN_STATE_RUNNING) {
> +            pause_all_vcpus();
> +        }
>          vm_state_notify(0, state);
>          if (send_stop) {
>              qapi_event_send_stop();
> @@ -736,8 +740,13 @@ int vm_prepare_start(bool step_pending, RunState state)
>  
>  void vm_start(void)
>  {
> -    if (!vm_prepare_start(false, RUN_STATE_RUNNING)) {
> -        resume_all_vcpus();
> +    RunState state = vm_was_suspended ? RUN_STATE_SUSPENDED : RUN_STATE_RUNNING;
> +
> +    if (!vm_prepare_start(false, state)) {
> +        if (state == RUN_STATE_RUNNING) {
> +            resume_all_vcpus();
> +        }
> +        vm_was_suspended = false;
>      }
>  }
>  
> @@ -745,7 +754,7 @@ void vm_start(void)
>     current state is forgotten forever */
>  int vm_stop_force_state(RunState state)
>  {
> -    if (runstate_is_running()) {
> +    if (runstate_is_started(runstate_get())) {
>          return vm_stop(state);
>      } else {
>          int ret;
> diff --git a/system/runstate.c b/system/runstate.c
> index ea9d6c2..e2fa204 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -108,6 +108,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_PAUSED, RUN_STATE_POSTMIGRATE },
>      { RUN_STATE_PAUSED, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_PAUSED, RUN_STATE_COLO},
> +    { RUN_STATE_PAUSED, RUN_STATE_SUSPENDED},
>  
>      { RUN_STATE_POSTMIGRATE, RUN_STATE_RUNNING },
>      { RUN_STATE_POSTMIGRATE, RUN_STATE_FINISH_MIGRATE },
> @@ -161,6 +162,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
>      { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
> +    { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED},
>  
>      { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
>      { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
> @@ -502,6 +504,7 @@ void qemu_system_reset(ShutdownCause reason)
>          qapi_event_send_reset(shutdown_caused_by_guest(reason), reason);
>      }
>      cpu_synchronize_all_post_reset();
> +    vm_set_suspended(false);
>  }
>  
>  /*
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


