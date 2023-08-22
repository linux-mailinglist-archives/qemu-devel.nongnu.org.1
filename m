Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B510784949
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 20:13:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYVqz-0002Mi-JM; Tue, 22 Aug 2023 14:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYVqw-0002MM-PD
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:11:42 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYVqt-0000oi-Qi
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:11:41 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68a36dc1422so1979612b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692727898; x=1693332698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kBcTsNbSwGBxMrHN3XwPjjyx1Jrk8uUoo3l31SBaSF0=;
 b=b6mFpRxIqo2tje+DplLWIT4NvjVF2k03XfjotKXRWMCtwmVWLjdvwQekw2ZTUZ4rJN
 cvION/t/LbX5zAgjfhwzMg4nXWWYym+N8zNgjjxOiYeAtuJhmQlwBYuBzZxGsy084lHM
 FDalfYWeR9Kow+iKv8pPB9ONF9xLqfnGdoI/FShWIFCM8TyYH/kjcE2AneJtq4nFr9Te
 7x1BBUG0E4ngruEoUXMn4wST2Rqk0IOMd32FfpYol4mlKi7vgpwIdhWUFM2o2HAivhpX
 hIdh2zKgpsohN/dyHxNKI47N8hcpk1SmvUgR9lP1zL4JqRvSqTQz/wGumaFN4EaPvJBp
 x9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692727898; x=1693332698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kBcTsNbSwGBxMrHN3XwPjjyx1Jrk8uUoo3l31SBaSF0=;
 b=l97ykQq1Ey+eKqQl6OD+TpnlLSre7FjygeYi3WhGiNTTfbe3zTTVL2sSTcOtx9AlDS
 cCwnDHy4QLYVajKQbB/7i7vQkRFmotLX1dWua7AxPdVEPTis8j4zpJiinwARLoSICDAw
 Tp1bpLXQWgC8rVI0p7BiiBSDCoBzOfhbzxGScs0szADDd0rmySrYI6ENyyq8wWR7u5HV
 GSCOUEJ8TVMQ2Ld6xwo49RPe3QO+w2vRFNA1jkASKdCcINoat98c5C/cOlI8N2DL8fkt
 QnMicrQQT90XWrSNlw5/8JBl29/mTojT9Wq5v6e/SLe8sts+E3uu4FRhVGgicZphu3jS
 LemQ==
X-Gm-Message-State: AOJu0Ywo786izRl2ljNKSKpp/DRT5eJuEG4o4+Z1zUMM7jUsXj/WB60v
 83x4sfrQ8ZJsPRYaKSpu5cLmcg==
X-Google-Smtp-Source: AGHT+IH1o02ydbascIX9g5W5PIOFQO3T4hJOTtvdxQL8AW4XpSzIsod1z0JCSn8ncm54yUTrHqkoXQ==
X-Received: by 2002:a05:6a00:1a53:b0:668:69fa:f78f with SMTP id
 h19-20020a056a001a5300b0066869faf78fmr8764269pfv.1.1692727898451; 
 Tue, 22 Aug 2023 11:11:38 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a63b64a000000b0055387ffef10sm7372623pgt.24.2023.08.22.11.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 11:11:37 -0700 (PDT)
Message-ID: <c7dbf551-f833-c5e3-302e-fcea2d411bb5@linaro.org>
Date: Tue, 22 Aug 2023 11:11:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 21/22] Implement shmat(2) and shmdt(2)
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org,
 Stacey Son <sson@freebsd.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-22-kariem.taha2.7@gmail.com>
 <eb0506c6-f9bd-5a1f-870b-b6d07dd337ea@linaro.org>
 <CANCZdfrmw6c9kxFTUrWegaU78SHBjqVMEHuO8VVsPN=7hGQb0Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfrmw6c9kxFTUrWegaU78SHBjqVMEHuO8VVsPN=7hGQb0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/22/23 11:03, Warner Losh wrote:
>     Hmm, bug with linux-user as well, because here we should re-establish the reserved_va
>     reservation.
> 
> 
> ... of the shared memory region we just detached? Right?

Correct.

On a related note, on FreeBSD is there any practical difference between

     PROT_NONE, MAP_ANON
and
     PROT_NONE, MAP_GUARD

for large memory regions?

I ask since FreeBSD doesn't have MAP_NORESERVE, which Linux uses to avoid allocation of 
gigabytes.


r~

