Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 637DA7D9987
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 15:17:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwMgO-0004l9-OT; Fri, 27 Oct 2023 09:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwMgL-0004kl-DO
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:15:21 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwMgJ-0000Ny-2d
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:15:20 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53e04b17132so3298474a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698412517; x=1699017317; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l4gzMSUyQ/FMX0J7Ljcbxg1HLk8uA62Lx8jX0w7ORsw=;
 b=mnd8ULoBbPvMfyByPfFEiGbx9N51vIjZTrUVnQLIFSXBZ0gnQUfDhVjXyKqLmTFpqe
 nq34TJjCT7B7NI2ryjsTLptEtaQSSNGmnhqVSACTSBtdNxzxRQm6cFisHFtI5r7vvxOk
 GuVkcljBiJfXIAXqBqFjrBbydhF0PNTU9yZUc3uT2D+kY1dTzB6qjicKnC0XspZVVTAG
 LQUYgxJbiQTL47i2WWTdQJe9Qpyge+MFb8PzKZkzgCNXSUDIvIs+V6dDrLoroc5j5Dp9
 fyCua5pYKZCs858Ri0pcom19EIRUiiphs2Or3OXyfrZjqgu9g+9pCwrnISW2KxRotR+l
 XsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698412517; x=1699017317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l4gzMSUyQ/FMX0J7Ljcbxg1HLk8uA62Lx8jX0w7ORsw=;
 b=wECLc29MuenAN1IhVaqxLfSFql1rJjxFVYc1pfXjtwR3fW5SPXggNDGn+8sQMFd6nf
 QybhBAArcNWjH+Cdn82woXbPZcAKaV+L3YZHH9tgC/h0WqG6ebzbprxSQpoh+DUiLVLx
 LewJ6Q8ALpONt3vpiz5OgBk3rt3A1H6HDi1bFNjy57bFYzLljB33zHkihTtiVtsMYQB/
 2ksNtuuFzMFI/wVd1kdabK3kEYe9fX2OVLuXEZslracLY/fNSdNnevVCug+pJZZLQmFH
 kOY3db7YTWFvpSCFiHfyM+mo6dB8HeQSU/cDyqXi0fJtXGsXLUxyvpocJjsj+wgJweqC
 Hw5w==
X-Gm-Message-State: AOJu0YxoOaUSEDeBmHF1ATDzDugI/Ce6R4YzKZw+zA+Y+LDK6xlbMzJY
 4hFtfmxa/8/mjnqGsqpeNBOhcQfoiQQbJgothLpLKw==
X-Google-Smtp-Source: AGHT+IEe6u6qZwQy+WSrjEkF6oaJ+TucR2UW+zEyahAngXZX+G780Y28z4NXq0SARQ8QwTJNLBZQQayyZNJ5TDIfuT4=
X-Received: by 2002:a50:d494:0:b0:53d:a4e5:67d0 with SMTP id
 s20-20020a50d494000000b0053da4e567d0mr2453938edi.13.1698412517284; Fri, 27
 Oct 2023 06:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231017193217.1512868-1-tong.ho@amd.com>
 <20231017193217.1512868-4-tong.ho@amd.com>
In-Reply-To: <20231017193217.1512868-4-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2023 14:15:06 +0100
Message-ID: <CAFEAcA9z8BAgapk4HixRdpB49reLNGs8_b5GMrEt7uYCEr9Pug@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] tests/qtest: Introduce tests for AMD/Xilinx Versal
 TRNG device
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, richard.henderson@linaro.org, 
 frasse.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 17 Oct 2023 at 20:32, Tong Ho <tong.ho@amd.com> wrote:
>
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---
>  tests/qtest/meson.build             |   2 +-
>  tests/qtest/xlnx-versal-trng-test.c | 486 ++++++++++++++++++++++++++++
>  2 files changed, 487 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/xlnx-versal-trng-test.c
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 66795cfcd2..593ca6714b 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -216,7 +216,7 @@ qtests_aarch64 = \
>    (config_all.has_key('CONFIG_TCG') and config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ?            \
>      ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
>    (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
>    (config_all.has_key('CONFIG_TCG') and                                            \
>     config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
> diff --git a/tests/qtest/xlnx-versal-trng-test.c b/tests/qtest/xlnx-versal-trng-test.c
> new file mode 100644
> index 0000000000..dc19c1e83b
> --- /dev/null
> +++ b/tests/qtest/xlnx-versal-trng-test.c
> @@ -0,0 +1,486 @@
> +/*
> + * QTests for the Xilinx Versal True Random Number Generator device
> + *
> + * Copyright (c) 2023 Advanced Micro Devices, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +

> +#define FAILED(FMT, ...) g_error("%s(): " FMT, __func__, ## __VA_ARGS__)

This fails to build for Windows because this macro name clashes
with one from the system winerror.h:

../tests/qtest/xlnx-versal-trng-test.c:71: error: "FAILED" redefined [-Werror]
71 | #define FAILED(FMT, ...) g_error("%s(): " FMT, __func__, ## __VA_ARGS__)

Also, qtests should not be using g_error() to report errors, because
this turns into a call to abort(), which the test harness will
not report nicely as an error. Use g_assert_true() or one of
the family of g_assert_cmp*() functions to test checks that
you want to be test passes or failures (but *not* g_assert()).

thanks
-- PMM

