Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECC97EA06C
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:45:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Z79-0000ZZ-VN; Mon, 13 Nov 2023 10:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Z77-0000ZH-Ng
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:44:37 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Z76-0006sx-2G
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:44:37 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507bd644a96so6520665e87.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699890274; x=1700495074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b8wJckh9c9DAIPaY8C9Mwpjrc/Mbkz3CSbjHl9DJNIQ=;
 b=OyuiB06MLicYXUT63emoY/9nlJwvvpFsPnD4UBv/rvQQtN4PAqcnEpi8ecBQP0u6kr
 7wd4hywH4cTIxQ8u7FGGAqT5SaCBCbRDVnlr7rXJfys89ZBzYR8vx/R12hEjckpStFPd
 XAbL/SOjTxsMfmDT1jFwcsMLlETiRoqxiZcNGNCw+IhPh4mUy9XgzoIli3jt3u1HVhgZ
 6pfxiXcgbrawIJuGRacbvzvzSFhMd8osJuinrSD3sdVGSepKPDyXgDk3XfN4MkZ+klcf
 UK0Ab5DHyiTr8xr0aMX4WJt0GF5vZM174w5l31XrCwyuXeM+RYjq5tbw2MHXR/ALpuIH
 hvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699890274; x=1700495074;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b8wJckh9c9DAIPaY8C9Mwpjrc/Mbkz3CSbjHl9DJNIQ=;
 b=VQ5Jh5jMy1sDgMJgyF6Jbwil061rwzXs/1isKgSQYyRlel6WngiRHLaoKgiSq1wLKX
 AH8i04G6ac1/wutKr0Lr7MQq15qXy5f7B3CLLoaE9xQnW2+E7tRs3t9LlgFt9AbePrct
 86yjsB4lD6jptaooqmE2HYbHKfDgWA2nqGn5hMNphFWQYbZYK1l4UgBqksQkGchlltmq
 P2Z960g9oxUH/p0pz+VjjlhYD3UjbbOnXSOpHO/uufbf/NuF9sRNx6NrFHmaejNwTJhC
 m8MnuyFFtrBkRTY3jfb2bzAxgtIqz9C1JtrK7mAr/4NsrbWLU0+24PtVGA6bJfD0W7CJ
 rfEg==
X-Gm-Message-State: AOJu0YxBbQjaQRjBsh0/dULDu+IosqqaCWoPkvkmmyI0HRguWH+P1VMr
 jCmaV+2TMF1Z80+7s8A1qw9o21SpBc+KSzGGwvU=
X-Google-Smtp-Source: AGHT+IE3zFYvOZvg/BeMnFU/aXqqKzf/zcPPT7OJuFIBln2ZvlAfjekdREr2wAqFApWBEF5QzAOCRA==
X-Received: by 2002:ac2:4a74:0:b0:503:3278:3221 with SMTP id
 q20-20020ac24a74000000b0050332783221mr4282625lfp.69.1699890274055; 
 Mon, 13 Nov 2023 07:44:34 -0800 (PST)
Received: from [192.168.69.100] ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 q24-20020a17090622d800b009db53aa4f7bsm4201445eja.28.2023.11.13.07.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 07:44:33 -0800 (PST)
Message-ID: <fe730485-9f49-4333-bcd5-c6e452a2787a@linaro.org>
Date: Mon, 13 Nov 2023 16:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2 v4 00/10] hw/char/pl011: Implement TX (async) FIFO
 to avoid blocking the main loop
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Gavin Shan <gshan@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org
References: <20231109192814.95977-1-philmd@linaro.org>
 <CAFEAcA8MJeX1Jk_-ONP1nNgHYadL7Oa8P3jGQXwNoofQnJWk8g@mail.gmail.com>
 <4ffed8f5-6624-4488-a74f-567cbd926b78@linaro.org>
 <CAFEAcA_0BfGVDZWJUPs8hwYRKS8FmzppQgY+s83qxBXHjLJvnw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_0BfGVDZWJUPs8hwYRKS8FmzppQgY+s83qxBXHjLJvnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Hi Peter,

Cc'ing Mikko.

On 13/11/23 14:11, Peter Maydell wrote:
> On Thu, 9 Nov 2023 at 20:59, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 9/11/23 20:29, Peter Maydell wrote:
>>> On Thu, 9 Nov 2023 at 19:28, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>
>>>> Missing review: #10
>>>>
>>>> Hi,
>>>>
>>>> This series add support for (async) FIFO on the transmit path
>>>> of the PL011 UART.
>>>
>>> Hi; what's the rationale for the "for-8.2" targeting here?
>>> What bug are we fixing?
>>
>> The bug is on Trusted Substrate when the ZynqMP machine is used:
>> https://linaro.atlassian.net/browse/TRS-149?focusedCommentId=149574
> 
> And have we confirmed that the async FIFO support fixes that problem?
> That bug report seems to have mostly just speculation in it that
> maybe this XXX comment is why...

Mikko tested the v2 (or v1?) and confirmed it was fixing their problem
with TRS.

That said, besides the v4 last-minute review from Richard just before
his US holiday WE, I have to sadly recognize -- although I could argue
this is a bug fix -- this series is not yet ready, thus will miss the
8.2 release :(

(Mikko: no need to test this one, I'll Cc you on the next one to get
  your Tested-by tag on the list).

Regards,

Phil.

