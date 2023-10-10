Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3457BFAE6
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:14:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBc3-0004k6-Ql; Tue, 10 Oct 2023 08:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBc2-0004jr-A9
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:13:22 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBc0-0004O1-G9
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:13:22 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so926809866b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696939998; x=1697544798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0wHBD1j9QzbazpGxPn5423PKK6zv8ne76ZCWbZI3Erk=;
 b=oz1/XSeNLP4GuVFQshHbecHDMmKap9CHoZGN/TdpprCMs0iZORLKB4HpU2+ALzWsf3
 ac80ccSjFFs+OUKAvZRxp2xbiVVTsx9MEhbs+x+Hsu3W4aqvWTgQlqx3MecSGmZC3qT1
 M6box3PRyUfKvGzKAV0QU3HjufJoyR/8EZwDiXFIh4lvq3NCUGd5+c7OMbHEteazIxCu
 S95llLDK30IEyuuF5q8zwFeEz1Z0pUjrWrcJr9bc2/weemMXqsCL7sx8h4hCTgvmmqmB
 5yRPVUPi3Wt39kE2xDwqffpRiiPN9o3ccFye+iglZMs+xUN+3vtIadlBD8i+McdXwnNe
 OGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696939998; x=1697544798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0wHBD1j9QzbazpGxPn5423PKK6zv8ne76ZCWbZI3Erk=;
 b=oK+7VOqtu1OKlMZMxmAamRoqrpnrr93vWj/jfJVPdbGyywYqU7+vLoF8tEWZbMf7WE
 x0MXTT3iEzUeU/oMFpxmKUcY5M/lpr8qU9FjgFmisYwDAu4AjsY0G4CF0Di5OHwgCOGx
 5AdHFyrIVC2TT+3ut0k0PtOGRAiRGrVEICZbLbkp4Fm6acOOpNW/sGc9ciO02OGnxl5V
 Lqrgg9zZOtsTGscx/ZjnkWrwcer8NMsVcrMVUBK2fgkPWxceH3mb695BISThpLCwesqS
 LqybRgBDlizoNRp0KVuXr6OVch+yxcJlZF1vsoIplbdL2EmnMR9+2Y0DYsZJCqIyP9t3
 YwFQ==
X-Gm-Message-State: AOJu0YwDr4b/f41U/0eDbsxVkltir/a0l3SWmbAcbcj4XHA9eJRBKzCA
 CtHbK89b30uOUY6eaxC1MFa+sA==
X-Google-Smtp-Source: AGHT+IEErA4EWYJDNmaeDuTugHHB53EujQ7gzfJ8jEEWXkHvlMeIWeOrPu4/1lyY/LPryZze6krAgw==
X-Received: by 2002:a17:906:5a6b:b0:9a9:e525:8705 with SMTP id
 my43-20020a1709065a6b00b009a9e5258705mr15041979ejc.57.1696939998693; 
 Tue, 10 Oct 2023 05:13:18 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 jp20-20020a170906f75400b0099bcb44493fsm8413423ejb.147.2023.10.10.05.13.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:13:18 -0700 (PDT)
Message-ID: <875f6449-cccb-ccb1-035b-6c339b7d0c3d@linaro.org>
Date: Tue, 10 Oct 2023 14:13:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v17 07/16] accel/tcg: Collect TB jit statistics
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: fei2.wu@intel.com, "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003183058.1639121-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 3/10/23 20:30, Richard Henderson wrote:
> Collect items like input and output code size, guest instruction count,
> intermediate ops, spills, etc.
> 
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> [rth: Consolidated at the end of translation.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translate-all.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



