Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EB877D4EE
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 23:11:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW1IX-0001MG-RE; Tue, 15 Aug 2023 17:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW1IV-0001M3-CB
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:09:51 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW1IS-0008OR-Ui
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:09:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso36447105ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 14:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692133787; x=1692738587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nNPkKY6qMjf/yGgZS5VMvS/4DzB54vQBu6wNi3BunoA=;
 b=AdNExEvc6UBycCVsF9kypY/1T+c1fWu66A4dJH5TVduQO/I/SlClgZevMfzPy2kgyj
 J4zzSlMxYN0qyNIQysBAfO6mb8jF3FzuoETUZWbi6jPnYyMXCwAz8NqAlFOj+/wEjY4u
 4ruO/hD2FZgFlFpbyBF2QcmC/UPsJ1DlWMzS0StcNdfnhKFojbLlGOqcW2+N7NArrA9e
 f23LuDK+pG/PH+V1epvoB7s12cnChPivj2YMD8ymOaamrTvtmKKfKxVMacK9C++ej7pB
 n02fgJDjyjIT20xbpoFXxSeIIe+SzXpwfLv9P3gDcbWWOvgrFfQXWKXjCO/ICX0CR4U1
 vgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692133787; x=1692738587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nNPkKY6qMjf/yGgZS5VMvS/4DzB54vQBu6wNi3BunoA=;
 b=PjjFILsIdS8bQm0yo6McdxNRk/fruhyyDBLT7CypGYrizih5Jz1OaVsYwa2C7YB9Kz
 3Hf5h8+vXMwSitRh7LkE4a4UfNpsWhwxPcIEsMOfsvKfmurGSnbdhRoJAV5rILNhr9G5
 qD2aKcRgEB7/6PTDPyrN8ww3Jk+9gRGwQP493ymgVu4PPpXntgWfpUNucEnTTKgDqvfV
 M8ns7gA8QNWzfxnzSSpNpDBYJrXcaHxxqa/mv5rbozkk3bQ4naIBXD3PzEXulKg4gDsW
 SLPUf9CnRFX0jqh+CYf5PZIzDrCrJ0e3VLOrwjHD9bl08NbNRdVvfyiUFzPu03TZbTLx
 5JrQ==
X-Gm-Message-State: AOJu0YxTKFJgV7vT0u00fsqvuiR+yrgbgK6JOwFoxf47K4Uo/mUJpnAO
 cMTv4dN+lotMiVnQd5Fv4/xnUw==
X-Google-Smtp-Source: AGHT+IGt3xfwU6B/vrCPcRx/3jSFB59yYusWDywnrzLv/9lOItUXnRx5n1EHeoJTWN/kUX6L5E3bxQ==
X-Received: by 2002:a17:903:2312:b0:1af:aafb:64c8 with SMTP id
 d18-20020a170903231200b001afaafb64c8mr34861plh.21.1692133786990; 
 Tue, 15 Aug 2023 14:09:46 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:8d06:f27b:d26c:91c1?
 ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a170903228200b001b89891bfc4sm11487863plh.199.2023.08.15.14.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 14:09:46 -0700 (PDT)
Message-ID: <59d8d261-be68-dd60-f3d2-547b4e8dca94@linaro.org>
Date: Tue, 15 Aug 2023 14:09:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/14] linux-user image mapping fixes
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
 <35fa0e0c-ca69-a84a-02a0-4edcac65adb6@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <35fa0e0c-ca69-a84a-02a0-4edcac65adb6@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.045,
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

On 8/15/23 06:51, Michael Tokarev wrote:
> 09.08.2023 00:08, Richard Henderson пишет:
>> The following changes since commit 0450cf08976f9036feaded438031b4cba94f6452:
>>
>>    Merge tag 'fixes-pull-request' of https://gitlab.com/marcandre.lureau/qemu into 
>> staging (2023-08-07 13:55:00 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/rth7680/qemu.git tags/pull-lu-20230808
>>
>> for you to fetch changes up to dd55885516f42f718d0d121c59a5f7be5fdae3e6:
>>
>>    linux-user: Rewrite non-fixed probe_guest_base (2023-08-08 13:41:55 -0700)
>>
>> ----------------------------------------------------------------
>> linux-user: Adjust guest image layout vs reserved_va
>> linux-user: Do not adjust image mapping for host page size
>> linux-user: Adjust initial brk when interpreter is close to executable
>> util/selfmap: Rewrite using qemu/interval-tree.h
>> linux-user: Rewrite probe_guest_base
>>
>> ----------------------------------------------------------------
>> Helge Deller (1):
>>        linux-user: Adjust initial brk when interpreter is close to executable
>>
>> Richard Henderson (13):
>>        linux-user: Adjust task_unmapped_base for reserved_va
>>        linux-user: Define TASK_UNMAPPED_BASE in $guest/target_mman.h
>>        linux-user: Define ELF_ET_DYN_BASE in $guest/target_mman.h
>>        linux-user: Use MAP_FIXED_NOREPLACE for initial image mmap
>>        linux-user: Use elf_et_dyn_base for ET_DYN with interpreter
>>        linux-user: Do not adjust image mapping for host page size
>>        linux-user: Do not adjust zero_bss for host page size
>>        linux-user: Use zero_bss for PT_LOAD with no file contents too
>>        util/selfmap: Rewrite using qemu/interval-tree.h
>>        linux-user: Remove duplicate CPU_LOG_PAGE from probe_guest_base
>>        linux-user: Consolidate guest bounds check in probe_guest_base
>>        linux-user: Rewrite fixed probe_guest_base
>>        linux-user: Rewrite non-fixed probe_guest_base
> 
> Is there anything in there and in other linux-user late fixes which are applicable to 8.0?
> Or should we declare 8.0 as semi-broken and be done with it?

Let's wait a bit and see if we're not just exchanging one set of bugs for another.


r~


