Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E00D4724699
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:45:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xuj-0005pD-AK; Tue, 06 Jun 2023 10:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Xuf-0005mr-U6
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:43:57 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Xud-0003hP-1Z
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:43:57 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso4510852b3a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686062633; x=1688654633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+DmIAMbunq1pomrbFObBYHR3zPVk1GkroIuzxg71Tvs=;
 b=co+ciTo9d//afNbYvWaad3TbOUv/eF6ZQhg/wRDZRO9Kebl110sLG09CiTrrdDB/cN
 U5fzCSKpytAv3rCvr+FDAkb4t1OoK8vR9MZpIK0kWjlvoM8T9X43qrU59uVi5nMIaI+9
 8CM6HsDwlJbruhO/s0C94YwFcpOEDm9Ulp8N7ZUGYfDa2Rv6ZXZWuh6FAeK7Wi6aOmGr
 PkgrAbTwhNu1xpIANL35iEsrfQWj99Kwvy25R8d2waxvhv5Jh7Kmb4JmI89Qwpa1pfJG
 aqoltUIHegFZljemfPu8YLDbtVcVZ+FViwtfj6PHNSaQLqXAvfrRyOj7Q9y9lQo4E2YD
 E0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686062633; x=1688654633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+DmIAMbunq1pomrbFObBYHR3zPVk1GkroIuzxg71Tvs=;
 b=DmGw1iisLPtkmmkcCz+iIkIZ5e596RP+8fMnd/EfutCzrXqzUqFN4yAQo8my/g0RJ+
 wbr2TSOIpW7g4uCqLrIxXDlb2bG3+34q/6+hqXOABvvgKMQFYEGuLCFAUpreRczvW7pb
 GDJWPO7PL67ZNSFK5USwDyvtxI5MJbjBUUavDZcFpjUnzSJ4CTSQZOjxy4uy6bCKXStl
 2GFEJV0N2ySte10BGM1oN9e3nI1lWtsbmckZEIIzrnIMIkXQFUSYTADQb+owI49OdSMB
 ocBj0Aks/89YyhuFp5e+nP9s6iB3/nTUEV0VG5K/L7JFDZRcamfcycjwzFdv84RaJzIl
 9COQ==
X-Gm-Message-State: AC+VfDxYIFjvNrssjiN39ATjQ2HXkmDzfmNMr2k2inalXwo6dZWpxW2X
 88tfR+xZs4+sMtM5YOW2UarTtw==
X-Google-Smtp-Source: ACHHUZ5/edwD5N1k9eYY4vV4SH6o6Tk8JI59AfpX4DyCRn6uIwWDSEM0zwCMrxDzYF5nU+3gHkjABA==
X-Received: by 2002:a05:6a00:4403:b0:659:14c8:1f0b with SMTP id
 br3-20020a056a00440300b0065914c81f0bmr3276276pfb.4.1686062633323; 
 Tue, 06 Jun 2023 07:43:53 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 y23-20020a62b517000000b0064d2ad04cbesm6840668pfe.209.2023.06.06.07.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 07:43:52 -0700 (PDT)
Message-ID: <cad000d7-f408-9337-9328-ccb262c5fcc7@linaro.org>
Date: Tue, 6 Jun 2023 07:43:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/5] target: Rename per-target 'helper.h' -> 'helper.h.inc'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
References: <20230606141252.95032-1-philmd@linaro.org>
 <20230606141252.95032-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230606141252.95032-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/6/23 07:12, Philippe Mathieu-Daudé wrote:
> Since commit 139c1837db ("meson: rename included C source files
> to .c.inc"), QEMU standard procedure for included C files is to
> use *.c.inc.
> 
> Besides, since commit 6a0057aa22 ("docs/devel: make a statement
> about includes") this is documented as the Coding Style:
> 
>    If you do use template header files they should be named with
>    the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>    being included for expansion.
> 
> Therefore rename the included 'helper.h' as 'helper.h.inc' for
> all targets (updating the documentation).
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

A bulk patch like this isn't ideal.  Targets that have a tcg/ subdir should have 
helper.h.inc moved into there.  At the end, include/exec/helper-gen.h and 
include/exec/helper-proto.h become unused and go away.


r~

