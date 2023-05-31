Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D2718BD2
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:30:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4TOH-0007mm-5b; Wed, 31 May 2023 17:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4TOE-0007m6-DF
 for qemu-devel@nongnu.org; Wed, 31 May 2023 17:29:54 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4TOC-0004pY-M9
 for qemu-devel@nongnu.org; Wed, 31 May 2023 17:29:54 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1a1b95cc10eso258520fac.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 14:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685568591; x=1688160591;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zk5jQz/cY1+u9AlJBIFhKhgA5PESN3wPOhotQGzG1DA=;
 b=FwRfjDZx4/lOsUFX/jvKJ844PaK8Qyr/rkLn+FpqtMuLIDXb0zkZCT6sW9by1mL0kw
 274+6JjlRqdb407xyqcxDiD5toX7twSKwSy41gODzpX7XJB3U3hftEyFD5T3CeotbAui
 jHTDZ0MoGN04h70oIQctXBoLhYp56cP7LintdEX4ArmeGeGeB7w9SMTuLaOy9fi2b6V4
 kkw0dF1o1SMw2tRtF9v/cWB1pAchaME1bFrAZhENhSaMIs9QfM7MC19sYLkz0LJBxQwG
 xHtbi95gbouKkJK9Z80mIIMsSt3HK7Vu+Dx2hHf5FLNko3br609ljgEvYfN7OGMh3PHk
 if0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685568591; x=1688160591;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zk5jQz/cY1+u9AlJBIFhKhgA5PESN3wPOhotQGzG1DA=;
 b=Dl48zekzKz/GWJFCD72vi3cF8w0Y1fdOrIlV7BprsNJWoTGw5XB04a/DsBhOW2Yhq+
 9I/gqv/RkQbLj1U+Sm19Ybm++aoDXkQShGVHfXCLANog1OD7owNwkDgVyc6Fr+RrfO3I
 22pbfRG5xcEQSfAw3+AM106AzYRFWeXjxGUZo4YbtsvZmDDkf9f7/GeIcrVVBNPqYLe6
 aybRaHDGnQy9p9rP9Iac8JthR5llgcuIe3PG1Z1NTHKP8a3728wfDZt5SN0UtrYiN6G0
 0puUGf82IrTQorSosm1pxVz1VQBOCXoILnPy4TG39u6LamMp3nl6xBRpq+zRNLsEiSKj
 ti+w==
X-Gm-Message-State: AC+VfDwaaINZ+/MC6aeddDlrGuU6igAbLmokpn3JaDZBHbtyQ3prLscn
 kE7hSpYe7sXZS4dEOKEklRSi0w==
X-Google-Smtp-Source: ACHHUZ6nDYFDlCkBNUgaqB/BsIo9uM2rxbIxrkjXOVPvumLqq4nS5gUTE+/LWT+aNJAIB8GDLRQ5AQ==
X-Received: by 2002:a05:6870:822a:b0:192:ba3b:a18 with SMTP id
 n42-20020a056870822a00b00192ba3b0a18mr4885762oae.51.1685568591266; 
 Wed, 31 May 2023 14:29:51 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 y126-20020a633284000000b0050f9b7e64fasm1758395pgy.77.2023.05.31.14.29.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 14:29:50 -0700 (PDT)
Message-ID: <5c0e79d6-6810-5429-656a-041e114b9b5e@linaro.org>
Date: Wed, 31 May 2023 14:29:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 01/11] *-user: remove the guest_user_syscall tracepoints
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230531194815.1508961-1-stefanha@redhat.com>
 <20230531194815.1508961-2-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230531194815.1508961-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 5/31/23 12:48, Stefan Hajnoczi wrote:
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -531,7 +531,6 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
>       CPUState *cpu = env_cpu(cpu_env);
>       abi_long ret;
>   
> -    trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
>       if (do_strace) {
>           print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
>       }
> @@ -541,7 +540,6 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
>       if (do_strace) {
>           print_freebsd_syscall_ret(num, ret);
>       }
> -    trace_guest_user_syscall_ret(cpu, num, ret);
>   
>       return ret;
>   }

Failed to remove the now unused cpu variable:

https://gitlab.com/qemu-project/qemu/-/jobs/4387911615#L6426

../bsd-user/freebsd/os-syscall.c:531:15: error: unused variable 'cpu' 
[-Werror,-Wunused-variable]
     CPUState *cpu = env_cpu(cpu_env);
               ^
1 error generated.


r~

