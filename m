Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE2F7D59E9
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvLUF-0008ET-Ce; Tue, 24 Oct 2023 13:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvLUC-0008D4-Jr
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:46:36 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvLU0-0006ba-TY
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:46:36 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53e84912038so7157461a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 10:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698169582; x=1698774382; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HOrDbc0nM6QgTDLV84pYjI62RbgxYMi5tMwl8lyeQpM=;
 b=rNUXMhM4NlKa+0LOpuAumsjviRKIjv4vcoxnw7k+dR68HBsvc736kdx5FbTV9jebjy
 /vrOJ96qFY8a0P1U3Y5kSYHpjF7pF0VLOyOnszVgp/okEdu2jpLZqvZu6ISd5yX6DPCR
 hreHACgu5U3JPRpixl75PX2rQBZvZ4lG8EDDa4PV/pSVZ69tHG/H7mUZSQ52P2EB0UXf
 k+XnUSdCj2E1hft/bAAnHiRfCvQxbtu3aSI8e0mHrc0yW5iOTLAhPFniPw6KC4yD4NxH
 jzs16M7sGiwzsV/aXO1dBeQmZsamEKJoIAsgFL34Qtf5fWW8jIhi4yOtO65tNHj9sQ/o
 nPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698169582; x=1698774382;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HOrDbc0nM6QgTDLV84pYjI62RbgxYMi5tMwl8lyeQpM=;
 b=suCsK86g6sDyl0scwhOIF1wkdmBPLgmiUHQ+iMHjDDu+Dxe/0HsiM4Vymx3GNqXGv/
 yQe9piK1RoRR72VfGFTVcvEOlEroycXYs+DiiOicP4CtuE9hAqrRYEWUWgfICelWxgPp
 bHiaDNJDVoPMxNcjwo+4b1DSmj4k+Z0VEpWGb/rU/do6/ychKY94j+wm8Ym9Hv8Gs1Jf
 4cdm6qLAMgcGGlmWD9grVKuRUv7hAnmcrqcG7aBqZLpIZ6YEXykH8LeQbFVMdyBpMpA0
 WusdMNZxbK7R/ZSv0x8rqB1AjKSMDGR+Q803UWjlp/5Zh7lv9i0VAJ6LchpSQnWVGHYq
 LIfQ==
X-Gm-Message-State: AOJu0Yz57wBQnNz9cMyuVpoCNFZLzzEJLMldSWvSpzchojR/fHU7GTC+
 2GW6Ot31zt6l6SXqc/r2pf05GUcjEbJ3KxyYq268ow==
X-Google-Smtp-Source: AGHT+IEV4VyK0MXonrqPazLQNOL5HC9kgfZ26Cs5nIyVVM8i7uyTpoNZwYvYgRlfK95CQS62hpoze01VFKCh6Jv0VtY=
X-Received: by 2002:a50:ab12:0:b0:530:7ceb:33c with SMTP id
 s18-20020a50ab12000000b005307ceb033cmr9300084edc.4.1698169582329; Tue, 24 Oct
 2023 10:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231024173923.4041874-1-milesg@linux.vnet.ibm.com>
In-Reply-To: <20231024173923.4041874-1-milesg@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Oct 2023 18:46:11 +0100
Message-ID: <CAFEAcA9ZLk7XYpjOQ-_9JXELK_qjgW3ABmpHY=aiPa+DS-131A@mail.gmail.com>
Subject: Re: [PATCH] misc/led: LED state is set opposite of what is expected
To: Glenn Miles <milesg@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, 
 andrew@codeconstruct.com.au, joel@jms.id.au, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 24 Oct 2023 at 18:40, Glenn Miles <milesg@linux.vnet.ibm.com> wrote:
>
> Testing of the LED state showed that when the LED polarity was
> set to GPIO_POLARITY_ACTIVE_LOW and a low logic value was set on
> the input GPIO of the LED, the LED was being turned off when it was
> expected to be turned on.

It looks to me from reading the code like the bug is there
for active-high GPIO as well ?

> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
>  hw/misc/led.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/misc/led.c b/hw/misc/led.c
> index f6d6d68bce..96cad7578e 100644
> --- a/hw/misc/led.c
> +++ b/hw/misc/led.c
> @@ -63,7 +63,7 @@ static void led_set_state_gpio_handler(void *opaque, int line, int new_state)
>      LEDState *s = LED(opaque);
>
>      assert(line == 0);
> -    led_set_state(s, !!new_state != s->gpio_active_high);
> +    led_set_state(s, !new_state != s->gpio_active_high);
>  }

Maybe "!!new_state == s->gpio_active_high" would be clearer?
Then you can see that we are (1) converting the int new_state
to a bool with the !! idiom and (2) we enable the LED for a
high input and active-high GPIO.

thanks
-- PMM

