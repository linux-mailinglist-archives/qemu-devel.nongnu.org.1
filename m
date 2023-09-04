Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC73779190C
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:46:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9tl-0001cP-7j; Mon, 04 Sep 2023 09:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd9th-0001bw-Mq
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:45:45 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd9te-0004af-Pp
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:45:45 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso212004366b.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693835141; x=1694439941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dveQUEAvemW9I8YRw3cIPQPyAvdx+sH8Cofh5E8QoS0=;
 b=cz9N8NLu5w0Tc4upujlgjF1pRMlqdl0mgOBgh4YrDVQtHKyUrHFpm4jKs4IrH5T5AW
 V22W+O+cpT0d19BtHEAchPLrviP5qsEu5NrjAokchzOWQQgGOk41LaZMcBJ0vGdtFc3e
 PdB7jDtsg988Bhjo8SDjLuyNb1QnznnXm5tSc5AoUf50dskOGkl4glG6e8YYWvj1oAwB
 69nqq0evn/+Q+iFvHWNqu+1xmgnORIIScJ+S2SHu4AJZDF/XhFUBhBtgX+9UINYJr1zJ
 4VZdxbyXF3l7MGg6DsitlXyM3ScWpwvzB2ETjAJlrqiJglDXVrA9hlgD7kQ/ZQO0sMoK
 4jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693835141; x=1694439941;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dveQUEAvemW9I8YRw3cIPQPyAvdx+sH8Cofh5E8QoS0=;
 b=JWDjIxW8MvU6PhBiM6q0qpp2aXLNs/i5QdoZSJp4YyJsWPUy9a2E1Jo8y0bV1Se4XD
 vIfhHuFdANPPNK34XUVeJNU84Aufx+cia2Pb5wirL/90f7Jjn46YCOcWEaLVtTAgKUTt
 107YaGYhdx9WpN10JwXcL+ifGI22VeGL1TAed2D4MGb9udC+RriLtn7GEKAuHLPBBCN/
 sw1w1T6LIT2WgLMa9PHsqCDEIZQqlLMwO5q54OhqcWLBpM7a0POtitBFBUk/X+pmGtsh
 PZln33c+FWHAzLEvJ4sP/P31JVCpqCXnqsc1EgV7WUS75VTmuPIcE5Ltp2xpGBV4m1GM
 nyfA==
X-Gm-Message-State: AOJu0YwdBnSVNL9nQeDx0T5G4moMgQrzX02uSKeJRTBVJOJOvCl5KNLZ
 x8e+B06fflS2i6QJnByNXJsyqQ==
X-Google-Smtp-Source: AGHT+IHOOndRquWTygdUg8VUT1+U+bUI+9aACnqPkr1Mx9rzkCKLBvoF4da8FZ6dK0a4xGlt3ySNEQ==
X-Received: by 2002:a17:906:3091:b0:99b:ed44:1a79 with SMTP id
 17-20020a170906309100b0099bed441a79mr7246789ejv.3.1693835140691; 
 Mon, 04 Sep 2023 06:45:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 h23-20020a1709063c1700b0099d45ed589csm6154590ejg.125.2023.09.04.06.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 06:45:40 -0700 (PDT)
Message-ID: <9fcd5396-e6c2-b5fa-6d6c-3e950bc15155@linaro.org>
Date: Mon, 4 Sep 2023 15:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/4] hw/pci-bridge/cxl_upstream: Fix bandwidth entry base
 unit for SSLBIS
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Dave Jiang <dave.jiang@intel.com>, 
 linuxarm@huawei.com
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
 <20230904132806.6094-3-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904132806.6094-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 4/9/23 15:28, Jonathan Cameron wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> According to ACPI spec 6.5 5.2.28.4 System Locality Latency and Bandwidth
> Information Structure, if the "Entry Base Unit" is 1024 for BW and the
> matrix entry has the value of 100, the BW is 100 GB/s. So the
> entry_base_unit should be changed from 1000 to 1024 given the comment notes
> it's 16GB/s for .latency_bandwidth.
> 
> Fixes: 882877fc359d ("hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/pci-bridge/cxl_upstream.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


