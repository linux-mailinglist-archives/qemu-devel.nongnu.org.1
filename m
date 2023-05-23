Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A73770E416
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WI1-00036d-C9; Tue, 23 May 2023 13:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WHz-00036R-C8
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:59:15 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WHx-0005SM-RS
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:59:15 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso125330b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684864752; x=1687456752;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6so+HiTX7MhkXcch8MYW4uvcZWL3eW8MJxbt593Sqvs=;
 b=WDWXHeZ2r8PCAF9ETr7CyujyOHmL63F3ynw/OFLMG8/jpHkmHeIvgNsHQkCoxhFZPT
 Z0iaA9zwQkdUTuh8aI/Nmp+nizeT0v1VesLhbBS6tbkU5gGMV58jqSgjSDMmgZ9EHZ3V
 +7JdSmIRxoYqnq9HyRNRiSphC4IDWO9bUqxbjIuRJUNPoryL8ZfEpOxsomhSgu1n4p+Q
 7xSsVAdaYrofhPTbSVhcwGEH+SgAdmBEEhmbR1hrE+gzEUGOHmepodVNDluyjYn5a879
 nGOOcAo//xedmzkS1Exj8GejU8zxlq0YD2kSQ25iiLIef/0/bZTpEJ/bGvPkjR17U2An
 usbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684864752; x=1687456752;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6so+HiTX7MhkXcch8MYW4uvcZWL3eW8MJxbt593Sqvs=;
 b=aTGyfj3hjNm5i4mrmvds5bIjJ5JYYS43elj047RV/2BBCxHefT8u9yCVJN4S5QNa+X
 fm0Yx4PUyKAA6KKGWv4UWTk8++S43ByNEA7gNK4XRAI4gGDTpFiOsRNKDPREFm30M+0n
 Me8wVScyJwUKliswuuKTiMCHbTKL1Aqg2M7x9x6+Z64ZeC0mIP8fVRB7PNjIt92KUCAu
 uqdC1T86lMuHb7xjZKJX6r2K0K/pfPArwZKl/O3CTw9w5CWO26SqWBOevSJcRKqs361z
 qiHA3kddwacJqAsel/9bQDyrQIoI5qGPlDT8G1ukJSXvblN5wcA+GmLT42jd6jRaXdd9
 ZAZQ==
X-Gm-Message-State: AC+VfDyyDqvm+GnDsJTyQ2MBqyvXGXy9KqGNze1QJ91gCuiNYBKMf98+
 uS/R9Knwsv34hgDr6W91c6WGYVSFzlQRr8V5V3Y=
X-Google-Smtp-Source: ACHHUZ67pTAq8WoGvXg2gKz7YdM3S16/tjxUVcs8WThXEQv9NFlJhAQTfdYX7kupNsjjT6YNC6n30w==
X-Received: by 2002:aa7:88d5:0:b0:63d:3c39:ecc2 with SMTP id
 k21-20020aa788d5000000b0063d3c39ecc2mr15561535pff.12.1684864751928; 
 Tue, 23 May 2023 10:59:11 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a63c105000000b0053ba9ddbb62sm3074180pgf.91.2023.05.23.10.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 10:59:11 -0700 (PDT)
Message-ID: <43ce6b12-231a-1ea5-27b8-8d01dc514132@linaro.org>
Date: Tue, 23 May 2023 10:59:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/6] docs: Document decodetree named field syntax
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230523120447.728365-1-peter.maydell@linaro.org>
 <20230523120447.728365-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523120447.728365-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 05:04, Peter Maydell wrote:
> Document the named field syntax that we want to implement for the
> decodetree script.  This allows a field to be defined in terms of
> some other field that the instruction pattern has already set, for
> example:
> 
>     %sz_imm 10:3 sz:3 !function=expand_sz_imm
> 
> to allow a function to be passed both an immediate field from the
> instruction and also a sz value which might have been specified by
> the instruction pattern directly (sz=1, etc) rather than being a
> simple field within the instruction.
> 
> Note that the restriction on not having the format referring to the
> pattern and the pattern referring to the format simultaneously is a
> restriction of the decoder generator rather than inherently being a
> silly thing to do.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/devel/decodetree.rst | 33 ++++++++++++++++++++++++++++-----
>   1 file changed, 28 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

