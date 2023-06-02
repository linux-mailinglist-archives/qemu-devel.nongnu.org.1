Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A7171FDC4
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:25:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q512S-0006qT-Og; Fri, 02 Jun 2023 05:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q512M-0006px-VZ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q512L-0002gz-8T
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685697932;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cBSrWcHzQ899S+3aZsYi4TN09is6+2JcyCex31MxsM=;
 b=Tlv2YBNYxMVsyRaUp3/5rhDXlqqE4DZLb3fFO96KjYis0r+u7rCRu2g72Po31yioBMiR90
 VyNSLMY8jtu/XkCNc0+xJd2N7urvIX9ZgbIuNZwXhKsH1NlWIViDL8K4PP3uQWgJTi8RuR
 cUjvIKSaEXWtUuO6mnyfb6YkaT786fc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-cfgCc95SN6eK-XsbNsdvSA-1; Fri, 02 Jun 2023 05:25:31 -0400
X-MC-Unique: cfgCc95SN6eK-XsbNsdvSA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f4c62e0c9eso1397831e87.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 02:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685697930; x=1688289930;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2cBSrWcHzQ899S+3aZsYi4TN09is6+2JcyCex31MxsM=;
 b=gqu7hURqFZQyVSHdn26vSSzJ1COFVptc6QGejEVHZkN3xgaVCLGJI37KkYlgl5m7K0
 T1p8sJzJdy7SiXYMUlAeJf6pwegZyqY7eOiB2Onzav9PZQF0OmUbCwvO9mCbGJ1c2iEi
 LPHzDrfs9/XMBILIAb7dqj0EpZ0lFzWWsDDlJnoWZvykyOMAfLMPjxB7k4k7WZ6QSz5r
 UYfxszxGHzR5ocIdwnPsNgiUvqy/jz01YVtvdt8DjntaMwCbcDcahJABIGjeF0y0kavp
 E0sxh+0d9g7EAohju6ad5sKhAckwBBMS5TeKqOPHq92RymJwumFSTC3/d7tInCUD8VaP
 mzCQ==
X-Gm-Message-State: AC+VfDx7y8xrgOpW60aFWlkqrcHW4XH/ZjaOxwu5n5WBAU8Mlr0thgHS
 WnYxhwWOq4F1Y/ojHfLMtmbpFLBU7KPUU9BdzKZy5FOz24t7UmJV+JasbT6YuSjsel/IAlpUUVC
 hh1cVTab099tuF8g=
X-Received: by 2002:a19:740f:0:b0:4f3:93d4:2bc7 with SMTP id
 v15-20020a19740f000000b004f393d42bc7mr1746052lfe.36.1685697929906; 
 Fri, 02 Jun 2023 02:25:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7gGlr41tfATC2U/ukzxMZTKTZ3vkFF82WJ2Hb+GVfHtf0x4zJPuITuAeCEl/xQR/ZwUb1acg==
X-Received: by 2002:a19:740f:0:b0:4f3:93d4:2bc7 with SMTP id
 v15-20020a19740f000000b004f393d42bc7mr1746037lfe.36.1685697929470; 
 Fri, 02 Jun 2023 02:25:29 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 l22-20020a1c7916000000b003f6f6a6e760sm4918231wme.32.2023.06.02.02.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 02:25:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  Richard Henderson
 <rth@twiddle.net>
