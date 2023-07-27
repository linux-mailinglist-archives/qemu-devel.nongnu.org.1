Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A6764341
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 03:11:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOpJp-0008BK-SB; Wed, 26 Jul 2023 20:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qOpJn-0008B8-I2
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 20:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qOpJl-0002wh-R6
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 20:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690419442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vWfnPMDUxIlNN4PGdW1vQ5tcGzKU2OT5c0+AG2OVYNE=;
 b=DXDP23tRvYEQ16HPTFNiPC233TQeR+RnxFw+GUlB0KxsjTOrkNHIk7dKxp0rZwmvJNwsro
 NPL6M0WNLyzCg718ItF0wvHhA6FkvEoAhrZiX3TNfn2oDDy+MGX0Zix4+OXJLKwTz2dIqR
 6hoStXpV71velOQKZjTNrVmjXHtxTpU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-SYmpVXHJM_CZZQylvd1JUw-1; Wed, 26 Jul 2023 20:57:19 -0400
X-MC-Unique: SYmpVXHJM_CZZQylvd1JUw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76752bc38bcso55139085a.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 17:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690419439; x=1691024239;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vWfnPMDUxIlNN4PGdW1vQ5tcGzKU2OT5c0+AG2OVYNE=;
 b=h4swoAW1su7phAjRIMkBuguFkMC4yJGTxIJRl4Kfrp6dMKLzgEBHsEYX8xWjr+zkbZ
 nNiTCRUpNlFgTglEjmbQLWTCGoee1ffd1GHIwOBv51wrf0dKeuPy+i3fGrKl1ZoLuuWH
 c9sj1bsG31WJj7oaJ0lqhMlG+WKzJ3AYxwdOQuKX73AlRUsfwPknCh9KYmuypgnXdfwe
 iFXmbsGnNDip2asEwirn22pT9K1wOcHikG3KI3TxPmPmNDTVzg5+xPSWTZVqCHIxdfCH
 7RikO4Y+PE2HCRWIFZihFeQ83YGEltA0NwFrHjuEQkPAQIqzBYX0a1gUchbi6ehX9o/U
 bA6Q==
X-Gm-Message-State: ABy/qLaKP0RorFmbiPqYCEPSqo1nKM9DZA3O6EgTDczwobvwhXMbEKfu
 ndUBSYEvalPh+SPl+lTvu/7amK1s2DZkNhRRur0Wq5rXoQj4pn6Z4cGq9VsIYSkNo4Il9z1UWj1
 0PN4UOnHfWo3YD7Y=
X-Received: by 2002:a05:620a:1923:b0:768:2f20:b336 with SMTP id
 bj35-20020a05620a192300b007682f20b336mr4323447qkb.58.1690419439435; 
 Wed, 26 Jul 2023 17:57:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGH+mGOmaR1NSDh1sDdWHEmoVajkAi6cw8Wa88iXcx9ERY43Y7kyUUfw3Jn9BCxO7o97x4qYA==
X-Received: by 2002:a05:620a:1923:b0:768:2f20:b336 with SMTP id
 bj35-20020a05620a192300b007682f20b336mr4323433qkb.58.1690419439163; 
 Wed, 26 Jul 2023 17:57:19 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a17090aca8d00b00262e5449dbcsm157521pjt.24.2023.07.26.17.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 17:57:18 -0700 (PDT)
Message-ID: <83d5c2b6-20a2-0637-8373-c1935d97dc68@redhat.com>
Date: Thu, 27 Jul 2023 10:57:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/8] Adds CPU hot-plug support to Loongarch
Content-Language: en-US
To: xianglai li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 Salil Mehta <salil.mehta@huawei.com>, zhukeqian1@huawei.com
References: <cover.1689837093.git.lixianglai@loongson.cn>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <cover.1689837093.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Xianglai,

On 7/20/23 17:15, xianglai li wrote:
> Hello everyone, We refer to the implementation of ARM CPU
> Hot-Plug to add GED-based CPU Hot-Plug support to Loongarch.
> 
> The first 4 patches are changes to the QEMU common code,
> including adding GED support for CPU Hot-Plug, updating
> the ACPI table creation process, and adding qdev_disconnect_gpio_out_named
> and cpu_address_space_destroy interfaces to release resources
> when CPU un-plug.
> 
> The last four patches are Loongarch architecture-related,
> and the modifications include the definition of the hook
> function related to the CPU Hot-(UN)Plug, the allocation
> and release of CPU resources when CPU Hot-(UN)Plug,
> the creation process of updating the ACPI table,
> and finally the custom switch for the CPU Hot-Plug.
> 

[...]

It seems the design for ARM64 hotplug has been greatly referred, but the authors
are missed to be copied if you were referring to the following repository. There
will be conflicts between those two patchsets as I can see and I'm not sure how
it can be resolved. In theory, one patchset needs to be rebased on another one
since they're sharing large amount of codes.

   https://github.com/salil-mehta/qemu.git
   (branch: virt-cpuhp-armv8/rfc-v1-port11052023.dev-1)

I took a quick scan on this series. Loongarch doesn't have ARM64's constraint due
to vGIC3 where all vCPUs's file descriptor needs to be in place. It means the possible
and not yet present vCPU needs to be visible to KVM. Without this constraint, the
implementation is simplified a lot.

Besides, we found the vCPU hotplug isn't working for TCG when Salil's series was
tested. I'm not sure if we have same issue with this series, or TCG isn't a concern
to us at all?

Thanks,
Gavin


