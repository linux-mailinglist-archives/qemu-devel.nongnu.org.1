Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E1A732E4A
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 12:30:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA6i2-0006l2-SS; Fri, 16 Jun 2023 06:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qA6i0-0006ki-DM
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 06:29:36 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qA6hy-0006Ml-Mt
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 06:29:36 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51a1d539ffaso1285911a12.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 03:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686911372; x=1689503372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=92xWwc/xn57EVrGt32pxXKL5nOzCl0xs34WGS1IXpSE=;
 b=P08M/cyzR3ByoOAAbGav9X2nKlnEJ6MjrWNZFmgoD9Ss7uxAzFmMSHoYZdbptbD0+9
 GJr1c+6iWWprSVKLmG6vG4ew0FzdhPvhh2cTyyfvKistGOS4gCy/vKdlE9moqyT4zkpH
 A9cEKdRdXhzEZcPIOOZZ9aFk1ZSaHEnJFFoBAnW5iI973UVm1tyZVCPPEFaAio8cuIrI
 jurKGugsDtMYAyYNCPuUrf6SGeSEeRZslHGsqDdkDolO6fQGVu/rJxfKAmi0/rb4OE/X
 7cpxcu4YD6kYwL+5xJvvohgxeuOXCnoj41Begpzhc9hEhK3hRAt8/3i4onyn90Hd9amy
 ezgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686911372; x=1689503372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=92xWwc/xn57EVrGt32pxXKL5nOzCl0xs34WGS1IXpSE=;
 b=lrb2SQTnBnL3HZnWU6JgZ37HRXqIApasI5KkUuZQsZIVKjOcmxqlRLhFvKIxretPj2
 8sC1LeVe7c0U/WWVAmdOVzP1eJyAWb3icT+Yi4a2FVN9k+arJEYja1QdaHQpvAq75aYq
 zhwlNw5APpv5Wp2qM/HXlBRCpG20akXuPWBGT/aP32bX3HU2TxpRUBFk2E7tb8DmT9s9
 xkYWeQwW9S68NObnSqlbA+Ry1B9PKZWZuhz5ieNQ8SWGnePzs/z4dOCn7LspzzBzCgTj
 SDjf6lrQsKLwU+wiktMLPQrz/HklaNE3wHF7OrzcW6/viGfx56fCXFg39sCo7Ik/LFOO
 k6AQ==
X-Gm-Message-State: AC+VfDy6VUu90eAelq5RBuG0HrXKZyu4e84ecOcXZ+ep+HRzeXwE6Wpz
 jThJjkbSSnBpZ6Ss3esY+/8bVQ==
X-Google-Smtp-Source: ACHHUZ7WnxwvQNFfAZUDhtRpliTbQur5gGSpTR8HVd8O/UKCmGxcP93DvTEtFqsg6RHk2G68ct8yXg==
X-Received: by 2002:aa7:d0c2:0:b0:518:79d2:208c with SMTP id
 u2-20020aa7d0c2000000b0051879d2208cmr1399255edo.18.1686911372614; 
 Fri, 16 Jun 2023 03:29:32 -0700 (PDT)
Received: from [192.168.85.227] ([91.223.100.45])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a056402068900b0051495ce23absm9695536edy.10.2023.06.16.03.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jun 2023 03:29:32 -0700 (PDT)
Message-ID: <c8f2136b-9564-a1c7-b1ba-409c1f700e60@linaro.org>
Date: Fri, 16 Jun 2023 12:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/6] aspeed queue
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230615173525.428831-1-clg@kaod.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230615173525.428831-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/15/23 19:35, Cédric Le Goater wrote:
> The following changes since commit 7efd65423ab22e6f5890ca08ae40c84d6660242f:
> 
>    Merge tag 'pull-riscv-to-apply-20230614' ofhttps://github.com/alistair23/qemu  into staging (2023-06-14 05:28:51 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/  tags/pull-aspeed-20230615
> 
> for you to fetch changes up to 42bea956f6f7477c06186c7add62fa0107a27a9c:
> 
>    target/arm: Allow users to set the number of VFP registers (2023-06-15 18:35:58 +0200)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * extension of the rainier machine with VPD contents
> * fixes for Coverity issues
> * new "bmc-console" machine option
> * new "vfp-d32" ARM CPU property

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


