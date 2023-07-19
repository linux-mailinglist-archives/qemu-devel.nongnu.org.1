Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B59F1759729
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:38:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7Nk-0004fA-Gx; Wed, 19 Jul 2023 09:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qM7Ni-0004f2-PR
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:38:18 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qM7Ng-0002tI-Ry
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:38:18 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52166c7f77cso8341161a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 06:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689773895; x=1690378695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6PIeKIxwAxcX5ItBhje1uMfoQiWyL+2badkajclqqY=;
 b=rbXqQHjiUsWL9bglEi4ZNKHIewWQG0BPYVpGpmk4JEW+hZRjeOOe2E/BwGYttSr35q
 6SPs1+6N05//AMK3qi6xXnMuTWrhqvtSCnjKK7u2CJbFmk6bCGlusBcOw8ftPcty+9O+
 nJONlrqoLPXuNA4Hh5DaTy2bWaM2prqLXOEf4IS5mW4RbXfk3E82hbJR6+FNx4PDt/Ju
 EMXBrnT/U1gDDsR0ucZ8A8lC7FOBFe/PNmPhBAjRvpjXxpcCCMP5Xgrtvc0ZpO3uAhKd
 A81Hb8Ec0yBFfKM6MXslnfr0KGfrx5w3w3F9P4GFbPXL9+XhpBTJCYWK12z2I0rGbwMt
 56ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689773895; x=1690378695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6PIeKIxwAxcX5ItBhje1uMfoQiWyL+2badkajclqqY=;
 b=esYDlFsCS8AvIAfANRLXNRf+g6jDXoVCzxIXlhM2A8jkw6/B/Plzt52U2IFM6qAu7a
 Nud+LhKkuFLPhAceZou6FK7zrHlljx5V16ALz/uxpFCZ+k6HA/vW+fnOogk9l1qQOzX1
 FG0bOuZS4dflqDfXFmlzGExMC2EA+dJtEEGLjrMVttjEOPgXsd7gaKYkcPwB7PLRcPiq
 5UDXrerGD7xqsTzmNCFx2Pg2KN9rm9OIPlqhl8UCl8UdqVF5T5Ta054fErWlesQwq4x/
 u6pTL09AnkWv4DWC3vuQToNwC+u6ldSaH2lXbhKaJrz4zQi3VsnIesKEpJHExa8wthMz
 p3Ew==
X-Gm-Message-State: ABy/qLYki9IokG3KCGc4aicwbq2DJXA2kpfFib7/kLgw8NO42rvoDC/6
 wvoUGL0V3RTKiFZtX1mwE2q78eod45orpSZKDeyIcQ==
X-Google-Smtp-Source: APBJJlFdgforOEKXDT52gelq5MSsDOuhH5mt8oZvBFikVUs87UJFWdBv+EHGSpvZcscyUixrq2zr0OhVMZ+Eu4GY0ts=
X-Received: by 2002:a05:6402:5175:b0:51d:f589:9c7a with SMTP id
 d21-20020a056402517500b0051df5899c7amr2519433ede.17.1689773895213; Wed, 19
 Jul 2023 06:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230717182859.707658-1-berrange@redhat.com>
 <20230717182859.707658-5-berrange@redhat.com>
 <67db8111-8e86-0b63-e3a3-8e89a0862a61@redhat.com>
In-Reply-To: <67db8111-8e86-0b63-e3a3-8e89a0862a61@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2023 14:38:04 +0100
Message-ID: <CAFEAcA-gM=KTFi6+SebD5Su6yG_LMJ9wiYd6g9+ESy8GgtZ2Bw@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] qtest: bump npcm7xx_pwn-test timeout to 5 minutes
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-arm <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 19 Jul 2023 at 14:06, Thomas Huth <thuth@redhat.com> wrote:
>
> On 17/07/2023 20.28, Daniel P. Berrang=C3=A9 wrote:
> > The npcm7xx_pwn-test takes 3 & 1/2 minutes in a --enable-debug build.
> > Bumping to 5 minutes will give more headroom.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   tests/qtest/meson.build | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index ecbf515d50..e28f0925e1 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -1,7 +1,7 @@
> >   slow_qtests =3D {
> >     'bios-tables-test' : 120,
> >     'migration-test' : 300,
> > -  'npcm7xx_pwm-test': 150,
> > +  'npcm7xx_pwm-test': 300,
> >     'qom-test' : 900,
> >     'test-hmp' : 120,
> >   }
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> (we should maybe still have a look at this test later to see why it is so
> slow, though)

It seems to be doing a massively OTT amount of work to test
a single device. Nuvoton maintainers, can you have a look at
cutting it down, please?

thanks
-- PMM

