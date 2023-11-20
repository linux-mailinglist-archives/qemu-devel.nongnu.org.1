Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6837F0CB7
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 08:19:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4yXl-0008OW-4J; Mon, 20 Nov 2023 02:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r4yXe-0008Dp-4W
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 02:17:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r4yXa-0004Yo-H6
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 02:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700464673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RKZ0E7+ImyAmWmav7Lkn4R691jIyDz4wCqFXO9XTfzM=;
 b=fzlE4SyHB+oy073cUb+GzCmhwmLXvDyEA6e74iSWeRTIV4n8oLlXmT6CrlRIL2bBZLZ2vC
 D8dI/w0NerBlZDHdrN+zaxrXJDlnXA1hjZrc9FEGZqkqDOSAPubSUtTdcfR7qJMFYkpiJ0
 o8NIAv2TWYaBz/Wuub82La2ucFAfXsI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-ae-6cyNDMsKt-rxVEbgdiw-1; Mon, 20 Nov 2023 02:17:51 -0500
X-MC-Unique: ae-6cyNDMsKt-rxVEbgdiw-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1cc23aa0096so51259575ad.2
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 23:17:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700464670; x=1701069470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RKZ0E7+ImyAmWmav7Lkn4R691jIyDz4wCqFXO9XTfzM=;
 b=tLsG8NwYM695EAIplzMmKsxzPU21DfFGKI2QW5Om4xTBnaO1SXR1EVhgdDUKSjw9jy
 Vpogr/iJ4RdEnyh4GOuSgOuQWeuGrYsuNlOpIv9fJJ2DGm2R5ZbbR2dxV0opFuMA/iVE
 VZyAQQMU0uiZ+IffQuBmCjD/8ayzTWiD1/AL7HHJ+0wt200jE6QMGIXF7uNPrqN0O7jc
 qr/U6ROedFY3rZcirdInd7cU9TEO2h2uGDWOtl34Pm6vgIlMvEk6Kc6SxURQn5XSFEkP
 J9G88pnIAGAEnUMMzJWcNhn4x8AixBR4nOyq8rF9yciEolAQOSOGAOONCfjfJ8m9WSAK
 7iPg==
X-Gm-Message-State: AOJu0YxT3/ikdNyQFe7djvnFdRP9+2pGvK4NKUfyxqtuI4LQS5zyu52A
 pZ7zRd9+M/HvFKzNjS+KBZVDuXreZB6Elcaap5pf9N1Xuu8bcgS5Sb7bMdR/8DSM72BEX46pQ55
 082+QoIBMjI6ZxXI=
X-Received: by 2002:a17:902:dacb:b0:1cf:678a:6536 with SMTP id
 q11-20020a170902dacb00b001cf678a6536mr132928plx.6.1700464670472; 
 Sun, 19 Nov 2023 23:17:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfgqeTdlHh+a9ggvKjq+2lGKru+nOS8yY0CcsBriYOZ47DnwGQ8PnsblOicmGB0tNPmKpLFA==
X-Received: by 2002:a17:902:dacb:b0:1cf:678a:6536 with SMTP id
 q11-20020a170902dacb00b001cf678a6536mr132903plx.6.1700464670160; 
 Sun, 19 Nov 2023 23:17:50 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15?
 ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170902d50b00b001cf66056a1bsm434487plg.97.2023.11.19.23.17.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Nov 2023 23:17:49 -0800 (PST)
Message-ID: <2edea17f-cad3-4b89-922b-d2e91fce8e64@redhat.com>
Date: Mon, 20 Nov 2023 17:17:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2? v2 4/4] hw/arm/stm32f100: Report error when
 incorrect CPU is used
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Felipe Balbi <balbi@kernel.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20231117071704.35040-1-philmd@linaro.org>
 <20231117071704.35040-5-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231117071704.35040-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/17/23 17:17, Philippe Mathieu-Daudé wrote:
> The 'stm32vldiscovery' machine ignores the CPU type requested by
> the command line. This might confuse users, since the following
> will create a machine with a Cortex-M3 CPU:
> 
>    $ qemu-system-aarch64 -M stm32vldiscovery -cpu neoverse-n1
> 
> Set the MachineClass::valid_cpu_types field (introduced in commit
> c9cf636d48 "machine: Add a valid_cpu_types property").
> Remove the now unused MachineClass::default_cpu_type field.
> 
> We now get:
> 
>    $ qemu-system-aarch64 -M stm32vldiscovery -cpu neoverse-n1
>    qemu-system-aarch64: Invalid CPU type: neoverse-n1-arm-cpu
>    The valid types are: cortex-m3-arm-cpu
> 
> Since the SoC family can only use Cortex-M3 CPUs, hard-code the
> CPU type name at the SoC level, removing the QOM property
> entirely.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/stm32f100_soc.h | 4 ----
>   hw/arm/stm32f100_soc.c         | 9 ++-------
>   hw/arm/stm32vldiscovery.c      | 7 ++++++-
>   3 files changed, 8 insertions(+), 12 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


