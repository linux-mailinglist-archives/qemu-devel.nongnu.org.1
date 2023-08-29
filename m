Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F1478D032
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:18:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mv-0000jJ-AA; Tue, 29 Aug 2023 19:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4BT-0002AJ-Au
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:15:27 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4BN-0007Zx-Au
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:15:26 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bdb7b0c8afso29353685ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693336520; x=1693941320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A5fraKQsTmZMon05zkcYXPakjAPoN/kFYE4CL9N+frQ=;
 b=fxtlrDuG8xoNc2A/B6XIF06uIj9IQlJb85cG3Y/sFPLgP6bYmUZochmO6wE8rXzjDe
 7NycZIiIrnLCwgIotm+HUASn9Z4CcUpkn3c+EF3UptbRcY0TLhO4+MEdCoNuT85nKkJd
 F0EJCCJVVFDf5ktuF+kWLUh0jcU9fY5KyHFANuiqkx9Az/Hp+qD2ZofGFSanDbudcn/g
 bmdzyBddWzkX+eeMlHI4Xcp3FMCJv0W0hWtL+fXCDoDNf1bZsYw/d08R+omumjtGe7lP
 LVY2nxE8ukAfolgtoLgzlOEl8OsvTQkLT4vxUzCW4erzC6/BQJgGkomxKSeeTquniVZv
 KU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693336520; x=1693941320;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5fraKQsTmZMon05zkcYXPakjAPoN/kFYE4CL9N+frQ=;
 b=fxD6IhwHJ6fTEKsc8/J2RXqQuBkBIcIxzFRZ0BADxTzlMRL/KUMVUCxF3VDGF3tbQs
 X8LBHiHPzfIYj5yDeZ59hmp/ehUOPlTujYxAdBuDSoAeLtwrnlPEZP+mWZYmKPDKMBHV
 Gz1YGdj/lJFZ9o2wGn/g4LSeAvtcG6ATviCWH+8YGws2YUUzYjZAFFE0SNqTZNnmgBMW
 TSQKHfZj6M1IBsOOIcwd/iNofgXu3YSycdxixs9M/K7uWeh9eKpOy8sYJRd052HbCKrR
 O3ee2HhCCHuVEsNpC3klTkXv0aZOB4PwnbSmKRLdcXIm/MJmjj9r282YwG7ASiypyOXF
 zjhQ==
X-Gm-Message-State: AOJu0Yz9l5Yv97S4yszJYx5OXeUF51sWpygZJDk7vEkWOcSauzUH+rR3
 iGRvtUiBs2ldZbVMgs9+GRrBbA==
X-Google-Smtp-Source: AGHT+IFVVO5B6+mgr8iZj0CV+BWzA1dzY2PbmDmWtwAXizFH9Y46D7v21a2TokKZVPUyqnk3oi3Iww==
X-Received: by 2002:a17:902:ee89:b0:1bb:59a0:3d34 with SMTP id
 a9-20020a170902ee8900b001bb59a03d34mr45357pld.30.1693336519756; 
 Tue, 29 Aug 2023 12:15:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 a20-20020a170903101400b001b890009634sm9751473plb.139.2023.08.29.12.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:15:19 -0700 (PDT)
Message-ID: <70fac1ed-f8b6-4a4b-c062-8bd5e15eb0e7@linaro.org>
Date: Tue, 29 Aug 2023 12:15:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/32] bsd-user: add extern declarations for bsd-proc.c
 conversion functions
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-6-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-6-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
>   bsd-user/qemu-bsd.h | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>   create mode 100644 bsd-user/qemu-bsd.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

