Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6062272262D
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:44:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69Yt-0007NR-0Y; Mon, 05 Jun 2023 08:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69Yo-0007Me-Gp
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:43:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69Ym-0004r9-Vi
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:43:46 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3078cc99232so4356338f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969023; x=1688561023;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PzHa1gF+Prcdo2xmf99XlMPJk9QGTUjzjCHTcTiDoKo=;
 b=qXJd1cN7lpydT2GOw98P+6G3+CcOcx9SprgS7WrDxCIpu6HJ8cHoSQV1tybbkkM9A5
 on32Qria7fF0HvlhE4R+2dzmayRAxWSQq8uz6hCaT7gG+mNSftkNqZI7DKguSMcVrPUN
 q1NeqqO7BZKa2tPWgrYYXdguw2OZCvpXmTcHCxkF/eN8J/Ty4lS8taNmaZ3bT2WPsaX5
 WepSON6Lz1Y3Of1UaaZjpVFD7P9iCAk5mOxW39A9MyWreqhMNBJ1L9VKyYdRFihDJr7h
 mZk2MRwrmCWes1cDwvMCfKUQB/VUqawcygzXobrKg4OR4EN7dWFvSxhL0MFhDoJdMZfe
 NAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969023; x=1688561023;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PzHa1gF+Prcdo2xmf99XlMPJk9QGTUjzjCHTcTiDoKo=;
 b=H58m8P5UYeVjA1OZMtCA+xP0+yT+JVEWmODM58JACX8m7uolP7tEnjMxlLoRM6K9tQ
 FbQVM576eVu1sdwCVn1/XZbTwxJ33954y3aMmZLrf2k7oolUw8MbuQ1pPeN07FiQ3A5d
 SN+q23kdZ/c/xJ+S4NXJCeyPVJVnBw7SETiNADNyU5bpL6fS+AwIn/bpDlPHGNg5RuVn
 Yy668GTM9Nam38Xzx13peCi+dsQa0sJ8Zhy2VrVQBzPL4AiKFCLpecP9tyPDF/csgFUl
 Q/zrgFSOT+Hm3fbOkirJy7ZzfQPNHivY/quKANQjYKAhU1MFLTXSk7nmB3USJXmh3iX5
 qm8g==
X-Gm-Message-State: AC+VfDyJWHbNG+JYUAPrwI/31KdDlT9SgUJYIQXJdtZWDOveegDYcBH7
 aQzVMHIRf7x3L4nwuNO1j0Ca3A==
X-Google-Smtp-Source: ACHHUZ5LAcd69oBH36S99roIuh4rIfRDRFZKiQNkLXmm+WrQxTuLlINyXYWijkna8c2RV/pX/es+9A==
X-Received: by 2002:a5d:49d2:0:b0:306:2d45:a8e0 with SMTP id
 t18-20020a5d49d2000000b003062d45a8e0mr5793542wrs.15.1685969023571; 
 Mon, 05 Jun 2023 05:43:43 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 d6-20020adff2c6000000b00307b5376b2csm9680582wrp.90.2023.06.05.05.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:43:43 -0700 (PDT)
Message-ID: <7d321bc5-c54e-3584-efd2-0c9401da8655@linaro.org>
Date: Mon, 5 Jun 2023 14:43:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 10/23] q800: reimplement mac-io region aliasing using
 IO memory region
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-11-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230604131450.428797-11-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/6/23 15:14, Mark Cave-Ayland wrote:
> The current use of aliased memory regions causes us 2 problems: firstly the
> output of "info qom-tree" is absolutely huge and difficult to read, and
> secondly we have already reached the internal limit for memory regions as
> adding any new memory region into the mac-io region causes QEMU to assert
> with "phys_section_add: Assertion `map->sections_nb < TARGET_PAGE_SIZE'
> failed".
> 
> Implement the mac-io region aliasing using a single IO memory region that
> applies IO_SLICE_MASK representing the maximum size of the aliased region and
> then forwarding the access to the existing mac-io memory region using the
> address space API.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/m68k/q800.c         | 100 +++++++++++++++++++++++++++++++++--------
>   include/hw/m68k/q800.h |   1 +
>   2 files changed, 82 insertions(+), 19 deletions(-)

Out of curiosity, is mac-io an I/O bus, rather than a MMIO device?

