Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AC5784685
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:05:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTse-0000W2-6Z; Tue, 22 Aug 2023 12:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTsX-0000HD-76
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:05:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTsV-0006Ha-1w
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:05:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso36393825ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692720309; x=1693325109;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9BnmY5HcdqEuZ3Tq47Sj8pUuTaWms0RpdOb5kp5T5EM=;
 b=u1gU6f3jQ1PKwB71jIt7fTLsI5o/aYVBU6NbWbCqqV/UzCMWnAMkwWJlaoRPxTjXXq
 w/YpDHLowgpgUBSoBZbHrn+Eqp0LcElXqnT7X5f+JFfQOKNSWQijTwuXpUL1odZmp4xb
 ewP2yIva4JEfFVFJs2HBEydvs55LkWRzRZX8dzhLQ3dU6gXabAEUWOyDOaQoKEHKf+ff
 SL3SyeJTliaZ5eVhZyqjYD5wFNVh5pzoNgn263bBacG3WS1SeLj42n4LXFsrhfA/6ojx
 lcqvrl4PkhiUun1mrWpJp8dXTOSUBarjPocyRChSGanfnImQJfm200tPJj5E9lSj+pjf
 dPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692720309; x=1693325109;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9BnmY5HcdqEuZ3Tq47Sj8pUuTaWms0RpdOb5kp5T5EM=;
 b=I3dl2w9ApZX6FY7k2LJr+SVvylQNujkMidnpcf1qM/nhknO00Y1aOQsS/gXrmoNDAg
 jPQZgPshGSeDiIUDRw1PDy7eflXYbKCuH3iHmZJg9fhXNofb9rapdWT2MhSYEJdw+YBS
 PsFGfF6Qwgb3gypSbIq23MvvfHspJLlxKcvaUBSFD98YfL5jgjCsOiUrxO8vW/mNmpy+
 t73t8U2yUauXUPwBwOeXvgDusM9WY6i5izIhT7fZg7/XxsqPvr3spQ4AZ1ywPLVVdi+R
 /Jgt9vv6iTE0lA5i1SIIzBQjSAb7T3NGTJpuPHPoR/1h0tWx1Onppef6+OGigs+jB/i1
 PGBw==
X-Gm-Message-State: AOJu0Ywf1GHfnMfVTKOis5WMolqYoUoGnxbt0kbPRCdC75V8KJh9HTwX
 nIEeZmdVrWB7rzQSo2qPQSztSw==
X-Google-Smtp-Source: AGHT+IEBsRTATv5TFvCe8BrDheAsO1ZsbwvbxQzOGXcRIHNlFaHLqpQcEkyZue7JV5EnqjGdINCY8g==
X-Received: by 2002:a17:903:548:b0:1bd:da96:dc70 with SMTP id
 jo8-20020a170903054800b001bdda96dc70mr9966163plb.49.1692720309381; 
 Tue, 22 Aug 2023 09:05:09 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a17090282cc00b001bc0f974117sm9305161plz.57.2023.08.22.09.05.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 09:05:08 -0700 (PDT)
Message-ID: <d1ebf318-92fe-dd83-8500-17496e84070f@linaro.org>
Date: Tue, 22 Aug 2023 09:05:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/7] tcg/tcg-op: Document deposit_z()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230822093712.38922-1-philmd@linaro.org>
 <20230822093712.38922-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822093712.38922-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 8/22/23 02:37, Philippe Mathieu-Daudé wrote:
> Document deposit_z_i32() and deposit_z_i64(), added in
> commit 07cc68d528 ("tcg: Add deposit_z expander").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/devel/tcg-ops.rst | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
> index 306025ece7..7ea6aba502 100644
> --- a/docs/devel/tcg-ops.rst
> +++ b/docs/devel/tcg-ops.rst
> @@ -449,6 +449,10 @@ Misc
>          |
>          |     *dest* = (*t1* & ~0x0f00) | ((*t2* << 8) & 0x0f00)
>   
> +   * - deposit_z_i32/i64 *dest*, *t1*, *pos*, *len*
> +
> +     - | Similar to deposit, except that a zero value is deposited.

Nack -- deposit_z is not a tcg opcode.


r~

