Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5AB73D907
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:00:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDh8o-0002lf-7Q; Mon, 26 Jun 2023 04:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDh8m-0002lL-Nj
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:00:04 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDh8l-0005VV-0c
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:00:04 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so3596363f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687766401; x=1690358401;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hy7c0DsZKMxve5yBHkUFYNt1FdKf5og6FsP6ARfi7WU=;
 b=OaYiLBXgIur3xXWnrZlPpy0aAedNH/2QcLIUpqaoLln080onmqf1PsbuvZG2FyMwC3
 JYjAPTR+tDRbyJUDK3aiJkR1hj2gfjE8eio8yVAzIKlJJcOgkpn9QH/EVqgmXJJ2knjt
 IhzbIGvi6RjQ3lFG27+Tyi6mMC9JclaN8UmFum+kkbbyzl5sOyirdSgAanVMphzCCIbD
 PXBu9p0zs+jH4HQqMvNfEw3oJ+JB/PXumcIAl5dQRFVaG1Xr62e0RaJEejgCI46lRwjk
 4hsFyuQTvedhpUn3mtAKnIBn1bX6zwrgY9i6UvU07/jMWCZ+wgT5od66fqiYqyDzeze9
 hJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687766401; x=1690358401;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hy7c0DsZKMxve5yBHkUFYNt1FdKf5og6FsP6ARfi7WU=;
 b=EeSzIUvPx5FwMe7mlcI7b/ab97VDlu5/oWPuamNulOkDtFxeLzLM/tW+BVxpHyRHVz
 rgGrOGVJQQ++wBooDjTSYVFyBiFoYfKOs3+VQz5BtEF2CLLxYQXsCQIgnKhnAs1oPcTv
 4P+R/qj7IaGYVrTaTYYB/eLIjGUJTBAfJmEsnfqnvc5B6Xce0P6UGAVEEQFsJ3hYeG2N
 Lfjx9+3g89IUK5L39lH+93c/Cbb+FMBmB22Vtg8FEiJO8XfOS1ZtjQIZ/KwpeBvukf0P
 HRsmY04KvNM06E34ST1+B63j2r1qe+hL5elAXyYN0OCSXcJJMMb2jh86vmFRtKrzOSl5
 C9Eg==
X-Gm-Message-State: AC+VfDwRhID6ookudB3lEJCvVc/T9KhJfd0qAQZGRcfEGscZCTG7A3hx
 byaAQhEukQkLXQv0d2gL8cSiWg==
X-Google-Smtp-Source: ACHHUZ4laLjtXICoz5giuBkITSM0J7HqAOFrhpYpl5GvMYhB3u811fDHq+0NTd9O1MWHsMAdjFwrww==
X-Received: by 2002:adf:de88:0:b0:313:edaa:2504 with SMTP id
 w8-20020adfde88000000b00313edaa2504mr3061550wrl.25.1687766401264; 
 Mon, 26 Jun 2023 01:00:01 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a5d4561000000b0030e5a63e2dbsm6592567wrc.80.2023.06.26.01.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:00:00 -0700 (PDT)
Message-ID: <9862c370-248d-dae5-7537-1c7dad9e263b@linaro.org>
Date: Mon, 26 Jun 2023 09:59:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 03/26] gitlab: reduce testing scope of check-gcov
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623122100.1640995-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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

On 6/23/23 14:20, Alex Bennée wrote:
> This keeps timing out on gitlab due to some qtests taking a long time.
> As this is just ensuring the gcov machinery is working and not
> attempting to be comprehensive lets skip qtest in this run.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

