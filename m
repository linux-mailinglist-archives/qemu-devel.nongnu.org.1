Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725978D7A4
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:36:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbOA2-0006oP-59; Wed, 30 Aug 2023 12:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbO9z-0006nw-GB
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbO9x-0000Qy-5a
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693413311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ujoecicIfd57NId07TnsK5qXY7WWFT9O/LSL5uXO/3s=;
 b=MlZkN/TT2tvXEjbRj6Bebrn50/jcdtbmV8/Liu7URWnXZXv9vpD8u+Egqt/jHmD9jc5BJQ
 jXlJ5HVfGNqXFhH1c8J+LCNrLnc1Kv7d5XMd/GCAlesxut1JVRgEXsxcZD/R8wGik+D/sR
 PttoMWpbnXsVZ0kpihtx9HzsrDyurmU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-p1ZnK6_aOGOS0WKlymprmw-1; Wed, 30 Aug 2023 12:35:10 -0400
X-MC-Unique: p1ZnK6_aOGOS0WKlymprmw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63c9463c116so10493706d6.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693413309; x=1694018109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujoecicIfd57NId07TnsK5qXY7WWFT9O/LSL5uXO/3s=;
 b=kTCGVRY/U31waCDDRGJ5+E4ijKwGn6kQnaFzQqd3094XSmMC7YviMe7LvD1eROJJFI
 4gU90x1V3jnJqpa/cYlERv/iNrfXZhKYOr8b9mboxqotIoD9p9XutT1mCagysJudvyY/
 L5RZ19q/LQxK2NJjWf98rwJLwLVYeanlD7+Xp4gh7lwZlFZzJ4O7MKARTgojZPKJL4/w
 2CZgp8kT7K+AXk99R+zINh9Uzx0Mun4rNldGslRBMFtUVkwqnmuQ+kOkptJ1Ka71Bm/D
 W6VGi0/bhU4o0IvxBAAhQLzG8s/VXhbIM6DZrcO4eFN4N4k8mPuPlQX4QjhdXR26EP8S
 c/wA==
X-Gm-Message-State: AOJu0YzAtVFESTrUW6Ls1/Eh0qcNvL14jy+rwd3dCYvBFTblcr3vRzFY
 ZLZE6WFr52pxybD6B9dQbRpenT2GRFF+z5YajohcbHTT4i0PLEgZE0rowxJktC1ZwOnIr5vQoV0
 YqkaFB/J5RX8ZyX+3qezsRoI=
X-Received: by 2002:a05:6214:1d2c:b0:64c:232a:6e6a with SMTP id
 f12-20020a0562141d2c00b0064c232a6e6amr2790862qvd.0.1693413309708; 
 Wed, 30 Aug 2023 09:35:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAWBo2U7j6RpCUPh17f9gcLUGu4/F6as0d/IL6MQxXLYZhid1K9LDy0gDMX5WuD38eOKXt6g==
X-Received: by 2002:a05:6214:1d2c:b0:64c:232a:6e6a with SMTP id
 f12-20020a0562141d2c00b0064c232a6e6amr2790843qvd.0.1693413309388; 
 Wed, 30 Aug 2023 09:35:09 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 v8-20020a0c8e08000000b0064f59f68e78sm4264396qvb.81.2023.08.30.09.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 09:35:08 -0700 (PDT)
Date: Wed, 30 Aug 2023 12:35:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V4 05/11] migration: preserve suspended for bg_migration
Message-ID: <ZO9vuqhUgaEkjPtV@x1n>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-6-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1693333086-392798-6-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Aug 29, 2023 at 11:18:00AM -0700, Steve Sistare wrote:
> Do not wake a suspended guest during bg_migration.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/migration.c | 12 +++++-------
>  softmmu/runstate.c    |  1 +
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index a9ecb66..303d5a6 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3064,7 +3064,9 @@ static void bg_migration_vm_start_bh(void *opaque)
>      qemu_bh_delete(s->vm_start_bh);
>      s->vm_start_bh = NULL;
>  
> -    vm_start();
> +    if (!runstate_check(RUN_STATE_SUSPENDED)) {
> +        vm_start();
> +    }
>      s->downtime = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - s->downtime_start;
>  }
>  
> @@ -3134,16 +3136,12 @@ static void *bg_migration_thread(void *opaque)
>  
>      qemu_mutex_lock_iothread();
>  
> -    /*
> -     * If VM is currently in suspended state, then, to make a valid runstate
> -     * transition in vm_stop_force_state() we need to wakeup it up.
> -     */
> -    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>      s->vm_old_state = runstate_get();
>  
>      global_state_store();
>      /* Forcibly stop VM before saving state of vCPUs and devices */
> -    if (vm_stop_force_state(RUN_STATE_PAUSED)) {
> +    if (!runstate_check(RUN_STATE_SUSPENDED) &&
> +        vm_stop_force_state(RUN_STATE_PAUSED)) {

IIUC we need the vm_stop even for SUSPENDED?  I think we need to make sure
all backends are stopped before we start wr-protect the guest pages, so
when wr-protect happens the guest pages should be in a consistent state.

I'd think it proper to juse reuse the helper you introduced in the previous
patches, but maybe you have a reason to not do so (I didn't see it
mentioned anywhere, though)?

>          goto fail;
>      }
>      /*
> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
> index 21d7407..4417527 100644
> --- a/softmmu/runstate.c
> +++ b/softmmu/runstate.c
> @@ -163,6 +163,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
>      { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
> +    { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED },
>  
>      { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
>      { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


