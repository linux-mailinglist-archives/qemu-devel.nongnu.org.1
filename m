Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AB17D787E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:24:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnEA-0000Ag-D5; Wed, 25 Oct 2023 19:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnE6-00005m-7v
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:23:51 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnE4-0002op-He
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:23:49 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cac925732fso1970305ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698276227; x=1698881027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YzUOicqAHZtKpGRgbqgDSyXm04r78JXVYAf/cY5pEuk=;
 b=KHLywVn8XWKE0rflxDh+I26tlshcJHJAwlpVtcUKynni6PmUOfPyhzsF+aH8JDu3dJ
 5RtwNqHhs1DSf8ehnajQR1z0ymI9314AvnusDbBcCFpCMAG6SG1d8XKOS7ntIVy2cCl9
 r3mC56p07NvgrKq/ScIMwU5Pl/iGf7aOmDb2vuNjiLZ+JioslF/x4qxPLQx1V3MMCD6l
 b3WGRSBHnt26M8HC/jY4FKfooSFhdgDl1KXJCqJqzLfaOj+jPksjoLtzsKgupH1BByvo
 +gy7jtWTPbTGnZ/Vg9PYWg70qJhVIreOB6Rbjn8XYzvTXavJjjZYgaf1DenvFKHCCAOp
 un6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276227; x=1698881027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YzUOicqAHZtKpGRgbqgDSyXm04r78JXVYAf/cY5pEuk=;
 b=P+wvvx/5/VyuG+gMaI0Q6JO0y3hGEFO/ydymObUHwuWiQl42VIMDzcvuKIxd1PnOdP
 YxiLvuTVzwTQAbPlsPu2cEvdxpwJ/xasLWTMO8xkpaAd39Y30Mnub+4rocGSeIHmbMnq
 FL+qzhRTMqJjBwF7wQ6Le08iEMViu+R4YTlKy00c8suMFjL2uKq9lqiBxBd2SJqGBTtF
 fFSHqup1wtfXPcVChoqv7ogzQn6KJF3IGUyYf4L9y1w5CLLmsgVdP2ZHmB257Rf+FRHi
 RsDKdN55twgczQleUaSN9H9O4TnmfQEgULIP2HewfI/TgGXNViUUnKY30FNmcpR0EkQJ
 E13A==
X-Gm-Message-State: AOJu0YwTrgg3OcXR/ssesFZjagk7KYnqTBfzbCX9iWdH+xDgqtiLMrd/
 uoja5atdxXCbLzRIMTYadGD64w==
X-Google-Smtp-Source: AGHT+IGjTQpuaCKXmD3uVw0yHW26KIKffepWc8q/joSTGCzBRuz5Dmk2Mt+V/xev48VXLLQjsMCVLQ==
X-Received: by 2002:a17:902:f988:b0:1c3:2df4:8791 with SMTP id
 ky8-20020a170902f98800b001c32df48791mr13293281plb.27.1698276226918; 
 Wed, 25 Oct 2023 16:23:46 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902680d00b001c0de73564dsm9926456plk.205.2023.10.25.16.23.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 16:23:46 -0700 (PDT)
Message-ID: <f4c07e08-fa8c-4876-9867-1ae661e290e2@linaro.org>
Date: Wed, 25 Oct 2023 16:23:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] hw/arm: Move 'hw/arm/boot.h' from header to source
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20231025065316.56817-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231025065316.56817-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/24/23 23:53, Philippe Mathieu-Daudé wrote:
> Almost no ARM board header requires "hw/arm/boot.h".
> Move this header inclusion to the source.
> 
> Philippe Mathieu-Daudé (10):
>    hw/arm/allwinner-a10: Remove 'hw/arm/boot.h' from header
>    hw/arm/allwinner-h3: Remove 'hw/arm/boot.h' from header
>    hw/arm/allwinner-r40: Remove 'hw/arm/boot.h' from header
>    hw/arm/fsl-imx25: Remove 'hw/arm/boot.h' from header
>    hw/arm/fsl-imx31: Remove 'hw/arm/boot.h' from header
>    hw/arm/fsl-imx6: Remove 'hw/arm/boot.h' from header
>    hw/arm/fsl-imx6ul: Remove 'hw/arm/boot.h' from header
>    hw/arm/fsl-imx7: Remove 'hw/arm/boot.h' from header
>    hw/arm/xlnx-versal: Remove 'hw/arm/boot.h' from header
>    hw/arm/xlnx-zynqmp: Remove 'hw/arm/boot.h' from header

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

