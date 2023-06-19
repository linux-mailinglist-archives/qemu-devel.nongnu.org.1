Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5EA734C4A
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:20:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9BQ-00014n-0q; Mon, 19 Jun 2023 03:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9B0-000139-2n
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:19:51 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9Ax-0007wF-KD
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:19:49 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-988b204ce5fso79494866b.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687159186; x=1689751186;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lUG5dAWEQ0QTbRWaC2KRy9uXzpkouJG3w3hGEusKCZg=;
 b=BDKVbj2lv0hKYWAabFL5+QhOdlsKb1AVN1MpMzDmBX+i6s/8wGyI7D/ysbooJdkMlX
 JN1PWB6TruIX3eTDBSKgDCfi2qf2fO8PlImx4pHtC/L5OCmVx4W/qVAXVVGJTN2BDJEd
 nLfRJeZWF9yJ4PP5RD7Oq1zUIhAC2IPzAZHr/xTJxmzq2prJHPWPfITrfRyPXc0AOjPx
 MYo4M68y74Cn9ltrpCok9JJmeQBADJb0qbk7vFzi/Xxyu8BTJcSE9xeDdocveV84xwhG
 6tra8ny1HxLzFPBYJJAjYYJUn0EtWGeTApzQXAmf1SHPwtIqFrjlRUv5ZhIZYoZ/xDa/
 Au+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687159186; x=1689751186;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lUG5dAWEQ0QTbRWaC2KRy9uXzpkouJG3w3hGEusKCZg=;
 b=SvYhyGvMFkAZtlXcTXucbRb5nTHYtSEpIkTjT5qCVJZjmNwtDCbl+hbSf3jt13epgb
 1cPS3buD2sio3lav4r6KJT0ug5GLz/lCArYxhNtJwDcIpo/qSMOVmuQuGMhLP3B15Gsg
 9iFP222a4uG8Y9GqzVK/B38QQsPfe9312RlOLY/uBynHmJysu8BaIAuynVpMCIPmxci2
 srlExesTf9ORKYIPJXNgnR/gC9hLnLDOsFKosj8e1JA6IUS/RxWJ/pQ0QyDMzTvL2c8U
 S+bIzyQr7vsw2idpGjyqrMJSFYpx6ilc6pJjOVgMI5fAmxMGYCw+zpw4nKWikwBHB8FS
 Ph1A==
X-Gm-Message-State: AC+VfDzFcr4KIHA2OsFm/tVgVthL8OGXMCzosD79BfQQwXywdmXH1YQY
 6Iz1vANNdwiOUShEsD0v1NR8ioZJuqRXmvENNewISfTr
X-Google-Smtp-Source: ACHHUZ4DAzL+Z6jMDJ9Ry8e1L503NGPpanH6Gi9xoO8lBGKmgkYh/V3SuxZXAS4uCoMBgpINn1E/rw==
X-Received: by 2002:a17:907:161e:b0:953:517a:8f1a with SMTP id
 hb30-20020a170907161e00b00953517a8f1amr9240650ejc.58.1687159185921; 
 Mon, 19 Jun 2023 00:19:45 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 d18-20020a170906371200b0098282bb8effsm6667682ejc.196.2023.06.19.00.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 00:19:45 -0700 (PDT)
Message-ID: <d1a47235-7e68-b4a4-1791-87266f066abf@linaro.org>
Date: Mon, 19 Jun 2023 09:19:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/7] target/i386: TCG supports 3DNow! prefetch(w)
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230618215114.107337-1-pbonzini@redhat.com>
 <20230618215114.107337-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230618215114.107337-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
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

On 6/18/23 23:51, Paolo Bonzini wrote:
> The AMD prefetch(w) instructions have not been deprecated together with the rest
> of 3DNow!, and in fact are even supported by newer Intel processor.  Mark them
> as supported by TCG, as it supports all of 3DNow!.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

