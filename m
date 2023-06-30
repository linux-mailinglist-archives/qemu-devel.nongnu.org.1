Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 690D074393F
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:21:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFBEv-0007PS-Ib; Fri, 30 Jun 2023 06:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFBEt-0007Nf-SD
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:20:32 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFBEs-0004gN-7F
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:20:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc63c307fso6113655e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688120429; x=1690712429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AIZrgseZk2NVy5FWBDOpqmu+E0KMovPFMamW19OI924=;
 b=jmnd7YlmUt3vtwiCbbo3pEKdG38FZtAyERUIJXthJebtgzrsYhZC63DYi/U13+CU/w
 KdhZ4zU9gWl80aAaxlL9obdPDiEwm3AEKL4R9Qb03wFwJZMQC1rJIiFrbAKxS1k6B0d5
 Tux11TJw4c3hEzf0MZXjur23HWauMr4qZ7SaWZCtvTgqBu5e7zVCoMFoO6fcV7jF7LeE
 wiqBanYWA75BuuDarcKzCDzhCMo4k4ffdlVyg00hy9bKHuf+KidnBss2AONu5INamSBW
 taqVf2wozJxzv3NzE3rM8FDCn7h+EFj0YgeHvg/w3a41mTZ0CG/Q+lNtz+VH+OzY2u4Q
 BXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688120429; x=1690712429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AIZrgseZk2NVy5FWBDOpqmu+E0KMovPFMamW19OI924=;
 b=MPHmTGDF2GPQEgKVtQtS3fBk9KjPk7McWR8OJ7EBNpfFRTvg/7vW4mt+4/sxxykFLC
 5HQIjDBDL9eFKQ0o4SAPv5evhQqYp87gpX47izjPfwrgSxsjeDPc+xu2+a1GrVKHn2Bb
 sORkbUL4uuBsvLCblgU7IFxpHwkvDPYqBsTE2OwXm+3fNA6BWxwXBAsp8OAxm5IrfKwj
 HReWbFBbzX8TsBWzChn/RXRPl/gdI7/MnFkNlTw0pYLoqIveN/1ihJw3cpzWgNBk2nZd
 Hn/43DbzVpEM77KTqPfxpUybpUcqGNxt2jQvfkvzOLPDO+rhFaN8XD0J2ZKQZvopPjbD
 DbfA==
X-Gm-Message-State: AC+VfDzXAcWgd+niVSadY7+RjN7ljqYGg/JOjPgUHzLg//0fcGv+kCsU
 TDLszr7J6SUHNwjaYqWHUoOiAg==
X-Google-Smtp-Source: ACHHUZ79DqGZv5yG+3bPec/78QtfSPLvE5iRrkypHyKt7BFeAFLrHSkUcut1ynbHH3k89Uie+e0wYg==
X-Received: by 2002:a05:600c:3787:b0:3fb:ac73:f7d9 with SMTP id
 o7-20020a05600c378700b003fbac73f7d9mr1606856wmr.32.1688120428766; 
 Fri, 30 Jun 2023 03:20:28 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.211.104])
 by smtp.gmail.com with ESMTPSA id
 c25-20020a7bc019000000b003f819faff24sm21561394wmb.40.2023.06.30.03.20.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 03:20:28 -0700 (PDT)
Message-ID: <23c90163-657e-3d4b-0c74-437650a3e282@linaro.org>
Date: Fri, 30 Jun 2023 12:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] vdpa: order vdpa_feature_bits array
Content-Language: en-US
To: Hawkins Jiawei <yin31149@gmail.com>, jasowang@redhat.com, mst@redhat.com, 
 eperezma@redhat.com
Cc: qemu-devel@nongnu.org, 18801353760@163.com,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <cover.1688112025.git.yin31149@gmail.com>
 <b31f0bce96ad1b66fabeace182cddb41fede9683.1688112025.git.yin31149@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <b31f0bce96ad1b66fabeace182cddb41fede9683.1688112025.git.yin31149@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 30/6/23 10:54, Hawkins Jiawei wrote:
> This patch reorganizes the vdpa_feature_bits array
> in ascending order based on its value to avoid future duplicates.
> 
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v2:
>    - resolve conflicts with the master branch
> 
> v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01585.html
> 
>   net/vhost-vdpa.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 0479988a79..db7f1241af 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -50,15 +50,12 @@ typedef struct VhostVDPAState {
>       bool started;
>   } VhostVDPAState;
>   
> +/* The array is sorted in ascending order based on its value */

Alphabetically would have been simpler IMO, anyhow:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


