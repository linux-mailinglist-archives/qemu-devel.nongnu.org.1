Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D868707DA4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:11:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzabC-000358-0l; Thu, 18 May 2023 06:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzab9-00034k-Qr
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:11:03 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzab8-0003PT-B3
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:11:03 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-50be17a1eceso3190263a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684404661; x=1686996661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vScuOnyVFxi8AXSnCF0Ztm0U6LugS58i6f/I6I8ifvk=;
 b=v95m79OPCOCWNj3YX2w0P5pGLV0AfXrCXJfipoqaTBkxMLJdXoO6DxztxeO7QOx7YT
 8VttwF07ZWR/CyXO+1lA3lVQB3QHthXeQUP/3ROZLjwOPWN+XTUCvXwq9u5BIfJTeEGD
 WkTBV5LkBKo9GxjOAehaGhFz3T+73iggXXLy4ZqLlizMNVuWRKrMMX5FdWSBpc/2hVEL
 ybGm0cERo55w6LMXYV2AXbm8dSESjWw7+/0lzzfo9GMfSxLB0/4P8vDVXPTLB9UGWbRr
 cz3w1isi/LCjDNkjEGkgTCPHWhQm3F7xRbuTsMx2YPCpcw6Vi3gl2SXVbF/kJw8lxO4K
 P+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684404661; x=1686996661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vScuOnyVFxi8AXSnCF0Ztm0U6LugS58i6f/I6I8ifvk=;
 b=AACLyjg7rVE2Dpo39ZKrnalzuZT4F8cBTObqozSVGuLohvUK1C4mlWI3Z2vWIemkL0
 epTKk1bKv513wTipPcNzz5D4u9isbAVgx0D2QzuU5RgHRjoBtMURYDYrjqX2yoC+reoh
 zAV525OQJmX54IRxhtuOtulNwfStVLYzLulDP165qfviCY426JFpBONOV4R9iwYTcqz5
 2soryK/P8ToKU9jOrYLO48+9eeBCeC0nlg96Aw5d9B3XiTf4GvUKrXs5riOJZz2HYSDR
 BEJxvDdfSMmhgnt4KZ0YeepEmlcSXaIPFZawB6nv1DRNEg40IZZh908Jp7Lzh/YaGWNV
 oAqg==
X-Gm-Message-State: AC+VfDwrvnNeaAxRrEkHsXkHb/xD6Ye9VjyVi092mMrMkTe04Yt7nuv4
 vQFRvKZKlEd2PB/ii1gc1jyVq6fX1szJmvCmT4W4sw==
X-Google-Smtp-Source: ACHHUZ5plqNHL1Po/U+akHPLRwFBJvc3nWrKp+aNSO7DiCv4vSI99peBowY4iMoQHkZwKCRYpey3C1GQEcuilKiv2xU=
X-Received: by 2002:a50:eb0c:0:b0:50b:c1d6:8d60 with SMTP id
 y12-20020a50eb0c000000b0050bc1d68d60mr4912561edp.21.1684404660879; Thu, 18
 May 2023 03:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230516104420.407912-1-alex.bennee@linaro.org>
In-Reply-To: <20230516104420.407912-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 11:10:50 +0100
Message-ID: <CAFEAcA8fu-+YUeuhVw8mpgYXO=ueXrCecC-LkhFwoubUkMvg4Q@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: add RAZ/WI handling for DBGDTR[TX|RX]
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Anders Roxell <anders.roxell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 16 May 2023 at 11:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The commit b3aa2f2128 (target/arm: provide stubs for more external
> debug registers) was added to handle HyperV's unconditional usage of
> Debug Communications Channel. It turns out that Linux will similarly
> break if you enable CONFIG_HVC_DCC "ARM JTAG DCC console".
>
> Extend the registers we RAZ/WI set to avoid this.

Applied to target-arm.next, thanks.

(In theory we could implement the DCC and wire it up to a
chardev, which might be a cute way of getting early debug.)

-- PMM

