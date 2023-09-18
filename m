Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADFD7A4C50
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:30:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGCG-0001IN-7Q; Mon, 18 Sep 2023 11:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGC8-0001EJ-Bp
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:29:55 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGC4-0004a6-PH
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:29:52 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-530ce262ab2so2524427a12.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695050986; x=1695655786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2bJp7dMukpXKmC/EBPlexRdrTEjLNLwVrtG9XeLzG4M=;
 b=ke3QqJHUpH4hTT+jyxWjgTIpmakstATeImsn+1QkOpAi1/nobxZ4ClM1/RPXS7X90Q
 9r7OY3QwUaqeTG10B4KDehlD8dfUe8V+7N+mShgJzHwn367745lMwDMMQFqlFoeNGdG/
 2FBEcwL+Yq/46MCstiTqTdW/NN2dmTCybhpeABrpDr/TCbbqrpF+Dq0OCGtuJsT1DM4S
 /DaU7IA/dsAyNz5kpuHc0Oa+iypXLVK6X3d/cG0RlzEedGvIUjiBCGGljN0GP2DV0IQm
 AgrApcKzrgvO4TE6xsYZHQZhi0rL9CroXR/cNV4l8e/xO7QrFtQvheIEzWUjYzxFZJnd
 tL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695050986; x=1695655786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2bJp7dMukpXKmC/EBPlexRdrTEjLNLwVrtG9XeLzG4M=;
 b=mXWpadK1uQZGPIStYaDo+6b0PFq4cOwmspdajTIMjY/+V7Sq1II41g10Nxc1UK2TS7
 9t6Mnu/98pBb0wIToTbSnxhOA1cyOQT8SyBaEAWdnoavbIHFZ0Vv3FSxn3YmAzsKT0qo
 12XakLXj/Vx1TlvCKDkZBONotZX31L8zFbHGi4kX66PO7C8aKJ0wC/EVqUBjd2oju4MP
 sZoeftmRVYH3sUvpwm0pdPiSxZRC0pTI6Rem06y0DagH62EKyL00VXyFDcRy/d0/jdrs
 1hw09GaGnU17tLHMoR+jBc2nqPxVS2Mi6ffn7UA0MmNhJTvwpI+GqRnpJ5RcZRPr+y1l
 Ykow==
X-Gm-Message-State: AOJu0YxOQqAJmnsMf+yFAgSpT8br1US63M5fLd9ygxqXuKKlnrAXoWsU
 ec1lsDVMCLfXZNd3XoOYbcGgrQ==
X-Google-Smtp-Source: AGHT+IG0Abdn4mczICYQJRISrlJj/TaLIIL0g+6/C3vejwi23tfVc1+iHbMwtId0l5MUMuCkssl1Ew==
X-Received: by 2002:a05:6402:5d81:b0:530:ecd5:bc87 with SMTP id
 if1-20020a0564025d8100b00530ecd5bc87mr3980528edb.12.1695050985887; 
 Mon, 18 Sep 2023 08:29:45 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 d25-20020aa7d5d9000000b005288f0e547esm6184051eds.55.2023.09.18.08.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 08:29:45 -0700 (PDT)
Message-ID: <c3bb88b3-ffae-d767-d02f-0e154f918ae0@linaro.org>
Date: Mon, 18 Sep 2023 17:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 5/8] spapr: Clean up local variable shadowing in
 spapr_get_fw_dev_path()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-6-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230918145850.241074-6-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/9/23 16:58, Cédric Le Goater wrote:
> Rename PCIDevice variable to avoid this warning :
> 
>    ../hw/ppc/spapr.c: In function ‘spapr_get_fw_dev_path’:
>    ../hw/ppc/spapr.c:3217:20: warning: declaration of ‘pcidev’ shadows a previous local [-Wshadow=compatible-local]
>     3217 |         PCIDevice *pcidev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
>          |                    ^~~~~~
>    ../hw/ppc/spapr.c:3147:16: note: shadowed declaration is here
>     3147 |     PCIDevice *pcidev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
>          |                ^~~~~~
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/spapr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


