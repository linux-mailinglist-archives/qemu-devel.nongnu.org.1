Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD557E28A7
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:29:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01Wx-00038j-5U; Mon, 06 Nov 2023 10:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r01Wu-000323-Pt
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:28:44 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r01Wq-0003Er-34
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:28:44 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-54366784377so7590334a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284517; x=1699889317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4RnOAHF5iuWV2ZBnAN+/HojEW5P0edsTIol+MB8qYfU=;
 b=gKZI8zC3O4jN+WFhbEAtJQ5zo81bJgzHpLlhFJCuipZl3oRgsW8ZapiG8uaRB1zb+b
 srtWtW+uTO924gZFCucvyEkbcWbeSX+z8BZrseitf9XmEJV4rdE033qK+5B2NI0qSAEg
 ex6oY1RMjek5wM9H0lb+fGvfrldQ6rvUGeWkjxC6dbijtoVPqG/aiw3oJXBD3zNuxRav
 ovs0r/unnqsyjqOr+BlHPp3QVYgv1jrA02SHuelkvfbQCDYfo7AfN4YJgP4Ho4mXhrJ1
 fzx1T1yerbfbtRyiO6N6NeSHXNmXaDPKlj/xiXLDwHmZ9ggaiWPk56jlxI9rD9uoUWHc
 CqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284517; x=1699889317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4RnOAHF5iuWV2ZBnAN+/HojEW5P0edsTIol+MB8qYfU=;
 b=FwCsWzmmBtPGcE57DXLPi3D/NzYbhBdjhgjLjMLxrvllwpc7qRPA4y/cwD4seCbw2k
 okGKw6bFCLrzZuIiUpMmqLeghF8oULj+cqWVJ4nF17K9i8xizds92c9TGQRtHlRBopIt
 hYvra4O4nigkttOQVQNptmGGZ53N3mqvFZHehYods1wNnFDf2nBHhTwyDBJszeDiglCc
 JC56D8ms2NKJhn1rST/yJaAdjzRshx7ZCj8WVy6m0800y5He44qsGKUJXJ4z0ZM9bFxK
 gEt7jtFM7tSLVECHOlW/v1q5uVMTR0v2QpWHj5hkjpY8dE6H+NzXR8iyIT8dLG3aenAo
 iutQ==
X-Gm-Message-State: AOJu0Yxg+zFSgL73Xy2LwKXUI5zzjDeOoF41dokI+Ajenlx8e8KWdqz+
 RPobDUFGpJyfUiCEMHMvx6xmXsNO9G6ECQKHZHQ=
X-Google-Smtp-Source: AGHT+IHTYzxDmeUGTijgjfaJ5M3PI2IwvLeMgojOFFwxiUlZ9IMehqMCIBY+4DHsmuFxyV9zOq0ZNA==
X-Received: by 2002:a50:8a9c:0:b0:530:7ceb:33c with SMTP id
 j28-20020a508a9c000000b005307ceb033cmr28062421edj.4.1699284517453; 
 Mon, 06 Nov 2023 07:28:37 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 y93-20020a50bb66000000b0053e6e40cc1asm4570744ede.86.2023.11.06.07.28.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 07:28:37 -0800 (PST)
Message-ID: <dfec2372-5504-1320-ec14-0da6bbd66bfe@linaro.org>
Date: Mon, 6 Nov 2023 16:28:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 02/35] tcg/optimize: Split out arg_is_const_val
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 28/10/23 21:44, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 38 +++++++++++++++++++++++---------------
>   1 file changed, 23 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


