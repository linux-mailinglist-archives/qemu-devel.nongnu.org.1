Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD08571650C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:50:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40ez-0002z0-Ia; Tue, 30 May 2023 10:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q40eu-0002gk-BP
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:12 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q40es-0007rC-Jk
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:12 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f4f3ac389eso3696735e87.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685458146; x=1688050146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hx4CMfjN2gDdDdHPeJO2EwSEyrOhNR95CcofImCZWfA=;
 b=OSOBabiDBxS8zpoOXvjPNSq3Q+ZvyKm43PzxoZ9KuLqtLKrDjTHk9d9QdlWt6Ug5NB
 fjIzNsuLJHYcU/58P3cknSTVXJt3HcvKUp3Wrt9PNu86wpLt56HTplgGac8A+oBJHd9W
 m3BI/2MGc0YEbvfM1GA44wPndIv8TwAY1XUPr5Nz0qZEtGkoUphcjvZkgSa2bEdVyaZe
 Lu52Ab5ZZ10woeqriJMO8OfFj4n2yE5MvAxUk267b5gNv9pIizCDKKaTuHtAmHwBkDvk
 prFB7n7PkCEyiV27qA1TimN1c8Kh6Ve2xZkoTJxwfc2DyVuqHq8Oq66X1ZCzDqiPigiY
 3rQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685458146; x=1688050146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hx4CMfjN2gDdDdHPeJO2EwSEyrOhNR95CcofImCZWfA=;
 b=dH0f9adApVvKHI0Pc+kf1cAN+80uYE/xycXZlImfQaer/7KEWUe8jFMlsv3DH2/Gv9
 yH2EQKQPw7mcWTDybBEMpHbFYXcP39RqVUiznSzZKdBvO4nCCjBjCcFGjDi/rtUXj4Xy
 TOMe508ptwaluxhxVZ+KidHYsT0DS5j+o3xo8lboBxYz2rPrH0PG2rJSlwlghz8nWF3c
 b6IsE9UCdQrlGQ5gykRMhZGhmjP5SkttcalE2F6DqQsxXLpLIVeAdlpd2XpesTvKHa5p
 ZDD4i3EUH0e17UGwjsTUUA6gpafmROZaZ55L8oi0cxH3ASaPOR0F4WVCTQeVnB/kx1I9
 ysYw==
X-Gm-Message-State: AC+VfDwsvpk45qPRTWvOiVG2NHwKHO1dhvzypIqSanuvnpFz2o5PBmem
 LsZdsnRgctjfvqBPt6VVmN2SWS+zxbGYvftaGdO23w==
X-Google-Smtp-Source: ACHHUZ5mX2JNLMoNutr3vYZPtZF2OaigU8atpIejHdAr3pWj46vOvI1ZOnuV2IhS3Z4zRKtXg6h22xL043k+UzgJ57g=
X-Received: by 2002:ac2:5491:0:b0:4f2:579d:6867 with SMTP id
 t17-20020ac25491000000b004f2579d6867mr855280lfk.20.1685458146507; Tue, 30 May
 2023 07:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-3-richard.henderson@linaro.org>
 <CAFEAcA8E_wbiL=xxc=qzfbhBjTsGVxpMGYex_Ezsn_=47DJP3w@mail.gmail.com>
 <5192c74b-38fb-7f2e-7b27-58d210c1b087@linaro.org>
 <CAFEAcA8tPuFMz8BZ5P-SJS42q8E_TZ1_5DJL-0kOvzeT-Fymmw@mail.gmail.com>
 <a7ba5e1c-ca59-b114-229a-07930f6ba683@linaro.org>
In-Reply-To: <a7ba5e1c-ca59-b114-229a-07930f6ba683@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 15:48:55 +0100
Message-ID: <CAFEAcA_BS4b1MR=7zwVXB+eTXcVc2QhvzcvsoQn9mZ-xeps41w@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] accel/tcg: Fix check for page writeability in
 load_atomic16_or_exit
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Tue, 30 May 2023 at 15:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/30/23 07:06, Peter Maydell wrote:
> >> This is about falling through to the cmpxchg below: if !PAGE_WRITE_ORG, then the page is
> >> really not writable, we will SIGSEGV, and handle_sigsegv_accerr_write will kill the process.
> >
> > Right, but if !PAGE_WRITE_ORG then that implies also !PAGE_WRITE,
> > so we do that even without this change ?
>
> But !PAGE_WRITE does not imply !PAGE_WRITE_ORG.

Hmm. In what situation do we mark a page writeable when the
guest didn't ask for it to be writeable ?

-- PMM

