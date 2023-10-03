Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 367A57B72FF
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 23:03:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmY4-0003Hv-K3; Tue, 03 Oct 2023 17:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnmY3-0003HZ-1H
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:03:19 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnmY1-00083f-Dc
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:03:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68bed2c786eso1063918b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696366993; x=1696971793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AFyc9g3/mhuwMmp0zBXbU+xK3Gn4jsiTpX98EtAAgRE=;
 b=ZBVeBUE+FxykjZz1u/hsO5OYMKtE1FmwJCP5py1A/DlGUwiR0Gk1QI9tfFFOGaQrkX
 CHF+o5DD0oJNdGoaGiRd7uiup6zxTa7zv4qWvn6tQ8SLcidMpD5DH4bNyPDkPyEeVc7y
 TVwDzh6GQkQ1S1zcwsXA3+2LOPttd+U13IvPpCCJgyoDnt+OfTYPw4B/L/X3mnvdBzgP
 QDao59CdoxGdK1c9hf84e42uzAz5SADyNqaWeeApTJrL1EKFweEkWvnWM86Yfw0Pz6IW
 nyLpN0QalAQ0vUw3VDxIB/klu28e678atGofXUEzhFUBHiiV/gpkLZt4NjZCC8O1iJfN
 SZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696366993; x=1696971793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AFyc9g3/mhuwMmp0zBXbU+xK3Gn4jsiTpX98EtAAgRE=;
 b=eANcl/Feo+hPzuLFJgYpMdFzWXvrfB3XmLFPRxC8jvYgwEqbyzinm9UAxZMlGFwC0S
 k9YhiR2+42/DSgLF2uMESFXvGSCst8A8pYzst9rWabiivCeCGvh8aOkuxCUMaDh3nHPu
 NarWnZ38YiKITrpPonkh/p8FdLBKEsLjkBTrtMx0uQJWA0jBMbyWTPKnwouc3Xc/nosN
 JCshtE5dElHKBAoGPsURQZdnSlAk35aEcg+efxEBypTIhhMkRvaj1OzPIeBRoFcteN3M
 NGY4bU32c0AgsL30en6Se2yhraSLcDX/jVkTSoP9is+Sr6pao68DTVRDbttsUOf/WncR
 F8HA==
X-Gm-Message-State: AOJu0YzchCvZ7ihadLsMFHHKxpvXBU22uXNusqvj1nmCNnStS8Eg0bQS
 P76VRaW51errRnSCe1EnEePbdg==
X-Google-Smtp-Source: AGHT+IES3LllFVt0++2LwHSvicEmwrhmlWGm1OgKBBVmhWyN43MFwqGqQAciCxZ2XyKDvYKNy9gCmA==
X-Received: by 2002:a05:6a00:a26:b0:68f:c215:a825 with SMTP id
 p38-20020a056a000a2600b0068fc215a825mr768098pfh.12.1696366993466; 
 Tue, 03 Oct 2023 14:03:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a62b607000000b0068bbd43a6e2sm1876864pff.10.2023.10.03.14.03.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 14:03:13 -0700 (PDT)
Message-ID: <405187eb-75fb-6a82-abf7-6e427a6d0bf0@linaro.org>
Date: Tue, 3 Oct 2023 14:03:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 38/47] linux-user: Rename mmap_reserve to
 mmap_reserve_or_unmap
Content-Language: en-US
To: Andreas Schwab <schwab@suse.de>
Cc: qemu-devel@nongnu.org
References: <20230715135317.7219-1-richard.henderson@linaro.org>
 <20230715135317.7219-39-richard.henderson@linaro.org>
 <mvmy1h3vpy1.fsf@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvmy1h3vpy1.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 9/18/23 01:35, Andreas Schwab wrote:
> On Jul 15 2023, Richard Henderson wrote:
> 
>> @@ -776,9 +776,15 @@ static void mmap_reserve(abi_ulong start, abi_ulong len)
>>       real_len = real_last - real_start + 1;
>>       host_start = g2h_untagged(real_start);
>>   
>> -    ptr = mmap(host_start, real_len, PROT_NONE,
>> -               MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
>> -    assert(ptr == host_start);
>> +    if (reserved_va) {
>> +        void *ptr = mmap(host_start, real_len, PROT_NONE,
>> +                         MAP_FIXED | MAP_ANONYMOUS
>> +                         | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
>> +        assert(ptr == host_start);
>> +    } else {
>> +        int ret = munmap(host_start, real_len);
>> +        assert(ret == 0);
> 
> munmap can fail if vm.max_map_count is exceeded.  See the attached test
> (must be run from the current directory):
> 
> $ qemu-riscv64 ./test-free
> qemu-riscv64: ../linux-user/mmap.c:801: mmap_reserve_or_unmap: Assertion `ret == 0' failed.
> **
> ERROR:../accel/tcg/cpu-exec.c:532:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
> Bail out! ERROR:../accel/tcg/cpu-exec.c:532:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
> 

Thanks.  Sent a fix.


r~

