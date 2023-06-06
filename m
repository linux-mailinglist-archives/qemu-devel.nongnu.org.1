Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3749724B80
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 20:35:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6bVe-0007Fl-Sl; Tue, 06 Jun 2023 14:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6bVc-0007F6-Bs; Tue, 06 Jun 2023 14:34:20 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6bVX-0007VG-QJ; Tue, 06 Jun 2023 14:34:19 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1a2ad8f4075so5052276fac.2; 
 Tue, 06 Jun 2023 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686076453; x=1688668453;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KLY6MFFh6tDHhJzCedCBIRvda4hLkfX9kp1LX3UaAVk=;
 b=RuUfpmsSwKL/SQjkKz0WgaCpP269lvFz5WEkJVKmAC0sB8vblJwu9LdtF2M5MwtZVH
 JEDHKSEAh9vGMh9LsEg1canIDZJh7uL3S5ytpE36Aumj8VoeiOSRJhVblVugtkoBOnry
 3cpS0bvDq8gV+xQlBaj0lFJKPGrVDciiR8KBkh1lyKeXXDR/q2ome4Xef6XPNGXkqwg6
 9TWQ2cMZ/6+R2IBA/ORrqIPjLXmCQ4gmALap9MyiuwEozCGkF8lu9HtJM0K4GCGl8IP+
 clp4NbDBS3CB4tmAc67/hpUAh3cY8zuHhy4lhIBiLYvi0El70n1MY6OlutExz3jVIaIh
 DDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686076453; x=1688668453;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KLY6MFFh6tDHhJzCedCBIRvda4hLkfX9kp1LX3UaAVk=;
 b=XCCjarJCkfFD9TxXZ4/zOCwa3T7a5pbKAh39rLJmqBjr0bzqyWZVpnu/6/cyfGeIb3
 EBkZJAMbTEYZOEfAO6Yy6TyRZzGBVHcKpQmTL7wGVRdRMjpZbQLefKuTI/bZ56J+04AY
 PhAFz2CEDIdrjnSIoKMmxzxBjsJKH+rqGysXQebioD6zQLGXxv65H+ZQsW2AQG4UE4m0
 SblV1Co/1lIO2k7k3c2KHjrGR/S58o4sqWjqOk24tsKjYkmmR2GyeNFnZedoZ1WNA4S8
 UEKlmke1DX273QJnuXwLpR+/2v/tWKQn8G4tNiZoiy+P+fIqkV1lvI2Y/CRD968yvxPk
 3J/g==
X-Gm-Message-State: AC+VfDzZX8oFkCMuxH25jMVIgpajz8WCeV45wW6lhRUQ+OSpoxfHyx0y
 Mb/Nk2xkXULbDjIEUvkMs/M=
X-Google-Smtp-Source: ACHHUZ4WSmqyUh/kccZpDCawakCRQOCUm9c22u0yWBsbBY0wOwtKDzWILyh+PzstW0RZOWBWNFz8lw==
X-Received: by 2002:a05:6870:6c0c:b0:19f:3db1:e2cd with SMTP id
 na12-20020a0568706c0c00b0019f3db1e2cdmr4020861oab.49.1686076452755; 
 Tue, 06 Jun 2023 11:34:12 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a056870628a00b0019f44a07b35sm5058139oan.51.2023.06.06.11.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 11:34:12 -0700 (PDT)
Message-ID: <70fa2599-bd62-6ad5-d592-2e16fa4970ef@gmail.com>
Date: Tue, 6 Jun 2023 15:34:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] hw/ppc/openpic: Do not open-code ROUND_UP() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-trivial@nongnu.org
References: <20230523061546.49031-1-philmd@linaro.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230523061546.49031-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



On 5/23/23 03:15, Philippe Mathieu-Daudé wrote:
> While reviewing, the ROUND_UP() macro is easier to figure out.
> Besides, the comment confirms we want to round up here.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---


Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

>   include/hw/ppc/openpic.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
> index ebdaf8a493..bae8dafe16 100644
> --- a/include/hw/ppc/openpic.h
> +++ b/include/hw/ppc/openpic.h
> @@ -55,7 +55,7 @@ typedef enum IRQType {
>    * Round up to the nearest 64 IRQs so that the queue length
>    * won't change when moving between 32 and 64 bit hosts.
>    */
> -#define IRQQUEUE_SIZE_BITS ((OPENPIC_MAX_IRQ + 63) & ~63)
> +#define IRQQUEUE_SIZE_BITS ROUND_UP(OPENPIC_MAX_IRQ, 64)
>   
>   typedef struct IRQQueue {
>       unsigned long *queue;

