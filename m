Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4443718E59
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:20:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UB1-0002kF-73; Wed, 31 May 2023 18:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4UAz-0002jl-2w
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:20:17 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4UAx-000173-B8
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:20:16 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-53f9a376f3eso166884a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685571614; x=1688163614;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eqsKAra5b4edzib8L3FBd0RNp1oHfut9p8NxAQWAjUM=;
 b=dIcLzQorrn2UkVda7uXoPTDCtXSWMkikjSACVEJJnQPNnDfDVIjRRtBIOX0KeCtR5k
 7Qyx9na+JgwYIq7B155wBVS5ArlVdIhb/kN+w7ZYECY/rqgEz/TvdlG+FtMvrIeM4Xoq
 qPW3vkwNJuXsynlq8qTJUrKH23i3jWwUBZ7A4GSWytMVuQOjVYQxi2Rvt57x+swoT54j
 wvXbqnTlRLl7aeCceiwmnlWjWPPsyXCqseZzIsLK8vothUbVhj7IxEb8PBAt8S7RvvBw
 H+Cy+E+9ouG0bCmGABwoV1Z0z9LLPhwE1QrBt1Eed85SIJTiIL/rIugZ4SPNpi3vwYKE
 hgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685571614; x=1688163614;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqsKAra5b4edzib8L3FBd0RNp1oHfut9p8NxAQWAjUM=;
 b=jyQRdNWFFov55apil0zFHzZl640NeTFD5pQgFyTWWK0wsP+GAAPZ4pmp6GKTO+AwM8
 vxoNkOaS6HQiYmFZCVBawRXz7WmRzr4/IPz574S/qja8lR4hOCpjGgz+YYNPiO5KWtdY
 7M0JZlFJOnEt/1zkHmDbXIctBKCOvLQzndZmzzJGqoLl6LfbnR+k0butNoP6BRSFWLn9
 3FqRYaya4WhCzYSS0VVZqmAUbpuTHMoEty0Nn8IqyZSxdxfd5LLUZ/qZtx967JOvnfUi
 OlsUYtNgMygy20JWfuG82ePGxNhLVJcClzL9GCwiciiBR2kfI3UBnYr9jJDLGGVKxgCG
 kcWQ==
X-Gm-Message-State: AC+VfDy9eSUn2xDvJeodkG/X0hWX4vqDQOUGLHs574ltbULFW1P0WBEB
 RZ1xdr8b0MzDM0L/xkiyQiVrpw==
X-Google-Smtp-Source: ACHHUZ4amk6s8OWmPA3QnY6ATp1PTXPvMui4aPwSgLpvPlpA2zrReLhoZ3M3NuWyT0uMO8UprVb9sw==
X-Received: by 2002:a17:902:ceca:b0:1b0:1608:d7eb with SMTP id
 d10-20020a170902ceca00b001b01608d7ebmr7173044plg.5.1685571613805; 
 Wed, 31 May 2023 15:20:13 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a17090322c600b001a9b29b6759sm1904538plg.183.2023.05.31.15.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 15:20:13 -0700 (PDT)
Message-ID: <8df9e12e-a15d-62fb-ec93-032d4db7f8ac@linaro.org>
Date: Wed, 31 May 2023 15:20:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/27] tcg patch queue
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20230530185949.410208-1-richard.henderson@linaro.org>
 <a2fd61cb-190b-9658-c6ef-0252679f1c5c@linaro.org>
 <d0c21bbb-0448-4539-beae-893ef120fca4@redhat.com>
 <227e27e0-4035-8e17-2259-3098340f716e@linaro.org>
In-Reply-To: <227e27e0-4035-8e17-2259-3098340f716e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/31/23 11:07, Richard Henderson wrote:
> On 5/31/23 09:12, Thomas Huth wrote:
>> On 31/05/2023 03.08, Richard Henderson wrote:
>>> On 5/30/23 11:59, Richard Henderson wrote:
>>>> The following changes since commit 7fe6cb68117ac856e03c93d18aca09de015392b0:
>>>>
>>>>    Merge tag 'pull-target-arm-20230530-1' 
>>>> ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2023-05-30 08:02:05 
>>>> -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20230530
>>>>
>>>> for you to fetch changes up to 276d77de503e8f5f5cbd3f7d94302ca12d1d982e:
>>>>
>>>>    tests/decode: Add tests for various named-field cases (2023-05-30 10:55:39 -0700)
>>>>
>>>> ----------------------------------------------------------------
>>>> Improvements to 128-bit atomics:
>>>>    - Separate __int128_t type and arithmetic detection
>>>>    - Support 128-bit load/store in backend for i386, aarch64, ppc64, s390x
>>>>    - Accelerate atomics via host/include/
>>>> Decodetree:
>>>>    - Add named field syntax
>>>>    - Move tests to meson
>>>
>>> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.
>>
>> Too bad that we've run out of CI minutes for the Windows jobs ... FYI, this is causing 
>> now failure in the msys2 jobs:
>>
>>   https://gitlab.com/thuth/qemu/-/jobs/4385862382#L4821
>>   https://gitlab.com/thuth/qemu/-/jobs/4385862378#L4632
> 
> Grr.  It doesn't even say what failed, just wrong exit code.
> I wonder if the -o /dev/null is getting in the way...

Whee.  From meson-logs/testlog.txt:

FileNotFoundError: [Errno 2] No such file or directory: '/dev/null'


r~

