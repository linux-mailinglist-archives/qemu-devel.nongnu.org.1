Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F4E78D040
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nm-0001Qw-Tb; Tue, 29 Aug 2023 19:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4Yh-00006p-9U
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:39:29 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4Yd-0003fM-GD
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:39:26 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-572a7141434so2822156eaf.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693337957; x=1693942757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xNUv74gac8Vr33V6byjkS3dpkulEl0fDsggb6jiO8SA=;
 b=RfktInGbZtmYUc+7Trv4PyNc0h39QR5RltkqxgD3vhp90SHvCVPDfq/tylXE2vC8th
 ccFvEMi1HYH0D/aaSjfhFjOiW3ENyDPXr7b/jopySrRBqhNw6+QIbL33iThgfF8MDg+D
 iNkkvJfhLUQjRyXFSt6yiQy/ehEnaUPbXk1FPmC14SEkG6l3kODMy6HRL0hFcI4KcdZL
 Ii+iIxiI0yd0GqSyujCVV6yLEMSqcx2q5GwAf4OUWsbkMzn3t01F40RREvfgZJxOmzaC
 6XRkh51QROEnY2Kle0INOWJsVbk/8O9gXN2vYt0w8TxT9M6qs72p9wLN4Pd92dh4s8aV
 Dtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693337957; x=1693942757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xNUv74gac8Vr33V6byjkS3dpkulEl0fDsggb6jiO8SA=;
 b=Zp78Qj1tmmQaMdUn3LfKxsNLn9YzWBp3h7pvIJYhJShZ8FgtrYua0mhM3jUutXl2wY
 D0aGvXa+cPRrdp2UMBD7lfkZTvH1NWlCW8BKOc61Iw3gwd5o+vqPpPWFHmBg/gkPD62m
 SIc86uz0T/aNzjGCNNK1XH39KIdzC7W5OTebOlW2q5EIV2HkVJ9WSt6/iSmkglCmzmQf
 GjcaSkRMByCPlQFjcbL1jLkPhYEyGcVI2Imt+tNPn9Hdznsv4FxnJnlGlOAtVWbA4Fgs
 0VvOL1+jl1e2YkD8dy5PRXJf6QmHTRN7BVn7eeJqf2vlbjLI0j8283YuXMFvI3740fQl
 VSJw==
X-Gm-Message-State: AOJu0YxiYIOxP5kjjZ8KeahE8JyQEzP/Hbn9XeOJQQec9+VdKRlFoE/e
 J+Kcm5Et7cZ0avDnRjL1qI+Y/A==
X-Google-Smtp-Source: AGHT+IH4eYrGLqtoKEVrU4DvdKHB8R6YJ3rAhMRL7QQ6OfAok+ETLUn8EjRC3NvjGfiPi4huIL1tvg==
X-Received: by 2002:a05:6871:1c4:b0:1bc:1ad8:2b7b with SMTP id
 q4-20020a05687101c400b001bc1ad82b7bmr120253oad.58.1693337957639; 
 Tue, 29 Aug 2023 12:39:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a63d653000000b005701110ca06sm3752941pgj.5.2023.08.29.12.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:39:17 -0700 (PDT)
Message-ID: <6216b233-6eb6-c926-ceb4-6440998ce5fd@linaro.org>
Date: Tue, 29 Aug 2023 12:39:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/32] bsd-user: Implement host_to_target_rusage and
 host_to_target_wrusage.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-10-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-10-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-proc.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

