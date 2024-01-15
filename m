Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C0A82DB89
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:43:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPOBK-0005Zk-Kc; Mon, 15 Jan 2024 09:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOBI-0005Vd-Mz
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:43:16 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOBG-000596-T9
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:43:16 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e72e3d435so8463386e87.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705329792; x=1705934592; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nLpdw6hlwYu1su834MYR8Ydtrr0Kp5o/313w+8EGdkg=;
 b=nyQCRaJg8EzYePGKRfmmDmzB2fuEIfJTa+tD/uULlB9M60bZgSheUK2B9cX1SOfkm6
 S4uSglHRhkd4kFSmaOSaea4SdzMkRTPKolmUxVCpNO1pNy51CIwnjuAn/EZLVZ6DJUw6
 fkPjLZmLjhplU5tcSMYvM9UFN8YJaCvH3dzS8akHuCPAsRw0bbBv3BP8dLBVTRrRKby/
 HIiuji/6ywDw82hoFA3ej2kJDoRa6NWt5Cxu7Sv5DvABtakc5T+7cJNiyI0EjBls7gk6
 pq6Kz04eu1kcHN9mvPZiTcjaR8SCRWMchjgC+7YD/CwOlUsmqAe++fKznRehavnJ6S50
 w2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705329792; x=1705934592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nLpdw6hlwYu1su834MYR8Ydtrr0Kp5o/313w+8EGdkg=;
 b=n4s1F67NMalqJMgQE6tfgqZfSQr8bcJrbvVnSX2r96HXFgqhv0AnaYOz16RQCWha8w
 r70hXTjnLvvP6ZAUvS+lmEBErvvf4Y7RqkxaB292bQpwew5SkgxaqZl22W4JBm10/jFZ
 hBfmPaKlM9AznyJwS03X+corEpqbJouHVwCEhKXf7G0HhjxLj9TFpGSqNszPbz3E/JCI
 9p8aphHcJpU5feLBXR6Qwz4G4ldVi8d2oR2eBt0r8WgfZQi9GsKhv3ZGdXVJocl7g36P
 6mnfb5TXR4sBzkSEfTUFf7kpPGTRgdqmYRYz+J+BQyVXFBKE6pWl6U7n/r5PKvEwZex5
 W+7w==
X-Gm-Message-State: AOJu0YzcmvndiuTglEI/cjo0SdR/sfw/Bdd3sDmwj9J4R6+5OQ3pEyC8
 +yeN3PeLKObc1OgUQEB+NbZ9wnDi1v2YGhetm8T0MRPAAWa/Mg==
X-Google-Smtp-Source: AGHT+IFLwsf27U7umlratCz4vBS97rem+l6GfcT9vfDAaenDE1EA5MCr6YsXwP653NCkuJlinTxawzFI2xK/mEIWGFs=
X-Received: by 2002:ac2:4910:0:b0:50e:70b4:79ce with SMTP id
 n16-20020ac24910000000b0050e70b479cemr1426391lfi.185.1705329791986; Mon, 15
 Jan 2024 06:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-22-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-22-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 14:43:01 +0000
Message-ID: <CAFEAcA_n-uXJc9fd9n3c5Xj=ibtpokWpaozE-G+imyV6X=DNTw@mail.gmail.com>
Subject: Re: [PATCH v4 21/45] Add clock_isp stub
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Fri, 8 Dec 2023 at 02:40, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c         | 6 ++++++
>  include/hw/arm/bcm2838_peripherals.h | 1 +
>  2 files changed, 7 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

