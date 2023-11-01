Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB867DDB62
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 04:14:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy1gc-00023U-R0; Tue, 31 Oct 2023 23:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy1ga-000237-NS
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 23:14:28 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy1gY-0006iK-KT
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 23:14:28 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b6f4c118b7so5790115b3a.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 20:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698808465; x=1699413265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WJ3/AKgD3vWV8DpI3cBajOLG6JfNNtqRyCvLeUa05Bc=;
 b=P6xXPaqQkx1wKPr71celzUowcRDjvrUKoZxtUWyiAHTtpdbm0lxlvNbmJlR+jCDefW
 tbYf9xwpijo/mCYX+wn6wi/PjIIUO4Kfp2aXzf4wRUG/hopkLQdgPWMqR3/PbZ4hc1M8
 1bBTP8BvdkGtC+dk1QGqG941nv74PPD0C0hsV2vLF+Pyk3sigjfRMqvoRzUG1/fJCHzN
 s2envjHt9MEYvvxMaerTT1ecoFb1P1ZOJ+16iOzCMEOkcyzRlCq173IWiM/UeI41w/By
 RAn4mY/wwjSU0gfItCjeL/X18TXMxhBYaRn3ap6hwzhm2IM5Wz3+Y0Sasp+lIAF8i2St
 LzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698808465; x=1699413265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WJ3/AKgD3vWV8DpI3cBajOLG6JfNNtqRyCvLeUa05Bc=;
 b=euVtp8yCPAFuL6z1iVw+MXbWKD+r3T42d91vLhM8je19hCKb5dS5VoT6kY+216oRkr
 Md4glP7S8K31LzHLgvi/+mPIuqfrwpTzVks0y9Uf4aGGNpOdK+v4qtEbf4Do+STeME2J
 eyopcysrbk/nIgEML47SJz/iRMmLK6jqvugcYZlnvuR8YU09vDQPUPVQMtqxlVlp/3tG
 Tk9RI53hWxV+iNXyq92xo4TmYPIghcAf2WAzMUfiAqM6wpJboUbUkLDZP6yRSdBL+lG1
 iPNmImjNCF4d7fu9hQGCHAIt18FeBslm97PwFAXwjRtTkR5cW1kIlbJ+R/nuzV6SyMvB
 zZGw==
X-Gm-Message-State: AOJu0YxjrT909trDQGrjrp+fy8gSA/xkifFE4QgGAQqxtiuCFlZWrNlG
 AuhReJnscViv9kA1hgnnJzb6h2T3S3onMcwuAUc=
X-Google-Smtp-Source: AGHT+IEBxd9nmJemcJXU+ccnlFjV1Kqv/HTTy2UmXpGL8terAI29y6sLJ8bMAEBQBKXHOirmAfCP0Q==
X-Received: by 2002:a05:6a00:1894:b0:6b5:608d:64e1 with SMTP id
 x20-20020a056a00189400b006b5608d64e1mr13333169pfh.33.1698808465163; 
 Tue, 31 Oct 2023 20:14:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 n25-20020aa79059000000b0069319bfed42sm299588pfo.79.2023.10.31.20.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 20:14:24 -0700 (PDT)
Message-ID: <9a372238-34d0-43b5-9041-f0379ea5bff4@linaro.org>
Date: Tue, 31 Oct 2023 20:14:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] linux-user/loongarch64: Add LASX sigcontext
 save/restore
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, maobibo@loongson.cn
References: <20231101030816.2353416-1-gaosong@loongson.cn>
 <20231101030816.2353416-7-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231101030816.2353416-7-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/31/23 20:08, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   linux-user/loongarch64/signal.c | 68 ++++++++++++++++++++++++++++++---
>   1 file changed, 62 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

