Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 243357B9B31
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:57:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIHv-0008Vx-1X; Thu, 05 Oct 2023 02:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoIHs-0008Vj-Lh
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:56:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoIHq-00059h-T7
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:56:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3247d69ed2cso659731f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 23:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696489001; x=1697093801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qdMrzHGMMkzppJqF9JAQo1sLPeYRU4L6kggdmxboclE=;
 b=doLdFjhKXdP/7K2fGSvLe07aNYCbpVuLE/WJkyiKzu7TRiltLhlLEzvCNSsInuu5vB
 P2nxLkrxGZJ9e9vuE4w0aJvxFSXuAZyYkXsPiDwRQNlgjgfhmhkgwMBRKneqv6ZDU/3Q
 uBPsW/Tf8F9b2/ha5+x4oiGXvL3oWnzYcqmAk5kn8vmZMTL3LLfvGzLbMR+sM3l9uzsK
 +wKRGzV4adriVkTBGp4pchUpgnAco/3SCRrbSUlJJq/GBpUN8KgwCjnyWTXTCZwLIQKB
 Jvsyb8lnuFSnlpVSV0m1rNu1nanTOkORkimJDRJCDCK4gB7s0LowmSImPuwGPPUidUEy
 cU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696489001; x=1697093801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qdMrzHGMMkzppJqF9JAQo1sLPeYRU4L6kggdmxboclE=;
 b=pStDItVpRPM2VzSef9UtFqsVNGrTO8zfCbnFd+kMG/loyHQFF2DlWBlDdsGlrmKyDf
 xw3wV7W7GrjHRjhQroJcBQHaJMm/7W50h3+1lpKEWpJ/ri1s9o50K1OQAl3waXD1ImIX
 PAwodnIAjpan+eOlhkw2jo+3OJTqAXRb30kPpxLUaXdu0MUXcxBoEc92CUwIp6iAGLZb
 uBuNsAYpl62HxBBTNjlxJj9hIdrW8v0V2c0Hwvfu5lNqACQlOXFMNvHym6ZTZGawu4pG
 tlnDTi48jqD0nsaOc01DwGfel7OCtYgQdOiMJ99Mq9qB/PypAOyYLb6k+3LLkX6NzJ9D
 nfMA==
X-Gm-Message-State: AOJu0YzrlVo/pI/jvYWcwEY0DhtHuODgNDWM/f9nJdieJ46VNjT+t6Xv
 kE14xoZdBArZWG8rnRNdM7aKSw==
X-Google-Smtp-Source: AGHT+IFtMhRqXfrjm540BfEyyoE4QGb8G/PyEbiMBdPNp1cOGuWHEGhKir8qCjEfH++c8y3bV6+Dxg==
X-Received: by 2002:adf:e9c1:0:b0:31f:f2dc:db7d with SMTP id
 l1-20020adfe9c1000000b0031ff2dcdb7dmr3866932wrn.65.1696489001520; 
 Wed, 04 Oct 2023 23:56:41 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a056000100800b00326f5d0ce0asm1006544wrx.21.2023.10.04.23.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 23:56:41 -0700 (PDT)
Message-ID: <1628d62e-28ac-58f9-9efb-147db95d2b37@linaro.org>
Date: Thu, 5 Oct 2023 08:56:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: Wshadow: Better name for 'optarg'?
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
 <d688281c-d019-c1ff-6927-d1791911c57d@linaro.org>
 <e13885b5-06a2-599f-e0fe-c5e8f0671742@redhat.com>
 <b8b28fa6-6224-cf6c-9aa9-016083ed994f@linaro.org>
 <11abc551-188e-85c0-fe55-b2b58d35105d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <11abc551-188e-85c0-fe55-b2b58d35105d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 4/10/23 19:56, Thomas Huth wrote:
> On 04/10/2023 19.43, Philippe Mathieu-Daudé wrote:
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
>>>
>>> Given the broad range of operating systems and libraries that we 
>>> support in QEMU, I agree with Richard - it will likely be impossible 
>>> to enable that option without =local by default without risking that 
>>> compilation breaks on some exotic systems or new versions of various 
>>> libraries.
>>
>> -Wshadow=local doesn't seem to work here which is why I switched
>> to -Wshadow. I probably misunderstood something from Markus cover
>> letter. My setup is:
>>
>> C compiler for the host machine: clang (clang 14.0.3 "Apple clang 
>> version 14.0.3 (clang-1403.0.22.14.1)")
>>
>> I suppose we'll figure that out when eventually enabling -Wshadow=local
>> on CI. Meanwhile I already cleaned the 'optarg' warnings that were
>> bugging me, see:
>> https://lore.kernel.org/qemu-devel/20231004120019.93101-1-philmd@linaro.org/
>> I'll try to get -Wshadow=local, but the other series still seems a
>> good cleanup, as I used more meaningful variable names.
> 
> If I got that right, -Wshadow=local only works with gcc and not with 
> clang yet, so we'll need a check in configure or meson.build and will be 
> able to only use it when it's available.
> 
> If we could use "-Wshadow" to check global variables, too, that would be 
> great, but given my experience with some other project, it's very 
> unlikely that you can get it running reliably everywhere, since there is 
> often a bad library header somewhere that declares some global 
> variable(s) that spoil your plans (IIRC I've once seen a bad library 
> that even declared a global variable called "x" ... and you certainly 
> don't want to rename all occurances of "x" in the QEMU source code just 
> because of a bad library ... however, that's been many years ago, 
> though, maybe the situation got better nowadays, so if you like, feel 
> free to continue your quest - just be aware that it might not be 
> solvable at the end).

Nah I'm not interested in such a quest, this is simply an oversight
that this is restricted to GCC.

My view on those warnings cleanups is, once we start, either we
finish the full conversion and enforce the warning, or better not
to start wasting energy. I wanted to help Markus, getting closer
to the end. Sorry about the confusion, I'll wait this get enforced
for our GCC jobs on CI before revisiting.

Regards,

Phil.

