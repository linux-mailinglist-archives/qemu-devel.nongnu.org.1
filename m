Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A92874ACE6
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:29:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgq6-0007kU-7H; Fri, 07 Jul 2023 04:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgq3-0007jx-1J
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:29:15 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgq1-0001ZM-H3
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:29:14 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9922d6f003cso208195066b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688718552; x=1691310552;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I59hDVd5fduC46jMVdqzhIKrMV94ozgfyjQxTax7lfU=;
 b=cuM7hxK1lM7mx9XbpFUQk2MpvshIbWDOEYyrD5z85JxcZ3ZLv4aNuTKSQkmd11EyFr
 VE7HV9jQNJtDQdIq/G2MAB7ehsL4bIEIefk03HznYi4BEYlIJRmx2LOjdm3tzGhHMk9P
 1rAZ+WJtsyDIGjh+hVSb4mDm6HsoIehn6dKuNswe+JOJ2pVSFR2ca/BR6I1vujAc0EQA
 8Z1Bh1oBOMletv5MqDsvIsewfAO/1NY4lvLOYttd0IlXPvEuecNajdyS++DcYXnvdUbe
 aCQ42M/Z9gBSESIOrUzonRX4aNrqbQhzY31vktfgm63Q19UApeb3EqvBJW20jsKyiyLO
 Qh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688718552; x=1691310552;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I59hDVd5fduC46jMVdqzhIKrMV94ozgfyjQxTax7lfU=;
 b=AZzhXMOFd1lpPk2A134fR2ojixKgOu6LIBo1E/4WOXb01wWlu8o4nZqich5dHAzhr2
 X/m3ggdhRUaiU8fV1UUvD6c5GJ0vI+IliGXTbh53KS+ruKtBoOd2Y8j4OZl+OxDp1n1e
 BuSgreUfcLBw/wNJHQUXXuc3KpJ5/pPZ58r6uSWyMuv4AnoxPDf1xutFDJrVi6a7v5yJ
 /85Dx7gmF4OKLcKV2H4kLcrk3a0CDbIftDAer719YcyRAg7gU4wGgHYCvYszDhNRYit4
 QNDHZum/IfMZf2AuPPnNwgxr+xiXI0V7ctR3K0bgZaCWC5TrkGLrCJXcAGlpsUuoy06K
 XQNg==
X-Gm-Message-State: ABy/qLZTAjWmqluyFuQXgfjKXpiYqLPGOfydXo9iW05YizStqWBh+wb0
 /HrBizdIWI2a2MGCQj09mTzj69zC+ohaiK/1F/M=
X-Google-Smtp-Source: APBJJlGhbOyphhpUm5XFppWQTPxeG6sL1AVMpmshWVr+klkUYDklB2ppEBogdqKsGGGIJ2azCXXswQ==
X-Received: by 2002:a17:906:104e:b0:993:d6e8:2389 with SMTP id
 j14-20020a170906104e00b00993d6e82389mr342566ejj.26.1688718551932; 
 Fri, 07 Jul 2023 01:29:11 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a17090634cd00b0099316c56db9sm1858113ejb.127.2023.07.07.01.29.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 01:29:11 -0700 (PDT)
Message-ID: <e3fe143f-2c07-2d59-3dca-4534a767391d@linaro.org>
Date: Fri, 7 Jul 2023 10:29:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 10/21] q800: add easc bool machine class property to
 switch between ASC and EASC
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-11-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230702154838.722809-11-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 2/7/23 17:48, Mark Cave-Ayland wrote:
> This determines whether the Apple Sound Chip (ASC) is set to enhanced mode
> (default) or to original mode. The real Q800 hardware used an EASC chip however
> a lot of older software only works with the older ASC chip.
> 
> Adding this as a machine parameter allows QEMU to be used as an developer aid
> for testing and migrating code from ASC to EASC.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 30 insertions(+), 1 deletion(-)


> +static bool q800_get_easc(Object *obj, Error **errp)
> +{
> +    Q800MachineState *ms = Q800_MACHINE(obj);
> +
> +    return ms->easc;
> +}

Is the getter useful? Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


