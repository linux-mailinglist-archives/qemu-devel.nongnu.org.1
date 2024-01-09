Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DAF827F26
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 08:21:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN6PR-0002oU-FN; Tue, 09 Jan 2024 02:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN6PP-0002oI-Em
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:20:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN6PH-000435-8T
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704784814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ay3V288Konu0/dMX1QEGKWdHKwUGM3ykOnamiRrBI9M=;
 b=W5CIn56riz+UqRJfggZkcQuYpP28eeZuyQb6hQHJig3qhlHAxAdnJj5Mlsu0qA/SabwKjs
 cwOWMcGpA++eBOayjKA0eNo37aK/lqfMl7DfpxGbkEascyOVpXO1e16LaHCPaq6zwkZPUs
 z369REecbq70sUlFA8JRacCKL2OvvTE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-tUGJQx2mPFiHS3NHrpWRNQ-1; Tue, 09 Jan 2024 02:20:13 -0500
X-MC-Unique: tUGJQx2mPFiHS3NHrpWRNQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7831ed4bb2aso286855885a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 23:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704784812; x=1705389612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ay3V288Konu0/dMX1QEGKWdHKwUGM3ykOnamiRrBI9M=;
 b=I8rpKsBXrxSflj48P9WVljs9KRoq1aTTk+59gbW9A6SmhAgHkbBqkDKZjCb2GUHxgq
 2HTaSlaBB8LiGaHwlVXnik7z5FGDwPPYoY+UJvHWymPnQle0f6e/54/0+JLIxf/DDw49
 fa078lWcfkXoBvmBvvFRJvTICdSGwCOuvVRIlGj0Q7cdGVe90BSoOBI73fQXWafAYS1K
 MsiPpVW9OWdfOsOFVDOsTheJ/ZDOSC2PQllgEtk6y8C1yg7f3nUp0i6hIFbit5NPxipL
 yBktiN5CwZ17FIfLRYeGuFaLHdlYFHTL84S27HHegzuHA7BN1jJRKqJDCPRZHNunR0uE
 Caxw==
X-Gm-Message-State: AOJu0Yx6UQ+O9G0XVCIdgDN0pXrOouNJhi2ISGY2U3nvoxy0v0GyM+Vd
 FA4CXDUReeFn25D15UL4oO8VMdUdWZWRXO6YjVLTwNVZ02Hg2ST5jYDIz4o6zb8f/y9KVeMIvnI
 G860W+vPULQS76+QkoF4jo9yQ42IvX60=
X-Received: by 2002:a05:620a:c4b:b0:781:e37c:d77e with SMTP id
 u11-20020a05620a0c4b00b00781e37cd77emr6972410qki.39.1704784812197; 
 Mon, 08 Jan 2024 23:20:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyGqzoqGcvEpWrsQ5+EgCejjM3nY6v3n9QMcNtbnyWixaTYUB7WrXNmLFziLtClE4YseMmLA==
X-Received: by 2002:a05:620a:c4b:b0:781:e37c:d77e with SMTP id
 u11-20020a05620a0c4b00b00781e37cd77emr6972397qki.39.1704784811918; 
 Mon, 08 Jan 2024 23:20:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n19-20020a05620a223300b00783148d1269sm582626qkh.62.2024.01.08.23.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 23:20:11 -0800 (PST)
Message-ID: <485eca29-8a73-4fc5-83dc-5f8971b8ab0c@redhat.com>
Date: Tue, 9 Jan 2024 08:20:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] docs/migration: Organize "Postcopy" page
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240109064628.595453-1-peterx@redhat.com>
 <20240109064628.595453-9-peterx@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240109064628.595453-9-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/9/24 07:46, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Reorganize the page, moving things around, and add a few
