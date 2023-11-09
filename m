Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2857E710A
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 19:02:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r19LX-00050N-Sl; Thu, 09 Nov 2023 13:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r19LN-0004wj-9G
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:01:30 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r19LK-0001Ft-Jg
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:01:29 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so1825978a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 10:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699552884; x=1700157684; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rIlNApzXrb8e5wRpfNh4qEA6gI1Xn0LpbJPDKaRcJTk=;
 b=l3YBtsItETBuc1ZFAuH2ONaaev9wC594793ilHr2cb9H+yvvcmApMzfXRkQraU6rMb
 RJCcQbQCoU/ucPCu//J0xjz3xSKI2Ua/yi+P1L7ek5/gyGW8cFuINPfuGgqsxHuoIt5G
 YXnbNx7AVlbv/RqeGbGHlkaRdeohQp5aNyDDIkAcLzH/seEZRUd/HinYRh2Jb5M9JFNF
 mEnwGKBFRDV65B6pKw92yvmjqxInlXn6MJvoNbVXBw+rSy0yJzMRbTrpGV9nH5meMRTU
 PdcEHs1oaYag4N6CDhq0mPLVTKq2RTvy0d5xhppDBuVVg4npQ8aT9EFOHFSvburPvP5K
 kJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699552884; x=1700157684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rIlNApzXrb8e5wRpfNh4qEA6gI1Xn0LpbJPDKaRcJTk=;
 b=R7Jd8BpQwqQT3HJ+NXnHE9P2zCmy7ozPL7WhrwlNX2IiiEpz3rg1FFXHxhE+NeUMRJ
 tq+a3tdGUec3xnuEPXbDmwsZpucKh9bEdI/6CDxotjD02cOBKVk11/PEHByojlSSWugB
 8uhpTtOdM8SdWOXCCAGEjqzKbK+ukXftHzswOW2cN5qEf13L8Gqio8PBGa3jGH3Suz1n
 fLAy8J3M+4AWc54M8VqaCVwgln8iYagIBj3eni0uZ/LgSKYDxVBKKGNpD/5O9I0zG0aH
 lYpB7ObZ7QhV8fcm6OW79ilA9r928IM6RFM2dM7mHZoQhS1F+U/h22Wa/TtOGg5ZY9OL
 bbXA==
X-Gm-Message-State: AOJu0YzjhR6UyKt8zqWYmmHdhDR6tQZpETNsVEnkZVicixpPbyEz3/l2
 5UJ1595PAUnogQQ1aEcMJQ7gIgo52TFIM+Hu4nA1bg==
X-Google-Smtp-Source: AGHT+IE0G8TCFNaNpPdCbXZS5fN8JNyUxrvhrx901jbYf58mDtg/h+jOGNVRarmHr0NWlQEY70VnpbseNKK12qS2cPk=
X-Received: by 2002:a50:cc8a:0:b0:543:5d2e:a9c3 with SMTP id
 q10-20020a50cc8a000000b005435d2ea9c3mr5306640edi.20.1699552884331; Thu, 09
 Nov 2023 10:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20231109173544.375129-1-thuth@redhat.com>
In-Reply-To: <20231109173544.375129-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 18:01:13 +0000
Message-ID: <CAFEAcA_MK9-jzQx-po06-CnLLBHQSA2_VB3g7UFVCCiJskyCeg@mail.gmail.com>
Subject: Re: [PATCH] hw/audio/es1370: Avoid four-letter word
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-trivial@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 9 Nov 2023 at 17:36, Thomas Huth <thuth@redhat.com> wrote:
>
> Using certain four-letter words is not good style in source code,
> so let's avoid that.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/audio/es1370.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> index 91c47330ad..bd460c810e 100644
> --- a/hw/audio/es1370.c
> +++ b/hw/audio/es1370.c
> @@ -670,8 +670,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
>      cnt += (transferred + d->leftover) >> 2;
>
>      if (s->sctl & loop_sel) {
> -        /* Bah, how stupid is that having a 0 represent true value?
> -           i just spent few hours on this shit */
> +        /* Bah, how stupid is that having a 0 represent true value? */
>          AUD_log ("es1370: warning", "non looping mode\n");
>      } else {
>          d->frame_cnt = size;
> --
> 2.41.0

We could be more usefully clear here anyway:

/*
 * loop_sel tells us which bit in the SCTL register to look at
 * (either P1_LOOP_SEL, P2_LOOP_SEL or R1_LOOP_SEL). The sense
 * of these bits is 0 for loop mode (set interrupt and keep recording
 * when the sample count reaches zero) or 1 for stop mode (set
 * interrupt and stop recording).
 */

PS: while we are cleaning up comments in this source file,
how about the bit marked /* Start blatant GPL violation */ ?

I think what that comment is trying to say is "most of this
source file is under the MIT license per the comment at the top
of the file, but these register constants are from the Linux
kernel sources and so they are GPL2". Both these licenses are
fine for QEMU, but we should have the commentary at the top
say "file is this license except for the GPL2-only macros etc"
rather than misleadingly claiming this is a GPL violation...

thanks
-- PMM

