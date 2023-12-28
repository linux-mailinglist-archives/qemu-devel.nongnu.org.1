Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E29181F345
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 01:04:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIds4-0008Uu-P2; Wed, 27 Dec 2023 19:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIds3-0008Ub-5a
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:03:31 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIds1-0001sS-IY
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:03:30 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5c65ca2e1eeso1692462a12.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 16:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703721807; x=1704326607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J+nChfUKSb2m0urOd7n6/MYl+m/WZBr1+QmRZeRAisc=;
 b=y39Ali/8vokVPwxRkStwsZr3Xo1KN+VMUE8TkfOw91MHnuFtksfYu9r6Enmy5kQ3/d
 YXvQxkb40sCkxktPsCgffuF5sSHP+qGit/wm/GpsCAmBI7ax2fbnT1Gc/yje1vMr1OCj
 y1ZAafDjB6YaJQc6vg2wD61ma013r41XJ0o6V40PHiYaGPC3Xcr2F42eXZnorPhDq8Ff
 qgi6AGaj2nfVzwF6O1tbMX8FOnMQSxv3N4dTIHq4QlEopO6cbYhsIRjN52t0q8LLTEug
 M8d8hX1cD4n/lbP7hwcxKZIViC8qLlh/GJxbHxIt8hHomhfxd3h4+FncRVFOqGyhpe/B
 t8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703721807; x=1704326607;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J+nChfUKSb2m0urOd7n6/MYl+m/WZBr1+QmRZeRAisc=;
 b=jHdcr9oNO0iIAU9NtGk70SLO/OU1U6yY/Wb/xNKDyvKXBgIrGON5SLp4YUbHMUu2hf
 8zJ9FbMyC/mMXIzEg1CtFBqrEjRYaMdpEX2Q3eEFMlylcwochk6Kw2se095GTOdC8Huc
 WLV+3jcgC/h2P/gJgvtrqxyW3N0uW4P2qs6HlhnwJEygFaO/bxBULYX/+3HLODb29yLb
 ZYVIFAkujfKyCAfrpde7qiL+vM0Y9KKK2JlLU39GExDftsCZ5TcLYkeaeU/SA4rVT58F
 Pwcx9oKjJ9LsHrS2Yc/kX/4o0maIU9LoTnK0RcLrP09qYaE3dNecazeNO+N2Jd/wc9kQ
 f7fg==
X-Gm-Message-State: AOJu0Yx5s4gQ0XfWsZz9IwB9IACS9IxSwvJSG5KKWchEKjFDrYP6qg09
 WtU4cDJAvIrWVkcgbKuZHQebD5GAhfQUWQ==
X-Google-Smtp-Source: AGHT+IF50C9fsZoPp/1E/VsB3DLjv+IFy5A05Cfx4L7Zj5/SE2xy9ZIHateEygjajG1p0Jr9hlCKKg==
X-Received: by 2002:a05:6a20:42a5:b0:196:4a75:385d with SMTP id
 o37-20020a056a2042a500b001964a75385dmr154037pzj.58.1703721807558; 
 Wed, 27 Dec 2023 16:03:27 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a170903125100b001cfa0c04553sm12471567plh.116.2023.12.27.16.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 16:03:27 -0800 (PST)
Message-ID: <e0d3e790-a937-4f1d-9a30-e4ff04a7af93@linaro.org>
Date: Thu, 28 Dec 2023 11:03:22 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/35] target/arm: Report VNCR_EL2 based faults correctly
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-28-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-28-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/18/23 22:32, Peter Maydell wrote:
> If FEAT_NV2 redirects a system register access to a memory offset
> from VNCR_EL2, that access might fault.  In this case we need to
> report the correct syndrome information:
>   * Data Abort, from same-EL
>   * no ISS information
>   * the VNCR bit (bit 13) is set
> 
> and the exception must be taken to EL2.
> 
> Save an appropriate syndrome template when generating code; we can
> then use that to:
>   * select the right target EL
>   * reconstitute a correct final syndrome for the data abort
>   * report the right syndrome if we take a FEAT_RME granule protection
>     fault on the VNCR-based write
> 
> Note that because VNCR is bit 13, we must start keeping bit 13 in
> template syndromes, by adjusting ARM_INSN_START_WORD2_SHIFT.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h               |  4 ++--
>   target/arm/syndrome.h          | 20 ++++++++++++++++----
>   target/arm/tcg/tlb_helper.c    | 27 +++++++++++++++++++++++++--
>   target/arm/tcg/translate-a64.c |  4 ++++
>   4 files changed, 47 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

