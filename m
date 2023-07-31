Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63338768F24
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:45:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNZz-0007lj-KX; Mon, 31 Jul 2023 03:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQNZx-0007hB-Ji
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQNZv-0002ui-T7
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690789471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ElsIsOtJ5Znlz+lpzCgNdYqKc3kJAkdtbQfydrsYeA=;
 b=BVpec5cIvGtHdNMzJt0EUM6hlUrrVtNgyT7tj3XZknnKw4QI/4lIBKyitSlLlLU5eVLJNw
 jG0B769l6Rn4vN8cdgY+/YrM8h1q0GXAtBC9kKWJ4BbfRyC9nSECceTe0ZzMKOcfl9h51q
 hhCBI0MphXZ2iKXEnrxHScwTXkLL44Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-i9c5LDSQNuKbE32PsHIFdA-1; Mon, 31 Jul 2023 03:44:26 -0400
X-MC-Unique: i9c5LDSQNuKbE32PsHIFdA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f9e616e25dso56309221cf.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 00:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690789466; x=1691394266;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ElsIsOtJ5Znlz+lpzCgNdYqKc3kJAkdtbQfydrsYeA=;
 b=GLyoDEbCRijzCfUaAEGBy83zPzyD9gnEifhdIyuUnPTieuBXlY4Xuno9wIQNxTVgiC
 QG4of8ghoXgBWZyi53m3ujmN3bisuADeGPiAFVwyz3XkFT4smoUXHh+dlVYWQEtdsVI8
 4X0INtwwK3mx9s7we9o5TSaXUEJNup+H32kX/76tKCQ5EW311EUVee48xC0+Hdfg6FPO
 UXr/rt5XiSjjjw4l8pt19xnptAh/mNyAsqxFdnZ0gVVZR66Yg8GZUMwNxppWE8R9z0zb
 ROetfIUNbphcb/qFhSM0KwDhXeMPvL7MurKZKJWfUhwVqAdzUkKjR7vLtl6ZHY4e3Zlt
 lPHg==
X-Gm-Message-State: ABy/qLaSPPm1aZ4vdV9PBvUGS1Xh/d9ZLW2KSXwK9u15+Bnyv1xiGSJk
 nw0bSsiKpASdbSIwIoKbYhLG/uNnUyzBolOtWaM7gkcZ6Niw/5cd8jWXGelW+2+ScJfLBaGTfEl
 1y9HtqcOifwvEDXs=
X-Received: by 2002:a05:622a:19a9:b0:40c:8f5d:1b3 with SMTP id
 u41-20020a05622a19a900b0040c8f5d01b3mr8006739qtc.41.1690789466533; 
 Mon, 31 Jul 2023 00:44:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFinyUVuX2TcrsQG5rPoKEVADagHXEMcgjiea79L3HoHQlMjRlnstI5viPytYk2ZwT3Ae1wYg==
X-Received: by 2002:a05:622a:19a9:b0:40c:8f5d:1b3 with SMTP id
 u41-20020a05622a19a900b0040c8f5d01b3mr8006721qtc.41.1690789466338; 
 Mon, 31 Jul 2023 00:44:26 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 a17-20020ac86111000000b0040b8ba13701sm1757950qtm.52.2023.07.31.00.44.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 00:44:25 -0700 (PDT)
Message-ID: <54738824-42c9-a8f5-f174-bbb1dafa844f@redhat.com>
Date: Mon, 31 Jul 2023 09:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] tests/migration: Add -fno-stack-protector
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20230731065904.5869-1-akihiko.odaki@daynix.com>
 <20230731065904.5869-3-akihiko.odaki@daynix.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230731065904.5869-3-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31/07/2023 08.58, Akihiko Odaki wrote:
> A build of GCC 13.2 will have stack protector enabled by default if it
> was configured with --enable-default-ssp option. For such a compiler,
> it is necessary to explicitly disable stack protector when linking
> without standard libraries.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   tests/migration/s390x/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/migration/s390x/Makefile b/tests/migration/s390x/Makefile
> index 6393c3e5b9..6671de2efc 100644
> --- a/tests/migration/s390x/Makefile
> +++ b/tests/migration/s390x/Makefile
> @@ -6,8 +6,8 @@ all: a-b-bios.h
>   fwdir=../../../pc-bios/s390-ccw
>   
>   CFLAGS+=-ffreestanding -fno-delete-null-pointer-checks -fPIE -Os \
> -	-msoft-float -march=z900 -fno-asynchronous-unwind-tables -Wl,-pie \
> -	-Wl,--build-id=none -nostdlib
> +	-msoft-float -march=z900 -fno-asynchronous-unwind-tables \
> +	-fno-stack-protector -Wl,-pie -Wl,--build-id=none -nostdlib
>   
>   a-b-bios.h: s390x.elf
>   	echo "$$__note" > header.tmp

Reviewed-by: Thomas Huth <thuth@redhat.com>


