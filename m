Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9037B69A2
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:58:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneyB-0006bd-9I; Tue, 03 Oct 2023 08:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qney7-0006aP-Mi
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qney6-0005TD-53
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696337860;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RIyaI146R9Pp7iLPyQRI08X4H0ZqZiYZVmcJ1BlZ/Bc=;
 b=IBj12cIPWuFyf8XKAcOkEC+yKIXoILCEMD/FPA6XoFbfHWz2UcWYCPl+2L3zBeH26CtJqc
 uIQrVoCUqNtOiS/ywZ0likVOA4BzLzjm+PGvSo88nUXFYKiz66oAHcYomL2KqTTKOEhl20
 qwxB/7URl8dsRbSq7YbV5BtwRvN1RHc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-bptr_KG5NoG_e8DkRjn8lQ-1; Tue, 03 Oct 2023 08:57:39 -0400
X-MC-Unique: bptr_KG5NoG_e8DkRjn8lQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4055ce1e8c4so18321875e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696337858; x=1696942658;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RIyaI146R9Pp7iLPyQRI08X4H0ZqZiYZVmcJ1BlZ/Bc=;
 b=lNqrQWq+H+zWDM7TsXFC7UAxBZrfiE26rnCQ0ayHIt17HJ8ZhxR+EFLP3iZyhv1RPB
 xpBK83Pfk6loGIAm/7B6j+MfJ8DTplMArvFqMwaN2Tu7JuaV8wPvX49FP7AbVJnt5RZR
 tUHIh/lNTb53GYbmjZQ/odC8rqTPc5oo44Wt1rnP/HcLquTg2QGpUdZTCeBulB0sH8OF
 RVt6Fo3V9YNk5KWeujORgcfQAmi6UeL4WecRFi+ptAcCblTuoR4DKxul2EWBloajFUPN
 XH5LdhgpNdAZKCJMLEa4+VWSVty36eVxjk/AhKuihFdv91Gvabw4M1+FIj8gBL36paut
 mAiA==
X-Gm-Message-State: AOJu0YxtgHT8DjdUl+5n+wQkGsJdR/1nUjl82q0gEXQp7/0EjMYVZLSO
 FeY5qu7gWR4Dl5htlOIOsLNccnvKcWdnm17ZVkNA+Bc/GIRFo07fzw1Q7PF3wMpasIH7PXeL4k5
 pfxsRPvVjNd8SCk0=
X-Received: by 2002:a05:600c:3c97:b0:406:5a14:5c1e with SMTP id
 bg23-20020a05600c3c9700b004065a145c1emr2017885wmb.1.1696337857922; 
 Tue, 03 Oct 2023 05:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3lIsI7U/Zjb+sIsIC42O6kepFFizKmH4gloSYAWm9LxllEf6FS5P2HLa7RcwDS8Cu1hM9vw==
X-Received: by 2002:a05:600c:3c97:b0:406:5a14:5c1e with SMTP id
 bg23-20020a05600c3c9700b004065a145c1emr2017863wmb.1.1696337857510; 
 Tue, 03 Oct 2023 05:57:37 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 c17-20020a7bc851000000b0040641a9d49bsm1234866wml.17.2023.10.03.05.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 05:57:36 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Daniel P
 . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Zhijian Li
 <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] MAINTAINERS: Add entry for rdma migration
In-Reply-To: <ZRMOaYzpVdgORVM3@x1n> (Peter Xu's message of "Tue, 26 Sep 2023
 13:01:29 -0400")
References: <20230925133441.265455-1-peterx@redhat.com>
 <8734z2s6gz.fsf@pond.sub.org> <ZRMOaYzpVdgORVM3@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 03 Oct 2023 14:57:36 +0200
Message-ID: <87zg0z6eyn.fsf@secure.mitica>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> On Mon, Sep 25, 2023 at 03:55:08PM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > It's not obvious to many that RDMA migration is in Odd Fixes stage for=
 a
>> > long time.  Add an explicit sub entry for it (besides migration, which
>> > already covers the rdma files) to be clear on that, meanwhile add Zhij=
ian
>> > as Reviewer, so Zhijian can see the patches and review when he still h=
as
>> > the bandwidth.
>> >
>> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Cc: Juan Quintela <quintela@redhat.com>
>> > Cc: Markus Armbruster <armbru@redhat.com>
>> > Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
>> > Cc: Fabiano Rosas <farosas@suse.de>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  MAINTAINERS | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 355b1960ce..f6b21da753 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -3217,6 +3217,11 @@ F: qapi/migration.json
>> >  F: tests/migration/
>> >  F: util/userfaultfd.c
>> >=20=20
>> > +RDMA Migration
>> > +R: Li Zhijian <lizhijian@fujitsu.com>
>> > +S: Odd Fixes
>> > +F: migration/rdma*
>> > +
>> >  Migration dirty limit and dirty page rate
>> >  M: Hyman Huang <yong.huang@smartx.com>
>> >  S: Maintained
>>=20
>> Hmm...
>>=20
>>     $ scripts/get_maintainer.pl --status -f migration/rdma.cLi Zhijian <=
lizhijian@fujitsu.com> (reviewer:RDMA Migration)
>>     Juan Quintela <quintela@redhat.com> (maintainer:Migration)
>>     Peter Xu <peterx@redhat.com> (reviewer:Migration)
>>     Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
>>     qemu-devel@nongnu.org (open list:All patches CC here)
>>     Odd Fixes
>>     Maintained
>>=20
>> Contradictory status.  Do we care?
>
> Not a problem to me, but if you or anyone thinks that's better, please fe=
el
> free to post another patch to replace this one with Zhijian's ACK attache=
d.

Sending Markus version with Zhijian ACK.

>>=20
>> To avoid, try something like the appended patch.  With that one:
>>=20
>>     $ scripts/get_maintainer.pl --status -f migration/rdma.c
>>     Juan Quintela <quintela@redhat.com> (odd fixer:RDMA Migration)
>>     Li Zhijian <lizhijian@fujitsu.com> (reviewer:RDMA Migration)
>>     Peter Xu <peterx@redhat.com> (reviewer:RDMA Migration)
>>     Leonardo Bras <leobras@redhat.com> (reviewer:RDMA Migration)
>>     qemu-devel@nongnu.org (open list:All patches CC here)
>>     Odd Fixes
>>=20
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 355b1960ce..3e80857eab 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3216,6 +3216,15 @@ F: docs/devel/migration.rst
>>  F: qapi/migration.json
>>  F: tests/migration/
>>  F: util/userfaultfd.c
>> +X: migration/rdma*
>> +
>> +RDMA Migration
>> +M: Juan Quintela <quintela@redhat.com>
>> +R: Li Zhijian <lizhijian@fujitsu.com>
>> +R: Peter Xu <peterx@redhat.com>
>> +R: Leonardo Bras <leobras@redhat.com>
>> +S: Odd Fixes
>> +F: migration/rdma*
>
> It's slightly a pity we need to copy the lines, and I think this may not =
be
> the only place where we have >1 entries pointing to the same file.
>
>>=20=20
>>  Migration dirty limit and dirty page rate
>>  M: Hyman Huang <yong.huang@smartx.com>
>>=20
>
> Thanks,


