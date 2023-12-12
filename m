Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C75D80E873
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 11:01:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCzYm-0008Gl-7H; Tue, 12 Dec 2023 05:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCzYW-0008Fb-2t
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:00:00 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCzYF-000741-JO
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 04:59:59 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a1ca24776c3so1320986166b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 01:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702375182; x=1702979982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z2P0KYV2uc/1Ueee6hj46yxC72U4fbFkrztXuWL5f1g=;
 b=HP6tKS99oyQ/Y4RfIAS4MQDNhWVMVIwj8hr++d1bgd1XkgqfTo70H3sutxoZJOLXBO
 UNRD1lf4jQq9hDTvSGuKUgvcFWTovnP4QvOVDOESxDOp4hE8AYGe7GZXLUk9mFmPzZrI
 2B5AvvFynQPAJYXDXNaGUs3AiXUak02cdNh+d+9bLeFFsCXD0o6qwQnAqwOTFUKdNc2T
 6PmYUZniCluYUkn2Jk1XnkhVMRWUI1Rb8U40AW/V5ujp3GMlviIEaZI3YeTfkmav4C9r
 CAXaSXMeMJbmGHu4bjbyoXADeCvci8FzgPndQOb5LBKREE08AgPfNWzI+QvpfwJzvOSv
 kj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702375182; x=1702979982;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2P0KYV2uc/1Ueee6hj46yxC72U4fbFkrztXuWL5f1g=;
 b=apiKFVMrRtlWYS9DTKyxbPtTzYeRgKxNGKCk5wBpSnGzjtUuBAAZ24opZPR4DVp7NT
 pzwJ+uD1oQfF0X5C48JHhTw84jA+mmevBXh5qNOxaWQedxSIgRPEoeHdEtW2/RRMEbYC
 dE6P4IAeFDL1LKK+f119x0dMA42uv/AShbFGMAeUiQCcvKKtZMcHI7u52Y28ZGi/mEcT
 WwEUnkA3a4LMXinoNrWuw2LC/5r6AcCuOjyh/PZdz7I2ZMv/xFT3I7xVjihT4IV6RUZc
 ajKxPtLZC/AHegXOsNFtksIPnXL7odd94epm3q5CUgY4ZLZV2FhH5/9sQkMr19rIlLwO
 nQRQ==
X-Gm-Message-State: AOJu0Ywtac38rC4hVctvgDDFDCmgAQywzoIP4BDy42VNxlBiOSCgipW6
 v2xs3hhjqBBaUh0y+EBGno5mYg==
X-Google-Smtp-Source: AGHT+IEYelQ8jUdFBRR8R+eHyFXqrfwH05/HjJdd0vSkCIzYgPapsCP6tlFZjfdJEI/565E9c9dljA==
X-Received: by 2002:a17:906:748d:b0:a1d:d397:9bf8 with SMTP id
 e13-20020a170906748d00b00a1dd3979bf8mr3810345ejl.10.1702375181704; 
 Tue, 12 Dec 2023 01:59:41 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 tb19-20020a1709078b9300b00a1cd30d06d1sm6139752ejc.14.2023.12.12.01.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 01:59:41 -0800 (PST)
Message-ID: <f464abae-fa75-42c2-8f98-992d2d9dc65f@linaro.org>
Date: Tue, 12 Dec 2023 10:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/12] hw/pci: Initialize PCI multifunction after
 realization
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yui Washizu <yui.washidu@gmail.com>
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
 <20231210-sriov-v2-1-b959e8a6dfaf@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231210-sriov-v2-1-b959e8a6dfaf@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 10/12/23 05:05, Akihiko Odaki wrote:
> The device realization code may enable PCI multifunction for SR-IOV.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/pci/pci.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


