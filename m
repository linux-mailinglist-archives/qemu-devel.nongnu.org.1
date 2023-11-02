Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F414C7DED6D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:36:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySCs-0001Ud-1H; Thu, 02 Nov 2023 03:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qySCq-0001QD-JR
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:33:32 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qySCo-00045F-QN
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:33:32 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32deb2809daso332970f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 00:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698910409; x=1699515209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/uDke+oq6OCoYx5vhNBp0OwhJG2JkwI/LIcfzuHkPUE=;
 b=zjinLZ0lnlf1t5ILfuQ26/FxtoPadKfhC/7U+fcjnzTbgoTmc+nPapgIuMVuGrnTMa
 ws2VntkLSAg//l/qKjNY4y084MWigEmIsNt3YNG0v9Jt2YJOf+7eMIoIw0/fGeJYif8z
 Jpllac7IiiKLgqWbEJLyICjxQSthd/+y0Ij4WN7ukpDzF6xqtIe+Xcc6/XqJmgreYGZN
 n+n6sKtb6FBpiCfnBm0I62IlRlLjbe5hsnjbMcxpv87DmCbtu9+GGPn9Dm795h39ujJX
 4PM70lsMG04xw2tzM4SGdhtfWfKZb8pBH9LUD5bxMPdHym4RWQyZE7QtCujZtM4Z9ZVU
 djWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698910409; x=1699515209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/uDke+oq6OCoYx5vhNBp0OwhJG2JkwI/LIcfzuHkPUE=;
 b=pn69A4V2FoeHhBfCvq4CHTEbnAH3leANIxUUj8Eogywvq2emH//oFZqyBaZ6P4Y3s9
 k2oSpCoKUj/BaGUMOd2OS2cP8nK2iGNvxrxAGzxLYUUSU0At+VsbmDCI/kS9KysuPkab
 qgYn08JJknGOOmKpfoQGpNCXRHFZLhx09p5W93JVydxPislHc81H5yZomg5zLklDMwK+
 0hJ1bMZ/gebGr73D8ZyizQqEKi08I27JfWa8p3fThmeXXRUdStjb0B9pftYVyShs0lKg
 7qoQqzlLBOMcydBvuQk6xt69WguG1PTDOJ+SRplO+6zo0PDf8BJYE/8vmVPI8LbuVrzL
 CO2g==
X-Gm-Message-State: AOJu0YwmermSbDHlGQLouZDVMBUeKjAdMj0IXOj1KF6KhRSlhFUi46bG
 QIaIslAyjw75ODGkhHNotBzPew==
X-Google-Smtp-Source: AGHT+IF7yITtaMilcVJD0Fc8tokf7fvRZxBw30tbEEFF8Cn6L7PAqXFLuHB4ezbgAdDs2og4H7TDCw==
X-Received: by 2002:a05:6000:3c3:b0:31a:d9bc:47a2 with SMTP id
 b3-20020a05600003c300b0031ad9bc47a2mr16075484wrg.53.1698910409227; 
 Thu, 02 Nov 2023 00:33:29 -0700 (PDT)
Received: from [192.168.69.115] (176-131-219-113.abo.bbox.fr.
 [176.131.219.113]) by smtp.gmail.com with ESMTPSA id
 w8-20020a5d6808000000b0032f7fab0711sm1611927wru.93.2023.11.02.00.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 00:33:28 -0700 (PDT)
Message-ID: <dd6e0ea8-f8c9-350c-037d-612b0c319ef0@linaro.org>
Date: Thu, 2 Nov 2023 08:33:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 5/5] hw/ppc/e500: Pass array of CPUs as array of
 canonical QOM paths
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20231030143957.82988-1-philmd@linaro.org>
 <20231030143957.82988-6-philmd@linaro.org>
 <711ebdc8-7088-4e27-8d84-d29a7884f2dd@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <711ebdc8-7088-4e27-8d84-d29a7884f2dd@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.777,
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

On 31/10/23 22:16, Daniel Henrique Barboza wrote:
> On 10/30/23 11:39, Philippe Mathieu-Daudé wrote:
>> Devices should avoid calling qemu_get_cpu() because this call
>> doesn't work as expected with heterogeneous machines. Such
>> devices often iterate over a cluster of CPUs, which the device's
>> parent has direct access (when creating the child device).
>>
>> We can pass QOM as 'link' between objects, but we can't pass an
>> array of links. Here we exploits QAPI simplicity, by using
>> DEFINE_PROP_ARRAY and a list of strings, each string being the
>> CPU canonical path in QOM tree (which is constant and unique).
>> When the device realizes itself, the original CPU pointer is
>> recovered via a object_resolve_path() call.
>>
>> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
>> Inspired-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Tested with:
>> $ make check-qtest-ppc{,64}
>> $ make check-avocado AVOCADO_TAGS='machine:ppce500 machine:mpc8544ds'
>>
>> RFC: See cover
>>
>> FIXME: Should we free spin_cpu_list using g_autoptr(QList)?
> 
> By looking at how object_property_set_qobject() works I *think* we can 
> free it.
> Perhaps try using g_autofree and see if something explodes, hehe

In another thread, Peter noticed we then call qdev_prop_set_array(),
which takes the ownership, so no need to use g_autoptr in this
particular case (else we trigger a double-free):
https://lore.kernel.org/qemu-devel/CAFEAcA_GC8ypM2Y94KCU9Q_dntF6Na+igu-+0JZJ+MvPFE_HcA@mail.gmail.com/


> Thanks,
> 
> Daniel
> 
>> ---
>>   hw/ppc/e500.c         |  6 ++++++
>>   hw/ppc/ppce500_spin.c | 48 ++++++++++++++++++++++++++++++++++++-------
>>   2 files changed, 47 insertions(+), 7 deletions(-)



