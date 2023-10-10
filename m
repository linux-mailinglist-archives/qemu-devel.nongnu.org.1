Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E6D7C4231
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 23:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqK44-0003VC-WB; Tue, 10 Oct 2023 17:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqK41-0003Si-Qh; Tue, 10 Oct 2023 17:14:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqK40-0005V7-8x; Tue, 10 Oct 2023 17:14:49 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-69101d33315so4639683b3a.3; 
 Tue, 10 Oct 2023 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696972486; x=1697577286; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ttIViOAisenVog4Obo7HMCeWjiXBWgmUH2WQ9d113E=;
 b=QxjHO9ozdMQipwqVrwy4B7tRU75Bxl1J0AurucXoBX0TW9xx5cUVXA2i9lbA/+vAGK
 MXNTL1EOIWHddlpaYNxz1dDrU/pg+tMsFiSO4dm0b7o/0Ql6RutujrcL4ESEooGxpe+u
 0edAPa1QIsfB7GsJC47eHI8bdFXPXr6SJOH648Mll5nw1GgVNdsM9p/99FBvE84QuBh7
 in+Gm50/FLw1xn+zztKy4/MKhBhlODwWz2y6YhjpT5VOk29I6JyGrxvx9EmkQ13qMWh0
 kgviPtQh33Ybq/l/8Q42+mvBU3tA7pHsbb+NKyZlBbP1h2/VNM59nz3S2Yemb/f86ap3
 M3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696972486; x=1697577286;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3ttIViOAisenVog4Obo7HMCeWjiXBWgmUH2WQ9d113E=;
 b=sPTqmyy0bDK1q8fqIuFatOC2u0ovAjik1tyH2SBK7xyPKUhyPHpSfM0D2pDo538g2R
 zxzoRiG5ikH3KDUiaXIEIhnWZlMJW9tVfYQ6ifw3P5iuaFkBypQr/EA+WoMuda+piEG5
 Idhou9f8vsy/gdSNwJbCxTR8e+K0B3X3+zR43DExdt1kdP0C+ViL/+MsurIAy/0Jo7zp
 iuHkb9ieOzoUrRVveF7AoBv+/u6mWKAh+60w1wQ+QkPIW3esryvyBdsX4cGth9DuqILF
 BzkqzRe9kzwTnKdIn0URIQxsMLenRQGUPCds7cdYYDbU2UNu3eFrJzIHFY30PDZABvPj
 SJvw==
X-Gm-Message-State: AOJu0YwMUEMIJ+hKjE5r9AWSggcMF4umpyKVCh2S82HUAYekJBn30syf
 skva3C1l0fEUign8jnTm5yz01B9fCXU=
X-Google-Smtp-Source: AGHT+IEwJa7kj7hm16d3KfNQA1O4RjRUu7fDXbLIg+LMeznIcrSVcPpnPv+9G7h7aDpzQ/ih4re8AA==
X-Received: by 2002:a05:6a21:81a4:b0:16b:beb5:da5d with SMTP id
 pd36-20020a056a2181a400b0016bbeb5da5dmr10031659pzb.43.1696972486286; 
 Tue, 10 Oct 2023 14:14:46 -0700 (PDT)
Received: from localhost (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a62e716000000b0068fb8e18971sm8676630pfh.130.2023.10.10.14.14.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 14:14:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Oct 2023 07:14:40 +1000
Message-Id: <CW52JFK1RO4T.16XXH7EJX339F@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: <qemu-ppc@nongnu.org>, "Cleber Rosa" <crosa@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 07/11] tests/avocado: Add ppc boot tests for
 non-free AIX images
X-Mailer: aerc 0.15.2
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-8-npiggin@gmail.com> <87h6mypryo.fsf@linaro.org>
 <ZSVLEO4hAX3zJRFZ@redhat.com>
In-Reply-To: <ZSVLEO4hAX3zJRFZ@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue Oct 10, 2023 at 11:01 PM AEST, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Oct 10, 2023 at 01:43:16PM +0100, Alex Benn=C3=A9e wrote:
> >=20
> > Nicholas Piggin <npiggin@gmail.com> writes:
> >=20
> > > An AIX image can be provided by setting AIX_IMAGE environment
> > > variable when running avocado.
> > >
> > > It's questionable whether we should carry these in upstream QEMU.
> > > It's convenient to see how to run these things, but simple enough
> > > to maintain in out of tree branch. I just wanted to see opinions
> > > about it.
> >=20
> > Yeah there is no point adding a test no one else can run. We already
> > have tests that utilise dead URLs that can only run if you happen to
> > have the image in the avocado cache which should arguably be removed.
>
> I can understand the appeal of wanting to sanity check QEMU
> with esentially arbitrary guest OS, whether modern, or obsolete,
> whether OSS or proprietary.
>
> The appeal of getting the test integrated into QEMU is you don't
> have to worry about rebasing / merging local git changes forever
> more.
>
> I feel like this tells us we should not require users to be writing
> new avocado python test code merely to get a boring old guest OS
> boot up smoke test integrated into avocado.

Interesting thought. It is easier to be able to specify images
location, qemu command line, and some expected output and input
than to write an avocado test entirely. OTOH if you copy an
existing one and don't need to do anything different then it is
not so hard.

>
> I think we ought to have a 'guest_smoke_test.py' avocado test, that
> pulls in guest OS scenarios from external YAML/JSON files. eg
>
>   $ cat ppc_aix.yaml
>   image:
>     url: https:////some/path
>     checksum: xxxxxx
>   console:
>     expect: ...some console message...
>   vm:
>     arch: ppc64
>     machine: pseries
>     ....something something extra cli args something something...
>
> Users could then set
>
>   export  QEMU_SMOKE_TEST_PATHS=3D$HOME/my-guestos-library:$HOME/shared-g=
uestos-library
>   make check-avocado
>
> to load all the guest OS scenarios from these dirs, in addition to
> any scenarios that are shipped in qemu.git by default.

There would be a bunch of upstream avocado tests that could be
converted to such a format.

Thanks,
Nick

