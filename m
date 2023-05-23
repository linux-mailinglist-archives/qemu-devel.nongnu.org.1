Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28170E41A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:03:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WLJ-0005Xm-Mo; Tue, 23 May 2023 14:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WLH-0005OZ-B7
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:02:39 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WLF-0006Ci-Dh
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:02:39 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-25374c9be49so5065826a91.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684864955; x=1687456955;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7X7SJJFTX6VqYvEgW3088kmNsOYaP7q2C7SOOOgxAYk=;
 b=JZjbCJFdE7jPZ4cT6fxDdqyvSDhIWkXP+Ic4YfuY+/s7g+jS/R2/Q/UN+Dwmdp6XVr
 59cPgDBsb9V/iFHQwFeAzJb4G94ynqmMjWPOcat333PdxSaiGfsDQDFPGgKR7JVwo084
 3RSmv5X8aSTfTay8p/cxdOm0/4uytpxBS5h/hW47Ln81NJ9D810pnASAuAaqsrf8BG9t
 2HW02mb0Uo5zskJKgtYPEovscUbUZf4VU1eWhX38XqS+18Tv0bEc36ilH9c0Vksdez0+
 2bT6nDUP8hykQREt7cGrpqSTsgT1f3VbtJVrL9KW+2VQ1PEaUVNHltqHRCfzMv3nxXZr
 +NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684864955; x=1687456955;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7X7SJJFTX6VqYvEgW3088kmNsOYaP7q2C7SOOOgxAYk=;
 b=IzW4A/3XkHSauKSeMF6JjyOKqESq4w6IQ56hitqGVnt6/o4CcKDvalaDB3gxDSJDcZ
 ZCWeBAIHL+0fSY9wy5ovod29jd72vrmflJJrKMuSCKCIyqs/00N8SA56tq1gBaL5bF98
 eHnxm66ZXl9EOp4ohR0bRY3tWnT7eaGIkSThWCCpE9yHNrw7r0XSazFrgHR1topcbvGm
 CR1GijU641yGjGc1cmMS/kdpzgG7sIrWMUTNPD5pYS3TPFfhKh2hH3GsFNMfmaKxwD/0
 5MdTFUEAGxQ/Nwd4UI2NzvfQ6Qz9z6CiEGtDkY6nwrGdeiZ0hkO025kh1GoCM8LaFY5f
 nGKQ==
X-Gm-Message-State: AC+VfDzr6kMEWiBxNYu8OBoMIKkwJmT8OO0hq0/mNNVYZzI+J4zzDP2q
 LySPb/5hKJR6p1IrU4EjAewG1w==
X-Google-Smtp-Source: ACHHUZ5ZnS3e74VOYZdhZiFHq63GhdO1yQDeoJKF6MFWt/gbHKGxu2i272mpd+ZaQ7VCDUG5ACj1dQ==
X-Received: by 2002:a17:90b:238f:b0:253:3a2c:df52 with SMTP id
 mr15-20020a17090b238f00b002533a2cdf52mr13883233pjb.39.1684864955595; 
 Tue, 23 May 2023 11:02:35 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a631b4f000000b00534684201b0sm6338792pgm.27.2023.05.23.11.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:02:35 -0700 (PDT)
Message-ID: <89fb0be0-4d01-2e4d-134b-0519e618aa5f@linaro.org>
Date: Tue, 23 May 2023 11:02:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/6] scripts/decodetree: Pass lvalue-formatter function to
 str_extract()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230523120447.728365-1-peter.maydell@linaro.org>
 <20230523120447.728365-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523120447.728365-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
> To support referring to other named fields in field definitions, we
> need to pass the str_extract() method a function which tells it how
> to emit the code for a previously initialized named field.  (In
> Pattern::output_code() the other field will be "u.f_foo.field", and
> in Format::output_extract() it is "a->field".)
> 
> Refactor the two callsites that currently do "output code to
> initialize each field", and have them pass a lambda that defines how
> to format the lvalue in each case.  This is then used both in
> emitting the LHS of the assignment and also passed down to
> str_extract() as a new argument (unused at the moment, but will be
> used in the following patch).
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   scripts/decodetree.py | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

