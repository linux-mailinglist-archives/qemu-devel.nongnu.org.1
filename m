Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 891958177E7
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 17:50:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFGnn-0000vz-0J; Mon, 18 Dec 2023 11:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGnk-0000vQ-K9
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:49:08 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGni-0002yv-7S
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:49:08 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-553032f17cfso2526270a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 08:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702918144; x=1703522944; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pb/IYZRuRvxWme5LBdMifCbl4VpN4Dh2bV6K0o8fkrk=;
 b=h9czcw7cWn8Ka5kS8TAnOV5BCJXSxzxed/fLh2fCQMwi/pZZxSpe1DXeLspw9Uld4H
 jl60gIq09jZFV2TxLiRPB7yEwcNHLEwxhj3XHH0e6To7XAokticrYefC0cHcAuUFwTDq
 NBGg2YcvwoYsdY2xfur58Dn/a8CWQq5usUVElgdzXLoB/C0Ei7lwMFvVEt8RMWDd31WX
 dbEam+ybwi6eEVLXMKbvFDQS6uqb6wrcMuEKaNDo4TfD+u4JOnX8q4OwWX7HRg1yuA5b
 /yygogPXK14pOwGMEyFwAD/otPsd2EHhuiH+bVvWPxHCvueXIs0nmhehdWq6A8jYF4Fb
 SV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702918144; x=1703522944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pb/IYZRuRvxWme5LBdMifCbl4VpN4Dh2bV6K0o8fkrk=;
 b=iHXju36s0SqC/rcspohJy/CNaSbtElgFmbaMO1x088qugjqQ/2XJ1+WM4Bj7LFFsqa
 sxeQcUGmFM1fKTfQR7Sk0ntnhypE3IU3DsgnB8g/qE0eRc+qOTCsGW8b7GB7cuMH/5qZ
 mwVluMbeOhEmxl1mIhE3wQmJNAf8RNPBN3mF/E58c1RxityICNuV3pDO7GdjVBzzaIIS
 xc/r5iA13SlM6kr7fubplptHrH9R3CNasgDvSMp2M0ODt5RvFsq2yfseAJMRIs5xxMEN
 rwwoE/mZgSnjyFvQTvmHv87IfBaK/5yM55C+oH42ZOqjLDrwxWzan3zO51N4XvMe7FCN
 BQaw==
X-Gm-Message-State: AOJu0YzzZrBVWePxvU6WTZOsvX1DOtynw5slri2B+2ldZXuz5WrSGM/8
 jI3HZp4COGVzY1D40ULAscybZR0lsVBZccMT6y8sfw==
X-Google-Smtp-Source: AGHT+IGC0DHDVrEljYl5kCTy0XdEH/X06xVYxhuh1W/ZgcdBg++ckNokkzCYGI6pcU6EENN7eZ9Kz1qKRVS6CivKYTM=
X-Received: by 2002:a50:d51c:0:b0:553:4ec4:6980 with SMTP id
 u28-20020a50d51c000000b005534ec46980mr1036199edi.80.1702918143848; Mon, 18
 Dec 2023 08:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
 <20231204002619.1367044-12-sergey.kambalin@auriga.com>
In-Reply-To: <20231204002619.1367044-12-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 16:48:52 +0000
Message-ID: <CAFEAcA9V+U_hQ+U_8MqQfG0jEeupBmMFvEAOBygX5haGJ+tH5Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/45] Introduce Raspberry PI 4 machine
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 4 Dec 2023 at 00:27, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

