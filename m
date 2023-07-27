Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A14765AD1
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:55:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3ma-0003KR-5p; Thu, 27 Jul 2023 12:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qP3mX-0003KD-GP
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qP3mV-0007fm-ON
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690475040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7bjNdM+CV3RRif7tOKxcjsNyvqYyVMH9V9lAHfkNBPY=;
 b=YQnXqe8y1m0nxM02RzU4fHon8NqJYydWWpEon65T2YMMVG2Lm9Aa6SSQuLP3q3VTnTX74/
 CEXl0MU0e6XIh87j0UYbzZdMkUmLtaB8UABwuE3FnXycMKHpYLC8JMrlKtRQgqUyEusNKu
 SHedT5+37b/eC3xUrKWagnBFTOzXY+g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Cyp5sgamP0iQtcoCPmK1mA-1; Thu, 27 Jul 2023 12:23:58 -0400
X-MC-Unique: Cyp5sgamP0iQtcoCPmK1mA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbab56aac7so6673695e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690475037; x=1691079837;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7bjNdM+CV3RRif7tOKxcjsNyvqYyVMH9V9lAHfkNBPY=;
 b=OcWiY0dXCDN6IyHsZoT+7EG9ey2QRF2jxr5sSqlt8ws3clrShWx7H4YjE42BTqng+M
 V3tjNXZn+JRIZ1sonLNgzlcI7w7U6qtzXD178e11b5TEEweHoypc8IbUrIN6FjpB22vU
 yp9JDEuHd+Z/2MRUZaSAiyhkPvw90hjBZl9L0dX2t63V0tNe+i6CzPGegnL0a1dq9L2V
 tcnB1M4RW/hj+dHAXDP3JGijiWSBpTAoway9S1HmkpMcP7DJxVH7JMjGCKB9AeKbhwZX
 jTv4nhxfBmavsxMaTvCPSkW30dMmoWD1z1d/CxYeLF+oQmlOS0DpVxqQM+0osiCOdqt2
 j7/Q==
X-Gm-Message-State: ABy/qLaJ+Jx8CbUnC6icd4NPg0KM/OXhsO2GnFU6FgIRwJUQ5HsUzzUO
 SmBvrBaQltCauvFFWD+6qrssC7FcYiZza348My1tl6U8VXGqmn+P4sAqrCg3au2yIOMEZLLlIV7
 hrz2PCIz1vNEZflQ=
X-Received: by 2002:a1c:7905:0:b0:3fc:240:cecc with SMTP id
 l5-20020a1c7905000000b003fc0240ceccmr2093446wme.11.1690475037427; 
 Thu, 27 Jul 2023 09:23:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE5HrRHv5HKEGzyCwgUg0yXGojuXmrOn3UQgKnJ/utlrT+FMMnecmEBxOAZtBJo+zNLpTc6Mg==
X-Received: by 2002:a1c:7905:0:b0:3fc:240:cecc with SMTP id
 l5-20020a1c7905000000b003fc0240ceccmr2093438wme.11.1690475037141; 
 Thu, 27 Jul 2023 09:23:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c511400b003f7f475c3bcsm16948724wms.1.2023.07.27.09.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 09:23:56 -0700 (PDT)
Message-ID: <ea781305-fba3-83eb-aac9-fdef6a81b5c9@redhat.com>
Date: Thu, 27 Jul 2023 18:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 2/6] sysemu: Add pre VM state change callback
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
 <20230716081541.27900-3-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230716081541.27900-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/16/23 10:15, Avihai Horon wrote:
> Add pre VM state change callback to struct VMChangeStateEntry.

This sentence could be the subject.

> 
> The pre VM state change callback is optional and can be set by the new
> function qemu_add_vm_change_state_handler_prio_full() that allows
> setting this callback in addition to the main callback.
> 
> The pre VM state change callbacks and main callbacks are called in two
> separate phases: First all pre VM state change callbacks are called and
> only then all main callbacks are called.
> 
> The purpose of the new pre VM state change callback is to allow all
> devices to run a preliminary task before calling the devices' main
> callbacks.
> 
> This will facilitate adding P2P support for VFIO migration where all
> VFIO devices need to be put in an intermediate P2P quiescent state
> before being stopped or started by the main VM state change callback.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   include/sysemu/runstate.h |  4 ++++
>   softmmu/runstate.c        | 39 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 43 insertions(+)
> 
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index 7beb29c2e2..bb38a4b4bd 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -16,6 +16,10 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
>                                                        void *opaque);
>   VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
>           VMChangeStateHandler *cb, void *opaque, int priority);
> +VMChangeStateEntry *
> +qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
> +                                           VMChangeStateHandler *pre_change_cb,
> +                                           void *opaque, int priority);
>   VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
>                                                        VMChangeStateHandler *cb,
>                                                        void *opaque);
> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
> index f3bd862818..a1f0653899 100644
> --- a/softmmu/runstate.c
> +++ b/softmmu/runstate.c
> @@ -271,6 +271,7 @@ void qemu_system_vmstop_request(RunState state)
>   }
>   struct VMChangeStateEntry {
>       VMChangeStateHandler *cb;
> +    VMChangeStateHandler *pre_change_cb;

I propose to use 'prepare' instead of 'pre_change'


>       void *opaque;
>       QTAILQ_ENTRY(VMChangeStateEntry) entries;
>       int priority;
> @@ -293,12 +294,38 @@ static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
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

qemu_add_vm_change_state_handler_prio_all() may be. I don't have much better
but 'full' doesn't sound right. minor.

The rest looks fine to me.

Thanks,

C.

> + * @cb: the main callback to invoke
> + * @pre_change_cb: a callback to invoke before the main callback
> + * @opaque: user data passed to the callbacks
> + * @priority: low priorities execute first when the vm runs and the reverse is
> + *            true when the vm stops
> + *
> + * Register a main callback function and an optional pre VM state change
> + * callback function that are invoked when the vm starts or stops running. The
> + * main callback and the pre VM state change callback are called in two
> + * separate phases: First all pre VM state change callbacks are called and only
> + * then all main callbacks are called.
> + *
> + * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
> + */
> +VMChangeStateEntry *
> +qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
> +                                           VMChangeStateHandler *pre_change_cb,
> +                                           void *opaque, int priority)
>   {
>       VMChangeStateEntry *e;
>       VMChangeStateEntry *other;
>   
>       e = g_malloc0(sizeof(*e));
>       e->cb = cb;
> +    e->pre_change_cb = pre_change_cb;
>       e->opaque = opaque;
>       e->priority = priority;
>   
> @@ -333,10 +360,22 @@ void vm_state_notify(bool running, RunState state)
>       trace_vm_state_notify(running, state, RunState_str(state));
>   
>       if (running) {
> +        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
> +            if (e->pre_change_cb) {
> +                e->pre_change_cb(e->opaque, running, state);
> +            }
> +        }
> +
>           QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
>               e->cb(e->opaque, running, state);
>           }
>       } else {
> +        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
> +            if (e->pre_change_cb) {
> +                e->pre_change_cb(e->opaque, running, state);
> +            }
> +        }
> +
>           QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
>               e->cb(e->opaque, running, state);
>           }


