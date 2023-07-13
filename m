Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B202752A4E
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 20:30:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK13n-0007nU-Ur; Thu, 13 Jul 2023 14:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK13m-0007nG-5r
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:29:02 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK13k-00075O-Ce
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:29:01 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-403c653d934so7928251cf.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689272938; x=1691864938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=17j90EH8n7nIALhhxhY9RcLMseNefN+FfaJAuNQXiDQ=;
 b=BQihItzTb77krOw7tKkCNb4VE6fvWdOksQMzkPVdAmInO/6AwsoydFCbveBiwI0mWT
 tG42BxKwksqePhu0uGW/LcY4O/MPZEPkh8pq/yw7gvcJVCp9TUqdq7Jr4gjtXFpFJ1gQ
 bBxPgptGcW3lFKkR8TGprjONC7GIN3qM16BFu7nq5hubo46+fN3Mu39uAZe09BVNtaeY
 JEogpcWto1H8dcM6+p4w3yQcbKWVbyUImTE6YPB+XIuCCSR3sJP0hBNchRhSYeYGfUMJ
 3+iij33bXRrRG5BajY2JBmAIJnC9SKRDeKI3ujaaTewZQWUCk9dkvmT4a/jrh0e/yjWs
 /orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689272938; x=1691864938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=17j90EH8n7nIALhhxhY9RcLMseNefN+FfaJAuNQXiDQ=;
 b=cjypMCFSmaWDb0WXCuxZUmea6ykffSjkqmU60o66/1srCjbnJKXvf0KkCfZ6ObcEu8
 L1SXIzUXHJjKk5tX5fmDUijyS3iL06eb5dA0RGyZ7eWdlHVy82GOdtOTWE1I2KnPzYNw
 Z/yDWdr9MVcfZObm+0xT112QfpSS7sVcWy/6v6FLaorNyVrUhsF5uAQ02eKWJBBLesXp
 G8IglrQ/L1C8Ks/8g8dvuccR3yK789RLcbLUKZfSZFJqZgL2m3Tahv2xB8xnwYc2BR75
 7Ebxkvl+cFSWkmXJ6desZFLKB2ZG484cDB8AViMs7zDF0H7pieQGezi0jBvt1aZIC0xS
 I0eA==
X-Gm-Message-State: ABy/qLZ1cfEeyUB+ZR2+SFeIlcwwR2z+T/nKAL7upEo4TO94eP+mUz6Z
 e8LaFC+dWVsYOYRcjBltTUa//g==
X-Google-Smtp-Source: APBJJlG6SkSid0U5gsp6a9P4vv7leybID7nSvC3xvJ9uqcYLqkw4ty+APnB/dIQlLikmCMEasWAYFQ==
X-Received: by 2002:ac8:7d10:0:b0:401:e29c:b1b6 with SMTP id
 g16-20020ac87d10000000b00401e29cb1b6mr3146955qtb.39.1689272937801; 
 Thu, 13 Jul 2023 11:28:57 -0700 (PDT)
Received: from [192.168.88.227] ([172.58.139.107])
 by smtp.gmail.com with ESMTPSA id
 r18-20020ac87ef2000000b003ef189ffa82sm3246825qtc.90.2023.07.13.11.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 11:28:57 -0700 (PDT)
Message-ID: <e0d55ddb-3960-6ff3-e480-6f2fdf2d1407@linaro.org>
Date: Thu, 13 Jul 2023 19:28:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1 2/3] target/arm: Fix S1_ptw_translate() debug path
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230710152130.3928330-1-peter.maydell@linaro.org>
 <20230710152130.3928330-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710152130.3928330-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 7/10/23 16:21, Peter Maydell wrote:
> In commit XXX we rearranged the logic in S1_ptw_translate() so that
> the debug-access "call get_phys_addr_*" codepath is used both when S1
> is doing ptw reads from stage 2 and when it is doing ptw reads from
> physical memory.  However, we didn't update the calculation of
> s2ptw->in_space and s2ptw->in_secure to account for the "ptw reads
> from physical memory" case.  This meant that debug accesses when in
> Secure state broke.
> 
> Create a new function S2_security_space() which returns the
> correct security space to use for the ptw load, and use it to
> determine the correct .in_secure and .in_space fields for the
> stage 2 lookup for the ptw load.
> 
> Reported-by: Jean-Philippe Brucker<jean-philippe@linaro.org>
> Fixes: fe4a5472ccd6 ("target/arm: Use get_phys_addr_with_struct in S1_ptw_translate")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 37 ++++++++++++++++++++++++++++++++-----
>   1 file changed, 32 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

