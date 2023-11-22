Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F77F44B8
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 12:13:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5lA9-0002xq-E5; Wed, 22 Nov 2023 06:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5lA4-0002x4-DU
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 06:12:52 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5lA1-00023C-FU
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 06:12:51 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507a0907896so9349860e87.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 03:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700651567; x=1701256367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pHG+p/7dmDL8K+jCe3ynyGYs4kUaHD4fINNC7XGjciQ=;
 b=Bb6l6SdQSwGj70HxvTX1MMFPAI4Ub0zLFhbP8E4KeY7xqCkNYWq0bE0ewZ6P4P5aiq
 dejoPl8pIXi55F0kbvDMdcMdMglU45c4AMb0XG6Ksqq7KBbLVvsYklXA9JIV8iHfHkJk
 5Wi9xzbamP8cmy5Hfvzkm36OMIHmj/1+YJX9h2pmvrZGULXOCY0uMqcmaY5jewM9rzXE
 mcOpFsbY8KPEeOxBLV/D6UDMcH7/AIwLC5pupahy/l0s6WNwTyIWHgTma6TZADRWiloy
 Z0wtXbBdBTVocbJ+MhhHF2F7ylBOmJy4hi0tX5JIX4XrG07cH65dsNFWjt8o7WaQisiY
 LSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700651567; x=1701256367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pHG+p/7dmDL8K+jCe3ynyGYs4kUaHD4fINNC7XGjciQ=;
 b=LJS5exnZ+UQ0oKhLkPWLJ3WxFvhiEE3KN+Ctw2fIpdbJ1nD2oB+n+zF8+sLCnuwIci
 hO8ma7hG+gVPeet4JEtRlJLAFB/1UWmKb02hq3ymtIA5n1fP3OWUu4OJQSa4W3Wo3blv
 KSNAPFXBweONdITLq3obDz/kXKpBc1WBUYWnxGLyHzgPKtDJ7JwQNrGUjgZAkXvC/+Af
 mjI0Iuizn1wlnyA2+9sPeoo6wky4Vicdn9mRqRvTgL6YdewfPy8p/lGDVhbt/glEdPoZ
 6plJ2Odi4RSMVeBV79vUMaQRdjQ1TA6uhGmbhJG6xJugCgpPNs66twpJ3XRF/MO8uqVk
 qiOA==
X-Gm-Message-State: AOJu0Yy9MwbdvyWtiyj7fpjg9p5xQat7bKCskxfuI2fEbl9IuXX5o8Om
 DCSpPDmzwK8rf8sBSZqt6KqBVg==
X-Google-Smtp-Source: AGHT+IF8X2AGF0wGtbDv4JYn05an7iNDzvo2RS+HXt9FUmEMXP5jvS1lrdP60fEj7z3apHo+GGcjsQ==
X-Received: by 2002:a05:6512:e91:b0:4fd:faa5:64ed with SMTP id
 bi17-20020a0565120e9100b004fdfaa564edmr2020584lfb.11.1700651567371; 
 Wed, 22 Nov 2023 03:12:47 -0800 (PST)
Received: from [192.168.69.100] (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 a15-20020adfed0f000000b003140f47224csm16706766wro.15.2023.11.22.03.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 03:12:46 -0800 (PST)
Message-ID: <59356033-042c-4a15-82e4-7ab610752cb8@linaro.org>
Date: Wed, 22 Nov 2023 12:12:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ppc/spapr: Introduce SPAPR_NR_IPIS to refer IRQ
 range for CPU IPIs.
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org
References: <20231122092845.973949-1-harshpb@linux.ibm.com>
 <20231122092845.973949-2-harshpb@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231122092845.973949-2-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 22/11/23 10:28, Harsh Prateek Bora wrote:
> spapr_irq_init currently uses existing macro SPAPR_XIRQ_BASE to refer to
> the range of CPU IPIs during initialization of nr-irqs property.
> It is more appropriate to have its own define which can be further
> reused as appropriate for correct interpretation.
> 
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Suggested-by: Cedric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/spapr_irq.c         | 4 ++--
>   include/hw/ppc/spapr_irq.h | 1 +
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


