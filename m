Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E147DE6F6
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:54:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyID9-0003aG-QJ; Wed, 01 Nov 2023 16:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qyID7-0003Zx-Vq; Wed, 01 Nov 2023 16:53:10 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qyID6-0003Xb-He; Wed, 01 Nov 2023 16:53:09 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d9c687f83a2so200151276.3; 
 Wed, 01 Nov 2023 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698871987; x=1699476787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lp4G5MalqlvRxgYbT2GCYb9yyNmNDVoemJC9az5gGH0=;
 b=ZewLYpPN48ZEEk33Bu/jU3ygYMfQGjsLJn6vL2DchiXCc2Lt8rJyTGNikRuNi9nvWj
 01Ow9HdpcN8jUcWlaZRhQ4GBXHXEhCz5ROLPU/4dtdafdAW/LTbntk3UwLRCZm2Dav3p
 KuGNUvs+WYJ1CylPvwWdoFxBdWRpr+MIAyt29lmOyW/DgN4IygpbPQKx56UyHzdPTrWb
 joxITle7FwuEFvdXQ91TA6aubFszbuudugelJm6F+5ZpK+GCzqeLVtsexwZwa4Y6qQYT
 MHbfdZMeB5QCUjNrRX+TFKnDpzYZRNfyUBuqR0uHagpNkwZ58rjixuElq/VU0gk3aSMn
 fuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698871987; x=1699476787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lp4G5MalqlvRxgYbT2GCYb9yyNmNDVoemJC9az5gGH0=;
 b=qiscYtEpsvvpGGSpdkyfL97OSwY82bIsFQSRcJoY7c/3lIa6RsEpc0+CtDOCPuvUpY
 LUvXdMciQUD46e2rSHGRQTaRe7RBTRKfBRP1dK6a1XDnX+0J9zJ7Npo4LsElHIs9x/XU
 NuZmclDs2n/Agz69QhOXOVrwDV9OBIiBjV1Oh1wi/vu+zX3eDztic47Yrkpd9E9mrL0q
 nbNkj6SrW6m6j575JXSE1TZ6M2l9aLnnUsxwkZFsts7KTITsin3V4ak53DktBXsbGbj8
 zsMu61zIITZZcb/2nxqMmIypWUYlHvggOAfG7IT9fjVsBM75+gs0EO4wp37PhE0fQ8mm
 +dEg==
X-Gm-Message-State: AOJu0YxA49SZsCfSKS1L9KbYwVv2Zh0vdbcWSGfkNENUxi2YM4vLKvBr
 7vd7lmDAKi9vD1BAMTEkmVI=
X-Google-Smtp-Source: AGHT+IE/xNumPWDiWst/iDIoOe+VqgmtiGn4NBuqACRiTQ7eoWLIVtViUGLuw+8m/X3fSyWGfnG+Tg==
X-Received: by 2002:a25:548:0:b0:da0:c9e4:fab9 with SMTP id
 69-20020a250548000000b00da0c9e4fab9mr16019519ybf.57.1698871985341; 
 Wed, 01 Nov 2023 13:53:05 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a25b103000000b00da06575fbc8sm353855ybj.2.2023.11.01.13.53.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 13:53:04 -0700 (PDT)
Message-ID: <c69961b0-54c6-4885-bbf4-597727be35fc@gmail.com>
Date: Wed, 1 Nov 2023 17:52:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] spapr/pci: Correct "does not support hotplugging
 error messages
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, npiggin@gmail.com, clg@kaod.org,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, dave@treblig.org,
 jasowang@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 mst@redhat.com, david@redhat.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
References: <20231031111059.3407803-1-armbru@redhat.com>
 <20231031111059.3407803-2-armbru@redhat.com>
Content-Language: en-US
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231031111059.3407803-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=danielhb413@gmail.com; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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



On 10/31/23 08:10, Markus Armbruster wrote:
> When dynamic-reconfiguration is off, hot plug / unplug can fail with
> "Bus 'spapr-pci-host-bridge' does not support hotplugging".
> spapr-pci-host-bridge is a device, not a bus.  Report the name of the
> bus it provides instead: 'pci.0'.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Feel free to queue it up. Thanks,


Daniel

>   hw/ppc/spapr_pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 370c5a90f2..ebb32ad90b 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1551,7 +1551,7 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
>            */
>           if (plugged_dev->hotplugged) {
>               error_setg(errp, QERR_BUS_NO_HOTPLUG,
> -                       object_get_typename(OBJECT(phb)));
> +                       phb->parent_obj.bus->qbus.name);
>               return;
>           }
>       }
> @@ -1672,7 +1672,7 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
>   
>       if (!phb->dr_enabled) {
>           error_setg(errp, QERR_BUS_NO_HOTPLUG,
> -                   object_get_typename(OBJECT(phb)));
> +                   phb->parent_obj.bus->qbus.name);
>           return;
>       }
>   

