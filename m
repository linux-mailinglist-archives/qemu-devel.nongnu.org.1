Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B496378EC64
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 13:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbg4d-0008JP-80; Thu, 31 Aug 2023 07:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbg4R-0008H5-Vg
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 07:42:45 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbg4P-0001O9-HJ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 07:42:43 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5280ef23593so854438a12.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693482158; x=1694086958; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZYYMlf2Q/sBIqNnlNnSd1DVS5c7jiyWNWe7v8r7llI=;
 b=RWqGhM7UgeyEWsWfSIZzJO3VdOlV9R2OfVvsHNtpWp/LGhHD0k8faHcd1uiSJ2VgdO
 gDWbPgWUoz59LrvDUDxoOUFppI4VeLy1uu0CmVZ36pk6DtupAQilvm3Xyr1yaqNkVlQF
 FkJba3RI0G/4dZCNHnIG9yGMAKpz75nNiz/Tnx613KIYm8qAL+yEgUUyNS8f3J3wHxYn
 zDJsJ4+6Mvz21V+luqkTcRji7RvbJ53LaPnl14J/TLic8rqhYMKTXc89WMjfZqnbo1cr
 RDibtro69uA+6WbIznNjx8HOeVtT/NOPfi+NlgbzLmDws/4lRPD9PW09QooJKxBShRn0
 dnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693482158; x=1694086958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DZYYMlf2Q/sBIqNnlNnSd1DVS5c7jiyWNWe7v8r7llI=;
 b=Thdv2BCF5eQJUxSnteZMm7sRfQHSPfmnpy16nY5B9llwl+2gk+79LIHJ8tuT7EQWZL
 lq2bR+UPS2bO45yk5of57nkSt9zkqXyS+IGBaorx/C747d2clTyo+XG+J1m6kDVKDCyL
 ywOawv5B1zH0u/7MZyI1tO6VEAcxoxN3AOSXOIF/bLBTk4QzEpkN3Zwew9p5Sb2KiFDo
 PSRJfGI9oG7x88ynHkcGB48tLPNLDoE6sJ/MsTGU8WmMnGx97N7DE6z0AwalxS6R6Q8Z
 br4YM6wMwKVOTX6yd6GlWd4wxGeH7xHo+H5Aj0SqGA0k2mvCVBn8puAmP2fpqJitOlM9
 rxgA==
X-Gm-Message-State: AOJu0YzVLLhxf3H3UyRKREYTs9jTe11/GnPgRxG9e5LWV9Aup7pDAVp1
 5jteNl/teccaEFedHt3svxCqPcFXMwuF9yp0xbLJEQ==
X-Google-Smtp-Source: AGHT+IFl4wwDm0ua5CjWpvaFUGyolXCkXUNGWOEKAEJSJIc3bB6h9uhvyAyd6pxrYHp+x7WDevFt9lIiV4C29oUEVcI=
X-Received: by 2002:aa7:c414:0:b0:51e:ed6:df38 with SMTP id
 j20-20020aa7c414000000b0051e0ed6df38mr3890545edq.13.1693482158356; Thu, 31
 Aug 2023 04:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <87y1hspiyh.fsf@linaro.org>
 <alpine.DEB.2.22.394.2308301745530.6458@ubuntu-linux-20-04-desktop>
 <CAFEAcA8Ziov9vA9dW+4vzFE=KkSUqfMNNMZOtvQhqCXyjRytzQ@mail.gmail.com>
 <87cyz3pmgz.fsf@linaro.org>
 <CAFEAcA-m8G1kfTw52kOGPEvQwWPph0NWc0URVY1aQ2WwVeB_OQ@mail.gmail.com>
 <878r9rpjvl.fsf@linaro.org>
In-Reply-To: <878r9rpjvl.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2023 12:42:27 +0100
Message-ID: <CAFEAcA8ZdkHmtJ1r5zi-bW4msSUqvCdo1L6QbqMjEaJHf5Ji1g@mail.gmail.com>
Subject: Re: QEMU features useful for Xen development?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Xen-devel <xen-devel@lists.xenproject.org>, 
 Stewart Hildebrand <stewart.hildebrand@amd.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Sergiy Kibrik <Sergiy_Kibrik@epam.com>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 Vikram Garhwal <vikram.garhwal@amd.com>, 
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 31 Aug 2023 at 11:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > All our MPS2/MPS3 boards are M-profile. That means we have the
> > device models for all the interesting devices on the board, but
> > it would be simpler to write the an536 board model separately.
> > (In particular, the M-profile boards are wrappers around an
> > "ARMSSE" sort-of-like-an-SoC component; there's no equivalent
> > for the Cortex-R52.)
> >
> >>   https://developer.arm.com/documentation/dai0536/latest/
>
> It's not super clear from the design notes but it does mention the
> SSE-200 sub-system as the basis for peripherals. Specifically the blocks
> are:
>
>   Arm Cortex-R52 Processor
>   Arm CoreSight SoC-400 (n/a for QEMU)
>   Cortex-M System Design Kit
>   PL022 Serial Port
>   NIC-400 Network interconnect
>
> But if writing it from scratch is simpler so be it. The real question is
> what new hardware would we need to model to be able to bring something
> up that is useful to Xen?

Just the board, basically. The SSE-200 is specifically a
dual-Cortex-M33 block; all the references to it in the
AN536 appnote look like cases where text wasn't sufficiently
cleaned up when creating it based on the M-profile doc...

-- PMM

