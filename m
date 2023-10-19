Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3207D0412
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:39:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaif-00020S-Jn; Thu, 19 Oct 2023 17:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaid-00020A-Rs
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:38:15 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaic-00077t-9D
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:38:15 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99357737980so26896066b.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697751492; x=1698356292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3CeRPiYyFBNOveaPAMyUact9Jjxt8XFEWnZM7/bb7Ew=;
 b=uhjJEPLj/Hy/sk6NQno+bqoiCZA+Djbj02I+SD/aOHohmzE1dae1LScVgrhOXuaOMa
 Fvhea0Ao0FDyQZcpa135BpU+H4BmsaiVyGWS2sYq1ZAq97b8EdjuWF3T7BzRpDY86leN
 Oyb5o+t2Nvqty1G6ZSZdhjs7OCeAwoop7X/1ETrp4izsvln/+yR3PmMMDg2PFpDsIhpH
 WHrEBrDmc7vMnkzUw7eH+tKbVwPq+CmZJTyZBYqYnSgmiirq4LG97IMm+rT8ombDbYY5
 FXsJpO6T67F92wNlgP9NSFsr1YoEY08xqJmZCLvIdnT+0HKnrQLndn5oucE0Ih8geKBo
 RujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697751492; x=1698356292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3CeRPiYyFBNOveaPAMyUact9Jjxt8XFEWnZM7/bb7Ew=;
 b=euBYrhcnj2Ix9ny4ZcgZ9CGkLEL+JVIQTXVcu5OqXXE2m9QAnPoSYJr+58tVTn9H0P
 SyUVoADZ3RsHSg/Quqnot2Uj+VsthCp3YMpaqADcRaeh0s0ghwKZhCBaQOz7Sw6eB5Nm
 cg1uEUpJGjEANyM99uji6z8zHw7x8VcHFmePL0X30tLei4gFtZ0iBXhsZRHJ2cdfnfLA
 rk13ukVCDHPpqGTAhKbhtJuc+sClAmtOXUxKExSovVTpZCnNkCPm8VQOaTvN7Uf6SCF9
 1W2eB7VYJFgsnN7BBdt19T1XStcHoVuHSnJIkx+/+7Q2DnlDVwaUBS0PzyoXSF45enDj
 9I5w==
X-Gm-Message-State: AOJu0Yxdfc0y7wK7niGpqU18UwlcztmCsLCbIY2NIvC8M41Y89VifL+a
 qILxZCGKEv/renM3bAq1kMuy5XrpUBttItMVSACrdg==
X-Google-Smtp-Source: AGHT+IGQc0X1oe4w6lZ31cLypSSErlqo5gDWztiZVNBCj+EbdVsXN32/oBfFZoCo1TfqwcMEKmup9A==
X-Received: by 2002:a17:906:4fcd:b0:9bf:30e8:5bfb with SMTP id
 i13-20020a1709064fcd00b009bf30e85bfbmr3056516ejw.48.1697751491747; 
 Thu, 19 Oct 2023 14:38:11 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 x22-20020a170906711600b0099b7276235esm228609ejj.93.2023.10.19.14.38.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 14:38:11 -0700 (PDT)
Message-ID: <f4a43dd8-a206-6c78-f9e6-89174102679e@linaro.org>
Date: Thu, 19 Oct 2023 23:38:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/7] hw/ppc: SysBus simplifications
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231019131647.19690-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231019131647.19690-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 19/10/23 15:16, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (7):
>    hw/ppc/spapr_vio: Realize SPAPR_VIO_BRIDGE device before accessing it
>    hw/ppc/pnv_xscom: Rename pnv_xscom_realize(Error **) ->
>      pnv_xscom_init()
>    hw/ppc/pnv_xscom: Move sysbus_mmio_map() call within pnv_xscom_init()
>    hw/ppc/pnv_xscom: Do not use SysBus API to map local MMIO region
>    hw/ppc/pnv: Do not use SysBus API to map local MMIO region
>    hw/intc/spapr_xive: Move sysbus_init_mmio() calls around
>    hw/intc/spapr_xive: Do not use SysBus API to map local MMIO region

Series queued to hw-misc.


