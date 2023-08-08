Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB30773D8D
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 18:20:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTPQu-0008NQ-UT; Tue, 08 Aug 2023 12:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTPQt-0008NG-PE
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 12:19:43 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTPQs-0000Lx-7U
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 12:19:43 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6bb07d274feso4813960a34.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691511580; x=1692116380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XLxI88kupIfF5026EpHO5X5CPbabn679+iE3oLJa5Bc=;
 b=OwBw3mlarRVQy3nfAX+tn18MYFBmOFaiaj2alnGqny8wW++ATBElXcuZPnaPWBJiBY
 Qymhs+yATtadGangvjbIhzJZSIR6SRWq1UddB0BHjawtKiL1UYS+0VWWxsxrFOUkr/Hd
 g/gruewmf5GMr2uwsAHm9z9XEr/ehahSt4afprLWpo0cFX0XvSC3zlp5o9IpuNYXNepY
 ZnAig0Zoff6FzP/mvkV85SXsDWOt/KUKYJ0lEhTvq0vqW4p1dZPpYZp9s3NZ1dvW3Tz9
 6FR+iU9F/d6oII6WbWkfJmlrh0M6DEHziZTvFaB8p32myIUIEnHBpqfFi/WV/apbXBzT
 opvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691511580; x=1692116380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XLxI88kupIfF5026EpHO5X5CPbabn679+iE3oLJa5Bc=;
 b=MchTfjgI5BcJcKTljYhmzfjktLLxwxCln18t7wkZqumSFD3Xy9FLuYz1zzf/i31dml
 ZE9PCrL079bfoRj7MLNawJoR9WVdjHERjqnUDmoz00nIvp4ifxKDudGA8iCqmnhaOKRy
 GpxxxMWhvTW4fuQsGVQaWiCZDqw8z7F8X/ZXXi4X1cP4EJVXBFU95cAT/4f3hPKh0ZLH
 FJrSRikVJ/kSSBDT5t/OqukFgD+RNzehHU3td1NzUqb9s1LMxr+nTlXaiNdeHSXPdqml
 0aLlKd/3xk+dni19v7onTGg1t5iYrMSKRmkVMXhmORXZ43z5+QQHcUpYuaRW8qeWZvoA
 zYTA==
X-Gm-Message-State: AOJu0YwKrntObCp5cy5XlrGyCmIXxqdbQOdGIL9tLCpGqoTH0SvLbzZi
 W3ntnEeE2vv3zEaEALSjFAZ5Eg==
X-Google-Smtp-Source: AGHT+IGDjdmgGClgoCrWdfthwmNNO9iyN1OmLjVkG5IiwjOEkdw8+wX/3/ALhqAHfiS8DnVNyDzRCw==
X-Received: by 2002:a05:6808:5d1:b0:3a7:b094:8f2 with SMTP id
 d17-20020a05680805d100b003a7b09408f2mr181328oij.45.1691511580358; 
 Tue, 08 Aug 2023 09:19:40 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a63574b000000b005633311c70dsm6792366pgm.32.2023.08.08.09.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 09:19:39 -0700 (PDT)
Message-ID: <af38a30d-e91c-2354-812b-c1938487424f@linaro.org>
Date: Tue, 8 Aug 2023 09:19:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] linux-user: Define real MAP_FIXED_NOREPLACE value
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de,
 qemu-devel@nongnu.org
References: <20230808115242.73025-1-akihiko.odaki@daynix.com>
 <637ce4c6-9ac6-0bb2-aedb-632f79777902@linaro.org>
 <5e416a73-365e-407d-98fa-3b48be20045d@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5e416a73-365e-407d-98fa-3b48be20045d@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 08:16, Akihiko Odaki wrote:
>> Which supported hosts do not define this value?  Can we simply remove the fallback?
> 
> glibc didn't have this defined until 2.28. The older releases still maintained are 2.26, 
> and 2.27, according to:
> https://sourceware.org/glibc/wiki/Release

Thanks for digging into glibc versions.

> The page says ALT Linux p9 and Ubuntu 18.04 LTS (Bionic Beaver) has glibc 2.27.

QEMU says

# Support for the previous major version will be dropped 2 years
# after the new major version is released or when the vendor itself
# drops support, whichever comes first.

Ubuntu 22.04 is the current major version, so 20.04 is still supported until 2024, but 
18.04 is unsupported.

Similarly, ALT 10.0 was released in 2021, so ALT 9 is now unsupported.

I have just run a patch to remove the fallback through gitlab CI and it has passed:

https://gitlab.com/rth7680/qemu/-/pipelines/959680899/


r~

