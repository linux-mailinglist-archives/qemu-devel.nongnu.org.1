Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF62774D23
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:37:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTUNq-0005sz-BB; Tue, 08 Aug 2023 17:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUNp-0005sr-6c
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:36:53 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUNn-0002lk-M0
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:36:52 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bbf8cb694aso52389285ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691530610; x=1692135410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bKyqLjCsF5XMLfaNz8tw3ay9JwVMxWMccJaZbTzl1/k=;
 b=TdKvRG8aG0IrQzmL242GUx9x3GYdqMFmnA/5dHRDX47QE6ULkGkfQHKROXRqpF76FE
 JHcv5cQGZH930GBuPMr2eqaP/2eEjYkLKlHYK6WLqOiQixsNIat4KffpVI9PcHUrPCuU
 Na9qNmPrIq3EFzvHEwtli4GTog185FWs6n5YC/oRM08QA1TveaSslCnTn/l0htzI0GOW
 1mt8OswdZqpAN4w1IR4muQtpur8oD3eQEag2xWdGE3a0uIgFYEmomlrkwT2TmTG2I6xV
 zjq7LLnPtXIRzSr+kzHeYPE9r2KwLzroHu7SHEcQVxI6PjIT4bKOjgTQ7wu0Xxx/KLLl
 467Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691530610; x=1692135410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bKyqLjCsF5XMLfaNz8tw3ay9JwVMxWMccJaZbTzl1/k=;
 b=QqjvZUzqiqinnMPJongWNNQY1nDfekOG1XqenY7HMyFzSwU6BMBhPeEXhTz+xBYHSA
 DrV/f+PY7TroPc3lcGLXpMwlS62UPc/ErvqFX2qehx3a1d8IaRjRLbRCbDF1AL/A3Vvl
 YplzX71F+wzWEg/f+fepTThbj2z54Kz67s8id9pRJsSro7eG85C1NpjAJCAFKzLz2GZP
 aJ4x+lPw8PI0gcpA0qVdUMSwtwuOsOU6+AKa760ruATIg7G5HRV7yNHaYZI8EOqKLHTp
 i840fASbbTPoseqv2r5TwCY0kgq+0SbaPzhELycK38ZHFxo7m9gfl0u4v38Xhz+5yqHX
 1Fqg==
X-Gm-Message-State: AOJu0Yz3SM7+4bWLwnZLvVIOOGmh6MHN5gwtE1aVZRXXr7OiLN9fqQPu
 T8X4DaHeiO3vniltIMVC8CcI6A==
X-Google-Smtp-Source: AGHT+IFX9i9xDNsZkJpOxFdWobIhvrTst8IHT5aMbJSWknEnmoHKTGiWor382Oxnqfo1RDzPeMPqnA==
X-Received: by 2002:a17:902:8307:b0:1b9:c205:a876 with SMTP id
 bd7-20020a170902830700b001b9c205a876mr942949plb.29.1691530609836; 
 Tue, 08 Aug 2023 14:36:49 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 jj6-20020a170903048600b001ab39cd875csm9476629plb.133.2023.08.08.14.36.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:36:49 -0700 (PDT)
Message-ID: <33744539-f409-4671-4936-ced20da0b073@linaro.org>
Date: Tue, 8 Aug 2023 14:36:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/33] Implement host-target convertion functions
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-16-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-16-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 23:07, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Implement the stat converstion functions:
> h2t_freebds11_statfs
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>


Same typo and changes to subject.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

