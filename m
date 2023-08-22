Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE597838D5
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 06:29:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYJ1M-0004p6-M2; Tue, 22 Aug 2023 00:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYJ1K-0004ob-HE
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:29:34 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYJ1G-0008Uk-T2
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:29:34 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68a4025b5e8so1428816b3a.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 21:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692678569; x=1693283369;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=faavWqWhWL9jqSbOwGv8bImLaDQSVCTQYfWDhSbpWm0=;
 b=uVKwkMqwYYLj7ZKkx/Rt3uKBUxwyx62e++IfDeH1TV27/AbBJ9CMp8IyTmN7xGK31H
 ySmIaHxRO0xhPcwC6HoeJMH9Vvr9Ijun30ivQPDV3bxFUtL3GZ4zGAmrVzksUGddgcGy
 61+LkVqXSojIB95HM5fcUxTKgn+1rHamiEDFPmui7nzey9xC3elCERkmAwYzeSZF6CJT
 kz3pFdJdBno5CVStYfXB0mUqtfDmRsv6Ac4prmjM1VNrMP9iKiR0YFpN1Z0J9U80GfW0
 jdPeDC6Z7JgMmyV0DM4dSB8/W0K07xBRDwosNobGlB1NEHuRbfhd8vwd8eE/0X6kHppM
 bNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692678569; x=1693283369;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=faavWqWhWL9jqSbOwGv8bImLaDQSVCTQYfWDhSbpWm0=;
 b=LitawpfOVs0u748kTWUhhnvUkX3TPP9UFzXVgYeCMI1eeXVhX08sJYsMz4G73cDo4c
 VKDLYsIkX0tUDaRVx6qAEk7gvUVgYEKSgiwYStWojW5ZS77PKt+94I4Qtx7617v41gKS
 rIw8Q0bt7wjLQ6dygyyb85GdZtRbWmwLgx0JcYQfKv02vI3cgh2RCCJ0rcpeb49uK8/n
 29t6qGeRYJyJB8usCq8bQ1i2VsoVXdGDMIAAnevFwc0gRyjiNFe8DLIKageJDK+tbqwp
 lcIIJNJ8UCkNEiPOSv04QyPnTla/1w2N9iafv36FB42x/TJXZpQK8ylLVAmi4EfXnKzu
 j/bg==
X-Gm-Message-State: AOJu0Yzfv9UAiDBzah0ouoNgjJLZmGGUWrg2K1TcoYw2FvLrJOFHZnDZ
 aQFz3MAkOQEM2XXoN9b5i26hCw==
X-Google-Smtp-Source: AGHT+IHcTFh9vxKqeL7t2UEVVgHrdu1fACwVpZqIdouULBXag9EGsNStzAignkola3s5eNOqMZYDjw==
X-Received: by 2002:a05:6a21:3984:b0:132:79da:385a with SMTP id
 ad4-20020a056a21398400b0013279da385amr6394805pzc.23.1692678569179; 
 Mon, 21 Aug 2023 21:29:29 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:2c08:e710:4459:46f1?
 ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a170902834700b001b8ad8382a4sm7809356pln.216.2023.08.21.21.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 21:29:28 -0700 (PDT)
Message-ID: <07266988-91c7-98a0-495c-4b9ca36a3f9e@linaro.org>
Date: Mon, 21 Aug 2023 21:29:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/15] hw/loongarch: Remove restriction of la464 cores
 in the virt machine
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: c@jia.je, philmd@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230822032724.1353391-1-gaosong@loongson.cn>
 <20230822032724.1353391-11-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822032724.1353391-11-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

On 8/21/23 20:27, Song Gao wrote:
> Allow virt machine to be used with la132 instead of la464.
> 
> Co-authored-by: Jiajie Chen<c@jia.je>
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

