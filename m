Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C4D7DD0A7
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:37:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqnq-0000rC-7c; Tue, 31 Oct 2023 11:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxqnl-0000m4-0T
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:37:09 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxqnj-0003AO-F2
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:37:08 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9a58dbd5daeso893224566b.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698766626; x=1699371426; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J94TLVmxpl0XnRjKblCQ373JUKXqYHNbMQKHGSlFu3c=;
 b=TbovjNLebta0uJG+EHLa1Ndze5oDKC6v64hoWVbhJEVhpF9SUE5DtSckjNDAQv2Hck
 Veu5F1KS4ipjETO7f5vMt0JX5swkh8jztfKChYWREvSGIyruDoKfmV725QC2xs+pF2P+
 5ASJe5Rd+FHfUCWdFesLCUmS0Hnf3rBDzSNPkSG5vmHykZxKw3K6GYRW1deiaTIrqA0M
 CvUz0g+XgrkN+Nj/yAs9Wq0njtD1E2GyrMMvP+/AmriNXukGhQPWjM8x18moesaw785a
 /85imbKF01QqFuNg6TeNKcvIC235SYrAQvG+ye5tmw8Nzdm/KzL7yPJXAld7SRwgYwh9
 JFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766626; x=1699371426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J94TLVmxpl0XnRjKblCQ373JUKXqYHNbMQKHGSlFu3c=;
 b=tJnw2FGYH+mqow6nQAfgDji5+DbHYoso7Tq5q03/0GS5ACSI5kZiG/u9hiN8nkJtiL
 S52x8fAibZPeuZNP3iNJJcApJu6xoUhUYOVHkcNWUxxjSCqWTDoavYh3dZ78KjCiGt0f
 5GiBHZFtAXID/MB9nY2GVtvl5dcB381d2Gmc/zkndWXq9IYEUYOIlIveobdzKScKQJay
 8r+fVIjfE4UmWQ7zRWAJUoKPXefYaEInCHKgMKiNE7gp4rt5QgiPz2Ch8T/RoTsd8tOF
 G2aZGceJdqg+kVJxrOnj/nj+rGxYJsPCMj1TczLC7F2SSkHqGFo8oDmDBXJifkjacPZm
 y9Fg==
X-Gm-Message-State: AOJu0YzNLub9DCKVfQTKIeypBZNi4Wir2NAKnjZPN9FOCkrbGf94s/5o
 SfOPS3LCFnC+9r6PVOHOg8M5bmGBkcBps8DmWy+tng==
X-Google-Smtp-Source: AGHT+IGNFc8+3HLyZ82uAu0OXqWgI+jqDlbkn7G/uVkKA0csr/1Br3/+eo1eZzC/EL6wBlmGdOzguuYjzM7f+t/bTvA=
X-Received: by 2002:a17:907:318a:b0:9be:21dc:8a9a with SMTP id
 xe10-20020a170907318a00b009be21dc8a9amr10630988ejb.39.1698766625947; Tue, 31
 Oct 2023 08:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231030114802.3671871-1-peter.maydell@linaro.org>
 <20231030114802.3671871-6-peter.maydell@linaro.org>
 <9ea5c9b8-d740-4cec-9896-568babeca9aa@ilande.co.uk>
 <CAFEAcA9dJnp0CVOzVWV+Q-U4ji9c8=14ggztKGktCSsDDp_F0g@mail.gmail.com>
 <CAFEAcA_4wqP7G+gXnunJx85OTvUr-3kx6HGABGb6Kt3y=b_Nvw@mail.gmail.com>
 <59d6df3c-95ee-4ac4-9ac4-3f4ed49708fa@linaro.org>
In-Reply-To: <59d6df3c-95ee-4ac4-9ac4-3f4ed49708fa@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 15:36:54 +0000
Message-ID: <CAFEAcA9tipCFVfnR0Z9P8rvmtFdvzsn7dkz3FUAkTEuH+35d2g@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] hw/input/stellaris_input: Convert to qdev
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

On Tue, 31 Oct 2023 at 14:55, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 31/10/23 15:05, Peter Maydell wrote:
> > On Tue, 31 Oct 2023 at 13:55, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >>
> >> On Mon, 30 Oct 2023 at 20:38, Mark Cave-Ayland
> >> <mark.cave-ayland@ilande.co.uk> wrote:
> >>>
> >>> On 30/10/2023 11:48, Peter Maydell wrote:
> >>> Is it worth converting this to use DEFINE_TYPES() during the conversi=
on? I know Phil
> >>> has considered some automation to remove the type_init() boilerplate =
for the majority
> >>> of cases.
> >>
> >> I could, I guess. It seems a bit awkward that DEFINE_TYPES()
> >> wants you to pass it an array even when you only have one type,
> >> though, which is going to be a very common use case.
>
> For single type, there is no point beside enforcing a QOM style.
>
> I'll update docs/devel/qom.rst...

I do like that the macro means you're not writing an actual
function for the registration.

We could I guess have a DEFINE_TYPE() macro that was similar
to DEFINE_TYPES but emitted a function that called
type_register_static() instead of type_register_static_array().
Is that worth having? I'm not sure.

thanks
-- PMM

