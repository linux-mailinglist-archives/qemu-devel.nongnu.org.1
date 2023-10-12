Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8D07C6EDA
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:11:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvPi-0002ao-KU; Thu, 12 Oct 2023 09:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqvPP-0002He-QH
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:07:24 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqvPM-0005Gk-7R
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:07:23 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so1636206a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697116038; x=1697720838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uElxi2HlcdsKIdLCnnj5Iek8ftyU5xtffELgvgr3cFw=;
 b=OasvGpx11ehuIOMPauZRbuNST498OKagL9BWNaVlQRlLy9C2shbF0xXXcWDeUs8iXA
 udeya9pgjIszOkuR1IsBqsZEPCiq52hl7Y0uxykNrTwaM0CzrNpe7FKeiyn4N0ApX7cl
 6+FU9gKHB/ubUichWTy5JOSRnep4RVBAoMqlqIpMD9PyGLEFiKSeOV6+SoM2sp/k7u8Z
 Nx1aq6tHu2tk1W4e5n3uVYdXUw417HYtbdlAeBIDIrdXPRXYkPyW7367jqlHVVF6wY8f
 o8zSqMrh2V/RrqlRy99H9mskkRXVsgjtWR9/cFWYJWCl6mxmbitBhF5qvlAzfjzpWXN2
 Sx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697116038; x=1697720838;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uElxi2HlcdsKIdLCnnj5Iek8ftyU5xtffELgvgr3cFw=;
 b=GHeKdL2fHywI6q5Mze+DitI1iaU2ez7NvIhc4RWTwkV6a7ExFSEj8J64yZUURTf4Et
 fiEoF6hTx7Oiye8dfhVzHowXA+qhRzt9wxDQ9s1alBhMSvDHkR+oegsLU/TK2DgpLxqd
 7783VHLUFd5YO2Dqd2NgFRs3sgeyKYWkHaLXThX5Q18Oxp4HWbjIXvND472T9vYwzea0
 Zn8IUpN0D6XaSz/MmPL3VGMhhWXJscl1TLaGQBwDOW22+U9d3jlBxwvdJuSkhJjSKn2b
 qqzwvpn7lTpElK1bTtpz4W3u5klJycY7uc82nItF6h+znVV64sJKEdxQxqwptXB/D09m
 zVaA==
X-Gm-Message-State: AOJu0YxUg8KpLyUu3olz7PaHBlCY8Y42qj/IaZnLZkjq9q+2aJio6Yaq
 mayhKH9qdC+i659ycPoYdnBvbQ==
X-Google-Smtp-Source: AGHT+IEIkexhI37EGGJmyUtUoVkqSOBvDhgJYggwPOEXpYfeb9lEhiYNSWzoaPtXIswYw7Qweec21Q==
X-Received: by 2002:a05:6402:b18:b0:531:1875:bbc8 with SMTP id
 bm24-20020a0564020b1800b005311875bbc8mr21096447edb.19.1697116037908; 
 Thu, 12 Oct 2023 06:07:17 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-232.abo.bbox.fr.
 [176.131.211.232]) by smtp.gmail.com with ESMTPSA id
 i34-20020a0564020f2200b0053dec545c8fsm1667629eda.3.2023.10.12.06.07.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 06:07:17 -0700 (PDT)
Message-ID: <39fb2593-2184-560b-3d67-51f9203f078a@linaro.org>
Date: Thu, 12 Oct 2023 15:07:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 06/11] hw/char/pl011: Extract pl011_write_txdata() from
 pl011_write()
Content-Language: en-US
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <49918fad-56fc-150e-bb9c-bd00dc67df05@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 14/7/23 08:58, Richard Henderson wrote:
> On 7/10/23 18:50, Philippe Mathieu-Daudé wrote:
>> +static void pl011_write_txdata(PL011State *s, const uint8_t *buf, int 
>> length)
>> +{
>> +    /* ??? Check if transmitter is enabled.  */
>> +
>> +    /* XXX this blocks entire thread. Rewrite to use
>> +     * qemu_chr_fe_write and background I/O callbacks */
>> +    qemu_chr_fe_write_all(&s->chr, buf, 1);
> 
> Not using length?

This is a simple "code extract" patch. Length is used when
we switch to FIFO in the last patch.

>> +        pl011_write_txdata(s, (uint8_t *) &value, 1);
> 
> Host endianness error.  Copy to local uint8_t first.

Oops, good catch, thanks.

