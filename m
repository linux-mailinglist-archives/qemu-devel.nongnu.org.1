Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2693376B456
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 14:04:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQo6v-0001ZC-7V; Tue, 01 Aug 2023 08:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQo6o-0001RV-IE
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQo6l-0007EL-Cn
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690891450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZeQOkWWy8/HR8vk+wpRft/Iq09ECHiMunCBHzqqf4c=;
 b=Ol6UyMlsNvhqPC5k2Sn65lqs089akZmuwdIv5HU348F1t+grVviIVvoQ0s97V0iGzj3i6C
 sziAuzPGw5JNDuuMkp2rlt5VMCsNWDqLPNfTJk7YshX02XUJkx0LAIE1aFcNMF8wT2I9wD
 yYZG3LxQXEjxSDS6sKciZ+9m4nCtmCU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-ItGHCqB0O-SlblLHP2en3Q-1; Tue, 01 Aug 2023 08:04:09 -0400
X-MC-Unique: ItGHCqB0O-SlblLHP2en3Q-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7659d103147so758774285a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 05:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690891449; x=1691496249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kZeQOkWWy8/HR8vk+wpRft/Iq09ECHiMunCBHzqqf4c=;
 b=Eae/RAQGpnH7yOkvDl967lRC4tRoHxUnMn5uYsvyLbyaP7BDVnTV/cPMJ+NyBI59Hz
 nxdaSPYTLOwtuyP9k+Khsheu6fHnnvmjuWy4erckVrJlm0/uCdfZ06AIvR2Y6kdMyeGm
 dxyoZQgzjkV8x1ksXkMPCjwkB9QZ6U2DPtgsiNsbdrqBB6xjsJKGvvm8PFvaIFzsd56Z
 rA5rZSSserqhBFerQor+S6HLxoZFhyjgF09hRMRuWdmfMSth74duepXXt5pWIPXEgC5D
 y2G29GgfScukyo//cGLh0YE0rI+1ZiyUapRqvqlzWFEp6x1CuE2b8bzxqx1ZsGrxGmVM
 pvzA==
X-Gm-Message-State: ABy/qLatwl4MVxFkwC5OJkboevNhzAflxzr2sUXLPP6a9Zx+qKDh2he9
 goeacRr2rAwLO/VlhNOjW9SKRRN2vFN7cfCC/OvAkNk4lf5e6ERdUzdO0LTQewIMUJeJF9EWNe/
 DJgCiCKCoTr3RbyE=
X-Received: by 2002:a05:620a:22f9:b0:76c:c101:fbf2 with SMTP id
 p25-20020a05620a22f900b0076cc101fbf2mr2030310qki.37.1690891449248; 
 Tue, 01 Aug 2023 05:04:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGRBNWjOS7Z4eRKyiNOM4zSLSA4FJ0MH+NrTtlMucelS9xXc5piNLutlOaZcXMBvgXsO0lOqQ==
X-Received: by 2002:a05:620a:22f9:b0:76c:c101:fbf2 with SMTP id
 p25-20020a05620a22f900b0076cc101fbf2mr2030289qki.37.1690891448953; 
 Tue, 01 Aug 2023 05:04:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 o14-20020ae9f50e000000b007682697dcb0sm4081385qkg.76.2023.08.01.05.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 05:04:08 -0700 (PDT)
Message-ID: <c6cb28a4-78a1-e64b-ca71-70e75a29f92f@redhat.com>
Date: Tue, 1 Aug 2023 14:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 v2 3/6] qdev: Add
 qdev_add_vm_change_state_handler_full()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230731102521.15335-1-avihaih@nvidia.com>
 <20230731102521.15335-4-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230731102521.15335-4-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/31/23 12:25, Avihai Horon wrote:
> Add qdev_add_vm_change_state_handler_full() variant that allows setting
> a prepare callback in addition to the main callback.
> 
> This will facilitate adding P2P support for VFIO migration in the
> following patches.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/sysemu/runstate.h         |  3 +++
>   hw/core/vm-change-state-handler.c | 14 +++++++++++++-
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index 764a0fc6a4..08afb97695 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -23,6 +23,9 @@ qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
>   VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
>                                                        VMChangeStateHandler *cb,
>                                                        void *opaque);
> +VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
> +    DeviceState *dev, VMChangeStateHandler *cb,
> +    VMChangeStateHandler *prepare_cb, void *opaque);
>   void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
>   /**
>    * vm_state_notify: Notify the state of the VM
> diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
> index 1f3630986d..8e2639224e 100644
> --- a/hw/core/vm-change-state-handler.c
> +++ b/hw/core/vm-change-state-handler.c
> @@ -55,8 +55,20 @@ static int qdev_get_dev_tree_depth(DeviceState *dev)
>   VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
>                                                        VMChangeStateHandler *cb,
>                                                        void *opaque)
> +{
> +    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, opaque);
> +}
> +
> +/*
> + * Exactly like qdev_add_vm_change_state_handler() but passes a prepare_cb
> + * argument too.
> + */
> +VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
> +    DeviceState *dev, VMChangeStateHandler *cb,
> +    VMChangeStateHandler *prepare_cb, void *opaque)
>   {
>       int depth = qdev_get_dev_tree_depth(dev);
>   
> -    return qemu_add_vm_change_state_handler_prio(cb, opaque, depth);
> +    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, opaque,
> +                                                      depth);
>   }


