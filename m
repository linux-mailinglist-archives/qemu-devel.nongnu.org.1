Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDC97E279D
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:50:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00jI-0004Jv-OP; Mon, 06 Nov 2023 09:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r00jA-0003np-FU
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:20 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r00j6-0000r6-CO
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:20 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5446c9f3a77so2816029a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699281435; x=1699886235; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3rsMhV/YnelkiihUeLr8dh8pLDdvO1fBGxovLhiCmU=;
 b=MKhA+pHljxelbWGX4pyGDmP8vbrvdcuOAvHjdrB04FOw4Mzk+XP81qEEDZjvStI7sb
 +8vZRzMzVBJmovDbQFI1R/rXlHJvSJOdhp/M53v+KjD8Qb/m/FEwlvx5VJru9MdD1RP9
 qYO4oUhBKMkRey4Jyx3JDqMqIlmQUbZpoXwmjgQFi5UCPWeN/MVJPUwDg0l2UyEo/QwA
 WVlpPDtOo1s2f2FxuP+sEOPPO3jdkMxJ6D+t53MzCNh39C7GqxP8tiHhzVpjuSUWsDXp
 Fx2VXQX2pQbFmgmIMKeQbXXkO7rqkQDMg+Aqo5TGY9t2NbrkfZft8HocoolBTIhFwMms
 u1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699281435; x=1699886235;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G3rsMhV/YnelkiihUeLr8dh8pLDdvO1fBGxovLhiCmU=;
 b=mK6qDI3x1DWdqCAZImzgMYugV7k4iNqCtoVGrIXU+XnMCJBVUT6YnlcO/QFUb913EL
 EJLYrmk3DG+c88aF0Vh7qrSNMjN+0O4e7WlrQNqken1CqqZjYMUUHpybaiZMF6XTFxbC
 cIjtnrUp0udDQZwJkGZIeQ3pw9+cyRp5dvWaNXMpW3/79GIz/80V6DriOEzLyzqdGLi6
 fwxfixFLwe6m7i/aGJ86ikaPrzPhEKycW7JrI5gvRToKogRqkajkK5u0c9jQZYxKJaKf
 Fv/UH0QuYlS/fclh6gMDk96zhqbAdbQDlk44vw4Zg4SY1TYJI9TSpln3//A1Pa4ygegS
 yXoQ==
X-Gm-Message-State: AOJu0YyDmYxTBtMra0ZfHWp1RYevJkVesHOQwrFTfOp1OyezgK2jdKJd
 4txt2k89gAB5biPkAlhFAasHLtOXirntIy1u/sYjcg==
X-Google-Smtp-Source: AGHT+IHHfRYX1YGaYwMBIp2L2XXA0OvayKj/EpKiQ8n2hNYex+z24Q/7wbq+hbCd/V2ZGewtWaCwNFY2Hvw8HULdwU8=
X-Received: by 2002:a05:6402:14cf:b0:543:8891:e142 with SMTP id
 f15-20020a05640214cf00b005438891e142mr14815485edx.11.1699281434764; Mon, 06
 Nov 2023 06:37:14 -0800 (PST)
MIME-Version: 1.0
References: <1353832942.8123338.1699279035562.JavaMail.zimbra@enst.fr>
In-Reply-To: <1353832942.8123338.1699279035562.JavaMail.zimbra@enst.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2023 14:37:03 +0000
Message-ID: <CAFEAcA_XpfjUvM8Gb+NE6V_qreG3pEbNsUzKmBsKfnGZnsJObg@mail.gmail.com>
Subject: Re: Adding support of ARM board B-L475E-IOT01A using STM32L475 SoC
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 6 Nov 2023 at 13:57, In=C3=A8s Varhol <ines.varhol@telecom-paris.fr=
> wrote:
>
> Hello,
>
> Along with my fellow student Arnaud Minier, we're looking to implement su=
pport for a new ARM board for a university project.
>
> As of now we've have implemented a minimal version for the machine and th=
e SoC without any syscfg, timers or usart implementation.
> We have looked at the relevant informations about the procedure to submit=
 a patch, however we aren't sure if we should submit a patch now already,
> as a way to get acquainted with the procedure and expectations, or if we =
should rather implement more peripherals and submit the patch all at once.

You might as well send an RFC now if you have a minimal
working subset of devices. That will help you get used to the
process. If you haven't read
https://www.qemu.org/docs/master/devel/submitting-a-patch.html
that is our description of how it works.

> For further details about project, the end-goal is to emulate a maximum o=
f peripherals and be able to display an emulated LED matrix driven by the Q=
EMU-emulated board.
>
> How we're proceding for now is replicating code designed for the stm32f40=
5 SoC and other specific stm32f4xx code and adapting it for the stm32l475 S=
oC (both are Cortex-M4 SoC).
> Is it alright if the patch commits reflect this copy-paste then increment=
aly change details procedure ?

Generally speaking, no. The patch series as submitted should
be a sequence of self-contained changes which all do one
thing (eg "add SoC device framework", "add UART model";
"add new board model", etc). They shouldn't have extra
"fix this bug" or "change this thing" patches on top that
fix problems in earlier patches.

thanks
-- PMM

