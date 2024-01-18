Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F3831C98
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:31:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQULq-0005Lz-Ob; Thu, 18 Jan 2024 10:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQULn-0005KU-KY
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:30:41 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQULj-0001js-18
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:30:37 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a2d348d213dso594016366b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 07:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705591832; x=1706196632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yMhYaW/DOrnmTxGo423p3Vj6zWbiOp+1fhUIT1Jiclc=;
 b=xGNUovzezfiTZgfscV2iPmQXEG7UFHEdshl9Dgy3vQ/ew9HbMCmHvNVLhi9lslO2NM
 YC9XRcK5iDLYVGXAPa2QO7qcLkHyUGFtEe0kxKjM1p2Wazrvlz/6ViEKLEzEbwW7LjEW
 hQyxFIqC7lS1TDYmiTDdQbR2b1Jc1wNhPN91nMhMn4ZlYpUZ+xy95KT0WhPsCeXj/Gbl
 3FbnDP3uwkVBwVYNXSCd9s+LEJLJtEeBUzC1K7Y9oDf48dO34VQ7YmHULYvmJtVud7rI
 +Z738l+s6h/Y94pMutk6Mlw3dk8bKXIxyQhewc9Hzvf9NPheBqYDHHCMtIFjfGE4gJXs
 bypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705591832; x=1706196632;
 h=content-transfer-encoding:in-reply-to:cc:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yMhYaW/DOrnmTxGo423p3Vj6zWbiOp+1fhUIT1Jiclc=;
 b=NpPmgmGHi88FHN3jHs0MweDv/rBWRUI/VIkzlUOzyZHLnp2ehsc+wC1OXSPGnTRR/c
 zoxDvxO+qkxuk7OJWqnDwKdL0cDGhbRT9gO/oXOh0B67QqfUwtNZi1lJQifkvbC2txCP
 4wjdfsU24d7X4RcSoRPSaVXTuvXF3JLjIaZIOwjucJN15vJ9kkxfLjGXgiItJyHQiEMj
 V5sU1mYxrWN7/cfopQV2bzz6W2sMsAOAyMJFr4KhTSqzlak45/hC2kVFcI54s7qba0PQ
 AlWy6a8DsaU4hKWo75NM6BNkBbWnXdPV3AWdVmzzXhZualr/U3i0uSJLr+EPSko+8gKz
 McOw==
X-Gm-Message-State: AOJu0YwqPPUWyLWQSvJ3SbFnQkIQNj9Iztj+tP0yKusaNXNzc3Sw1WL6
 a0KqL55trQ+bu9UQIpqUOebQiA0XoHEZQooWG08O2mNQqhYR+zB4OF4Y7ct/VBw=
X-Google-Smtp-Source: AGHT+IFPawHvT5TaSru0RdAQx7GTopIeVVGRoM+1q0gheEiFEfomxLs0OjbfSXbR0Vr+eCj0Opv1Ow==
X-Received: by 2002:a17:907:802:b0:a24:8deb:3524 with SMTP id
 wv2-20020a170907080200b00a248deb3524mr708053ejb.54.1705591832228; 
 Thu, 18 Jan 2024 07:30:32 -0800 (PST)
Received: from [192.168.108.175] (33.red-95-127-38.staticip.rima-tde.net.
 [95.127.38.33]) by smtp.gmail.com with ESMTPSA id
 hy7-20020a1709068a6700b00a280944f775sm9228709ejc.153.2024.01.18.07.30.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 07:30:31 -0800 (PST)
Message-ID: <5531b75e-86ef-4543-b62a-1457666d9585@linaro.org>
Date: Thu, 18 Jan 2024 16:30:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt.c: Remove newline from error_report() string
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240118131649.2726375-1-peter.maydell@linaro.org>
 <1f34e941-5b0a-4091-95f9-0d0c8e302aa9@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
In-Reply-To: <1f34e941-5b0a-4091-95f9-0d0c8e302aa9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 18/1/24 16:17, Philippe Mathieu-Daudé wrote:
> On 18/1/24 14:16, Peter Maydell wrote:
>> error_report() strings should not include trailing newlines; remove
>> the newline from the error we print when devices won't fit into the
>> address space of the CPU.
>>
>> This commit also fixes the accidental hardcoded tabs that were in
>> this line, since we have to touch the line anyway.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/arm/virt.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

BTW there is another case:

$ spatch \
   --macro-file scripts/cocci-macro-file.h \
   --sp-file scripts/coccinelle/err-bad-newline.cocci \
   --keep-comments --use-gitgrep --dir .
./hw/arm/virt.c:1775:38:"Addressing limited to %d bits, but memory 
exceeds it by %llu bytes\n"
./ui/gtk.c:1094:56:"gtk: unexpected touch event type\n"

We could run this some of these coccinelle scripts on CI,
as a new job in .gitlab-ci.d/static_checks.yml or extending
the check-patch job...

Patch on the way for ui/gtk.c.


