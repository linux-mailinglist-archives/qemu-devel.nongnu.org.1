Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B582F19F
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:33:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPlQl-0001Sq-4U; Tue, 16 Jan 2024 10:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rPlQj-0001Sa-2h; Tue, 16 Jan 2024 10:32:45 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rPlQh-00018o-5d; Tue, 16 Jan 2024 10:32:44 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-28bec6ae0ffso5997276a91.3; 
 Tue, 16 Jan 2024 07:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705419161; x=1706023961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=VJBSSWyyW4VDLC7/1CVasTkOFMJbkFqLvjRNXyCSGSg=;
 b=G8NpnKLESe8GzoyxEMvGBND2KUDMbh/2by6dDiaRq9To/9iZbS/eAOM0HNSOfIr2GW
 dgTZ9IOaYSmZ0V/LOEQG2Y/5y3cn0sxk+EJonquTgEbRMEuVmxiX5FLiKKuEplCoQBL3
 eIaHMCCrRB/CEus72iQn0DKdJL6R7GjOD8/pvWrdOcCO4QVYBkzuNWXBtJXwPgIDko99
 yiYMEgZ6GF76cGyON+eGNk4bVpIVoKw9mTYHsydL8N3Sbnxg0w5+j0QDKPmci6SuR69b
 yh2LMjgBJNfLNGMjiK8YJhYKDd2XNkvHZtsrtCesqn3jBwMtA78BdqYP0mjn+qMxDgtb
 hgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705419161; x=1706023961;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJBSSWyyW4VDLC7/1CVasTkOFMJbkFqLvjRNXyCSGSg=;
 b=SJqf+8a+40xA5YPcarorZYNE8GmMGMueXWLWVr7zkTJYwomU0yLLbBaKSXZ5b99Cza
 UGVUji2kcc40vdXZZ5c5YQOXkwlr31QkrW89fM6xGOOM1FTWshLZgelvm2/tgjRjpH3d
 EUU4ODRhrZJs916FAmjrADvk09XV3G09oPmhVPZ9gB5NdpQKSa+CDHnAPA4Nfedi4fyE
 nRduEKU398E874XLYrebnmJwuFf2VJg8fVaXmqUps9AL9JWGOQuqZI2XA98jt7lr79fl
 XzDFgf1TH9n5GKiFG5opOpNnDM3CbkAgOhvq06ANv8hEGpjLeqegL9GL1K6SDf2vutgn
 QbTA==
X-Gm-Message-State: AOJu0YyANIy92lqQ1it6X/RnsShKlq/rLhrzJcgt70cZkL2/OjyK/p/Q
 Ps8uP50q1hav2d1yjQlrXIQ=
X-Google-Smtp-Source: AGHT+IHvFOjxZi9q815Jb7OGxgp8kkBXfcQ2AcqO1+mU7BH9ta5XAFszL/KaTDeck/En1L7qcV4vdg==
X-Received: by 2002:a17:90b:194e:b0:28e:7feb:f3b5 with SMTP id
 nk14-20020a17090b194e00b0028e7febf3b5mr630345pjb.95.1705419161285; 
 Tue, 16 Jan 2024 07:32:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a17090aec8700b0028e1d275201sm8092589pjy.46.2024.01.16.07.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 07:32:40 -0800 (PST)
Message-ID: <1fe9c72b-826c-4433-8f52-13034078ec94@roeck-us.net>
Date: Tue, 16 Jan 2024 07:32:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/arm: Add watchdog timer to Allwinner H40 and
 Bananapi board
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Li Guang <lig.fnst@cn.fujitsu.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20240115182757.1095012-1-linux@roeck-us.net>
 <20240115182757.1095012-4-linux@roeck-us.net>
 <7551e55e-89b3-40de-a3b4-60e158d00295@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <7551e55e-89b3-40de-a3b4-60e158d00295@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/16/24 02:04, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> (Cc'ing Li, Strahinja and Niek)
> 
> On 15/1/24 19:27, Guenter Roeck wrote:
>> Add watchdog timer support to Allwinner-H40 and Bananapi.
>> The watchdog timer is added as an overlay to the Timer
>> module memory map.
> 
> I'm confused by these registers from TYPE_AW_A10_PIT
> and the TYPE_AW_WDT implementation you are using:
> 
>    #define AW_A10_PIT_WDOG_CONTROL    0x90
>    #define AW_A10_PIT_WDOG_MODE       0x94
> 
> Do we have 2 implementations of the same peripheral?
> 

The watchdog core in A10 and H40 is the same. Linux devicetree uses
allwinner,sun4i-a10-wdt for several chips.

arch/arm/boot/dts/allwinner/sun4i-a10.dtsi:                     compatible = "allwinner,sun4i-a10-wdt";
arch/arm/boot/dts/allwinner/sun5i.dtsi:                 compatible = "allwinner,sun4i-a10-wdt";
arch/arm/boot/dts/allwinner/sun7i-a20.dtsi:                     compatible = "allwinner,sun4i-a10-wdt";
arch/arm/boot/dts/allwinner/sun8i-r40.dtsi:                     compatible = "allwinner,sun4i-a10-wdt";

> Should we instanciate AW_WDT within AW_A10_PIT?
> 


As far as I can see, AW_A10_PIT_WDOG_CONTROL and AW_A10_PIT_WDOG_MODE
are not really handled in hw/timer/allwinner-a10-pit.c because of the
memory range overlay,  and the defines might as well be dropped from there.
It made some sense to have them when the watchdog wasn't implemented
to avoid emulation errors, but afaics they are now obsolete.

The wdt type (TYPE_AW_WDT_SUN4I) more accurately reflects the watchdog
type. Control and mode registers are model specific. For example,
sun6i and sun9i use the same timer and watchdog cores but with
different register offsets and bit values for the watchdog registers.
sun8i uses the same watchdog core (and same register offsets) as
sun6i/sun9i, but the timer module itself is different. Implementing that
with the current model (using memory map overlays) is straightforward.
I don't know how one would do that from the timer modules; it seems
more complex to me than the current implementation.

On the other side, I don't know how the "proper" implementation in
qemu would look like, so I don't really have a strong opinion either
way.

Guenter


