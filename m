Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0B174B7A0
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:07:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHrj1-0008Df-50; Fri, 07 Jul 2023 16:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHriw-0008DT-7s
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:06:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHrir-00079N-Hz
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:06:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so25405005e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688760391; x=1691352391;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WZUfSRzxF/vjBjo/51juxiCNYS2KSmG1SOOw+K+nlCk=;
 b=hJEooYa9WwK3ZbDFq7JwkFxA+vhU8zucHClW+lYs7zfwcJBkMSQECx/E4HnhG+rVGj
 ahVRzg9whd7+D0Ungr9b0j7+hf1gDlYOSUOode1FlwB7WvmykfyuwNB8nwlD6eOXNF0V
 StxX+/lbEnBU99gtsNl7+zLagW7N0ZLA1ZtMZV3x5UCFi6JJFDm4fr5JqdcITdIZEoi2
 HBjyij4yiVRk2Op3T/Q4ZGb5XvBAsTkD34/TMgGblmYY/gwU5BjNJG80zIx0A1xANmKm
 0X3t1t8OpQS95lNfHiJZnhUlrkOIElGFLrlQLKtnmJvuavFdLngTfKMx+HZ7DW5XeO9S
 IA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688760391; x=1691352391;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WZUfSRzxF/vjBjo/51juxiCNYS2KSmG1SOOw+K+nlCk=;
 b=Hf7K33w0zIwMVhirZqVToM+CioZ08FoOmIyI2vVj/Wg+QYuIvL87A9xALPY00xXIQw
 nV0gliYmJYBGcyntRdVrJiyBl5H9Mc956xq6dG5b7q/5DtJtZNzb+qg6cDze6LNT/02K
 jD5zRiHvw0A7tRkLaS8mqfhrn1jiixnbq0AddD/uePf0k+UihZkto3O+oP4l6RLLKtKf
 tUJGH3Uk438uZ8FwwHp/F2woI4U+oldJy7ubGvdK4guTuGGpB3C8oph4oOuoHCEt0wxw
 zfsYu74VBOz3jz205HsYEjUlECDo6j3a5K2TsqjHu/0hvetGutRSlGFDSbWPm281jWNs
 qo/Q==
X-Gm-Message-State: ABy/qLb78wUMQPuvc9dYVmRdOUnf6XljEZ0RnMv6GgwKqsBlz2B97/WO
 GY9sKLsyshfDX0D6MpBbuEZlVg==
X-Google-Smtp-Source: APBJJlFml2RCUidL7PpbZZTZfXXyRfgUQYQsRAkKybwnq4mC1TMnma9OauyJH+ZTERG5WNuHYgTu7g==
X-Received: by 2002:a05:600c:22cf:b0:3fa:96ad:5d2e with SMTP id
 15-20020a05600c22cf00b003fa96ad5d2emr5177867wmg.19.1688760390710; 
 Fri, 07 Jul 2023 13:06:30 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a7bc354000000b003fbb8c7c799sm3309262wmj.30.2023.07.07.13.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 13:06:30 -0700 (PDT)
Message-ID: <9f3ffcdb-b685-6d73-51f3-efa5000c462b@linaro.org>
Date: Fri, 7 Jul 2023 21:06:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] linux-user: Fix mmap2() syscall on 32-bit targets to
 allow file mapping beyond 4GB
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <20230707131928.89500-1-deller@gmx.de>
 <20230707131928.89500-4-deller@gmx.de>
 <1147c41d-3bcc-eadf-f625-819caa349e97@linaro.org>
 <74be0ddd-b0f3-8fd3-8953-1595571db96f@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <74be0ddd-b0f3-8fd3-8953-1595571db96f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/7/23 21:04, Helge Deller wrote:
> On 7/7/23 21:47, Richard Henderson wrote:
>> On 7/7/23 14:19, Helge Deller wrote:
>>> The mmap2() syscall allows 32-bit guests to specify the offset into a
>>> file in page units (instead of bytes, as done by mmap(2)).
>>> On physical machines this allows 32-bit applications to map such parts
>>> of large files which are stored beyond the 4GB limit.
>>>
>>> Allow the same behaviour when emulating 32-bit guests with qemu.
>>>
>>> For that switch the mmap2() function to always take an abi_ullong
>>> (64-bit) offset parameter for target_mmap() and mmap_frag() to avoid an
>>> arithmetical overflow when shifing a 32-bit offset parameter by
>>> 12 bits (=PAGE_SHIFT) and thus possibly overflow the abi_ulong (32-bit)
>>> type.
>>>
>>> Signed-off-by: Helge Deller<deller@gmx.de>
>>> ---
>>>   linux-user/mmap.c      | 9 +++++----
>>>   linux-user/syscall.c   | 2 +-
>>>   linux-user/user-mmap.h | 2 +-
>>>   3 files changed, 7 insertions(+), 6 deletions(-)
>>
>> https://patchew.org/QEMU/20230630132159.376995-1-richard.henderson@linaro.org/20230630132159.376995-12-richard.henderson@linaro.org/
>>
>> Wherein I use the host off_t (which must be 64-bits).
> 
> I like your patch.
> But wouldn't it be better to use off64_t instead of off_t just to make
> clear that this is a 64bit int?

No, I don't think so.  That's the point of _FILE_OFFSET_BITS=64.

> And this part:
> -                          arg5, arg6 << MMAP_SHIFT);
> +                          arg5, (off_t)(abi_ulong)arg6 << MMAP_SHIFT);
> maybe should become (with brackets): ?
> +                          arg5, ((off64_t)(abi_ulong)arg6) << MMAP_SHIFT);

Why would you add useless parenthesis?
At some point everyone should know C operator precedence...


r~

