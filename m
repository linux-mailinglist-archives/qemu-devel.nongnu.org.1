Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2EF7B56D6
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnL5l-00084J-1Q; Mon, 02 Oct 2023 11:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnL5i-00083D-Bo; Mon, 02 Oct 2023 11:44:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnL5g-0004Gh-QZ; Mon, 02 Oct 2023 11:44:14 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso124806505ad.1; 
 Mon, 02 Oct 2023 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696261451; x=1696866251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JWbAN86U5W7W48L4fMqH0ihPA1WgRNpSBy4HQosaUdk=;
 b=caREshfIs1/SLn4zoWft1X8gZsDRn/4fTFGlNCNfYrk4Bs1vkhSHyVS59PBO2KqdGL
 29qHEHoVuF8N+xCAhEn/TW2RyoEucNg/xqH28d9lQfLYgzuTFVaQRPuOIotvhXNMFS8s
 JHIhh6EcC0IuPGVPr3swcx37US562cCJHppwUTiJQ9a/X6aJMovz9HZ89OvuKSVHM70a
 pODu7W2+cBnC8ukfRUnvFdcGZ7Ze38hJMVzzDWKBvEwvyrs1lAt2pFaOOOj9OhmXRth5
 Zeu0Vb2IRHU6xmmEtQlmVvUwF3NDPOTq4NFbkaFqOBczcyrYwXR5AXEmotcg5P3aKyKA
 GRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696261451; x=1696866251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JWbAN86U5W7W48L4fMqH0ihPA1WgRNpSBy4HQosaUdk=;
 b=VdYmDJNPYPh8TMMkdN4NBa8Qh/MoAxqkf9ohQne8wLSJgh9ZSpjDw6lTG/xJLP+nAK
 KG3qN/u0plQtc70u0wLljTEo+caaY7XOHrlOMC4ILVMIbegowr0A1RvnOZMrDabqquyh
 koouKIh2ISBZaPqL/fa8/OuwzZ70yAk7sUHylubPbp2ZVt6TgC+9KP76PhB50NwV9gHV
 KVvY0dT5vYWPAhhcNig+a0TWDC6jXcwyL0nsOMvEpivgEeyQY9DWaV7yQsXTqDYy9S1h
 O9PJfhC9Zbv2bSj9WPUaWuIOi8Jk7kmpubJVGeEGU4K6+yo21S5UABn8R2gFxmutDes8
 W81w==
X-Gm-Message-State: AOJu0YzIWYU05OHwbGc3hfJVhajSzlCbkD4jiYJFrT8/jdnhcXz+b0Nz
 t0Fm62WhclSoMuckhw5iIK2Xb2WJSUY=
X-Google-Smtp-Source: AGHT+IEvf52R58yeTSXV1DWsmJ9mOuRRCgMdXk1gFoK6F0naZznafHTM9dpKVgKVqbI6ClSR7b1iiA==
X-Received: by 2002:a17:902:f7c6:b0:1c6:1ab1:93eb with SMTP id
 h6-20020a170902f7c600b001c61ab193ebmr8749971plw.17.1696261450944; 
 Mon, 02 Oct 2023 08:44:10 -0700 (PDT)
Received: from [192.168.68.107] ([177.94.15.124])
 by smtp.gmail.com with ESMTPSA id
 jg6-20020a17090326c600b001c61df93afdsm15068697plb.59.2023.10.02.08.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 08:44:10 -0700 (PDT)
Message-ID: <5e6f6d29-64dc-7b67-0535-ac341dd317dc@gmail.com>
Date: Mon, 2 Oct 2023 12:44:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 7/8] MAINTAINERS: Add PPC common files to PowerPC TCG CPUs
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <20231002122326.365368-1-clg@kaod.org>
 <20231002122326.365368-8-clg@kaod.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231002122326.365368-8-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=danielhb413@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.321,
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



On 10/2/23 09:23, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   MAINTAINERS | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f72931ac2a4..2d00d14ef226 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -307,6 +307,11 @@ F: target/ppc/
>   F: hw/ppc/ppc.c
>   F: hw/ppc/ppc_booke.c
>   F: include/hw/ppc/ppc.h
> +F: hw/ppc/meson.build
> +F: hw/ppc/trace*
> +F: configs/devices/ppc*

Other archs seems to put the configs/devices/* file either on a "TCG CPUs"
entry or some other entry related to a machine type (e.g. MIPS). We don't
have an "Overall PPC Machines" entry like MIPS does, so adding it under
TCG CPUs works for me.


Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>



> +F: docs/system/ppc/embedded.rst
> +F: docs/system/target-ppc.rst
>   
>   RISC-V TCG CPUs
>   M: Palmer Dabbelt <palmer@dabbelt.com>

