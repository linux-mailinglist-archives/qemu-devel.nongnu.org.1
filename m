Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0634075E0FB
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 11:35:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNVTx-0005F5-6e; Sun, 23 Jul 2023 05:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNVTt-0005EL-Vl
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:34:26 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNVTo-0003J5-Eu
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:34:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fd190065a7so25996635e9.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 02:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690104858; x=1690709658;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ufTaOqucoACZyX5nZsQaNYieI6w6ujkHPIZ/siWPnLY=;
 b=gJ1DKEVo4UI7AnB89eTLmFH616bFYLT1oJI/nS89JkrMldxODYkIAA/OU9+GNiZsyC
 7nly2Zg8t6vVY5H3a7pdfy7tOJVIj9kro0yS6cQuAXMHD87suAzQbFpbPaPbqgJTP7O+
 sblYZAu8wy46sKejWu3Tu13Ep8A9dQP655yNgUEzO7Y/Q8++hMO1ekqqP+N7v/Z7ACVJ
 OH6Y4bROe/wapsf6y6ura/FWUmjxZ0EWvYVkHpI0r12E/uhme12bR/w+nbUgsWZs+C+L
 /Ixz2uQJxRc7xodwG2PxjwElu/wLeSe7A42HrCtNJecpRZIIrzQlwZow6DHIUK4mLRh0
 PmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690104858; x=1690709658;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ufTaOqucoACZyX5nZsQaNYieI6w6ujkHPIZ/siWPnLY=;
 b=Fwidqxz1p2gPWXvUZU1laBWxE2lg4eBdRuyMI7FWSfXMeKz/yhffsBUYVnNfXajBIa
 XeE+q524EJEtDnnlWO5YglmHmcumPywWp8LDllNsHQw/CjAZscJiELLkaYKQkmAeFDe4
 1QpTCDs1NntecgfO3GSBakS++diT8FDmG6dmnkOs3bc/FZ3EDZwD1nku5Jid2xC1MX0l
 p99N1zWicBA8vA3Nw2UQh9shFqFBtDur+/f7LmGcGjiHdTvgzcrQfzWLVdk5PbG/a2Ih
 aCWCWvIHy6mfh0cQxkftSE9kKoLFlYF/JZ6KFoeZ9CMc21MKag98tegxF8LIJiamkb/k
 2IRA==
X-Gm-Message-State: ABy/qLaSw3PBExIROY/DIMkaUBfI3QErGloh4Cz/5IJzWwaQy+UVtAum
 /enDv5aI3ErdXnMaIrO5MI+HGMTF64P61yEmF0UHAQ==
X-Google-Smtp-Source: APBJJlHoc5OK3aQhgGejN6qC90tf0gbgabaJIaQwBaG19URVg7o9DcW9iKU97liENPjYxjEDY7ztYw==
X-Received: by 2002:a7b:c01a:0:b0:3f9:c986:a2ca with SMTP id
 c26-20020a7bc01a000000b003f9c986a2camr5123882wmb.24.1690104857908; 
 Sun, 23 Jul 2023 02:34:17 -0700 (PDT)
Received: from [172.20.2.226]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a7bcb56000000b003fbb5506e54sm7175795wmj.29.2023.07.23.02.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 02:34:17 -0700 (PDT)
Message-ID: <47c6ff2d-85c4-4e44-a381-1e48e7aec7e0@linaro.org>
Date: Sun, 23 Jul 2023 10:34:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/14] target/arm/ptw: Don't report GPC faults on stage 1
 ptw as stage2 faults
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714154648.327466-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/14/23 16:46, Peter Maydell wrote:
> In S1_ptw_translate() we set up the ARMMMUFaultInfo if the attempt to
> translate the page descriptor address into a physical address fails.
> This used to only be possible if we are doing a stage 2 ptw for that
> descriptor address, and so the code always sets fi->stage2 and
> fi->s1ptw to true.  However, with FEAT_RME it is also possible for
> the lookup of the page descriptor address to fail because of a
> Granule Protection Check fault.  These should not be reported as
> stage 2, otherwise arm_deliver_fault() will incorrectly set
> HPFAR_EL2.  Similarly the s1ptw bit should only be set for stage 2
> faults on stage 1 translation table walks, i.e.  not for GPC faults.
> 
> Add a comment to the the other place where we might detect a
> stage2-fault-on-stage-1-ptw, in arm_casq_ptw(), noting why we know in
> that case that it must really be a stage 2 fault and not a GPC fault.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

