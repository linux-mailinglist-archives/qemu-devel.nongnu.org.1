Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D72BA76D843
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 21:58:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRHyo-0006aC-5F; Wed, 02 Aug 2023 15:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRHyl-0006Zv-Or
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 15:57:55 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRHyk-0004A6-8e
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 15:57:55 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bbdc05a93bso2044465ad.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691006272; x=1691611072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4QL2lWBuPdCLuRGqzpypdzivVnXVHr79fy4t3xwmpME=;
 b=HkulYAsMDxDIIn43IwmKMmMTbT/Xn0Ci3/DT4IV6krwosqf79RBZ2qnypQcc1z+vGO
 vSmnEgrXpsdXNM4W4poilIL2I88zw/4uNo5InIZxB21IWjE5xoVr76rUNuFYxD6QEx4Q
 nWiwtfnQJoQcv82msvyLL67A1NLcGWUSVkaIYDlhZL5ZevCdbj4C0aMMap/7Dp9DKTfb
 rnSjBFDynp/eSRWQhKfMzOyS0SJXl26Y7IlmLpPsH8n34SOBaQXL+2WiFTG09hZz8NY3
 4TCZkTPo+oTNIlZYyfw3rTnhKI2EPfTDxCKUhIoerotiT2wm6SGlZMjfudBaS//pD3UR
 VDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691006272; x=1691611072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4QL2lWBuPdCLuRGqzpypdzivVnXVHr79fy4t3xwmpME=;
 b=WolDLvYoc+3dyrHYIvF2nQVt8Cibn9oEsgXKDGoLsSuTEOnz+dZtpqTn5DFCDIpL00
 tX7YqqNgLAEjk91G0tGvmd/ROsAATJyM/PRxx8XEYE9c5py33g3elpNgdYpNigqeCJLs
 +ZikJ7naOyIiGxS95wT6vU+UBg/RMfiYVS/RHVqt214CleDMeES1v4KqfeY3cXbojkxr
 JMEU5+B/dBtYfEsge0P7Lra7eHzzERgRGdhvDrmZ+/s99qWfBFAU/3dVGcJPkNwX3gwZ
 b0cEBSw0gOnPIZ8OC9EOfLT28xIWhgDx2XyxkFnRg52aaXjEZyuZECtarU4axvDc4Fzm
 OXMQ==
X-Gm-Message-State: ABy/qLacCc5BiyghuS0GVqQg8cG05cfnOgRek1lt2iezruMJCAf258mn
 JoK8qWNW10q0LYicHEWTpHitaw==
X-Google-Smtp-Source: APBJJlH+tMA0Ndm4LcI4GMYC5BTnKdbPnd9lvuCTdQEo8CnwaE4DF03oRCwPySVYaB6INdVj2rr+Kg==
X-Received: by 2002:a17:903:1107:b0:1bb:9506:d47c with SMTP id
 n7-20020a170903110700b001bb9506d47cmr17969229plh.19.1691006272631; 
 Wed, 02 Aug 2023 12:57:52 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:b659:bbad:1a22:7ef9?
 ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 jk17-20020a170903331100b001b9e59d6ddesm12823590plb.124.2023.08.02.12.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 12:57:52 -0700 (PDT)
Message-ID: <8e602948-6ef2-9e45-30bc-f9bbc2e6802f@linaro.org>
Date: Wed, 2 Aug 2023 12:57:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 7/8] linux-user: Optimize memory layout for static and
 dynamic executables
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230801232745.4125-1-deller@gmx.de>
 <20230801232745.4125-8-deller@gmx.de>
 <bdf9ebc2-ef7a-7dd4-a742-8bbf5e836aea@linaro.org>
 <07af035f-8ce0-7002-2fda-ab89cc2853d4@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <07af035f-8ce0-7002-2fda-ab89cc2853d4@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 8/2/23 12:51, Helge Deller wrote:
>>> @@ -3159,7 +3140,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>>>        */
>>>       load_addr = target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
>>>                               MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
>>> -                            (ehdr->e_type == ET_EXEC ? MAP_FIXED : 0),
>>> +                            (is_main_executable ? MAP_FIXED : 0),
>>
>> This is definitely wrong, as all ET_EXEC require FIXED.
> 
> Not if the PIE flag is set too...

What in the world are you talking about?
There is no "PIE flag" in ELF.


r~

