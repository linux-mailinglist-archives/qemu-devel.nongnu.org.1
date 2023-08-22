Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E051784838
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:09:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUrn-0004Qr-00; Tue, 22 Aug 2023 13:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUrj-0004QV-Hq
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:08:27 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUrg-0003rg-GW
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:08:27 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bdaeb0f29aso30431315ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692724103; x=1693328903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n2lEUlasmorbC6nWVCtuopTT8Er6zkCfBRxZUMGjpok=;
 b=OFI1Eki7kmU7igHKl6XZ5/hEjqkFqLv79ntqtyVolM1SUtIM+KdIF2nYJDHDEWqkT8
 irRl20CYrTksWEkcvKJ5Ck9c5LabjLUPJS3+vJJs6t8BOzQlNqeFjSoRHQzHSAS7Iq5P
 2/uCKHBNkw3z2mjf8NOMPI7aXJOegbtnxV64ZJ7h8qtdCQViOhGTztG3JvsLU9YyLBIS
 J8jOm49Fu01KSGQVlX3r48O7sKNA3ROG1rvENKY9rK4ld/mlF5TJK8BplNEfH14Nm9On
 M5eAh1aG+JVMkwWRg+SG2rUi54151NkoUxxp4Qwya9BXz+SsIhh1gQx42O9WnU1r7sTJ
 /yUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692724103; x=1693328903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n2lEUlasmorbC6nWVCtuopTT8Er6zkCfBRxZUMGjpok=;
 b=Zw17iUGEw23EHZvvcIcckSBjKaZgmiRC3Fes0KjesoOVrMUmwHOgRqwvDYqyKjgehQ
 u5GwUCgjyiMGwtQN9AmxN9FvUO7iyXXuUvCsgdYUP/nYczomD56M+0rXoR5SiuVyvXZi
 veb+UeVG/YQAMdPnuJJVn4C5QT0+tlJ2eqBMF40yaEXmHL8VQo3uoinMtsnFiDRTm2ER
 JWe/ZqHmznbPn8kM7eG+ZSMbGRvJvxVKz8R+UNN+xHRaf3vSbh7erVVS1k+vNsXsHk5A
 gRP5eTR+GtJ6psb6WX3yFg0oSMODAiTtQ4KFoVnmaRN6tBvYwG5ur31edCcl0SoR7A9z
 dUHw==
X-Gm-Message-State: AOJu0YzYm4KI4H23wpqAtHP379Q/XgvQX9XqVxyxRWX1CM3DXZgGl7nb
 D9do3OkowDcQF1zEBRyYDFO4rA==
X-Google-Smtp-Source: AGHT+IEz0QEwam0GF+onPFYmq2XQZADCSVMHm8rzNxhsPRA8eVBDGT4Rq//8G0nK93x8T16acKiCqg==
X-Received: by 2002:a17:902:ab5a:b0:1b6:649b:92cc with SMTP id
 ij26-20020a170902ab5a00b001b6649b92ccmr7349546plb.69.1692724102660; 
 Tue, 22 Aug 2023 10:08:22 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a170902d4c300b001b9e9edbf43sm9262190plg.171.2023.08.22.10.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 10:08:22 -0700 (PDT)
Message-ID: <9e575c36-942d-d61d-ef15-d126888c0ea0@linaro.org>
Date: Tue, 22 Aug 2023 10:08:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] docs/devel/tcg-ops: Bury mentions of trunc_shr_i64_i32()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20230822162847.71206-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822162847.71206-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 09:28, Philippe Mathieu-Daudé wrote:
> Commit 609ad70562 ("tcg: Split trunc_shr_i32 opcode into
> extr[lh]_i64_i32") remove trunc_shr_i64_i32(). Update the
> backend documentation.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   docs/devel/tcg-ops.rst | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

