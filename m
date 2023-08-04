Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C8A7703B8
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:57:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwEw-0000Sc-PH; Fri, 04 Aug 2023 10:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRwEs-0000SU-Go
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:57:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRwEq-0003Hs-Ug
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:57:14 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b8b2886364so15687495ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691161031; x=1691765831;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hW90yQaoDhj5iVWvdsCUYnl7m5NKK0kCER/R4AX6hZ8=;
 b=Zf//Q3czVVuxIILY7PEk7P143QhPu9i/JuiJlLFppt8QHA/txhfTjhXiHVPweC2kYO
 J669sxnsWAic4nGG3ze/vbd9mTgy4XNOQ4iuM6NAr+JqCEv4rqIxZ+zec/6zAv7Hu30A
 dkjYnuxQamOuIY/1TPTDeXsNrmzOlnQw6Rb6//ID1fGwccorv+reV276+yfkVREO80tn
 EIADzeFQ2maWXYeJPEwfrDswuMZdOCNVzBpQzPOE/xSKpUeviC1FVbGrU8XqFGQl1H7z
 pSonjb2yn0q14k/XkksSknlMKpLBYs1jees2h3oXZp9CKgkP1DETFpgk0DxUhRNXdXH1
 tzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691161031; x=1691765831;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hW90yQaoDhj5iVWvdsCUYnl7m5NKK0kCER/R4AX6hZ8=;
 b=jYam/A4tgF4myd4LY9sFLSb9jKsEW3pJJ3I19VWnoPmKEqGVKGGMtBTktU9E4+iEVF
 xJrz/gIhk6BinHYPoXeib5rtKNRnuiv6YqSX7UnhLNLsn48gUkNMdVjg1xd/cvoGonQS
 d3c9apBnuJ+qWii4o4eil6EhWo9TPuxSyHq/SSZRwPNc7yd4iMKs/BpGT8ytrbPYLHGS
 3CzMX9FmmLl4trNhKz4TP97UM4skLjIAfu6kGkFETubesUFuakyE+DJkZRk5Fo/Bjb3z
 A+NbitbJgc+f2n0Zw+AxuHVqRNszzlITu+Yv8dDJUfCasHxTtcU1IvzHXB//QpafzpFj
 O0rQ==
X-Gm-Message-State: AOJu0YyBu9cf57EMJA3C8DbuPFQFcNB18XQKQTuW60cnv4yzh+DyySW2
 WUZRrUZLIdw7kWivbvqkX6Gi1A==
X-Google-Smtp-Source: AGHT+IG5TJk8agyQHVlmmy5HkI83lDbf9mOxXnjeyoHvtZrv6BOUMfD4nUog7e7LpjQO0Pi42auR5g==
X-Received: by 2002:a17:902:7604:b0:1b8:2a4d:3eb9 with SMTP id
 k4-20020a170902760400b001b82a4d3eb9mr1811053pll.34.1691161031342; 
 Fri, 04 Aug 2023 07:57:11 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:1eed:f77f:f320:8b14?
 ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a170902ead100b001b03a1a3151sm1875608pld.70.2023.08.04.07.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Aug 2023 07:57:10 -0700 (PDT)
Message-ID: <de9dfae3-4145-6933-80aa-e7ef9d9bfb3a@linaro.org>
Date: Fri, 4 Aug 2023 07:57:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL v2 40/44] gdbstub: add test for untimely stop-reply packets
Content-Language: en-US
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org, bcain@quicinc.com,
 quic_mathbern@quicinc.com, stefanha@redhat.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230518200411.271148-1-tsimpson@quicinc.com>
 <20230518200411.271148-41-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230518200411.271148-41-tsimpson@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 5/18/23 13:04, Taylor Simpson wrote:
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> 
> In the previous commit, we modified gdbstub.c to only send stop-reply
> packets as a response to GDB commands that accept it. Now, let's add a
> test for this intended behavior. Running this test before the fix from
> the previous commit fails as QEMU sends a stop-reply packet
> asynchronously, when GDB was in fact waiting an ACK.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Acked-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> Message-Id: <a30d93b9a8d66e9d9294354cfa2fc3af35f00202.1683214375.git.quic_mathbern@quicinc.com>
> ---
>   tests/guest-debug/run-test.py                    | 16 ++++++++++++----
>   .../tcg/multiarch/system/Makefile.softmmu-target | 16 +++++++++++++++-
>   2 files changed, 27 insertions(+), 5 deletions(-)

This test is failing for me on x86_64 and aarch64 host, aarch64 guest:


qemu-system-aarch64: -gdb unix:path=/tmp/tmptlr0fa8hqemu-gdbstub/gdbstub.socket,server=on: 
info: QEMU waiting for connection on: 
disconnected:unix:/tmp/tmptlr0fa8hqemu-gdbstub/gdbstub.socket,server=on
qemu-system-aarch64: warning: gdbstub: client sent packet while target running

   GREP    file
   untimely-packet.gdb.err
make[1]: *** [/home/rth/qemu/src/tests/tcg/multiarch/system/Makefile.softmmu-target:33: 
run-gdbstub-untimely-packet] Error 1

$ gdb --version
GNU gdb (Debian 13.1-3) 13.1


r~

