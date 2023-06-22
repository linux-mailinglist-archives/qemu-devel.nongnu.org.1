Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A6F73A7AB
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:50:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCORl-0003DG-7e; Thu, 22 Jun 2023 13:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCORO-0003A4-7P
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCORM-0006fN-NX
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687456192;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YHwvS6rAGcs2wdpcWBIv9mtD+iNSvYH1OhsjqcxnGok=;
 b=PKqaYzFRHbUy6swFcssE80Vm4W+85pXJf0Tih4+Hh0WVW8jcsudIIHS4lGN4UeYYzEzE40
 eXSTilG0GJJDF/5XP5teKZZjO1ZgrsHgKandZeolsLL6/hivGx7/tYzTSOOg7JY99e0pzS
 IxacXRQSzWlCoZPaBciK2Mf2r2WCs3w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-kb-tsBWbPfSH0jBtVd0GBg-1; Thu, 22 Jun 2023 13:49:50 -0400
X-MC-Unique: kb-tsBWbPfSH0jBtVd0GBg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31118de9a69so2956341f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 10:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687456189; x=1690048189;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YHwvS6rAGcs2wdpcWBIv9mtD+iNSvYH1OhsjqcxnGok=;
 b=grxnCiU6G2xoFhiukZ+clbbHS8aMhVgI225eaVkZB8osWEgJZjcWZHjJCT+SrughDc
 WYKICGr5A61y+jBC7fZEi/0s5X0HK3ZbZfyWqEI5azwEju4MWlMc20588l/pnqE908SD
 2k/e16AH3zAau6S9uR2WNbnIedc7svgopIu+R9hf45Odt4bLoEJuVZJmXLkrqEaKQOUi
 9uKym+8C+RG4e5melZ0l6lrW9iddi3J0tG1lwixoFDZ4gDTfQ8Ke27tNECZ31dOrD2/y
 xK25HaRQOV+FIvxVnjAVBzFA1gRgAVnRmkImvs5/ItgrgQIpZRc2QnQQQZd5bb4RXa2l
 3LeQ==
X-Gm-Message-State: AC+VfDxdMXNIjF/Zy6S/l5iE9HnAppTZNR54bv6jbpmuhK1skB1cF6xx
 AVfaHUwHzlKDuhhJTi/oWBnXzxTEiNXAeR5MkeVAkowWk+eWtu1uey05HdfvYVDv5SKY+c9ODo0
 FOdDnUMjZuHsLnEI=
X-Received: by 2002:a5d:4530:0:b0:30f:c040:169f with SMTP id
 j16-20020a5d4530000000b0030fc040169fmr13354471wra.33.1687456189549; 
 Thu, 22 Jun 2023 10:49:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6I7ZFMTY5v30HeOsCMJzg9nf/TFoUlhT1TuH5zHBOGwqobrpPJWF+75F+FkvRKa1ZrNl9Uag==
X-Received: by 2002:a5d:4530:0:b0:30f:c040:169f with SMTP id
 j16-20020a5d4530000000b0030fc040169fmr13354456wra.33.1687456189247; 
 Thu, 22 Jun 2023 10:49:49 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 l8-20020a05600012c800b0030ae4350212sm7560750wrx.66.2023.06.22.10.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 10:49:48 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  qemu-block@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  Thomas Huth
 <thuth@redhat.com>,  libvir-list@redhat.com,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [RFC 1/6] migration: skipped field is really obsolete.
In-Reply-To: <ZJGVJiL7HX49RSfu@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 20 Jun 2023 13:01:42 +0100")
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-2-quintela@redhat.com>
 <ZJGVJiL7HX49RSfu@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 19:49:47 +0200
Message-ID: <87a5wrfkuc.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Mon, Jun 12, 2023 at 09:33:39PM +0200, Juan Quintela wrote:
>> Has return zero for more than 10 years.  Just mark it deprecated.
>
> Specifically we introduced the field in 1.5.0
>
> commit f1c72795af573b24a7da5eb52375c9aba8a37972
> Author: Peter Lieven <pl@kamp.de>
> Date:   Tue Mar 26 10:58:37 2013 +0100
>
>     migration: do not sent zero pages in bulk stage
>=20=20=20=20=20
>     during bulk stage of ram migration if a page is a
>     zero page do not send it at all.
>     the memory at the destination reads as zero anyway.
>=20=20=20=20=20
>     even if there is an madvise with QEMU_MADV_DONTNEED
>     at the target upon receipt of a zero page I have observed
>     that the target starts swapping if the memory is overcommitted.
>     it seems that the pages are dropped asynchronously.
>=20=20=20=20=20
>     this patch also updates QMP to return the number of
>     skipped pages in MigrationStats.
>=20=20=20=20=20
>
>
> but removed its usage in 1.5.3
>
> commit 9ef051e5536b6368a1076046ec6c4ec4ac12b5c6
> Author: Peter Lieven <pl@kamp.de>
> Date:   Mon Jun 10 12:14:19 2013 +0200
>
>     Revert "migration: do not sent zero pages in bulk stage"
>=20=20=20=20=20
>     Not sending zero pages breaks migration if a page is zero
>     at the source but not at the destination. This can e.g. happen
>     if different BIOS versions are used at source and destination.
>     It has also been reported that migration on pseries is completely
>     broken with this patch.
>=20=20=20=20=20
>     This effectively reverts commit f1c72795af573b24a7da5eb52375c9aba8a37=
972.


Thanks for the history O:-)

>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  docs/about/deprecated.rst | 10 ++++++++++
>>  qapi/migration.json       | 12 ++++++++++--
>>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index cb7cd3e578..bcae193733 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -23,7 +23,8 @@
>>  #
>>  # @duplicate: number of duplicate (zero) pages (since 1.2)
>>  #
>> -# @skipped: number of skipped zero pages (since 1.5)
>> +# @skipped: number of skipped zero pages. Don't use, only provided for
>> +#     compatibility (since 1.5)
>
> I'd say
>
>    @skipped: number of skipped zero pages. Always zero, only provided for
>    compatibility (since 1.5)

Changed.

>>  #
>>  # @normal: number of normal pages (since 1.2)
>>  #
>> @@ -62,11 +63,18 @@
>>  #     between 0 and @dirty-sync-count * @multifd-channels.  (since
>>  #     7.1)
>>  #
>> +# Features:
>> +#
>> +# @deprecated: Member @skipped has not been used for a long time.
>
>   @deprecated: Member @skipped is always zero since 1.5.3

Changed.

Thanks.


