Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B39BB77D0F7
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 19:27:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVxne-0001PU-9P; Tue, 15 Aug 2023 13:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qVxna-0001Nr-2f
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 13:25:43 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qVxnX-0000fV-TL
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 13:25:41 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6b9cf1997c4so4740451a34.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692120339; x=1692725139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+ab2tKRytgAcGbCViLFMFQmDKryN5jQqnJc6OzJ8RQ=;
 b=HNecEvZPdAlbmSGcYcXum3KQ7dLTf3iJ3M3N9AKVEFNqe6t1u1oAFTOJsWR0mwwmiz
 V81z+6HCitkK34evzMC2VRM4Cznqe0vr3vfMuZNhHm9SH63OGkuDdvSMhPdwmMW/mFGI
 Ic0OBkEF5JPNSp5PAyqKpSiffq0lLbWlLG308BM038PeGl4nQmK48zdIvqa+YEoWIjuG
 QXE8UDLVp6XcyKzsPNaXSyxw6MtpL48hs7DiaJ9FxAGFANaxgqp7haab7uHgDcYoEE7G
 o6i/JoHb18glQFvuioL+mI4qCd7zM9cTD/NnJrAlNyfNUBdXvFz/FwxH8l5lgIXVE/tw
 BTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692120339; x=1692725139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H+ab2tKRytgAcGbCViLFMFQmDKryN5jQqnJc6OzJ8RQ=;
 b=UM+BWyvMKF2zaLOFLvFkzcNFgKLSqMc19yZD5g8vCyjl6/AoE5/KjVKT/qgT5Kyt1D
 XZxoQnA5kdqgowVX78G19U9DHrNuDOPoUYMI87FqTkJ/xVVnydA6/T1yd6UbMo4o0czQ
 UVzzgudvaR/ta8P2Nk9606eeArWaBSDrs4U6od5kh9wtrB+6KWFaVjdCjy5/e5+vgyRH
 mdh8X8XQMikoMlvJQzTkBiwUwYaxJr87zBkNEYSQCZIfNKji3wkFXiyKwq3E/B7Scckd
 NFgCQLUs7WbxDTk6iRhYBGSiZwZsW6p3/Q2vxn8KfSgmsmMk3TO39zvyQNV56wef+tX0
 a0sQ==
X-Gm-Message-State: AOJu0YytsPjqlS/MgYMNggwrX0UOGlYNBnUjgWBq76qPDAkUCTqnUd2w
 G7i6SYjcBLdB5FGio0s18MG2YAFjBAIcr8IWdz0=
X-Google-Smtp-Source: AGHT+IFrOAbhIT+BXBgCMxkgc1AttpRwbQ3P2OSM4bzpphWu1PPfS9TbGuFuScATB07/QcZQky6zwQ==
X-Received: by 2002:a05:6830:14c6:b0:6ba:a084:6a1b with SMTP id
 t6-20020a05683014c600b006baa0846a1bmr11434814otq.10.1692120338798; 
 Tue, 15 Aug 2023 10:25:38 -0700 (PDT)
Received: from [192.168.68.108] (189-69-160-189.dial-up.telesp.net.br.
 [189.69.160.189]) by smtp.gmail.com with ESMTPSA id
 v11-20020a05683018cb00b006b75242d6c3sm5350945ote.38.2023.08.15.10.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 10:25:38 -0700 (PDT)
Message-ID: <434598e2-51bf-75d5-c8e4-1bbf704ba52b@ventanamicro.com>
Date: Tue, 15 Aug 2023 14:25:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 04/12] target/riscv/cpu.c: del
 DEFINE_PROP_END_OF_LIST() from riscv_cpu_extensions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20230727220927.62950-1-dbarboza@ventanamicro.com>
 <20230727220927.62950-5-dbarboza@ventanamicro.com>
 <CAKmqyKMkWbg5iFOOqgiaT_J6+FCUr9gpQS9HV90kZeGwPeioPg@mail.gmail.com>
 <0013e3ed-75ba-1806-45d5-6ca7c00ee917@ventanamicro.com>
 <CAFEAcA8NKafY0pdHEmJNDavSNw9P=+sO1zGaSbviL1v5oJ2Trw@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAFEAcA8NKafY0pdHEmJNDavSNw9P=+sO1zGaSbviL1v5oJ2Trw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.045,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 8/15/23 10:15, Peter Maydell wrote:
> On Tue, 15 Aug 2023 at 13:44, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>>
>>
>> On 8/10/23 14:49, Alistair Francis wrote:
>>> On Thu, Jul 27, 2023 at 6:20 PM Daniel Henrique Barboza
>>> <dbarboza@ventanamicro.com> wrote:
>>>>
>>>> This last blank element is used by the 'for' loop to check if a property
>>>> has a valid name.
>>>>
>>>> Remove it and use ARRAY_SIZE() instead like riscv_cpu_options is already
>>>> using. All future arrays will also do the same and we'll able to
>>>> encapsulate more repetitions in macros later on.
>>>
>>> Is this the right approach? This seem different to the rest of QEMU
>>
>> I am not sure if we have a 'right approach' in this case or not. I see both
>> being used in QEMU.
> 
> The major use of the DEFINE_PROP_* macros is for creating
> a property list to pass to device_class_set_props(). Those
> lists must be terminated with the DEFINE_PROP_END_OF_LIST()
> marker (because the function takes a pointer and can't tell
> the size of the list with ARRAY_SIZE()). For cases like this
> where you're writing code locally to manually iterate through
> the array and never pass it to any other code in QEMU, both
> approaches work. But it does seem to me a little confusing
> to have a non-terminated property array.

Thanks for the explanation. Having a non-terminated property array is another
reason to revisit this patch.


Thanks,

Daniel

> 
> thanks
> -- PMM

