Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B61567EA2A2
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:14:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bR3-0002h9-Vf; Mon, 13 Nov 2023 13:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2bQv-0002eo-TJ
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:13:16 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2bQk-00080p-2n
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:13:13 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1f060e059a3so3083805fac.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699899179; x=1700503979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZBVS57ugFH+dWwwgJQNw/EdC1LQ7A71bAIRGFWgr9qQ=;
 b=aEgVj+sdulIhE1sffrh7YKfQDCF+j3BYfG9EEmOkKh0PYqgk4EIgTMOT+/mJp/DJcl
 UeP1hDVbuLkZn067hrHFyCmgk4CosMqWJg65px0y836p+GyfREy1BD5WXyguU8jSK+02
 vlis/bkDQAXJq16GckadnhhvayKh37IaXJy6yNeDOIuHe2ugaT1DjHhInhgJyFM/mq6M
 mDHN2J3Nu+jAG1gnwvdNNtOEFqOdsGENrYemOevNvmS4cOqaWPfyuLpJ4kQif2jCdzOO
 UzzZPWtbzDh3lFmOocd3vi5lAnPW0M++x3WdHpFDgY8OPJ3n27swGH67hbWRaWvMnLGD
 txaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899179; x=1700503979;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBVS57ugFH+dWwwgJQNw/EdC1LQ7A71bAIRGFWgr9qQ=;
 b=attjsqvFVb07WglrFdg2cjR9oXzKMbNS2+H0A9PncSNwW1G1K2r22YFS48A+hdqAMW
 lb1PG1CMYV4CJfRYFhkkL2dvFbV/H5s/i0Je4vsY+Y3R/8Qnya6CPCOqjK2X1AHHOH+r
 RDWuErEcln/xYJdzi7AVnKvbHkgb6rWIF6XgjRtV+HVaz0AadkoYZofqpTyiXFF9lRyj
 7i4j1oulvgJfbWnFniO0vgAyaI6eTfPOlRG6RvtJEN1VYPFuWoFQVwWv59UhjkNxQWdu
 TEwUWMSV+DfdCJtQVsc+KKesGuF9GRewaXJnuJLMg/71vm7bAhxPRa2MAsBKLcSgoSYf
 FGVQ==
X-Gm-Message-State: AOJu0YwCeUaKY22zhojckXZM/iS/Ntd2s73hlQg1dwPJ8tCQ1idcxymE
 YfL4CABxdABf0smtTYeGEAi0ew==
X-Google-Smtp-Source: AGHT+IHouUBCiMX9KBY+uYOICqzQx66TRgfPBXn9EutFo+KHFLUOx3FPF3CRi5Kl+BGT8JiIk0Cxfw==
X-Received: by 2002:a05:6870:3045:b0:1ef:c944:222b with SMTP id
 u5-20020a056870304500b001efc944222bmr9441610oau.11.1699899179250; 
 Mon, 13 Nov 2023 10:12:59 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 it13-20020a056a00458d00b006b58af8aae3sm4092255pfb.77.2023.11.13.10.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 10:12:58 -0800 (PST)
Message-ID: <1c57d09a-14ab-4dc3-bc23-31e1ac906f82@linaro.org>
Date: Mon, 13 Nov 2023 10:12:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 02/10] hw/xen/xen_arch_hvm: Rename prototypes
 using 'xen_arch_' prefix
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20231113152114.47916-1-philmd@linaro.org>
 <20231113152114.47916-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231113152114.47916-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/13/23 07:21, Philippe Mathieu-Daudé wrote:
> Use a common 'xen_arch_' prefix for architecture-specific functions.
> Rename xen_arch_set_memory() and xen_arch_handle_ioreq().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/xen_arch_hvm.h  | 4 ++--
>   include/hw/i386/xen_arch_hvm.h | 4 ++--
>   hw/arm/xen_arm.c               | 4 ++--
>   hw/i386/xen/xen-hvm.c          | 6 +++---
>   hw/xen/xen-hvm-common.c        | 4 ++--
>   5 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

