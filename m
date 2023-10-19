Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D307D043B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:54:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtayA-0005zE-V5; Thu, 19 Oct 2023 17:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtay6-0005wj-Cj
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:54:14 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtay3-0005kI-JH
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:54:13 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32003aae100so801633f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697752450; x=1698357250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m6uoA/gUdgh2gCfHCUiMY91LkGczWCPUe8MMf7DehIQ=;
 b=xznR3Zcce9skBsl8PYfY5L1ELoExBeIfTN+ruzQsyPgboSSh1Y9xx6/G4WOccEjx59
 awcHK8n+rtPTKHfwAIkxFvAEWvp9WD3eyO8tEj5y899JLRW9p9sLcdOY8OidRnbTtYu7
 oc3c4sm8UH/9FHGDxmAbwt3k3QDC2guGpDpUzTwgN4CTGDmvWNkB5+Y9KF9WzVcmyqKt
 1Dr8l1Ejq+vlShi9QzhGsPXX+K+ib25t4PFBKuOBl52nDDVJBbhsaSqHZMNyxUiDpEuk
 Z5osgTy0N1GyhSg2BuB/5abpx/8sUOob9tfb+3ysle+93djPwCtUzLg8iFJilw23zubk
 RA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697752450; x=1698357250;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m6uoA/gUdgh2gCfHCUiMY91LkGczWCPUe8MMf7DehIQ=;
 b=t6dC4woNxM2ZJE/5MsF/m4p2YXeUKbq1Qv78XywTRkKZRdCX6CzyAd+q62ATbvq5yH
 II0xB/RDXdGNPsSjnY/8/I6Od2CKN49jyCqih0acLeWrtOK5+Cz/UOp/XqNN/CA599Ze
 Y+ar/jR081dsGqShpCzMBLh/rlliiQNGepV1gd4z2Wf2/EPT2qbZ7rpzIcMG64fDpAOd
 GGyD9STNp5FHAFlxytRGt9g2XxkLyxY3tw3Ym67BEOma0kzhJ1eBC78UmZzjsrVm1mvv
 h5QtEJ28s0+CX2n//2eNL4A6a2SgnyahRvvKw+L7B4w7Hffl142e2M6OCSa3CL+NejJU
 qWYg==
X-Gm-Message-State: AOJu0YzJRAejR5FQqMqFf1A+yzLitWmOc+T78CvscjGrA/JAsilwbInN
 LvVUeFNkMUnpZz7uiyITEZsImA==
X-Google-Smtp-Source: AGHT+IGDt1gSeHody7YTbWUINNUhhTWbohK6IxMQLixKf84pLCcHfqW2im6+f0vLGo1CZz2aB98hNA==
X-Received: by 2002:adf:b346:0:b0:32d:cb21:4e99 with SMTP id
 k6-20020adfb346000000b0032dcb214e99mr2805828wrd.13.1697752450100; 
 Thu, 19 Oct 2023 14:54:10 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 r6-20020a5d6946000000b0032da4c98ab2sm267171wrw.35.2023.10.19.14.54.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 14:54:09 -0700 (PDT)
Message-ID: <85d802ff-bb4b-64bd-cb1b-471264a2f487@linaro.org>
Date: Thu, 19 Oct 2023 23:54:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 4/7] target/m68k: Use tcg_gen_ext_i32
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, laurent@vivier.eu,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
 <20231019182921.1772928-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231019182921.1772928-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 19/10/23 20:29, Richard Henderson wrote:
> We still need to check OS_{BYTE,WORD,LONG},
> because m68k includes floating point in OS_*.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 23 +++--------------------
>   1 file changed, 3 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


