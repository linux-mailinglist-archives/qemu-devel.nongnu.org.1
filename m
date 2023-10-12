Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B467C703B
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:26:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwcr-0005DQ-Q5; Thu, 12 Oct 2023 10:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqwcq-0005Cl-27
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:25:20 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqwco-0003RI-EI
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:25:19 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53dd3f169d8so1836191a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697120717; x=1697725517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ayHr7M2SqhRkK+c7+qJ9CpIBrca7uy44Og56CYJfF2I=;
 b=W+zUnXw/hIA4ZDOKzXK1KQojnL144oQP0J04To28fruZsv77eDfETRiuzZFgb85i9/
 OcNrlYlBVFkZO4n5xU1nCJtjmU62J/EZzQ616XPQu/Trp2KEvknlDAJSac3bnVhQotE+
 NLAoWdTE6cSeXSEm8bEgqV2HnK9ybucLOcHjlnS3UnL/i5iNivNkMJ10O0Vy+bHRoTo6
 YsqOSY3lNwimKTfqauCXzq9vuSRyARb/lcPatE0g4+FAT+LrcYza/cvaxGgxQfqDW13C
 Qu16BtdRU1VpIH8DiZXo3MAFKWUWnzZHox5Cl98/BpYfoT0UKTNwykp/CKDj3IZE0yQU
 UG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697120717; x=1697725517;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ayHr7M2SqhRkK+c7+qJ9CpIBrca7uy44Og56CYJfF2I=;
 b=pbv8pKvuro4NsG0kkpO036Gr4gBTOxAnKxtwVWefmDHFr3Rl7ltaA6CByW7DaOhz8V
 9h+zNCra28QCfQ6ItBhW/1VAdS+SdUbPfIn57b3mAjg9Ykpk8MSNObSYEcku3VOr2EY1
 D+louA5ZpxGbpLt9wcXCaFRQPO98ehEAKkeMiGj9QNoI0yhCzWKnRWO9Zy4qzC/0loFO
 rvaFr4GCttG7YgpZ2hFspbTWBId6fW5+fj0yrsdgV6R84wD2TrHqs95SBHdA1ujSuYut
 ONGJq5/pVPIJ07yydM2h3KQNEb8bMWyRwzfmaepT+w8aNKzFLLmtaeeTY9mC6UVlgBuu
 oMxw==
X-Gm-Message-State: AOJu0YzCHwvn0B5wNn0J1H7loZADmjiPGPudMQCOkOvRLfiJGDcBhxFO
 cAvEOV0d9b0yqtMfv4GSpR0ShA==
X-Google-Smtp-Source: AGHT+IHZydKIz2f99qcBZfP3bggM5qD3G0stgljuURvy6khlmjofQkKMaW134wTembTj//YLypYMeA==
X-Received: by 2002:a17:906:2250:b0:9ae:69c4:5b4f with SMTP id
 16-20020a170906225000b009ae69c45b4fmr23565313ejr.19.1697120716797; 
 Thu, 12 Oct 2023 07:25:16 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-232.abo.bbox.fr.
 [176.131.211.232]) by smtp.gmail.com with ESMTPSA id
 a24-20020a170906685800b009828e26e519sm11081999ejs.122.2023.10.12.07.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 07:25:16 -0700 (PDT)
Message-ID: <1d47574e-cc05-a087-f674-0644430a4682@linaro.org>
Date: Thu, 12 Oct 2023 16:25:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 06/11] hw/char/pl011: Extract pl011_write_txdata() from
 pl011_write()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org
References: <20230710175102.32429-1-philmd@linaro.org>
 <20230710175102.32429-7-philmd@linaro.org>
 <49918fad-56fc-150e-bb9c-bd00dc67df05@linaro.org>
 <39fb2593-2184-560b-3d67-51f9203f078a@linaro.org>
In-Reply-To: <39fb2593-2184-560b-3d67-51f9203f078a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 12/10/23 15:07, Philippe Mathieu-Daudé wrote:
> On 14/7/23 08:58, Richard Henderson wrote:
>> On 7/10/23 18:50, Philippe Mathieu-Daudé wrote:
>>> +static void pl011_write_txdata(PL011State *s, const uint8_t *buf, 
>>> int length)
>>> +{
>>> +    /* ??? Check if transmitter is enabled.  */
>>> +
>>> +    /* XXX this blocks entire thread. Rewrite to use
>>> +     * qemu_chr_fe_write and background I/O callbacks */
>>> +    qemu_chr_fe_write_all(&s->chr, buf, 1);
>>
>> Not using length?
> 
> This is a simple "code extract" patch. Length is used when
> we switch to FIFO in the last patch.

Hmm you are right it isn't used...

The UARTDR register is 16-bit wide. Only 8 bits are used for data.
No need for a 'length' param here.


