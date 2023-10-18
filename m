Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B22067CE66E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 20:28:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtBHD-0001OI-LO; Wed, 18 Oct 2023 14:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtBHB-0001Nc-76
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:28:13 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtBH9-0003NC-MK
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:28:12 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso10003062a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697653689; x=1698258489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Hl11SdGTTdqV3DJmyPPKr/uv6nwXeQ0MMtjVGcu1l8=;
 b=LPC/OO8aITWJmGKfiRNxXyqTYNjjEwgJ/aLKUSxhqCeRvcPQ708lynKh6SjpJL2JvJ
 tIeYW/k4vQxS60CtNpbM4LgIUmN8AOeKrAQEcJD2oPq2ClxKBDOh54FzPOeM00ME8bRK
 SPvucWAeEiCVVAUWTXrceAE3OFejmMNUCLsZyRkogGik5SuUpCYmuRuOYO7gItjDuFIl
 ic8fkV9XalKMjmuSzHLv2b4hh8rozgtccEEYPJLzeqxRalNUXo0VgJ+jjmREG6pneTmD
 D8vYZFlv+zKCC7q9yMqMo+Jk1ZDn/XrDgUmi/vWHE/0WwE8ZzTbuuOGKQES7dXTGAUk9
 MWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697653689; x=1698258489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Hl11SdGTTdqV3DJmyPPKr/uv6nwXeQ0MMtjVGcu1l8=;
 b=PbQ3VT6bHD5bU6zZoi8v9T+6pLBpr7COZQFN3zqwR5QIMjbcIp0yWrhqtufWlpt4J6
 KL2vIkVvTlL6Zeh72FABRvjmOgcaBfx+C8MtEFsMxYIE53lkOgOB5kLfS7jmK0YBsyf+
 NUCDJ8KYAX6D+nUDZ8BkXL62xEWDYlFCT2YYCnb+5uCtziA8WZ/9U2eGa64MFGuidGox
 6H1mDDTTnhu4O+5egNOxHZdxoJwaB1NTseToAzX4i+u0kXQzuwcciT4u4em9HUc9+0+Z
 m3YMWuk55aheD/1bX0IEzabdWRPotmRPF7C00buflYSlxbhvD3eq0KfhsX/hEzKwGYLi
 GZ0A==
X-Gm-Message-State: AOJu0Yw3KlZ2EhM200K2t2gFHyaSQf14HKfvlmFQrq7PobbvbExpGh06
 JTe0KM2H9kvORey8AUVMT3UtO0GdwEbuCLHjqMQ=
X-Google-Smtp-Source: AGHT+IEXrXDP0DJhZBcq8Cc/zj1+943/v31AdbNY4HF4mmhDEAC0rdEG1LUQadJFZ7bd62f2ZH8CTw==
X-Received: by 2002:a17:907:2ce3:b0:9be:cdca:dadb with SMTP id
 hz3-20020a1709072ce300b009becdcadadbmr49798ejc.69.1697653689485; 
 Wed, 18 Oct 2023 11:28:09 -0700 (PDT)
Received: from [192.168.69.115]
 (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr. [176.171.218.149])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a170906081000b009c4cb1553edsm2159466ejd.95.2023.10.18.11.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 11:28:09 -0700 (PDT)
Message-ID: <fdb42676-148c-1c40-c3e2-cfe34432030f@linaro.org>
Date: Wed, 18 Oct 2023 20:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/6] hw/ppc: SysBus simplifications
Content-Language: en-US
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org
References: <20231018133059.85765-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231018133059.85765-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/10/23 15:30, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> There is no point in exposing an internal MMIO region via
> SysBus and directly mapping it in the very same device.
> 
> This series replaces a sequence of:
> - sysbus_init_mmio()
> - sysbus_mmio_map()
> by a single call to memory_region_add_subregion().
> 
> Philippe Mathieu-Daudé (6):
>    hw/ppc/pnv_xscom: Rename pnv_xscom_realize(Error **) ->
>      pnv_xscom_init()
>    hw/ppc/pnv_xscom: Move sysbus_mmio_map() call within pnv_xscom_init()
>    hw/ppc/pnv_xscom: Do not use SysBus API to map local MMIO region
>    hw/ppc/pnv: Do not use SysBus API to map local MMIO region
>    hw/intc/spapr_xive: Move sysbus_init_mmio() calls around
>    hw/intc/spapr_xive: Do not use SysBus API to map local MMIO region

Cc'ing Thomas :)

