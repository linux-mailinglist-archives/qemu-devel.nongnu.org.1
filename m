Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 414F973AB20
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:04:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCRSp-0005rF-4Y; Thu, 22 Jun 2023 17:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qCRSn-0005qg-Bb
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qCRSl-0006ul-Qe
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687467810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rckay/8IO7DhMniDh6+zn6W/v5MBfOdjAS5lQdWXbfc=;
 b=HDlFnRRRNgWuPpBVrfZIVnsrvsZv4a/oHUR0/OEcFz/W7I/EBkN4rHCwKDYSm3cejKRzl5
 1AKEXouhqIhx3s8I3oamGvTKHEDviZRv2vORq376M7Gk9m/5vjWh50bSAudcddXigahdgt
 +0khpdvjg+uUkUnsWDvMq5DqFi6Ty38=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-DRGa00whOt2c2qjiuLa19A-1; Thu, 22 Jun 2023 17:03:27 -0400
X-MC-Unique: DRGa00whOt2c2qjiuLa19A-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-39cdf9f9d10so5281912b6e.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 14:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687467806; x=1690059806;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rckay/8IO7DhMniDh6+zn6W/v5MBfOdjAS5lQdWXbfc=;
 b=ByMpYtq6IHlcgLnjT8OqJ6uWgppiVnZ6DrLvaQBrEdHCwXJgYIOUsvp8doUO0ovabO
 7+P/XPRD9yZhPdibm/MS7g6Xn0iDY+KU75+dloPh0wwM1ElpIIsfudzkBuXkhZfvKrKk
 oraFlZeevJA1dLLwqXEB7SijxR78NFy2Gp9BM8bVDtNL+j3H+XLipY4kPUdFFPgPe9n8
 9ei9MiwPvdXjiSVqsDx9JINLeQIjSqzBXqYDuaiC/Ejhgha7ef44108t9Kr9D3nrniLu
 1ThyjBaREChgVGYEGgKps3ZfyYMdOW+tvaE21859TyBVUz6qOQzNB+oa4P+0mO/mRiU1
 FPRg==
X-Gm-Message-State: AC+VfDyF2a8UgSCPVWbF83gYV8e4EoFe1FPguS2CEoXplaRDsAR2rn3W
 FFt0nyu6GPPpz4RkcofQ5yKGzvYtnrWkISRg+JtSpM6bFwEc9YMJNY3PrseOp3JACfCjNlKwa4y
 bFIG74Yclc1E0WQwIV8zS4KPzdGzP00g=
X-Received: by 2002:a05:6808:14c4:b0:39e:dbe8:2007 with SMTP id
 f4-20020a05680814c400b0039edbe82007mr13934954oiw.25.1687467806600; 
 Thu, 22 Jun 2023 14:03:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5y437gWupbUuDY50Vzosijhi7t1ti6t2iYqfZ6TrD2O29twqj5eRjjMk4o/O8Im6S3O3cTmEF10yBsNluXs5Y=
X-Received: by 2002:a05:6808:14c4:b0:39e:dbe8:2007 with SMTP id
 f4-20020a05680814c400b0039edbe82007mr13934935oiw.25.1687467806371; Thu, 22
 Jun 2023 14:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230621002121.1609612-1-jsnow@redhat.com>
 <CABgObfahSN4eQ65nu9Dy_7bkWmxfERiJ-ZEM729futMFuGWwPw@mail.gmail.com>
 <CABgObfYKK+eU56iP2O+O7s=dcfWxmpXrB3EuNj=CkUw-XEjSnA@mail.gmail.com>
In-Reply-To: <CABgObfYKK+eU56iP2O+O7s=dcfWxmpXrB3EuNj=CkUw-XEjSnA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 22 Jun 2023 17:03:15 -0400
Message-ID: <CAFn=p-a1Lz=FdrAYcB8Ua3AK=C5674Lyg5vRyxNjaybNXgvQ0w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Switch iotests to pyvenv
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 22, 2023 at 5:24=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Wed, Jun 21, 2023 at 9:08=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> > Maybe patch 4 can use distlib.scripts as well to create the check scrip=
t in the build directory? (Yes that's another mkvenv functionality...) On a=
 phone and don't have the docs at hand, so I am not sure. If not, your solu=
tion is good enough.
> >

Yeah, that's a possibility... we could "install" the iotests script.
That might keep things simple. I'll investigate it.

> > Apart from this the only issue is the speed. IIRC having a prebuilt .wh=
l would fix it, I think for Meson we observed that the slow part was buildi=
ng the wheel. Possibilities:
> >
> > 1) using --no-pep517 if that also speeds it up?
> >
> > 2) already removing the sources to qemu.qmp since that's the plan anywa=
y; and then, if you want editability you can install the package with --use=
r --editable, i.e. outside the venv
>
> Nope, it's 3 second always and 1.5 even with the wheel.
>
> Maybe replace qemu.qmp with a wheel and leaving PYTHONPATH for the rest?
>
> Paolo
>

Hm, I guess so. It's just disappointing because I was really hoping to
be able to use "pip install" to handle dependencies like a normal
package instead of trying to shoulder that burden with an increasing
amount of custom logic that's hard for anyone but me (or you, now) to
maintain.

It kind of defeats the point of having formatted it as a package to begin w=
ith.

Maybe there's a sane way to amortize the cost of installation by not
re-creating it after every call to configure instead -- the rest of
the script is fast enough, perhaps we could default clear to *False*
from now on and use the _get_version() bits to detect if the local
internal package is already installed or not -- and if it is, just
leave it alone.

If we always install it in editable mode, and the path where it is
"installed" is what we expect it to be, it shouldn't have any problems
with being out of date.... I think. We could conceivably use the
"faux" package version the internal package has to signal when the
script needs to re-install it.

Something like that?

--js


