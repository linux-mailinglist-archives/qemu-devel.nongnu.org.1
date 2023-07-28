Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC47669CD
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 12:05:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPJqT-0004gq-Gy; Fri, 28 Jul 2023 05:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qPJqE-0004ga-Jv
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qPJqC-0000Mt-B8
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690536774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMpE7aCTDU5KWwlxNJ2JWG218YSQySijXoRAK4D7fns=;
 b=WDRQiLetAG6KuP5ZOH4mjSmxE8up71Sm8Fv8r03JRyNmKmScogN7XVh7syXatsWnrd41N9
 HFAXVKryUIZweqcJD9r82XGaquMSEKOsZKV2mALuX9AcWyNHi5M26aCUr1tjQBqbpOHRJV
 qJdBk9aO2Twg31D/KLBBn9oJUZFVl8s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-gkGktSdbPoaRtdaolAXcdw-1; Fri, 28 Jul 2023 05:32:51 -0400
X-MC-Unique: gkGktSdbPoaRtdaolAXcdw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fb76659d6cso1743931e87.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 02:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690536767; x=1691141567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMpE7aCTDU5KWwlxNJ2JWG218YSQySijXoRAK4D7fns=;
 b=C8tJDB3+v/ltXO/lnCsL5N+ksaFJnEc1IqOgBjfI/GWvRm9gnhjhRyv8N+SIJHgrVU
 q8VBcJ9yne++x8QnQDeUuQVjlD7u0aqH0u8Lrp9CcU7sx9uUle/M3K3uMQBw+AOS1v6g
 18eRN31no1keAUMI/KPU3HICg2lPuY8mwmRDdO6t0X+OyRZD8hjQV5bdWxcGENwdAToo
 A666RgtkvAgUWLHWLPViVWIv9ye9lKVNlJ2XpITThXGodiSwHmweDINQ8dEvttKVdxo1
 v5WjTPRkTkKej65vr/8uF8ancjpHtDrJXCqAqSIvJc/6OJQqMl62irS36AVHfXWBXdUe
 5wxw==
X-Gm-Message-State: ABy/qLbsJGIN53XEs9UuIRigScK0C4H/A2cRunlG5HhKjN4/M6FHbnBj
 BrF+o7PVkqyobCekskpJWim+05S/oY6uzmo2Lml/9VrvSwR1ETkYczgRnbxgVEAIV8bY/C+p99z
 8UBfV/oUziic3tat3KkT7tOcrhBWiNQNQZr1dUyrZ4A==
X-Received: by 2002:ac2:58c9:0:b0:4fd:cae7:2393 with SMTP id
 u9-20020ac258c9000000b004fdcae72393mr1284477lfo.2.1690536767159; 
 Fri, 28 Jul 2023 02:32:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE441iDkWE5d3ikajkHVhYE0aGRtT3+pOZcPbvblyPaNr88Wx3HkYL/B+Y4ZTl6JEYXe5bivbZ3Ex6VczPwqa8=
X-Received: by 2002:ac2:58c9:0:b0:4fd:cae7:2393 with SMTP id
 u9-20020ac258c9000000b004fdcae72393mr1284444lfo.2.1690536766803; Fri, 28 Jul
 2023 02:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230726161942.229093-1-berrange@redhat.com>
 <0d0f9f65-2ead-6852-20c2-a83e256eecac@redhat.com>
 <ZMJJS5lUtPKpld0q@redhat.com>
 <a56c06a0-a6b4-cee6-be97-3586a836f4d3@redhat.com>
 <ZMODTyTzJrKiDPo5@redhat.com>
In-Reply-To: <ZMODTyTzJrKiDPo5@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Jul 2023 13:32:35 +0400
Message-ID: <CAMxuvawrEUmrftcAtsD0=QXHckqTKQRTFqePR7KOJruSoFUxCA@mail.gmail.com>
Subject: Re: [PATCH] gitlab: remove duplication between msys jobs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

Hi

On Fri, Jul 28, 2023 at 12:59=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Fri, Jul 28, 2023 at 10:35:35AM +0200, Thomas Huth wrote:
> > On 27/07/2023 12.39, Daniel P. Berrang=C3=A9 wrote:
> > > On Wed, Jul 26, 2023 at 08:21:33PM +0200, Thomas Huth wrote:
> > > > On 26/07/2023 18.19, Daniel P. Berrang=C3=A9 wrote:
> > ...
> > > > Anyway, before we unify the compiler package name suffix between th=
e two
> > > > jobs, I really would like to see whether the mingw Clang builds QEM=
U faster
> > > > in the 64-bit job ... but so far I failed to convince meson to acce=
pt the
> > > > Clang from the mingw package ... does anybody know how to use Clang=
 with
> > > > MSYS2 properly?
> > >
> > > AFAIK it shouldn't be anything worse than
> > >
> > >    CC=3Dclang ./configure ....
> > >
> > > if that doesn't work then its a bug IMHO
> >
> > No, it's not that easy ... As Marc-Andr=C3=A9 explained to me, MSYS2 ma=
intains a
> > completely separate environment for Clang, i.e. you have to select this
> > different environment with $env:MSYSTEM =3D 'CLANG64' and then install =
the
> > packages that have the "mingw-w64-clang-x86_64-" prefix.
> >
> > After lots of trial and error, I was able to get a test build here:
> >
> >  https://gitlab.com/thuth/qemu/-/jobs/4758605925
> >
> > I had to disable Spice and use --disable-werror in that build to make i=
t
> > succeed, but at least it shows that Clang seems to be a little bit fast=
er -
> > the job finished in 58 minutes. So if we can get the warnings fixed, th=
is
> > might be a solution for the timeouts here...
>
> Those packing warnings look pretty serious
>
> C:/GitLab-Runner/builds/thuth/qemu/include/block/nvme.h:1781:16: warning:=
 unknown attribute 'gcc_struct' ignored [-Wunknown-attributes]
>
> This means CLang is using the MSVC struct packing ABI for bitfields,
> which is different from the GCC struct packing ABI. If any of those
> structs use bitfields and are exposed as guest hardware ABI, or in
> migration vmstate, then this is potentially broken compilation.
>

Yes .. gcc >=3D4.7 and clang >=3D12 have mms-bitfiles enabled by default,
but we can't undo that MS struct packing on clang apparently:
https://discourse.llvm.org/t/how-to-undo-the-effect-of-mms-bitfields/72271


