Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF82478C8E7
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb102-0002Gb-1Y; Tue, 29 Aug 2023 11:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb0zq-0002EJ-Gc
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:51:14 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb0zm-0006cq-50
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:51:14 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so11296872a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693324268; x=1693929068; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mjP7Nk2AiweCUTPo0u46RcHlgpd5d+u42BjdFO/+fGY=;
 b=Y2VVHnn5X4hCiVjSzTxok9JOG+f4VNQsDeR7+UESIsj55oZ2+WlA3ubCC+Br2QKdah
 0o+oNXSxnr0nna+zBB4xUmSmZ4Cn1hpy5yPWBn4rIkq0DFyoCQAGLw/pFrF2gRbiHqs8
 XaG0CedwawGLBzCHwF5SapzfOWvmAvo1jIbu/qlopyAhh27s8o3xKGzNDCiE5Rx0vjIs
 oe/Jdctmwqu1SvBiQnDvXdC6R2FyUHkNdcFRR15SImOY1Wxr0SqPpSVgV7Ni+fw6Zk+F
 BHisw5Q34Qq75EJHJ3kYHVJKatcQO2R2XFzRzWtYeEI1FjAyEDDbXuAQd4UnSKQGtIDz
 WuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693324268; x=1693929068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mjP7Nk2AiweCUTPo0u46RcHlgpd5d+u42BjdFO/+fGY=;
 b=kiC+Et0mpMIdGomacRYN0/ox62ng5lA5K4R0jTVVc2n6mlC6GIJ1738NOWiJpDnFq0
 xg7Yt4NbFr6pTygT91lRyIO0kHJsPa9nM5MzPs8mJDX4UZm/KOG8IU2BMuzaH7dKvMLQ
 6o2We8u3UvjCeEK7ij4J8IE3QOt6k5ISqYh4TbL/CSm2SEsSabDjCjWXsOc8UaVc4V5q
 yq/opZui2IUj/R/wk66Q5hBW3gEUf4E20ozpFTOSB2dxnnU62bgSnCTiM438jnsXQNNI
 s9hIjWNhgaEWLrdUdnmWnDrRjiaNe7WJpwawmrsrEiiXZHkIFFwHMkI1IKL2XNI3NzmA
 a6Kw==
X-Gm-Message-State: AOJu0Yxs/veNK1734Y9SNEzmZkP2KvOlDj5FeuR31z2vaS6VXDmWg/CF
 Dl4DZfuQCkDIWn5PQNc/PadSHAWsAnGOOI/u3vZzY6lxKAqylIyu
X-Google-Smtp-Source: AGHT+IH/bsJBiWlZhu96+ElnNzhLvwK68UzE3yoWnqhy6seFCzRvRtj2wrWjAd76sE9Hfe/Paw/1FkKza8zT/iZANTk=
X-Received: by 2002:a05:6402:51c6:b0:522:c226:34ea with SMTP id
 r6-20020a05640251c600b00522c22634eamr3480848edd.7.1693324267752; Tue, 29 Aug
 2023 08:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
In-Reply-To: <20230720155902.1590362-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 16:50:57 +0100
Message-ID: <CAFEAcA8XzYQsGO+g+hCmVuXc5ZmJE7wmwNihKm+1cMbRawPkTQ@mail.gmail.com>
Subject: Re: [PATCH for-8.2 0/4] rtc devices: Avoid putting time_t in 32-bit
 variables
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 20 Jul 2023 at 16:59, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset was prompted by a couple of Coverity warnings
> (CID 1507157, 1517772) which note that in the m48t59 RTC device model
> we keep an offset in a time_t variable but then truncate it by
> passing it to qemu_get_timedate(), which currently uses an 'int'
> argument for its offset parameter.
>
> We can fix the Coverity complaint by making qemu_get_timedate()
> take a time_t; we should also correspondingly make the
> qemu_timedate_diff() function return a time_t. However this
> will only push the issue out to callers of qemu_timedate_diff()
> if they are putting the result in a 32-bit variable or doing
> 32-bit arithmetic on it.
>
> Luckily there aren't that many callers of qemu_timedate_diff()
> and most of them already use either time_t or int64_t for the
> calculations they do on its return value. The first three
> patches fix devices which weren't doing that; patch four then
> fixes the rtc.c functions. If I missed any callsites in devices
> then hopefully Coverity will point them out.
>
> This patchset is a migration compat break for the aspeed boards,
> because the offset field in aspeed_rtc is in its vmstate struct.
> We could in theory make this a compatible migration change, but
> I don't believe we care about migration compat for these boards.
>
> I've only tested this with 'make check' and 'make check-avocado',
> which probably do not exercise these RTC devices much.
>
> I've tagged this as for-8.2 because the code has been like this
> forever. We might as well give ourselves plenty of time to see
> if there's any unforeseen consequences of widening the type.

8.2 dev cycle is now open, so I plan to take these through
the arm tree, since they're mostly arm timer devices.

thanks
-- PMM

