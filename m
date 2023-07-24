Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A47B75F930
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 16:02:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNw8M-0002kJ-0m; Mon, 24 Jul 2023 10:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qNw7r-0002U8-Eb
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 10:01:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qNw7o-0007Ld-Th
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 10:01:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fc0aecf15bso42942225e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690207283; x=1690812083;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k3f2l2EECZF/B35B8+oFcJpo4co8Uripn4gNl8KZQKI=;
 b=XhKwPEOmArXYZGSjURFwlWC/3eyCFqXUTVD6JExD0mYrQ3/4hCG6rCw7riS5oCJ7VU
 rodEjpcTkdfP4UTEXS7jDyLXeAGAJqtJUollpK4xK7Q++r8e3vj0dJ9+oY7NM7tCe3CK
 SjEzVxmzDFF4Tj7V/q2Hlzvir8Q/VCFeu9CKkp7k6fvNrVTThvdhMaHTkr1p9+hTt+Bn
 VRAS3GldEqjWdfCxRF5BgFwOvBIrh/hC1tS1ksCftwFdcdG8Ss50NJQqHh3tUabpzj28
 fmBqvE6TwYKZwVvuuwpk2PrM6sL8hxXJQwVWjPfC1GRXfFv99BiFaoYJQifUPy2Cea1d
 89JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690207283; x=1690812083;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k3f2l2EECZF/B35B8+oFcJpo4co8Uripn4gNl8KZQKI=;
 b=J1JBOWseboRDYyHAb0i8gdVdNqwA9xy8ecZaOXv2Y5hu5t8K5gJ47Wg1EcRQ/DDmp5
 10e/F5lCOIn4/DC7qi5jCJ8JMv8+N+zsHrafuQp5s3DZnMiLYxGidEZPM58M7TDjEbCt
 UxZ3QofMWZ+w9CsHa7a0dHcmJWtBGhLyAl2H7xmbT8vMZqkdmQ8WKRiXwSLbT+7aJL8v
 GxXLlTX0uTdGEd1cQ1IgRzQ9c07pg3F1LDIyM6WDJGqXLKzRDzwMzPM9L0MdBWY27axh
 LCUGMjhmohaUOZqKI3UcBa5nNpwJYNJr9DrfJTjFSINTDVVjW283pyqgfAEsSxwhM/0x
 3gmg==
X-Gm-Message-State: ABy/qLZQbLZXjbg0XPjLHCSQT0M7hYL/TNVHAvzii3LhY9wsgy/T7gno
 lCVEQBvT/P0Ib5gvzfnigKZQyr6efIhbFnYOKiM=
X-Google-Smtp-Source: APBJJlFCRaM6nl133gCcBBBo19d1SJelU9AYBMhAG0nO4PwMXHHP/HItbIOqUzvtzjNSoZ1NuNOXHQ==
X-Received: by 2002:a5d:4210:0:b0:317:618a:206 with SMTP id
 n16-20020a5d4210000000b00317618a0206mr1392911wrq.71.1690207283335; 
 Mon, 24 Jul 2023 07:01:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.210.255])
 by smtp.gmail.com with ESMTPSA id
 r9-20020adff709000000b002fb60c7995esm13278112wrp.8.2023.07.24.07.01.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 07:01:22 -0700 (PDT)
Message-ID: <a143d824-689d-16cb-c6a6-8369ddc33c8f@linaro.org>
Date: Mon, 24 Jul 2023 16:01:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 0/4] rtc devices: Avoid putting time_t in 32-bit
 variables
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
 <1d7fc618-fb10-4990-dbda-5fd610655a66@linaro.org>
 <CAFEAcA8MuzfV2cREitZ4uJGQVAQut-8r_M_xd4cpmUdv+HZjVw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8MuzfV2cREitZ4uJGQVAQut-8r_M_xd4cpmUdv+HZjVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 21/7/23 11:46, Peter Maydell wrote:
> On Fri, 21 Jul 2023 at 10:16, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 20/7/23 17:58, Peter Maydell wrote:
>>> This patchset was prompted by a couple of Coverity warnings
>>> (CID 1507157, 1517772) which note that in the m48t59 RTC device model
>>> we keep an offset in a time_t variable but then truncate it by
>>> passing it to qemu_get_timedate(), which currently uses an 'int'
>>> argument for its offset parameter.
>>>
>>> We can fix the Coverity complaint by making qemu_get_timedate()
>>> take a time_t; we should also correspondingly make the
>>> qemu_timedate_diff() function return a time_t. However this
>>> will only push the issue out to callers of qemu_timedate_diff()
>>> if they are putting the result in a 32-bit variable or doing
>>> 32-bit arithmetic on it.
>>>
>>> Luckily there aren't that many callers of qemu_timedate_diff()
>>> and most of them already use either time_t or int64_t for the
>>> calculations they do on its return value. The first three
>>> patches fix devices which weren't doing that; patch four then
>>> fixes the rtc.c functions. If I missed any callsites in devices
>>> then hopefully Coverity will point them out.
>>
>> PL031State::tick_offset is uint32_t, and pl031_get_count() also
>> returns that type. Is that expected?
> 
> I think those fall into the category of "the device we are
> modelling does not support 64-bit timestamps" -- the PL031
> RTC_DR register is only 32 bits.

Good, thanks for confirming.


