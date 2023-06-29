Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 885347422EB
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 11:08:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEndR-0003kQ-1Q; Thu, 29 Jun 2023 05:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEndP-0003kD-3K
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:08:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEndN-0000vb-G1
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:08:14 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fba5a8af2cso3807485e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 02:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688029692; x=1690621692;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=daGxRlj/3oFLJVGe6XEP61e2rRDHRHFCqBEXYiOZJQM=;
 b=TrJrVZ0MuHipn5iELmPDAR0oVn1laJl9f5gRkayRmad/FqH3+BukB1WhTs7Yu2etbc
 LZvzpCZNJ4B8ivADWFAtTl5JW0L/b3X7WOTWrtkAR5QFiLHDPuuvxsevkhspry0sRu61
 gTwsdnG9OyG4SoUL3lNriS/WiNRomU1UJZwAgpYv2UuBMkUxVWSRra2oW7LHEJu/9l5E
 vb/msk2PaCxYEZj7qAXx88A1H82bVy/aoP/CnthbPiMjzs9fkwUIA4TWebCy5Pg+OoBW
 tBR41Twamhj0dv15Ad7MivGJSg+XtxtVweyY83OQ20eEOFMGNobJfx6ToRx8B2m3gFUB
 kqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688029692; x=1690621692;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=daGxRlj/3oFLJVGe6XEP61e2rRDHRHFCqBEXYiOZJQM=;
 b=hwJfVoCmB38d9uwFvdw65SciJjFiwGyJIrlrGWtP1MtdSTk6N86d79tq452w8RFiTm
 fpoe7ppLCSrXCZcVtRwl330BaZ1ssMVNkYseZhcziEWM2VY1ZYeo5W+V3duItA9kD4gG
 pyUSIRu263ywBc5NLVP3/kl8WbOJUAwYK5BYuiBRIR8WmuOLJi36qjxoIqqvrm3X1oY/
 tgeL3JQ0MdAEXxP2oahwmGWyotOTgyCtwZYX2hbsOMgxYa7C+yVTcZ89QAmgloB1ZgVH
 lB5/M4lFctWDCE54KoqDBuVbi/bZE8PiyXPvnYXxXEs9eIe2oZ4u/4reISTBFX8x1H8L
 SCZQ==
X-Gm-Message-State: AC+VfDyEydPhmwC+jJQ+qpjwMbfWdhmwgIqkgCHQFnZNMtHv+E3MtFye
 06fe0RxQoUjmfOlcSiWXnp7QgQ==
X-Google-Smtp-Source: ACHHUZ5oAhKIWmlsOTm6bvhW8GejnX3wePcYNymyS4F1Gc9Rz0G8izQA0Iq9iNel1mH3Hw8JXvnjaw==
X-Received: by 2002:a1c:cc15:0:b0:3f9:bf0f:1cf5 with SMTP id
 h21-20020a1ccc15000000b003f9bf0f1cf5mr16687896wmb.20.1688029691881; 
 Thu, 29 Jun 2023 02:08:11 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a05600c218300b003f9a6f3f240sm18740201wme.14.2023.06.29.02.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 02:08:11 -0700 (PDT)
Message-ID: <1f0f8b0a-1f38-29f5-5363-13a88af2ba91@linaro.org>
Date: Thu, 29 Jun 2023 11:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] accel/tcg: add assert() check in
 tb_invalidate_phys_page_range__locked()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 richard.henderson@linaro.org, clegoate@redhat.com, hsp.cat7@gmail.com,
 qemu-devel@nongnu.org
References: <20230629082522.606219-1-mark.cave-ayland@ilande.co.uk>
 <20230629082522.606219-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230629082522.606219-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 29/6/23 10:25, Mark Cave-Ayland wrote:
> Add an assert() check in tb_invalidate_phys_page_range__locked() to ensure that
> both the start and last addresses are within the same target page. Note that
> due to performance concerns the check is only enabled when QEMU is configured
> with --enable-debug-tcg.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   accel/tcg/tb-maint.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


