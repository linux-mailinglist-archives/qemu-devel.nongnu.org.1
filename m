Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA82A77B8AE
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 14:33:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVWjw-0007sg-B9; Mon, 14 Aug 2023 08:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qVWju-0007sP-AC
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 08:32:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qVWjr-0003Uc-Sw
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 08:32:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe1d9a8ec6so30070415e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 05:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692016322; x=1692621122;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V/UOqS+HhZrMu8PzAb0tEXD4nfcXDySePmrT2R5NWug=;
 b=IVooglF1X4BR1byjgL2Z6tXaw/l8bco8/1nqhe3kxDeAf7FSt+WESlIkQFylednKdC
 8jplxa6dpGsOoPlCYxQ1SA2B3GHkNajF55t0gC9FI1s+WE2UV5rfB+oSosqCA1+kHdjM
 Ag7XMlpDZQ/iogebmkpd5USKa7lCWCg1Wuvu61gybjS3AqDwu8N4KsbeMgxGH+s2Pxvc
 sZy/LJ64AmQrWeKAkvzBKEcQ9I5hPvprOnbWFlsykpes+ylkMQ9p145/YtaWs+OewOQ/
 577J3L25oCYVaAlbKNUrn+30TJrOIWOiSP3zR+rXBCC533JtGgdku2vecSLR+uek2IiV
 xOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692016322; x=1692621122;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/UOqS+HhZrMu8PzAb0tEXD4nfcXDySePmrT2R5NWug=;
 b=bqxF8Q6scJFwU9g8IeG50OxNmP7dS3YH//YXyG/CbC8FCN+sCFzapPha/gVSvrwtih
 CGzndQVSojEdkPSWtja0er6jrcfhVvMqR82PJmyIrAuDf4SgJGN4HiqYUZfRngKwngWd
 O0yQRPyHcPn3LLCjpk6LLTObPsahqFKLpCD8WgNBVng15JsZ3v0ocUblrbNji/Epg9fc
 sxQKA1nv+OnneXy/OCiZe7xpOcu+rSmIn8xf3f3kFbeGxugqSZ8XY+Sb1JnHmrZRCypb
 fXTOu5drvpSbIyf4wvcTXF+JjRdhi4Ka89bBwlEDsvSpXRDx7amB0UWyhoIW00MIy10D
 atKA==
X-Gm-Message-State: AOJu0YwEqjnCROFR2V1vlBkqTxZju7AEKrcgG+UVHWO/y9ejkJgULJyc
 /v0vIWMP5eoYHA/i79xr7N8=
X-Google-Smtp-Source: AGHT+IGxUMKaLrIyUXsODDpoe77K8GyxfOaZ4AZQ4FyMsM4MDtTf62gb7Lb7cgeqmX+IS2ejLmjBdA==
X-Received: by 2002:adf:ec0b:0:b0:317:650d:f7ce with SMTP id
 x11-20020adfec0b000000b00317650df7cemr7625342wrn.29.1692016321647; 
 Mon, 14 Aug 2023 05:32:01 -0700 (PDT)
Received: from [192.168.17.102] (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 t18-20020adff612000000b00317b0155502sm14337513wrp.8.2023.08.14.05.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Aug 2023 05:32:01 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <23529a16-3a7e-287a-4da8-eebf53d5a95d@xen.org>
Date: Mon, 14 Aug 2023 13:31:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH post-8.1] hw/xen: Clean up event channel 'type_val'
 handling to use union
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <2d5e23d21fdbd148d9b0d9e4c00145217c4ddd17.camel@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <2d5e23d21fdbd148d9b0d9e4c00145217c4ddd17.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-2.265, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 03/08/2023 16:28, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> A previous implementation of this stuff used a 64-bit field for all of
> the port information (vcpu/type/type_val) and did atomic exchanges on
> them. When I implemented that in Qemu I regretted my life choices and
> just kept it simple with locking instead.
> 
> So there's no need for the XenEvtchnPort to be so simplistic. We can
> use a union for the pirq/virq/interdomain information, which lets us
> keep a separate bit for the 'remote domain' in interdomain ports. A
> single bit is enough since the only possible targets are loopback or
> qemu itself.
> 
> So now we can ditch PORT_INFO_TYPEVAL_REMOTE_QEMU and the horrid
> manual masking, although the in-memory representation is identical
> so there's no change in the saved state ABI.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> Thought this would be a nice cleanup to avoid abusing `type_val` for
> various different purposes, and especially the top bit of it for
> interdomain ports. But having done it I find myself fairly ambivalent
> about it. Does anyone feel strongly either way?
> 
>   hw/i386/kvm/xen_evtchn.c | 124 ++++++++++++++++++++-------------------
>   1 file changed, 64 insertions(+), 60 deletions(-)
>

