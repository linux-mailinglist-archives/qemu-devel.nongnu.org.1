Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998D82CCCE
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 14:27:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOe2u-0000t6-Te; Sat, 13 Jan 2024 08:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOe2p-0000mO-Sy
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 08:27:28 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOe2n-0003HY-Pr
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 08:27:27 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5534dcfdd61so12944256a12.0
 for <qemu-devel@nongnu.org>; Sat, 13 Jan 2024 05:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705152444; x=1705757244; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhOpWHYsUYOjsfTNAJI1YLA+pSFeaSMgSNSIrzcL3OE=;
 b=wEKCfkMDpkfoNvo1KBEL+VRd5YEJiCED/fIRZwFpxCgg8ylLzb4iC1iH0CYHXtdVQu
 b3CLugdoZfq0TTl/FMSw/shH63sHZxLuuqQ9L2gnxePNKTzQjU127aw/9a1Rz+1iHCj9
 fg2OWrU7G35CT0hYW9ZM+sHb0USvo41dBStIOmEgpQ9JLBrJgUyf7TB2iPCk7vKycywl
 q+5encRT2A1e5QPlAGUsqv3kNsLPOIPU05w0PZjyveEUXh2CDRG8Y753lTqTkg224KsO
 FWES+Kfd6l+eazMDbVOiDWXkixzakw/SeQ2HDi+p4QOkSHVZ2hAdy/VowrfAmwKS//op
 QKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705152444; x=1705757244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhOpWHYsUYOjsfTNAJI1YLA+pSFeaSMgSNSIrzcL3OE=;
 b=ve7Z/G9u9qpLLg4PBVU1lputVusQigFOTqDsmn5uImxIto/snS87jBZyHF/jtJByzb
 0ZIgZv1n21OTi2PJXSgnERC2Z2JHKXC9J0dDVsKltpxsCP+gjtzspas64gCZAJ3qoER6
 mQeas1ah//+TB9yuDkA/CqnxyjnoT8GJ5Kyaj1bWtt9ov3hrsWecDKRTs3LZjpRU/new
 3/i61QpvbAomMOLD5/cFHfTEL9U66Ter1+ipG0+bdbu4EzsCOmUlPL1gIETucPq9TYXs
 0iTvdWe4pi+5JWecN+DZAiyukKPM3Ti2EaG1HCQjCJat+8RPCkuYJGf9t4pLJP5Eoskt
 qv5w==
X-Gm-Message-State: AOJu0YxEPHZDgi+BOnIQUMdfdoOxK2FyUbeudTS5lVbqqOszMKIkLxPi
 Hn3XdmU+gAXjjwVz4cWOpR8J90oQXxZ+ju611S8dWtg43qG90w==
X-Google-Smtp-Source: AGHT+IETav6rswDniDEM2jM13XalATxvLUlGh0idwcM0mH/cyRR3+57/HdLEZuqzCJncL6Jc79vE4BVUvW2HRBdz5+4=
X-Received: by 2002:a50:8a8a:0:b0:557:25a1:27ff with SMTP id
 j10-20020a508a8a000000b0055725a127ffmr3000588edj.38.1705152444271; Sat, 13
 Jan 2024 05:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20240110195329.3995-1-philmd@linaro.org>
 <20240110195329.3995-4-philmd@linaro.org>
In-Reply-To: <20240110195329.3995-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Jan 2024 13:26:51 +0000
Message-ID: <CAFEAcA9K1sH3ZObCtQzOe2AYiNKbrMLRoEbTB-f=N1NsCAnW-Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] hw/arm/armv7m: Move code setting
 'start-powered-off' property around
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Wed, 10 Jan 2024 at 19:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Reorganize a bit by first setting properties which are not
> dependent of CPU features (and can not fail).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

