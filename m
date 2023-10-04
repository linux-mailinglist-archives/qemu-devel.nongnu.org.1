Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1194E7B8622
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:09:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5Mq-0005Dv-8W; Wed, 04 Oct 2023 13:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qo5Mn-00056f-52
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:08:57 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qo5Ml-00085M-H6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:08:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-692c70bc440so1866848b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696439334; x=1697044134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hTQUZQjd9I0EJRYyfJgG7dT3PFzWrcjUoTaTNxeM4QI=;
 b=SUTjaBwlWefwn+XYCxs/Bez3ruOrcfbaFshCbs+uaody7c3arrmOXrq9IoH6LDtMm6
 NbBo75zNRWp6hUzwyX/BHyn0n77AbAkGAqbZEI2B+A+nxxDJoal//5G9OxduaBioNzrd
 +mgeBhOeFVTwynLNFhEQUZC5er85uPKgZbnnKeMgES7Vh0diWbulAjFEszRVdqvk+Am1
 BAD0eT/xMBYFbVPJvf3wQzFKnaNLOFAQy+kfjmwZVP3kBxmv3j4MzbRjAbQJGGeEkvqX
 fv71q+uLdZzkvldRH3cY3qqFvD7a3tmhLvQcQmd/wgu6RPPYLqcfQH3gjOtHJWl4PVPH
 UjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696439334; x=1697044134;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hTQUZQjd9I0EJRYyfJgG7dT3PFzWrcjUoTaTNxeM4QI=;
 b=oz0mCMgLOoIzx2ILV05sxhclxMwMlqYdXPt3HPEpmdSHJGbDCDmYEeHmmV5g4sPaWO
 kk0YezgpuCDey8FfCFzJedviW0eHcxskxaRLfiB5VY6ETNBCfkuhPw9uKCPBJZvjZvKf
 Iw3EYynHtgemLdGqMPVOSfYwXHMnbtMLgjXqXuXrPMnB/8qzrxjjOwJH6HUbqeHDtyk5
 TA7oUWwjj4gAji1ckm0v7x61uC0BVEommW2KX8hufyVM7mF8EWYoB14QOFQ0WUMMErkz
 dCG435DWQeMKlyfSH7Ets5r32K/jt36u5GnlJTBrLdLkWfIvQFjn6LpJ6PbPud9OcN6U
 pq6g==
X-Gm-Message-State: AOJu0YzMndu2qnwlSxmrHC2ycQFb8Dhb5mkvoSLCPkqNMj6+kVd6vAQn
 gBDpgV6rJhpBvg3oslociRSZWQ==
X-Google-Smtp-Source: AGHT+IGnZ2rUvy8yDfgZxsun5cx+ZERmwpATK0BbLysnNcPKtTl81oFwS0NRobSZmQ5R2CyM6iXaNw==
X-Received: by 2002:a05:6a20:1442:b0:161:9d3b:dc0e with SMTP id
 a2-20020a056a20144200b001619d3bdc0emr2967518pzi.22.1696439334006; 
 Wed, 04 Oct 2023 10:08:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 p21-20020aa78615000000b006884549adc8sm3467802pfn.29.2023.10.04.10.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 10:08:53 -0700 (PDT)
Message-ID: <4af39265-41bf-4358-b5b8-2184264b7b7b@linaro.org>
Date: Wed, 4 Oct 2023 10:08:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 00/47] tcg patch queue
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
 <CAJSP0QXw80o=S-f3ey1ujF7nY0JwYQ-BPrmxm6nRJPt2wrjxOg@mail.gmail.com>
 <72fabe24-0b50-92d1-6269-7722d6708ebb@linaro.org>
 <CAJSP0QWAa5UjPD_cQogCOZdnxyokvJ6gc7UsLytF1YgxG-5rYA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAJSP0QWAa5UjPD_cQogCOZdnxyokvJ6gc7UsLytF1YgxG-5rYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 10/4/23 09:46, Stefan Hajnoczi wrote:
> On Wed, 4 Oct 2023 at 12:28, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 10/4/23 07:57, Stefan Hajnoczi wrote:
>>> This commit breaks the build:
>>>
>>> ../bsd-user/signal.c:479:19: error: unused variable 'env'
>>> [-Werror,-Wunused-variable]
>>> CPUArchState *env = cpu_env(cpu);
>>> ^
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/5222693462
>>>
>>> Please resend the pull request with a fix.
>>
>> The line number quoted above does not correspond to my source.
>> Did you attempt to merge multiple pulls simultaneously?
>> There must be a conflict between them.
>>
>> My guess is Warner's bsd-user PR.
>> Please just apply that first and I'll re-roll mine afterward.
> 
> Okay. Note that host_signal_handler()'s env local variable looks
> unused in your tag:
> https://gitlab.com/rth7680/qemu/-/blob/pull-tcg-20231003/bsd-user/signal.c?ref_type=tags#L473

You're right, it does appear to be unused.
And yet "make vm-build-freebsd" succeeds, as does a native build on a freebsd install.


r~

