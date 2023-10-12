Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 700FA7C643D
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:53:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqngD-0004Xv-7k; Thu, 12 Oct 2023 00:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqngA-0004X3-HS
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:52:10 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqng8-0002vY-UO
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:52:10 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so984148a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697086327; x=1697691127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rDelcTJFe8mOTTTdareous3udwOQBNDSUsx28o0UKnQ=;
 b=dvp5ELKlljGogadWNgNxPTRiHnVFiu9pEOyUAa0jQFDG6tLQzRj2k+obd6iZ/twvgv
 hlBXfxy1twIYvTkyva9c2xFas2EDVCD6bpPXGqPcOOLCQV+JAOy0APWiNXPyVMagZEWx
 5nm+OUiOJgWwvmrwygzfgvFATK2N3jRaioRPbzfC5RXa5qSpA3PnP37BOvnOxcpBPnTi
 Zlhc/7M3uLXi8Kxsy8HkXrRlJ0CzPkLWJxDR8/m7fsSbhDmqBQ+3Ph56p7035iG6cxVP
 R9Lm2sK/w/0Q01zXfD8j2EMLN2CYQzGnZ9bkbB8nc6dwUN/Ssqy+FY2n5Tyzv/thwCKg
 neTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697086327; x=1697691127;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rDelcTJFe8mOTTTdareous3udwOQBNDSUsx28o0UKnQ=;
 b=Q/uGRMfhSGoxOngenS+2fAzp0vXHVgFDnk0Hjt6V43br3gn5LI3mPWtm2Wrneps7Et
 ZVRjfiShdUKneriV1bxGdfbCYRC2m+FxedJJpwLLoi2MDV7W6rgzFzAEufDGoqTFHh3i
 YsLeOzhsK4L4uusW8EYHG7zYCxevlU9NDyTrrKMcx6wtX8XeLjl/HXeyqt3fX4xK360Y
 euoO+dXSM+Hwy/6cIzMsm2tqoXkg/e61YTkEduANrR0fFDi2jQNmVY8yuZItahGnKSLo
 SBVX4WqmHK1+YZEwbj+LnWazJ3gNcwcbaprwTwPCuy2x/ZzCQRvUQXYSKW+Vf+TgQxXs
 xUdA==
X-Gm-Message-State: AOJu0YyHAP+kHGhakfFscFmrBLYlCTvTRINM6NGolgmLTM+QxSNeo/kV
 eKj+LrDTWaiU8P84znRDmqGG/A==
X-Google-Smtp-Source: AGHT+IFlk9BX7KDI5xqssFr3XSB52uw5GPgrEtmbR+atJftTAlFMST+SYTZU6w9w/G9vnywxzqecvw==
X-Received: by 2002:a17:906:4e:b0:9b2:9741:e1e9 with SMTP id
 14-20020a170906004e00b009b29741e1e9mr20749857ejg.7.1697086327171; 
 Wed, 11 Oct 2023 21:52:07 -0700 (PDT)
Received: from [192.168.69.115] (dcs23-h01-176-173-173-31.dsl.sta.abo.bbox.fr.
 [176.173.173.31]) by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm10582687eja.24.2023.10.11.21.52.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:52:06 -0700 (PDT)
Message-ID: <31ae6951-2f32-ab86-4ddc-aa70364a89ce@linaro.org>
Date: Thu, 12 Oct 2023 06:52:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC/PATCH v0 12/12] gunyah: Documentation
Content-Language: en-US
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: quic_tsoni@quicinc.com, quic_pheragu@quicinc.com,
 quic_eberman@quicinc.com, quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com, Brian Cain <bcain@quicinc.com>,
 Mark Burton <mburton@qti.qualcomm.com>
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-13-quic_svaddagi@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231011165234.1323725-13-quic_svaddagi@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Srivatsa,

On 11/10/23 18:52, Srivatsa Vaddagiri wrote:
> Add gunyah.rst that provide some informaiton on how to build and test
> 'gunyah' accelerator with open-source Gunyah hypervisor.
> 
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> ---
>   MAINTAINERS                |   1 +
>   docs/system/arm/gunyah.rst | 214 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 215 insertions(+)
>   create mode 100644 docs/system/arm/gunyah.rst


> +Limitations
> +-----------
> +
> +Below features are not yet supported.
> +
> +* SMP (PSCI support needs to be added)
> +* virtio-pci (support for which in Qemu seems to rely heavily on KVM, which
> +  needs to be made multi-hypervisor friendly).

Is QUIC interested in working on that? My work introducing
AccelCPUState to make CPUState accel-agnostic was done in that
direction, but I didn't notice much interest in the community
so I unprioritized it.

Regards,

Phil.

