Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DEC71FD27
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:09:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q50lX-0006ei-KZ; Fri, 02 Jun 2023 05:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q50lV-0006eH-Pu
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:08:09 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q50lT-0003Jv-SA
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:08:09 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5148f299105so3974608a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 02:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685696885; x=1688288885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bu14ceylCClaJySjbsOXEaE9OqiNUXwrQIr4+8JYXZU=;
 b=GZay4lqKzU4XU7SA7g7DB8nfmzmyYxR2hZsx1zg+oWpAMG0Bev+nN8dtsmG4LPnNMA
 LA5/KOwKnKbR94WJQDj5xJTPG9/XkYzAQ3aP6SlzW3GwIhJK2MIjMgygSdPIohyUQ9XU
 zHn3dauPIdTtt4h5jXoXu+3L7v7LrWipTK9J2AuqHEOE3AAxyF1RcBgczzlL1u/U6VoV
 YlVkbhLySkynZSmsmjXW76wJ0SLRMJ/mS2J4cQLqOCmngmvnAsTeJ5iA5cmW4HYcfr34
 AyFCNfB0YmlOFMNqm6K2L0aRrikjKm4cGnG4FVtZepwdLWyue//Gn+/hTazP+DlU1pXb
 FRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685696885; x=1688288885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bu14ceylCClaJySjbsOXEaE9OqiNUXwrQIr4+8JYXZU=;
 b=CL6gPRltxsuXz3uFvvNicoDvR4NRzc2yUSp7Vm4PaAx9MTcHjZBr9KVUW2sUZi8QEN
 CPr9foBBtepT5OoG+uLWtsZD/zU/l2MW6Lx0k4THh6z1iZjvbkky1t5cwddmP3M1sb9y
 mWm10PQvf++IngVlHIwZVR2P88cnkspp6wcu6MXcJyupzmU01l9KmCiDJyJOjok74DFs
 UWicdAkHMmak1pGnqYhz6f0Kww3/liZUCdN1WEfLqttC0ms5WHnm0mBqoncsSXUDq/2o
 BVsifQ45ABzfJhCIcFeO3kstekRUwSI1LBQnxLwcG6b6yK9W8nIpsxgdiYKtVRlnMuKx
 MgtA==
X-Gm-Message-State: AC+VfDwAi9xryFjrakuAdn1qRXOANlM1ifQZ9jMAqRvpbjTM3CBnrt6/
 EshmU5eWo6qWoycF4stedl3LgbxzsGZtF8KZaIDQUw==
X-Google-Smtp-Source: ACHHUZ6bIcht2JPmHv317UC8rOdkEDQhdAYw1BTpSvunYq+fEP7zuLg3WFmjth6NOvJmVmMzo9WqJ/xAnB6492458ms=
X-Received: by 2002:a05:6402:8c3:b0:516:2aaa:9bdd with SMTP id
 d3-20020a05640208c300b005162aaa9bddmr1948946edz.7.1685696885539; Fri, 02 Jun
 2023 02:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230601143312.69691-1-quic_acaggian@quicinc.com>
 <CAFEAcA-92-zExcOFMwaNYvP5pXLTUETsYi3mpuvTp2txfVEp9Q@mail.gmail.com>
 <11f8fb60-abe7-d99d-c3bb-aaa405425668@quicinc.com>
 <B0A9BD1B-B98C-4710-987D-03ADDBB993B7@quicinc.com>
 <CAFEAcA8tCZ0shxEiA4hOVsHhOBvGmQ6HLJq1dPKDuSqBXKdtJw@mail.gmail.com>
 <033C707D-C8DF-4DA7-BE50-F19DE2A17FB4@quicinc.com>
In-Reply-To: <033C707D-C8DF-4DA7-BE50-F19DE2A17FB4@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2023 10:07:54 +0100
Message-ID: <CAFEAcA-CSzE=bzCR-zx6hPqmiV9pv8CqwXqv9ui3sZXbWkZZjw@mail.gmail.com>
Subject: Re: [PATCH] hvf: Handle EC_INSNABORT
To: Mark Burton <quic_mburton@quicinc.com>
Cc: Antonio Caggiano <quic_acaggian@quicinc.com>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Thu, 1 Jun 2023 at 20:21, Mark Burton <quic_mburton@quicinc.com> wrote:
>
>
>
> > On 1 Jun 2023, at 18:45, Peter Maydell <peter.maydell@linaro.org> wrote=
:
> >
> > WARNING: This email originated from outside of Qualcomm. Please be wary=
 of any links or attachments, and do not enable macros.
> >
> > On Thu, 1 Jun 2023 at 17:00, Mark Burton <quic_mburton@quicinc.com> wro=
te:
> >> This patch came from a discussion on the KVM call the other day.
> >> It may well be the case there is a better/different implementation
> >> - so the patch is more by way of asking the question.
> >>
> >> Re-phrasing your question - I think it boils down to =E2=80=9Cshould H=
VF
> >> (and KVM) support executing instructions from IO space?=E2=80=9D.
> >
> > I think this falls into "might theoretically be nice but is
> > probably too painful to actually implement". In practice
> > well-behaved guests don't try to execute out of MMIO devices.
> >
>
> >> In that case, this is a =E2=80=98partial=E2=80=99 answer to providing =
such
> >> support for HVF - partial in that it relies upon a memory
> >> region being created =E2=80=9Cdynamically=E2=80=9D for the IO space th=
at
> >> has been accessed as a side-effect of a normal access.
> >
> > But nothing in (upstream) QEMU magically creates MemoryRegions
> > just because the guest tries to access them. Either there's
> > nothing there in the AddressSpace at all (definitely can't
> > execute from it) or there's already RAM (happy case) or there's
> > already a device there. If there's already a device there
> > then something would need to do a "put a bit of RAM in
> > temporarily, fill in the single instruction by doing an
> > address_space_read() to find the data value and writing it
> > to the scratch RAM, tell KVM/HVF to do a single-step, undo
> > everything again".

> Indeed, that=E2=80=99s basically what we=E2=80=99re implementing. In TCG =
mode you =E2=80=99see=E2=80=99 the access, we=E2=80=99re just making it so =
that in HVF you equally =E2=80=98see=E2=80=99 such accesses to the =E2=80=
=98device=E2=80=99 (so you can put the bit of RAM in, out, shake it all abo=
ut). A cleaner implementation may be some sort of =E2=80=9Cpre-i-side-acces=
s-op I=E2=80=99m about to access this device/address please register a =E2=
=80=98memory region=E2=80=99 I can use (temporarily)=E2=80=9D. I=E2=80=99d =
have thought that could be useful any time you execute from e.g. a temporar=
y ram of any sort (whatever the accelerator).

This patch doesn't do any of the "set up the RAM, single
step, tear it down again" work, though, which is the complicated
bit. It just retries an access that ought to have worked directly
when HVF did it; which isn't really what you would want to
do if you were trying to handle HVF or KVM exec-from-device.
In that scenario the "read from the underlying device" would
be in the middle of a large amount of other complicated code.
And without all that other complicated code (which I tend
to feel is not worthwhile as a feature) this change is
completely unmotivated by anything we have upstream...

-- PMM

