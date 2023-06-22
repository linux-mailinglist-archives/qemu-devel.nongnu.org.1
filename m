Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE1739C40
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:11:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGK9-0003I6-G2; Thu, 22 Jun 2023 05:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCGK7-0003Ho-UM
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:09:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCGK6-0001SB-Cs
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:09:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f9bece8d1bso17249815e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687424989; x=1690016989;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k/EKZiQd1ey9p4aWa6JWppu/xXDSntzofpZsOMYMFlg=;
 b=DdqjcZjys6K0mOTtuFVKrnCK3L5OnsH6q7Ko/s5ncO+luTrONwdD4rOjM+b5G/AkhD
 jb4ht3+CvfBelY+LJko4ju415w+F8HtRla1+cezkZn3IN5tdu9Vu+DbUd+Mut1zl/b+1
 eD/BmE0ZHg9MwksK//9tU75HTNhv4RCddMRzAlWxj3KSzeaKFmvgg05DzNPCQC3m9IgN
 uwix3v/UhJ5FfFr6p8qo3FuQxZyc8DjSAjHcztDJ6EcEEAS3gcj+bqBT+BNu/IgEBOZE
 HqHdCXm5rjobLuXnPOsua850azsRLRJGW0MiWQXHCTZmJYIfNHecrLv9Xel0N9DBylCr
 1VhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687424989; x=1690016989;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k/EKZiQd1ey9p4aWa6JWppu/xXDSntzofpZsOMYMFlg=;
 b=lbhTc+rGS2vVigy73Xw/jbW0BuGxr+oRr3mPe7fvpEKAiaZ0nByhed1kqz18eY0Pkj
 Rxb5azG6oYJQxQCOyM/9Ad9YWABmAPzr0SU7BwntBwGKp24Fse5Xu+NcQE6nIkiNZvx+
 cOqsXiMS/rVxp2NHSSq7TV2E0DbSrzfxfmWpnsVbzX/FWXl9sbfS3/qN8ngyS4fqmEO5
 Fv+uFotcyEXU6akZzLnUVQDiopHE8COBAYJQ0PFJgYpn/kfaNeTNq59p2pXkPvFg4GOt
 86ubEw4tgd4Z5QPNdub21lp8gHPpkJJC920PLvQR02+u7O3Dp/3Yo/hYMzylTuCY5Df5
 nkHw==
X-Gm-Message-State: AC+VfDxDNStjpUrJR6UiBknMOb5rmLyMfDow8SSxVnhTBAMEhj+6sgGJ
 uxtKMpXjtZaloNJrAOuTsf2DrA==
X-Google-Smtp-Source: ACHHUZ6HA4VGP504KXEtSaD6GnX/N1N9W0VXsV5pTJYS8z/ia89Z8p03q6ZIG9Sx5G9KeTsMHJDEBg==
X-Received: by 2002:a05:600c:204d:b0:3fa:7810:8cca with SMTP id
 p13-20020a05600c204d00b003fa78108ccamr116127wmg.26.1687424988809; 
 Thu, 22 Jun 2023 02:09:48 -0700 (PDT)
Received: from [192.168.69.115] (che77-h02-176-184-42-18.dsl.sta.abo.bbox.fr.
 [176.184.42.18]) by smtp.gmail.com with ESMTPSA id
 z3-20020a1c4c03000000b003f9b3ccb815sm8947191wmf.1.2023.06.22.02.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 02:09:48 -0700 (PDT)
Message-ID: <712f1d4b-1ce1-2c6f-1279-ab88d5adf3c5@linaro.org>
Date: Thu, 22 Jun 2023 11:09:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/9] accel/tcg: Renumber TLB_DISCARD_WRITE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
 <20230621121902.1392277-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621121902.1392277-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 21/6/23 14:18, Richard Henderson wrote:
> Move to fill a hole in the set of bits.
> Reduce the total number of tlb bits by 1.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h | 4 ++--
>   tcg/tcg-op-ldst.c      | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


