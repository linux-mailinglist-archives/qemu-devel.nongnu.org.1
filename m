Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6FB71626D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zde-0002xl-Ch; Tue, 30 May 2023 09:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3zdV-0002uU-Mh
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:43:42 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3zdT-0007Ma-36
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:43:40 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-30b023b0068so18917f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685454217; x=1688046217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=89/dBmknNHq10BYbuq2gcqpitFtVoA/p4F7hYUZjx2M=;
 b=IJoc7UArCn7YjfgxS4TXWXLJRgBcih6poEypwSvmQ/X8RLD9dP2YxtuQ4sv7y+Q/7x
 9gckFAk6fajitJINITuhEtqgDGh8XwXoF4tWt9+AvusY9QzcDIB6VbgoOWVC8eeD/xKo
 nfyRJ/w08Jt32jJq4KwPth09cwSYPBujovP6vfJmpiH+nlJXdaOR+8GPnG6l9RazkevX
 D8s0zA+wcYbmVSnxyIM1yYRA23ueH94b07SPn19YZcDfqupsVpjiGQdEcs7lR2qE77PF
 naXaennOHVE5UZUffyGS0xDOzxOyjJxeUIDBfFKI8F+OpJcM7fMRM5Krft592iKvE8a1
 FFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685454217; x=1688046217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=89/dBmknNHq10BYbuq2gcqpitFtVoA/p4F7hYUZjx2M=;
 b=HWAT6DCRAY0BafIzgSTGNGtW4zKPT8HxdHGQpjoOEfRvauL2+nFrSZj17BTN1ESaoF
 wrs3Yx5CfrcFS5XCJR6Al0DrRuaT9LMIAH5FwtHZce3g3K/rOQJBhjdd2rEPgUcmSTyq
 stT/af+TjFYHuLfwf2msnvKKO0fGKsqhMYnV0C7ygNQ/TYC6zl46RKQzCrLsc7oLvqKA
 HsQq4Eab54uLcgodoDfpFGfy1cxQuQG7tzkvvJE0DwkjhK7JQVWl4XS2lFMf3JAIR6Fn
 O7OAWXKWQ7sj/yXx1FzO3d2xGO+nXkwZeCGISOekTfiUCQuYtQL7h0C+vGw0KPLCeuO+
 1qSw==
X-Gm-Message-State: AC+VfDx/2xUaHDa1hk3aWcTLcXW2cSWEBaL+WBHeD4WgYH+ROg0QXqV0
 Rv0e0BoR6dXGCqhoqVqcyjdddlI2R5ZFvseoqgMsCA==
X-Google-Smtp-Source: ACHHUZ7r0Dc0ovYrIMSryI1XVodsbOzKPVcE5CobwDBIl/N4F4Wj87RzTdf7tnLRmc8idD5DW5TFbQ==
X-Received: by 2002:adf:fec1:0:b0:30a:e5a6:1840 with SMTP id
 q1-20020adffec1000000b0030ae5a61840mr1785339wrs.17.1685454217346; 
 Tue, 30 May 2023 06:43:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a05600011c100b00306c5900c10sm3383721wrx.9.2023.05.30.06.43.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 06:43:36 -0700 (PDT)
Message-ID: <150fa53f-18b2-6f39-c500-aa5c859dc82c@linaro.org>
Date: Tue, 30 May 2023 15:43:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 08/10] hw/i386/pc: Remove PC_MACHINE_DEVMEM_REGION_SIZE
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230530113838.257755-1-david@redhat.com>
 <20230530113838.257755-9-david@redhat.com>
 <20230530090655-mutt-send-email-mst@kernel.org>
 <9d395d6f-4da9-45c6-bf20-ed33f1c4bca5@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <9d395d6f-4da9-45c6-bf20-ed33f1c4bca5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 30/5/23 15:11, David Hildenbrand wrote:
> On 30.05.23 15:07, Michael S. Tsirkin wrote:
>> On Tue, May 30, 2023 at 01:38:36PM +0200, David Hildenbrand wrote:
>>> There are no remaining users in the tree, so let's remove it.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Richard Henderson <richard.henderson@linaro.org>
>>> Cc: Eduardo Habkost <eduardo@habkost.net>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>>
>> This (with previous patches) means any user changing
>> device-memory-region-size machine property is now broken, right?
> 
> We only had a getter, no setter (for good reason).
> 
>> How do we know there are no users?
> 
> We don't. A quick google search makes "device-memory-region-size" and 
> "qom-get" only pop up in BUG fixes for something that appears to be QEMU 
> developer driven.

This was my analysis.
> I don't consider it any useful, but if we want to be careful, sure we 
> can leave it around.

If we want to keep it, we should move it to generic code IMHO,
not PC machine. Otherwise the less unused code the better :)

