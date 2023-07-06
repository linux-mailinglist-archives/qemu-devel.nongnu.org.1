Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8038274961E
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 09:14:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHJAs-00072l-5L; Thu, 06 Jul 2023 03:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHJAq-00072T-1E; Thu, 06 Jul 2023 03:13:08 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHJAo-0004Pk-AX; Thu, 06 Jul 2023 03:13:07 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1b0156a1c49so471251fac.0; 
 Thu, 06 Jul 2023 00:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688627584; x=1691219584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ymIDizSuFOJNIHmrXqVETSI70Qu+NqG8dEwx/piyRb0=;
 b=kD0/SR1PnVWPix0/Bffmq3kCter//FS9hAF8QRq7EOWptZF3C5enHNf3bZCghdhYqB
 IlwO0ZRpfa+YBqOQH0+3h4t4A+YvVrL1++zrUBAEnCv5F6n5HaoZ7mkxIOI5pDMsbI7t
 k3iNlRJ21410bePRCjGR42NPXG+HbS6T7Xhr4/cZo6zhHgwqds3MC5aLG/T0W+672vEy
 wLM4zQ81uAyKvFxotxcL/AANvCgvjcA/tlJTHMFC4Xb7SVdTMPOncqSZz9IyRd8LaDz0
 fEZwqS1c2oNCyVrwv6THuZZ0HTJTRkWwKgLgiRJWHWh5hX04vYphQMoJiimfQmhj/UGE
 c0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688627584; x=1691219584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ymIDizSuFOJNIHmrXqVETSI70Qu+NqG8dEwx/piyRb0=;
 b=JuoqcKOaFQKQof2e0+GykrF3YUstMmaOOQBwlV0pK5t9Va9bGpG+JtR0ffOFQyR9qo
 l+FG/x9c8UbhnEvVsd/3rIB90EhzE0Ak86VnkHkIXOvvyWwbWAx64mTKymFLpI+HbTNH
 hgatIXAAwyTnqVhm7rL9nsHSfM1sWPu3MxAAMLY/zR7vUXQILBaMAOlvlH4t8hQtnzIc
 wmpghCr6v+R6VqpS1zAR9INo1L9G/bv6jYVHtHEUVkKkOq7hstDAVzsiYfVX/37XQIRc
 IoQqmUPfCHn/9vr/uo0pRryj/CoMji0Lpkn0z79yJTV+h7MB2PVBwmr7ihxSoFHUNnCz
 CcMQ==
X-Gm-Message-State: ABy/qLasFD1IUlE5tu5BM8FhIHmrqL5GwYo5D5BtZPQNJZwN+BH10MOZ
 YnT9iwxTewZqvBorv+hC0CM=
X-Google-Smtp-Source: APBJJlEvyt7hST9qNv8EsZHhUeiKsanUGKrwN207SoBTxUcx7yRW2uadb+bGJt8iwrYIVnY0yVkp0w==
X-Received: by 2002:a05:6871:60f:b0:1b0:3b98:50e4 with SMTP id
 w15-20020a056871060f00b001b03b9850e4mr1325851oan.58.1688627584368; 
 Thu, 06 Jul 2023 00:13:04 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 j17-20020a056870d45100b001b015338d52sm499913oag.3.2023.07.06.00.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 00:13:04 -0700 (PDT)
Message-ID: <c00e7c46-6928-ed4d-f2c6-2754a590802f@gmail.com>
Date: Thu, 6 Jul 2023 04:13:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 00/14] PPC440 devices misc clean up
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <cover.1688586835.git.balaton@eik.bme.hu>
 <d192a786-6019-f1d3-6491-c245527da417@gmail.com>
 <ec526143-9f3f-3d8d-9977-2ee76a31ef23@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <ec526143-9f3f-3d8d-9977-2ee76a31ef23@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.089,
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



On 7/5/23 22:09, BALATON Zoltan wrote:
> On Wed, 5 Jul 2023, Daniel Henrique Barboza wrote:
>> Zoltan,
>>
>> Patches 1-9 are queued. Don't need to re-send those.
> 
> Thanks, the last two patches are also reviewed and they don't depend on the ones before so you could queue those too.

Just queued patch 13.

Patch 14 doesn't apply in ppc-next even after applying patch 13:

$ git am -s -m \[PATCH\ v2\ 14_14\]\ ppc440_pcix\:\ Stop\ using\ system\ io\ region\ for\ PCI\ bus\ -\ BALATON\ Zoltan\ \<balaton@eik.bme.hu\>\ -\ 2023-07-05\ 1712.eml
Applying: ppc440_pcix: Stop using system io region for PCI bus
error: patch failed: hw/ppc/ppc440_pcix.c:490
error: hw/ppc/ppc440_pcix.c: patch does not apply
error: patch failed: hw/ppc/sam460ex.c:441
error: hw/ppc/sam460ex.c: patch does not apply
Patch failed at 0001 ppc440_pcix: Stop using system io region for PCI bus
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

I suspect we need  some of the previous (10, 11, 12) to apply it cleanly.



Thanks,

Daniel

> 
> The only outstanding patches are those 3 that rename the type defines to match their string values. We could come up with better names but those suggested by Philippe are too long IMO so at least the patches in this series clean up the current mess and we could rename these later. I'd rather not change the string values too much as those are what QOM actually uses to ideintify the types but we're free to change the defines. Currently we have:
> #define TYPE_PPC4xx_PCI_HOST_BRIDGE "ppc4xx-pcihost"
> and then a "ppc4xx-host-bridge" type without a define which is another type which is quite confusing. I may have partly created this mess back when I first tried to add sam460ex and did not know much about this but at least I'd like to improve it a little and resolve some of it now.
> 
> Regards,
> BALATON Zoltan

