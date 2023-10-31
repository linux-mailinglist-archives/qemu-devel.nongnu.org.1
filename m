Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 386047DD0C9
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:44:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxquO-0008Dq-GL; Tue, 31 Oct 2023 11:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxqu5-00081g-Mz
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:43:49 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxqtt-0004E0-53
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:43:41 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53db360294fso9964911a12.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698767007; x=1699371807; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oe7J9q5uDTSryL7saiupMFIi1MTfsnCHy28PzXMcyxw=;
 b=KZyZ9jjP9mQlf5CnidH2w5NYnX0o/c25sShhTp7e/3ru4MN+yFJtPhtHcWnwrWXhwf
 OWpHkr152AhMbomJRh3pw8v1Dg9HG5R2MH0BZfCW2Y9DXyPQ+39leSEz7gQgNgo1nRi1
 ELjvieXuYu0zcezRLoyAvnKDUpTHexf5nnrC1HGFKagPRMcv4qPsE+npn62Iyns3nq3/
 3Fbqof8XGv/mmpF93TwDlE0heOMDVbyXEx4w8hWGc2ZpJG/eM4WVF+56ZMgrk0UouFug
 c4DqiJ/J5fGRepU0igvICvK8TffhUY/+mOfsKu/LxamJz/R3hcKYv1y7zTuVGvVNTG+d
 90bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698767007; x=1699371807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oe7J9q5uDTSryL7saiupMFIi1MTfsnCHy28PzXMcyxw=;
 b=btSblNMka0sdkktslCP2IuMIiCX43lm8/jT0JFXp77UpfyppkdMMTwqx4blQx8Js2K
 x+HwRzp6YgZwdbDg82s73zPm5eQF+Mos5e0datVMTifShPUnqCnR/xNl1yqOCi+q0zOA
 ZqbgdCZEWrGh+OUhsokyXgtdce1HHoCGHpum1WRXhjGviz5tKJSjCl5GoYr6Xh0patpK
 L1kOxoSYgEkEo5Jh1Wgo6fhxVAqz0VOeTHo+h7SfS03OZPQtKFEIGL1jWtEweBK2x6WC
 vb56Tp8OlIV7eEvFcBvpo+wnqijuRx2M1VPYMctNEpiNzv8zstRp2EX1nUBFwcyDZ/CH
 VFUw==
X-Gm-Message-State: AOJu0YxdIUDK+PnaS5A8LvNDmEPSw1ptF1lZ4kOFpwtO1/VFVH0juMs6
 b8o5OMCYd+Hmp4uKKcC133Tk2FdTnyQcUQtbXeh90/UwnOVS/3PP
X-Google-Smtp-Source: AGHT+IGIeZATh4anzIkz5pqx8yzhyLGvnwffh+2srG8EZfLIMMEOx6QPvWA6IB0w/iTTpjEW9N98LlkzrlZ+6Uv68xg=
X-Received: by 2002:aa7:c2cb:0:b0:53d:fe98:fd48 with SMTP id
 m11-20020aa7c2cb000000b0053dfe98fd48mr10409901edp.3.1698767007480; Tue, 31
 Oct 2023 08:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230927151205.70930-1-peter.maydell@linaro.org>
 <20230927151205.70930-7-peter.maydell@linaro.org>
 <9994c0ae-57af-d3b3-520d-7cbbee543778@linaro.org>
In-Reply-To: <9994c0ae-57af-d3b3-520d-7cbbee543778@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 15:43:16 +0000
Message-ID: <CAFEAcA8mQ_r+RJZsDr42Vi88rMT=cRtEVNziKNCkB1AsZXujtg@mail.gmail.com>
Subject: Re: [PATCH 6/8] docs/specs/virt-ctlr: Convert to rST
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 31 Oct 2023 at 15:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 27/9/23 17:12, Peter Maydell wrote:
> > Convert docs/specs/virt-ctlr.txt to rST format.
> >
> > I added the name of the device to give readers a bit more idea
> > of which device we're actually documenting here.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   docs/specs/index.rst                        |  1 +
> >   docs/specs/{virt-ctlr.txt =3D> virt-ctlr.rst} | 12 +++++-------
> >   2 files changed, 6 insertions(+), 7 deletions(-)
> >   rename docs/specs/{virt-ctlr.txt =3D> virt-ctlr.rst} (70%)
>
>
> $ ./scripts/get_maintainer.pl -f docs/specs/virt-ctlr.txt
> get_maintainer.pl: No maintainers found, printing recent contributors.
> get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
>
> $ ./scripts/get_maintainer.pl -f hw/misc/virt_ctrl.c
> Laurent Vivier <laurent@vivier.eu> (maintainer:virt)
> qemu-devel@nongnu.org (open list:All patches CC here)
>
> Cc'ing Laurent.

That raises the question, is it intentional that the doc
is virt-ctlr but the source file is virt-ctrl ? Should we
rename one of them (looks like the doc, so easy enough to
do as part of this patch)?

thanks
-- PMM

