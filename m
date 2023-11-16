Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB7D7EDBEE
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:26:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3WkY-0003sq-9i; Thu, 16 Nov 2023 02:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WkV-0003sT-Q7
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:25:15 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WkQ-0002Sh-KD
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:25:15 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32fadd4ad09so380321f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700119509; x=1700724309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Jw6fAaO8aPY2GrW3I/fm74DvqQUUQuYMx2Cw5e4KTA=;
 b=Cufaug0E2xulqxkUsQpg45Ta7gF1t+z7Z9KVKfAZH8VjdZ/ApDpOKjVEqRq4bZjvru
 sCZhlX97wmga5V+2fpA2SWfVyUwses35f+QMc0uALSH7BCSUWWENDlm58nQqyYSX2aD8
 8GtI/+4JUP2JEclLbM027fjpmy6ZB8/1EnYFnI2JYmZBmVgZOWNT0rNrn+29Z9oNGcx3
 +h2kVaRfT/Re+xEp1RCD2kvYxVx6jr7taHGvvFLNm8yASVzt+tv3p9KoCO3qWDX4+56M
 VqOtpIAfTCnsYEsL/R4MXo4YH3tSxznRGoRYy990nx13jcOiuz3qf+sJHy0DHy2YvNhg
 QVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700119509; x=1700724309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Jw6fAaO8aPY2GrW3I/fm74DvqQUUQuYMx2Cw5e4KTA=;
 b=ZxDyAh/SrsSu4OWDATaFV4vX3WKXyqlVsi4kBMP7zBUE3eDxKUjRBZS7WLfX26A5UE
 ZJVYPZVplJWfNFLnhdnUifxGRkrEWU0fPLUh3N5dsLssu1EG0f3gOiOefRbdp1xzUv6v
 8EctNtoWvWr96p2MLYLGfBhJiLpPTE2Bie+uhxmfiPkluWpoemK0ArWO5wNLVKPxbCc+
 8tqMtDFIKpkQ86IecWjvyxfWYM9Jr5vg/3DEubE9iYp74XUrrzzubyCwM/VKtuNjjfTo
 aLXs3MLD50IeaG6TWTbpqmSm8Pc+dNjpCuwWpo5xcfJ/0hAfHjb77Xqdf8yDJKeAO0jH
 +qoQ==
X-Gm-Message-State: AOJu0Yw60WMK3zHLEzwFbefhSUtCNQznfQyvUCTNQYYvnhO+iyBHmhaY
 /6f8NxBqz/ikPFkvPB6aUzBJSgxl8m0MNK5jUDg=
X-Google-Smtp-Source: AGHT+IEGkNcnVJpAJfXk+DEKOVMu5feZER/1++P3fn0HmeOuRZ2dKO9jAz5hZ1IvkU68Oq1QSrnupw==
X-Received: by 2002:a5d:47a8:0:b0:323:1d6a:3952 with SMTP id
 8-20020a5d47a8000000b003231d6a3952mr13133258wrb.4.1700119508660; 
 Wed, 15 Nov 2023 23:25:08 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a5d48c1000000b0032fdcbfb093sm12592668wrs.81.2023.11.15.23.25.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:25:08 -0800 (PST)
Message-ID: <bd08361d-cb43-4ee5-9fbc-534d1349c56c@linaro.org>
Date: Thu, 16 Nov 2023 08:25:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2? 3/6] hw/arm/stm32f100: Report error when
 incorrect CPU is used
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 Tyrone Ting <kfting@nuvoton.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Hao Wu <wuhaotsh@google.com>, Felipe Balbi <balbi@kernel.org>,
 Gavin Shan <gshan@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20231115232154.4515-1-philmd@linaro.org>
 <20231115232154.4515-4-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231115232154.4515-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 16/11/23 00:21, Philippe Mathieu-Daudé wrote:
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

With [2] from cover applied, this becomes:

      $ qemu-system-aarch64 -M stm32vldiscovery -cpu neoverse-n1 -S
      qemu-system-aarch64: Invalid CPU type: neoverse-n1
      The valid types are: cortex-m3

> Since the SoC family can only use Cortex-M3 CPUs, hard-code the
> CPU type name at the SoC level, removing the QOM property
> entirely.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/stm32f100_soc.h | 4 ----
>   hw/arm/stm32f100_soc.c         | 9 ++-------
>   hw/arm/stm32vldiscovery.c      | 7 ++++++-
>   3 files changed, 8 insertions(+), 12 deletions(-)

[2] 
https://lore.kernel.org/qemu-devel/20231114235628.534334-1-gshan@redhat.com/

