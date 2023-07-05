Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A62748522
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 15:38:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH2gp-0003aU-8Q; Wed, 05 Jul 2023 09:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH2gd-0003ST-Fw
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:36:53 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH2gQ-00031k-C2
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:36:39 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b5c231c23aso109438031fa.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688564196; x=1691156196;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pf+E5VMuYaHZno32BFB2ICK2QdbbEgaD6cQc4pmfP4Q=;
 b=qQe7WnXNbmiVFk30Jj30WK8wpu5Rs93S07f+Y0hqNS8vJ6ia6rNxySVys1tEoutYxh
 DK4a6tn2Bwfnwrbqh20WnnVsbu9ja6P7ZF7jmORfhPqCfebCU82MIHsj8ayzMCjnraMA
 tn8H6eJJDxroO4VJlep6qaJVvLzlgRJKBXfvsX+vnM/WSSQWS3gI79eHzIKpRjzxgG2F
 WxKdge/J1kicm4ubN//nNeU4QyTDHuUp3dbm9DCUOKMIEtcYkSZosp4jo39VNeNU1tle
 b6onVy7of+WjK1gz8WGf/io1vH3T9wc1Aew5/fbq00VQQEO0/eLiomn7C0sikXdbNa4/
 vKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688564196; x=1691156196;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pf+E5VMuYaHZno32BFB2ICK2QdbbEgaD6cQc4pmfP4Q=;
 b=kf/xQOofiWaEwwA9dLuLw0WhztMxrWpHgXTJodIxLJktizqeV0VIjQVZP+UQYfbBVA
 F1JEE2F+9erV/GEF/yDMJP6ibo9vVqyumOwA8TysE8D3RzVJW/9FMx82ibv1BEo3/QNv
 i0OWYD8VF4mIzdvTAfFn2CTbXoXbAJzQeeXuQo01Z6pI+m80wZ1lYkos/zb06FAy79YM
 jP+wrCUCVgimznMI7az9GZU65hHb7ij/776FJquc+Ni/F+7CL5VlUu2DzJCNX5mHQ/kz
 oPsDqHc+WmKJ9km7pOCT26K+TnIBp9nwwWG+404CAHAeI8sqVlNNT61WZJdbNJIIxlpr
 I/sA==
X-Gm-Message-State: ABy/qLZ+10wSk/WXZEPCTIGkFaR1AhKp63YWS7GOkkXfIFLBKjtWUUvg
 zznnZdgEhmBrD0uzW3X3ylzrkA==
X-Google-Smtp-Source: APBJJlFQ5n9LppTZnrUZeFKe8N5urhqqEsOk7vMZ5Ao7J/T8fVaGoekyYu9JI3nYQujsbuACGJ0vJQ==
X-Received: by 2002:a2e:2e16:0:b0:2b6:b575:b26c with SMTP id
 u22-20020a2e2e16000000b002b6b575b26cmr10968375lju.47.1688564195819; 
 Wed, 05 Jul 2023 06:36:35 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 15-20020a05651c00cf00b002b6ca937d60sm3796432ljr.8.2023.07.05.06.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 06:36:35 -0700 (PDT)
Message-ID: <3f065f3d-8f52-3e99-af65-f829f74947e9@linaro.org>
Date: Wed, 5 Jul 2023 15:36:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 07/11] tests/tcg/aarch64: Add testcases for IC IVAU and
 dual-mapped code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?John_H=c3=b6gberg?= <john.hogberg@ericsson.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
 <20230704163634.3188465-8-peter.maydell@linaro.org>
 <2e39933a-b9d9-5792-8c4e-dd558d4aad5d@linaro.org>
 <dd6a96b4-1b72-67e2-58ce-8011203128ae@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <dd6a96b4-1b72-67e2-58ce-8011203128ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/5/23 11:25, Philippe Mathieu-Daudé wrote:
>> /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: 
>> /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/lib/../lib/librt.a(shm_open.o): in function `shm_open':
>> (.text+0x3c): undefined reference to `__shm_directory'
>> /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: 
>> (.text+0xcc): undefined reference to `pthread_setcancelstate'
>> /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: 
>> (.text+0xfc): undefined reference to `pthread_setcancelstate'
>> /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: 
>> /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/lib/../lib/librt.a(shm_unlink.o): in function `shm_unlink':
>> (.text+0x30): undefined reference to `__shm_directory'
>> collect2: error: ld returned 1 exit status
>> make[1]: *** [Makefile:119: icivau] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:50: 
>> build-tcg-tests-aarch64-linux-user] Error 2
>>
>> It looks like this test needs something else.
> 
> Maybe:
> 
> icivau: LDFLAGS+=-lrt -pthread

Yes, that's the ticket I'm sure.
Today is a travel day, so I'll still let someone else re-test.


r~

