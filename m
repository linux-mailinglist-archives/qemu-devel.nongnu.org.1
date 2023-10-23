Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7C67D302B
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 12:40:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qusKd-00042p-05; Mon, 23 Oct 2023 06:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qusKX-00041m-MZ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qusKU-0001cL-Hd
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698057517;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JL/R3a/6y6MOVoJyJJ+NAEum+XsHMBdbvREDQGEuQuY=;
 b=O9PPi8itsQL/tCNd1UYoWBs5zgOau8AVeyBCm8OvJIB2XNWADbfARYmoccsgyEeo/z6Bzf
 H7sGbN844VhyIDXAI9kIqQ/TtLVCu0665D38Tc8hrNXNEAsCvxvQ7H/+Le/1NOBJvyRSQR
 OGsDKQkB7poTJ4xUlKaaEVHtIZ2IJrQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-ZXJYpFQVNEakGPACfq3pXw-1; Mon, 23 Oct 2023 06:38:33 -0400
X-MC-Unique: ZXJYpFQVNEakGPACfq3pXw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507c996104fso3396399e87.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 03:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698057512; x=1698662312;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JL/R3a/6y6MOVoJyJJ+NAEum+XsHMBdbvREDQGEuQuY=;
 b=J3inQqJWbd1JOw0qbb9DDLlEg5RBNr2PMHNRCBvAARelEgIWC1PInwX2onJ2L5i06e
 UIZjVGDXnmrVaNs1gfAs+kj5lv5yMCFXDxCXXeA2HvRoNsHLDq1kHpu6SlNXihh7Lug7
 FyszUxbFNPgjT6yOxhkPNp178xboODCejsXbzNIkM5OGoabfnZ0vToIjPB6EW/2rR0rb
 +U/LmZdOT14y1ans5QS0wMOBqJgTXrd5z3ZSBPTeiv0IzXN0LY5qcALOmbmonoegfpDZ
 QrFd0ZEIrJhsIiJ8Vp7OyoS3nbvZbretWFDSx0G6XgPYwxhV5poMANpIe/bJ/2ifqzvn
 duiA==
X-Gm-Message-State: AOJu0YxLyFQEVXAtJYhDluu/zEv9jxeKPipB8k7DH9WWx2BoKJ6Bk1zk
 +9dV0ZXK2GMQCj3/NoRAHdAg2GcLY8Wf/RbP7BXFidDyOZ1w46O9EUUaHp/O0GD1cK1R7S/irKg
 B1K7LD0didEZQW9k=
X-Received: by 2002:a05:651c:2208:b0:2bc:f2d7:f6ce with SMTP id
 y8-20020a05651c220800b002bcf2d7f6cemr7065538ljq.49.1698057511934; 
 Mon, 23 Oct 2023 03:38:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV+Hl4STwEM5LOtPkThT8iXP0Ti8ZP1pHzADC4bLcMxceia10iDpff7lWtsAt+udqtQC6Gfw==
X-Received: by 2002:a05:651c:2208:b0:2bc:f2d7:f6ce with SMTP id
 y8-20020a05651c220800b002bcf2d7f6cemr7065527ljq.49.1698057511536; 
 Mon, 23 Oct 2023 03:38:31 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c358c00b00401b242e2e6sm13958516wmq.47.2023.10.23.03.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 03:38:31 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Xu
 <peterx@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,  "leobras@redhat.com"
 <leobras@redhat.com>,  "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [PATCH 0/5] Live Migration Acceleration with IAA Compression
