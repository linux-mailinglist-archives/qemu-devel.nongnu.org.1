Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 581C27093CF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:39:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwZH-0005uc-UG; Fri, 19 May 2023 05:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzwZG-0005ra-IE
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:38:34 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzwZF-0006u9-0a
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:38:34 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-96aadfb19d7so575446366b.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 02:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684489111; x=1687081111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCbJITu6J+V7NNLLeIAbJ8W0ENj5B2DYy10NNBwFVzI=;
 b=AQnLiFn21OdvpWY2PQjpdLPmtfQysocNeLeCYIbXaf0LwbH703pqjyrQV1AFiHnaVT
 wyl/1jaNbI5FJuPtfqRTwtA3l6MR1dj0D8GOgFLcYA4KUjQvE2+Z+klO/BCnR0vKIkVQ
 tyw56ZrpmgJoG1yIPKN/dpW3vXiidE3GQV41QBFeUfm4/agOTTC/yLY/5HAy/FlcMI/O
 anmhQqd+P7gAYwYWU+AxdYW2mPmOqZNUbxGEjkmVxDr3yuL3q1OrbYgAA8TGhpMP7dgj
 mBKBA8avnIHfI26cJkMDEc9/fHWbb/yxE69CaPFEb8x/6OcJFYryMKCR14akKbMFUvSk
 +0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684489111; x=1687081111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCbJITu6J+V7NNLLeIAbJ8W0ENj5B2DYy10NNBwFVzI=;
 b=bZrAZBYpILD6ncV9hfPEs+hYVDKNFLUM0whUm6vlPFSyE4VSFIJTy6PsNHNaHkerAi
 AEe00+8AAYc1A06P99KCQHv4sRK6IoePk5XiQnYWzh/4kXphQzQP6kOYntOpRxxxtnbQ
 jXoDPrHSAHQPTCYoDrwKD1OlAEfgCvt3b28TR12py7VkOEjQkhqDWcKk3B3IIJR4jbks
 SrWAa9MFUfbPhpsJlODiVGb2ywRXMWEB/CrcVx193SnbL0XZ9eNjEIQ2GSOvol//LlMF
 sDUt9jiPJlamO8bkw/cnkrnq8vqZPQyO3f3HTJe8j454RGVok5Z8tnrj8AZxGzWAG5be
 7ghw==
X-Gm-Message-State: AC+VfDy6tcebQj0AJQhJVrh7itpXxTX8juAXaUFZNn6Xk791BuAs9xwt
 MK3X5joN3qscGMQblyM0nY4+1BGgJI3w6STEOlT6ig==
X-Google-Smtp-Source: ACHHUZ5R71EuPRKoR5qTlWH1IFpfiFvnPBFuQdxGEEOHckXo3TAKWjQ7Eh+iJFNzlUDfR+/Wk+zCBlUo0+77v73ojS8=
X-Received: by 2002:a17:906:5f87:b0:966:1d92:5f97 with SMTP id
 a7-20020a1709065f8700b009661d925f97mr1235052eju.66.1684489111196; Fri, 19 May
 2023 02:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230519085647.1104775-1-pbonzini@redhat.com>
 <CAFEAcA-nMG_5u4pADASoQNF_MCCXHMCB3APTtVLohzTzCmJ3cQ@mail.gmail.com>
 <ZGdCL3Ka2JSeo+XD@redhat.com>
In-Reply-To: <ZGdCL3Ka2JSeo+XD@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 May 2023 10:38:19 +0100
Message-ID: <CAFEAcA9P-mAQ-Vf8vs=jsFpcKePnnFFtaP11_RAjZNhmmzOUKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] meson: use subprojects for bundled projects
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Fri, 19 May 2023 at 10:32, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, May 19, 2023 at 10:21:03AM +0100, Peter Maydell wrote:
> > On Fri, 19 May 2023 at 09:56, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> > >
> > > QEMU bundles a copy of dtc and keycodemapdb.  They both support meson=
,
> > > so we can run their build system via subproject() instead of hardcodi=
ng
> > > their contents.
> > >
> > > In fact, now that QEMU's configure script knows how to install missin=
g
> > > Python dependencies, we can replace submodules altogether with .wrap
> > > files, which have several advantages, either immediate or potential:
> >
> > So do we have a path for getting rid of submodules entirely?
> > I'd be all in favour of that, but I'm somewhat less in favour
> > of "some things are submodules and some things are this new
> > .wrap file setup"...
>
> I think we can ignore 'roms' submodules on the basis they are never used
> during a normal build, they're mostly just a maintainer convenience and
> for release archive source bundling.

Yeah, I agree -- or at least I agree they're a distinct use of
submodules. We might at some point want to look at whether there's
a better way to deal with ROM blobs than what we do today, especially
as the size of the source archives for things like UEFI is much
bigger than I expect anybody anticipated when they set the rom
blob machinery up. I don't think the way we do ROM blobs is
very convenient for our distro downstreams either.

-- PMM

