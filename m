Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E77188C9
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 19:49:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4PvF-000546-EW; Wed, 31 May 2023 13:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Pv4-0004xd-7C
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:47:36 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Pv2-0005Er-Nj
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:47:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b0236ee816so153895ad.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685555251; x=1688147251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=znoH4H0+9Cjyj08GQVpDCQg30xorYSyCFsBntgfl2iE=;
 b=fKvVpQHEhHz1arrSJeL8ROoARfHW5cV3867KI3I9EfR+nPXpXpwRmaDi7TZJkDFngC
 AeP6R3Xx/aPM9LCcXrYezcritdPNtmLgjOUv7jd7e6UtrrXWsYfkapS3VhFwIiQp4b71
 Bguzl/fG8/mm4McpAJSUNIxR87kpm/x0vDRckS3OLnPTcoTkWCv4xNfUhS1xAhCjzJPL
 YfG16zc9lrvZJ+FAMmnAPH6gxXCfD95khcqfcxwm7GB5nds5UYe0zbAv9G9mwf+cwewQ
 nMxoRMths+yQlVBVElEIZys/4KeRIRIYZ7W1H8H5HGvm5K/8q9qADa5tbYU/UtdbADyp
 G6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685555251; x=1688147251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=znoH4H0+9Cjyj08GQVpDCQg30xorYSyCFsBntgfl2iE=;
 b=WRlzMsYXwHBCgydyR4drAJVmQK8vwr6WHXfI6Gy6C2cP1+PF7y3cQXC0WmL0lB5XFD
 Satbzd0/bjWeAZHFlB+e0qv2FdTXrdUzDObUg5hYh+9KOCjv/tYe2SAX6L72zSchcw+q
 yEYNYvSLlDYqhLqsqIL2BRMsSXfnXErO+ZefezU8lPhX2x0OpELSX1SRtNf2B9ZAjhR0
 5LJOGFQG3FFl0wIzmKTvJMxWxatuqdQMwA46zacLZnemjwCFzH4JLFEAajZuM7gEhrji
 8TnT4qCSpCF+fUXyz5k7XrJ8l4zQmSy6mLjR59Q+qUXRmLy+QgM8cGNxhjeV49ZajihD
 UCBQ==
X-Gm-Message-State: AC+VfDzuBtRCRLBfM7yUGOvT/xQ/pzxAwu9GyIf06aen+Xi+fiFTs6Pm
 FNlhtxwqsMILHxMta2GVpbjEeQ==
X-Google-Smtp-Source: ACHHUZ5lefXkZ3Nhl8Pt/AzFAwND0iGctrmKf7ziAijzu1qEOjNU8BD54ZQqBtMDwRP6Xr6M3fU0rQ==
X-Received: by 2002:a17:902:e742:b0:1b0:34a6:e0b6 with SMTP id
 p2-20020a170902e74200b001b034a6e0b6mr6308811plf.31.1685555251188; 
 Wed, 31 May 2023 10:47:31 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a170902788500b001ab2b415bdbsm1704353pll.45.2023.05.31.10.47.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 10:47:30 -0700 (PDT)
Message-ID: <686ffc58-4d2d-f9a9-49b0-722dcedc2dc5@linaro.org>
Date: Wed, 31 May 2023 10:47:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] fpu: Add conversions between bfloat16 and [u]int8
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, peter.maydell@linaro.org, alex.bennee@linaro.org
References: <20230531065458.2082-1-zhiwei_liu@linux.alibaba.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230531065458.2082-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/30/23 23:54, LIU Zhiwei wrote:
> We missed these functions when upstreaming the bfloat16 support.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

They look ok, so far as it goes.  What will they be used for?


r~