In-Reply-To: <BY5PR11MB4388F9495DD42ACCFB980A6CA3D8A@BY5PR11MB4388.namprd11.prod.outlook.com>
 (Yuan1 Liu's message of "Mon, 23 Oct 2023 08:33:44 +0000")
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <87cyxa6dso.fsf@secure.mitica> <ZTFCnqbbqlmsUkRC@redhat.com>
 <ZTFJ84SnSOAcU5gY@x1n> <ZTFL+N3mxESxXpfv@redhat.com>
 <BY5PR11MB4388F9495DD42ACCFB980A6CA3D8A@BY5PR11MB4388.namprd11.prod.outlook.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 23 Oct 2023 12:38:30 +0200
Message-ID: <87h6mhtyhl.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

"Liu, Yuan1" <yuan1.liu@intel.com> wrote:
>> -----Original Message-----
>> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Sent: Thursday, October 19, 2023 11:32 PM
>> To: Peter Xu <peterx@redhat.com>
>> Cc: Juan Quintela <quintela@redhat.com>; Liu, Yuan1
>> <yuan1.liu@intel.com>; farosas@suse.de; leobras@redhat.com; qemu-
>> devel@nongnu.org; Zou, Nanhai <nanhai.zou@intel.com>
>> Subject: Re: [PATCH 0/5] Live Migration Acceleration with IAA Compression
>>=20
>> On Thu, Oct 19, 2023 at 11:23:31AM -0400, Peter Xu wrote:
>> > On Thu, Oct 19, 2023 at 03:52:14PM +0100, Daniel P. Berrang=C3=A9 wrot=
e:
>> > > On Thu, Oct 19, 2023 at 01:40:23PM +0200, Juan Quintela wrote:
>> > > > Yuan Liu <yuan1.liu@intel.com> wrote:
>> > > > > Hi,
>> > > > >
>> > > > > I am writing to submit a code change aimed at enhancing live
>> > > > > migration acceleration by leveraging the compression capability
>> > > > > of the Intel In-Memory Analytics Accelerator (IAA).
>> > > > >
>> > > > > Enabling compression functionality during the live migration
>> > > > > process can enhance performance, thereby reducing downtime and
>> > > > > network bandwidth requirements. However, this improvement comes
>> > > > > at the cost of additional CPU resources, posing a challenge for
>> > > > > cloud service providers in terms of resource allocation. To
>> > > > > address this challenge, I have focused on offloading the compres=
sion
>> overhead to the IAA hardware, resulting in performance gains.
>> > > > >
>> > > > > The implementation of the IAA (de)compression code is based on
>> > > > > Intel Query Processing Library (QPL), an open-source software
>> > > > > project designed for IAA high-level software programming.
>> > > > >
>> > > > > Best regards,
>> > > > > Yuan Liu
>> > > >
>> > > > After reviewing the patches:
>> > > >
>> > > > - why are you doing this on top of old compression code, that is
>> > > >   obsolete, deprecated and buggy
> Some users have not enabled the multifd feature yet, but they will
> decide whether to enable the compression feature based on the load
> situation. So I'm wondering if, without multifd, the compression
> functionality will no longer be available?

Next pull request will deprecate it.  So in two versions is going to be gon=
e.

>> > > > - why are you not doing it on top of multifd.

> I plan to submit the support for multifd independently because the
> multifd compression and legacy compression code are separate.

compression code is really buggy.  I think you should not even try to
work on top of it.


> I looked at the code of multifd about compression. Currently, it uses
> the CPU synchronous compression mode. Since it is best to use the
> asynchronous processing method of the hardware accelerator, I would
> like to get suggestions on the asynchronous implementation.

I did that on a previous comment.
Several questions:

- you are using zlib, right?  When I tested, the longer streams you
  have, the better compression you get. right?
  Is there a way to "continue" with the state of the previous job?

  Old compression code, generates a new context for every packet.
  Multifd generates a new zlib context for each connection.


> 1. Dirty page scanning and compression pipeline processing, the main
> thread of live migration submits compression tasks to the hardware,
> and multifd threads only handle the transmission of compressed pages.
> 2. Data sending and compression pipeline processing, the Multifd
> threads submit compression tasks to the hardware and then transmit the
> compressed data. (A multifd thread job may need to transmit compressed
> data multiple times.)
>
>> > > > You just need to add another compression method on top of multifd.
>> > > > See how it was done for zstd:
> Yes, I will refer to zstd to implement multifd compression with IAA

Basically you can use two approachs here (simplifying a lot)
- for each channel
     submit job (512KB)
     wait for job
     send compressed stuff
  And you adjust the number of channels depending on how much
  concurrency you want.


- for each channel
     submit job
     while (number_of_jobs_submitted > some_threshold)
        wait_for_job
        send job
  Here you need to piggy back in the MULTIFD_FLAG_SYNC to wait for the
  rest of jobs.

Each one has its advantages/disadvantages.  With the 1st, it is simpler
to do, because it is for all effects synchronous, and simpler to
"contain" the concurrency.

With the second approach you get much more concurrency, but you need to
be careful about how much stuff do you have in flight.

Remember that you get queueds for each multifd channel.
How much asynchronous jobs (around 512KB each packet) can current
hardware handle?  I mean what is the optimus number, around 10, around
50, around 100?


>> > > I'm not sure that is ideal approach.  IIUC, the IAA/QPL library is
>> > > not defining a new compression format. Rather it is providing a
>> > > hardware accelerator for 'deflate' format, as can be made compatible
>> > > with zlib:
>> > >
>> > >
>> > > https://intel.github.io/qpl/documentation/dev_guide_docs/c_use_cases
>> > > /deflate/c_deflate_zlib_gzip.html#zlib-and-gzip-compatibility-refere
>> > > nce-link
>> > >
>> > > With multifd we already have a 'zlib' compression format, and so
>> > > this IAA/QPL logic would effectively just be a providing a second
>> > > implementation of zlib.
>> > >
>> > > Given the use of a standard format, I would expect to be able to use
>> > > software zlib on the src, mixed with IAA/QPL zlib on the target, or
>> > > vica-verca.
>> > >
>> > > IOW, rather than defining a new compression format for this, I think
>> > > we could look at a new migration parameter for
>> > >
>> > > "compression-accelerator": ["auto", "none", "qpl"]
>> > >
>> > > with 'auto' the default, such that we can automatically enable
>> > > IAA/QPL when 'zlib' format is requested, if running on a suitable
>> > > host.
>> >
>> > I was also curious about the format of compression comparing to
>> > software ones when reading.
>> >
>> > Would there be a use case that one would prefer soft compression even
>> > if hardware accelerator existed, no matter on src/dst?
>> >
>> > I'm wondering whether we can avoid that one more parameter but always
>> > use hardware accelerations as long as possible.
> I want to add a new compression format(QPL or IAA-Deflate) here. The reas=
ons are as follows:
> 1. The QPL library already supports both software and hardware paths
> for compression.

The question is if IAA-Deflate is compatible with zlib-deflate.
What are the advantages of QPL software implementation vs zlib?
- Is it faster?
- Does it uses less resources.

> The software path uses a fast Deflate compression
> algorithm, while the hardware path uses IAA.

Is it faster than zlib?
And doing all of this asynchronous job dance is not going to be slower
than just calling the functions in a software implementation?

> 2. QPL's software and hardware paths are based on the Deflate
> algorithm, but there is a limitation: the history buffer only supports
> 4K. The default history buffer for zlib is 32K, which means that IAA
> cannot decompress zlib-compressed data. However, zlib can decompress
> IAA-compressed data.

Aha.  Thanks, that was what we wanted to know.

> 3. For zlib and zstd, Intel QuickAssist Technology can accelerate both of=
 them.

Do we have any number than we could look at?
We are interested in three things:
- how faster is it
- how much cpu is saved using IAA
- how much latency does it add

Thanks, Juan.

>> Yeah, I did wonder about whether we could avoid a parameter, but then I'm
>> thinking  it is good to have an escape hatch if we were to find any flaw=
s in the
>> QPL library's impl of deflate() that caused interop problems.
>>=20
>> With regards,
>> Daniel
>> --
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberra=
nge :|
>> |: https://libvirt.org         -o-            https://fstop138.berrange.=
com :|
>> |: https://entangle-photo.org    -o-
>> https://www.instagram.com/dberrange :|


