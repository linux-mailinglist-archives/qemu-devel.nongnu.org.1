Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D21097183AF
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MEs-0007DV-1U; Wed, 31 May 2023 09:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MEq-00076w-26
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:51:44 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MEo-0003F8-GR
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:51:43 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30ad752f433so4072416f8f.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685541101; x=1688133101;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zIj7oBr14wEC1WyXIeoLXhQvfrE69hLmw4YzClKmuZk=;
 b=VSyr3iVrDSa2xncONrG/ZEAXwvOhs22P3TWGuwr8GGBqkhzQUEEHbdHqEO6xz46mp7
 Z3kYL6vKYyztL1IkatzY0MoUfMaSfI+73/r1Q2zGfxtkFQYskI16FA6u6lwgiR+sFif4
 QS1cg1TOaGgJFtXxh+trtEuoh4PZVU5Fcfu/ovrUcZSDJ7SnShGtKCz8DvjTfJUsVtdt
 0BN11a+Q0kEMgEbFAbwcfn6W6qKHxZmAEimTkRO8iwRDXLym5mvk3XjTQEPw4zYI/2xQ
 zLs6DHGYY00QOdsbspBMemwkuqQnedoMG4t/1rghggS/npca4jpQhiqofVCXcuMBXznw
 aZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685541101; x=1688133101;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zIj7oBr14wEC1WyXIeoLXhQvfrE69hLmw4YzClKmuZk=;
 b=F5Kba0IVdyVVLHERDyexAarZ44kmmsDOc/xF5hmgLOSm+uTdhnoMdAlXMn1fPkpPbd
 LT/rks7jBwJDTOxoW4ek7+bGeXAY0VCJXjjAXntdCX8CtDuSE+wdazouEb8aJWPkE206
 AyKPtQ7tntc4utomJqBkQkyspNQk5kY9PxGFiNX8L2oMWArJvbvil1tCh5AVIsj8Pci9
 q5Xa1sgowIaOSRwrOr1EjyQxM+mIWxkT+gARImdG2lavaxxLCY48exag0TOLHl2gCaAv
 95TqdXqtycpbomcMvNH4O+aWFV0c1nOIJ8d5AjlvDOq7tShLv0ap1ef+Vj849SW+4F8P
 yIww==
X-Gm-Message-State: AC+VfDzGwK38OAT4JfVQsk7GNbsWu4s8s1VpzmHC11DqFKFbXjGMYW+w
 PoWdM7vHePeJOfNk5FfSXXIdsQ==
X-Google-Smtp-Source: ACHHUZ7loSO0HR1UMla2EQgEy5KFlDRICcUHEWtr2AJPd1Rjhv2N8RuIZpLfGIfwYywSxlNZfZV/ng==
X-Received: by 2002:a05:6000:1362:b0:306:321c:995b with SMTP id
 q2-20020a056000136200b00306321c995bmr4519550wrz.41.1685541101015; 
 Wed, 31 May 2023 06:51:41 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 m23-20020a7bca57000000b003f5ffba9ae1sm20983153wml.24.2023.05.31.06.51.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:51:40 -0700 (PDT)
Message-ID: <2f748f17-171d-374f-42d5-c03c3122a4e4@linaro.org>
Date: Wed, 31 May 2023 15:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 18/23] q800: move SWIM device to Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-19-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-19-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> Also change the instantiation of the SWIM device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 8 +++++---
>   include/hw/m68k/q800.h | 2 ++
>   2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


