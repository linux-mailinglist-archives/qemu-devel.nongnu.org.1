Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C27370FE36
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 21:07:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1toj-0003HL-9h; Wed, 24 May 2023 15:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1toh-0003Gx-Dl
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:06:35 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tof-0007O7-Cf
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:06:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d4e4598f0so1393553b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684955192; x=1687547192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p9bdCH0rr3Qzd9En3mlFlRjDUiyvkssUGWlCPomvkcw=;
 b=BSExmUxAMQggFjHT3V17NdJij3+1dpUXwx5UnWquaZ28dcKa/AOC17gz8TXsbllZ2L
 LupKipopkumre3K8omstm6igx/74KHWK26Ghsxint0oe/YP+4PU7zw84z6zgvK0u145S
 wU/SrM/S6sbvH+BaCBA+MM32MSklToubL1KNL+1zsDqnCVnEesLxkYlFXdkZgnH0FseO
 K0zhU+GxoqEPVCSDZDiM7WJgNBm00r2VuXlKF0QaQvxy/Jgn0rzKRpjZya3CrGsEY2ss
 1sVxb9MICCSjz/v5UNjjbkvuKKmV4oT+Vg+xNcVsAh23d8kbhOc5o98j+0brm2mQHrPD
 GQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684955192; x=1687547192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p9bdCH0rr3Qzd9En3mlFlRjDUiyvkssUGWlCPomvkcw=;
 b=RnatkkO6F9Trp4TVkPTTysCVIJLmcDQTuZ1a1ceIc+hFxMKibsWrt1+JeR8eJU0Aq2
 wble+/Xy4xssOv1ISZfKq1uYm0OZMbtA0nOZkn844REY0NdNx52lGGycU4jUCWrJaJNt
 sJo4gQQhyBDR/tPyUezJXG/vy8XqzUGLvGM+/8II7uXoJ76RyjDn+nmZIZ46GcKcBDoL
 /rvfFByXnKf2plTxvNTk3AfLrvqc6A+FNKw+4ZUfSrvix56fbdt+AhRPkBDnL9s3VxJr
 X5njLEmoqmFtdHZTqbpuf2fg4kXRXVhq4ICyPAkp2/84q7cnuJfQV7nOOt5LDqdBYKkj
 wYjQ==
X-Gm-Message-State: AC+VfDwgDggGBQ3GyIQVj0qv9yMrEBOnv6/LJxZIxHSI/Z9HV4VNHMOB
 ntnLIq+ou68aO/azMCgwiKddxQ==
X-Google-Smtp-Source: ACHHUZ7oBQ4x2kJA7Tcf8o1YXXBiMd1dMmx88stTODRc+eRN0qE46sWG6Qv5RiiYLVL4z30MQFQxSA==
X-Received: by 2002:a05:6a00:cc8:b0:64d:7162:9cf0 with SMTP id
 b8-20020a056a000cc800b0064d71629cf0mr4553772pfv.8.1684955191994; 
 Wed, 24 May 2023 12:06:31 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 y4-20020aa78044000000b0064928cb5f03sm7768408pfm.69.2023.05.24.12.06.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 12:06:31 -0700 (PDT)
Message-ID: <9a524656-6e69-a044-3303-79b7a7bd1c10@linaro.org>
Date: Wed, 24 May 2023 12:06:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/10] hw/arm/realview: Move 'board_id' to
 RealviewMachineClass
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20230524145906.33156-1-philmd@linaro.org>
 <20230524145906.33156-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524145906.33156-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/24/23 07:59, Philippe Mathieu-Daudé wrote:
> Instead of having each machine instance resolve its board ID,
> set it once in their class_init() handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/realview.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

