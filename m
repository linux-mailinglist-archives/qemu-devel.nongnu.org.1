Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3907660E2
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:49:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPAlk-0002um-Iu; Thu, 27 Jul 2023 19:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPAlh-0002ub-MJ
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:51:41 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPAlf-0001Ns-IE
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:51:41 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a5ac84718dso1287080b6e.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 16:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690501898; x=1691106698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hib0QVAeKDTAPyfWZ72X/rToAN338wgP43CR9anYPBE=;
 b=yb1bTfP4euEZQIzhtiCtN8ql5APlLQosWmM0mfKsZ7yr7xxblX6eSkflkA29+n2tra
 u00Avt+U1h8Tlev2MNpm04ndhtwFQMTFk0ScZqg4M4IWYE0kzRDxaGex0pyG6i42m1Ea
 zwSsnbrtQgYiNvdmOvdBrkIoaZeVc0UUMWl5qPIPmPAcKKVA88gx52rfq2CGlJCKvjLI
 jCNWM0ukeSOhHz3HTke6ag1/Pz4LdOPpnnPy5vIaFGds7z2hpkian/4MgWkhPJBbOTTS
 GMYevnt+3wtH8pBDA7/n03N8iMTuDzcB1lE+SDXkG39W1PvVHE41ZDSx9pJtZPJjVEez
 +EQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690501898; x=1691106698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hib0QVAeKDTAPyfWZ72X/rToAN338wgP43CR9anYPBE=;
 b=Ik+jnZs17C2OTaH9AEPBeY/jb7Hgw1yGY+ewJq4glbjYbuKWkOCX0lJJ4LEIYaQl6X
 Yo5Wz9i2OiY/8qCGnlR5LuFeo7Kd8KR1Ds7ztGmqZHRRHslkWaGPtd9ZM6B17HWPOI5z
 GcnKLgByYPwlwndGypmALfz4nJ1z+5Cz1u9ofOhWFjSCJtasZknJg/ev2UpZaBEUSQUG
 krWs2W4HVqzKa5NfWWxkRDwoKvq0wV6/WmnNaZJnHQNsK7SMXPN0iRAUsOu2F+TNiVC5
 61EAePTXe/213/y0LxBsmsX+qJlMYz5RhZv84Ghsoh5sT/phaW5HzPdL6iO97O6AAy+d
 ug+A==
X-Gm-Message-State: ABy/qLakf66MHzp8jeCAFs3z0VEQAPRCeq7gJJUsCXq3xpmefp55kVjh
 NZcr9PxV/6zuRL5uY+FgvaoTXQ==
X-Google-Smtp-Source: APBJJlG8Ej/gUd8N80xTMt9BPZ8vFSwXdjYZ3wLTxcn3sY8QtZqncF0G5WbbsoRUeeeGaUPOBjvyxg==
X-Received: by 2002:a54:4692:0:b0:3a3:6244:2b0a with SMTP id
 k18-20020a544692000000b003a362442b0amr788719oic.23.1690501898171; 
 Thu, 27 Jul 2023 16:51:38 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:943b:b6e1:1f00:9721?
 ([2602:ae:154e:c001:943b:b6e1:1f00:9721])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a170902c38400b001b85bb5fd77sm2184892plg.119.2023.07.27.16.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 16:51:37 -0700 (PDT)
Message-ID: <f682b315-8da5-9519-3d79-7505e7af2087@linaro.org>
Date: Thu, 27 Jul 2023 16:51:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/9] include/exec: typedef abi_ptr to vaddr in softmmu
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org, agraf@csgraf.de,
 dirty@apple.com, rbolshakov@ddn.com, anielhb413@gmail.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
References: <20230721205827.7502-1-anjo@rev.ng>
 <20230721205827.7502-7-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230721205827.7502-7-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

On 7/21/23 13:58, Anton Johansson wrote:
> In system mode, abi_ptr is primarily used for representing addresses
> when accessing guest memory with cpu_[st|ld]*(). Widening it from
> target_ulong to vaddr reduces the target dependence of these functions
> and is step towards building accel/ once for system mode.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/exec/cpu_ldst.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

