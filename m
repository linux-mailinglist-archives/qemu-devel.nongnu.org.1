Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CCA71890B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 20:09:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4QER-0008RP-3Z; Wed, 31 May 2023 14:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4QEO-0008R6-2A
 for qemu-devel@nongnu.org; Wed, 31 May 2023 14:07:32 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4QEM-0002LK-6h
 for qemu-devel@nongnu.org; Wed, 31 May 2023 14:07:31 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b04949e5baso29284525ad.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685556448; x=1688148448;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IyaFZdsi4t8gjtHm3hgsJAx+bzDu746yIoMG9//jC0M=;
 b=jh07HIYOKeKcC0eQIs36WL9ZOC/0akUrwFx+BogvsQyT+90ycnyaQkEUTMcWFYBAy1
 ELQfoad9Bxvt56Mw716I8hOCBJGhNFpBGWy251t9mCQ2OQ+kk0IsGfRZEt5KU4FIwBPW
 X74EipWfjnLbzKZwfzGCjp65aD9sdC5nYVYU8CYJi/LyGJP4nEZvPcVsQJ2FL3JVqEeM
 ZBCkRb7f9fVnBib5iX4jcusQja7ObkFfiRhrZ/3dceu9Wh4S9tbzSMVT+zclZIHqOSOh
 wB4d6o1RsHbYVDal2rKIqU3vvG0A5M20vSTVF1D0wrYhqLhEhqJUPzm7XVjOsN+Yrzgp
 X7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685556448; x=1688148448;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IyaFZdsi4t8gjtHm3hgsJAx+bzDu746yIoMG9//jC0M=;
 b=bMZ2U8gm0M3H9GJQ4GLS74PTvDpYyRgyKkxIMQxHJ0+6hCawAAyeQRR4UKqoIWX9O5
 8qfkgl7G177wtm2Ctq0faWVilU5JZ99y01J3ox8oOmm5JxMXq8dOKM6GW05fquZKbEkp
 yHBhmGPdkg7j2NgdLZgdPdatDrLEEWbXKAstjUSeutRuoz1xUVa6ON/c6cLCevUO8iid
 ttKUSKDlALGgs5aK6yOtYvY+2VfFrl1S8HaRZi2iKzICkBOindduJo/HJIleZlsEK2SC
 mOROD++O9Hbdw2ekWUqVFH9kgGZkkSyylk7jNu1nlO+8NgYrToWO5bKnGjSh6FeQ7EdY
 QrSA==
X-Gm-Message-State: AC+VfDwsy6zpRC4WkPdKWinW1YLflQoOxE/zZbxGh9pDKTXci2B/1Efc
 eSEW7RCkO9R3b4yeP3BQm4sGcw==
X-Google-Smtp-Source: ACHHUZ77awI1VYkSfv0xQULDAEpXj6p1oYeVdXdjuuiltUu4bwKXvCUJB/hrUHYVS7RvpUklVBKP1w==
X-Received: by 2002:a17:902:e546:b0:1b0:3224:e53a with SMTP id
 n6-20020a170902e54600b001b03224e53amr7646936plf.20.1685556448171; 
 Wed, 31 May 2023 11:07:28 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 jw11-20020a170903278b00b001b016313b1dsm1710125plb.86.2023.05.31.11.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 11:07:27 -0700 (PDT)
Message-ID: <227e27e0-4035-8e17-2259-3098340f716e@linaro.org>
Date: Wed, 31 May 2023 11:07:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/27] tcg patch queue
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20230530185949.410208-1-richard.henderson@linaro.org>
 <a2fd61cb-190b-9658-c6ef-0252679f1c5c@linaro.org>
 <d0c21bbb-0448-4539-beae-893ef120fca4@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d0c21bbb-0448-4539-beae-893ef120fca4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 5/31/23 09:12, Thomas Huth wrote:
> On 31/05/2023 03.08, Richard Henderson wrote:
>> On 5/30/23 11:59, Richard Henderson wrote:
>>> The following changes since commit 7fe6cb68117ac856e03c93d18aca09de015392b0:
>>>
>>>    Merge tag 'pull-target-arm-20230530-1' 
>>> ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2023-05-30 08:02:05 
>>> -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20230530
>>>
>>> for you to fetch changes up to 276d77de503e8f5f5cbd3f7d94302ca12d1d982e:
>>>
>>>    tests/decode: Add tests for various named-field cases (2023-05-30 10:55:39 -0700)
>>>
>>> ----------------------------------------------------------------
>>> Improvements to 128-bit atomics:
>>>    - Separate __int128_t type and arithmetic detection
>>>    - Support 128-bit load/store in backend for i386, aarch64, ppc64, s390x
>>>    - Accelerate atomics via host/include/
>>> Decodetree:
>>>    - Add named field syntax
>>>    - Move tests to meson
>>
>> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.
> 
> Too bad that we've run out of CI minutes for the Windows jobs ... FYI, this is causing now 
> failure in the msys2 jobs:
> 
>   https://gitlab.com/thuth/qemu/-/jobs/4385862382#L4821
>   https://gitlab.com/thuth/qemu/-/jobs/4385862378#L4632

Grr.  It doesn't even say what failed, just wrong exit code.
I wonder if the -o /dev/null is getting in the way...


r~


