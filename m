Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D4D769A2C
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:56:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQUJU-0002nI-3x; Mon, 31 Jul 2023 10:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQUJR-0002mt-EG
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:55:57 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQUJP-0007iN-Lq
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:55:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-686b91c2744so3267446b3a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690815354; x=1691420154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u+ZFbu5nLzK4ZOVyi8WI5e+JmjDX7GZVskMjJDaStAQ=;
 b=QK1gGCFhsG3fk6vQIAyVO9egGsmb/Lnbj1JAUnCgE39M2nSMbU8kDIMmRyEW5jGCgB
 pEslbtuRyFrWOe4hyldRWMN2kMDohKdh+vuqmk+bwwZ7ZqffChvJEUTbLUKZoRgF59gu
 ydvoo9UvoS3CwL3VZgPPFC890mTPDZxrcCq+vt3SqlgaG1P4/Cek9ZfFeAWAAS0BlSQF
 j9FhcsfPOCZX5RshMb5M0csWKOa8bVJ6uI7MIPwlQt46zfi9DjdEFbm7N1EWChKqxJFp
 Fff/G6n8kj+XqdCYiwqefURbo/MCi5nTDYhqNb7SbHx6q45mBbruri2HtUAWzAjV1lCf
 SKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690815354; x=1691420154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u+ZFbu5nLzK4ZOVyi8WI5e+JmjDX7GZVskMjJDaStAQ=;
 b=YjLDOB/ztRU4L7CKPJ1cUYu4UmiRosrKqTNS8voh8h0+crxk8Kn38FU4oNTCt6kHoW
 KZeAggDOwxrUp1Bu7CLGsFM8DNDIVBpebdvaXmhQVixRwuEjb7Utkh3ptxtFS9eAPZTj
 TZuoQWdUniAVaueYkxNEQwnh2yucgZ+fcS0aqFzGMxYSQHAnT5LSoAqrhhHcCqegPFFV
 E/XY603FYGib11TRM+j8tHb+ZJSE0yRtZPlysr7rdjAZ62owg71S54pjDKf4OVFMo1lS
 AuA8R15e3kWEPSQUAnMCTnNmOKUan/wXPlnrx8bOFWHkvH1nxcLYXxdqUa/TMVJcahli
 sAYA==
X-Gm-Message-State: ABy/qLa+uTrf+O80x9FHHvJt/ojydTJi58eYzDj24jpQOKpu8S2G/diF
 ctUe2YkLHw8CKjXIw9qFZoXbyA==
X-Google-Smtp-Source: APBJJlFGJRqqcOsAdx7cn1ZqGu9r8M3RtU3G0pQ/H9ALjKtq532OIF144ihJK4ghE94OadrXcfKZ1A==
X-Received: by 2002:a05:6a00:134c:b0:686:9385:4642 with SMTP id
 k12-20020a056a00134c00b0068693854642mr11831784pfu.6.1690815354125; 
 Mon, 31 Jul 2023 07:55:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 s24-20020a63af58000000b0056368adf5e2sm2605874pgo.87.2023.07.31.07.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 07:55:53 -0700 (PDT)
Message-ID: <2a9d2f15-4f1b-19c7-7feb-e8597c1c71e3@linaro.org>
Date: Mon, 31 Jul 2023 07:55:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/s390x: Move trans_exc_code update to
 do_program_interrupt
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: david@redhat.com, qemu-s390x@nongnu.org, Claudio Fontana <cfontana@suse.de>
References: <20230728195538.488932-1-richard.henderson@linaro.org>
 <920b0af5-4acb-3eaa-755f-608359117cd2@linaro.org>
 <f054a26eee85be8dba7095b6c4c86fd79331fcd4.camel@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f054a26eee85be8dba7095b6c4c86fd79331fcd4.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/31/23 01:26, Ilya Leoshkevich wrote:
>>> +    case PGM_PROTECTION:
>>> +    case PGM_TRANS_SPEC:
>>> +        assert(env->int_pgm_code == env->tlb_fill_exc);
>>> +        set_trans_exc_code = true;
>>> +        advance = true;
>>> +        break;
>>
>> These exceptions came from seeing an early kernel fault, grepping for
>> the set of
>> exceptions raised in mmu_helper.c, and eliminating PGM_ADDRESSING per
>> the first hunk.
> 
> Does POp specify that the CPU stores Translation-Exception
> Identification on Translation-Specification Exceptions
> (PGM_TRANS_SPEC)? I re-read the 0xA8 documentation a few times, but
> could not find it.

Neither could I.

> It's also interesting what the kernel was attempting when it got
> PGM_TRANS_SPEC and recovered from it. Maybe something else is wrong?

I think the kernel was testing PGM_PROTECTION, to see if LowCore protection worked.

But since that one wasn't listed for 0xA8 either, I preserved previous behaviour in 
setting trans_exc_code for all mmu exceptions except for PGM_ADDRESSING.


r~

