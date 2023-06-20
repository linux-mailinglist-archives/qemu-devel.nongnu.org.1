Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E057376D0
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 23:48:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBjBo-0000PH-Ao; Tue, 20 Jun 2023 17:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBjBg-0000Kz-7M
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 17:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBjBd-0005Ib-GM
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 17:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687297612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KtHUPqaUgG9yaZtG11WM/22XCYdFB2PPRFfcYen660w=;
 b=I1kA2w1On1+uI/A4f5uzNfNTVcIRFwqwlKrXZsL5CjJeJQwm03Cer5E+Je/zBpAi7egfPL
 1emdAkvR9eGPrChlw4XgUSvnT2aF1/MCnp9QmmRYQ8shQfh9Tvpz3xnl32AVzEfyJUzXzV
 g78yQVpJtS+umG92KSB4vt3L2l53a7I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-6Mg3zMPEPiyNf2ZKaPXa8w-1; Tue, 20 Jun 2023 17:46:50 -0400
X-MC-Unique: 6Mg3zMPEPiyNf2ZKaPXa8w-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-62ff893f03bso12540636d6.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 14:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687297610; x=1689889610;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtHUPqaUgG9yaZtG11WM/22XCYdFB2PPRFfcYen660w=;
 b=bIyPxxl6aUF5qLylCV3+Gzcp47+FFeUFjsPnKM2jR4hSJ9y61kJB9DlUYD6BaXEDT8
 Fs/TM/7Wm7/9fcRyxLItmlqy4cus2t6lnkSS7tZDJEG5/W32ZdBSDZzU/qW0VwwHkmI1
 fyu19lrIF5w9dYXIBE6mu3VTVJxhcFgYdU0GRiT5yMZTaBuj1lZmrSOAiYtTH8ysyn3/
 sWmZw8+hr1gc2OgTGl6J2aDgXpUCdVJD72vGEgIxU5AzJvFLU7AGa2OJz1zhBEJiB2oy
 Y2Emdq12EK4XlsjrprXiE1fXnUnsWA6uV7Hkd33aUPMy9IPUiiW5etkjqaRk/bn13Baq
 jDCw==
X-Gm-Message-State: AC+VfDxLZjsfZKCrgFCldjQqfWhHkTq/csGK9dNRpmSbdRxn+hN7gyQh
 gJLcPPqo61AZTEE6QXk/XevQPDkN27cxmw5z6kmcMzAzxl6fwirfcn24QQ7x4Nip+rQSyHDQGyT
 1NQxrUMHquqHQ0x0=
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id
 kj24-20020a056214529800b0062f12836185mr16685407qvb.2.1687297609780; 
 Tue, 20 Jun 2023 14:46:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/lUJ2ygOHGQnAp+oC3F+55CZfitua94P/O29vediXhOHk3UsGTEt0cnPA2WLY1yMwpGExIA==
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id
 kj24-20020a056214529800b0062f12836185mr16685395qvb.2.1687297609420; 
 Tue, 20 Jun 2023 14:46:49 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a16-20020a0ce350000000b006262e5c96d0sm1669433qvm.129.2023.06.20.14.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 14:46:48 -0700 (PDT)
Date: Tue, 20 Jun 2023 17:46:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V1 2/3] migration: fix suspended runstate
Message-ID: <ZJIeR7svXvtHdgs4@x1n>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1686860800-34667-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 15, 2023 at 01:26:39PM -0700, Steve Sistare wrote:
> Migration of a guest in the suspended state is broken.  The incoming
> migration code automatically tries to wake the guest, which IMO is
> wrong -- the guest should end migration in the same state it started.
> Further, the wakeup is done by calling qemu_system_wakeup_request(), which
> bypasses vm_start().  The guest appears to be in the running state, but
> it is not.
> 
> To fix, leave the guest in the suspended state, but call
> qemu_system_start_on_wakeup_request() so the guest is properly resumed
> later, when the client sends a system_wakeup command.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/migration.c | 11 ++++-------
>  softmmu/runstate.c    |  1 +
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 17b4b47..851fe6d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -496,6 +496,10 @@ static void process_incoming_migration_bh(void *opaque)
>          vm_start();
>      } else {
>          runstate_set(global_state_get_runstate());
> +        if (runstate_check(RUN_STATE_SUSPENDED)) {
> +            /* Force vm_start to be called later. */
> +            qemu_system_start_on_wakeup_request();
> +        }

Is this really needed, along with patch 1?

I have a very limited knowledge on suspension, so I'm prone to making
mistakes..

But from what I read this, qemu_system_wakeup_request() (existing one, not
after patch 1 applied) will setup wakeup_reason and kick the main thread
using qemu_notify_event().  Then IIUC the e.g. vcpu wakeups will be done in
the main thread later on after qemu_wakeup_requested() returns true.

>      }
>      /*
>       * This must happen after any state changes since as soon as an external
> @@ -2101,7 +2105,6 @@ static int postcopy_start(MigrationState *ms)
>      qemu_mutex_lock_iothread();
>      trace_postcopy_start_set_run();
>  
> -    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>      global_state_store();
>      ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
>      if (ret < 0) {
> @@ -2307,7 +2310,6 @@ static void migration_completion(MigrationState *s)
>      if (s->state == MIGRATION_STATUS_ACTIVE) {
>          qemu_mutex_lock_iothread();
>          s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> -        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>  
>          s->vm_old_state = runstate_get();
>          global_state_store();
> @@ -3102,11 +3104,6 @@ static void *bg_migration_thread(void *opaque)
>  
>      qemu_mutex_lock_iothread();
>  
> -    /*
> -     * If VM is currently in suspended state, then, to make a valid runstate
> -     * transition in vm_stop_force_state() we need to wakeup it up.
> -     */
> -    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);

Removal of these three places seems reasonable to me, or we won't persist
the SUSPEND state.

Above comment was the major reason I used to have thought it was needed
(again, based on zero knowledge around this..), but perhaps it was just
wrong?  I would assume vm_stop_force_state() will still just work with
suepended, am I right?

>      s->vm_old_state = runstate_get();
>  
>      global_state_store();
> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
> index e127b21..771896c 100644
> --- a/softmmu/runstate.c
> +++ b/softmmu/runstate.c
> @@ -159,6 +159,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_RUNNING, RUN_STATE_SUSPENDED },
>      { RUN_STATE_SUSPENDED, RUN_STATE_RUNNING },
>      { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
> +    { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED },
>      { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
>  
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


