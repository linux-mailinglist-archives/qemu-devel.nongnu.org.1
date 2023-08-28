Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5824F78B040
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 14:30:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qabNM-0004Qh-9E; Mon, 28 Aug 2023 08:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qabNK-0004QS-MC
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:29:46 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qabNI-00081P-Fz
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:29:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40061928e5aso29263615e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693225783; x=1693830583;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fm+LhOneseJKjCTd8Jbqjv3FFvyUGODXCCGQgoDG6o0=;
 b=bvY7j3WINXbpYgbhMjgjJZbOuG1EadFMNko5Fw/0K2U6T3l8kBVewDhwhE139vEdbk
 zCFzUxX9LBSEIGjTtzKREsGIcAKhHuy7yjwKdPMxeAiZQb2SKyLJAnVbzPIHykJ95Vpe
 K8s6lTjnUO25XMBjUILjpQyHRDfYrq9iiN0CknEn1OW6V/0RUS3to8zSDv9ntwGfXcgz
 Q8sZrK38f+GKxWt/PJ/FkqrqtLG8zhdmgsJEQ9dg+M1bhw8XCjzKyZDzZezk7I3NXgGI
 9eBOw50gbkokx0aFjPJOtEj05VkgmSPLGOkTdqfUuVK5W+gVUEhdVXusVdk3v/cPncU1
 mLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693225783; x=1693830583;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fm+LhOneseJKjCTd8Jbqjv3FFvyUGODXCCGQgoDG6o0=;
 b=YWvE36PAllUsF7r6S64QC44luxo0n4Jzsp3VwzU90bYPB/l9iU4llWEDnf6WIxPyOj
 qJIKmkk14yffbCr4FomjQbdt2zga/57YCCn+TroyPpYozhQESTB5VSZrq9tFP+XyaIME
 n/bhibVv4fGa8HSYioj19S8RcGkIuuX5K8rPRH64D5lg31Vccc84oZdU8d/wszsFsxJb
 sPkga5wKa11yGIXWyUMbtF/9qXqQyBLxNw7vO5LLYLSRwfz+z6+MRFA/vcSJ5GduHtrN
 QAMQNTk66MlJ8N5uY52NkAkY937pF6Lcl2TikClOzSzOh59/pB5OV8Rlkl7bNyrWyxXv
 bClQ==
X-Gm-Message-State: AOJu0Yw30WSg3uSRIlNTu+JdRIH9Sqd8yRbpebaaj/2bChPN4vM1WvRM
 kTZT1sKqTjy6JTpXe2wgGvoqQdCH2is+MxH9bAc=
X-Google-Smtp-Source: AGHT+IHqU/DygJ2TPrz/uA0YolcK+xBNB/CvlUEtHmIk+foTHU+v5KJkJNvud6oHbk8VQq6qQemYVw==
X-Received: by 2002:a7b:cc8c:0:b0:401:c52c:5ed9 with SMTP id
 p12-20020a7bcc8c000000b00401c52c5ed9mr3570051wma.32.1693225782885; 
 Mon, 28 Aug 2023 05:29:42 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a1c4c0c000000b003fed78b03b4sm10506971wmf.20.2023.08.28.05.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 05:29:42 -0700 (PDT)
Message-ID: <bcd40311-d5b8-3f15-1b18-512e920d9907@linaro.org>
Date: Mon, 28 Aug 2023 14:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 08/11] target/tricore: Fix RCPW/RRPW_INSERT insns for
 width = 0
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me, richard.henderson@linaro.org
References: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
 <20230828112651.522058-9-kbastian@mail.uni-paderborn.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828112651.522058-9-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 28/8/23 13:26, Bastian Koppelmann wrote:
> we would crash if width was 0 for these insns, as tcg_gen_deposit() is
> undefined for that case. For TriCore, width = 0 is a mov from the src reg
> to the dst reg, so we special case this here.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c          | 10 ++++++++--
>   tests/tcg/tricore/asm/macros.h      | 15 +++++++++++++++
>   tests/tcg/tricore/asm/test_insert.S |  9 +++++++++
>   3 files changed, 32 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


