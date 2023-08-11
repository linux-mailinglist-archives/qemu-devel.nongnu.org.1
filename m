Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF5A7799E1
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 23:49:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUZzg-0004BP-7R; Fri, 11 Aug 2023 17:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZzY-0004Ai-K2
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:48:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZzW-0003dG-Vq
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:48:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bdc6867ec4so3309705ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691790497; x=1692395297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d3Q4nPTmnEMXih8Ksg1CYwlHsmCDB5AFeJNnhJRCoFI=;
 b=Dgc6DFeq/1sMTsPPHcwm8VER+rFB/8U7F6SqRBFGDaSZsjm8euR8CXB9903zjmA6L+
 USlGgiJ46Cqd2myisHaiFP7UHu58ju+ZT17OrHKZ0k4l6o7tzsXOwthRggpfHpUfRlvz
 s7nIsg+DYU+vFEuZ6bCHU3Rea6XZ2e4bD7d+KY0PGxDHLN4uXrgs0uXAl/7rYlf6M5IQ
 6qyMcwia3uifai9Ct8jZxUNcKoImT8x5Up7ADca66yeb8CtxEXMESE/YzJordjzZ50k4
 vLid/bndzY8mb6RyMW2btSRqpFLiM0ABhSpH2EysXPT5FzNkjgUsNeRMEMfeOB8yw05b
 95UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691790497; x=1692395297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d3Q4nPTmnEMXih8Ksg1CYwlHsmCDB5AFeJNnhJRCoFI=;
 b=bIKPXJ/4jTIQ+SXUEppRDTyV6bHiLLaYghk4tQTJ+q064CD6A4vGbFSTL5yFwLUof8
 RpU1mNjgUQAVVtx91p/g+XqomIT086QrMEJgyRmXpzZAMdldmeX/oGIv7CelDQwkvz1q
 SHLN1k/GMzeh0ZpmOnwDzOqeMYZjp4Ets2lLmZz+zByHpyuryHGWrU4ImolV7KCHIISx
 CymjiCUYzuU3q65xQycurznTdKqt0DHg9CJDKV7a+F1QCloJoLNh0Gnh8qnLZ/aSaQ7h
 YF7480gTRtu7jHCbBMBK0cA0ln28Ls5+7DZxHnYTLduV6lJSLyE9r9GzjPJonfG/7ysa
 oJrA==
X-Gm-Message-State: AOJu0YxNibXnWHbNren3a4axc2gpBp1Br2z+8TsEOwkRnXewTwW53M7U
 7GYOVMRhiA3DvkLGKuSRqVnFp2gkY7xFQr+SN4M=
X-Google-Smtp-Source: AGHT+IEY/L1gauh6HD0TFW2wroauB8hNCXN+IT+jCzSHAkBz8cxesfnqnxbSERc9iC4rUjUQpOoJZA==
X-Received: by 2002:a17:902:c14d:b0:1bc:73a6:8be6 with SMTP id
 13-20020a170902c14d00b001bc73a68be6mr2571580plj.54.1691790497395; 
 Fri, 11 Aug 2023 14:48:17 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:e773:351d:2db2:8a8a?
 ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 b4-20020a170902d50400b001bb9b5e86b7sm4410694plg.91.2023.08.11.14.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 14:48:16 -0700 (PDT)
Message-ID: <f6548c41-cefc-e8e6-9e61-9e4b4b8ea014@linaro.org>
Date: Fri, 11 Aug 2023 14:48:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/2] pci: last minute bugfixes
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1691770630.git.mst@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1691770630.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 8/11/23 09:17, Michael S. Tsirkin wrote:
> The following changes since commit 15b11a1da6a4b7c6b8bb37883f52b544dee2b8fd:
> 
>    cryptodev: Handle unexpected request to avoid crash (2023-08-03 16:16:17 -0400)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
> 
> for you to fetch changes up to 0f936247e8ed0ab5fb7e75827dd8c8f73d5ef4b5:
> 
>    pci: Fix the update of interrupt disable bit in PCI_COMMAND register (2023-08-11 12:15:24 -0400)
> 
> ----------------------------------------------------------------
> pci: last minute bugfixes
> 
> two fixes that seem very safe and important enough to sneak
> in before the release.
> 
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


