Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F192373AB48
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:13:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCRbH-0001Mn-OT; Thu, 22 Jun 2023 17:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCRbC-0001MJ-24
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCRbA-0001rv-Fn
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687468331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nDdz9sahllYqUO3QamAWO/XBliREMveiwd27ZCeEH8=;
 b=J02WQggUnM97RbfeG9K3U0D7xvE3sYnmzTFxDENEK5Am7C41L4TaRb9Gq6y0H9BfFWLQus
 YllAiNYJXcrMOBwwPYaNlLp5ZcnU2BcC2z+zgJADdFNvwFmMVZjyqK2UgBiwNkq0+woopZ
 QSMz8Ae0d06v9ov5IErQ8R1pEr7di50=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-TjPG_De_Pn23u76XiN2Vdw-1; Thu, 22 Jun 2023 17:12:09 -0400
X-MC-Unique: TjPG_De_Pn23u76XiN2Vdw-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-78f1b0510c7so2084124241.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 14:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687468322; x=1690060322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5nDdz9sahllYqUO3QamAWO/XBliREMveiwd27ZCeEH8=;
 b=eyAAnqTd9/M/ngDdXHaRx36jWAWKTsQb7TDIiG0hghTvoEQT5jfzVu/c/ftrsJTDMm
 BPuboBpGax8xxaxv4zv8TATbv2M6+43JFyUQxig0cpPEG5pVDAoudRKcPws//ExQm8Zf
 Euhwn0TMGPR+FxNpwlxuxSk5fFS++cjJMqfcHFVefXAVd4rFJozO9DJKd//3ay5oklby
 UUqloujG65D/8sD6SVTXv/injY2/lw3VJtO7UNhL0HD8AcB4k267kruosgHuDG7xZNNa
 3Pf1bNZFHDAE4mxpRSsWqfqbMCsrMdyDU/2c43AOHEKAogaJu/IaYOyRLyKVLP1gfxHT
 a1oQ==
X-Gm-Message-State: AC+VfDxqJMDMH2X1/7CQm1bhdX+RjGYwFpluGD3y9WCs9tEQFXncCz/X
 SktzM/sHqpH9ohynjK7O/Aiu7QWBUBF3gXcLCV7frI/QkgVIcRZHmrZQRgNxmuYM7oPMuwgBMf8
 K1DXh8lMcMyuRmLJlJwcbnGLb/jvSPF4=
X-Received: by 2002:a67:fd93:0:b0:440:bfd5:de21 with SMTP id
 k19-20020a67fd93000000b00440bfd5de21mr5398352vsq.6.1687468322188; 
 Thu, 22 Jun 2023 14:12:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6g27iSLp0QqsoxiLgGp9WOwNjr2IrSb5BQw4WtXZ4OqIXQ4D941QNwtWf4B5/ShyKBAcr/Q43y0kMnZV3a6xc=
X-Received: by 2002:a67:fd93:0:b0:440:bfd5:de21 with SMTP id
 k19-20020a67fd93000000b00440bfd5de21mr5398337vsq.6.1687468321924; Thu, 22 Jun
 2023 14:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230621002121.1609612-1-jsnow@redhat.com>
 <CABgObfahSN4eQ65nu9Dy_7bkWmxfERiJ-ZEM729futMFuGWwPw@mail.gmail.com>
 <CABgObfYKK+eU56iP2O+O7s=dcfWxmpXrB3EuNj=CkUw-XEjSnA@mail.gmail.com>
 <CAFn=p-a1Lz=FdrAYcB8Ua3AK=C5674Lyg5vRyxNjaybNXgvQ0w@mail.gmail.com>
 <CABgObfYo34ZOqAGdf9jEEQUtTztcwDUF+N9JGSsbBw8z1FOoWQ@mail.gmail.com>
 <CAFn=p-YnhA=FGPbPifY9vR=skpV=8dVvtmgdivJGw0cNjR6ouw@mail.gmail.com>
In-Reply-To: <CAFn=p-YnhA=FGPbPifY9vR=skpV=8dVvtmgdivJGw0cNjR6ouw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Jun 2023 23:11:30 +0200
Message-ID: <CABgObfbmjjB505_O4wg5sUKYkgVhcrdPnevV9Pv-uH+TCb=o-w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Switch iotests to pyvenv
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 22, 2023 at 11:08=E2=80=AFPM John Snow <jsnow@redhat.com> wrote=
:
>
> On Thu, Jun 22, 2023 at 5:05=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > On Thu, Jun 22, 2023 at 11:03=E2=80=AFPM John Snow <jsnow@redhat.com> w=
rote:
> > > If we always install it in editable mode, and the path where it is
> > > "installed" is what we expect it to be, it shouldn't have any problem=
s
> > > with being out of date.... I think. We could conceivably use the
> > > "faux" package version the internal package has to signal when the
> > > script needs to re-install it.
> >
> > Stupid question, why not treat it just like avocado?
> >
>
> How do you mean? (i.e. installing it on-demand in reaction to "make
> check-avocado"?)

Yes, installing it on-demand the first time "make check-iotests" is
run, using a "depend:" keyword argument in
tests/qemu-iotests/meson.build.

BTW,

from distlib.scripts import ScriptMaker
ScriptMaker('..', '.').make('foo.py')

Seems to do the right thing as long as foo.py includes a shebang (I
tested it inside a virtual environment).

Paolo


