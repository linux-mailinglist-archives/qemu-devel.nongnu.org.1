Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA2874DE15
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:22:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIwRz-0008Mf-69; Mon, 10 Jul 2023 15:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIwRv-0008MG-Gn
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:21:32 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIwRt-0005k3-Oq
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:21:31 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3159d75606dso1189814f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689016887; x=1691608887;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GgnOMuliePA9/O/Tv6qfptNBmi6+Rv5tdL/0E6URbKw=;
 b=o93ykXI8t6qz/gZrRghUNXbrhKvhWz1kPA0eSF8lcwUiA7AeKKXTD4Xtk8DG4bseLt
 xv4FFQJDaOV0LzObsNEeGECdelryKPB2UVXIl3u5sXN2YY05B3KejeJejYONL8RTFziV
 VS/gOL4ZoBWh6/nzbh9Q9rksCCPPKkI/+XSddfMGumEy1f9/8CxFtjz851jzWBsfcPFk
 RHJS103LFBcHfBwfJ7ywcD4porkRrdts3ZxWFgyCIepi1LTwr+Ivr8ShcQOrl5uSdMtB
 jZr3WBCJv/m8lUfdknectZM1jo0Nw9CnnoOelS2fJrRvGIRNgsfiujHwDj9M/sXHOJBN
 +Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689016887; x=1691608887;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GgnOMuliePA9/O/Tv6qfptNBmi6+Rv5tdL/0E6URbKw=;
 b=iu46fNJvSQukKHd6dIA6Zk0Agc1WVHJuInP6waF1hiKtALF9Wjr9LRM5rOxZzNk/vo
 J5I4OQLCeeRA7viKSeU4bJwYlVjvK5Qp2tT2NlWKWkNbMQB2kY7WNNwtncRUfpWBMMwh
 zpUfu6dtV/WxYr0ltMW/TW4xx+t15/HQMQL66OfOld/2ex9Hsq8UNwUjY6zAH5IWcWAy
 3oPSVKSjkfU6nr54VUPps5qfk31IeIw/4vbK+BfcThHJ26GwWapEUepgCT7rzpLH9/3m
 Y67xBOSBb7jnQO5ICAmwuLRXCVtdum3OFislssOxfG513ryaG1ZgSzHqsPgefFPylyOC
 y2Lw==
X-Gm-Message-State: ABy/qLYYruqwH6J9AShi2HvpoMOD0U5xK23ool0TTNn58som3YXoO7M/
 IjB6HZoHCBcMBj3KXwb0ArdaBZrq077cXrSQDQUGMw==
X-Google-Smtp-Source: APBJJlFr5ILf2sDW6EZaD1qLfiIzZY4DNKj+P98jfxkBnALA/M6XAGGg5nfmDz9neO71/5rFXLZi+A==
X-Received: by 2002:a5d:63cd:0:b0:314:96f:bb81 with SMTP id
 c13-20020a5d63cd000000b00314096fbb81mr11566375wrw.22.1689016886867; 
 Mon, 10 Jul 2023 12:21:26 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 x14-20020a5d490e000000b0031423a8f4f7sm199201wrq.56.2023.07.10.12.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 12:21:26 -0700 (PDT)
Message-ID: <234d7b82-e34e-53db-34de-c7cfe05ab204@linaro.org>
Date: Mon, 10 Jul 2023 21:21:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/mips: Rework cp0_timer with clock API
Content-Language: en-US
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: chenhuacai@kernel.org
References: <20230521110037.90049-1-jiaxun.yang@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230521110037.90049-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 21/5/23 13:00, Jiaxun Yang wrote:
> Previous implementation of MIPS cp0_timer computes a
> cp0_count_ns based on input clock. However rounding
> error of cp0_count_ns can affect precision of cp0_timer.
> 
> Using clock API and a divider for cp0_timer, so we can
> use clock_ns_to_ticks/clock_ns_to_ticks to avoid rounding
> issue.
> 
> Also workaround the situation that in such handler flow:
> 
> count = read_c0_count()
> write_c0_compare(count)
> 
> If timer had not progressed when compare was written, the
> interrupt would trigger again.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> This seems fixed MTTCG booting issue on malta 5kEc with SMP.
> I'm going to do more test and see if we can enable MTTCG for
> mips64el.
> ---
>   target/mips/cpu.c              |  8 +++++---
>   target/mips/cpu.h              |  3 ++-
>   target/mips/sysemu/cp0_timer.c | 35 ++++++++++++++++++----------------
>   3 files changed, 26 insertions(+), 20 deletions(-)

Thanks, queued to mips-next.

