Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2797561AE
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 13:37:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLMWg-0007xy-SI; Mon, 17 Jul 2023 07:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLMWe-0007xe-OI
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:36:24 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLMWd-0007to-3Q
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:36:24 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4fbf09a9139so6775815e87.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 04:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689593781; x=1692185781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNjhLKq3hvSe6746uiaMDGY+6D3Uk4qonECA/HniVvg=;
 b=EUpH4lYJjdDWhE4j05gBTbq98izUMmdLpAWhFZv3GtLyduxxFiXdUjjxVOsy+R6v19
 m8jAhObLj3iQCm9YoF4KgMYTK+C0NWYNZ2UcYCxsTCguaNcCeP+xlzECuNrlpHAWAzKt
 Nczwr7GUGr88ApWcfMRtEDNf9sfdLMN/VL51E6DqRrxqk5SIT7sacZZ2gDXkPcrN/4Ez
 qsstVHh6hVrlVr66+FYuNN4cT8mByegsh9gJTS3CmkL1lRJesrgvgud2RShjUoj9+Mqh
 XRBVaqY80jA18QkcZsr1Feztztf1WEGJlJiGHwu8noT6ZYYslg8iaEpeKLpT8oWxwS4/
 Pxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689593781; x=1692185781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNjhLKq3hvSe6746uiaMDGY+6D3Uk4qonECA/HniVvg=;
 b=fR9d4E+wggTGY/uanu+uk9Jr3q+GE6ZzUXW5n5ZGcOEK1Ypgpz+soJQFGh6c0RvP+N
 u9jPDYr6mSiGVFGeQDflZA76uTNJHDA2GLGW1JqHUElxA35m9Z3SgDd2zElVWH+Oko9U
 CnaAGzLha93K5khT5g6kqCqwUV0wO9FtsIMRMfGGHTBns4q3V/83DZtBqQ1DH5x3ru/M
 wnGUSOJuKL5Do9Pe2foxSQmEjzXXTKrI8M0bnglWf6HcBrm5I4pWddgKNdo21XERT0+O
 OQTP6Cgj+rgWO4P9cEZW48quCFJFm8jQcVhoRHzNO9xbu4z4X+JdGjpTRLjRvh15Z28e
 mp8Q==
X-Gm-Message-State: ABy/qLaJyKsYO0iPnU7FgssS2bJfwlPgAWBdibM+XdOyRPrgoC6H+/EY
 E8IudhBBuDsdevJW5Lgc7ZmgAF9hAtkBdzjdzQzV6A==
X-Google-Smtp-Source: APBJJlFYVrzZ0mNT+15uA3nmfqxpWN4gPEvLewgsMocGO7Yejv1vLMVt/Wh1XgQJmZDcuor2Zh0YxcNwUGPiIt4U2/U=
X-Received: by 2002:ac2:4553:0:b0:4f8:cd67:88e6 with SMTP id
 j19-20020ac24553000000b004f8cd6788e6mr7457313lfm.44.1689593780909; Mon, 17
 Jul 2023 04:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230717103544.637453-1-peter.maydell@linaro.org>
 <c7506bc9-0b59-bdaf-de3f-8bfe7d81c580@linaro.org>
 <46891cc0-6f71-b452-0e87-58953aa64826@linaro.org>
In-Reply-To: <46891cc0-6f71-b452-0e87-58953aa64826@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2023 12:36:10 +0100
Message-ID: <CAFEAcA80UCBw+1biKuM-HtyT=MrxC7Tv-q3ZKWcd_dvsafgPVw@mail.gmail.com>
Subject: Re: [PATCH v2] target/sparc: Handle FPRS correctly on big-endian hosts
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Mon, 17 Jul 2023 at 12:32, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 17/7/23 13:30, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 17/7/23 12:35, Peter Maydell wrote:
> >> In CPUSparcState we define the fprs field as uint64_t.  However we
> >> then refer to it in translate.c via a TCGv_i32 which we set up with
> >> tcg_global_mem_new_ptr().  This means that on a big-endian host when
> >> the guest does something to writo te the FPRS register this value
>
> (typo around "write")

Yes, should be "write to" but somehow I managed to transpose
the final letters of the two words...

-- PMM

