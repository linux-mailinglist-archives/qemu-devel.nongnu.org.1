Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E76D74486E
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:14:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXc2-00065z-Qt; Sat, 01 Jul 2023 06:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFXc0-00065p-TL
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 06:13:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFXbz-0008HF-A9
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 06:13:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc244d386so25023235e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688206429; x=1690798429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=egm2IaI14wvY5CgM4UazoU8RAyxmI82yXv1oUwrj6qk=;
 b=kPcowPTeVJEQ3OtUwLGO4Gs0bvCVkJ6akeZsUYxG29EBOvgEJ1laGZ4+hAlhwQavzc
 pKvLsUU9D+cb9Ux0VMdmh2FsS50bsHjjSoUU2cUUYe9othY3YkK33IJoM1j6giKjNPVf
 9MHTmkjq24smSKgRGV1l4xEkpdYbIitZ6VT7EfahBmcxcXwlRPl6bNX+HFTTMej7+mKN
 0wRoHVRcGc1Y/lTkm4yWlrE2uGmiu8E4o6Lipjh5Gch54xhlJvPZ/KxizXA4K6vZ9d0q
 O8Y1BzxWwd/NFcmigstCGP0Tsm4qVozMNq+bifzmrtFZ0uuL388/9WpGEF0MFu8eVJmj
 IW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688206429; x=1690798429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=egm2IaI14wvY5CgM4UazoU8RAyxmI82yXv1oUwrj6qk=;
 b=UBpTzn87t/xGO8VSkCfa04chj/s5tQ4hy9qtzlNgtrN+V/FrG7w9Hhi0DilBCgrS1P
 3s5wGDnAvuQo0ohB2C1sgTg3tI0Cb3L2gfNQ8gS/ZIwgEmk2IqRcTuyxcgyx3sPlTe/T
 utLbNlYpd5h9OvXv/Cn+FrjyqVmESZGOWjhcXVjUE1Ymr/hJSYlrYkD6bZNQsIK6vhhk
 fvH7wSjcD5u6ZIjCHhtscSMR0DC5iZmhsiqFqvrmgPmB0h7LeX6SscxM52gyNF4/MUxO
 ncvgtAOVRCs7wLt0+7DPVVvfPi7/sHDVSDoApAiQy7qrurmjrQkIBmg5DeNJetqLvG2f
 gMJQ==
X-Gm-Message-State: AC+VfDzQOnu9Razg8bqejk+6SE2+twW0zdZY8THcu3gLj8P9bKbrVpZl
 3duFsc1fQxzwKCKWGv5uOS6AcQxq3hdyqqmABAUBow==
X-Google-Smtp-Source: ACHHUZ4Vh5XdBhL08NndhHtb5lVCsCXmoskj1V3Ah525upfVb0r6xUiYBgKqKfbAygmOK162dRgC/Q==
X-Received: by 2002:a05:600c:22d4:b0:3fa:9850:8b12 with SMTP id
 20-20020a05600c22d400b003fa98508b12mr3685501wmg.21.1688206429382; 
 Sat, 01 Jul 2023 03:13:49 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 24-20020a05600c229800b003fa98908014sm16123069wmf.8.2023.07.01.03.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 03:13:49 -0700 (PDT)
Message-ID: <6f972534-3859-971b-032d-3b0d8eb864b9@linaro.org>
Date: Sat, 1 Jul 2023 12:13:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] audio: dbus requires pixman
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230630214156.2181558-1-marcandre.lureau@redhat.com>
 <efd6705a-893d-7c6d-c3eb-264928b055b3@linaro.org>
 <0fe923ff-920c-f2ed-fb2b-e8f6d938da86@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0fe923ff-920c-f2ed-fb2b-e8f6d938da86@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 7/1/23 10:04, Philippe Mathieu-Daudé wrote:
> On 1/7/23 08:28, Richard Henderson wrote:
>> On 6/30/23 23:41, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau<marcandre.lureau@redhat.com>
>>>
>>> Commit commit 6cc5a615 ("ui/dbus: win32 support") has broken audio/dbus
>>> compilation when pixman is not included.
>>>
>>> Fixes:https://gitlab.com/qemu-project/qemu/-/issues/1739
>>>
>>> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>
>>> ---
>>>   audio/meson.build | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Queued to tcg-next, per request.
> 
> While this happens to fix the build, I think the proper fix is
> different, see:
> https://lore.kernel.org/qemu-devel/20230630234839.14716-1-philmd@linaro.org/
> 

Doh! I didn't see this until after pushing to master.
But yes, that's more correct, getting the -Ipaths right.


r~

