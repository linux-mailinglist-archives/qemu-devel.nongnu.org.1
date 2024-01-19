Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F71832728
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 10:59:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQldi-0005aX-1t; Fri, 19 Jan 2024 04:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQldg-0005aE-Pb
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 04:58:16 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQlde-0001pe-Lq
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 04:58:16 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e741123acso717104e87.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 01:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705658292; x=1706263092; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVZWN7JzsxO1haogAKE/BecseugFbjJUdIFlmvpwfLM=;
 b=rSI9p9pF9O3gcTq+jp1RvMdEWGZBztddNrUHlxk0AMcs+A/QyEzlRJ4usxTHY0Nk87
 BCUXdAlA/JbeFsRbBbpNLfL7NdPQY3NxYp7TRs4Mkpv+K0WcivEAAkKBgy3cwc5+HNNG
 AlEWkGCSB7MvFYqb9P51i5FEqZ9PnO5jvOOic/5rz/E/PAml6rUVxp03f8SmM8ik3HBp
 eKE2omTgN3ZrAFouLdZujrZJqP61nFgbrabKa9l2Qbeql8Fn63BmhRA6BCJ2vK1oWVzk
 fA9DLgzM9qKgbNl6UyzXKGBKhkhdJ7Fqd+CnZQB77j/b6vUPm1aqDqqV1MfuyLbuqBmm
 OdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705658292; x=1706263092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vVZWN7JzsxO1haogAKE/BecseugFbjJUdIFlmvpwfLM=;
 b=D4M6zV5ui61xm4TzNOT7J/93K5p07s3++yyWav1z2x/oUjoSqi4Nxb01d3wEai0mYK
 oxNJwikD7xf/5aSuShDPaSU/paCNdQivnpyl7doPDxXaaZoVzaRE3IEpUBqZLOVyLb+Y
 9Mm5K2/F88n+Jhzci+RWu1tifSIc1FW4Viym+44A0O0deT1SxNwyRuPLErG59QfJG9YO
 YiHgkfvx/YZaQ1Ls9TB79WIdWBdwLWppQcHKUJ+NhhV4eGC3I222i7W/+kAdMMyucQsU
 MUnxPre2UIIaJz+tlMbQsoZXXoC7t7O/orLzhLF455gAL71HnT9qAI1ify2fLCbZC3P1
 hzIg==
X-Gm-Message-State: AOJu0YxoDoHOziX73M0p6mF1XJiNm1WKrInQOX0v0BCl+/Tr1aGfFPGk
 u9qMPNGIdiPcA3ETEtONKAGHU9CdytCG6z/10tFZ1xdiscI/KDT9eOHPxe1sJMNACC8LITY1Bu/
 ss+eDlN1pvooe50P/N1LiWSz2VZ/2Aqgcc5Lukg==
X-Google-Smtp-Source: AGHT+IFlGs/g82bNMTJ4EIYpCHJs7wy9TFKdkInIH0SgBA/PzJi0r/EGcFOx2yHZ9362dmcVJS9PxUvmh4wgFN2Mxjc=
X-Received: by 2002:a05:6512:902:b0:50e:3907:46b7 with SMTP id
 e2-20020a056512090200b0050e390746b7mr441499lft.107.1705658292159; Fri, 19 Jan
 2024 01:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20240117042556.3360190-1-anisinha@redhat.com>
 <ZaehVFa9O6XfuL85@redhat.com>
In-Reply-To: <ZaehVFa9O6XfuL85@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 09:58:01 +0000
Message-ID: <CAFEAcA_2j61Gq=x8J3=HUD08_mF19Ff1GOrpfcGOAJKQg-L4Mw@mail.gmail.com>
Subject: Re: [PATCH v2] acpi/tests/avocado/bits: wait for 200 seconds for
 SHUTDOWN event from bits VM
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 17 Jan 2024 at 09:43, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Jan 17, 2024 at 09:55:56AM +0530, Ani Sinha wrote:
> > By default, the timeout to receive any specified event from the QEMU VM=
 is 60
> > seconds set by the python avocado test framework. Please see event_wait=
() and
> > events_wait() in python/qemu/machine/machine.py. If the matching event =
is not
> > triggered within that interval, an asyncio.TimeoutError is generated. S=
ince the
> > timeout for the bits avocado test is 200 secs, we need to make event_wa=
it()
> > timeout of the same value as well so that an early timeout is not trigg=
ered by
> > the avocado framework.
> >
> > CC: peter.maydell@linaro.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2077
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >  tests/avocado/acpi-bits.py | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > changelog:
> > v2: cosmetic comment updates in code and patch description.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thanks; I've applied this directly. Hopefully it will deal with
this intermittent for good.

-- PMM

