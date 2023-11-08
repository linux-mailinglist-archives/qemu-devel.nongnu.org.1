Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF07E58E7
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 15:29:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0jXB-0008O6-WD; Wed, 08 Nov 2023 09:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0jX6-0008NO-5z
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:27:52 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0jX3-0004qx-NL
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:27:51 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso1044511666b.3
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 06:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699453668; x=1700058468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UTVySnCHqdBYrtYlFPk0dG8SS+HryJ+3ImfDHYCMhSM=;
 b=o93ooex0v4eKpcGvPuQ7acN5LYAz0O3Z1MRm7oQOiqEYxJbmr5a+68dySIe6dwsFRl
 pjSPu2B8v6I3qu8pjneMOC2lNv7oeWtPr0NEqk/REynTIyTwqxHxCQOfikDLAEHX5Zbv
 bxB3I3P+cm5rBtFX6evW2G3CyNrAVp9V1qA+RUM5qAK+7FvsitUhUDRjvMjq8iAm1M8Y
 OVYyPZteWcwf093Me6UGjFChMYnsyQFiMyam4nxe3RUzAUgwr3U/tXBT4DeaCw1/ARuz
 dll8G2Z+jU9+2/2y0FbJ71q69sbglMwp4B19YwXDrDHLDdC/ymul0WwiaatyGfocuMMv
 Ub1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699453668; x=1700058468;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UTVySnCHqdBYrtYlFPk0dG8SS+HryJ+3ImfDHYCMhSM=;
 b=NWj3biymlQTNPIV9Cv1S74g4IeItEcRxii9UId53HkHYhlw1RiAB2cNEMbUig9GpIm
 dCHkv2Fb3g8MEuwKj/33SYJR/juD+2rZDj7Km70ZDDGb3ol3Gnc+W+2uDYWvh5OFuwms
 GsoI8asyxPpiYzJOYoC/uBWyZvuPvhBDLCNVvIE5fmr2WPJt3bSUzIjdFle+IwNHgcig
 I/exRB6HKn2zspqGeCMxjql/0tdcxZfvbuAE9iBT2uZ0tWm92AeW2rLNvWfJPEonTyOk
 bgGxIibVkHurbBRxxagWAmY7ItvC6o0wX5/HS3bP/pgmlz/BQr358ywzyBW7G3nP5ip6
 waKQ==
X-Gm-Message-State: AOJu0Yy8PyYXJ7ZjBWMngfkBBDyOMgVs7Z8KUut3YEbQPn1neysHj3SD
 bkEtTBZrQV21/El5vKC5+i3qBA==
X-Google-Smtp-Source: AGHT+IFUTyMe1KwO1Z6c+3hS4EvXtZxm3ncpM+M67IB4hA9IkvBqdJVPSFZ9eUoIysb7hF6GFn1osQ==
X-Received: by 2002:a17:907:741:b0:9bf:77ae:3aa9 with SMTP id
 xc1-20020a170907074100b009bf77ae3aa9mr1586129ejb.24.1699453668069; 
 Wed, 08 Nov 2023 06:27:48 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a05600c4e8600b003fefb94ccc9sm19950237wmq.11.2023.11.08.06.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 06:27:47 -0800 (PST)
Message-ID: <2ed8e417-438e-4d44-9e1b-f391328afc4d@linaro.org>
Date: Wed, 8 Nov 2023 15:27:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/20] first version of mcdstub
Content-Language: en-US
To: Nicolas Eder <nicolas.eder@lauterbach.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Boenig <christian.boenig@lauterbach.com>
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

Hi Nicolas,

On 7/11/23 14:03, Nicolas Eder wrote:
> SUMMARY
> =======
> 
> This patch-set introduces the first version of the mcdstub.


>   30 files changed, 3749 insertions(+), 38 deletions(-)
>   create mode 100644 debug/debug-common.c
>   create mode 100644 debug/debug-gdb.c
>   create mode 100644 debug/debug-mcd.c
>   create mode 100644 include/cutils.h
>   create mode 100644 include/mcdstub/arm_mcdstub.h
>   create mode 100644 include/mcdstub/mcd_shared_defines.h
>   create mode 100644 include/mcdstub/mcdstub.h
>   create mode 100644 include/mcdstub/mcdstub_common.h
>   create mode 100644 include/qemu/debug.h
>   create mode 100644 mcdstub/mcdstub.c
>   create mode 100644 mcdstub/meson.build
>   create mode 100644 target/arm/mcdstub.c

These files are missing a license. Adding:
/* SPDX-License-Identifier: GPL-2.0-or-later */
on the first line is usually enough.

No need to respin a v4 yet, let's wait for technical
comments on your patches.

Regards,

Phil.

