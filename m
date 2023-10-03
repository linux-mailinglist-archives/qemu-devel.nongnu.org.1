Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C92D7B60B9
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 08:25:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnYoU-0005g1-7C; Tue, 03 Oct 2023 02:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnYoR-0005fd-VQ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:23:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnYoQ-0000t0-B6
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:23:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4054f790190so5387775e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 23:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696314196; x=1696918996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yNPCrajTh57Jjbi/jtn+1FxXShjLbKmdOEGxNykJkZQ=;
 b=UsqjcRbDvdclwTBrsbYs0fDhu2UJ7EG97WiVwr4eru7ic3UF6qRQlYpFuBtjNrKEgD
 Wt9fFhONLwY4h69bt/CniQO1dtM7rWIjELuhxa7tA1OTgpbcgiCXo1VwmdmFegGXV9ur
 csmxyz9CELXShmFJ7kGDzT5uugmLg/Bj8LK168vnmAMpCL6bIpI8oic16QD7Cmikbw0O
 WSNbyeAVuV3v4JGPg3xwwc3QJIYFPYwy9nZjjU8m3IncBF0QY3iyAPR6HZCvGyIY99yq
 cxT86xdUajl5gpcQuHH/lM7jxFKYOchzMMXbKO2SUeUeha4uOw5bCcNMXY9LA4NEGu1O
 SNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314196; x=1696918996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yNPCrajTh57Jjbi/jtn+1FxXShjLbKmdOEGxNykJkZQ=;
 b=ZIYSiqTgT2h/XGDGG3JJ0kK6x4/f7DASyYek/QG6dUDfJfc9DYw1A3pbI4AeWSjucq
 k48zpM3pnPBQldmLEMMUULlYQt887ZBaRXdpTkyiI1E3M4zaHKGRf9Dp3bqg5RHAUY8Y
 ex0jMO1n87HECFvcubemlVmIXDDPtDW5swTXtTK/mert/bZvakUDt1jJMvuiJOV8iXn2
 ZyxGfb0Fmf+/rC3VI0I0v1bue79n6nqumeppmQYYsHb+yahoQiAZ/QnHXkIr3wI6ZMcV
 WUymiXlmtQ16rSMbJFzsHo9O+PLnDT5FFziLS3R1tBpqxcdOcqvqhuYEIwGPZFkuai8R
 qa4g==
X-Gm-Message-State: AOJu0YwwqaB5Qw6zxPnMw6CLsYwwq+QkMBVf1SYhu/ky3iEK2dgeBGFe
 xCAqd9fzGLuLkPhksG4kCmL8kA==
X-Google-Smtp-Source: AGHT+IG3wcjYYGEgW5I7yoFeprWFNGoQg7UTEtYVN9GS935ou5c2jXGRl2dirtS5iwVKjCMEyzlWGQ==
X-Received: by 2002:a5d:6986:0:b0:320:b24:4361 with SMTP id
 g6-20020a5d6986000000b003200b244361mr11629310wru.34.1696314195987; 
 Mon, 02 Oct 2023 23:23:15 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 da4-20020a056000196400b003279518f51dsm750608wrb.2.2023.10.02.23.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 23:23:15 -0700 (PDT)
Message-ID: <06cd7690-adb6-e9ff-abf7-21c8c05efc2c@linaro.org>
Date: Tue, 3 Oct 2023 08:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] xlnx-bbram: hw/nvram: Remove deprecated device reset
To: Tong Ho <tong.ho@amd.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, alistair@alistair23.me, edgar.iglesias@gmail.com,
 peter.maydell@linaro.org
References: <20231003052345.199725-1-tong.ho@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003052345.199725-1-tong.ho@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
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

Hi Tong,

On 3/10/23 07:23, Tong Ho wrote:
> This change implements the ResettableClass interface for the device.
> 
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---
>   hw/nvram/xlnx-bbram.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Since you did this one, do you mind updating the other Xilinx devices?

$ git grep -F -- '->reset = ' hw/*/*xlnx*
hw/display/xlnx_dp.c:1399:    dc->reset = xlnx_dp_reset;
hw/dma/xlnx-zdma.c:827:    dc->reset = zdma_reset;
hw/dma/xlnx-zynq-devcfg.c:387:    dc->reset = xlnx_zynq_devcfg_reset;
hw/dma/xlnx_csu_dma.c:714:    dc->reset = xlnx_csu_dma_reset;
hw/dma/xlnx_dpdma.c:601:    dc->reset = xlnx_dpdma_reset;
hw/intc/xlnx-pmu-iomod-intc.c:539:    dc->reset = xlnx_pmu_io_intc_reset;
hw/intc/xlnx-zynqmp-ipi.c:362:    dc->reset = xlnx_zynqmp_ipi_reset;
hw/misc/xlnx-versal-cfu.c:498:    dc->reset = cfu_apb_reset;
hw/nvram/xlnx-bbram.c:526:    dc->reset = bbram_ctrl_reset;
hw/nvram/xlnx-versal-efuse-ctrl.c:753:    dc->reset = efuse_ctrl_reset;
hw/nvram/xlnx-zynqmp-efuse.c:841:    dc->reset = zynqmp_efuse_reset;
hw/rtc/xlnx-zynqmp-rtc.c:258:    dc->reset = rtc_reset;
hw/ssi/xlnx-versal-ospi.c:1833:    dc->reset = xlnx_versal_ospi_reset;

