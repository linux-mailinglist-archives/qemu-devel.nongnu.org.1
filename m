Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FFD7802AD
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 02:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWnBm-00024M-Fa; Thu, 17 Aug 2023 20:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWnBh-0001r2-HB
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 20:18:01 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWnBf-0005eI-A3
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 20:18:01 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-56546b45f30so336612a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 17:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692317877; x=1692922677;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/wsWQ3ZpCJ3DGQ0TFqJE73cjuHlq84mRlWY3sLSLhH8=;
 b=BDdok2i9JVzXqkH6sEBuG0ysvCySSmYZqhU1C8NpkfgCmfUKw/e7ILQjb9yOMkEJU3
 aS8eCjo60cN0zVezSHxXF5geuy68vQ7LWdyha60NfV7r0tagIu9UjVlHdC8Vu44TR20t
 DKqC4LBGU0T1rgzi9Fogu33pSdhDuUmuYN2pl7ze5OMyA6rauGgo5V3puRJNi5NzpD2b
 wiQ+FaNXvJ1TD9RV5mtALkuY99GLlASOIcSqb45J1vJ1qF3iwEfXJwWWtSlaf/iWawXM
 FebseFD2UDbY6V7K4BL/+QW7dhN+fc/Vh/FBArGue6rNpdPX81ykRYzsz3alZiT/mSeY
 K6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692317877; x=1692922677;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/wsWQ3ZpCJ3DGQ0TFqJE73cjuHlq84mRlWY3sLSLhH8=;
 b=f5JveLu5jGi5LrjYynE/YnISNYFi4HjM6UVxd9uoOueYXGmALa+DFwN1vvcSFGVg3C
 Zhx96Rj2gtFdd7886lkrqo6kqiCoQpBnXFRCedERyw5wjew2PLkRVwiP6JXjCO3qvg6b
 B0SSK/JYehK60x1hhNJvK3QK1kR0Pk6Hso6FFB3eUT2ExywhAlTzUTT7uy605urpxpTs
 66Rc7oKcMsdwgiKqNOKXhsZqrgpN7w4M5+NKYPC8EiZ0mG2Sq7Y/E/g+mrojS73wsxd+
 BBWmi3ajC6XulJTMb7MCAIywoh6vjAo1G5feUSOnOrFYfRDyN3PyhmR7q0JHZYBoVOf1
 Zvsg==
X-Gm-Message-State: AOJu0YzVxVohCk0nnpEvthCKvF54YjhgU2mhs429P1BV63l+ICzNUOes
 lY2u8tRRetwZQvoalugr3nkORA==
X-Google-Smtp-Source: AGHT+IHOh6X3BRT1MvgRquiM92kKe/tToQy9mglTKWULwaWaXqbtw1sJ6GvirM1uzGZag0aa+lNn4Q==
X-Received: by 2002:a17:90a:a58f:b0:267:909f:3719 with SMTP id
 b15-20020a17090aa58f00b00267909f3719mr1031450pjq.19.1692317877516; 
 Thu, 17 Aug 2023 17:17:57 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:3858:36b1:43e1:e747?
 ([2602:47:d483:7301:3858:36b1:43e1:e747])
 by smtp.gmail.com with ESMTPSA id
 fa14-20020a17090af0ce00b00263ba6a248bsm2155683pjb.1.2023.08.17.17.17.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 17:17:57 -0700 (PDT)
Message-ID: <49adae1c-1f8f-31c6-bd6f-e63ffc236d41@linaro.org>
Date: Thu, 17 Aug 2023 17:17:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] linux-user: Adjust brk for load_bias
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, deller@gmx.de, qemu-stable@nongnu.org
References: <20230816181437.572997-1-richard.henderson@linaro.org>
 <20230816181437.572997-4-richard.henderson@linaro.org>
 <6fd3fa16-c8d7-adee-c90c-90e6dda68673@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6fd3fa16-c8d7-adee-c90c-90e6dda68673@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
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

On 8/17/23 09:04, Michael Tokarev wrote:
> 16.08.2023 21:14, Richard Henderson wrote:
>> PIE executables are usually linked at offset 0 and are
>> relocated somewhere during load.  The hiaddr needs to
>> be adjusted to keep the brk next to the executable.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 1f356e8c013 ("linux-user: Adjust initial brk when interpreter is close to 
>> executable")
> 
> FWIW, 1f356e8c013 is v8.1.0-rc2-86, - why did you Cc qemu-stable@?
> 
> If this "Adjust brk for load_bias" fix isn't supposed to be part of 8.1.0 release,
> sure thing I'll pick it up for stable-8.1, but it looks like it should be in 8.1.0.
> 
> Or are you saying 1f356e8c013 should be picked for stable-8.0, together with this one?
> 
> (We're yet to decide if stable-8.0 should have any recent linux-user changes).

This has missed 8.1.0-rc4 and therefore will not be in 8.1.0.
I have tagged it stable for stable-8.1 for 8.1.1.


r~


