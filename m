Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AFF72A1CB
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:06:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7gV7-0005RT-EH; Fri, 09 Jun 2023 14:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7gV6-0005R6-AN
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:06:16 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7gV4-0007uR-Q3
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:06:16 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-51b4ef5378bso993030a12.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686333973; x=1688925973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z5me2xa+ruM1rriq38vBZUetOjhR2d3Ub4n9gxXOazs=;
 b=d+lS0OoNiAlA4Y4t2Vi9QbKGjC7ynlcCreLCZnCM+51yTEyLNPh0lQNKsTV8CYEDfb
 qfBqErH/jnJJWvCxs1g4ewsdx1CGbKC7s3GJx17hgk+Auwv4UnUsr5mTeYyZVBb30QFN
 YlCHBn8yp2KnauXjySewHjuPCBVl6Rwam/5itEpGO++PZGCmYkpRtt8NdrYNUy5W/zcZ
 12J30x5CDDd3KjlK2F5GFr0OWoCgEzIuVVfAT1fZNkkDLPOcSj0r99r/ukdsiRUFcCyN
 YgD7ZpEdWg+7KwHOrNlc5/vjJT6da4XOW8vV/+6v6ECUg2EIvzITQWmvtj9f3elqB1BB
 V5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686333973; x=1688925973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5me2xa+ruM1rriq38vBZUetOjhR2d3Ub4n9gxXOazs=;
 b=C2C4O4ueSWXWxQ+nvdhavb6crUaKg1xPlXBZOTEOE5E5GMVMGAn7X/2Z8dVR/iIG/Q
 4oi2n6R6L8J/w0sMILDyHuegsigaxQqtLzl/rFhsSNo0Bko5hLGe0v0ylQ0/zy7hC1zq
 2pjhJtrbIimr7ZJoyaFjVzhSlKI/iIIGil5Z67Gjeg/kk+WbalNuHXosCAaDaGl7bUtr
 QWuL9RQk5S+zPjK8e4EXeSWS9b46tGoHwLKHSReQVaLiNaOPFupJF+U6kk55JzCDZAG7
 7fEBhaspzXP5vQ8cckG/1fqNrVBqVzi0uJ3oUxhhS5WPVULAen9KRGhzg24l+xin9Dih
 sAew==
X-Gm-Message-State: AC+VfDwEA1ET/uN0/FDhysPOOJMVhc53ncrR8sr0HR26XoLDBtQYKzds
 lI8wFFLGZhcsNnrAeDFTPMcZNA==
X-Google-Smtp-Source: ACHHUZ4XJZPZ0tL9TMOjODpKljGgd5lToUmFuaZOw1TF1jR1EQpuM6sU043u3TTagU8O2/JmDTwyMw==
X-Received: by 2002:a17:903:249:b0:1b0:6544:1d4 with SMTP id
 j9-20020a170903024900b001b0654401d4mr2270869plh.27.1686333973223; 
 Fri, 09 Jun 2023 11:06:13 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 6-20020a170902c10600b001ac55a5e5eesm3564650pli.121.2023.06.09.11.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 11:06:12 -0700 (PDT)
Message-ID: <430f8aa6-bee8-fa29-96ec-3fdfcf008eac@linaro.org>
Date: Fri, 9 Jun 2023 11:06:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/arm: Return correct result for LDG when ATA=0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20230609155457.87848-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609155457.87848-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/9/23 08:54, Peter Maydell wrote:
> The LDG instruction loads the tag from a memory address (identified
> by [Xn + offset]), and then merges that tag into the destination
> register Xt. We implemented this correctly for the case when
> allocation tags are enabled, but didn't get it right when ATA=0:
> instead of merging the tag bits into Xt, we merged them into the
> memory address [Xn + offset] and then set Xt to that.
> 
> Merge the tag bits into the old Xt value, as they should be.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: c15294c1e36a7dd9b25 ("target/arm: Implement LDG, STG, ST2G instructions")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Spotted this while I was doing decodetree conversion stuff.
> I guess nobody runs with MTE available but not turned on :-)

Indeed.  :-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


