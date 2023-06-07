Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8BA7256C3
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:04:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6o8n-0005Zn-4R; Wed, 07 Jun 2023 04:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6o8k-0005Zd-51
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:03:34 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6o8g-0006LX-W1
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:03:32 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30d5931d17aso3368181f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686125009; x=1688717009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ct3JIswcecrwK+aoODAksT9EVs/LVCbsE0rCzhYImmE=;
 b=T8HDrmClAfD+AHOevMDpmYwFWjovhjggx6DO5mWsLrxwPy1oUNv/R95EPyMDX2AzxX
 tEeGMagurqE9rQuV/D9g/YRM0TPmYU369Qb8viuqcLRKO2rlwh87jni3dF560NpaExCs
 pV9nTenuTe/di8EdqlG+/s/AXfWIbEEzwZMMIrsJ/Zh0WAqo37mqrTWWsOmh07ZcEfkm
 pn0I0zL3m6FwPMmZahJu5OHcn7eJdegMF0jZQcdFZ/h0o3u/STsrgMWXnAgIXCtWE9m4
 E7YFFSNIZosqrj8mNChldShJuZeYRka1qbn6mPGlapMrtrTsbEkOxsxvOK/UafvAHWuK
 LtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686125009; x=1688717009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ct3JIswcecrwK+aoODAksT9EVs/LVCbsE0rCzhYImmE=;
 b=jqIFKkBTmw9jiSDJiy7gvmGh+dpUz093R/YBcy/KPgkgpo4QWnVVHwgxFlIzl0mJq8
 ZOaaX9aHwonOsVBA00O+hhSCVoNbxgtTmgciWlahcrJIJN1y5GLlu1NQH4nls8fit7H1
 REwA3vd80swu86KCehxyzyqwsZC0F6N0PF+xrL3ZIbxaNtqARjUNhgAa/GB+ByHveDve
 U0i/xuOPcECgWQKzHxUkYsXfSqB+JFQ/ekcGHhbXK/bomTJrYHwAVNaWE2rXgSnE11tx
 bCpjUQ0juEryKngAWhSjiIs8edoz7Es2uvsESCaOopi1gJsHA9pBo06CZldO26Y8eyi2
 ATfQ==
X-Gm-Message-State: AC+VfDxqjZ6UUIpx9nS9sCbUQdf3fJhHDmgaVbdOizzakE/rjRfNADw6
 GPjOweAQBI30i/0a49Du1qs/lA==
X-Google-Smtp-Source: ACHHUZ7KwxKgmTHY1kLWqw55GEXQe1bsnu8XKOkmT19qSv/YeAIy5EDFwBKJY2Uk3XI6uUUacUyVGA==
X-Received: by 2002:adf:ea8a:0:b0:30e:3d2a:192e with SMTP id
 s10-20020adfea8a000000b0030e3d2a192emr4044145wrm.7.1686125009217; 
 Wed, 07 Jun 2023 01:03:29 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 w6-20020a5d6806000000b0030630de6fbdsm14642533wru.13.2023.06.07.01.03.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 01:03:28 -0700 (PDT)
Message-ID: <fd52c2c3-92dc-34ad-c969-189943fc9c19@linaro.org>
Date: Wed, 7 Jun 2023 10:03:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v5 1/3] hw/i386/pc: Refactor logic to set SMBIOS defaults
Content-Language: en-US
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, imammedo@redhat.com,
 berrange@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
References: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
 <20230607024939.703991-2-suravee.suthikulpanit@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230607024939.703991-2-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/6/23 04:49, Suravee Suthikulpanit wrote:

"Refactor logic to set SMBIOS defaults"

> Into a helper function pc_machine_init_smbios() in preparation for
> subsequent code to upgrade default SMBIOS entry point type.
> 
> Then, call the helper function from the pc_machine_initfn() to eliminate
> duplicate code in pc_q35.c and pc_pixx.c. However, this changes the
> ordering of when the smbios_set_defaults() is called to before
> pc_machine_set_smbios_ep() (i.e. before handling the user specified
> QEMU option "-M ...,smbios-entry-point-type=[32|64]" to override
> the default type.)
> 
> Therefore, also call the helper function in pc_machine_set_smbios_ep()
> to update the defaults.
> 
> There is no functional change.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   hw/i386/pc.c      | 24 +++++++++++++++++++++++-
>   hw/i386/pc_piix.c |  9 ---------
>   hw/i386/pc_q35.c  |  8 --------
>   3 files changed, 23 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


