Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC01A82DE91
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 18:40:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPQvw-0004dg-Qi; Mon, 15 Jan 2024 12:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPQvu-0004bP-Nm
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 12:39:34 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPQvs-00005G-QQ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 12:39:34 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e7fce1abcso5421515e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 09:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705340371; x=1705945171; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pkxj2qOj0omw6OidKXo9Q1FGu90qhueEyEMCxfoDgbA=;
 b=qeYZ3uwI0WSS/2l9B1ny8przK7fWdkOdOl5hgxLJkVFm8+pG8J16BFrrEBuMirn70W
 kraCu+DsXR+yxb4NrE622Kv+SlKtRD6u1EWm7c1OR7GNsA4YLwPMGQcbgTHOStyuBGes
 AO/EqkSXBsfXGO6uCoidsxqL21H4fAD8PG3mKs/7Z9Q6cN0ToD4Ii9L8lMu8b+FNuL3m
 kc/n6D2E6tyHgh84lrZaluek1eULW55T2qof/tHWKnhNPu5YL8niVpCM/omD/BRClGN0
 +v9BHvpOS8y1849YWvhSnusUgedVi7rPBOvv/BT/6BaWVZfxM/nyrJ/m1neMdEr5baOp
 7+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705340371; x=1705945171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pkxj2qOj0omw6OidKXo9Q1FGu90qhueEyEMCxfoDgbA=;
 b=ogdFdRWqa/3eWuLysAiq4X8fNgkM9hXO/H2GqXECOXFG1avae6kdPneYssZv35D43h
 l3MFFT5qjnQ4qDPjLiJ/pO12ZHOQISRD7z13ULuRZk7SRP3nh8BQ2u7TzKI60zaWSJzq
 oSm9f1Du5hF2jzQBYGLRtYhBp8I7VDG3fu4m72OJn/Fx1xRyVjqY1QzbTAHrQnNPPQ8h
 g1E03FLCzGR32gypZgnqSD1atp18G3e6jazvegeMe4RhCqx7ttyZJS6PNRoRP1xg5I6d
 XCve6iIXhNj6jFeAtDD26gPvlMIoI9bChhxawXI6oAwOM33kdwN6mriL7wr/zvCTSlDO
 OhKw==
X-Gm-Message-State: AOJu0Yxxehk25P9LsUUiQKxnWjPlzgvKRRiEGexCCqForqGEYKxHatPc
 jsTlbNYkc670SgaEZPFFyu5kV2tX5mMHl281vgeZsyPbnUppOA==
X-Google-Smtp-Source: AGHT+IFC8ZExPEPAo6j23a3UhvemsCQmtr0eHukHBU6xc14NTJB1SNlrQ4e3cQXYjGQ/wSqg0nFyuyjOtfN2dtwWZNc=
X-Received: by 2002:a05:600c:228b:b0:40e:4492:ffa with SMTP id
 11-20020a05600c228b00b0040e44920ffamr3397448wmf.61.1705340370953; Mon, 15 Jan
 2024 09:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20240112100059.965041-1-thuth@redhat.com>
 <20240112100059.965041-6-thuth@redhat.com>
 <7f24e391-e3ba-462c-ba30-2ea7ddb62795@linaro.org>
 <fdbe4b2d-b63a-4fcd-9747-08d713e17d22@redhat.com>
In-Reply-To: <fdbe4b2d-b63a-4fcd-9747-08d713e17d22@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 17:39:19 +0000
Message-ID: <CAFEAcA-9EnvXKcrECsAKCMHPobLch4mKU0Yvb2+ZKALcFSiqaQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] qemu-options: Remove the deprecated -singlestep option
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 qemu-trivial@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 15 Jan 2024 at 13:54, Thomas Huth <thuth@redhat.com> wrote:
>
> On 12/01/2024 16.39, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Thomas
> >
> > +Laurent & Peter
> >
> > On 12/1/24 11:00, Thomas Huth wrote:
> >> It's been marked as deprecated since QEMU 8.1, so it should be fine
> >> to remove this now.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>

> > StatusInfo::singlestep was deprecated at the same time,
> > can we remove it?
> >
> > IOW could we complete your patch with this?

> > diff --git a/qapi/run-state.json b/qapi/run-state.json
> > index ca05502e0a..08bc99cb85 100644
> > --- a/qapi/run-state.json
> > +++ b/qapi/run-state.json
> > @@ -106,25 +106,15 @@
> >   #
> >   # @running: true if all VCPUs are runnable, false if not runnable
> >   #
> > -# @singlestep: true if using TCG with one guest instruction per
> > -#     translation block
> > -#
> >   # @status: the virtual machine @RunState
> >   #
> >   # Features:
> >   #
> > -# @deprecated: Member 'singlestep' is deprecated (with no
> > -#     replacement).
> > -#
> >   # Since: 0.14
> >   #
> > -# Notes: @singlestep is enabled on the command line with '-accel
> > -#     tcg,one-insn-per-tb=3Don', or with the HMP 'one-insn-per-tb'
> > -#     command.
> >   ##
> >   { 'struct': 'StatusInfo',
> >     'data': {'running': 'bool',
> > -           'singlestep': { 'type': 'bool', 'features': [ 'deprecated' =
]},
> >              'status': 'RunState'} }
>
> Uh, oh, that's a bigger change already ... can we safely remove the field
> here without upsetting 3rd party apps that rely on this interface?

That was the whole point of marking it 'deprecated' in the JSON,
I thought? We don't think anybody's using it, we've given fair
warning, isn't the next step "remove it"? Markus, you're the
expert on QAPI deprecations...

-- PMM

