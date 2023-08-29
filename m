Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3452478D02B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:17:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n2-0000oY-HG; Tue, 29 Aug 2023 19:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4rC-000207-Dp
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:58:34 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4rA-0007L3-7r
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:58:34 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bf3a2f4528so37860015ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693339111; x=1693943911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6aYvgHMRz9Dv1CzsREAP6G2FclTrXwVLwGri54OLaJY=;
 b=IDAD+eNvOMMTgyUE/JO3jS4LiibCeyhYwRn/CG+7iyxtXJLNrnbx11rgd3pRBCZ8i0
 KsVHShUFr1p7ijiWN67+/3Zy3pyQpABgYA081MkaTnA5RJFDfNOH1HMRMfhIufngXR7R
 BWy9THoSHSnLaVtJ1x550qSEOjkduhAJDteJyI6u0v1VKjj4KCaxnonuNe38DI7lYOkv
 03ynQfq98kMNg/iiWjlOB/chtbNd7IcHJ4m3tJBNjjkXCzVwbXScKpo9P4vEhWU/j4no
 B5sFY7jxlHYwxFbKnZaNBnaVwhOOsyG18COAbIuKdQjfJ3rahF1dxSK5rjAfebUcTGcd
 3s6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693339111; x=1693943911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6aYvgHMRz9Dv1CzsREAP6G2FclTrXwVLwGri54OLaJY=;
 b=JcGv3kvQDUXiLQcrTfnbva32bGy+PgjTJv7WrDJiQZVenYIxDCdl1TUgnWkJSGCEdV
 kpX/KYPT6jGWybvn5D2xtVvPuE553d+XdENUifoUAZ0AOgXZa9GyZnrd2oSCN3z/2GOy
 vRaqyI/DEiL5wBcu1gHVfqPRx0xg4190YmFKfIEFP3DttUKMf4EY4XGjJfjFWGRRTjhy
 YXNvyaXyzPJaHExPCGR2In7u6Kq96jz1mfubo0Eq05EHRLvoWeAb6PPI5DNbKuc+Ob+o
 ONmTjM0fe63NrRiFiNAHftzhDUDgT7LWztatnbEIrj9niqJcPQ6NJirTwi6T7snqPM6X
 qcQA==
X-Gm-Message-State: AOJu0YwpX2IStEY7EpyBvGjg8JKuD5q+T/WyOgCDeBOzI2r96koV/aXn
 Kb5FohtfMdQwhmQxhF24xXmoch1gSDqztlgC+f8=
X-Google-Smtp-Source: AGHT+IGk2I5X/V0FQ0ZJXuaiha1kINXiLw13SMZjmRzerio8MnHmMxhT9Itu4h08oKRO7oAitpGZBQ==
X-Received: by 2002:a17:902:684c:b0:1c0:9abb:4873 with SMTP id
 f12-20020a170902684c00b001c09abb4873mr100751pln.64.1693339110704; 
 Tue, 29 Aug 2023 12:58:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a170902bd8500b001bdd719874esm9774171pls.168.2023.08.29.12.58.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:58:30 -0700 (PDT)
Message-ID: <7096d95e-b8b0-c542-5356-687459afa3ce@linaro.org>
Date: Tue, 29 Aug 2023 12:58:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/32] bsd-user: Implement getrlimit(2) and setrlimit(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-16-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-16-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-proc.h           | 59 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  8 +++++
>   2 files changed, 67 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

