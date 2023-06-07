Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6622E726F2D
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 22:56:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q70Aq-0005TA-I9; Wed, 07 Jun 2023 16:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q70Ao-0005Sx-EH
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:54:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q70Am-00023E-SX
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:54:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6da07ff00so78992005e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 13:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686171266; x=1688763266;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tN1JAErKx+aJSR3uuGJsYjhONi3Jg1D/ZwLRtgF8Sq4=;
 b=Bv/jzFg+Pq8rYTIpeqXZ6zdY6VeCcH/+cGfOpPszqto99dJpDlk/t/4UYrpWQlF6Z8
 jN20TFs6gDsysOpkd3zRCYCL9Zooa24I9hQ6cZj0xCckCv5izVqUjNC7S3R4sNlvn6Ql
 Q3MbyidTw0KB7iaqUPcV/gMMZqO5NNAJmbQZQDl6joKC0CCoRqiQTN9GEBGSw6G3Eqjc
 swZYFLljNb7BTJITWrve8JJ+rYf63Yt+dDVySeSpvYf0vDsK4KfQwPhImT871osB1kak
 OTEcHrRsQMzZs/lc57Ac5140uF+qcDqojg6KBFvEN9n2r27BnUwui74bzwpN2n+oCtTX
 asRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686171266; x=1688763266;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tN1JAErKx+aJSR3uuGJsYjhONi3Jg1D/ZwLRtgF8Sq4=;
 b=dgXgiW6IPt8i758LFC9AbOGZMkyZWNaLPgTnQ7ZRkTnl/4Fb/SJGqxyryCNstXesSC
 9o1cYNESHJUhe9gPH2uqYbMwJbR/cmSHS7nLh6ZMjSdJv+MXTK4ovPk+WQtgc84NE0/F
 qP6OPSSpt1k80kSnXRAawjIu+KL+kmLPgC0FhJ1CtZYvSSHCAFc/oKalDGIueDkZO/tF
 dgVWkAcTPIVtgkxi1aLsFbMDdSRUwXF52dp/8x3ON5G7wCRdzvJEVjF6dl5A5uhIZ5gJ
 Xmh6iLb5VcndxOTbE5nZTCiWijtaZezVZHj29gCrgi0tGY1ctieuBJ2I1zYwL4esusaF
 VcBQ==
X-Gm-Message-State: AC+VfDyAvl9iaxe2dk+hI2VkrFDDoq0T2ALz7LmQmUNyfDLs3hRb+ucT
 TbLtU8/XXIy4LC9L7B61BUbkPg==
X-Google-Smtp-Source: ACHHUZ4y/bM9dvsQ5omBMQ2bM6xW4N8zd3l7R1CjlnsA6QNn/NZ2OL/GoitmInbLozmgftNJBU3nzg==
X-Received: by 2002:a7b:c3d9:0:b0:3f7:36ae:de6d with SMTP id
 t25-20020a7bc3d9000000b003f736aede6dmr6104167wmj.6.1686171266187; 
 Wed, 07 Jun 2023 13:54:26 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 p13-20020a7bcc8d000000b003f604ca479esm3225986wma.3.2023.06.07.13.54.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 13:54:25 -0700 (PDT)
Message-ID: <fa0f4c78-741d-d864-7094-d80af5e12144@linaro.org>
Date: Wed, 7 Jun 2023 22:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 1/1] maintainers: update maintainers list for vfio-user &
 multi-process QEMU
Content-Language: en-US
To: Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, elena.ufimtseva@oracle.com,
 kanth.ghatraju@oracle.com, karl.heubaum@oracle.com
References: <cover.1686153256.git.jag.raman@oracle.com>
 <03122dc6dc27f93a674991ef64874170fe8d1a4b.1686153256.git.jag.raman@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <03122dc6dc27f93a674991ef64874170fe8d1a4b.1686153256.git.jag.raman@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 7/6/23 17:58, Jagannathan Raman wrote:
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 436b3f0afefd..4a80a385118d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3786,7 +3786,6 @@ F: tests/tcg/aarch64/system/semiheap.c
>   Multi-process QEMU
>   M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>   M: Jagannathan Raman <jag.raman@oracle.com>
> -M: John G Johnson <john.g.johnson@oracle.com>
>   S: Maintained
>   F: docs/devel/multi-process.rst
>   F: docs/system/multi-process.rst

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


