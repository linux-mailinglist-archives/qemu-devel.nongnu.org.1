Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AE47D4E91
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 13:09:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvFGm-00058l-1L; Tue, 24 Oct 2023 07:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvFGh-00054X-0P
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvFGb-0006HV-MD
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698145687;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gB4uS6S7st0CPDlJR1A4U2y2iQeTtClCP2vEdG87owg=;
 b=XJuMbUp7t0tEOtjj2OJTuiUYVHnMLTCefAPsofwV4OOIlP2FoH8zjPlwnXEo8NN6RdJAqF
 SowGqFH3hJCuVOMtYL3ctLFLm/PPmZEZrMFfJwDmxZ156ej+xcaJs9a5GsfmHpRR57pm8T
 YexcBTKKwxcj35Im9Q20mDc4yZNGsOU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-grchonwMPfGhlPzYLx4voQ-1; Tue, 24 Oct 2023 07:08:06 -0400
X-MC-Unique: grchonwMPfGhlPzYLx4voQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c51ca27f71so36555931fa.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 04:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698145685; x=1698750485;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gB4uS6S7st0CPDlJR1A4U2y2iQeTtClCP2vEdG87owg=;
 b=Jle9DZeWiBguIRg/b86wJbF2F8LUa+x7+wiOCAEuUULwR6Tlfgp/ETm2aFJastO76m
 FoZF+dVwgxq3YL3gJ2K1ARhVERSeGlsGgc/MybFVcGpuCJ3s1eesDeDqSgZMKR4aAJ6s
 gLzTOa7+YHPUJxALMJH7h2Mae95/rY80qqyYZ8461tKTtNe8QJMyaF9yZLwx9DrcfJOF
 LKuJgNvMrdpqxdC0n60/DEIzbTQP9k4jevMVE8CdL2FxGLApaGE2n8/9WQDYRroF5DKf
 htmHDGFZmR1P/v5mpwMdVnUF3d97BzptASnbg5Eb95juZl7rQMmePz0QD12kAFGa6408
 ooBQ==
X-Gm-Message-State: AOJu0YzuzNrOXibJK5/3ZmXpMsGvpXDENBimHXBWy19fD4TBZ64lJFaL
 W19/JHh5++FstdZ/zz06YqHj8AN3Ccqse0n2MCGHDq31CMJTVltXzV8NTOaoaEZh59MPBUURs2S
 nCzEmfOszssYFMCA=
X-Received: by 2002:a2e:8e2a:0:b0:2b5:7f93:b3b0 with SMTP id
 r10-20020a2e8e2a000000b002b57f93b3b0mr7114588ljk.17.1698145684877; 
 Tue, 24 Oct 2023 04:08:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAGp/Lrmri+UMIqFcrFt1CNFlvp2czdnzaxblxok96n9O3N5mT+1Jy6r4ZEoNqIDu/uNGXiA==
X-Received: by 2002:a2e:8e2a:0:b0:2b5:7f93:b3b0 with SMTP id
 r10-20020a2e8e2a000000b002b57f93b3b0mr7114564ljk.17.1698145684551; 
 Tue, 24 Oct 2023 04:08:04 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 c39-20020a05600c4a2700b0040588d85b3asm16101319wmp.15.2023.10.24.04.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 04:08:04 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  John Snow
 <jsnow@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH v2 9/9] docs/migration: reflect the changes about needed
 subsections
In-Reply-To: <CAMxuvazf9_j=oqOrpCAcmhsai3n6rWBSa_X-bZXkRVQum7BQQQ@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 24 Oct 2023
 14:58:08 +0400")
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
 <20231024084043.2926316-10-marcandre.lureau@redhat.com>
 <87sf60z499.fsf@secure.mitica>
 <CAMxuvazf9_j=oqOrpCAcmhsai3n6rWBSa_X-bZXkRVQum7BQQQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 13:08:03 +0200
Message-ID: <87jzrcz3ak.fsf@secure.mitica>
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> Hi
>
> On Tue, Oct 24, 2023 at 2:47=E2=80=AFPM Juan Quintela <quintela@redhat.co=
m> wrote:
>>
>> marcandre.lureau@redhat.com wrote:
>> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  docs/devel/migration.rst | 17 ++++++++---------
>> >  1 file changed, 8 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
>> > index c3e1400c0c..50f313f178 100644
>> > --- a/docs/devel/migration.rst
>> > +++ b/docs/devel/migration.rst
>> > @@ -240,17 +240,16 @@ a newer form of device, or adding that state tha=
t you previously
>> >  forgot to migrate.  This is best solved using a subsection.
>> >
>> >  A subsection is "like" a device vmstate, but with a particularity, it
>> > -has a Boolean function that tells if that values are needed to be sent
>> > -or not.  If this functions returns false, the subsection is not sent.
>> > -Subsections have a unique name, that is looked for on the receiving
>> > -side.
>> > +has a Boolean function that tells if that values are needed or not. If
>> > +this functions returns false, the subsection is not sent. Subsections
>> > +have a unique name, that is looked for on the receiving side.
>> >
>> >  On the receiving side, if we found a subsection for a device that we
>> > -don't understand, we just fail the migration.  If we understand all
>> > -the subsections, then we load the state with success.  There's no che=
ck
>> > -that a subsection is loaded, so a newer QEMU that knows about a subse=
ction
>> > -can (with care) load a stream from an older QEMU that didn't send
>> > -the subsection.
>> > +don't understand, we just fail the migration. If we understand all the
>> > +subsections, then we load the state with success. There's no check
>> > +that an optional subsection is loaded, so a newer QEMU that knows
>> > +about a subsection can (with care) load a stream from an older QEMU
>> > +that didn't send the subsection.
>>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>
>> Just wondering.  What device propmted you to write this series?
>
> When I worked on ramfb, I did various testing with the subsection
> handling and was surprised by the default lazy behaviour. I initially
> thought it was a bug to ignore missing sections (both needed and
> not-needed), then I realize from the doc that it was partially by
> design. I thought it was clearer to make "needed' section actually
> required on load as well. I wonder though of the potential of breakage
> from old QEMU versions, how do we test cross-version migration? Do you
> think also "needed" section are actually required? Perhaps we need
> better wording and documentation instead...

This was designed for a world that no longer exists.
We used to "promise" that we will allow migration for:

$ qemu-n -M pc -> qemu-(n+1) -M pc

And pray that it worked.

We have dropped that long ago (as imposible to do/test).  And now we
only promise that:

$ qemu-n -M pc-n -> qemu-(n+1) -M pc-n

And in this case, making the needed versions required looks like a good
idea to me.

As said, waiting for others to chime in.
The changes that are independent are already on my queue.

Thanks, Juan.


