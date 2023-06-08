Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B487282FB
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:47:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Guc-0007Fs-V5; Thu, 08 Jun 2023 10:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GuV-0007EV-QR
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:46:47 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GuU-0000Z4-52
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:46:47 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4effb818c37so841295e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686235604; x=1688827604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YymtRz8dt3CDxGiat6ktH2WYKwEJl3Y2thtAxKI/9A=;
 b=ZzGBtAzvcI+0P6Nz/U4i1eWdLurG+/ILYaUwISU6+o+TlGSX+1GhMngkVL+E3fBwQl
 03aGbzAgUfQjIT3kIDoBnrKfbe9ry4NHd+oesOmgxbWyvJ0RImtK4Jn61uB98ViYrwBf
 O0boEH3o2nPgktiNjhldkmmRuCaY9cKOYL82eTV2+74ckusiTM/jRL7qMbRL4SvRk6Fs
 uS95Bi0LGyi0YrfQXHC01nuNUdvUtAjbh1RxfYhiQXVu0WtzdJfSUTrxbphRd5W8a6DN
 AOwKzcRSncTFGVNdZR1jGuvmXO4FlMndjkD6rErRSDXbve/LgxnOfTagIkNyR9v6X/eI
 hSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686235604; x=1688827604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YymtRz8dt3CDxGiat6ktH2WYKwEJl3Y2thtAxKI/9A=;
 b=MEFw7loCcSczO1/DT8nbwo0NdcYscu+BFhHATnGiDuRBbXsozbz17tL+OLBIAbBuV6
 aHLTMxhyMs/QHSe0DRxLyBkvtscrkTAdXAidDKf6ldVRfJ7qijBxttCfAPZ83Eg09tb4
 WgV+lwdOKbLf3oiz4WO4nF1Sv7BhkdGU69DC2uFayCcZ0w98V9if0SEk8c3pG8ntqkdW
 hbhZ0UicAI5OKtaZIJaPV+HZ+j2/fNRnHAyfzZRBjOoZTy1V1owyRhGuk9t0VJ9+clLV
 BwGIdy/Rtp2Tz5Yxnz91pbQD9zPguTb8lNAhD0yegO88J5TmJtr39j2wySnSxc3lTyDP
 TOgg==
X-Gm-Message-State: AC+VfDzRPQS4fL7gUsoPbFujLZY3TUYKsYUJGkCb4WCTEzlmzD8ND6ZG
 FTSuVudVRw2Ly1K+W4x8vXkISuUm5y+pRQBVUULp0A==
X-Google-Smtp-Source: ACHHUZ52mjictis6fjD9ZEHlQjTfaLelshQo0UcpESTuvok8iIQk28GYLi19kzNEAf9TRzXYivevWmqN3biRGfTASpg=
X-Received: by 2002:ac2:538a:0:b0:4ec:8816:f4fc with SMTP id
 g10-20020ac2538a000000b004ec8816f4fcmr2998436lfh.6.1686235604234; Thu, 08 Jun
 2023 07:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-8-philmd@linaro.org>
In-Reply-To: <20230531203559.29140-8-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:46:33 +0100
Message-ID: <CAFEAcA928VCeRVz7JQFGefxuyDn3LZC25zuLSJfYUg-7PkgyXw@mail.gmail.com>
Subject: Re: [PATCH 07/15] hw/timer/arm_timer: Extract arm_timer_reset()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

On Wed, 31 May 2023 at 21:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Extract arm_timer_reset() before converting this model to QOM/QDev
> in few commits. This will become our DeviceReset handler.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/timer/arm_timer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
> index 2cd8c99b4e..54318d0a57 100644
> --- a/hw/timer/arm_timer.c
> +++ b/hw/timer/arm_timer.c
> @@ -172,13 +172,18 @@ static const VMStateDescription vmstate_arm_timer =
=3D {
>      }
>  };
>
> +static void arm_timer_reset(ArmTimerState *s)
> +{
> +    s->control =3D TIMER_CTRL_IE;
> +}

Reset also should zero s->limit and s->int_level.
(in arm_timer_init() this was implicit in the g_new0()).)

thanks
-- PMM

