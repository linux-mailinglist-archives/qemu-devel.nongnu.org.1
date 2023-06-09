Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD6D72A5BE
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 23:59:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7k7E-0002vC-0G; Fri, 09 Jun 2023 17:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7k73-0002uP-V6
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 17:57:42 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7k72-0006jm-7H
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 17:57:41 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f736e0c9b1so23189045e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686347846; x=1688939846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o0YO+kU+Ce5n7LnophaKVpJ9I/hceZ6c+k1doJVs1eQ=;
 b=y5PQ39pOXIdkhN6xzkIy4ZuVE2+RrJLXa/Za/zA62a8HvOYMMvrVdk1NBsDq27uhvs
 K7R3d3Q/bEr1bQROE6FWpkJ3rg0g6v85AyzwNTNgsp2PogOA7MrgYtZk5qDH6+ETz3lu
 f8ndQ7bWEAaJnVwKUcMkI7ioPvaIFA0lTxl4z1VqH9A8X4mve0ozkFqqPjnIexB+tzzE
 PeoAkdTclhGsPNJjd1sd+CIYFyhTogPsUC3CK1LV8R2lD6sLnGkvM/NEH/8VKomFvLgn
 CxX7lr6hcCJrN4+9QsS2MEBYOYQ6BTlsNzhvkfzI1V7MmLKv2TE+6HtYdpvuXdl5LyYv
 OXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686347846; x=1688939846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o0YO+kU+Ce5n7LnophaKVpJ9I/hceZ6c+k1doJVs1eQ=;
 b=FKVxqrhoBRWElcjJnBVJtIZubTcQ2JtkPk9Kf2wcVrvaFJFukE8Lvt80Yj+JjvFE1q
 6F3tEzljZRt4d8zXzFEt1BhVOy1nl59LUGtC5rW8nbnHuyMK+GPxClpEVQCuijgUk5r2
 5//XwKxkPISXWOom1F5A6ShFOQvEqivpFxMYtH/UR3M9fBwXhc/WNhj49mG9uH2jfBFO
 9Rxzlrk4BUV4UDNyuOjwgPIi9Bj1QhxQGrsp9P9tqQ4gt2Sgc8v8alX4AAcBKxtXCf9S
 prbRqsVeNRiT5aaImU4btJiBkN6jaHQU63pR6N2WXl0Pu3X13lH+MqVAJpbtzl2ufG/U
 c/VA==
X-Gm-Message-State: AC+VfDzqSpV58rtvj6tcqbG5C70SK3dkfld/0V/TMQP7hsUA+oQhVm9i
 /6Nb8DfqUid47wbeeNQ4CZeJhg==
X-Google-Smtp-Source: ACHHUZ7APQybDbAdusLExnSbZ4lWrUU9HjBkY4E3Fesb/s0TfF9CXPSOmTpbqlFrjfbsdmkRPm/pCg==
X-Received: by 2002:a1c:7c0e:0:b0:3f6:3bd:77dc with SMTP id
 x14-20020a1c7c0e000000b003f603bd77dcmr2035623wmc.23.1686347845707; 
 Fri, 09 Jun 2023 14:57:25 -0700 (PDT)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c230800b003f7ed9dae70sm3864416wmo.0.2023.06.09.14.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 14:57:25 -0700 (PDT)
Message-ID: <eee9de62-0a9d-c9b4-c749-29bd87343680@linaro.org>
Date: Fri, 9 Jun 2023 23:57:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] hw/i386/pc: Clean up pc_machine_initfn
Content-Language: en-US
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, imammedo@redhat.com,
 jon.grimm@amd.com, santosh.Shukla@amd.com
References: <20230609164107.23404-1-suravee.suthikulpanit@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609164107.23404-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 9/6/23 18:41, Suravee Suthikulpanit wrote:
> To use the newly introduced PC machine class local variable.
> 
> Suggedted-by: Igor Mammedov <imammedo@redhat.com>

"Suggested-by"

> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   hw/i386/pc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 33ffb03a32..f8d105e829 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1864,7 +1864,7 @@ static void pc_machine_initfn(Object *obj)
>       pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
>   
>       /* acpi build is enabled by default if machine supports it */
> -    pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
> +    pcms->acpi_build_enabled = pcmc->has_acpi_build;
>       pcms->smbus_enabled = true;
>       pcms->sata_enabled = true;
>       pcms->i8042_enabled = true;


