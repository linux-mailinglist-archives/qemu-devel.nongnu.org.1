Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A828319B3
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:57:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRxB-0004JL-O5; Thu, 18 Jan 2024 07:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQRx9-0004J0-JW
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:57:03 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQRx7-00021S-RI
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:57:03 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55a38fb45c1so335932a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705582620; x=1706187420; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RpfO4oaFqs6lwAALE39rx6AfKD+NVhjkKQROy23W76U=;
 b=niRZwegmjhKDSQPyh0gu+kYSWj8/ZS8Mhw8Lg7z7RsiiGyZDHUfrsRMoZa0l6aMzEz
 bNNGZ8FBenxuufzgfpPmoqg7Cbsw1ddlU1mx7TzGFTn1Fbmn4SkOJlUoADi0mctAqX5z
 ULrqEg/Ri/oMvsM+s8LMYcfQt21ysnAhr44VVIh0v4brMZJM58g15CQMKiY15j8oVaK1
 MgndmJKmpsHZ0mqItS+99pjcKR2tkNCBVJ63/HE2Dlrj3UJpt3F55v3LO8JW8gLC7PXA
 FWroLn+NNQrTq3pxN3YlHLd56Hftxx3JbsMK4qY5mhr/6DNzxVhkOfKYlcz+kGkgllO6
 tiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705582620; x=1706187420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RpfO4oaFqs6lwAALE39rx6AfKD+NVhjkKQROy23W76U=;
 b=tXxNAIeGsfoGLOsYEkQD08DoE6keg4B+4jN9CVk7Hk7GNg6WN6caS/mMKujo6tvrnC
 3rV+io4TJye9xneldmqu7Mppcd+xv/gy0T+jLNAB9scJPTKMxa4oPhHSovI2SusKwWGx
 o1n8KXFnFpYD1ms9TXODOSt0oylKNpY6TvK/tC/H1yxlzOJmnVCt4SmDjHJ5TnmNNcI8
 vr5lT1bkzIHuUMRBHeEOGmiiZTzQfXCeDEtR9bh0vliTvq9zV9ISmRqPFx183lmF0UKm
 L25lIwRvll3jCblofQW9XRlRB24zFMk90jgYVIsLhBWLOH+DDDGD1pfwPreBi+U+CJW7
 2Svg==
X-Gm-Message-State: AOJu0Yx5gUBwOsWi69qxPGgT0kIQ4s2ezJNGOoiF4jugrV1RR81r4MoI
 QqQ4LIcD+PgIbo9819xhW9PJPR02qS4xS01YlhVi92qYXySCiqfepscs8uXjmQsvrRjgqy6qPWU
 5djV/zgfBE08ScAAXu9UvOzswRk8BVTPjR8ktVw==
X-Google-Smtp-Source: AGHT+IEm6jRj0FvOggQ3Z5lBaS9mQ/Qb7YCS1waC+LCfHyTzI1oRhDBojXc8cVJXmKfzJ7HCyulqSEnleg1mJfDTNLQ=
X-Received: by 2002:aa7:d98e:0:b0:55a:343:e617 with SMTP id
 u14-20020aa7d98e000000b0055a0343e617mr562471eds.76.1705582619999; Thu, 18 Jan
 2024 04:56:59 -0800 (PST)
MIME-Version: 1.0
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <y2kuootd3k2tqe2245zggbuusg2kaaqrxlvxfwy2wrcbdxg3cn@zgj6tl7gd4lp>
 <CAFEAcA8H6kVNiSk6CEVun5KWQH-sqWxBKxZ9Rf7haQhZHEKiow@mail.gmail.com>
 <CAFEAcA-sw2FNgTft0PYL=GW0JQhdRX9Zn0B6muUjC68nmVXHnA@mail.gmail.com>
 <e2hpw77r6t2ge6h233cq75qdadou6koz62sfktcsrlc2gzeqnq@4ejyxysmmulo>
 <CAFEAcA_f0Q7LkSQ2+sxgBcRQNSTenykq1R28QMuGyW22PtxW2Q@mail.gmail.com>
 <CAFEAcA_-fF7fWGm_QUJa86LHJvtBk4jKvTw=OvM+EOxQzuYvWA@mail.gmail.com>
 <7u5v67zlt5aapyinxbc4dgdiivtx4cr5mttdck6jzfknfb2ni2@lscetlkzwvjy>
 <b5d14237-5bf3-49dc-b9c4-4f18bd6dec96@tls.msk.ru>
 <7gsflxxdzqdjzeyool3kjgsokjgxbys3tijlcmqf2fusddn7o6@vafldjprddge>
In-Reply-To: <7gsflxxdzqdjzeyool3kjgsokjgxbys3tijlcmqf2fusddn7o6@vafldjprddge>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2024 12:56:49 +0000
Message-ID: <CAFEAcA87C0W0nRLe4pbf7LHLP7w38iV3zCHph5_N8bsR77mhmA@mail.gmail.com>
Subject: Re: Re: [PULL 0/6] Firmware/edk2 20231213 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 17 Jan 2024 at 14:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Jan 17, 2024 at 01:16:34PM +0300, Michael Tokarev wrote:
> > 15.01.2024 13:20, Gerd Hoffmann :
> > >    Hi,
> > >
> > > > PS: when are we likely to be able to update to a proper released
> > > > EDK2 ? Running with a git snapshot isn't ideal, so if we can
> > > > move to an EDK2 release version within this QEMU cycle that would
> > > > be nice.
> > >
> > > Next release should be tagged by end of February, so if the qemu 9.0
> > > schedule is simliar to the 8.0 schedule this is before soft freeze
> > > and an update should be no problem.
> >
> > So, should we pick this up for 8.2.1, or wait till next release of edk2 ?
> >
> > The thing here is that for (some) downstreams, edk2 is a separate package,
> > so if qemu relies on changed edk2, it should be there before qemu-side
> > changes can be added.  So if we pick this patchset up for 8.2.1, it might
> > be a bit surprising for downstreams.
>
> It's not that there changed something in the edk2 <-> qemu interfaces.
> This build contains a workaround for the current shim.efi clusterf*ck.
>
> The tl;dr version:  The build is compiled with the (very recently added)
> PcdUninstallMemAttrProtocol=TRUE option to workaround a bug in shim.efi.
>
> The extra long version:
>     https://www.kraxel.org/blog/2023/12/uefi-nx-linux-boot/
>
> Picking this up for 8.2.1 makes life easier for the downstreams which do
> not do their own firmware builds but ship the qemu prebuilds instead.

On the other side of the scales, it's a bit unexpected for a
stable-branch update to include "unreleased version of EDK
binaries" (rather than, say, "same version of EDK binaries
but with one specific fix"). So I can see the argument for
waiting for the tagged upstream EDK release first.

thanks
-- PMM

