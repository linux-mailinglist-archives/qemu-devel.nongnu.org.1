Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAABF869612
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Feb 2024 15:07:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rey67-00041a-G7; Tue, 27 Feb 2024 09:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rey65-00040q-Ug
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:06:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rey63-0002F5-B8
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709042772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V33Mk0sfOJYeiKgma44q2Moyss5uABVS1hIVsG92JbA=;
 b=EjDbHnmEylK1CGiOQqzHiGJSPWb5ns/biYDD13AwXKOQYCe2UgTpd9U+V19y7obZuQsp64
 B+1DKV6/6tPXibop6ynSE2QgjjkdQv9w9Ziyg9Z6xqdrzqbOqBLyNsDNcYvfRhjLs3jvI3
 VmvLacVa+BiTqAbY31zxCp0PWx+MUlU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-UNa1xEo4M0uVf7POQkBCmQ-1; Tue, 27 Feb 2024 09:06:11 -0500
X-MC-Unique: UNa1xEo4M0uVf7POQkBCmQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7830ab8fb5aso568561585a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709042771; x=1709647571;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V33Mk0sfOJYeiKgma44q2Moyss5uABVS1hIVsG92JbA=;
 b=jOyHv1ElySnx2dtoZy+Bw0oGDafsnDgmiBabNIS8TotXZIBEFcIBd74cPSfnVS7iqN
 G5bDCqeSLK0tR55riYl+mM/15zTlgdbzuHU0N3f7BNhYQ63EwZc0vZpdw8TXIUkTeVms
 5K0wKwOUILkbfs/Dynz6G7ZbAn/+m9KFm7n5QAUZKX5TzGdSMWZLlIEUc1AR0lqnZGDC
 5viZx827Y4wXgy8QZF68fRDke0j/muvJCIukcuGcVvqbq6nOXYbRoVh5urJFgD3J6dz8
 nzMOSmGZ9Kt6tDQWwSkupl67wET0khf6RFN3OYvArOSedSXmPLTkJuzaYRnWpEIgzBh8
 sJjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX33/pPKMDP5orhQK3P93mTjqBiQM63Q7QP5mxgLzmO0WTNGMRQZwjQelZ+lS7Uys/FavdXZ43dI/q98zMrIigsDs/JlTg=
X-Gm-Message-State: AOJu0Yw5dWvOImGk3ACgAjNjZKFycnWpcWSvM/82ZWW+/WOyqqRMpuet
 VVC7TaWVvT/9BsOqlLCgZ14WP3GFdGd3cK7cLRoMo6fpxUpsgu7ja7UN775Qay/uipHQEcn0vKa
 JySvxwyxP528fEuhH/RKcmOQIE3cJ00ssX9GI/WIcX/Cep41wun/V
X-Received: by 2002:a0c:9781:0:b0:68f:f701:e357 with SMTP id
 l1-20020a0c9781000000b0068ff701e357mr1958826qvd.12.1709042770932; 
 Tue, 27 Feb 2024 06:06:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErKzOVBrJZBVYfMzcCxe0dUXWLXcDhpnSJvVtPkZ7AtsdpH6NAWC/aZN5S39lOfW51VUwkjA==
X-Received: by 2002:a0c:9781:0:b0:68f:f701:e357 with SMTP id
 l1-20020a0c9781000000b0068ff701e357mr1958797qvd.12.1709042770631; 
 Tue, 27 Feb 2024 06:06:10 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 ol8-20020a0562143d0800b0068fb9bdd7absm4216921qvb.74.2024.02.27.06.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 06:06:10 -0800 (PST)
Message-ID: <10ba2151-fd32-4aec-8bba-75c5c59c5b02@redhat.com>
Date: Tue, 27 Feb 2024 15:06:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide/ahci: Rename ahci_internal.h to ahci-internal.h
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, philmd@linaro.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20240227131310.C24EB4E6005@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240227131310.C24EB4E6005@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 27/02/2024 14.13, BALATON Zoltan wrote:
> Other headers now use dash instead of underscore. Rename
> ahci_internal.h accordingly for consistency.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ide/{ahci_internal.h => ahci-internal.h} | 0
>   hw/ide/ahci.c                               | 2 +-
>   hw/ide/ich.c                                | 2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename hw/ide/{ahci_internal.h => ahci-internal.h} (100%)
> 
> diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci-internal.h
> similarity index 100%
> rename from hw/ide/ahci_internal.h
> rename to hw/ide/ahci-internal.h
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index b8123bc73d..bfefad2965 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -37,7 +37,7 @@
>   #include "hw/ide/pci.h"
>   #include "hw/ide/ahci-pci.h"
>   #include "hw/ide/ahci-sysbus.h"
> -#include "ahci_internal.h"
> +#include "ahci-internal.h"
>   #include "ide-internal.h"
>   
>   #include "trace.h"
> diff --git a/hw/ide/ich.c b/hw/ide/ich.c
> index 3ea793d790..9b909c87f3 100644
> --- a/hw/ide/ich.c
> +++ b/hw/ide/ich.c
> @@ -70,7 +70,7 @@
>   #include "sysemu/dma.h"
>   #include "hw/ide/pci.h"
>   #include "hw/ide/ahci-pci.h"
> -#include "ahci_internal.h"
> +#include "ahci-internal.h"
>   
>   #define ICH9_MSI_CAP_OFFSET     0x80
>   #define ICH9_SATA_CAP_OFFSET    0xA8

Reviewed-by: Thomas Huth <thuth@redhat.com>


