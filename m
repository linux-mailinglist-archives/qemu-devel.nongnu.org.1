Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EB97773F6
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 11:15:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU1kN-000189-DV; Thu, 10 Aug 2023 05:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU1kL-00017n-S5
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:14:21 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU1kK-0007MY-Bi
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:14:21 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5234f2c6c1dso859415a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 02:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691658858; x=1692263658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2ymAEecElLVLmcZKoFbNRjqEhJz0WRnXzYSGc5XvTyQ=;
 b=ur60bvk7dZtOxUIZNlDR8EgG0xVx8NWge3fsVbas26GeP7FTMxRsNPHwQ6qmb5UNpR
 eJZSnfkq7FAXersiLcRoQIzNg/kQ9+Kcbpqnzy1GmNlhTYUUvtFdfhs61xrgNllb36Kv
 CrJxvHRKrv6uT4xRu1uKwhInRarkseKoMHFt0LK0iR1J0t8p0CpXlX9+NSldCKrLBYba
 TvtceUO8uhvh0X6orgAXQREdJ3M+GTgnmmex2B3OS7CM7WaSWfpavRkh9i0SezpW7V41
 mvpwlem+PwCH/mFUyVsthvAtSP16TDXiPGQG2SfBRlVIpRJfQ1GV71ahEmZfIJFIP8Yl
 a6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691658858; x=1692263658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ymAEecElLVLmcZKoFbNRjqEhJz0WRnXzYSGc5XvTyQ=;
 b=LnZFyzgwY3Ten34l8ZHbmwhm/qa39MavYpqUwKhSisFQfMbfXqWpDiilomrwo9zv4P
 yiMbrpXMezKWJUlh4t9PExzQYM8jl/iDmOrA16E+AMnYuguA7e/NY7Us+HRiSFPY3Y90
 180QVc1z3xfVMeWK4Mcj5wY+C2z3V9ntJ4JAUXoG69MMQ/B0LqdJ9/5eI8hcnpN4l7eX
 spdG1WxWB1NPhVjdUhet4I9v3Pw87JVHf3uSIqwp0THihwJ0B0HizHJUWb376Froo1Qv
 rTYfm1JOmB+gDsOFYIcALPilvYGWSUts1EFQArD+R7sT50ljn2/Lp5A1PZkrQyu9/bX8
 Rw5w==
X-Gm-Message-State: AOJu0YxhZYuQOECiaeY8WNyX6iw/PnQ5b/HFDCsUFwKDrdLHQPOgNxVI
 m8NwLFNYp135hy6pVjhRQy+wsPZ97fhvxTCr0oE3ug==
X-Google-Smtp-Source: AGHT+IGI4o5ty+wUntNAp6eHZPITCMSCjzfIkXZ/NYcJ8m3LvT6lEi3AKfXOlv8kMLlN0K3wD22vzIbOzXNperoJfek=
X-Received: by 2002:aa7:d747:0:b0:523:4bee:43ed with SMTP id
 a7-20020aa7d747000000b005234bee43edmr1701665eds.18.1691658857991; Thu, 10 Aug
 2023 02:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <ZNQcQxcL/22LmrVP@p100>
 <129c90ab-14cc-04bb-493a-d4524b54c02f@linaro.org>
In-Reply-To: <129c90ab-14cc-04bb-493a-d4524b54c02f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 10:14:06 +0100
Message-ID: <CAFEAcA_yD37zTnXNkX+qg_WtUUQPJrk72UL4vusdJrnNHz4H7A@mail.gmail.com>
Subject: Re: [PATCH][RFC] Add crash handler for qemu-linux-user
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org, 
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 10 Aug 2023 at 02:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/9/23 16:07, Helge Deller wrote:
> > +            /* did qemu source code crashed? */
> > +            if (unlikely(!h2g_valid(host_addr))) {
> > +                qemu_show_backtrace(info);
> > +            }
>
> This won't do anything at all when reserved_va == 0,
> i.e. 64-bit guest on 64-bit host, or any 32-bit host.
>
> The idea of having a backtrace is nice, I suppose, we just need
> a better detector.

I think Dan also had a look at one point at doing
backtraces for crashes in system emulation mode?
Certainly this would be useful for test crashes in CI.

thanks
-- PMM

