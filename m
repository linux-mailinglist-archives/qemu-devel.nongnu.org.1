Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D180CA93
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:11:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCg3b-0000qy-Qt; Mon, 11 Dec 2023 08:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCg3Z-0000qp-Np
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:10:45 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCg3X-0006P4-8c
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:10:45 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3360ae1b937so2006680f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702300241; x=1702905041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xqua8hXcGPAbk1HHL6rBZ4Edmk2U7JiN9FUmi5WaqmI=;
 b=hz3Xb3aGJZIodA+GHWK4Nk0r4dDC/ETOldi8mR45Bnp3156nVReriFwi1SnPsQAxwA
 o+iqcjU5NtkiLxK6t+lsfjxp/quVc8TQo0D6b0wJN4HyVwlI86kzN1p8z6mpploHSzn3
 N0pr/0/Yv0nYNIPF4QTOoPsSCg5AYQD3g0daL67oKaH6t/Ci04MiIO/3FfZW4sqJi7fX
 34QQSDxucGkOQz0cDizdeLsjij7IXmyURVesVHjyAAPuTzZYfPxfPCSvYLvUvf7WyWdi
 A6gscVONxY4FxRfLkiFzGTPsCAe2Y9E71yfQ7X6ohlV9mogJpfAZ39AAlKsOA78kZSTw
 rpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702300241; x=1702905041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xqua8hXcGPAbk1HHL6rBZ4Edmk2U7JiN9FUmi5WaqmI=;
 b=wTFckT38cD5Ae0UxaeuQkFETJKoNPmy7NU3mobfm3lrmFXRs8BCxg1tHU0boCpZC9o
 sIy8rXOkIl7m3moMEyN0PZFskdYYr5zPyPjuVx84xmKabNiiqh1QCwFFLVY2ZvNdWO8T
 IoznvqHmtSw7T+NaaXBswqvRtS5VmOHiWh8udZVKklXH1Z+zsUOs+Sy/Giw2sTt3Iwg4
 4tKpNxr7HzjJB3eMhZo/XzF4w+qHTenR2oUrubEsZpRCIzu1PojerMQ4mYTC37k/UTFU
 pAyBt+q3rMIIzD3PseK0Gk+n1iR1iU87OqFnuRd1+dysnn8OdoS72n/moKT4J6rix5Xo
 QaaA==
X-Gm-Message-State: AOJu0YyTDYjHuop3FCWmTkBKd8RJsexe0+hHAqToSdtDyEHCqpfY+TBL
 mbDraSokruI2lzRN/jO35rsHMg==
X-Google-Smtp-Source: AGHT+IHK5f5jVJQwCPExTQrwL8Xg1naMH0bKYr6qRi4j38F5a/QMWPhtS/9XdMIiBrXhAiBspgt9sg==
X-Received: by 2002:a05:6000:1282:b0:334:b26b:4477 with SMTP id
 f2-20020a056000128200b00334b26b4477mr2408453wrx.25.1702300241579; 
 Mon, 11 Dec 2023 05:10:41 -0800 (PST)
Received: from [192.168.12.175] (61.red-88-29-188.dynamicip.rima-tde.net.
 [88.29.188.61]) by smtp.gmail.com with ESMTPSA id
 z17-20020a5d44d1000000b003334a0513dbsm8581478wrr.67.2023.12.11.05.10.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 05:10:41 -0800 (PST)
Message-ID: <5b589bca-ec5e-44e7-b525-b8614a879648@linaro.org>
Date: Mon, 11 Dec 2023 14:10:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen: fix condition for enabling the Xen accelerator
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <stefano.stabellini@amd.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Young <m.a.young@durham.ac.uk>
References: <20231209143222.2916891-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231209143222.2916891-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 9/12/23 15:32, Paolo Bonzini wrote:
> A misspelled condition in xen_native.h is hiding a bug in the enablement of
> Xen for qemu-system-aarch64.  The bug becomes apparent when building for
> Xen 4.18.

This looks like 2 issue, first meson, then
CONFIG_XEN_CTRL_INTERFACE_VERSION (the superseded patch).

> While the i386 emulator provides the xenpv machine type for multiple architectures,
> and therefore can be compiled with Xen enabled even when the host is Arm, the
> opposite is not true: qemu-system-aarch64 can only be compiled with Xen support
> enabled when the host is Arm.
> 
> Expand the computation of accelerator_targets['CONFIG_XEN'] similar to what is
> already there for KVM, and fix xen_native.h.
> 
> Cc: Stefano Stabellini <stefano.stabellini@amd.com>
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Reported-by: Michael Young <m.a.young@durham.ac.uk>
> Supersedes: <277e21fc78b75ec459efc7f5fde628a0222c63b0.1701989261.git.m.a.young@durham.ac.uk>

(strip the Supersedes: tag)

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/xen/xen_native.h |  2 +-
>   meson.build                 | 17 ++++++++++-------
>   2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
> index 6f09c48823b..1a5ad693a4d 100644
> --- a/include/hw/xen/xen_native.h
> +++ b/include/hw/xen/xen_native.h
> @@ -532,7 +532,7 @@ static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
>   }
>   #endif
>   
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41700
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41700

I don't know about this, but for the rest (meson):
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


