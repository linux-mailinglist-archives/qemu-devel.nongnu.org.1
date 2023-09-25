Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A3E7ADCFC
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 18:24:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkoNa-0001Ld-Bj; Mon, 25 Sep 2023 12:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qkoNW-0001LC-Qn
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:24:10 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qkoNV-0002Vq-At
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:24:10 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-533edb5ac54so3543218a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695659047; x=1696263847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8+a6yLUvWXDzXXV2T87UOh+1Nksw0K2QIE4gvsr3dP0=;
 b=FXnLtWd0T4qpNSWsleXoCaM6AjpbvvkViOWneG19OIgKurhkUE3l+s8D1RKyqkminZ
 Myeiw9Q/nZp6LjuOJYluRNsn1Dl5c8446ar0pYd1/ncy3ISnN5+jzlP4rXSkTrSXfD8d
 wcEJEC++eEaPmYQZvNzuYgiDw1z8L/j0WK000XPyqI3ZOeIYb40uHvKURS+Oyra6LGUH
 FfsPr1QiaJjEI+v9YQTVWOeyOwUhk6kCT/AK/BWeWshBHBo/xY7D3hnJ58+uyuVKLwtR
 rwQdiyIBB9E4iR0abgwCToEVwATqU3JSNC9BAQQ3ENhk4OPqdh3xP+RmpaAbfiM44g8B
 m8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695659047; x=1696263847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8+a6yLUvWXDzXXV2T87UOh+1Nksw0K2QIE4gvsr3dP0=;
 b=CRop2yxe2mMKdPs31IEfD1+0odZnFcdlcuJilffrSPUAK5ctfB2ELJ1DdbMRlEdflc
 H88VTL2kwJL2BuZ98ICYe9EGk5dEScRbeJenFh3J97iimWx0JjKd5EMeYoVSXp0c/aDd
 Phs6zM4gHkk8EmzfXuWmk2EmQfJPwtidfBBcK+rrkWznlzd7HdPfwDGwNnt6rhzHthl7
 XtzTbXwXD1NqChuH/mrxbQ4oJPSUUzfx9Voq1VzIYIUnIG85EIXEW/AnoIlZNdixYmoZ
 3jVqmJP0qbxjC1/HAaGZpyB+mbChyShgHV+8fRxR7lpmvSLrPUNmhrZ43qiurOtxVVy6
 tLRg==
X-Gm-Message-State: AOJu0Yy4993POFt7c9H0PSdUCPJ6b+j0gDsb2cYphxO7M+pLJJFJeF+u
 o7v00lj9kKAm3tLt114CAXBUpw==
X-Google-Smtp-Source: AGHT+IFZHt/UEnm2oW+TR7cL/j7Q/hzowjNV52fUP2hEYUiOJihPSaSpwq6vR/bnIb4CnYGleftdPw==
X-Received: by 2002:a17:906:518f:b0:9ad:c132:b93e with SMTP id
 y15-20020a170906518f00b009adc132b93emr5923291ejk.28.1695659047090; 
 Mon, 25 Sep 2023 09:24:07 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-91.dsl.sta.abo.bbox.fr.
 [176.173.161.91]) by smtp.gmail.com with ESMTPSA id
 k8-20020a170906a38800b0099bc2d1429csm6548746ejz.72.2023.09.25.09.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Sep 2023 09:24:06 -0700 (PDT)
Message-ID: <f5a909cb-609d-0329-672e-3f6f089c75d9@linaro.org>
Date: Mon, 25 Sep 2023 18:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] hw/sd/sdhci: Block Size Register bits [14:12] is lost
Content-Language: en-US
To: Lu Gao <lu.gao@verisilicon.com>, qemu-devel@nongnu.org
Cc: Jianxian Wen <jianxian.wen@verisilicon.com>,
 Bin Meng <bin.meng@windriver.com>,
 "open list:SD (Secure Card)" <qemu-block@nongnu.org>
References: <20230922020312.30828-1-lu.gao@verisilicon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922020312.30828-1-lu.gao@verisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 22/9/23 04:03, Lu Gao wrote:
> Block Size Register bits [14:12] is SDMA Buffer Boundary, it is missed
> in register write, but it is needed in SDMA transfer. e.g. it will be
> used in sdhci_sdma_transfer_multi_blocks to calculate boundary_ variables.
> 
> Missing this field will cause wrong operation for different SDMA Buffer
> Boundary settings.
> 
> Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
> Fixes: dfba99f17f ("hw/sdhci: Fix DMA Transfer Block Size field")
> 
> Signed-off-by: Lu Gao <lu.gao@verisilicon.com>
> Signed-off-by: Jianxian Wen <jianxian.wen@verisilicon.com>
> Reviewed-by: Philippe Mathieu-Daudé? <f4bug@amsat.org>
> ---
> v2:
>   - Add fixes information and reviewed-by information
> 
>   hw/sd/sdhci.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)

Thank you, queued (pull request will be next week).

