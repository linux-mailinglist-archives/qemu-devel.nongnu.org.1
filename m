Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BD575F7C3
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:05:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvEd-0002rE-Cc; Mon, 24 Jul 2023 09:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNvEW-0002qa-Il
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:04:18 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNvEQ-0001ja-Fk
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:04:16 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51e28b299adso7005876a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690203837; x=1690808637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i0VbEX0ynJ0FpIGNZtEVhvU8T5VNyQwtNIFED01nX/s=;
 b=aSlevQlyRRaq5zS5iWEQqk5cGwDk+19Gp477zvZ8olqZBsnfrZMv7rCKs0mXEEe/jr
 aqc84uLhNNP1KvTnEexkj6lDC4QCBO+l9/McGzq+h0yI9j4vFm0oi1QTpo85/FGliMEi
 pMZMiGsHXpUfakU8e9xFkYEtmkU78qLG1hoYFHKnIAr9fZhrfAZ+J1li5sraRvIDDDnG
 5tL29gbOIgyvzk50lUVbgXg1+A5id3k2XCy394/a2qKCWNvo1CtPWcWdw6qOdOLMLRSY
 rQ0OuRzPok9u3ED53uH1YnMxmWIOMJjmO5VbDs7ask9LK9u3mHxQoKEf11Hh2kEYQjAq
 Mr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690203837; x=1690808637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i0VbEX0ynJ0FpIGNZtEVhvU8T5VNyQwtNIFED01nX/s=;
 b=Rwqvs6nLlcDqBbeicL7yKNA0mvcGMXj33XE+plVqt+H4OT/ICtUAwGqJS0BOLxFugz
 N451trHzRsnXdLEQOPWRW8k1BEMLSubASfSXriStBawaQxLy75GpmzfzM0Eo17VMfrnv
 Ygy3t+oJnIo6YIM0RYN8Hvfx2jemMPanHQ/dmK3QY4wB/CoeRUHqdgta8vISPgd0sgIr
 glTrBtEIUZJ3MurHHiqLniqn+71pQzjFRfJPU52npMPWEwhXxPUec0WC08MinnubsLM9
 rJ9bzug4/MWZieKW2dyuR39I/LRvAMR812oPpvrOo6U/OPcryOaePeu/yS4pq3WJ8Jol
 8XvA==
X-Gm-Message-State: ABy/qLZELqL+WpxSc99IhqAi2l3NEOFKT1ozORS6NZlLlw98WxfDSESt
 X10leeXyh5fq6KlCz0jS/tmjgSCKzLMa7nNJQIEw3g==
X-Google-Smtp-Source: APBJJlHw6tf45QG8k/UFfx4HIGtltsttsbZydooBOe6/KltI21pxdD0c4r4k+9BHkP1XytzxJv1IqLPDl48bRaB48fc=
X-Received: by 2002:a05:6402:204e:b0:51e:1af0:3a90 with SMTP id
 bc14-20020a056402204e00b0051e1af03a90mr9266743edb.37.1690203836775; Mon, 24
 Jul 2023 06:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHyVn3Bh9CRgDuOmf7G7Ngwamu8d4cVozAcB2i4ymnnggBXNmg@mail.gmail.com>
In-Reply-To: <CAHyVn3Bh9CRgDuOmf7G7Ngwamu8d4cVozAcB2i4ymnnggBXNmg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 14:03:45 +0100
Message-ID: <CAFEAcA8o4ct_VUjFV-aDpksocbCT2DjzLY9Usftar6Eo=WkzsA@mail.gmail.com>
Subject: Re: [PATCH] For curses display, recognize a few more control keys
To: Sean Estabrooks <sean.estabrooks@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sat, 15 Jul 2023 at 14:31, Sean Estabrooks <sean.estabrooks@gmail.com> wrote:
>
> The curses display handles most control-X keys, and translates
> them into their corresponding keycode.  Here we recognize
> a few that are missing, Ctrl-@ (null), Ctrl-\ (backslash),
> Ctrl-] (right bracket), Ctrl-^ (caret), Ctrl-_ (underscore).
>
> Signed-off-by: Sean Estabrooks <sean.estabrooks@gmail.com>
> ---
>  ui/curses_keys.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/ui/curses_keys.h b/ui/curses_keys.h
> index 71e04acdc7..88a2208ed1 100644
> --- a/ui/curses_keys.h
> +++ b/ui/curses_keys.h
> @@ -210,6 +210,12 @@ static const int _curses2keycode[CURSES_CHARS] = {
>      ['N' - '@'] = 49 | CNTRL, /* Control + n */
>      /* Control + m collides with the keycode for Enter */
>
> +    ['@' - '@']  =  3 | CNTRL, /* Control + @ */
> +    /* Control + [ collides with the keycode for Escape */
> +    ['\\' - '@'] = 43 | CNTRL, /* Control + Backslash */
> +    [']' - '@']  = 27 | CNTRL, /* Control + ] */
> +    ['^' - '@']  =  7 | CNTRL, /* Control + ^ */
> +    ['_' - '@']  = 12 | CNTRL, /* Control + Underscore */
>  };
>
>  static const int _curseskey2keycode[CURSES_KEYS] = {
> --
> 2.40.1

So, there's already some logic in ui/curses.c that
handles control keys generically, and it was put
in (or at least modified) way back in commit d03703c81a202ce
in 2010 with the commit message saying it was for
control-{@[\]^_} :

                if (chr < ' ') {
                    keysym = chr + '@';
                    if (keysym >= 'A' && keysym <= 'Z')
                        keysym += 'a' - 'A';
                    keysym |= KEYSYM_CNTRL;
                } else
                    keysym = chr;

But we only use that code if kbd_layout is set.

So I'm not sure how this should work -- are these
control-key combinations keyboard layout specific and
that's why this is only in that branch of the code?
Or are they generic and we can support them in the
no-keyboard-layout case too? I did a bit of playing
around with my non-standard-keyboard-layout and one
of the ncurses-examples test programs, and I think we
can do this regardless of keyboard layout.

Unfortunately this curses code is (a) pretty old
(b) has no active maintainer (c) is not used much.
This patch looks like it's OK to me, but I'm guessing
a bit. It looks a little odd that we programatically
handle control-X in the with-keyboard-layout case
but do it data-driven via the array in the without
case, but that's the way the code is already written...

So I guess

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

This seems like a safe enough small change, so I'm going
to take it via target-arm.next, unless somebody else
would like more time to review it (or to claim the
vacant maintainership of the code ;-))

thanks
-- PMM