> headlines ("Postcopy internals", "Postcopy features") to cover sub-areas.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   docs/devel/migration/postcopy.rst | 159 ++++++++++++++++--------------
>   1 file changed, 84 insertions(+), 75 deletions(-)
> 
> diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
> index d60eec06ab..6c51e96d79 100644
> --- a/docs/devel/migration/postcopy.rst
> +++ b/docs/devel/migration/postcopy.rst
> @@ -1,6 +1,9 @@
> +========
>   Postcopy
>   ========
>   
> +.. contents::
> +
>   'Postcopy' migration is a way to deal with migrations that refuse to converge

The quote character is used in a few places to emphasize words
which should be reworked. The rest looks good, so


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



>   (or take too long to converge) its plus side is that there is an upper bound on
>   the amount of migration traffic and time it takes, the down side is that during
> @@ -14,7 +17,7 @@ Postcopy can be combined with precopy (i.e. normal migration) so that if precopy
>   doesn't finish in a given time the switch is made to postcopy.
>   
>   Enabling postcopy
> ------------------
> +=================
>   
>   To enable postcopy, issue this command on the monitor (both source and
>   destination) prior to the start of migration:
> @@ -49,8 +52,71 @@ time per vCPU.
>     ``migrate_set_parameter`` is ignored (to avoid delaying requested pages that
>     the destination is waiting for).
>   
> -Postcopy device transfer
> -------------------------
> +Postcopy internals
> +==================
> +
> +State machine
> +-------------
> +
> +Postcopy moves through a series of states (see postcopy_state) from
> +ADVISE->DISCARD->LISTEN->RUNNING->END
> +
> + - Advise
> +
> +    Set at the start of migration if postcopy is enabled, even
> +    if it hasn't had the start command; here the destination
> +    checks that its OS has the support needed for postcopy, and performs
> +    setup to ensure the RAM mappings are suitable for later postcopy.
> +    The destination will fail early in migration at this point if the
> +    required OS support is not present.
> +    (Triggered by reception of POSTCOPY_ADVISE command)
> +
> + - Discard
> +
> +    Entered on receipt of the first 'discard' command; prior to
> +    the first Discard being performed, hugepages are switched off
> +    (using madvise) to ensure that no new huge pages are created
> +    during the postcopy phase, and to cause any huge pages that
> +    have discards on them to be broken.
> +
> + - Listen
> +
> +    The first command in the package, POSTCOPY_LISTEN, switches
> +    the destination state to Listen, and starts a new thread
> +    (the 'listen thread') which takes over the job of receiving
> +    pages off the migration stream, while the main thread carries
> +    on processing the blob.  With this thread able to process page
> +    reception, the destination now 'sensitises' the RAM to detect
> +    any access to missing pages (on Linux using the 'userfault'
> +    system).
> +
> + - Running
> +
> +    POSTCOPY_RUN causes the destination to synchronise all
> +    state and start the CPUs and IO devices running.  The main
> +    thread now finishes processing the migration package and
> +    now carries on as it would for normal precopy migration
> +    (although it can't do the cleanup it would do as it
> +    finishes a normal migration).
> +
> + - Paused
> +
> +    Postcopy can run into a paused state (normally on both sides when
> +    happens), where all threads will be temporarily halted mostly due to
> +    network errors.  When reaching paused state, migration will make sure
> +    the qemu binary on both sides maintain the data without corrupting
> +    the VM.  To continue the migration, the admin needs to fix the
> +    migration channel using the QMP command 'migrate-recover' on the
> +    destination node, then resume the migration using QMP command 'migrate'
> +    again on source node, with resume=true flag set.
> +
> + - End
> +
> +    The listen thread can now quit, and perform the cleanup of migration
> +    state, the migration is now complete.
> +
> +Device transfer
> +---------------
>   
>   Loading of device data may cause the device emulation to access guest RAM
>   that may trigger faults that have to be resolved by the source, as such
> @@ -130,7 +196,20 @@ processing.
>      is no longer used by migration, while the listen thread carries on servicing
>      page data until the end of migration.
>   
> -Postcopy Recovery
> +Source side page bitmap
> +-----------------------
> +
> +The 'migration bitmap' in postcopy is basically the same as in the precopy,
> +where each of the bit to indicate that page is 'dirty' - i.e. needs
> +sending.  During the precopy phase this is updated as the CPU dirties
> +pages, however during postcopy the CPUs are stopped and nothing should
> +dirty anything any more. Instead, dirty bits are cleared when the relevant
> +pages are sent during postcopy.
> +
> +Postcopy features
> +=================
> +
> +Postcopy recovery
>   -----------------
>   
>   Comparing to precopy, postcopy is special on error handlings.  When any
> @@ -166,76 +245,6 @@ configurations of the guest.  For example, when with async page fault
>   enabled, logically the guest can proactively schedule out the threads
>   accessing missing pages.
>   
> -Postcopy states
> ----------------
> -
> -Postcopy moves through a series of states (see postcopy_state) from
> -ADVISE->DISCARD->LISTEN->RUNNING->END
> -
> - - Advise
> -
> -    Set at the start of migration if postcopy is enabled, even
> -    if it hasn't had the start command; here the destination
> -    checks that its OS has the support needed for postcopy, and performs
> -    setup to ensure the RAM mappings are suitable for later postcopy.
> -    The destination will fail early in migration at this point if the
> -    required OS support is not present.
> -    (Triggered by reception of POSTCOPY_ADVISE command)
> -
> - - Discard
> -
> -    Entered on receipt of the first 'discard' command; prior to
> -    the first Discard being performed, hugepages are switched off
> -    (using madvise) to ensure that no new huge pages are created
> -    during the postcopy phase, and to cause any huge pages that
> -    have discards on them to be broken.
> -
> - - Listen
> -
> -    The first command in the package, POSTCOPY_LISTEN, switches
> -    the destination state to Listen, and starts a new thread
> -    (the 'listen thread') which takes over the job of receiving
> -    pages off the migration stream, while the main thread carries
> -    on processing the blob.  With this thread able to process page
> -    reception, the destination now 'sensitises' the RAM to detect
> -    any access to missing pages (on Linux using the 'userfault'
> -    system).
> -
> - - Running
> -
> -    POSTCOPY_RUN causes the destination to synchronise all
> -    state and start the CPUs and IO devices running.  The main
> -    thread now finishes processing the migration package and
> -    now carries on as it would for normal precopy migration
> -    (although it can't do the cleanup it would do as it
> -    finishes a normal migration).
> -
> - - Paused
> -
> -    Postcopy can run into a paused state (normally on both sides when
> -    happens), where all threads will be temporarily halted mostly due to
> -    network errors.  When reaching paused state, migration will make sure
> -    the qemu binary on both sides maintain the data without corrupting
> -    the VM.  To continue the migration, the admin needs to fix the
> -    migration channel using the QMP command 'migrate-recover' on the
> -    destination node, then resume the migration using QMP command 'migrate'
> -    again on source node, with resume=true flag set.
> -
> - - End
> -
> -    The listen thread can now quit, and perform the cleanup of migration
> -    state, the migration is now complete.
> -
> -Source side page map
> ---------------------
> -
> -The 'migration bitmap' in postcopy is basically the same as in the precopy,
> -where each of the bit to indicate that page is 'dirty' - i.e. needs
> -sending.  During the precopy phase this is updated as the CPU dirties
> -pages, however during postcopy the CPUs are stopped and nothing should
> -dirty anything any more. Instead, dirty bits are cleared when the relevant
> -pages are sent during postcopy.
> -
>   Postcopy with hugepages
>   -----------------------
>   
> @@ -293,7 +302,7 @@ Retro-fitting postcopy to existing clients is possible:
>        guest memory access is made while holding a lock then all other
>        threads waiting for that lock will also be blocked.
>   
> -Postcopy Preemption Mode
> +Postcopy preemption mode
>   ------------------------
>   
>   Postcopy preempt is a new capability introduced in 8.0 QEMU release, it


