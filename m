Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B283978A1CC
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 23:17:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaN7h-00054r-EI; Sun, 27 Aug 2023 17:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaN7Z-000522-IN
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 17:16:33 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaN7X-0007oz-1J
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 17:16:33 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68bed286169so2317040b3a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 14:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693170989; x=1693775789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NpnsIlOIkdljc/GXZcjfjNwsWjEhPc1pJgTFZwzBQFI=;
 b=sjNFlSXu+zbpENeZ+diM7NLqtOEL2ccrIkrIjfaEEXR8ugIH1cCj9dVW7GG0HeBzi6
 3ph0x/flp8vt7xDnwcP8i/3L2iK7zPTmU/hLkBhBsam0MbiI+APIF4TRjTd7xFUHL5+I
 CrN/0WCuBJx4I1L0yosn80Ju3dPZdzK3S/LTBUbySg6RTZpDj6cqhLMWAKdraM8Y/DPs
 guN1KLAsaCmdtEOlK+O1fA+CMoQ1UzKpeLH4EB0sHfmdu3oezvLjmFqQhWozFhZqkhwN
 WvN9fDXMTvIEGt1ocwEyskdXSSKtpBUuNQ19+K74+Jxw8+tB1fA/VN8FsU5WaVHd4Jlf
 FWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693170989; x=1693775789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NpnsIlOIkdljc/GXZcjfjNwsWjEhPc1pJgTFZwzBQFI=;
 b=kDLzLrHibNHZSC+AfbrZ+zi3U3XxAGQ/2QXV0uy848f9QdfhY2yiu2uD0AwqIDpiXs
 YTom9Vn0GkwasbdFrZvhWb+XpZ4oD+t1bBayXw3AOMvtu54fEu8YoWMGddWWhg6mFOao
 9+Hk2v/SdDOuUnri0ceAO8M8F+r1FLv/220vNv14uERRKaoHspGHR2DMotWl/p8RyRW9
 xOX060CmQkvJl/pxyvscL4lXck2JT+cckfs9A9w3Sz1pYUop4eIv8tjY2/Au9Nie12Hp
 KVhpfOyLpizJgqbX2GF+IgK0QCC5F/BwYGG23aRVUGD7tIPoa8UjmOuo3VDIFdUn/F0Q
 NQ1g==
X-Gm-Message-State: AOJu0Yz5L5c/YqHhfXFYgEHyHKLONdAShNQeSBejI3199qFtqH+FJFGB
 Gzj5WBB6q+QHS6AGDItGZhhEhA==
X-Google-Smtp-Source: AGHT+IGa23eUP4+eRGTuVdAGGZkGuSmZdIjWgR6gvzHiw/JUTwGOz24sJDS9nHtugxG3rhkda97vzQ==
X-Received: by 2002:a05:6a21:7742:b0:14d:ccd3:ef3b with SMTP id
 bc2-20020a056a21774200b0014dccd3ef3bmr51859pzc.49.1693170989294; 
 Sun, 27 Aug 2023 14:16:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa78a0e000000b0062cf75a9e6bsm5255559pfa.131.2023.08.27.14.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Aug 2023 14:16:28 -0700 (PDT)
Message-ID: <8c8eda9a-5920-ca7f-2b9e-d2ae8be7bf2e@linaro.org>
Date: Sun, 27 Aug 2023 14:16:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] softmmu: Use async_run_on_cpu in tcg_commit
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com
References: <20230826232415.80233-1-richard.henderson@linaro.org>
 <20230826232415.80233-3-richard.henderson@linaro.org>
 <2f239df2-5cdf-9eef-98af-b208d3ead39b@linaro.org> <87o7is44u6.fsf@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87o7is44u6.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.414,
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

On 8/27/23 13:17, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 8/26/23 16:24, Richard Henderson wrote:
>>> +static void tcg_commit_cpu(CPUState *cpu, run_on_cpu_data data)
>>> +{
>>> +    CPUAddressSpace *cpuas = data.host_ptr;
>>> +
>>> +    cpuas->memory_dispatch = address_space_to_dispatch(cpuas->as);
>>> +    tlb_flush(cpu);
>>> +}
>>
>> Question: do I need to take the iothread lock here, while
>> re-generating the address space dispatch?
> 
> Does it regenerate or just collect a current live version under RCU?

Quite right, just reads.


r~


