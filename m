Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C177E614
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 18:12:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWJ7R-00073E-0N; Wed, 16 Aug 2023 12:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWJ7N-00072Z-T1
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:11:34 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWJ7L-0002t4-79
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:11:33 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6889288a31fso483848b3a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692202289; x=1692807089;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4EWb0+SV1Ium3ZMX8uqMkbJO5sF/gFVi1hi9RE+Hc2w=;
 b=byLd4IVIB518LJHNr8ATCz+4jPyj98/yPA53L7fiYYGnpETp0C5n8qwq5H/XVUVvJ4
 uWTwysbqnwHUwxLANFlZoBKg+M6tgLMjBy3AuUhdR2ys9hEjUd4CEzRQSakgoTVNK+nl
 WGtMmR+P2oG8WWGwYfK4/7p79cVt24Zmmxyzj281vZq5WD+jMRij6SL5VTwJYKzB29M+
 F1p/SAucgtsq8XSEc9zQeEniHfcDAKTYSv0Ak1L2p2xC6bmqZzR6TVOub7CsLJbJL/Kj
 VZ9omDZpPQeE6cgBrxeajqEFZD7nuxeq8xJTwosRlwp9Sjoi1Bzs+qsMh2RGWpKmL6mx
 E17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692202289; x=1692807089;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4EWb0+SV1Ium3ZMX8uqMkbJO5sF/gFVi1hi9RE+Hc2w=;
 b=Vt/3h9CPDG2XA5+axPYQvzTx94VtPcjoQLffGkvdbrBxrJCZsw+lH9LmMcJN3dhNAy
 ido66asoRmF52/0wvKuSZ7K1wYxyurIfI5fn+f94ilaivrIFtTjJyaommjlqXjGgIzk4
 8nqFsuKGPcdqyB4/r3d7KGkH7bJaBdBlgdjPp52912XjsFgGkM1pG4nZjMakqpHlVxCQ
 f9TzKsNmPhUqoy4MpbbkW1uARa189+6QQ8/McBf7JGNM34CcQVvjKDDwwdLwI1r53NPs
 VbtNfLmQjCwtYg/kN0Zz/LkQ4/nU31Cmolp0o6WoaPhVAAowL0fN+PPGj9nQETf1ntIy
 X7zQ==
X-Gm-Message-State: AOJu0YyPI84okV3A5gZN+hsGfqFptBG1dWk60SXFjCVJItkMEID7wC7k
 X1Ump9wAuiCEbgUPiOOphu2/OP99K1mZ8muRkOw=
X-Google-Smtp-Source: AGHT+IGYoyN1nRGp94EQPLjsgJHqDTsjHxY4ZrVhLazn/N1ND91o1a4nLhMa7KxudOxAvbOXXFUDGw==
X-Received: by 2002:a05:6a20:914e:b0:140:d536:d434 with SMTP id
 x14-20020a056a20914e00b00140d536d434mr148561pzc.10.1692202289592; 
 Wed, 16 Aug 2023 09:11:29 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:a064:e3f9:a812:973b?
 ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 b1-20020aa78701000000b0063f1a1e3003sm1553584pfo.166.2023.08.16.09.11.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 09:11:29 -0700 (PDT)
Message-ID: <58a921ce-bade-1746-62ce-83f116a8e443@linaro.org>
Date: Wed, 16 Aug 2023 09:11:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 07/25] gdbstub: Introduce GDBFeatureBuilder
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20230816145155.21049-1-akihiko.odaki@daynix.com>
 <20230816145155.21049-8-akihiko.odaki@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230816145155.21049-8-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 8/16/23 07:51, Akihiko Odaki wrote:
> GDBFeatureBuilder unifies the logic to generate dynamic GDBFeature.
> 
> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
> ---
>   include/exec/gdbstub.h | 20 ++++++++++++++
>   gdbstub/gdbstub.c      | 59 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 79 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

