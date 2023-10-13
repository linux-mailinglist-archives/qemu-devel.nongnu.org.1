Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ED77C80DA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDug-0005Kx-UE; Fri, 13 Oct 2023 04:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrDuT-00057Q-VJ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:52:43 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrDuS-0001rT-BU
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:52:41 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b2f73e3af3so281687566b.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187158; x=1697791958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=llUT1vlhvrkIv7DUnBRH1TQSHbe2bIeWhonBeS7jeh8=;
 b=n0DGd78Kun5G2drmvubhCGlZ4Lu59n40eGncFAXCYfmhIwbgeQ+eY97mBl4+LbVPyv
 n0slRKuinLUbw3NyCCCC5g24G86VEakJCIl51mYcFaPTGt2Ut6/90PMf/27XXhUwrphA
 mpk48dXuXO69y6ZNJkQ5VAH61oKlGFU6nxnU9+TvjEvwZc9/YaV4bhR0O6LRnXRjHJmz
 chTD1uXu7uBv2yD/AJphzLnhQQ8PLbBfw8+CSyv8PAZOzIFOCiCnmPSbcRusBzV9JFky
 bHQmueGiUwtVZfkZy/ax2LY9TFsWYXijZQxyLe6gbz4FiiDvRVYZEjs0GhOu9u4OdB1G
 TUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187158; x=1697791958;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=llUT1vlhvrkIv7DUnBRH1TQSHbe2bIeWhonBeS7jeh8=;
 b=QPMByh12z6+DGbOA310ycU1PUs7E4P8w7d4oIvo1IT5RURshExaJ/zhgFeZI2EKq9Y
 1gyHle0g7BRYR8SDaZbW8m3MRyXZP7o7Y88ZY2Qey9dM6mNHaY3zVem8xP7jn9hvqmtR
 zxk0JvH/TPDpMSuKyyb0nUGqUX2tCfPDo+Ww735yA8FxZOHAzJ1dvOERB7UlggW9KqQE
 vE8freKzmL1uGZHsoekhMeEKkFYNTk187zgEsudxTLGYzaIUGClyZlQmpN/zLAnTbkTP
 PGdLjsiQVMJRPt+Rt8OGd03Z8r3X+yNKBxhdS6nOFjfUw07LbnEp5YhSmykSfiuefux+
 z+uQ==
X-Gm-Message-State: AOJu0Yx3HPXjcTFrwBT5ky3kmMNiIOpBp1+Xriclel55whsvuCcffItm
 3K5DfsOtalUw1wYD6s/vGURIHg==
X-Google-Smtp-Source: AGHT+IGsHMIT01p6ohU61fhqxz4fDLO1UWtYKXbQ0pD4VjlhbDeLYFJiTU2NvQjCMfRzo1v9wrEbXA==
X-Received: by 2002:a17:906:7496:b0:9b2:93f2:71b0 with SMTP id
 e22-20020a170906749600b009b293f271b0mr23024336ejl.38.1697187158428; 
 Fri, 13 Oct 2023 01:52:38 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 op13-20020a170906bced00b009a13fdc139fsm12153259ejb.183.2023.10.13.01.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 01:52:37 -0700 (PDT)
Message-ID: <657c8046-04f5-a131-cfa8-aeb493caf760@linaro.org>
Date: Fri, 13 Oct 2023 10:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/cxl: Fix opaque type interpret wrongly
Content-Language: en-US
To: Li Zhijian <lizhijian@fujitsu.com>, jonathan.cameron@huawei.com,
 fan.ni@samsung.com
Cc: qemu-devel@nongnu.org
References: <20231013015515.23647-1-lizhijian@fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231013015515.23647-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 13/10/23 03:55, Li Zhijian wrote:
> void cxl_component_register_block_init(Object *obj,
>                                         CXLComponentState *cxl_cstate,
>                                         const char *type)
> {
>      ComponentRegisters *cregs = &cxl_cstate->crb;
> ...
>      memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cregs,
>                            ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
> 
> Obviously, opaque should be pointer to ComponentRegisters.
> Fortunately, cregs is the first member of cxl_state, so their values are
> the same.
> 
> Fixes: 9e58f52d3f8 ("hw/cxl/component: Introduce CXL components (8.1.x, 8.2.5)")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   hw/cxl/cxl-component-utils.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


