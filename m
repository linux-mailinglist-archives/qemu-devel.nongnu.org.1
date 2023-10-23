Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D8D7D3061
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 12:49:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qusTW-0006pG-Ew; Mon, 23 Oct 2023 06:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qusTT-0006nu-Tz
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qusTQ-0003ZC-QD
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698058070;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cl6bdK5rl00VrQqIl1hFBrTSBiwOQ6xNbhLOua3NP4=;
 b=g699VaBEh9ulmhVe3wPwpOgzIPBW5LBd6JtJnHNZAbHS8Aic0AaB0LIHUFnXVIpYbW6CnH
 1jcKgsr1ThsKcsvQ0wXWv5orrb5jWy9sPSZfpn0mOSgA8GxKZCJ+q7z5LbI/eq8Y/8MyJK
 nwgUDcXxEDvrJHa8tvIRNTK7/FjBR1s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-J-HuZXwKN46Inii8sN-K9Q-1; Mon, 23 Oct 2023 06:47:48 -0400
X-MC-Unique: J-HuZXwKN46Inii8sN-K9Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507cb169766so3050059e87.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 03:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698058067; x=1698662867;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cl6bdK5rl00VrQqIl1hFBrTSBiwOQ6xNbhLOua3NP4=;
 b=Ea2WAzZbKvY4Nlq8SO+zYpiiZNP463pPFBQFM867ulUG/e/PMalQWCGqjWO5iZ79tc
 dANawQodbVd0c2NUX3vNgVSbQdbKIAaby+x2CLr4DsohKFiu5eYKiyD7J84LyF8Px0pJ
 GTPuQK8KQPer+acItfYt/luJmHiFXWVGL7aCG71n56KgL34fQlcXj74UztQR1G2Lb373
 8q09aqhsJl7uHjiFjQjeJlre8PeyYn++L6zn0GxF67HdTi4IZccl3I3gQ8+KaUcaT7v4
 jIcQMSYwcOq4C/tW32niAbM4r9Y6Bv78W3vtUZWZOocngjVHI92lkq9o30ybPzaG8hh/
 qCgg==
X-Gm-Message-State: AOJu0Yyl6RCvr+ksxdehpU5Q+bFBmmEaJlXHp0YaztoRQvVC5yUfGHzZ
 MMoQ6sAd6ur/D0hp3E5bmD/NB7MBRC2o8mB/p8r6gCMfp6sFf7svsoUC8qIA7QoM9O7Mgky5JmB
 ENsguTnN9OO2WM7o=
X-Received: by 2002:ac2:5df0:0:b0:500:75e5:a2f0 with SMTP id
 z16-20020ac25df0000000b0050075e5a2f0mr6423786lfq.51.1698058067202; 
 Mon, 23 Oct 2023 03:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjL8NosQ5+KbrIBy4og/6lq6hS29UmUf9pnDYG03aZkVPxJsFG9msGmN6gwaVAuKMrwhOVNw==
X-Received: by 2002:ac2:5df0:0:b0:500:75e5:a2f0 with SMTP id
 z16-20020ac25df0000000b0050075e5a2f0mr6423778lfq.51.1698058066873; 
 Mon, 23 Oct 2023 03:47:46 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 y7-20020a5d4ac7000000b0032dde679398sm7496105wrs.8.2023.10.23.03.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 03:47:46 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Liu, Yuan1" <yuan1.liu@intel.com>,  Peter Xu <peterx@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,  "leobras@redhat.com"
 <leobras@redhat.com>,  "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [PATCH 0/5] Live Migration Acceleration with IAA Compression
In-Reply-To: <ZTZLI1r+U5EbX12E@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 23 Oct 2023 11:29:55 +0100")
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <87cyxa6dso.fsf@secure.mitica> <ZTFCnqbbqlmsUkRC@redhat.com>
 <ZTFJ84SnSOAcU5gY@x1n> <ZTFL+N3mxESxXpfv@redhat.com>
 <BY5PR11MB4388F9495DD42ACCFB980A6CA3D8A@BY5PR11MB4388.namprd11.prod.outlook.com>
 <ZTZLI1r+U5EbX12E@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 23 Oct 2023 12:47:45 +0200
Message-ID: <87cyx5ty26.fsf@secure.mitica>
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Mon, Oct 23, 2023 at 08:33:44AM +0000, Liu, Yuan1 wrote:
>> > -----Original Message-----
>> > From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Sent: Thursday, October 19, 2023 11:32 PM
>> > To: Peter Xu <peterx@redhat.com>
>> > Cc: Juan Quintela <quintela@redhat.com>; Liu, Yuan1
>> > <yuan1.liu@intel.com>; farosas@suse.de; leobras@redhat.com; qemu-
>> > devel@nongnu.org; Zou, Nanhai <nanhai.zou@intel.com>
>> > Subject: Re: [PATCH 0/5] Live Migration Acceleration with IAA Compress=
ion
>> >=20
>> > On Thu, Oct 19, 2023 at 11:23:31AM -0400, Peter Xu wrote:
>> > > On Thu, Oct 19, 2023 at 03:52:14PM +0100, Daniel P. Berrang=C3=A9 wr=
ote:
>> > > > On Thu, Oct 19, 2023 at 01:40:23PM +0200, Juan Quintela wrote:
>> > > > > Yuan Liu <yuan1.liu@intel.com> wrote:
>> > > > > > Hi,
>> > > > > >
>> > > > > > I am writing to submit a code change aimed at enhancing live
>> > > > > > migration acceleration by leveraging the compression capability
>> > > > > > of the Intel In-Memory Analytics Accelerator (IAA).
>> > > > > >
>> > > > > > Enabling compression functionality during the live migration
>> > > > > > process can enhance performance, thereby reducing downtime and
>> > > > > > network bandwidth requirements. However, this improvement comes
>> > > > > > at the cost of additional CPU resources, posing a challenge for
>> > > > > > cloud service providers in terms of resource allocation. To
>> > > > > > address this challenge, I have focused on offloading the compr=
ession
>> > overhead to the IAA hardware, resulting in performance gains.
>> > > > > >
>> > > > > > The implementation of the IAA (de)compression code is based on
>> > > > > > Intel Query Processing Library (QPL), an open-source software
>> > > > > > project designed for IAA high-level software programming.
>> > > > >
>> > > > > After reviewing the patches:
>> > > > >
>> > > > > - why are you doing this on top of old compression code, that is
>> > > > >   obsolete, deprecated and buggy
>> Some users have not enabled the multifd feature yet, but they will
>> decide whether to enable the compression feature based on the load
>> situation. So I'm wondering if, without multifd, the compression
>> functionality will no longer be available?
>>=20
>> > > > > - why are you not doing it on top of multifd.
>> I plan to submit the support for multifd independently because the
>> multifd compression and legacy compression code are separate.
>
> So the core question her (for migration maintainers) is whether
> contributors should be spending any time at all on non-multifd
> code, or if new features should be exclusively for multifd ?

