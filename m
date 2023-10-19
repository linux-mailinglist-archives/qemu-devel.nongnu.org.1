Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8457CFDE4
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:32:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUzq-0005k9-4h; Thu, 19 Oct 2023 11:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtUzT-0005hQ-JH
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtUzR-0006Vp-0r
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697729471;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oeY7IHzPGOdud9NsX8DTwa8zYbDAMgb1qmg27CVJ6cs=;
 b=YeQCFo1Z/jci2LhVIZVyIEdxh/kAd5JqlE5bXyCpeA27XQYWqPcthjV1jfbDQRuaC7y06x
 LAWS/S7HtMZlJwi1zo0SlNq9ywUDsdve+l0t6neD6lfLpiLxARl9TSKoWjfZRTaYKwM7Iw
 ciR0HOS98JOxSPLCYonJBkMII/zbmQ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-22NyCygxNvqqvnC5TFUFtg-1; Thu, 19 Oct 2023 11:31:10 -0400
X-MC-Unique: 22NyCygxNvqqvnC5TFUFtg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4084e4ce543so965085e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697729469; x=1698334269;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oeY7IHzPGOdud9NsX8DTwa8zYbDAMgb1qmg27CVJ6cs=;
 b=GnGAxgok2YaJY9mB+fZmDp5HZUEyzoJ+9xclqadFcWO4/c3L6MDHEX3OyAu5E/Brrp
 U/ppZ7xyg4yuvAP7yPeMHRbAZaEQBf07uO796TnmAne/hEwPfhT9xSI5HPHJciOLYtW7
 8FaZDfqK9eRGysCS6/8jxBNUGBXjN+xcOr4NcbO0LhUav9tw+2RigZOMBlTI/HcB2nfV
 3dLDOZRCusnacFoyfz0u81o3uv7vYSqrazqukSl96TCyZFlhTKGiB5/Vjwf2SttK05yh
 Gacnpl2k+oTkFJh+tp9sqYgpit5C0en1yCaEhuyQZ/kNxN+a8qd+cNwhiR5s8VvZuJ2h
 IQbA==
X-Gm-Message-State: AOJu0YxDjH1InzeQOaos65LdqyZz1pdyJBENYpB7YwdrwfdxJ+4I3Sjg
 J1QmISc7aLuDK3ckcbg9b2D2sH/EMist0V+L1pKjEGKoVBVTvboXfGrj9G1PCFOBgyIiX7R+vAK
 JOoTGCxhTEF9VtGI=
X-Received: by 2002:a5d:54d1:0:b0:32d:9787:53bc with SMTP id
 x17-20020a5d54d1000000b0032d978753bcmr1911250wrv.62.1697729468936; 
 Thu, 19 Oct 2023 08:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXpsGa0IbqOdZIxkZ5XFAl69HBvVHsH/dbH1YV7AERS7cfthkdBOjfOkQgob1cDMzDPou/Sg==
X-Received: by 2002:a5d:54d1:0:b0:32d:9787:53bc with SMTP id
 x17-20020a5d54d1000000b0032d978753bcmr1911231wrv.62.1697729468594; 
 Thu, 19 Oct 2023 08:31:08 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 j1-20020adfea41000000b0032dcb08bf94sm4736301wrn.60.2023.10.19.08.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:31:07 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Yuan Liu
 <yuan1.liu@intel.com>,  farosas@suse.de,  leobras@redhat.com,
 qemu-devel@nongnu.org,  nanhai.zou@intel.com
Subject: Re: [PATCH 0/5] Live Migration Acceleration with IAA Compression
In-Reply-To: <ZTFJ84SnSOAcU5gY@x1n> (Peter Xu's message of "Thu, 19 Oct 2023
 11:23:31 -0400")
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <87cyxa6dso.fsf@secure.mitica> <ZTFCnqbbqlmsUkRC@redhat.com>
 <ZTFJ84SnSOAcU5gY@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 17:31:06 +0200
Message-ID: <87o7gu39z9.fsf@secure.mitica>
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

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Oct 19, 2023 at 03:52:14PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, Oct 19, 2023 at 01:40:23PM +0200, Juan Quintela wrote:
>> > Yuan Liu <yuan1.liu@intel.com> wrote:
>> > > Hi,
>> > >
>> > > I am writing to submit a code change aimed at enhancing live migrati=
on
>> > > acceleration by leveraging the compression capability of the Intel
>> > > In-Memory Analytics Accelerator (IAA).
>> > >
>> > > Enabling compression functionality during the live migration process=
 can
>> > > enhance performance, thereby reducing downtime and network bandwidth
>> > > requirements. However, this improvement comes at the cost of additio=
nal
>> > > CPU resources, posing a challenge for cloud service providers in ter=
ms of
>> > > resource allocation. To address this challenge, I have focused on of=
floading
>> > > the compression overhead to the IAA hardware, resulting in performan=
ce gains.
>> > >
>> > > The implementation of the IAA (de)compression code is based on Intel=
 Query
>> > > Processing Library (QPL), an open-source software project designed f=
or
>> > > IAA high-level software programming.
>> > >
>> > > Best regards,
>> > > Yuan Liu
>> >=20
>> > After reviewing the patches:
>> >=20
>> > - why are you doing this on top of old compression code, that is
>> >   obsolete, deprecated and buggy
>> >=20
>> > - why are you not doing it on top of multifd.
>> >=20
>> > You just need to add another compression method on top of multifd.
>> > See how it was done for zstd:
>>=20
>> I'm not sure that is ideal approach.  IIUC, the IAA/QPL library
>> is not defining a new compression format. Rather it is providing
>> a hardware accelerator for 'deflate' format, as can be made
>> compatible with zlib:
>>=20
>>   https://intel.github.io/qpl/documentation/dev_guide_docs/c_use_cases/d=
eflate/c_deflate_zlib_gzip.html#zlib-and-gzip-compatibility-reference-link
>>=20
>> With multifd we already have a 'zlib' compression format, and so
>> this IAA/QPL logic would effectively just be a providing a second
>> implementation of zlib.
>>=20
>> Given the use of a standard format, I would expect to be able
>> to use software zlib on the src, mixed with IAA/QPL zlib on
>> the target, or vica-verca.
>>=20
>> IOW, rather than defining a new compression format for this,
>> I think we could look at a new migration parameter for
>>=20
>> "compression-accelerator": ["auto", "none", "qpl"]
>>=20
>> with 'auto' the default, such that we can automatically enable
>> IAA/QPL when 'zlib' format is requested, if running on a suitable
>> host.
>
> I was also curious about the format of compression comparing to software
> ones when reading.
>
> Would there be a use case that one would prefer soft compression even if
> hardware accelerator existed, no matter on src/dst?
>
> I'm wondering whether we can avoid that one more parameter but always use
> hardware accelerations as long as possible.

I asked for some benchmarks.
But they need to be againtst not using compression (i.e. plain precopy)
or against using multifd-zlib.

For a single page, I don't know if the added latency will be a winner in
general.

Later, Juan.


