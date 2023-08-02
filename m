Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F13B76D38C
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 18:20:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qREZI-00061h-U9; Wed, 02 Aug 2023 12:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qREZG-0005zx-KA
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:19:22 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qREZE-0006FY-W8
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:19:22 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686efa1804eso5095705b3a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690993159; x=1691597959;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=peuTUS9+aXbOI6j0pF5LLZZcpRshqVzDfOU4aXpzAMM=;
 b=w0oHPZjj18bbrAJjFV5JhDF+IugkUsMozOCdtEg/SKCN0/vqRSQX+UaCyFl9/Qqn4B
 Crg2Y29TYNVYNdx9iKQ8VmJa3GpomKwpkBID0nFgrBBvoCd2SmyURNz+g4SqjeeKnKID
 cY27+9NWzws11iQUQr/t4aU4lPBbXeizKz0pLgWqwIj6sZAs2uMeXFCXyU5Fh3FdUWPA
 TSFTFGm/TH75fnMdC/zP2mpBq6DY649qFjvQ0fSsm1/qL0okUMLSXKxxR9DrQkDpN5e9
 alqRtBrDaneFY5kSfXDEB6OZGSs6rbk4BNmZLZGc1A6Y6r3IwmUh6a3n/2JeAxfSEKVq
 CMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690993159; x=1691597959;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=peuTUS9+aXbOI6j0pF5LLZZcpRshqVzDfOU4aXpzAMM=;
 b=cx16cjs/LeCQRY1BQ7YRLyvDQrmWMtOY6DLFsDjVBu33XQQWqfzlICrCI2frbkzVee
 0VgHmD1//T0O1s6+Z+ykZ/UCmhUY3ffWZ1veRbrtY3R2VtwECYCkohlO4PYIdxfjyqXj
 FBGk+3Hp25GW+CY/xJpnRcyeDnhAz/O6Gh2gECXzW1JKM8qATCKMigpQGGcJIXUC3WQ7
 mfiCJiWlfbOieIBlyMM3MLHPJGheqG0ZdkgcfDJ5mIkxYMCa1YMoWCkn/VkXgwnzFfYR
 2ltBTMGSyuOIKoC/6QTr1W17njf4capx9ol+TtdggsowVuXkBWcSIm9+VUmW3f4zslkL
 iFxA==
X-Gm-Message-State: ABy/qLbZCNloeE1BBSmlr6TWKOwb9Z7I1dDWDatFzRrUKRKWJKVARVIp
 e7+q4D1EDurz07MeJF9yJ7ZpyQ==
X-Google-Smtp-Source: APBJJlGK2yqQJOVpiYHFXXAt7hXEtzChcBOhZC+Y4AeeVFt4EWPbjwNhy4uqz5OuGgbsHBZYGf5BRw==
X-Received: by 2002:a05:6a00:2e26:b0:64d:5b4b:8429 with SMTP id
 fc38-20020a056a002e2600b0064d5b4b8429mr18089838pfb.18.1690993159386; 
 Wed, 02 Aug 2023 09:19:19 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:b659:bbad:1a22:7ef9?
 ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a62fb05000000b0068782960099sm125959pfm.22.2023.08.02.09.19.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 09:19:18 -0700 (PDT)
Message-ID: <a463f0d5-18a3-24bc-0e50-4a4b84cccf55@linaro.org>
Date: Wed, 2 Aug 2023 09:19:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] gdbstub: use 0 ("any process") on packets with no PID
Content-Language: en-US
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>, iii@linux.ibm.com
Cc: alex.bennee@linaro.org, bcain@quicinc.com, philmd@linaro.org,
 qemu-devel@nongnu.org
References: <922a658a278cf241e7ca0f49b2249c7d5a6871b6.camel@linux.ibm.com>
 <781bf772bf3575e3fcd8ad26141e7c1d42a6a999.1690974182.git.quic_mathbern@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <781bf772bf3575e3fcd8ad26141e7c1d42a6a999.1690974182.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/2/23 04:04, Matheus Tavares Bernardino wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>
>> On Tue, 2023-08-01 at 12:37 -0300, Matheus Tavares Bernardino wrote:
>>> Previously, qemu-user would always report PID 1 to GDB. This was
>>> changed
>>> at dc14a7a6e9 (gdbstub: Report the actual qemu-user pid, 2023-06-30),
>>> but read_thread_id() still considers GDB packets with "no PID" as
>>> "PID
>>> 1", which is not the qemu-user PID. Fix that by parsing "no PID" as
>>> "0",
>>> which the GDB Remote Protocol defines as "any process".
>>>
>>> Note that this should have no effect for system emulation as, in this
>>> case, gdb_create_default_process() will assign PID 1 for the first
>>> process and that is what the gdbstub uses for GDB requests with no
>>> PID,
>>> or PID 0.
>>>
>>> This issue was found with hexagon-lldb, which sends a "Hq" packet
>>> with
>>> only the thread-id, but no process-id, leading to the invalid usage
>>> of
>>> "PID 1" by qemu-hexagon and a subsequent "E22" reply.
>>
>> Did you mean "Hg"?
> 
> Oops, that's right, thanks.
> 

Queued to tcg-next, with the typo fixed.


r~

