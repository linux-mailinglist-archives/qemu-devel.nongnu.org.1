Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABCD715FD8
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:34:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yWh-0008MC-As; Tue, 30 May 2023 08:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yWb-0008DR-Q8
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:32:29 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yWZ-0001ia-P9
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:32:29 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30af86a96b4so127455f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685449946; x=1688041946;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B0JaErNv7F/pL8tIgBF+HzZ9xHV4CCAiUM32UBVhOuQ=;
 b=pU85qRSWzstHvCmUip5ePbO8jgrOFXE2IH5bu940270ZQ5pNr0/LC5U26pIXq8pceV
 HboJOk3CqZVL/44n6NHZPyrRcSLv18EbiRpelRy/nqYNwUilU9jvGU9Os4ITPlbgTZxi
 jODQLGZR2/4SLFVaUIci5F4JKFjbOI33+gS64kkQZ6eP2GXWAvcF9XNoqVAhLCDLJtN2
 gUxnQvJHz8MSjJeZGbWNhE/e7DDbTlruFqFyId4GY3iNUccAZ7R8TtqYmJNEpvD1poQf
 1gy2ZqjKo7ZWJMEaPtvjcj+p2gaYQaFPjSXiwL3hsrthbQIUuSu9DjE4gU05/O3EAusp
 rPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449946; x=1688041946;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B0JaErNv7F/pL8tIgBF+HzZ9xHV4CCAiUM32UBVhOuQ=;
 b=DbBO27fhqf84ooMbHZk8GhjgfXozVm8kvI5eDljTVnw2YFCywWQnSds0Fql6MWhrog
 0ZUmXGVs3G9aq70E1G3m2Qk5FgGX9+HZEih4ouPASGyhjZhWRPn7OFJ+uWAKMhvD1jFt
 i0hddEXV2kqKjqahU6fyWbGfUXBZUoctltgDDwfcrSuy/l4oj/aMgZH2wG9GrGXYQxAg
 UjPE3wIivOha0fWTr7ACvRhyMPwq88hhpRKPbd/LpbVW+m1qpX4PtU34/qYyaGVY2bVT
 8KB2BGteJyc2aGZ/1tVwGYtPR++KdhGzE3Ht7/M1G653ozVNgfPrEJL7o4M+z7nE1+Yn
 GIPQ==
X-Gm-Message-State: AC+VfDxCxbFiVLGksRKWWu8F06mGB/IR/025mH/jeoyP2CUdLjhV5VH1
 8fY/pMYM7qCktIVjiD5p4SD+5w==
X-Google-Smtp-Source: ACHHUZ5jFowKRXJfX74zaoZdKScFGq4mDASfPvLQoLbRsvUCbr31DgyGSGdRlr5TL9pTjipY4PEpjg==
X-Received: by 2002:a5d:490d:0:b0:306:46c4:d313 with SMTP id
 x13-20020a5d490d000000b0030646c4d313mr1552351wrq.28.1685449946111; 
 Tue, 30 May 2023 05:32:26 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfe881000000b0030631a599a0sm3196174wrm.24.2023.05.30.05.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:32:25 -0700 (PDT)
Message-ID: <77141281-dc31-a38c-6e40-a5be986cf074@linaro.org>
Date: Tue, 30 May 2023 14:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 04/10] hw/ppc/spapr: Use memory_devices_init()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230530113838.257755-1-david@redhat.com>
 <20230530113838.257755-5-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530113838.257755-5-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 30/5/23 13:38, David Hildenbrand wrote:
> Let's use our new helper and stop always allocating ms->device_memory.
> There is no difference in common memory-device code anymore between
> ms->device_memory being NULL or the size being 0. So we only have to
> teach spapr code that ms->device_memory isn't always around.
> 
> We can now modify two maxram_size checks to rely on ms->device_memory
> for detecting whether we have memory devices.
> 
> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> Cc: "Cédric Le Goater" <clg@kaod.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/ppc/spapr.c       | 37 +++++++++++++++++++------------------
>   hw/ppc/spapr_hcall.c |  2 +-
>   2 files changed, 20 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


