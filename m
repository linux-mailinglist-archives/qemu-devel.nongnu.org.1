Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C29EF7A471A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:33:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBYH-0006Nc-4l; Mon, 18 Sep 2023 06:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qiBYD-0006NJ-F9; Mon, 18 Sep 2023 06:32:23 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qiBYB-0001Pj-GQ; Mon, 18 Sep 2023 06:32:20 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a9ee3c7dbbso2863391b6e.1; 
 Mon, 18 Sep 2023 03:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695033137; x=1695637937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OB9xhdXP0Hj9nZGxQdWksW9faf4V/732NuriWf6na7g=;
 b=E8lGrqsvnq44MqazSzEoOGsO4/fTyOe0JsFwROCA7eD9pRRhw/ySNkeuQLnZJR7fdx
 BWY/1D5e4440JFnijQNqzSCyZYmr85XwHJmVnowP7Q24I6HcUXDXV7G7Mtne4ACkHlIp
 rsf6wslV4ufZ7v78X/5Zm+RrWT9C/JTh4epS/Texw7ksCay8dLsB3oFHmjP5YOa0UQOe
 YdsUZSDXISiuuUrGLwBTu15KQTE4YVEC1Dcmcy9GrWUgidmC9RS6Pu/Qmi79oFeDwaOI
 qXtT7bx+MyyX6Pt9ndp69wF/A99JJRKRje3tHPvVzw60Ye3N98WxFBVqayiln6Q8w6Mj
 xNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695033137; x=1695637937;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OB9xhdXP0Hj9nZGxQdWksW9faf4V/732NuriWf6na7g=;
 b=tmjmr1HJX0b9RJ4J64SPrjzHvi/C1xBOV7yVQwGh/NqlPn5GHM22n9TArAvFHbT2dk
 ifZJ0POUGM80r7QvRvyEHjITPkFVqDJ1rWTAqllH+DJBuUv6D/Ll8jD4rj5NRibpetQi
 rVUbLPfzDoYq1LnJtgvs1uzSYoF+6w1cy+IVmB0VaRyQCLDeP8cZ8WmQqUPPRacb05Og
 889EmknU4G0OknXXySORiU0uaufuwpmdeNECmFuh5jPQLlDFnFmynH9OjOlS4rgtTu5e
 oAogzeaDRx7+jd8U7UoBBs3TBfDIMeMEk56mLgeyNV1lxLk+JVV8GmPz8skPx4MipZdY
 isJg==
X-Gm-Message-State: AOJu0YxOeIGVVWZFkSey0m/k8oHfKv3ipPB47l5HE2QnpNE4Q6WvpuVE
 5QcjUt5V04tMYkLt6wfPrMwTejeH2WU=
X-Google-Smtp-Source: AGHT+IFij10Re3Y2sS3MJS3xhLOnjlAobIsZrj7GKN9TnawqRxfvmJ2PL2p0gpBW2cBfxd/amk10TA==
X-Received: by 2002:a05:6808:1396:b0:3ad:c5f3:36c6 with SMTP id
 c22-20020a056808139600b003adc5f336c6mr5829335oiw.38.1695033137031; 
 Mon, 18 Sep 2023 03:32:17 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.127.211])
 by smtp.gmail.com with ESMTPSA id
 fa12-20020a0568082a4c00b003a4243d034dsm3884783oib.17.2023.09.18.03.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 03:32:16 -0700 (PDT)
Message-ID: <1035c5a6-1138-0889-26b8-579733e5b01d@gmail.com>
Date: Mon, 18 Sep 2023 07:32:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org,
 npiggin@gmail.com, aik@ozlabs.ru, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>
References: <20230915110507.194762-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230915110507.194762-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-1.473,
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 9/15/23 08:05, Daniel Henrique Barboza wrote:
> Update all relevant PowerPC entries as follows:
> 
> - Nick Piggin is promoted to Maintainer in all qemu-ppc subsystems.
>    Nick has  been a solid contributor for the last couple of years and
>    has the required knowledge and motivation to drive the boat.
> 
> - Greg Kurz is being removed from all qemu-ppc entries. Greg has moved
>    to other areas of interest and will retire from qemu-ppc.  Thanks Mr
>    Kurz for all the years of service.
> 
> - David Gibson was removed as 'Reviewer' from PowerPC TCG CPUs and PPC
>    KVM CPUs. Change done per his request.
> 
> - Daniel Barboza downgraded from 'Maintainer' to 'Reviewer' in sPAPR and
>    PPC KVM CPUs. It has been a long since I last touched those areas and
>    it's not justified to be kept as maintainer in them.
> 
> - Cedric Le Goater and Daniel Barboza removed as 'Reviewer' in VOF. We
>    don't have the required knowledge to justify it.
> 
> - VOF support downgraded from 'Maintained' to 'Odd Fixes' since it
>    better reflects the current state of the subsystem.
> 
> Acked-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>   MAINTAINERS | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00562f924f..c4aa1c1c9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -298,11 +298,9 @@ F: hw/openrisc/
>   F: tests/tcg/openrisc/
>   
>   PowerPC TCG CPUs
> +M: Nicholas Piggin <npiggin@gmail.com>
>   M: Daniel Henrique Barboza <danielhb413@gmail.com>
>   R: Cédric Le Goater <clg@kaod.org>
> -R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
> -R: Nicholas Piggin <npiggin@gmail.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: target/ppc/
> @@ -438,10 +436,9 @@ F: target/mips/kvm*
>   F: target/mips/sysemu/
>   
>   PPC KVM CPUs
> -M: Daniel Henrique Barboza <danielhb413@gmail.com>
> +M: Nicholas Piggin <npiggin@gmail.com>
> +R: Daniel Henrique Barboza <danielhb413@gmail.com>
>   R: Cédric Le Goater <clg@kaod.org>
> -R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>   S: Odd Fixes
>   F: target/ppc/kvm.c
>   
> @@ -1430,10 +1427,10 @@ F: include/hw/rtc/m48t59.h
>   F: tests/avocado/ppc_prep_40p.py
>   
>   sPAPR (pseries)
> -M: Daniel Henrique Barboza <danielhb413@gmail.com>
> +M: Nicholas Piggin <npiggin@gmail.com>
> +R: Daniel Henrique Barboza <danielhb413@gmail.com>
>   R: Cédric Le Goater <clg@kaod.org>
>   R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
> @@ -1452,8 +1449,8 @@ F: tests/avocado/ppc_pseries.py
>   
>   PowerNV (Non-Virtualized)
>   M: Cédric Le Goater <clg@kaod.org>
> +M: Nicholas Piggin <npiggin@gmail.com>
>   R: Frédéric Barrat <fbarrat@linux.ibm.com>
> -R: Nicholas Piggin <npiggin@gmail.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: docs/system/ppc/powernv.rst
> @@ -1497,12 +1494,9 @@ F: include/hw/pci-host/mv64361.h
>   
>   Virtual Open Firmware (VOF)
>   M: Alexey Kardashevskiy <aik@ozlabs.ru>
> -R: Cédric Le Goater <clg@kaod.org>
> -R: Daniel Henrique Barboza <danielhb413@gmail.com>
>   R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>   L: qemu-ppc@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>   F: hw/ppc/spapr_vof*
>   F: hw/ppc/vof*
>   F: include/hw/ppc/vof*

