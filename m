Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A141C79D15D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:48:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2o8-0006BH-N3; Tue, 12 Sep 2023 08:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg2o0-00068S-FF
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:47:48 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg2ny-0000vk-8l
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:47:48 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31f915c3c42so3035744f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694522864; x=1695127664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IP3UShobHVIaraMH5luRzR0GgluVEcphL0vQ+SnwoOA=;
 b=uBkfscsJCe/+5zrq7oOI591kz8TNbgUR0O6P7PkAm98ejoxc5gXAgk6B+J2wmxgq75
 9sfQj6oippASmaq4z2c2UPaeTvKlxRzIbnJy5cq/x4c3yZ8W7HHZ/F1qNhY11mVdpNUr
 BT2Mv3Q7MaGgpUwaaG6sesQHy4uaRwGsYuCZLhzBOwIfdrmR1ZieKG8/Y1dCisJMrvzM
 Rg4s7ne9eNZMD4Vf8Jv8KvSXsV8Nfxf8ktfEfGXR6mDhqHxmiEdqxke41zJ2FfXEnYdE
 I0eWXq6B3Av417eKCm5bUP2y9O3kYKZvhHKa9V4lBrrg3I2WPek9A6eoE8BjQL104UMw
 jFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694522864; x=1695127664;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IP3UShobHVIaraMH5luRzR0GgluVEcphL0vQ+SnwoOA=;
 b=IIjYlqFIuIfYduqk/5vNLjxSas7a7YBlFQRQyJryXJwMzHeB88KcTD34QCa2Fd4Qo0
 h+rysUi6Bw/7cogieogoz009f+piv6Kjmp6mkBF1DJs57HdwyZ0Elna3RyP8AI9jKicC
 GJG12lgJAFgeaqPAJPrRZIoavn838vq21TnXXdeas73vIgepVEDfJhZQ8KFHX4BJjshu
 YikQb0wOK2caOBlQ0za87zGnKbE7fyxbYkV2zO+DuG814gYB6q6fuqCK9Kefr+EnzNGg
 p5OYfwq41vHyE4dT8JPoG/iZnEZKS/sOE9XqgdFn0XjPIiuJTUmFeD2yEqk35dFHSGt5
 PHOg==
X-Gm-Message-State: AOJu0YzCa40xog/7BmaTlfwz13IfnxxOIC22YMn9CCidYw+QpCTJJFDB
 Sphki+h6ABIbvBeYdUlmDekO6w==
X-Google-Smtp-Source: AGHT+IHBkLdfdFGo10acpA4Q/NKNtsBc2XUbC8Oa/hPzNdZT0lH5aG3KbfOp6HmvFpnbRmQCIYXbAA==
X-Received: by 2002:a5d:5103:0:b0:315:8f4f:81b8 with SMTP id
 s3-20020a5d5103000000b003158f4f81b8mr10749789wrt.50.1694522864431; 
 Tue, 12 Sep 2023 05:47:44 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 l9-20020a5d4bc9000000b003180027d67asm12726357wrt.19.2023.09.12.05.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 05:47:43 -0700 (PDT)
Message-ID: <be58faf9-8218-e085-7dc3-b9c2858adac8@linaro.org>
Date: Tue, 12 Sep 2023 14:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: Usage of vfio-pci without KVM.
Content-Language: en-US
To: Shlomo Pongratz <shlomopongratz@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <CAHzK-V2a-tW8BQBJNurf0QogTNYH3_oEg7HAfi-dSU_3D626Tw@mail.gmail.com>
Cc: qemu-discuss <qemu-discuss@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAHzK-V2a-tW8BQBJNurf0QogTNYH3_oEg7HAfi-dSU_3D626Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Cc'ing VFIO maintainers.

On 12/9/23 14:39, Shlomo Pongratz wrote:
> Hi,
> I'm running qemu-system-aarch64 (QEMU emulator version 7.0.93) on
> Ubuntu 20.04.4 LTS i with Intel's i7.
> I'm trying to pass a Samsung NVME device using vfio-pci. I detached
> the device from the nvme driver and attached it to the vfio-pci.
> Using lspci I can see "Kernel driver in use: vfio-pci"
> In QEMU script I've written "-device vfio-pci,host=0000:03:00.0" where
> 0000:03:00.0 is the device PCI address.
> I get the error
> qemu-system-aarch64: -device vfio-pci,host=0000:03:00.0: VFIO_MAP_DMA
> failed: Invalid argument
> qemu-system-aarch64: -device vfio-pci,host=0000:03:00.0: vfio
> 0000:03:00.0: failed to setup container for group 15: memory listener
> initialization failed: Region mach-virt.ram:
> vfio_dma_map(0x55855c75bf00, 0x40000000, 0x100000000, 0x7f5197e00000)
> = -22 (Invalid argument
> 
> My question is vfio-pci is supported with cross architecture?
> 
> Thank you.
> 
> S.P.
> 


