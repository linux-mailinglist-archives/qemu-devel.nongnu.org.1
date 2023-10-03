Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 275CA7B5E10
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 02:18:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnT7B-0004Rf-Qo; Mon, 02 Oct 2023 20:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnT7A-0004RR-6H
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 20:18:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnT76-0001CE-2M
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 20:18:15 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c63164a2b6so25475125ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 17:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696292288; x=1696897088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Up2Tzi55RzlFZ+93ivEnmD6YB5G9W0V9Yx/zXYFQ0Ws=;
 b=WONlUUVMb7Sio8SEBEpdxf1/WgiF1l0l7FakQk1ATwP4XgFvPLrf33N1F9sUhwSwsf
 DpH0RH7YqvAZbmJq01GzER5/D44Cnue010AMH/F+6FfbO+KABBNY90y7RwYd5NlCq0gZ
 nqJ13+R3B1mIN5Ii8i9Frogo3lYNzUO7sX6jmxBdynj6VUfVNZ3sSvmVBGGizotyF0h6
 dklczpkcoAGj+fql65nLrJjsmP6uhYYJ+7B+Y/Zjmck3qW7QlFPfUgddJeti5rCgwVr4
 emjWeMVk/Tthb2gXSVMJeMi3jAHpeHwI47jDu8QwyaKglYD9L4eME8bjLAFrdWanW312
 ztDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696292288; x=1696897088;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Up2Tzi55RzlFZ+93ivEnmD6YB5G9W0V9Yx/zXYFQ0Ws=;
 b=A5L/F5EVdrSRR8nUlUXGXz1DJymL6YOB/HoUMvymtSQPrr2A80PCym19Y9KjhV1X28
 57njMjzL0EDO6G1zPzaFD9QKHX8EAvXAhkfFsFh7UWFkbv2xnPh+h93oLHsQojXIFche
 DGhJ3l2IDwWDfztSbC6XEUjKhdR0u0OZPAQB99FLXRXx8+agtDIegSDk4JGeUjqYmnxu
 bYgRBVRhuwbfoK2jM4eR5Y1GSUohp5u9tTiigZ+quuVr9nHFPGtaqi0acqnCcefrtfGN
 YrPVNMnidcio91rDi44poIbEAC7gvCOdiTsoDyg24Bs85+icna7Aj/vKNuCSoKiEnGeF
 Cdlw==
X-Gm-Message-State: AOJu0YyBrB4QSbhHD15KpMkq+C/KBzW+pRIL4AwwvTtHYFbsPx66skZ9
 AfjB1rXDvui6YcpwgcksLN6xdA==
X-Google-Smtp-Source: AGHT+IFqg7HMUGLIRfG1AQfeSVxYwSIo9922bs68u2ZNueAj7MwWT3e5cQLzMm7bdocGRfj45LxQJA==
X-Received: by 2002:a17:902:c9c5:b0:1c3:b268:ecba with SMTP id
 q5-20020a170902c9c500b001c3b268ecbamr1384808pld.18.1696292288509; 
 Mon, 02 Oct 2023 17:18:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a170902dc8600b001c63429fa89sm37603pld.247.2023.10.02.17.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 17:18:08 -0700 (PDT)
Message-ID: <97fedf88-d86c-e6bc-21a5-11b07f385d27@linaro.org>
Date: Mon, 2 Oct 2023 17:18:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 0/6] tcg patch queue
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20230928194156.237351-1-richard.henderson@linaro.org>
 <327359d1-f6c2-68fa-aaa4-c079caada15a@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <327359d1-f6c2-68fa-aaa4-c079caada15a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
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

On 10/2/23 15:46, Michael Tokarev wrote:
> 28.09.2023 22:41, Richard Henderson wrote
>> Mini PR, aimed at fixing the mips and ovmf regressions.
>> r~
>> ----------------------------------------------------------------
>> accel/tcg: Always require can_do_io, for #1866
>>
>> ----------------------------------------------------------------
>> Richard Henderson (6):
>>        accel/tcg: Avoid load of icount_decr if unused
>>        accel/tcg: Hoist CF_MEMI_ONLY check outside translation loop
>>        accel/tcg: Track current value of can_do_io in the TB
>>        accel/tcg: Improve setting of can_do_io at start of TB
>>        accel/tcg: Always set CF_LAST_IO with CF_NOIRQ
>>        accel/tcg: Always require can_do_io
> 
> What's the set required for the regression fix for -stable ?
> Is it the whole thing?
> (yes, I tested the complete set in debian).

While it would be possible to take fewer to just fix the regression, it's probably best to 
take the whole set.


r~



