Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F17E7B5E
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 11:21:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Odi-000407-Fj; Fri, 10 Nov 2023 05:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r1OdZ-0003zl-Qw
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:21:17 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r1OdX-0007tz-Tk
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:21:17 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso2963112a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 02:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699611673; x=1700216473; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LqHY1rM+nJijkVtRNRAZWGeNV/wqoJqulwCB5qLr/y4=;
 b=ibq1QfZjiC41nploVvtIV9UazPqmOakfhqm+EVSE2syEjEK/kno4rVt8nd+lNpV/cs
 CstuO91P9Ifk2EpriO6LcZLm8E5rrWigPKIRcEQl6rnzuIw0tRL8KMyNZ6AimjAJd04H
 C7zDDcZiQJCD8TSjaE7/d/t2XZF/fGtaS8qsXmDZboRt/dzga/hu7aqUjxVKHqtgQzs3
 VJ+Bzh4S8kLu9epQbRRdgZgokzERW0HTezHymYAgvMb4Nkpgw/m8poAPbqByM7jeab2s
 4rdbh5ITyp6ulgOk56Iu/+ErQb8y+4dqHYPE/pike0K1ZPK2bDZ6GRW7pIgqQIDHoPhM
 t5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699611673; x=1700216473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LqHY1rM+nJijkVtRNRAZWGeNV/wqoJqulwCB5qLr/y4=;
 b=ZkLnL+G1UhFmooFYOBPuW41zix7fhP6seE3C6nohkxV3dtW1WGXPMY8fZ36HftFtHc
 z9MXCeSVRnBillxleHK6cuDhh4XgjD+m88b7P8xzFIKsgnj8JPdIKGwshsRWvzBPxYYr
 D0RzAYjwdLxkZ5k0BAOUbQyicf0B8LBeBF/Lj5s8hcsBCTMYIomXItKxAsrTrqyCb2md
 B1PQ3rwbFFlGz2o67M2hXa3p0tFFX+b1HVRf4jiHn75OgXW1kVoamAWbokLbds+Ptm6u
 2ozp8/4ncb+KVtEMcWAZd4uGtUssWrTsC/JnmYzRQs58GkqkNmF9YxT+M81O8NxGqVU3
 rGRA==
X-Gm-Message-State: AOJu0YzM9OD+9gKIlCAMcK+gNh+J/K1rVrecls3XdWogYLR7DXxbWXQi
 Mh9A53ugQvem5MFkOEKJFjCMMVIbO0cAQUu0WikQhg==
X-Google-Smtp-Source: AGHT+IFhkUk7hwuZBj1DfWvw9u/uuHuwMndz5d9znY3llK9wnIGdqvq+rr8a1ChNvFNmJfPNu9+hvvMdFTsRh4WQ2Zc=
X-Received: by 2002:a50:8714:0:b0:53d:f072:7b0a with SMTP id
 i20-20020a508714000000b0053df0727b0amr6661245edb.39.1699611673413; Fri, 10
 Nov 2023 02:21:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
 <4b040fc18cb0e563e92ce084ca18b89a050a8aaa.1699606819.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <4b040fc18cb0e563e92ce084ca18b89a050a8aaa.1699606819.git.manos.pitsidianakis@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Nov 2023 10:21:02 +0000
Message-ID: <CAFEAcA80sv6ewJ+LoROn-9ooEyLGQwiqYpL3=fqrK7gA0oZG-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add warn_unused_result attr to AUD_register_card
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "open list:OMAP" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 10 Nov 2023 at 09:16, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Ignoring the return value by accident is easy to miss as a bug. Such a
> bug was spotted by Coverity CID 1523899. Now, future instances of this
> type of bug will produce a warning when using GCC.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  audio/audio.h      | 2 +-
>  hw/arm/omap2.c     | 8 +++++++-
>  hw/input/tsc210x.c | 8 +++++++-
>  3 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/audio/audio.h b/audio/audio.h
> index fcc22307be..b78c75962e 100644
> --- a/audio/audio.h
> +++ b/audio/audio.h
> @@ -94,7 +94,7 @@ typedef struct QEMUAudioTimeStamp {
>  void AUD_vlog (const char *cap, const char *fmt, va_list ap) G_GNUC_PRINTF(2, 0);
>  void AUD_log (const char *cap, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
>
> -bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp);
> +bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp) QEMU_WARN_UNUSED_RESULT;
>  void AUD_remove_card (QEMUSoundCard *card);
>  CaptureVoiceOut *AUD_add_capture(
>      AudioState *s,
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index f170728e7e..59fc061120 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -614,7 +614,13 @@ static struct omap_eac_s *omap_eac_init(struct omap_target_agent_s *ta,
>          s->codec.card.name = g_strdup(current_machine->audiodev);
>          s->codec.card.state = audio_state_by_name(s->codec.card.name, &error_fatal);
>      }
> -    AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal);
> +    /*
> +     * We pass error_fatal so on error QEMU will exit(). But we check the
> +     * return value to make the warn_unused_result compiler warning go away.
> +     */
> +    if (!AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal)) {
> +        exit(1);
> +    }

This kind of thing is why Coverity's unused-result warning has a
lot of false positives. We shouldn't introduce extra code like
this to work around the fact that the tooling doesn't understand
our error-handling convention (i.e. error_fatal, and the way
that some functions report errors both via the return value and
also via the Error** argument).

thanks
-- PMM

