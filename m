Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4886A76B454
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 14:04:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQo5x-0007gU-Pl; Tue, 01 Aug 2023 08:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQo5r-0007Pp-D4
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQo5m-00077R-9S
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690891388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=okaBwoxLNQde5x/44bER0yBKOAFxmCrmCz7Zzt4DOHw=;
 b=BvHID/RAy4Jw2Qt/kAHr5zFtnIPFuVmGfG33M6Rd3Y07+9+NwHBSRRLHem+cQz+aUXkciw
 jltbnzlKICqXHWH5n6cw7mPyz0n7JY10bim7Qwr9Ua6uqyWz9XTWjZg54a8Tf5+ldujzQJ
 VxVqT9u+qbyIvENeMz4Zhb9F+Wun90k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-8kAjWJ0CPB6K_W4SCdnk_w-1; Tue, 01 Aug 2023 08:03:07 -0400
X-MC-Unique: 8kAjWJ0CPB6K_W4SCdnk_w-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-63d0b65ae89so42714836d6.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 05:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690891387; x=1691496187;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=okaBwoxLNQde5x/44bER0yBKOAFxmCrmCz7Zzt4DOHw=;
 b=OpHCqDSRWigYYNnUXNx0PaCNv3gExA9UzFIQc62rlfhp3AJQkIxr7zcoHerNyitugO
 xXdF3GW/nKmB6vK9oeB8KHrUKSULsZGX2S4me9Cm0FcLFAUlvOYS4UFGlTY2HaIdVrHw
 QDHgyMjoctmyjhLo5baAOyqlfVPnMTZkXhQsbI3eQGVU4nKXeTr45KFZqk7Wq4IG9h1s
 k6osvrv0BMDD5nyRTVXsGj0Eg0N/Dl8pDhL9lVmEjQGTFh4TOIGSw68Wiy/fGRU9EJts
 wN2lm8wj5K+w9HOVB33EGOE79u/Skj647U+ohg/z5si38KzlH7OFR88drcdAYde4X+kX
 7j4Q==
X-Gm-Message-State: ABy/qLbky1nCbSAX0Fzvzh88bQJcZ0AWxeasDWWXc3kD4+ozBJ2cdzyV
 RSKSEfLkBXFCT9LaYszOka4bLnoebSTS/4iEo83O4juOQ6mSRslKColJmbfSrvXQ/EMCI0lXr0K
 DHxJyPwqqEAXNbBg=
X-Received: by 2002:a05:6214:27c9:b0:630:1b99:5c53 with SMTP id
 ge9-20020a05621427c900b006301b995c53mr13665404qvb.9.1690891386763; 
 Tue, 01 Aug 2023 05:03:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkoXgaKhTfY8kkypRGujP0RydUEvxOrdDnNO68qSouhM5MU579mTpyFg2LUy4LzddcOW7c4A==
X-Received: by 2002:a05:6214:27c9:b0:630:1b99:5c53 with SMTP id
 ge9-20020a05621427c900b006301b995c53mr13665376qvb.9.1690891386393; 
 Tue, 01 Aug 2023 05:03:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h24-20020ae9ec18000000b0076800354830sm4092778qkg.2.2023.08.01.05.03.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 05:03:06 -0700 (PDT)
Message-ID: <0b0a59c2-9016-471f-7576-ffb59adc23cf@redhat.com>
Date: Tue, 1 Aug 2023 14:03:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 v2 2/6] sysemu: Add prepare callback to struct
 VMChangeStateEntry
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230731102521.15335-1-avihaih@nvidia.com>
 <20230731102521.15335-3-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230731102521.15335-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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
> Add prepare callback to struct VMChangeStateEntry.
> 
> The prepare callback is optional and can be set by the new function
> qemu_add_vm_change_state_handler_prio_full() that allows setting this
> callback in addition to the main callback.
> 
> The prepare callbacks and main callbacks are called in two separate
> phases: First all prepare callbacks are called and only then all main
> callbacks are called.
> 
> The purpose of the new prepare callback is to allow all devices to run a
> preliminary task before calling the devices' main callbacks.
> 
> This will facilitate adding P2P support for VFIO migration where all
> VFIO devices need to be put in an intermediate P2P quiescent state
> before being stopped or started by the main callback.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/sysemu/runstate.h |  4 ++++
>   softmmu/runstate.c        | 40 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index 7beb29c2e2..764a0fc6a4 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -16,6 +16,10 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
>                                                        void *opaque);
>   VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
>           VMChangeStateHandler *cb, void *opaque, int priority);
> +VMChangeStateEntry *
> +qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
> +                                           VMChangeStateHandler *prepare_cb,
> +                                           void *opaque, int priority);
>   VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
>                                                        VMChangeStateHandler *cb,
>                                                        void *opaque);
> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
> index f3bd862818..1652ed0439 100644
> --- a/softmmu/runstate.c
> +++ b/softmmu/runstate.c
> @@ -271,6 +271,7 @@ void qemu_system_vmstop_request(RunState state)
>   }
>   struct VMChangeStateEntry {
>       VMChangeStateHandler *cb;
> +    VMChangeStateHandler *prepare_cb;
>       void *opaque;
>       QTAILQ_ENTRY(VMChangeStateEntry) entries;
>       int priority;
> @@ -293,12 +294,39 @@ static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
>    */
>   VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
>           VMChangeStateHandler *cb, void *opaque, int priority)
> +{
> +    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, opaque,
> +                                                      priority);
> +}
> +
> +/**
> + * qemu_add_vm_change_state_handler_prio_full:
> + * @cb: the main callback to invoke
> + * @prepare_cb: a callback to invoke before the main callback
> + * @opaque: user data passed to the callbacks
> + * @priority: low priorities execute first when the vm runs and the reverse is
> + *            true when the vm stops
> + *
> + * Register a main callback function and an optional prepare callback function
> + * that are invoked when the vm starts or stops running. The main callback and
> + * the prepare callback are called in two separate phases: First all prepare
> + * callbacks are called and only then all main callbacks are called. As its
> + * name suggests, the prepare callback can be used to do some preparatory work
> + * before invoking the main callback.
> + *
> + * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
> + */
> +VMChangeStateEntry *
> +qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
> +                                           VMChangeStateHandler *prepare_cb,
> +                                           void *opaque, int priority)
>   {
>       VMChangeStateEntry *e;
>       VMChangeStateEntry *other;
>   
>       e = g_malloc0(sizeof(*e));
>       e->cb = cb;
> +    e->prepare_cb = prepare_cb;
>       e->opaque = opaque;
>       e->priority = priority;
>   
> @@ -333,10 +361,22 @@ void vm_state_notify(bool running, RunState state)
>       trace_vm_state_notify(running, state, RunState_str(state));
>   
>       if (running) {
> +        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
> +            if (e->prepare_cb) {
> +                e->prepare_cb(e->opaque, running, state);
> +            }
> +        }
> +
>           QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
>               e->cb(e->opaque, running, state);
>           }
>       } else {
> +        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
> +            if (e->prepare_cb) {
> +                e->prepare_cb(e->opaque, running, state);
> +            }
> +        }
> +
>           QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
>               e->cb(e->opaque, running, state);
>           }