I don't feel that strongly, but using the union+bitfield approach is a 
little nicer to read and only makes the code 4 lines longer.


> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index a731738411..446ae46022 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -58,7 +58,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(XenEvtchnState, XEN_EVTCHN)
>   typedef struct XenEvtchnPort {
>       uint32_t vcpu;      /* Xen/ACPI vcpu_id */
>       uint16_t type;      /* EVTCHNSTAT_xxxx */
> -    uint16_t type_val;  /* pirq# / virq# / remote port according to type */
> +    union {
> +        uint16_t type_val;  /* pirq# / virq# / remote port according to type */

Not sure the comment is that valuable any more... and maybe just 'val' 
now rather than 'type_val'?

> +        uint16_t pirq;
> +        uint16_t virq;
> +        struct {
> +            uint16_t port:15;
> +            uint16_t to_qemu:1; /* Only two targets; qemu or loopback */

I'd have switch the sense and called this 'loopback'... since it's the 
more unlikely case.

> +        } interdomain;
> +    } u;
>   } XenEvtchnPort;
>   
>   /* 32-bit compatibility definitions, also used natively in 32-bit build */
> @@ -210,16 +218,16 @@ static int xen_evtchn_post_load(void *opaque, int version_id)
>           XenEvtchnPort *p = &s->port_table[i];
>   
>           if (p->type == EVTCHNSTAT_pirq) {
> -            assert(p->type_val);
> -            assert(p->type_val < s->nr_pirqs);
> +            assert(p->u.pirq);
> +            assert(p->u.pirq < s->nr_pirqs);
>   
>               /*
>                * Set the gsi to IRQ_UNBOUND; it may be changed to an actual
>                * GSI# below, or to IRQ_MSI_EMU when the MSI table snooping
>                * catches up with it.
>                */
> -            s->pirq[p->type_val].gsi = IRQ_UNBOUND;
> -            s->pirq[p->type_val].port = i;
> +            s->pirq[p->u.pirq].gsi = IRQ_UNBOUND;
> +            s->pirq[p->u.pirq].port = i;
>           }
>       }
>       /* Rebuild s->pirq[].gsi mapping */
> @@ -243,7 +251,7 @@ static const VMStateDescription xen_evtchn_port_vmstate = {
>       .fields = (VMStateField[]) {
>           VMSTATE_UINT32(vcpu, XenEvtchnPort),
>           VMSTATE_UINT16(type, XenEvtchnPort),
> -        VMSTATE_UINT16(type_val, XenEvtchnPort),
> +        VMSTATE_UINT16(u.type_val, XenEvtchnPort),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> @@ -599,14 +607,13 @@ static void unbind_backend_ports(XenEvtchnState *s)
>   
>       for (i = 1; i < s->nr_ports; i++) {
>           p = &s->port_table[i];
> -        if (p->type == EVTCHNSTAT_interdomain &&
> -            (p->type_val & PORT_INFO_TYPEVAL_REMOTE_QEMU)) {
> -            evtchn_port_t be_port = p->type_val & PORT_INFO_TYPEVAL_REMOTE_PORT_MASK;
> +        if (p->type == EVTCHNSTAT_interdomain && p->u.interdomain.to_qemu) {
> +            evtchn_port_t be_port = p->u.interdomain.port;
>   
>               if (s->be_handles[be_port]) {
>                   /* This part will be overwritten on the load anyway. */
>                   p->type = EVTCHNSTAT_unbound;
> -                p->type_val = PORT_INFO_TYPEVAL_REMOTE_QEMU;
> +                p->u.interdomain.port = 0;
>   
>                   /* Leave the backend port open and unbound too. */
>                   if (kvm_xen_has_cap(EVTCHN_SEND)) {
> @@ -644,7 +651,7 @@ int xen_evtchn_status_op(struct evtchn_status *status)
>   
>       switch (p->type) {
>       case EVTCHNSTAT_unbound:
> -        if (p->type_val & PORT_INFO_TYPEVAL_REMOTE_QEMU) {
> +        if (p->u.interdomain.to_qemu) {
>               status->u.unbound.dom = DOMID_QEMU;
>           } else {
>               status->u.unbound.dom = xen_domid;
> @@ -652,22 +659,21 @@ int xen_evtchn_status_op(struct evtchn_status *status)
>           break;
>   
>       case EVTCHNSTAT_interdomain:
> -        if (p->type_val & PORT_INFO_TYPEVAL_REMOTE_QEMU) {
> +        if (p->u.interdomain.to_qemu) {
>               status->u.interdomain.dom = DOMID_QEMU;
>           } else {
>               status->u.interdomain.dom = xen_domid;
>           }

Possibly neater as a ternary now you're switching on a simple boolean.

>   
> -        status->u.interdomain.port = p->type_val &
> -            PORT_INFO_TYPEVAL_REMOTE_PORT_MASK;
> +        status->u.interdomain.port = p->u.interdomain.port;
>           break;
>   
>       case EVTCHNSTAT_pirq:
> -        status->u.pirq = p->type_val;
> +        status->u.pirq = p->u.pirq;
>           break;
>   
>       case EVTCHNSTAT_virq:
> -        status->u.virq = p->type_val;
> +        status->u.virq = p->u.virq;
>           break;
>       }
>   
> @@ -983,7 +989,7 @@ static int clear_port_pending(XenEvtchnState *s, evtchn_port_t port)
>   static void free_port(XenEvtchnState *s, evtchn_port_t port)
>   {
>       s->port_table[port].type = EVTCHNSTAT_closed;
> -    s->port_table[port].type_val = 0;
> +    s->port_table[port].u.type_val = 0;
>       s->port_table[port].vcpu = 0;
>   
>       if (s->nr_ports == port + 1) {
> @@ -1006,7 +1012,7 @@ static int allocate_port(XenEvtchnState *s, uint32_t vcpu, uint16_t type,
>           if (s->port_table[p].type == EVTCHNSTAT_closed) {
>               s->port_table[p].vcpu = vcpu;
>               s->port_table[p].type = type;
> -            s->port_table[p].type_val = val;
> +            s->port_table[p].u.type_val = val;
>   
>               *port = p;
>   
> @@ -1047,15 +1053,15 @@ static int close_port(XenEvtchnState *s, evtchn_port_t port,
>           return -ENOENT;
>   
>       case EVTCHNSTAT_pirq:
> -        s->pirq[p->type_val].port = 0;
> -        if (s->pirq[p->type_val].is_translated) {
> +        s->pirq[p->u.pirq].port = 0;
> +        if (s->pirq[p->u.pirq].is_translated) {
>               *flush_kvm_routes = true;
>           }
>           break;
>   
>       case EVTCHNSTAT_virq:
> -        kvm_xen_set_vcpu_virq(virq_is_global(p->type_val) ? 0 : p->vcpu,
> -                              p->type_val, 0);
> +        kvm_xen_set_vcpu_virq(virq_is_global(p->u.virq) ? 0 : p->vcpu,
> +                              p->u.virq, 0);
>           break;
>   
>       case EVTCHNSTAT_ipi:
> @@ -1065,8 +1071,8 @@ static int close_port(XenEvtchnState *s, evtchn_port_t port,
>           break;
>   
>       case EVTCHNSTAT_interdomain:
> -        if (p->type_val & PORT_INFO_TYPEVAL_REMOTE_QEMU) {
> -            uint16_t be_port = p->type_val & ~PORT_INFO_TYPEVAL_REMOTE_QEMU;
> +        if (p->u.interdomain.to_qemu) {
> +            uint16_t be_port = p->u.interdomain.port;
>               struct xenevtchn_handle *xc = s->be_handles[be_port];
>               if (xc) {
>                   if (kvm_xen_has_cap(EVTCHN_SEND)) {
> @@ -1076,14 +1082,15 @@ static int close_port(XenEvtchnState *s, evtchn_port_t port,
>               }
>           } else {
>               /* Loopback interdomain */
> -            XenEvtchnPort *rp = &s->port_table[p->type_val];
> -            if (!valid_port(p->type_val) || rp->type_val != port ||
> +            XenEvtchnPort *rp = &s->port_table[p->u.interdomain.port];
> +            if (!valid_port(p->u.interdomain.port) ||
> +                rp->u.interdomain.port != port ||
>                   rp->type != EVTCHNSTAT_interdomain) {
>                   error_report("Inconsistent state for interdomain unbind");
>               } else {
>                   /* Set the other end back to unbound */
>                   rp->type = EVTCHNSTAT_unbound;
> -                rp->type_val = 0;
> +                rp->u.interdomain.port = 0;
>               }
>           }
>           break;
> @@ -1207,7 +1214,7 @@ int xen_evtchn_bind_vcpu_op(struct evtchn_bind_vcpu *vcpu)
>       if (p->type == EVTCHNSTAT_interdomain ||
>           p->type == EVTCHNSTAT_unbound ||
>           p->type == EVTCHNSTAT_pirq ||
> -        (p->type == EVTCHNSTAT_virq && virq_is_global(p->type_val))) {
> +        (p->type == EVTCHNSTAT_virq && virq_is_global(p->u.virq))) {
>           /*
>            * unmask_port() with do_unmask==false will just raise the event
>            * on the new vCPU if the port was already pending.
> @@ -1352,19 +1359,15 @@ int xen_evtchn_bind_ipi_op(struct evtchn_bind_ipi *ipi)
>   int xen_evtchn_bind_interdomain_op(struct evtchn_bind_interdomain *interdomain)
>   {
>       XenEvtchnState *s = xen_evtchn_singleton;
> -    uint16_t type_val;
>       int ret;
>   
>       if (!s) {
>           return -ENOTSUP;
>       }
>   
> -    if (interdomain->remote_dom == DOMID_QEMU) {
> -        type_val = PORT_INFO_TYPEVAL_REMOTE_QEMU;
> -    } else if (interdomain->remote_dom == DOMID_SELF ||
> -               interdomain->remote_dom == xen_domid) {
> -        type_val = 0;
> -    } else {
> +    if (interdomain->remote_dom != DOMID_QEMU &&
> +        interdomain->remote_dom != DOMID_SELF &&
> +        interdomain->remote_dom != xen_domid) {
>           return -ESRCH;
>       }
>   
> @@ -1375,8 +1378,8 @@ int xen_evtchn_bind_interdomain_op(struct evtchn_bind_interdomain *interdomain)
>       qemu_mutex_lock(&s->port_lock);
>   
>       /* The newly allocated port starts out as unbound */
> -    ret = allocate_port(s, 0, EVTCHNSTAT_unbound, type_val,
> -                        &interdomain->local_port);
> +    ret = allocate_port(s, 0, EVTCHNSTAT_unbound, 0, &interdomain->local_port);
> +
>       if (ret) {
>           goto out;
>       }
> @@ -1401,7 +1404,8 @@ int xen_evtchn_bind_interdomain_op(struct evtchn_bind_interdomain *interdomain)
>               assign_kernel_eventfd(lp->type, xc->guest_port, xc->fd);
>           }
>           lp->type = EVTCHNSTAT_interdomain;
> -        lp->type_val = PORT_INFO_TYPEVAL_REMOTE_QEMU | interdomain->remote_port;
> +        lp->u.interdomain.to_qemu = 1;
> +        lp->u.interdomain.port = interdomain->remote_port;
>           ret = 0;
>       } else {
>           /* Loopback */
> @@ -1415,13 +1419,13 @@ int xen_evtchn_bind_interdomain_op(struct evtchn_bind_interdomain *interdomain)
>            * the port that was just allocated for the local end.
>            */
>           if (interdomain->local_port != interdomain->remote_port &&
> -            rp->type == EVTCHNSTAT_unbound && rp->type_val == 0) {
> +            rp->type == EVTCHNSTAT_unbound && !rp->u.interdomain.to_qemu) {
>   
>               rp->type = EVTCHNSTAT_interdomain;
> -            rp->type_val = interdomain->local_port;
> +            rp->u.interdomain.port = interdomain->local_port;
>   
>               lp->type = EVTCHNSTAT_interdomain;
> -            lp->type_val = interdomain->remote_port;
> +            lp->u.interdomain.port = interdomain->remote_port;
>           } else {
>               ret = -EINVAL;
>           }
> @@ -1440,7 +1444,6 @@ int xen_evtchn_bind_interdomain_op(struct evtchn_bind_interdomain *interdomain)
>   int xen_evtchn_alloc_unbound_op(struct evtchn_alloc_unbound *alloc)
>   {
>       XenEvtchnState *s = xen_evtchn_singleton;
> -    uint16_t type_val;
>       int ret;
>   
>       if (!s) {
> @@ -1451,18 +1454,19 @@ int xen_evtchn_alloc_unbound_op(struct evtchn_alloc_unbound *alloc)
>           return -ESRCH;
>       }
>   
> -    if (alloc->remote_dom == DOMID_QEMU) {
> -        type_val = PORT_INFO_TYPEVAL_REMOTE_QEMU;
> -    } else if (alloc->remote_dom == DOMID_SELF ||
> -               alloc->remote_dom == xen_domid) {
> -        type_val = 0;
> -    } else {
> +    if (alloc->remote_dom != DOMID_QEMU && alloc->remote_dom != DOMID_SELF &&
> +        alloc->remote_dom != xen_domid) {

Maybe vertically align the clauses here as in the 'if' a couple of hunks 
back?

>           return -EPERM;
>       }
>   

Since all the above are nits...

Reviewed-by: Paul Durrant <paul@xen.org>


