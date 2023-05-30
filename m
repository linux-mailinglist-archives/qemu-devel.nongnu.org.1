Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDDB715F0D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:23:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yN6-0003FT-Ut; Tue, 30 May 2023 08:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yMx-0002pI-7F
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:22:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yMv-0007lf-07
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:22:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-30ad8f33f1aso2781617f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685449347; x=1688041347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D1LKyft2/91dJcophWImOTWMocrtI2x+nbhDwIJH+7I=;
 b=fbSWlfabF4A6S0jbrrLQPr0y7m2vrj6+aceNV4pEY20cEyMckwoy+wzPj1VzWT1zGe
 j424UWV5TUAXaA3Z225KTOrji1e5AB2fY27kN+CbmkVLDb++Yc2dkLNN9CcBM9c16oKm
 oPyTR1kHZxZck7RPBZdgtA9rrA6ebMpwe2ubiJYLS0fkFkY+977els3Eg2qyBwUuBnmq
 xB+Lov3ooil0Iteb7ESBTK61vMHTqL+rnMrcKCiaO8asfOOi3S464IDfvlhDqkzSkY2p
 LmPNGO6i3WjMRemaKqO7aaX7ygHaiUWjoOE6Wpo3Hyi9o083E8K7l4yOrfMa+lQrivAt
 seXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449347; x=1688041347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D1LKyft2/91dJcophWImOTWMocrtI2x+nbhDwIJH+7I=;
 b=IorEVth7cyZbpZYbmfkpwZ9e3dVZHpsEL+jIvmK7F9pu/hgCaKPkFdrNflgUXtugaL
 MuP/4qlcA66NVNqQ5DpVW7issZf1HKHQcMYixsKkvaHqJK49U4Fx64UF1jpl5zRqlWge
 NINtvztL6StCmLqwU9YlLQ6cHTUrfeIt+naI2fcQbfWwAybwko7zhLRvW3Smi/VLvhvT
 fy9wmubaaNaP6DgplWahykSJETwI8sR6FhaxX0l8i2gyNtT6vuLiM6IKYQTY0jsYLDJr
 outky0GxxsHbSRQh6rq4q/GWSkm7hZJYda0Yo2qxfzjBpmQJuas+dbEKVosHN4IhayvD
 UydA==
X-Gm-Message-State: AC+VfDzW1V6nKO++glcIisd+E8CK2Tw/amH8xKubLzYMQf4uxo0m63wh
 RJQk4Ruv6LpaV1ABlgzxU1XQZA==
X-Google-Smtp-Source: ACHHUZ5IbIQ7WGEzaf3AN46YJxOFFboq2K2CH66zCbVrEnkoDb29EsNle8ySmmaN0fQ8cFBsDNVxFg==
X-Received: by 2002:adf:f404:0:b0:30a:d8df:6800 with SMTP id
 g4-20020adff404000000b0030ad8df6800mr1413209wro.33.1685449347478; 
 Tue, 30 May 2023 05:22:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a5d544c000000b002fed865c55esm3086126wrv.56.2023.05.30.05.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:22:27 -0700 (PDT)
Message-ID: <c9406bef-2a9b-1c21-c11d-bcf8a85bec96@linaro.org>
Date: Tue, 30 May 2023 14:22:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 08/10] hw/i386/pc: Remove PC_MACHINE_DEVMEM_REGION_SIZE
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
 <20230530113838.257755-9-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530113838.257755-9-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> There are no remaining users in the tree, so let's remove it.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/i386/pc.c         | 19 -------------------
>   include/hw/i386/pc.h |  1 -
>   2 files changed, 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


