Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F44B73F87B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4m2-000594-Mr; Tue, 27 Jun 2023 05:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4m0-00057e-PG
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:14:08 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4lz-0003YC-8a
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:14:08 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b6a084a34cso30783061fa.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687857245; x=1690449245;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7BM7ddDrVGZTFkRLT9uvbnAay1jMHkAtl02XJ+qL1L4=;
 b=N8YFhh6Qjmbo6C5bxzb6ptAOTEAhqvZTc6779Ywl51jEpMs+yPDaU4eeL5vMUkVV4b
 Drck3/bDpSGsuwC927he2v7+dpfiobceW3NY6xN4uEqKAUKteBX21iWcXYBm+0ZPZY3d
 wV6JNmpm4IL4+zJhEg6MFkYd524I+VJgrbWEL/jp3gcb2DuIgaWI09JrqP2emeYPSlDO
 VBu3GR9IojNQtXzM+C4RrbX6p2aF9IviCAs5r3WpjFTLxOFkdYglrmq6SbqbC4yyXDtE
 oHCrvSPyha/nGgltmu88fuhCM3QRZ40RuBPMdxQbCs0hb5XYiIwDW8cLoX8e6NoLNRIp
 BQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687857245; x=1690449245;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7BM7ddDrVGZTFkRLT9uvbnAay1jMHkAtl02XJ+qL1L4=;
 b=M/Mhp0Gy1l/YNRGybLbgnh+nT2iJcIgL5HX0yMzaguPzGzn6XbEnOU87tUSwaoMWuw
 Ku4udwavTlF5u8jm//tcrbFToU/db+b96ndGxYubIplZPMBwu18kSvo+19A0seklkKMS
 nzjpKtoCuRChx9ECQmpn1EtEAK1CmX4+Go3HyUSiBeOt3KM9pQGfbtVF3VSr/teLWpi9
 CPUbqxajHdIiDRK/TY4NL3QVKAbgKaiVKFuzCL0AF9Qx74LL/zQo47do0Vm2ryzay0pt
 ynCQAXSBsn3N2HUy8rxabcTxQXk60scp0ZQtBKuu6X2rmgF0MWo1JrBXcAzrU19r6clE
 uWiQ==
X-Gm-Message-State: AC+VfDzoe91XSuiRPCxngmn3+wkLFcphxLBx83Guli+oPt3NZabFHezF
 xerMaFwX8brDOIy3DjpxlvymMFkKv965dixmokA=
X-Google-Smtp-Source: ACHHUZ5anxAnNN30k7FLbgXrP4WCpeOpfwbdAEzlB5Qt5VuEZZ3oZwL8eUGd7S8tXtiJple9ZpJu6Q==
X-Received: by 2002:a2e:b003:0:b0:2b4:5c50:c4f5 with SMTP id
 y3-20020a2eb003000000b002b45c50c4f5mr18406738ljk.52.1687857243809; 
 Tue, 27 Jun 2023 02:14:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 v2-20020aa7d9c2000000b0051bee925ca7sm3653468eds.34.2023.06.27.02.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 02:14:03 -0700 (PDT)
Message-ID: <511457be-fa9b-bcfc-447d-bb79f7873a55@linaro.org>
Date: Tue, 27 Jun 2023 11:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] pc-bios/s390-ccw: Provide space for initial stack
 frame in start.S
Content-Language: en-US
To: Marc Hartmayer <mhartmay@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 mrezanin@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-3-thuth@redhat.com>
 <877crp9uq9.fsf@li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <877crp9uq9.fsf@li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 27/6/23 10:26, Marc Hartmayer wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> Providing the space of a stack frame is the duty of the caller,
>> so we should reserve 160 bytes before jumping into the main function.
>> Otherwise the main() function might write past the stack array.
>>
>> While we're at it, add a proper STACK_SIZE macro for the stack size
>> instead of using magic numbers (this is also required for the following
>> patch).
>>
>> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   pc-bios/s390-ccw/start.S | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)


>> +#define STACK_SIZE 0x8000
>> +
>>       .globl _start
>>   _start:
>>   
>> -    larl    %r15,stack + 0x8000     /* Set up stack */
>> +    larl    %r15,stack + STACK_SIZE - 160   /* Set up stack */
>                                           ^^^
>                                           You can also add a macro for this
>                                           - e.g. STACK_FRAME_SIZE.

Yes please :) No need to respin.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Besides that,
> Reviewed-by: Marc Hartmayer <mhartmay@linux.ibm.com>
=

