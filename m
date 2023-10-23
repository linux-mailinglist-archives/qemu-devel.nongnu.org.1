Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C3E7D2EA3
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:39:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurOj-0006eD-W3; Mon, 23 Oct 2023 05:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hans-erik.floryd@rt-labs.com>)
 id 1qurOa-0006XP-CA
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:38:48 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hans-erik.floryd@rt-labs.com>)
 id 1qurOY-00069g-Dk
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:38:48 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ca215cc713so16382535ad.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 02:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rt-labs-com.20230601.gappssmtp.com; s=20230601; t=1698053924; x=1698658724;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsJyX4TfKJA3zFCOJLEpoqaUqIFOUY/32FohvbS+1UU=;
 b=vGR7rFxfh0pRyCzhZM+Ef+kbOY86nzs8tNQweyOV8a8vzOPR0NKyAzPQDYdAwKPxty
 COhVHrCfmVZKgoChQ55pmwKpf+UYcRuRiNxJrQil97Zyi5iF9cLVjCw2+lNRfw1IGjK0
 uKc7OZj/JBsbUszaGtdaz6w2cyUXdt13ttJTbpPdbGqUmIFG5ZUgl42EXE7KpEyTI0Ib
 +S3VhWNzjTunAVo0bT6ne5Oc+DnnTcy7ABNZ14jPrDZ4xMV/UOFuOtUi0cGD8Q1lCR4Z
 N/P74bd4PSLGW+E1cq4nPNXcbEzDCieP3ktufHsUtFVY0iPlIDxiLlXY7FUHiyIqWEqw
 6qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698053924; x=1698658724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsJyX4TfKJA3zFCOJLEpoqaUqIFOUY/32FohvbS+1UU=;
 b=k3IlQ0R8OY1fNyDtl61gELLg9/gICkoumBhkZ9ddH7ZGmj/rTPMVROzOZRmlFzH9Ha
 riOLI2UNUSr2pDO5V0F9ciF/YRz216+K+2JZaWpSD+xjaE1lGrs99tGVRn57n+fy+WOj
 29K3UDB2yWRVNsWbSkgnF3qAOXM0JQv+8tMKxq/itpHFTCcpKeLnho8/+QwFNUlAI7QJ
 vBNCCppQxi524N/NMGYiZw2bFul6bBUNVuMroR5ZCfmDgiaHORghV0un8HnZimzDBIRH
 lk10TWbvqRcedNHAc+yzu6t1Q5y/KGGZ451fJrYeujkfUSa1QW/9iVQQZrsavZOCaBBu
 DWXg==
X-Gm-Message-State: AOJu0YyRDcBTz2RwMtb0VqWvLt+RYhooSFD32zCdRLQXhcVOXgT3SnUl
 R9L4C4l3qolGxeG7MkMuRhIiaSXATZSLmo7FEWIrVQ==
X-Google-Smtp-Source: AGHT+IFadVVLLcyK3irFKtyxZBORWPKTBKwCs/MKLWFI0woYamcTmy7NFEUhv4xg76bgvmcZIKy2pIRWuPX+UvD5QDY=
X-Received: by 2002:a17:902:e88a:b0:1c4:13cd:b85f with SMTP id
 w10-20020a170902e88a00b001c413cdb85fmr7259210plg.5.1698053923947; Mon, 23 Oct
 2023 02:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231020170009.86870-1-philmd@linaro.org>
 <20231020170009.86870-3-philmd@linaro.org>
 <CAKmqyKPJoyMmoNAX9JrHz6_SSphqRkEJPy3AUaV0eu+701Ow9g@mail.gmail.com>
In-Reply-To: <CAKmqyKPJoyMmoNAX9JrHz6_SSphqRkEJPy3AUaV0eu+701Ow9g@mail.gmail.com>
From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Date: Mon, 23 Oct 2023 11:38:32 +0200
Message-ID: <CADS1RdShzeE_VCMDMjCEcN06f6cEVh3dQ61g=oOKSsEBJAwuuA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] hw/char/stm32f2xx_usart: Update IRQ when SR is read
To: Alistair Francis <alistair23@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=hans-erik.floryd@rt-labs.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 23 Oct 2023 at 03:37, Alistair Francis <alistair23@gmail.com> wrote=
:
>
> On Sat, Oct 21, 2023 at 4:12=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> >
> > From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
> >
> > Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
> > [PMD: Split from bigger patch]
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> > Is this required?
>
> I don't think this is required
>
> Alistair

I agree this should be removed. It was added because the manual says
that some irq:s are cleared by a combination of reading SR and writing
to DR. However, those bits are not implemented yet, and probably the
clearing should be done when writing DR anyway.

Thanks for reviewing,
 Hans-Erik

