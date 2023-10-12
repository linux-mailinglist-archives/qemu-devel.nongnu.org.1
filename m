Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FBA7C6C86
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 13:39:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqu17-0004DU-1w; Thu, 12 Oct 2023 07:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqu15-0004DD-G4
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:38:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqu13-0008DI-Fm
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:38:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-405417465aaso9381145e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 04:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697110687; x=1697715487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYoal1t73cZzk+XXznIIWRUd96h0pUkSOFoByGrG2TA=;
 b=ly4l4FXZSzkoCX4yZ47CGwYByqKpigoURt/nzUzyR7ZsZWfdqItHL31FiAPUWuMFy9
 otmPgfDrxlSk7yZq0rSU9M3dUjqEv+m4qgNdIxM9KkPeXsohl/C66u+T9Ryim5RKlEfP
 7amQITIQ0ttZ4t5wE5xHclcJ20GUZHHQ5kFk/x0z/tenHTDdKhfDpr5p4OAafd2HOJzN
 86FUPdroEiqT0N0bCVDw/kDUxx02x6TKiSfhQ7KhmDrPNTe3UC+CEhvYowhoeuXstjm8
 46mg+wvXlikAe/2AfQhB4ZYahvuJFXjTqdu3tYi2Pi1cpr4vLz4Sz4k/VP+Y4sRMrUAE
 HqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697110687; x=1697715487;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KYoal1t73cZzk+XXznIIWRUd96h0pUkSOFoByGrG2TA=;
 b=kBqGDp3VZLWSLVwQXMDgsaTBZSApJBiv0yHqNDd83qaUDpEwIiXzJMpp9iYJzLffvp
 ENRIsI8kR+gddkfEGcY8/bORb1nKuqrllH1ETDOC+mQIlf51TUJtkYeZBx5j2mPxZH+V
 KKtdu5ayLVlRxFWnpz9dNGgpN5w+r78XVGWJbjmj3xsbMajaxLmdKm9D6TXlDJevlkfZ
 lCIeCYVGgG9+xkrcyRC0izh8vE3nuL8BQ85pAlNzObot6RvaQZx5bOETJWRqLByRT7da
 5TCA1veiuIlgzSGGpvRW0i7fCRCmjwg3wkTu3dDBc/qGjleo7aiJVAO0dZS09qCb5z5b
 8NVA==
X-Gm-Message-State: AOJu0YzQFmMhPXdTLGIL2pMwXDjFsd0QXNd9YVAEZDnxx7MYBl6NNhcM
 Tnu5xd0+LZf13+9bziCosqS8HSHCeXyYXtuJX/4=
X-Google-Smtp-Source: AGHT+IFv0GcLYLDo4H6cKU7RMTDn+Pjlm4nXHE34LLMKJw9bT3qv6YqRg6SeUH1XYYX3dacGkpCWGw==
X-Received: by 2002:a05:600c:21d0:b0:405:3a3b:2aa2 with SMTP id
 x16-20020a05600c21d000b004053a3b2aa2mr20520923wmj.37.1697110687531; 
 Thu, 12 Oct 2023 04:38:07 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 11-20020a05600c230b00b004053a6b8c41sm19230014wmo.12.2023.10.12.04.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 04:38:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A8B3A1FFBB;
 Thu, 12 Oct 2023 12:38:06 +0100 (BST)
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-4-quic_svaddagi@quicinc.com>
 <d4814468-3b1c-ea34-563e-9418bf1d6220@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
 peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 quic_tsoni@quicinc.com, quic_pheragu@quicinc.com,
 quic_eberman@quicinc.com, quic_yvasi@quicinc.com,
 quic_cvanscha@quicinc.com, quic_mnalajal@quicinc.com
Subject: Re: [RFC/PATCH v0 03/12] gunyah: Basic support
Date: Thu, 12 Oct 2023 12:32:34 +0100
In-reply-to: <d4814468-3b1c-ea34-563e-9418bf1d6220@linaro.org>
Message-ID: <87y1g8m5pd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Srivatsa,
>
> On 11/10/23 18:52, Srivatsa Vaddagiri wrote:
>> Add a new accelerator, gunyah, with basic functionality of creating a
>> VM. Subsequent patches will add support for other functions required to
>> run a VM.
>> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
>> ---
>>   MAINTAINERS                     |   7 +++
>>   accel/Kconfig                   |   3 +
>>   accel/gunyah/gunyah-accel-ops.c | 102 ++++++++++++++++++++++++++++++++
>>   accel/gunyah/gunyah-all.c       |  70 ++++++++++++++++++++++
>>   accel/gunyah/meson.build        |   7 +++
>>   accel/meson.build               |   1 +
>>   accel/stubs/gunyah-stub.c       |  13 ++++
>>   accel/stubs/meson.build         |   1 +
>>   docs/about/build-platforms.rst  |   2 +-
>>   hw/arm/virt.c                   |   3 +
>>   include/sysemu/gunyah.h         |  43 ++++++++++++++
>>   include/sysemu/gunyah_int.h     |  27 +++++++++
>>   meson.build                     |   9 +++
>>   meson_options.txt               |   2 +
>>   scripts/meson-buildoptions.sh   |   3 +
>>   target/arm/cpu64.c              |   5 +-
>>   16 files changed, 295 insertions(+), 3 deletions(-)
>>   create mode 100644 accel/gunyah/gunyah-accel-ops.c
>>   create mode 100644 accel/gunyah/gunyah-all.c
>>   create mode 100644 accel/gunyah/meson.build
>>   create mode 100644 accel/stubs/gunyah-stub.c
>>   create mode 100644 include/sysemu/gunyah.h
>>   create mode 100644 include/sysemu/gunyah_int.h
>
> Can we move gunyah_int.h to accel/gunyah/?

If it's all internal to gunyah itself you could rename it to internal.h
(although we do have various forms of foo-internal.h across the code
base).

However I see the reason is the other accelerators have done so:

       accel/hvf/hvf-accel-ops.c
  58:#include "sysemu/hvf_int.h"
       accel/hvf/hvf-all.c
  14:#include "sysemu/hvf_int.h"
       accel/kvm/kvm-accel-ops.c
  20:#include "sysemu/kvm_int.h"
       accel/kvm/kvm-all.c
  31:#include "sysemu/kvm_int.h"

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

