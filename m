Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0396279D68C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:41:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6Ro-0003gF-V1; Tue, 12 Sep 2023 12:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg6Rn-0003fp-CA
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:41:07 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg6Rj-0003ML-Tk
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:41:07 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bf66a32f25so74896031fa.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694536862; x=1695141662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PcVXSNi2OG+n4/UEWodX/kmsqoARu0+uN0FaHJfjfq8=;
 b=qGeKMwpTNYkRc/UK4yI/xn7fTC40QHDYi91D9O4C8lqJvjm3ZW+nmo41Rtv4p7qYz3
 XRP2jonbphcnX9IrtkHralQ4iv4QYhPA7Imoz80n4Wlgf3jnxQxC96c/5eDmDLNUr9Mz
 8/bfS4cwVEQohvSbE0sDJ5ZluExkhY7MT1T0A5Mjxlgt3cftoK/5VC0fIRzx6PughOvB
 bapjYxlkzGI8RQxFzW0CXP+Xfnx/PuIhwtT243VvR7/NQnPyBqpI/h8WfBD9Ff0FGy3x
 r9HViFJZnxE1GUIyWPSOxJaw2Iyl2rZkH/3fzhWkbMGAlLKZ50T3DyihnVxSYhUjx56K
 O7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694536862; x=1695141662;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PcVXSNi2OG+n4/UEWodX/kmsqoARu0+uN0FaHJfjfq8=;
 b=MRPuW0HSCtS6C9qb/z9CZu+dAv6hpCBeUHTleIk+1Xn2RgASYpEJ3Ci2q+8DygKNmr
 dX21ZFjPfSNf1QN9snllg9ZazIduyhuqc6RwSBi37NyCUM5WzFXMhZt7ijeQa6JU8Zn/
 RHOaDcgBKTXO1a3JbuAUeE6e7A2xkoRrgj139Gqv1QQIMqTzjn0JBpUf0drQw5w5nFaN
 exrbuaY29Xc/RfgKZnpRH1SkCA/NsTedG3XvjNDszTLozXdwgGh//DR/PDa9vnQ2C+mE
 KE+bzuDbJfoj6QkPNiaDXkOtxrMwOKB16+wlqR/OLEREfwI1aDaY3C/udSGjX0ysJIUb
 eHgA==
X-Gm-Message-State: AOJu0Yw5+tBrxnNllUJ/aTp2vnKGCheGY9+WTnw4RrP5UNbXHSFeDz9F
 DUyvyB4/Asb0l1SkzB+uSyC+rA==
X-Google-Smtp-Source: AGHT+IH/s9a8hPkCKfIdQLFqBuT3KDtjmStAwUT0MWJDZzltKYcPi2vGdet1mTCNDgGaEheocE7fxg==
X-Received: by 2002:a2e:9c95:0:b0:2bf:b106:6296 with SMTP id
 x21-20020a2e9c95000000b002bfb1066296mr298114lji.4.1694536861952; 
 Tue, 12 Sep 2023 09:41:01 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 oy26-20020a170907105a00b0099d45ed589csm7055644ejb.125.2023.09.12.09.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 09:41:01 -0700 (PDT)
Message-ID: <47336aed-d6e9-a844-d7ee-1f8944cbb882@linaro.org>
Date: Tue, 12 Sep 2023 18:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2] hw/i386/pc: fix code comment on cumulative flash size
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org
References: <20230912155553.82514-1-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230912155553.82514-1-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 12/9/23 17:55, Laszlo Ersek wrote:
> - The comment is incorrectly indented / formatted.
> 
> - The comment states a 8MB limit, even though the code enforces a 16MB
>    limit.
> 
> Both of these warts come from commit 0657c657eb37 ("hw/i386/pc: add max
> combined fw size as machine configuration option", 2020-12-09); clean them
> up.
> 
> Arguably, it's also better to be consistent with the binary units (such as
> "MiB") that QEMU uses nowadays.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC)
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
> Cc: Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86 TCG CPUs)
> Cc: Richard Henderson <richard.henderson@linaro.org> (maintainer:X86 TCG CPUs)
> Cc: Eduardo Habkost <eduardo@habkost.net> (maintainer:X86 TCG CPUs)
> Cc: qemu-trivial@nongnu.org
> Fixes: 0657c657eb37
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
> 
> Notes:
>      v2:
>      
>      - use the binary units MiB, KiB, GiB comprehensively in the comment

I was going to suggest that ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
>   hw/i386/pc.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)


