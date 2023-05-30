Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B6715EE0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yKQ-0008HJ-AI; Tue, 30 May 2023 08:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yKG-0007l3-MM
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:19:44 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yKF-00073b-5W
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:19:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30ae95c4e75so2416242f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685449182; x=1688041182;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hte6Z3s2OOCCifRBIc/cUlFXu9Wprm67pz6esrvZtPE=;
 b=oTsudeT8nhTIX6m8A9/y7IjzoN8+KmMdBK5XAbGpBav0C66pJiKUZ7XEMELQWe5nI9
 09tVitaFQZoDlGdhMRlqf4jfAgRMIPqsuxu0ptM+x58NPTOezlD7DOyOR36xCYePSKLg
 TY9Aq5NWgJkQ8Q80vTe3E/zuDIBfmrwKURHJKBdhr/r51t2z7tphgdVBTcf7jInqAnhe
 y5UOEMfrX+80u/RNylyJ5KWRjXOAOHKfbBrFP9Dw0EjooCYUHICWt55YQ1vBYWgrHtDa
 oAbbCko3XIASLTH7IFo5HDSS4kkWtJDdAeVKfPamWxIkIdGCQuMGlaPYE2RO26SlcgVC
 8HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449182; x=1688041182;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hte6Z3s2OOCCifRBIc/cUlFXu9Wprm67pz6esrvZtPE=;
 b=IjU+j8hqdES6ANvzKVJST/ddrH0QG5RXyIfUK4h237hfTYPKGUeW+Tzpl78WiyXAwH
 5HEhixBhRb+7lxUSMnYquaFwzTRVtDW/TgUlRRFnQdskbgtayeQRuZubnUc5p2nag640
 Oy5qWbx15Su1Ir2vuPrBPZ/wN9a1AxzyjCSdebzLQW0weKI5iUKdJMioWA5vnyBgLYks
 AwOvHfeEMyBxdgPdNfG5oRl9sIaJNFf4hMJzGytfPtwX6yE7w+Cwek6Kl6l9ngbszznC
 ipKNXR+OF2mizn4B5d5GTkzQ7SNa0wAD1dP/c2pGDaSr/+MSffw8Nl3qylbrHBpaGbbd
 bcDg==
X-Gm-Message-State: AC+VfDyDZBs4sPS1hkmYkfUKz2FBT3I0qEXFzzvXNbL3l5xZSjPYl7a4
 Bvo7DbyibrFfenTMd4zZqauqOw==
X-Google-Smtp-Source: ACHHUZ5R8Qihy8gxJfL7NqGn6r8RooQQkQXeCL2uxvfBX/mm7LU2myNUpLJa2YCEVBBGSu6vq1F/GA==
X-Received: by 2002:adf:fe0f:0:b0:30a:eda0:71c5 with SMTP id
 n15-20020adffe0f000000b0030aeda071c5mr1425974wrr.16.1685449181788; 
 Tue, 30 May 2023 05:19:41 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a5d5344000000b00307acec258esm3180259wrv.3.2023.05.30.05.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:19:41 -0700 (PDT)
Message-ID: <f8b1a6b2-6b54-85d6-98ed-2015c6e4aaf2@linaro.org>
Date: Tue, 30 May 2023 14:19:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 03/10] hw/arm/virt: Use memory_devices_init()
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
 <20230530113838.257755-4-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530113838.257755-4-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
> Let's use our new helper. We'll add the subregion to system RAM now
> earlier. That shouldn't matter, because the system RAM memory region should
> already be alive at that point.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/arm/virt.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


