Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 853538056E9
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 15:12:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAW8o-0004e4-W4; Tue, 05 Dec 2023 09:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rAW8m-0004dr-H2
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:11:12 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rAW8j-0007Ex-Vz
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:11:12 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54c67b0da54so5356220a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 06:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701785468; x=1702390268; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcq2iAXrHZHb0//lmBNVhI9C7/qB4pPUsjtA0Xu+Qaw=;
 b=pfKuk7u4uEiiHM/iye92OF/uHpKDQ94nmzogDGp8nH/teg7uLk29NDy3yl5WJ8VQQV
 axxpWesdPn1WZeC+cO73Grfzv23BYUyqoYUNxM/HbfeUpacrP0nOmzLq+tLNNscT0k6d
 /mVZfWSumYV41VcLVQiuJ4l1F6FrVutEcgorooBcWC43G8Ld46DGdewQsdcmHRpRPVbI
 okQw++ChKsqeqYy7U/vwnoidCt4cRJVssXsJaGvznBnQTEgRDm6ZXe7im+gFWdGQdXdv
 U2S1nUOrB86DSVgDqstBE6UFcLcPt+d/2z51fOtCaY5KpWCf7t4Sdl9akWCJ3FeFZ6Po
 vzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701785468; x=1702390268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fcq2iAXrHZHb0//lmBNVhI9C7/qB4pPUsjtA0Xu+Qaw=;
 b=YR+ILCnSz93Ln+LYrdgSy/Bkirms+Ch7AUX9+f8MNzI+bE0wTEbgjXap3IgHCmiNKd
 BokrV9w7jwkqgugIJoEbVTTt6bnJ8M4detWq5mE0iXqjC9jleAVkynBaO2SnDXpGM0CQ
 XpdoVhK/AcMxMv31A/MshvI9IlrJgC3V4GLMZlBLHijvVrYsAcZdIgu5Pb90fy+qCYrv
 OYcb6Jc19pFWM1hQhUJbN4n/INd/MvHHeYpJ9MG7EgNp7e2CnxM8sPRqkZKOBl2f+M99
 OjzJvVaH+9sJiAqcVX4Jt4AHB/57MwN6K3FeVZssr5lzD5XuAC9DIjqeXZrHs2C8UCna
 772Q==
X-Gm-Message-State: AOJu0YzXNyEQozb5z9ceRm3QDg5zsB/XNE+jUL7w3oVKJaSSl+yaQJot
 wVdsw2EcKXG9K0JpbwFaVn1EjxI56CmthAvjm9PJYQ==
X-Google-Smtp-Source: AGHT+IHlFI2sBlKhKlbcxPffTEHCfrzvkpf/qngOdRAvESxA0xUHntYfOVxkkhGFaeKjg6i1ZOrklClwUHep+2IIqhw=
X-Received: by 2002:a50:d684:0:b0:54c:4837:81fb with SMTP id
 r4-20020a50d684000000b0054c483781fbmr4409021edi.76.1701785468054; Tue, 05 Dec
 2023 06:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20231205121420.3287637-1-alex.bennee@linaro.org>
In-Reply-To: <20231205121420.3287637-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Dec 2023 14:10:56 +0000
Message-ID: <CAFEAcA85p9C=D8QZ9Ew8xMSVZgtVAOgQ0h7xBkPAKMZFci5uPQ@mail.gmail.com>
Subject: Re: [RFC PATCH] replay: stop us hanging in rr_wait_io_event
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 5 Dec 2023 at 12:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> A lot of the hang I see are when we end up spinning in
> rr_wait_io_event for an event that will never come in playback. As a
> new check functions which can see if we are in PLAY mode and kick us
> us the wait function so the event can be processed.
>
> This fixes most of the failures in replay_kernel.py
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  include/sysemu/replay.h      |  5 +++++
>  accel/tcg/tcg-accel-ops-rr.c |  2 +-
>  replay/replay.c              | 24 ++++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index 08aae5869f..83995ae4bd 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -70,6 +70,11 @@ int replay_get_instructions(void);
>  /*! Updates instructions counter in replay mode. */
>  void replay_account_executed_instructions(void);
>
> +/**
> + * replay_can_wait: check if we should pause for wait-io
> + */
> +bool replay_can_wait(void);
> +
>  /* Processing clocks and other time sources */
>
>  /*! Save the specified clock */
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 611932f3c3..825e35b3dc 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -109,7 +109,7 @@ static void rr_wait_io_event(void)
>  {
>      CPUState *cpu;
>
> -    while (all_cpu_threads_idle()) {
> +    while (all_cpu_threads_idle() && replay_can_wait()) {
>          rr_stop_kick_timer();
>          qemu_cond_wait_iothread(first_cpu->halt_cond);
>      }
> diff --git a/replay/replay.c b/replay/replay.c
> index 0f7d766efe..e71cdbf819 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -338,6 +338,30 @@ void replay_start(void)
>      replay_enable_events();
>  }
>
> +/*
> + * For none/record the answer is yes.
> + */
> +bool replay_can_wait(void)
> +{
> +    if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
> +        /*
> +         * For playback we shouldn't ever be at a point we wait. If

This comment sounds like "this can't happen, but it does for
some reason we don't understand" ... Is there some bug somewhere
that we're papering over here ?

thanks
-- PMM

