Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D97979CE
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 19:21:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeIff-0000OT-Ba; Thu, 07 Sep 2023 13:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeIfd-0000OK-88
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 13:19:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeIfa-0006bd-2g
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 13:19:57 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c0d5b16aacso10259515ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 10:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694107192; x=1694711992; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=skZKt0z2pUGF4QF2fQ8xiAQmsbfPBtUIfF1tMDMvI2E=;
 b=isxqLjFN80vthx3x3YqQkJKWvU+4CzfDXkoC6Q4nIXRsGpGPW5e67dImXDb027Q/t3
 nJsHb9x9i96Kx78faraANtKUsyV54SkWOEeuevzQbPOxLZSVBM3O0EY9mzXBm/j13Eye
 FPYZBFR19R26qvCgXMQWMiofx+XG+U6ZwaRFZabyH1KXAZFjVBdryrUQAi774yL8w7ca
 ZFdzAbIdSngwlja78XryXhZ5ovCXQ6+e8dii9bepCwJ5IcfEdet8G40j1Xz9lNkAt2RF
 3gmgEK4dCvomvJgbbLaMpj0sr+bQR/apdIm9x8iYdW3JKTFEtECE5k8BKq2LJj1aMHEP
 fFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694107192; x=1694711992;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=skZKt0z2pUGF4QF2fQ8xiAQmsbfPBtUIfF1tMDMvI2E=;
 b=hLYArdvCsnxvsyGghJLRHwZEJoHhq8whQO56Z4ASSYUko6StUwXalgI7Q59eiO6fqw
 5EqwnnkzFYVEO6DYwurhbG/nqI41T2w4nH+/iNuop0di9gW6/VN7sxHnvSRg9Vkwi8uV
 tKVjccI45PpDM8MKvGXHTFOwADuWLiQbFxfhJjN6Jcfb1+tpjb8vWMo2k3uq3YFQ+3P8
 I1YhISdL5OoWu1FaP8DIgq7B0H/B5wPaQJ+mWxp0WPF8lmfFd3RMs1YiWl48PIuERU4W
 o0khtw5fwvzaFuYoqxsvJYhc5lNYKGK0EKKwqHhSC1Lavz9pNspgBCJgsX8OrB42we/Y
 m16A==
X-Gm-Message-State: AOJu0YxdSpoIZilhY+Xpss7fnKpHpru3Q3esUQYeK3ffUNvOhq4O3f3P
 dNYlSlFaVtfXHckK+ESNEeLGS8RByYjAKEubXrg=
X-Google-Smtp-Source: AGHT+IH2T5NY2pzusRBjpgTIU/BMut8lxHAafHm4dbCA+wl0SmtHyV3e8I+DfpfzZGJeLhTN5Hek7A==
X-Received: by 2002:a17:902:82c4:b0:1bd:d718:5833 with SMTP id
 u4-20020a17090282c400b001bdd7185833mr281044plz.18.1694107192302; 
 Thu, 07 Sep 2023 10:19:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a170902c94e00b001bdc7d88ee3sm26024pla.37.2023.09.07.10.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 10:19:51 -0700 (PDT)
Message-ID: <6e6a0db3-9f4d-8ea2-c254-9962cf35d380@linaro.org>
Date: Thu, 7 Sep 2023 10:19:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 02/57] target/loongarch: Implement gvec_*_vl
 functions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-3-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 9/7/23 01:31, Song Gao wrote:
> Using gvec_*_vl functions hides oprsz. We can use gvec_v* for oprsz 16.
> and gvec_v* for oprsz 32.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insn_trans/trans_vec.c.inc | 68 +++++++++++++--------
>   1 file changed, 44 insertions(+), 24 deletions(-)

The description above is not quite right.  How about:

   Create gvec_*_vl functions in order to hide oprsz.
   This is used by gvec_v* functions for oprsz 16,
   and will be used by gvec_x* functions for oprsz 32.

The code is correct.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

