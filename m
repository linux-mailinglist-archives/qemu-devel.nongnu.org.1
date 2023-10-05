Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 335F47B9B2E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:54:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIER-0005fd-EN; Thu, 05 Oct 2023 02:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoIEK-0005fG-Ji
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:53:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoIEI-0003Po-Qf
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:53:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-327be5fe4beso616687f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 23:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696488781; x=1697093581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fgkOuBM06YdQudXzdfP4cijXvUf8+ZgZiji2YsGfoq0=;
 b=XVEGYMJld6mjQtbl/oiE4Htfur8OSURt4G577iv7e+6XNe6wIlo9+divptbFn+bXVL
 2fXi5bj83AfMuUCqMB24xGPKbj5g8aKfHktbZ5+Unti0xIKvc9n9O8aqF9sI7mcgYcmW
 nu4My9gfuIaTQ9+OOvw3LoIbZQ4eK/NRiozNmD8wuwUnut+XqHeQ6m/M+bPJpdzWMW0J
 b8hE19vdNe7oUB6EI56fM/xdFnMjbLtB7DMoCkZ6c73ONlrPQl57JFMNkYaqciU8pMTy
 UX+gIqGZ2cANVmssXHNyS5uWAp9hGgNddEb9uX5iYWDVtQ69+TNIVdDGyi9KNro1Oa9N
 JoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696488781; x=1697093581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fgkOuBM06YdQudXzdfP4cijXvUf8+ZgZiji2YsGfoq0=;
 b=HHpuOkXpQ4NVA46fY2x7/hSGCDmU8N53efxIvSjthhnBODmYLMlRxzGmy/20zUzTIN
 pcoYa/wkbrtJFcjgYJofhrpYvweL0qSAsHfGXz4RSQaKovw5Heq2pJvvoKVnsamEDy8O
 mmFcT2/2e4vQYuCh29MAwEwjulUfdgd0fL9Z135RNyIA/mRiJy8LzbmMGEALUoLdHUqw
 uERsVAPf5x6BVGfOAXZTFeR9dO1xUTC9Fiu5Wz1hxdzq+C8cC4Qlf12jANGaD2sSHVS6
 ZvtSedffzFEUX3rZu0WwtJ2ulnbVWJBC66bAWJ0b1yx1oNeqFPGMYfGfH80SuqfeIO/d
 3lmw==
X-Gm-Message-State: AOJu0YyB56fBxG51255GoNvx5MaRA1XC+vJDmXA7uqesq5G4sj2MmxXZ
 Q7o0Dngo00IJ07IKZXmcEnE/4g==
X-Google-Smtp-Source: AGHT+IEz8NYMFuHKm05e3Vu96S3+/zVqkmDkzkop1/gRaVg6L/4m6onbbSUqoQ0C5PAbUSjKxs2vsA==
X-Received: by 2002:a5d:568e:0:b0:31f:d2dc:df26 with SMTP id
 f14-20020a5d568e000000b0031fd2dcdf26mr3941883wrv.28.1696488781018; 
 Wed, 04 Oct 2023 23:53:01 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a5d500d000000b003259b068ba6sm1000980wrt.7.2023.10.04.23.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 23:53:00 -0700 (PDT)
Message-ID: <dec9cc07-e57d-a65a-b929-ee9fba51dd16@linaro.org>
Date: Thu, 5 Oct 2023 08:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: Wshadow: Better name for 'optarg'?
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
 <d688281c-d019-c1ff-6927-d1791911c57d@linaro.org>
 <e13885b5-06a2-599f-e0fe-c5e8f0671742@redhat.com>
 <b8b28fa6-6224-cf6c-9aa9-016083ed994f@linaro.org>
 <87lechabs2.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87lechabs2.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

On 5/10/23 07:17, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 4/10/23 19:35, Thomas Huth wrote:
>>> On 04/10/2023 19.23, Richard Henderson wrote:
>>>> On 10/4/23 03:05, Philippe Mathieu-Daudé wrote:
>>>>> Hi,
>>>>>
>>>>> I'm getting a bunch of errors for 'optarg' declared in <unistd.h>:
>>>>
>>>> I thought things like this is why we were trying -Wshadow=local.
>>>>
>>>> I think it's unlikely that we'll be able to prevent all such cases.
>>> Given the broad range of operating systems and libraries that we support in QEMU, I agree with Richard - it will likely be impossible to enable that option without =local by default without risking that compilation breaks on some exotic systems or new versions of various libraries.
>>
>> -Wshadow=local doesn't seem to work here which is why I switched
>> to -Wshadow. I probably misunderstood something from Markus cover
>> letter. My setup is:
>>
>> C compiler for the host machine: clang (clang 14.0.3 "Apple clang version 14.0.3 (clang-1403.0.22.14.1)")
>>
>> I suppose we'll figure that out when eventually enabling -Wshadow=local
>> on CI. Meanwhile I already cleaned the 'optarg' warnings that were
>> bugging me, see:
>> https://lore.kernel.org/qemu-devel/20231004120019.93101-1-philmd@linaro.org/
>> I'll try to get -Wshadow=local, but the other series still seems a
>> good cleanup, as I used more meaningful variable names.
> 
> I'm aiming just for -Wshadow=local now.  If somebody else gets us all
> the way to -Wshadow, I'll clap from the sidelines.
> 
> I'm mildly skeptical about -Wshadow without =local when targeting a wide
> range of toolchains over a long time.

Well sorry about the confusion, this is an oversight from my part:
I didn't understood your work is focused on GCC, so I was trying to
get it working on my Darwin host which default to Clang (from what
Warner also said, it seems to be the default on FreeBSD too).

> Not an objection to cleanup patches such as yours!
> 