Only for multifd.

Comparison right now:
- compression (can be done better in multifd)
- plain precopy (we can satturate faster networks with multifd)
- xbzrle: right now only non-multifd (plan to add as another multifd
          compression method)
- exec: This is a hard one.  Fabiano is about to submit a file based
        multifd method.  Advantages over exec:
          * much less space used (it writes each page at the right
            position, no overhead and never the same page on the two
            streams)
          * We can give proper errors, exec is very bad when the exec'd
            process gives an error.
        Disadvantages:
          * libvirt (or any management app) needs to wait for
            compression to end, and launch the exec command by hand.
            I wanted to discuss this with libvirt, if it would be
            possible to remove the use of exec compression.
- rdma: This is a hard one
        Current implementation is a mess
        It is almost un-maintained
        There are two-three years old patches to move it on top of
        multifd
- postcopy: Not implemented.  This is the real reason that we can't
        deprecate precopy and put multifd as default.
- snapshots:  They are to coupled with qcow2.  It should be possible to
        do something more sensible with multifd + file, but we need to walk=
 that
        path when multifd + file hit the tree.

> I doesn't make a lot of sense over the long term to have people
> spending time implementing the same features twice. IOW, should
> we be directly contributors explicitly towards multifd only,
> and even consider deprecating non-multifd code at some time ?

Intel submited something similarish to this on top of QAT several months
back.  I already advised them not to use any time on top of old
compression code and just do things on top of multifd.

Once that we are here, what are the differ]ences of QPL and QAT?
Previous submission used qatzip-devel.

Later, JUan.

>> > > > I'm not sure that is ideal approach.  IIUC, the IAA/QPL library is
>> > > > not defining a new compression format. Rather it is providing a
>> > > > hardware accelerator for 'deflate' format, as can be made compatib=
le
>> > > > with zlib:
>> > > >
>> > > >
>> > > > https://intel.github.io/qpl/documentation/dev_guide_docs/c_use_cas=
es
>> > > > /deflate/c_deflate_zlib_gzip.html#zlib-and-gzip-compatibility-refe=
re
>> > > > nce-link
>> > > >
>> > > > With multifd we already have a 'zlib' compression format, and so
>> > > > this IAA/QPL logic would effectively just be a providing a second
>> > > > implementation of zlib.
>> > > >
>> > > > Given the use of a standard format, I would expect to be able to u=
se
>> > > > software zlib on the src, mixed with IAA/QPL zlib on the target, or
>> > > > vica-verca.
>> > > >
>> > > > IOW, rather than defining a new compression format for this, I thi=
nk
>> > > > we could look at a new migration parameter for
>> > > >
>> > > > "compression-accelerator": ["auto", "none", "qpl"]
>> > > >
>> > > > with 'auto' the default, such that we can automatically enable
>> > > > IAA/QPL when 'zlib' format is requested, if running on a suitable
>> > > > host.
>> > >
>> > > I was also curious about the format of compression comparing to
>> > > software ones when reading.
>> > >
>> > > Would there be a use case that one would prefer soft compression even
>> > > if hardware accelerator existed, no matter on src/dst?
>> > >
>> > > I'm wondering whether we can avoid that one more parameter but always
>> > > use hardware accelerations as long as possible.
>>
>> I want to add a new compression format(QPL or IAA-Deflate) here.
>> The reasons are as follows:
>>
>> 1. The QPL library already supports both software and hardware paths
>>    for compression. The software path uses a fast Deflate compression
>>    algorithm, while the hardware path uses IAA.
>
> That's not a reason to describe this as a new format in QEMU. It is
> still deflate, and so conceptually we can model this as 'zlib' and
> potentially choose to use QPL automatically.
>
>> 2. QPL's software and hardware paths are based on the Deflate algorithm,
>>    but there is a limitation: the history buffer only supports 4K. The
>>    default history buffer for zlib is 32K, which means that IAA cannot
>>    decompress zlib-compressed data. However, zlib can decompress IAA-
>>    compressed data.
>
> That's again not a reason to call it a new compression format in
> QEMU. It would mean, however, if compression-accelerator=3Dauto, we
> would not be able to safely enable QPL on the incoming QEMU, as we
> can't be sure the src used a 4k window.  We could still automatically
> enable QPL on outgoing side though.
>
>> 3. For zlib and zstd, Intel QuickAssist Technology can accelerate
>>    both of them.
>
> What's the difference between this, and the IAA/QPL ?=20
>
> With regards,
> Daniel


