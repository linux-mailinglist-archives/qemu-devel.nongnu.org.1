Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50882725733
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:16:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6oKM-0003il-MO; Wed, 07 Jun 2023 04:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6oK7-0003gc-TC
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:15:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6oK6-0000Jc-6X
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:15:19 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30c4c1fd511so5821739f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 01:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686125716; x=1688717716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j04NOYjlt7/1FGIApL9DrWzcV+mMrudQL/7JVcSsYzQ=;
 b=v4YZwqQWh991QrLoCxJ099jlMH3+0zM77lPFcIx+PlWLTjFrmpyEe77fkzEKn2YzVi
 FRYGrVF97xZgaQftMP+s5tTwj/XE5i5t49Mz+5uVx03v8sUFoyQDLozYvWO2BI6hmZc8
 r0jVkveaZCaydN3MXuJvRfOp35H+3wRM489046pYkSLxgs07tFKqQk1m1vI4u/UwriG2
 iO3by4saqQe7Bgii2BymhXVxnardSXL/8PVN3lqv1jATJEhQnUEq59l4ANwyYCilYNHq
 jbdjwMfGoc3f6PsjIQ8G1z8Rq3pSkGZXOVjYaB8Jq+wn3GJa2u6Vf6YImhT74Gn2NTiR
 gKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686125716; x=1688717716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j04NOYjlt7/1FGIApL9DrWzcV+mMrudQL/7JVcSsYzQ=;
 b=OraJvKC0MPnzPSiH6eg5cAg2dwmL4uwNoBTBMb9dFOeD536ZAhotHeHUTiaN/O6Fmz
 dH2KwBGzf9zsAYLUC+9yvfHD78TEc6GqKS0QBNmlye4kVH9mhmb+Wsx7aZA2tfIhDSv4
 SyGr+kuYprzg6EPVGaCaRZc/lm3ebZ3zCf1j0AM5U1UYqzk4qX9wwX4zarM5lOLkttbw
 yWJed6jc18XRdYr9rdwZbm+rM/ghaXe8+P/oKjjC36hzcWoz+Oo85yx4vL6/aTU7s/kb
 rDq/tX0an/kLL6YeQOC3KQMuwRsK5STdhsGkH3GfCOv33M/rPKlgRzFVFP+M1VL/vGn5
 LqQg==
X-Gm-Message-State: AC+VfDx46IGuvFB2UbYjtgshPbW6Q+xYlc00E8UhjuS/30zslTSR3TPc
 +/MWOBw6JFhV36Hh6FIzi5oMrw==
X-Google-Smtp-Source: ACHHUZ56hDGk7dW07lQiRH2dwhY8Fpm8+vlvIoPLQQW9PMGk7E8dfUlQdD3Qo7O+m570mn35wEpWuA==
X-Received: by 2002:adf:fa8d:0:b0:309:e24:57b3 with SMTP id
 h13-20020adffa8d000000b003090e2457b3mr5922244wrr.4.1686125716255; 
 Wed, 07 Jun 2023 01:15:16 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4206000000b003063772a55bsm14634409wrq.61.2023.06.07.01.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 01:15:15 -0700 (PDT)
Message-ID: <cd5d75fb-4df9-5ef1-0abe-4dcad2babf2a@linaro.org>
Date: Wed, 7 Jun 2023 10:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v5 1/3] hw/i386/pc: Refactor logic to set SMBIOS defaults
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 imammedo@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
References: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
 <20230607024939.703991-2-suravee.suthikulpanit@amd.com>
 <ZIA7x5cYNr99mhzd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZIA7x5cYNr99mhzd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 7/6/23 10:11, Daniel P. Berrangé wrote:
> On Tue, Jun 06, 2023 at 09:49:37PM -0500, Suravee Suthikulpanit wrote:
>> Into a helper function pc_machine_init_smbios() in preparation for
>> subsequent code to upgrade default SMBIOS entry point type.
>>
>> Then, call the helper function from the pc_machine_initfn() to eliminate
>> duplicate code in pc_q35.c and pc_pixx.c. However, this changes the
>> ordering of when the smbios_set_defaults() is called to before
>> pc_machine_set_smbios_ep() (i.e. before handling the user specified
>> QEMU option "-M ...,smbios-entry-point-type=[32|64]" to override
>> the default type.)
>>
>> Therefore, also call the helper function in pc_machine_set_smbios_ep()
>> to update the defaults.
> 
> This is unsafe - smbios_set_defaults is only intended to be called
> once. Calling it twice leads to a SEGV due to double-free
> 
> $  ./build/qemu-system-x86_64 -machine pc,smbios-entry-point-type=64 -smbios file=/tmp/smbios_entry_point
> Segmentation fault (core dumped)

Doh, good catch.

> IMHO we should just not do this refactoring. The existing duplicated
> code is not a significant burden, and thus is better than having to
> workaround calling pc_machine_set_smbios_ep too early in startup.
> 
>>
>> There is no functional change.

I was too confident because of this line ...

>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   hw/i386/pc.c      | 24 +++++++++++++++++++++++-
>>   hw/i386/pc_piix.c |  9 ---------
>>   hw/i386/pc_q35.c  |  8 --------
>>   3 files changed, 23 insertions(+), 18 deletions(-)


