Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D0D7E8E09
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 03:57:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r20dP-0008E8-Gw; Sat, 11 Nov 2023 21:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r20dK-0008Ds-TX
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 21:55:34 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r20dG-00065N-Oy
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 21:55:33 -0500
Received: by mail-il1-x141.google.com with SMTP id
 e9e14a558f8ab-357cf6725acso13297385ab.3
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 18:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699757724; x=1700362524; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJDClDSNaNEPVXz9zYl2X3u7oFUSHrJkfAbcZpAei/E=;
 b=QhrWZ43LZ3KIcd6253adQ4NdLXnBeYG46Cudrt5f177Gq96RAxMqrWIX/f5cmEXPQy
 PgnNCym4hE9Je8TafSWaBE896Ac5/1mWu3NwLznUG4LFmFIevBdN3ZZKc9tBXwBa9vnN
 9/1c4/G3Xtm0fkRG25YqcjWccMbFgDs1dDRUxCsc1scD4zAVEZ7OoMKRiQIYdi4xdBw2
 9Nkp5X05baDz4rmLWwDjjjSBwarSIo8NPSxNRR2AhtBhImnnzZeyTxxus6fdZethOHR5
 4m9QPb+uhjqFZG0y1OAK8chV8zq74jCFkoDiMlp9S03g0reqBrwh+OFVkGVYwZUOgkW9
 mzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699757724; x=1700362524;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pJDClDSNaNEPVXz9zYl2X3u7oFUSHrJkfAbcZpAei/E=;
 b=TLBMYl0GFll8xFA3COZwpfnEdqaimKEWNufHyglaFnILUXRIcC04nKBTM1zlv63ak4
 t58VFS7CibzQGn1X2TI+1cKHZdUB3sv6Gmjz8MoROIm5Q3X/aOzXZNUN/1aU8EtcYQmS
 /FCMpiAA6NFiUMvTJEJghCIXpGve8rAMRVzSSPA+N4OcrUfnZPv0lUACjWV/4WcsPSbF
 ni/6GUxiG+1EwBSTStZuSFU8iHbFlkTpTHrbi7vK028zd3HphjJXOdLP98AsYboofgeP
 ChjvBXeWWV6i0X7JVNy5ExXpVIAoXsHwI8RDcQtZoRJnBYDDTf5+pHRKQRHsUBY7TkV0
 6s2w==
X-Gm-Message-State: AOJu0YzRtrhjzaGHUL4K/6xbJdn7aLSY/wGajEsRMtAr8rzRj89Tp7km
 32eALkKE994A2yIS3v1yK6hUiA==
X-Google-Smtp-Source: AGHT+IFG11M2848kqw5FOUX9ZIMwKvLs5O3Y35DHDylJ2269iFfKzANu/lezqwcyOI+6hxna754ZPg==
X-Received: by 2002:a05:6e02:1bcf:b0:357:438f:6ecf with SMTP id
 x15-20020a056e021bcf00b00357438f6ecfmr4796081ilv.13.1699757724282; 
 Sat, 11 Nov 2023 18:55:24 -0800 (PST)
Received: from ?IPv6:2804:7f0:b401:308c:fa40:2f92:19ee:4ba?
 ([2804:7f0:b401:308c:fa40:2f92:19ee:4ba])
 by smtp.gmail.com with ESMTPSA id
 10-20020a170902c20a00b001b7f40a8959sm1914963pll.76.2023.11.11.18.55.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Nov 2023 18:55:23 -0800 (PST)
Subject: Re: QTest framework does not capture toggled irq line
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
References: <4daf0424-b767-b5d9-bacb-0fe879c92963@linaro.org>
 <41fc01bc-9883-48b3-8652-c526745eda90@redhat.com>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <bf5c6f4e-9d78-d590-7124-3521e08cc435@linaro.org>
Date: Sat, 11 Nov 2023 23:55:21 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <41fc01bc-9883-48b3-8652-c526745eda90@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=gustavo.romero@linaro.org; helo=mail-il1-x141.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.148,
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

On 11/10/23 3:16 AM, Thomas Huth wrote:
> On 10/11/2023 04.40, Gustavo Romero wrote:
>> Hi folks,
>>
>> I'm writing a test for a device that has one IRQ output line
>> that is toggled (raised then lowered) by the device to trigger
>> a CPU interrupt.
>>
>> Afaics the QTest framework does not provide a way to capture
>> when an output line is raised because the API functions, e.g.
>> qtest_get_irq(), read the current state of the intercepted
>> IRQ lines, which is already low when the function is called,
>> since the line is toggled by the device.
>>
>> I'd like to introduce a new API function to address this case,
>> called qtest_get_irq_trigger_counter():
> ...
>> This change addresses the current QTest limitation. Is it acceptable?
> 
>   Hi Gustavo,
> 
> that sounds reasonable to me.

Thanks, Thomas! I've posted the patch here:

https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg02867.html


Cheers,
Gustavo

