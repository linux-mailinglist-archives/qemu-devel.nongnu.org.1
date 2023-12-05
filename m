Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EED138060DD
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 22:35:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAd4y-0006w4-SK; Tue, 05 Dec 2023 16:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAd4l-0006v5-97
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:35:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAd4h-0008Ct-Pd
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701812127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rRNnp6JYl5Acu0Ax5DjtxdNoDqcZzYfIehSKo4kQlz4=;
 b=Y57tIczV3QQKo1ittHED8ghci4NywmLNzaKdHgDbjvAz0aaW4tAiUIgMOIgKLuNdmJl9Ja
 xjloLUBwr4Czl0WYuGZq0pVyrubRQnOhq7EjZkqGjlYgoQ/CrzsM2u5my49O6vhh8Y/ro8
 bDvMDU53FaVvcRZu4BSPMf6JbL5nA4U=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-Zz-EsZQoMY6X8jiz-4d22A-1; Tue, 05 Dec 2023 16:35:21 -0500
X-MC-Unique: Zz-EsZQoMY6X8jiz-4d22A-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-58e28c5b6aeso617333eaf.0
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 13:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701812120; x=1702416920;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRNnp6JYl5Acu0Ax5DjtxdNoDqcZzYfIehSKo4kQlz4=;
 b=iI+2TScUx8uPAqcFukWmr8cLLfZtSkmHqokgf6n01v+DRftqT2DEXNbHEcrL/pOVWF
 Ot0tY9/x4L1594ksGg0N1tiRFeYUcwu5na8Ib1gyWR1TPyR/H93csVTRzFXAMPntwJSg
 gNWZapJtvnFlSw9CPB4WcJcRrLYWLUhXXcBP4v6o+yPokUO8gVa0xZBoVZUTwJP9gbln
 FV1Vj7KzGfB2hElixIr2SF186ygmFiptqblu9RHxncWe/VDrcbGSog3Cxv8I2czwReHJ
 A1QfEngAkGmAvSrIFWw9t8ap1Z4twZ3h8AJmy7Aki69l9qtc/Nl08qjmQ+kzJ9eTOb8S
 rGrA==
X-Gm-Message-State: AOJu0YwVTpiyIU0jYYVjB2QapCCfiBD7DK6LHvnp7dJL6kv/1CxA1Anx
 dLK16/HxQZV+qy8d0tg7Piay5hzjkQqnHe3cDdM2lZBWwyHHmOweXWIxKw4zVq9sal4YaRUk0Uw
 irU4D3gRZlkj3wxE=
X-Received: by 2002:a05:6358:5915:b0:16b:958e:6a1c with SMTP id
 g21-20020a056358591500b0016b958e6a1cmr19935079rwf.0.1701812120541; 
 Tue, 05 Dec 2023 13:35:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGC/7xjATq7ANmTQckOM9mPRHOAger4qROXHBJ61vH5THFgCzoLGM4Mj+ajP6lbwzn5JsHDQ==
X-Received: by 2002:a05:6358:5915:b0:16b:958e:6a1c with SMTP id
 g21-20020a056358591500b0016b958e6a1cmr19935055rwf.0.1701812120155; 
 Tue, 05 Dec 2023 13:35:20 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 l19-20020a05620a0c1300b0077f103c8ad6sm1801791qki.82.2023.12.05.13.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 13:35:19 -0800 (PST)
Date: Tue, 5 Dec 2023 16:35:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 07/14] migration: preserve suspended for snapshot
Message-ID: <ZW-Xlnu3Nbeh-VA8@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-8-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1701380247-340457-8-git-send-email-steven.sistare@oracle.com>
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

On Thu, Nov 30, 2023 at 01:37:20PM -0800, Steve Sistare wrote:
> Restoring a snapshot can break a suspended guest.  Snapshots suffer from
> the same suspended-state issues that affect live migration, plus they must
> handle an additional problematic scenario, which is that a running vm must
> remain running if it loads a suspended snapshot.  Currently, after loading
> such a snapshot, the vm_start fails.  The runstate is RUNNING, but the guest
> is not.
> 
> To save, the vm_stop call now completely stops the suspended state, courtesy
> of a recent patch.  Finish with vm_resume to leave the vm in the state it had
> prior to the save, correctly restoring the suspended state.
> 
> To load, if the snapshot is not suspended, then vm_stop + vm_resume
> correctly handles all states, and leaves the vm in the state it had prior
> to the load.  However, if the snapshot is suspended, restoration is
> trickier.  First, call vm_resume to restore the state to suspended so the
> current state matches the saved state.  Then, if the pre-load state is
> running, call wakeup to resume running.
> 
> Prior to these changes, the vm_stop to RUN_STATE_SAVE_VM and
> RUN_STATE_RESTORE_VM did not change runstate if the current state was
> paused, suspended, or prelaunch, but now it does, so allow these
> transitions.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick below:

[...]

> +void load_snapshot_resume(RunState state)
> +{
> +    vm_resume(state);
> +    if (state == RUN_STATE_RUNNING && runstate_get() == RUN_STATE_SUSPENDED) {
> +        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);

Please avoid using NULL for Error**.  &error_abort seems apropriate.

Thanks,

-- 
Peter Xu


