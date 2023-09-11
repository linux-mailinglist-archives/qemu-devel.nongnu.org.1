Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6235879A8AE
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 16:38:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfi1y-0002EY-P5; Mon, 11 Sep 2023 10:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfi1x-0002EI-9X
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:36:49 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfi1u-00055p-Ur
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:36:49 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52e828ad46bso5926228a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694443005; x=1695047805; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P56pw5Lv6S/ZtHI7icBsS2sYRJaov5ujkufLSu6W+0k=;
 b=nZ33EJ/fCS+N649F7+UBNTJYGQVDOVozat2V98kPZlSGVtzCM3rek2WHjPnqCPEbAs
 AmbPoEz3yyU1B7T+brw8VsiGUeVeZJNm/tArK8Cv2BT/DUO18i0SJkIW2j7FDmJZFhqA
 +lD/d3BrzBuNtSn3QG1VLaFvp4Q/MpoNYCqKGpOWhDM10gP8KyDs3j1VuJrFiVUnqcZG
 vDeXfHucGgghPVy/8YIir6g3CLfm2MvbzwVvZtLLiQNUp3e4OBd8Q7w+UI4x8G6hnBtW
 tnT70KalFOkqthDinDgB8CAcm8+Xl363hrObvKmczniNzgPj8UIAXLvlBNXm+VezL8v9
 3z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694443005; x=1695047805;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P56pw5Lv6S/ZtHI7icBsS2sYRJaov5ujkufLSu6W+0k=;
 b=riVJkFrwK6OZiyNgu1LEkP5Ip14JPyUuYyDos3xFBD+CWCNBC+z0dILQZMCuKLGsQ4
 yk4zXKDRNUUEbJma7Rwe7ysuGR5weHt4RUH/KD17aqnF5/pgKG+uAFfcgrqrYYpyid1I
 vGNK9pDvIpmRtY4rn9uHd0Hyig+r1ZUG+bIUOrKtYJUdodE3yxAjdZdk4HzSs5/PF10o
 303nSffSgocEYGyS2Wx++IKZRzCYGeeJnkmgGTmnuLAMzTSOqi1cU0U2/FmGrnC6TDWz
 UxVflMcbHRnTQUNkjFaCvISDMJxpozTnTvSQVRoh14MAZrpfPh0M+4suy0ClxvLZYFhF
 AYWw==
X-Gm-Message-State: AOJu0YwmkAZbzCWe76Ji0K7vIPZsMuOj2HXXsQB+eXIzBPG0+BB5YLpW
 gziQFfBjKemUMXx5DklICR6t9D9iFGnLDVT+A0C89iAOOMW9Bxml
X-Google-Smtp-Source: AGHT+IG7qNjYXrk7YJfrF4zCYbB7Y0R9sNw34+Q94CDNTLq3t0LmL6KsCwJmg9cnh8SyoODRpjCdiUzHKYl2Tqsk7PM=
X-Received: by 2002:aa7:da4d:0:b0:523:4acb:7f41 with SMTP id
 w13-20020aa7da4d000000b005234acb7f41mr7693001eds.14.1694443004992; Mon, 11
 Sep 2023 07:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230911135340.1139553-1-peter.maydell@linaro.org>
 <20230911135340.1139553-6-peter.maydell@linaro.org>
In-Reply-To: <20230911135340.1139553-6-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 15:36:34 +0100
Message-ID: <CAFEAcA_O7T40AXVDd9H1==prySSEDv+0dZauwLDFGaxPTriA2Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] target/arm: Update AArch64 ID register field
 definitions
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 11 Sept 2023 at 14:53, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Update our AArch64 ID register field definitions from the 2023-06
> system register XML release:
>  https://developer.arm.com/documentation/ddi0601/2023-06/
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is intended to allow updating the set of ID register
> fields we expose for user-only mode, so I have only
> updated the AArch64 ID registers, not AArch32.
> ---
>  target/arm/cpu.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

> @@ -2299,9 +2317,13 @@ FIELD(ID_AA64ZFR0, F32MM, 52, 4)
>  FIELD(ID_AA64ZFR0, F64MM, 56, 4)

I missed one line (failed to save editor buffer...):

+FIELD(ID_AA64ZFR0, B16B16, 24, 4)

-- PMM

