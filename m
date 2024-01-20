Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA73C833669
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 22:26:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRIqF-0008MK-1D; Sat, 20 Jan 2024 16:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRIqD-0008Lv-4p
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 16:25:25 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRIqB-0008Kb-AP
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 16:25:24 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6dbb26ec1deso2154826b3a.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 13:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705785921; x=1706390721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l1+H9QnDj9pwOeW1CW1SYa1aRNgjzXYFyHJ5yW/WDww=;
 b=NHHwWcWnLSKllz7EADOrHyCBel2oZjunKbdZzLRbklzdUzunckJrsARNI2SPBTQULh
 iWH+s2gjrY+z+nuI2cepiTlcoFACobDz2dewKYfehEeBUWr1L5xjFSmgxXOqx1mTIY2f
 CXG8YRruZRLWpEcbp71dT35V7eObRY3REzKrTSomPAFqaWs/Y9rPm6/unBNRa47xrB5P
 XCdfsb9CgOZ0x4+zDeub5w0BNMWF/MDZK8ASLwJyG5M/irIojh5dBVKGm4ge4VZmPhnT
 To244Qz9YCu+UavwKohzKwbF6H0Zn8EMtedUjeNldZmXLNvbUJqvCdFUGUAQq3QH7Hts
 2HaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705785921; x=1706390721;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l1+H9QnDj9pwOeW1CW1SYa1aRNgjzXYFyHJ5yW/WDww=;
 b=fa6GGaIE0FEkouqDuyRfCzHpzunMlKww8JvoxVUu4HRaobvMKI91l5V8PUf7jiDyMT
 fy1gAVUteudSxGKj83mtDcRT1wsjro2gEfay1Kw1C/Ee0p1/0rig5M63dhft1a4syhq+
 PQTjSiqcj4HEK98mFr5tKI/mGATraJti4z3jPVeTFjn/BeMUtKR+fV6M23w/J1/uhopc
 sa0SBY7r3zlzs3h+itLJ9DmGDKEIDOP5QJlvE8kfKzzUPixkcmzMyQt7wzy9gVeExABe
 jfwpnH3AGf9ugaCvYgzrcA3IxS2CYP8Y9kq4pEmjfI/pKor8wfyl8oVj6b4JCAazeTlr
 dzfw==
X-Gm-Message-State: AOJu0Yypps6FuTyl+jJ1I3XnDCw0vCpmz8lOd5YFPwZlU+fUuhww1q4z
 o+/eLewbiCNBIY22laaZrQqc/rNAtN9LmU1iVwyozFA/y3gF0/5Lj/U+i+6tNzE=
X-Google-Smtp-Source: AGHT+IHlZZwcPjxN7rFLAFn0YACZE/j0lMKIkgEo4jTAuMt1fJf743/yTsOjRupFG1HGdRnSBBzTLQ==
X-Received: by 2002:a05:6a00:4291:b0:6d9:b082:b8f0 with SMTP id
 bx17-20020a056a00429100b006d9b082b8f0mr2533534pfb.66.1705785921445; 
 Sat, 20 Jan 2024 13:25:21 -0800 (PST)
Received: from ?IPV6:2001:8004:5170:1e39:1361:3840:4873:7990?
 ([2001:8004:5170:1e39:1361:3840:4873:7990])
 by smtp.gmail.com with ESMTPSA id
 ks21-20020a056a004b9500b006dac91d55f7sm7228076pfb.136.2024.01.20.13.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jan 2024 13:25:21 -0800 (PST)
Message-ID: <ef87ae55-574b-461c-a3ff-f0e1263277bd@linaro.org>
Date: Sun, 21 Jan 2024 08:25:14 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/elf_ops: Ignore loadable segments with zero size
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Bin Meng <bmeng@tinylab.org>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20240116155049.390301-1-bmeng@tinylab.org>
 <8ecba163-cd69-4adf-96aa-95f46a0d07e9@linaro.org>
 <45c13c08-c539-4daf-892e-db2e9360a186@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <45c13c08-c539-4daf-892e-db2e9360a186@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/20/24 21:28, Michael Tokarev wrote:
> 16.01.2024 19:38, Richard Henderson wrote:
>> On 1/17/24 02:50, Bin Meng wrote:
>>> Some ELF files really do have segments of zero size, e.g.:
>>>
>>> Program Headers:
>>>    Type           Offset             VirtAddr           PhysAddr
>>>                   FileSiz            MemSiz              Flags  Align
>>>    RISCV_ATTRIBUT 0x00000000000025b8 0x0000000000000000 0x0000000000000000
>>>                   0x000000000000003e 0x0000000000000000  R      0x1
>>>    LOAD           0x0000000000001000 0x0000000080200000 0x0000000080200000
>>>                   0x00000000000001d1 0x00000000000001d1  R E    0x1000
>>>    LOAD           0x00000000000011d1 0x00000000802001d1 0x00000000802001d1
>>>                   0x0000000000000e37 0x0000000000000e37  RW     0x1000
>>>    LOAD           0x0000000000000120 0x0000000000000000 0x0000000000000000
>>>                   0x0000000000000000 0x0000000000000000         0x1000
>>>
>>> The current logic does not check for this condition, resulting in
>>> the incorrect assignment of 'lowaddr' as zero.
>>>
>>> There is already a piece of codes inside the segment traversal loop
>>> that checks for zero-sized loadable segments for not creating empty
>>> ROM blobs. Let's move this check to the beginning of the loop to
>>> cover both scenarios.
>>>
>>> Signed-off-by: Bin Meng <bmeng@tinylab.org>
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> But please report this as a bug to whatever tool produced such nonsense.
> 
> I think we've an old bug about this in debian bts, https://bugs.debian.org/919921 .

That's different -- file size == 0, mem size != 0.


r~


