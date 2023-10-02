Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CC17B56CF
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:41:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnL2H-0004lg-MF; Mon, 02 Oct 2023 11:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnL1p-0004P4-Cv; Mon, 02 Oct 2023 11:40:24 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnL1Y-0003Hd-2f; Mon, 02 Oct 2023 11:40:07 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5859a7d6556so2675186a12.0; 
 Mon, 02 Oct 2023 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696261194; x=1696865994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E0l2fVSW5mSeFFbhW0BC48QKNaLOYkj3zLBCiAU+Okg=;
 b=m7aCbaSRwWAUTDVgDVBk7me/7jNaXj5zOAuRc4hBR5R7Ee2TcML2jJdNYdU2NxNBqW
 Rx0Cc/YYxVUA3/zLEpJQd2l+g7pqRdqKVtgCTeAx4ceOPGzQ14R+ngEevdPD4ihLAl67
 Lu/gTSJ7NO+sCcJZD/0mZuWUmp40g+DNzoZX8+JnRu5Pl7n6uOFrcFzFUZx+QECE8urN
 UhKFoDYsL/lYiR/QnCDivZ0wWbORB/xcKhr4axKJ2ZBio5uC+dYbC95E9MoTUKX1E26q
 9Zeem+W3FeSZHyJC4CtnP1o+ubo6Lk4i3t4VdUTlokpRzHClt3XooP3kJsQrYRY6P3GP
 f+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696261194; x=1696865994;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E0l2fVSW5mSeFFbhW0BC48QKNaLOYkj3zLBCiAU+Okg=;
 b=LLSk0ECo076FEoPTMQZyWIqTTWwUUUDJ9T+ZvOHNBo1sgl+yElndfeeipO2FkXfkjo
 cCOVcBrRm+jr8yLzkkhXmUqkFSaivRzi7EB4H+3wO4So4HuL9cVNMrx154XzDNDVQC0x
 DbCrHqKKF2RXLPWv/jZplJb7SB194jTg0OWv6YaRDoM3VuUxNBsJmXePBr/ibZIx/tDY
 A/08MdYiiolbEZYW0sAv5AlhyBowYIyHSc+ve1+kVlPm79MKXRB40YlnRjIyfxlGaVi8
 VQe/gokRb+5FY4zQ0IjWeFJJjqSmbbMdk/QWDck+kWECjcOCFa46Pe0KnoCw0Ac3UY8i
 Ag8A==
X-Gm-Message-State: AOJu0YxhVccktlZM+MuoCQKZB9yh0JmygEUzQcH0Dojr9eE+hRi7pQSI
 wO+6vzOzR5FRwu9/sSs5afDIk2n6bz4=
X-Google-Smtp-Source: AGHT+IFaUJI6BTVfd/g3LlihGfwVnz7FLsbtrcEm5MDhxIPLcGHK/u5OWVKndJbGHgrx94rYShTJSg==
X-Received: by 2002:a05:6a20:1045:b0:13c:ca8b:7e29 with SMTP id
 gt5-20020a056a20104500b0013cca8b7e29mr11695550pzc.12.1696261194250; 
 Mon, 02 Oct 2023 08:39:54 -0700 (PDT)
Received: from [192.168.68.107] ([177.94.15.124])
 by smtp.gmail.com with ESMTPSA id
 x28-20020a63b21c000000b00564b313d526sm19596134pge.54.2023.10.02.08.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 08:39:53 -0700 (PDT)
Message-ID: <edf14a6a-ccd1-e081-53dc-1aad8ec792be@gmail.com>
Date: Mon, 2 Oct 2023 12:39:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/8] MAINTAINERS: Adjust file list for PPC pseries machine
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <20231002122326.365368-1-clg@kaod.org>
 <20231002122326.365368-6-clg@kaod.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231002122326.365368-6-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=danielhb413@gmail.com; helo=mail-pg1-x530.google.com
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
> The fdt.{c.h} files provide a helper routine used by the pseries and
> pnv machines. Attached it to the list of the larger one: pseries.
> 
> Protected Execution Facility (PEF) is the confidential guest support
> for PPC pseries machines.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   MAINTAINERS | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23ce59995d59..b3ba402f7943 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1440,6 +1440,10 @@ F: hw/*/spapr*
>   F: include/hw/*/spapr*
>   F: hw/*/xics*
>   F: include/hw/*/xics*
> +F: include/hw/ppc/fdt.h
> +F: hw/ppc/fdt.c
> +F: include/hw/ppc/pef.h
> +F: hw/ppc/pef.c
>   F: pc-bios/slof.bin
>   F: docs/system/ppc/pseries.rst
>   F: docs/specs/ppc-spapr-*