Subject: Re: Big TCG slowdown when using zstd with aarch64
In-Reply-To: <ZHmyA40nIiUBceX0@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 2 Jun 2023 10:10:27 +0100")
References: <87y1l2rixp.fsf@secure.mitica> <ZHmyA40nIiUBceX0@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 02 Jun 2023 11:25:28 +0200
Message-ID: <87pm6ep65z.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Thu, Jun 01, 2023 at 11:06:42PM +0200, Juan Quintela wrote:
>>=20
>> Hi
>>=20
>> Before I continue investigating this further, do you have any clue what
>> is going on here.  I am running qemu-system-aarch64 on x86_64.
>>=20
>> $ time ./tests/qtest/migration-test -p /aarch64/migration/multifd/tcp/pl=
ain/none
>
>
>> real	0m4.559s
>> user	0m4.898s
>> sys	0m1.156s
>
>> $ time ./tests/qtest/migration-test -p /aarch64/migration/multifd/tcp/pl=
ain/zlib
>
>> real	0m1.645s
>> user	0m3.484s
>> sys	0m0.512s
>> $ time ./tests/qtest/migration-test -p /aarch64/migration/multifd/tcp/pl=
ain/zstd
>
>> real	0m48.022s
>> user	8m17.306s
>> sys	0m35.217s
>>=20
>>=20
>> This test is very amenable to compression, basically we only modify one
>> byte for each page, and basically all the pages are the same.
>>=20
>> no compression: 4.5 seconds
>> zlib compression: 1.6 seconds (inside what I would expect)
>> zstd compression: 48 seconds, what is going on here?
>
> This is non-deterministic. I've seen *all* three cases complete in approx
> 1 second each. If I set 'QTEST_LOG=3D1', then very often the zstd test wi=
ll
> complete in < 1 second.

Not in my case.
/me goes and checks again.

Low and behold, today it don't fails.

Notice that I am running qemu-system-aarch64 in x86_64 host.
Yesterday I was unable to reproduce it with kvm x86_64 in x86_64 host.

And for aarch64 I reproduced it like 20 times in a row, that is why I
decided to send this email.

In all the other cases, it behaves as expected.  This is one of the few
cases where compression is way better than not compression.  But
remember that compression uses dictionaries, and for each page it sends
the equivalent of:

1st page: create dictionary, something that represents 1 byte with value
          X and TARGET_PAGE_SIZE -1 zeros
Next 63 pages in the packet: copy the previous dictionary 63 times.

I investigated it when I created multifd-zlib because the size of the
packet that described 64 pages content was ridiculous, something like
4-8 bytes (yes, I don't remember, but it was way, way less that 1 byte
per page).

> I notice the multifd tests are not sharing the setup logic with the
> precopy tests, so they have no set any migration bandwidth limit.
> IOW migration is running at full speed.

Aha.

> What I happening is that the migrate is runing so fast that the guest
> workload hasn't had the chance to dirty any memory, so 'none' and 'zlib'
> tests only copy about 15-30 MB of data, the rest is still all zeroes.
>
> When it is fast, the zstd test also has similar low transfer of data,
> but when it is slow then it transfers a massive amount more, and goes
> through a *huge* number of iterations
>
> eg I see dirty-sync-count over 1000:

Aha, will try to print that info.

> {"return": {"expected-downtime": 221243, "status": "active",
> "setup-time": 1, "total-time": 44028, "ram": {"total": 291905536,
> "postcopy-requests": 0, "dirty-sync-count": 1516, "multifd-bytes":
> 24241675, "pages-per-second": 804571, "downtime-bytes": 0,
> "page-size": 4096, "remaining": 82313216, "postcopy-bytes": 0, "mbps":
> 3.7536507936507939, "transferred": 25377710,
> "dirty-sync-missed-zero-copy": 0, "precopy-bytes": 1136035,
> "duplicate": 124866, "dirty-pages-rate": 850637, "skipped": 0,
> "normal-bytes": 156904067072, "normal": 38306657}}}
>
>
> I suspect that the zstd logic takes a little bit longer in setup,
> which allows often allows the guest dirty workload to get ahead of
> it, resulting in a huge amount of data to transfer. Every now and
> then the compression code gets ahead of the workload and thus most
> data is zeros and skipped.

That makes sense.  I think that the other problem that I am having this
days is that I am loading my machine a lot (basically running
make check in both branches at the same time, and that makes this much
more probable to happens.)

> IMHO this feels like just another example of compression being largely
> useless. The CPU overhead of compression can't keep up with the guest
> dirty workload, making the supposedly network bandwidth saving irrelevant.

I will not say that it make it useless.  But I have said since quite a
long time that compression and xbzrle only make sense if you are
migration between datacenters.  Anything that is in the same switch, or
that only needs a couple of hops in the same datacenter it makes no
sense.

Later, Juan.


