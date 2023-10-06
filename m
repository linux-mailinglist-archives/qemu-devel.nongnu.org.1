Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC4C7BB48C
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:51:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qohUD-000763-43; Fri, 06 Oct 2023 05:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qohU9-00075k-I3
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:51:05 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qohU5-0004Gk-NE
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:51:05 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso1890816f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696585858; x=1697190658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gmoKUr+unuEqR/P6Huy2BMZCR3N0wy3+neQKMcnFHhw=;
 b=lgKwFeDuN6aD3ksjWS0le5+1mDzgmiq2cy6uKGDpGnxDILEyY7dM8iLDzVRRLu4UCU
 UjJkTF8WTsgqf1qJMBiSWE5kG4pQq3BX3kwK3GKf0cYYc0wJTp/e2UctjTMx0LuV+jiL
 Hq7qtzu86FM3bF0hc17LqGkMR0Utw1AMiIMFvDeQX6a7z5YWbinUHQsj0tGxwArUg2Yj
 vRICZCOW8ZH7JpLRJFHof5rIy6uZrnLK+i02R0UH2aop7ebjAPzLZoda/dtcXnxFE6Mc
 Xj28mVzzEwVr9IEbC4OBlkNxATDSrXNtx4zcZhEMvlj6JxKXzZKsLeDztkQ58/f+G21f
 DJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696585858; x=1697190658;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gmoKUr+unuEqR/P6Huy2BMZCR3N0wy3+neQKMcnFHhw=;
 b=BYlnomuif+Jdjxw/kiYPt+5iAdZPc+HbytD6kOEb5Q4CsOpDKHxyWSZ/I8Erxo79i5
 ixRGZ4AtUAlGod6utsahUSOw+6AsJiHpA9VeBanjmBH+iUeu25z8a7oLuJHFYpiGEEyT
 g6goPSI8eMA1vFQGETNxmL4pM1WKACdiVT+6X9G0/bIpXJR5doieDnbW0/7gct3Ncc4i
 E59Ogo4ovsJQtpfhhX9KUY9jLh63CgmRvmus8+zJ56/kftHlIE+aJiLjeZ6TfB3Faxht
 59Ep2OUgc7qH+EYmGomhibSHWzsTG75xtojMqG1+LZukyBEVqKkX7K1+1jWoSpKtGekE
 cDhw==
X-Gm-Message-State: AOJu0YzX16zsEJFUxTLapNBrIk4BPnGMHOKlt9nPKoYBo5dIBTStaYgp
 OK0FmObVxUPgL3ku34wDf7u4eg==
X-Google-Smtp-Source: AGHT+IE+3rp+1CBZrDYwQINTsp3OJOXuVM08gZjcCILs5ugQJCxeZiB3zz8sLxnP0Cq9Q+ZWZkmm8A==
X-Received: by 2002:a5d:458f:0:b0:321:6ff5:9256 with SMTP id
 p15-20020a5d458f000000b003216ff59256mr6285611wrq.58.1696585857765; 
 Fri, 06 Oct 2023 02:50:57 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.115.173])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a5d4052000000b00317e77106dbsm1254207wrp.48.2023.10.06.02.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 02:50:57 -0700 (PDT)
Message-ID: <76469d81-f23c-61e6-9308-7e9b6eeca859@linaro.org>
Date: Fri, 6 Oct 2023 11:50:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 00/29] first version of mcdstub
Content-Language: en-US
To: Nicolas Eder <nicolas.eder@lauterbach.com>, qemu-devel@nongnu.org
Cc: Christian.Boenig@lauterbach.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 6/10/23 11:05, Nicolas Eder wrote:
> SUMMARY
> =======
> 
> This patch-set introduces the first version of the mcdstub.
> The mcdstub is a debug interface, which enables debugging QEMU
> using the MCD (Multi-Core Debug) API.

[...]

> neder (29):
>    mcdstub initial commit, mcdstub file structure added
>    TCP chardev added, handshake with TRACE32 working
>    TCP packet handling added
>    queries for resets and triggers added
>    queries for memory spaces and register groups added
>    query for registers added
>    query data preparation improved
>    shared header file added, used for TCP packet data
>    memory and register query data now stored per core
>    handler for resets added
>    query for the VM state added
>    handler for reading registers added
>    handler for reading memory added
>    handler for single step added
>    adapting to the qemu coding style
>    deleting the mcdd startup option
>    handler for breakpoints and watchpoints added
>    making step and go handlers core-specific
>    adding trigger ID handling for TRACE32
>    cp register read/write added
>    switching between secure and non-secure memory added
>    transitioning to unsinged integers in TCP packets and removing
>      MCD-API-specific terms
>    moved all ARM code to the ARM mcdstub and added now commom header file
>    step and go handlers now propperly perform global operations
>    Doxygen documentation added
>    moved all mcd related header files into include/mcdstub
>    MCD stub entry added to maintainers file
>    added description to out-commented gdb function
>    introducing the DebugClass. It is used to abstract the gdb/mcd
>      set_stop_cpu function.

v2 is now reviewable, thank you!

