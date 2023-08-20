Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8339D781E12
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 16:16:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXjDx-00076s-FW; Sun, 20 Aug 2023 10:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjDv-00076B-07
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:16:11 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjDs-0005AP-TO
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:16:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68a3082c771so484804b3a.0
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692540966; x=1693145766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/1pgRkeIpCavCMMj8sEApd3DVgbOQ7At68zWmIkHsXc=;
 b=uPdGVn3f9LQ3eK7zTKbtmsqxbifC2mGppQaE9etsTJXVQ6AJjBuSh2YCPNY6II5+Gb
 FarrMRXCL1cPXywBW1JMwakiFk8LOIS6K9eeeCalSkECBGmQd1PKgjdyDB1dfV596g6T
 Ha6pYJDFoIj9TFoCn0c/fCFcjpQUNtzZ4vtRLCHuTqE6WcrTJvp8RjaJR1mD01G/bk9c
 jEEo93FhEVsNSvqzkpuGOuwOiRAT5EixMX8/WOHb/FLkYkxqnQRrhF3XPbwdpGIct8dK
 lNI3hfia96lt4puBN/WuNF3gkLMyybqyhBH6gXxivU7vwtjb7R0x+PF3oAUAoy82BdqE
 aU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692540966; x=1693145766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/1pgRkeIpCavCMMj8sEApd3DVgbOQ7At68zWmIkHsXc=;
 b=KO4TdTTL4xwCZRObFRJKnmZ0dLQii6D8HLa1yxFgqAe4AYKWdGzbdqnxggK/D4NZ4I
 Ms2ShxVtZb/eHE/bmkKETPQzQBnFT6dScMcONopHcx+uvid0AxeWd3W4tOnv4Xysmaw4
 CrqReCrh4EPtKYo8sB5MYrjvK3Sx58gMN+OFP1sOpOOsNbbv05Ljk0Vmtp2LEQVQhEdO
 riuKNrH7JSazmoL4bBXaZYNW4E3smvfS82MdW8eY4wa/2y3im2piQzodTzq/w74Bxa5J
 QjyOPcQetXolFRI+NBHWz+W79qBmenorbfLUQVY8yB8Cq9if+1V545RVRPnKN9+kOaMM
 C1mg==
X-Gm-Message-State: AOJu0YwM6rPpOXM5Lgnpbfaorz7bZv/j4PjNHrrlLTPKG6mGa6Kr4Mlu
 LVKYex8tPJSKaw5IMtJmnKVdG7bvgZ2zeADjHo0=
X-Google-Smtp-Source: AGHT+IHyStj5UkLbs+YkMlOKTKUksZSj3nBZjrq5Db9G0E0WnX9pb0JuyDjaZVbVOhSbfGUPxSMIrg==
X-Received: by 2002:aa7:8307:0:b0:67c:db:c2f4 with SMTP id
 bk7-20020aa78307000000b0067c00dbc2f4mr5011470pfb.4.1692540966604; 
 Sun, 20 Aug 2023 07:16:06 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a63aa4b000000b0056afdbd0a24sm1402702pgo.9.2023.08.20.07.16.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 07:16:06 -0700 (PDT)
Message-ID: <90c7afb3-cf9f-efa2-7529-8db3d43fbdc5@linaro.org>
Date: Sun, 20 Aug 2023 07:16:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/22] Implement ipc_perm conversion between host and
 target.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-10-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-10-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

