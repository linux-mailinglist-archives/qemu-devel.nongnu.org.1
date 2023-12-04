Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4327803A71
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:36:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABvS-00040H-KD; Mon, 04 Dec 2023 11:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rABvQ-000408-I0
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:36:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rABvP-0008Ue-03
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701707761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VB9Iy2Mmcs4tNr+aVPSR0w9IaVyZKHPMDYoYohQUodY=;
 b=cOwDOdbXu8bMgQKEsvUAjKy5jZI1WCINRrNykDSnzu4eO5YmAF4BOkpcdRPKsTlon/0ImW
 rNxVDr90kWMd3giELe1IoWiIvcA5l9JsJGy5pKgD8Y8OHAyI2rNQ8uZpxaSY1lgNEPVPk5
 Um2W8TdaBdAOI88BjVURdJ2xC13Sd9I=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-ozH9j1GQM5W1GnRJGH4wtQ-1; Mon, 04 Dec 2023 11:35:56 -0500
X-MC-Unique: ozH9j1GQM5W1GnRJGH4wtQ-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7b3d03b59adso135624739f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 08:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701707756; x=1702312556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VB9Iy2Mmcs4tNr+aVPSR0w9IaVyZKHPMDYoYohQUodY=;
 b=f1ULBpAzTnQJxp1xifZfVnucwq0IyVrlWi2uiG79WLV5BQG1s3CBgyxKREr+pZB9ex
 DybpmTiUHONzLeKUlOy/5YOL7+wFFhLuU1t2i9IS0BBZezWJvTqLQ0E5d4sPdL44DLDz
 L8Yhyoox9CeEWQLw+zjDoep/KtvlA2crUwEnh9H9PExJKruSiV6IY6YIVIKauRTLQaWu
 o60c1+BthyUwKpW8KgiakXxaiK8q7o3SemvOffYXTxNdBVFDYMhz3gQqEAUtv8Rqzd45
 Ifq5tdcjZdjyMw0xBhOuGDe4jQG7H+ZzGGD7W0b3qOK4Vq3eluYUNx6kklV4WyemPmVl
 iTMw==
X-Gm-Message-State: AOJu0Yzc+SbbtfQQyf/hleID/oF3R00Qmb8dloXZcK4ptuUNNZZVp8/E
 CD0XdXzWF35pi/T98kjscpb414NECeR84ATCyIU5HalJQKrawxLrIOUKI1wNlpB2T3wbxXVXp27
 F/ZJzxUElcm0aFCg=
X-Received: by 2002:a6b:c403:0:b0:7b3:f2a2:45e with SMTP id
 y3-20020a6bc403000000b007b3f2a2045emr16534702ioa.2.1701707755863; 
 Mon, 04 Dec 2023 08:35:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBGF+IEr4Qm/a5SDbnH6zGwmLpSi1KW9pBCMJeLrRxCN0uck6L4aCRW/eYaEOvORqigeAP8A==
X-Received: by 2002:a6b:c403:0:b0:7b3:f2a2:45e with SMTP id
 y3-20020a6bc403000000b007b3f2a2045emr16534679ioa.2.1701707755385; 
 Mon, 04 Dec 2023 08:35:55 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 f33-20020a05663832a100b00468e18cd2f6sm1942056jav.132.2023.12.04.08.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 08:35:55 -0800 (PST)
Date: Mon, 4 Dec 2023 11:35:52 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH V6 03/14] cpus: stop vm in suspended runstate
Message-ID: <ZW3_6H4ZK_NUS5FM@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-4-git-send-email-steven.sistare@oracle.com>
 <ZWkIV1k7n7xW5doM@x1n>
 <0533cef9-2499-4480-b0a2-e5c00787ceda@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0533cef9-2499-4480-b0a2-e5c00787ceda@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Dec 01, 2023 at 12:11:32PM -0500, Steven Sistare wrote:
> >> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> >> index f6a337b..1d6828f 100644
> >> --- a/include/sysemu/runstate.h
> >> +++ b/include/sysemu/runstate.h
> >> @@ -40,6 +40,11 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
> >>      return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
> >>  }
> >>  
> >> +static inline bool runstate_is_started(RunState state)
> > 
> > Would runstate_has_vm_running() sound better?  It is a bit awkward when
> > saying something like "start a runstate".
> 
> I have been searching for the perfect name for this accessor.
> IMO using "running" in this accessor is confusing because it applies to both
> the running and suspended state.  So, I invented a new aggregate state called
> started.  vm_start transitions the machine to a started state.
> 
> How about runstate_was_started?  It works well at both start and stop call sites:
> 
>     void vm_resume(RunState state)
>         if (runstate_was_started(state)) {

This one looks fine, but...

>             vm_start();
> 
>     int vm_stop_force_state(RunState state)
>         if (runstate_was_started(runstate_get())) {

.. this one makes the past tense not looking good.

>             return vm_stop(state);

How about runstate_is_alive()?  So far the best I can come up with. :)

Even if you prefer "started", I'd vote for not using past tense, hence
runstate_is_started().

Thanks,

-- 
Peter Xu


