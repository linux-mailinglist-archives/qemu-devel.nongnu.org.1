Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 799C5781E09
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 16:07:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXj3e-0004K0-Uj; Sun, 20 Aug 2023 10:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXj3d-0004Jl-63
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:05:33 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXj3b-0003WV-0Z
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:05:32 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a3cae6df9so148250b3a.2
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692540329; x=1693145129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oGDNFnKpeRzR01zVuGhPS+M/ctjXYf3dOtrgixjQtNY=;
 b=NomyO2N26Brgs38fZ/3vYY7y3g6aYYIFtn1FIsMLQLh5XulcLiAZIIhZQKRHvLTqOY
 ysl+1dh3AIIhk5irc6awiib//JlRE3xcPO59qE0X2NtZEEU7ozw0HASH8GaPT+ySZ31n
 RG3S1kKFDrSqSOtkkviFv7hRAgpctlH4h33U5iSjKbQ8tq6OLDjcmi71NEBJk3mWWXy3
 o3jX7MlJUOFfs1iH0zoif3ocKbejkkrp3aE8zwVJODUeheVHEAox/KmteEkg8hwEkTQ8
 /07tI7iy9QnnJxQsNe+w/MOalV5eB5LlVGpcJpGA2e+9GNOIfDTjpE0Y0e0miZGSNB3C
 B6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692540329; x=1693145129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oGDNFnKpeRzR01zVuGhPS+M/ctjXYf3dOtrgixjQtNY=;
 b=DzXhc03ZKeItGgf+6MiOgX5rPHQUjXLwaK5XDFnsuAilMtjv5VlOqiQ2MIXJUDxcFl
 4Cyir/McpkXQMBSA0ivCmaaemrhX37r9baVOwxht18QJ9EEA5DyIn5Mll5kAwjeSQs+I
 PJlwOZwEcMfGZP0+pI9Ec7TDdb4UUbc7PmdQz3q0RpJjSBAZPnEcj5flDQfEUgmAgtlp
 Brc6vuNUHRMkEfXXmFxeQKU1LfWykNmj9/WE6DMzlaARpkSRclt5FF82ouBVhPyqCccN
 +ywSFe+XNnSZOjgMoFotxbYfQkKymmpEe4eKvALVQGr+azS4cHXKNbSQPTefMLZj+IEn
 0bJA==
X-Gm-Message-State: AOJu0YxJieq81twkqwuZnroi+MvGtZV6/uzxT26hrtMBuJ4WeuppQEmk
 MKkIRBIGOFCppjScau9rTwKUTg==
X-Google-Smtp-Source: AGHT+IF6oFcdx9B+JYyZMmjtkkJOm/jvmxJhVz7Phr8azBMxtFMHIqJoHBd2OWHi3BmP61qXxgHqIw==
X-Received: by 2002:a05:6a20:d4:b0:13d:384f:b6ec with SMTP id
 20-20020a056a2000d400b0013d384fb6ecmr2786361pzh.58.1692540329076; 
 Sun, 20 Aug 2023 07:05:29 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 fm17-20020a056a002f9100b0068874e1faf2sm4521491pfb.56.2023.08.20.07.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 07:05:28 -0700 (PDT)
Message-ID: <30c2d4d7-a457-a3ef-bbc5-6d734d38a5f7@linaro.org>
Date: Sun, 20 Aug 2023 07:05:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/22] Implement shm_rename(2) system call
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-7-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-7-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/19/23 02:47, Karim Taha wrote:
> From: Kyle Evans<kevans@FreeBSD.org>
> 
> Signed-off-by: Kyle Evans<kevans@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-misc.h    | 24 ++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  6 ++++++
>   2 files changed, 30 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

