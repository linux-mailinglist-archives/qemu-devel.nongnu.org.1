Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 793EB74F2B0
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:51:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJEhE-0001S0-So; Tue, 11 Jul 2023 10:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEhD-0001Re-Ga
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:50:31 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEhB-00039r-NK
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:50:31 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b703d7ed3aso95210651fa.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689087028; x=1691679028;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6x9XZTvV9jpDpbbK/iF8+fsNpxh+skWTMHj+S38fk24=;
 b=ylLSfvTKtV+5O6SEymsgbmFFu2S6ljwugGFMaqp6Bq6/sJIt+t07FjV8wzr6IB3koD
 eZRwPw/jEz35UMH5BF2kvOQv5ac6nxcyMI4EeIUVvdFygx7PU5i7eRbw/H4ATLIoP9Dp
 df00WVA9cmJ0JVGHQUQ5iIlttZojOxZoK5aCThXfesOTCPuDzaAVG6eiyBtKHa3JSedR
 0WbIHUo0J+Ns1rQPuq+f7JE51C9+cXQWoBIaF/wggLSMFYi1UKb/4s7jWjcINXZW41U1
 u5C8Cq3A/4GuXCCuzqhaZT6rw+rTu0QwAq3PCJUm0Jh/2gd56yL0Qn1i4nRJ4g8bJCna
 ToLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689087028; x=1691679028;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6x9XZTvV9jpDpbbK/iF8+fsNpxh+skWTMHj+S38fk24=;
 b=LbBPgansg+9BBoAdKluIP3HF7ww6W4L75DALWKQsJMjzwYCVN9dImWQ1WU9LQ0MpmE
 c6+JmUD6Cncbounbw6SrFMmcpCItUxxN1imieNK3p5XdNEo739NlavSCwV86QjdY3MvT
 darebXJK+nyaiTILmPsHNzAaKjRBSOgFjLWArMM9b22mwt+TvhGTglmBcV630C/EcQEL
 Ax7cd2La/z7K0UJe9Bj7qez4HDxIBQ6xQhq/bIlrK7gtEU8/l2OtQXIvK6HY9AA1uIaT
 Y4TrNKY+v9EILCqtHh2u9JhS3AdjZlDfObeEKCZ5Pz+zJPD9I4aNUpsCKacnesStdgpi
 He2g==
X-Gm-Message-State: ABy/qLZXOH2pWwbX3Qz082A0/SLRD0BoH461NbGZvP04hg0F/kZlpiIo
 7+NShg+RwGmpQ3JJoWvgdKfmJ8DRtOteRk8hO5I=
X-Google-Smtp-Source: APBJJlE/WH97d0zhvc+OXZrxkO/GJbI9YVvYQ8fdJ+H50yaX65KepX7OuysqmZjBGOqSIbeINL5tew==
X-Received: by 2002:a2e:b0ca:0:b0:2b6:e105:6174 with SMTP id
 g10-20020a2eb0ca000000b002b6e1056174mr13121139ljl.47.1689087028110; 
 Tue, 11 Jul 2023 07:50:28 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a170906351000b0098669cc16b2sm1243489eja.83.2023.07.11.07.50.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 07:50:27 -0700 (PDT)
Message-ID: <89d0f254-d27c-518d-180d-d4adae770cd7@linaro.org>
Date: Tue, 11 Jul 2023 16:50:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] s390x: Fix QEMU abort by selecting S390_FLIC_KVM
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230711143426.708978-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230711143426.708978-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 11/7/23 16:34, Cédric Le Goater wrote:
> If QEMU is built with --without-default-devices, the s390-flic-kvm
> device is missing and QEMU aborts when started with the KVM accelerator.
> Make sure it's available by selecting S390_FLIC_KVM in Kconfig.
> 
> Consequently, this also fixes an abort in tests/qtest/migration-test.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/intc/Kconfig  | 1 -
>   hw/s390x/Kconfig | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)


> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
> index 5e7d8a2bae8b..0dad184e06d2 100644
> --- a/hw/s390x/Kconfig
> +++ b/hw/s390x/Kconfig
> @@ -7,6 +7,7 @@ config S390_CCW_VIRTIO
>       imply WDT_DIAG288
>       select PCI
>       select S390_FLIC
> +    select S390_FLIC_KVM

         select S390_FLIC_KVM if KVM?

>       select SCLPCONSOLE
>       select VIRTIO_CCW
>       select MSI_NONBROKEN


