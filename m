Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D61787F0CB1
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 08:17:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4yW9-0005jB-Je; Mon, 20 Nov 2023 02:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r4yW7-0005i9-SP
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 02:16:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r4yW6-0004JG-47
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 02:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700464581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orkFtJ4lDkQFQ2lzWrpbQFx7qZ9pgHqFdGDUVIMlrB0=;
 b=R+hN8mqqSUac1MiiSz3B2WwgVzm5IHrxLlwOXKX5oHji3x1A7AeGcA6n5uGwO/Ec5bv+wA
 tfFeitJggFABAUFxmLK6LMU+xmFz8a6a/tTwwZfSE1V/C0vWIf7sfDZtSH7Si9dbCY0mah
 bsx8HWPVr6Mt3LJMBGwwTouAmYMnu/Q=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-iCbSRjgmMvifNZyHBOVJNw-1; Mon, 20 Nov 2023 02:16:19 -0500
X-MC-Unique: iCbSRjgmMvifNZyHBOVJNw-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1cc252cbde2so45874805ad.0
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 23:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700464578; x=1701069378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=orkFtJ4lDkQFQ2lzWrpbQFx7qZ9pgHqFdGDUVIMlrB0=;
 b=nffS0NrXgTxBshDYPPF47PqjS3LK9gc8ZTqEdPLxakWfOF6IaC0uULcRRMUmb5i/CH
 y11BR8JJ8C3asD6W6cGkRjmPUMsY813UjrPPX2UBG4Vtw6N0E5E0a4XNmmDAteKJoNaP
 7fNcUHXyOWo3yvka77BClNHrgqCgbTanQ4/cIymQ1Bi343+Zi0EOOuSbVYXBn40yx1NG
 BGc/FFY8rTV0M4SWc6sNeM8T66xi4QazjpKrBqYy9fTL0xIBILiRuW2hJ9dWnd/q6VXc
 dJ4FTOOK9HxzTwkqWvfe5obvYhrDN4xyzXwHdSWjIG+VZe8W/uC7fkGiiACVyQ+1Zrim
 OPzQ==
X-Gm-Message-State: AOJu0Yz5WjDqyFigAzkp9jS/Wlq0hjBLIxHUI5DqOOL3faO76W2Nhfyo
 LrzfZfxxBVPaUayrP4IesFtaSaepG/HEJ4vvTwWqJZfpmpZ8C0wbHl5HWN02Ro5KFnRlU66o5Nm
 MP4LzE2J7xwvxO0I=
X-Received: by 2002:a17:902:f54c:b0:1cc:7d96:3fe7 with SMTP id
 h12-20020a170902f54c00b001cc7d963fe7mr5755017plf.28.1700464578254; 
 Sun, 19 Nov 2023 23:16:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcWH4A2KTimHFfoaB10wqleJ6x8e3QQiyewH4tB/npYSLfCAGVq3q27BreykfMgIZudWRdWQ==
X-Received: by 2002:a17:902:f54c:b0:1cc:7d96:3fe7 with SMTP id
 h12-20020a170902f54c00b001cc7d963fe7mr5755006plf.28.1700464577943; 
 Sun, 19 Nov 2023 23:16:17 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15?
 ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170902d50b00b001cf66056a1bsm434487plg.97.2023.11.19.23.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Nov 2023 23:16:17 -0800 (PST)
Message-ID: <8cb8cbc1-29da-4b32-b23b-2caa4f75f20f@redhat.com>
Date: Mon, 20 Nov 2023 17:16:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2? v2 2/4] hw/arm/stm32f405: Report error when
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
 <20231117071704.35040-3-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231117071704.35040-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> Both 'netduinoplus2' and 'olimex-stm32-h405' machines ignore the
> CPU type requested by the command line. This might confuse users,
> since the following will create a machine with a Cortex-M4 CPU:
> 
>    $ qemu-system-aarch64 -M netduinoplus2 -cpu cortex-r5f
> 
> Set the MachineClass::valid_cpu_types field (introduced in commit
> c9cf636d48 "machine: Add a valid_cpu_types property").
> Remove the now unused MachineClass::default_cpu_type field.
> 
> We now get:
> 
>    $ qemu-system-aarch64 -M netduinoplus2 -cpu cortex-r5f
>    qemu-system-aarch64: Invalid CPU type: cortex-r5f-arm-cpu
>    The valid types are: cortex-m4-arm-cpu
> 
> Since the SoC family can only use Cortex-M4 CPUs, hard-code the
> CPU type name at the SoC level, removing the QOM property
> entirely.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/stm32f405_soc.h | 4 ----
>   hw/arm/netduinoplus2.c         | 7 ++++++-
>   hw/arm/olimex-stm32-h405.c     | 8 ++++++--
>   hw/arm/stm32f405_soc.c         | 8 +-------
>   4 files changed, 13 insertions(+), 14 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


