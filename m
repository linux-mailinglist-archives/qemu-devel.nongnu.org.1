Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B42836B62
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:44:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxOv-0000WB-NJ; Mon, 22 Jan 2024 11:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxOl-0000Fu-IZ
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:43:49 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxOh-0002jk-IU
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:43:46 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2cdebb968feso38726131fa.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705941820; x=1706546620; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tM474doQDosKN31ji6845TtgOnSYIw5pqktWL1kOrD0=;
 b=rNiL73i7Wwt5xgSKbt1WaZNzy8o6AnuPMSSV439WiZ2IiLx7fF0PoDIwu8UU+7QkQ8
 v00H4R49kSV4dO18kTccsbSxEh2PhuHNfCIzNL3i8T85NGOEfuC3gawszZwwX/l6o5hZ
 xU5Nj/N1FGOTYw2BN1tDYZ7ZmQPryYMWBB0OEsHVNbLohfettAX0lHGFQr+agOTVdPa8
 gzasRSEQAqTyJdcGrdQKESuqQIre6b4h29gSgSnnCFkB3UDpUgR8j+Wp6U+EU2GFJinn
 97t6uaD2F1q+Ko84r2xdULiN/WD2wCaaNviodnD1RIadVY/yOWbFDPyj9RNXtr+QGm/G
 WrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705941820; x=1706546620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tM474doQDosKN31ji6845TtgOnSYIw5pqktWL1kOrD0=;
 b=fKVYLtItBTmBbtSeQbsaesB7ZRWqmzsN0h6gRzMSpwbq9+HFFlaSYDsB84pKF0nD19
 CcwfYuM0si9pSs0Uqi/EmXkgZy4epF9x6L7Ma9YQJBpzSDDAvjNVX6I9gXdz83k5AoXH
 c+o4pOk2Wfu9xM5EXLndFOkbtACydtwWvGdMk5cDW9+cjk/xfHrj145jmFwPxFs6Pjur
 4FNuS4Lhg9Z3knzclnlEE6P08oWFFJ48YFZD738FY/fhE8n9vrRatB6qq9HE66ig5Yj+
 c/aQztts0K14CvwvqpGNDUfN0+woobPjXcHVz681HO9wE7vAdI9pl7o0FQ7RmPBapQA3
 l3TA==
X-Gm-Message-State: AOJu0YwmWQk3GgWeF4kHU7uOJhpJuwJK298DELhF9qZdmBBz3Xutw4QQ
 cwPYxzUBnqqumOQfVMWjHPUy11zCbFIg2LA5diWOcWchUhYUfAAEZ9ULiVVfM7juPZXMag2PVyi
 8G7qGMVVGtO/4U6Dte0OCrCVaFhBX9GNQEPQ+vg==
X-Google-Smtp-Source: AGHT+IGrBN1DoQJ2dZc0HLUQwSm7+hqLCyHiTrZnUIwNvDzfwfPJZoL7n1p0I6RbzlG6lOaDFHLfCL5IGLkRCV4kDTw=
X-Received: by 2002:a2e:a901:0:b0:2cc:eefc:20bf with SMTP id
 j1-20020a2ea901000000b002cceefc20bfmr2675087ljq.24.1705941820432; Mon, 22 Jan
 2024 08:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20240120005356.2599547-1-linux@roeck-us.net>
In-Reply-To: <20240120005356.2599547-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 16:43:29 +0000
Message-ID: <CAFEAcA8bPmpZC-b4ZLcNQO7oNy4R-OKVRvqnO51wNUR1Q00JcQ@mail.gmail.com>
Subject: Re: [PATCH] fsl-imx6ul: Add various missing unimplemented devices
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Jean-Christophe Dubois <jcd@tribudubois.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

On Sat, 20 Jan 2024 at 00:54, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Add MMDC, OCOTP, SQPI, CAAM, and USBMISC as unimplemented devices.
>
> This allows operating systems such as Linux to run emulations such as
> mcimx6ul-evk.
>
> Before commit 0cd4926b85 ("Refactor i.MX6UL processor code"), the affected
> memory ranges were covered by the unimplemented DAP device. The commit
> reduced the DAP address range from 0x100000 to 4kB, and the emulation
> thus no longer covered the various unimplemented devices in the affected
> address range.
>
> Fixes: 0cd4926b85 ("Refactor i.MX6UL processor code")
> Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> This patch is necessary to boot mcimx6ul-evk with Linux v6.7.
>
> My apologies for the noise if a similar patch has already been submitted
> and I missed it.



Applied to target-arm.next, thanks.

-- PMM

