Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C37A57B69B7
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 15:02:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnf16-0000cK-Ay; Tue, 03 Oct 2023 09:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnf0j-0000b2-9j
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:00:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnf0f-00069H-QL
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:00:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-406402933edso8497625e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 06:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696338018; x=1696942818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iOknJBTSReGg/Ah87Wo5wMdENcfmdmbpRBcksJRX00s=;
 b=RZALhq0LYiUzsAEgEn2TtlMUaCwxdQoRqru08e1UrcvZYe2gY6mQCpT2VFL9ZBkbyD
 Pn4uqubFjdHOwnW5Eqh/+CjCIwHlhzw5tKwP2doMVTXEnakaLbEPwq7xTOYac2XGJWyC
 kfknBO1Ao8E+s8e7FzlNxMVVuvNXcswtW//gE9kFwaAod1W5c3sSJmJTcgEacaxp9i1w
 vb5MLXy9okug6k2QhqknzEVdLwCA4yDnuU11ZnDOD4CdKKmI/co3QwkVYcLQ6tw5k7Ma
 1iaG62/DusDey959AOJ6jHvfxPNnrr/PGsEJMiUgGOz0r96MGgimt2GmHXfublWfHUjt
 ZiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696338018; x=1696942818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iOknJBTSReGg/Ah87Wo5wMdENcfmdmbpRBcksJRX00s=;
 b=Vb7BiILz3v275HO1XMDJ07xLPNnu150nOTgg/7cqkBFGacvABAVmNfLeb/JXv+G3qk
 YG56512YegrlyUwb8GXR1xOHWXtafhQ/ij0HE0H7gvtDbiGMVvlZaSf4FlhazgCVyLe7
 rGdr7cGbzFt8LGyJOOB7R6S2i4o0KKeP6V5efNfHtlHPAC3yJrTFmH1LzniuU6GDY3bx
 do05xy/tSuuykUugPSLJaj9ncOfDlYsmJmPH0/WYvY0IFWa/3R+pHSiZnlOy9dEiI2Jk
 6bS1fLsjS/fpMx0PxXUNa966LPiQ6H0p3uM87pwb2fSf9hRvavjT5wDqOdsGenZ6mmK7
 q6QQ==
X-Gm-Message-State: AOJu0YywhU92i2vOABWwVktxSpEXBOl0ajf5M4qiweac+UrKXZIC0CoF
 yV4JtX5W+qeL766BMYJ+cXKZsg==
X-Google-Smtp-Source: AGHT+IEEjmhxgBTcBB3U5rwp4S3A50gwaTf1COp3zluxkRk+jjQllmvVZb1lGaJRoF/uZNkzorutcg==
X-Received: by 2002:a05:600c:20a:b0:405:36d7:4582 with SMTP id
 10-20020a05600c020a00b0040536d74582mr11753192wmi.15.1696338017969; 
 Tue, 03 Oct 2023 06:00:17 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 11-20020a05600c248b00b003fefe70ec9csm9411855wms.10.2023.10.03.06.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 06:00:15 -0700 (PDT)
Message-ID: <0afc2728-882a-6f4b-d343-2ce126745034@linaro.org>
Date: Tue, 3 Oct 2023 15:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 08/19] linux-user: Add gen-vdso tool
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930021529.987950-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 30/9/23 04:15, Richard Henderson wrote:
> This tool will be used for post-processing the linked vdso image,
> turning it into something that is easy to include into elfload.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/gen-vdso.c          | 223 ++++++++++++++++++++++++
>   linux-user/gen-vdso-elfn.c.inc | 307 +++++++++++++++++++++++++++++++++
>   linux-user/meson.build         |   6 +-
>   3 files changed, 535 insertions(+), 1 deletion(-)
>   create mode 100644 linux-user/gen-vdso.c
>   create mode 100644 linux-user/gen-vdso-elfn.c.inc


> +static void output_reloc(FILE *outf, void *buf, void *loc)
> +{
> +    fprintf(outf, "    0x%08lx,\n", (unsigned long)(loc - buf));

uintptr_t? Otherwise nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +}



