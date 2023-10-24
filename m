Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4615F7D56D7
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:45:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJZr-0006Hp-3o; Tue, 24 Oct 2023 11:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvJZo-0006HO-Ld; Tue, 24 Oct 2023 11:44:17 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvJZi-0008Cj-2T; Tue, 24 Oct 2023 11:44:16 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32dd70c5401so3150126f8f.0; 
 Tue, 24 Oct 2023 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698162248; x=1698767048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yS5KTEoFqSeFaD9KDbOtnwK71r/T1IzAy2dMzIuLI5s=;
 b=jfWYcJJ+0Pp8GYKfTKU7yPX/XnUbBq4pLQgZ5DfRzzKwBuDJCW6D/KSCOhKKXZouQK
 CfkgfONd+oK36R41w5fTaJ2bE7nN5C2Z8vnG8eUEtxhdxVe6Po1b0NPs6sODsXR4TP8A
 F9cQc4Ue/24mfRg0tH/dykY759ULyFa0SAygvhZwWssxIpbRjl9dl5GP1uJEBFYP59w0
 8ZPPJElSXfHw0Baiep+bkE2qGZgwouDzB4A0f/vx2XeBytaAly8eiuD7IJD41Odlcyuk
 KKAZiQ9IgkNYxWsV3OXi3Y9RSCupEALijFPHDEgxfPixgLlIba3nbuonJzM+CWbKCsGy
 byPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698162248; x=1698767048;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yS5KTEoFqSeFaD9KDbOtnwK71r/T1IzAy2dMzIuLI5s=;
 b=BHI22cyiG3TuEs3TESFf2gfMpx0cICMIlWAj6JBzT4YrmAUJA+/Q+kPrVUpquAp9tv
 6SmnZMUKSfRITJnza0AekGE3jZnigxY4Dcs2WMOPipjyJAHE00vojhI+ChBNwcHt02wF
 oF7rw61QCl4vUOHZ9uZ3W+tUxGwaRPrwLZucjhsPHgpSM68YmiuRA5w54JlI9EVeNQ19
 NLGTZggPx3BbkYv38VHjmp+P50xNdh3GiabwHngsHmPHlqtErfBG1QDR2tBx6D1tIsI+
 cK+yLqzf2NKkOZ4ho9zq6yzZ/OYmRaPQECla1RCLFdzLHLdoyupRsI3EGQz6aPSxaIiq
 ZyXw==
X-Gm-Message-State: AOJu0YzVBGTh8Yh8osdwMaFM20eTnIGa94IO1omL1vQ0CM/YqBQUfmfV
 wnX2p1wOIc36ItcfDOKXzDU=
X-Google-Smtp-Source: AGHT+IGOdFp+c3H/OzmD6auBGTwD1zTQ8nmXRdo9qvd7R6YRSUetpKZX659Ae1VnlHjErrywnw2Ypg==
X-Received: by 2002:a5d:560d:0:b0:32d:d756:2cd3 with SMTP id
 l13-20020a5d560d000000b0032dd7562cd3mr8359004wrv.22.1698162247852; 
 Tue, 24 Oct 2023 08:44:07 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a5d550e000000b0032d9caeab0fsm10133987wrv.77.2023.10.24.08.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 08:44:07 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <8ba01df3-6189-4e1e-a70f-37a2d4dd21ed@xen.org>
Date: Tue, 24 Oct 2023 16:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/24] hw/xen: handle soft reset for primary console
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231019154020.99080-1-dwmw2@infradead.org>
 <20231019154020.99080-17-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231019154020.99080-17-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 19/10/2023 16:40, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> On soft reset, the prinary console event channel needs to be rebound to
> the backend port (in the xen-console driver). We could put that into the
> xen-console driver itself, but it's slightly less ugly to keep it within
> the KVM/Xen code, by stashing the backend port# on event channel reset
> and then rebinding in the primary console reset when it has to recreate
> the guest port anyway.

Does Xen re-bind the primary console on EVTCHNOP_reset? That's news to 
me. I go check.

   Paul

> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c          |  9 +++++++++
>   hw/i386/kvm/xen_primary_console.c | 29 ++++++++++++++++++++++++++++-
>   hw/i386/kvm/xen_primary_console.h |  1 +
>   3 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index d72dca6591..ce4da6d37a 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -40,6 +40,7 @@
>   #include "xen_evtchn.h"
>   #include "xen_overlay.h"
>   #include "xen_xenstore.h"
> +#include "xen_primary_console.h"
>   
>   #include "sysemu/kvm.h"
>   #include "sysemu/kvm_xen.h"
> @@ -1098,6 +1099,7 @@ int xen_evtchn_soft_reset(void)
>   {
>       XenEvtchnState *s = xen_evtchn_singleton;
>       bool flush_kvm_routes;
> +    uint16_t con_port = xen_primary_console_get_port();
>       int i;
>   
>       if (!s) {
> @@ -1108,6 +1110,13 @@ int xen_evtchn_soft_reset(void)
>   
>       qemu_mutex_lock(&s->port_lock);
>   
> +    if (con_port) {
> +        XenEvtchnPort *p = &s->port_table[con_port];
> +        if (p->type == EVTCHNSTAT_interdomain) {
> +            xen_primary_console_set_be_port(p->u.interdomain.port);
> +        }
> +    }
> +
>       for (i = 0; i < s->nr_ports; i++) {
>           close_port(s, i, &flush_kvm_routes);
>       }
> diff --git a/hw/i386/kvm/xen_primary_console.c b/hw/i386/kvm/xen_primary_console.c
> index 0aa1c16ad6..5e6e085ac7 100644
> --- a/hw/i386/kvm/xen_primary_console.c
> +++ b/hw/i386/kvm/xen_primary_console.c
> @@ -112,6 +112,15 @@ uint16_t xen_primary_console_get_port(void)
>       return s->guest_port;
>   }
>   
> +void xen_primary_console_set_be_port(uint16_t port)
> +{
> +    XenPrimaryConsoleState *s = xen_primary_console_singleton;
> +    if (s) {
> +        printf("be port set to %d\n", port);
> +        s->be_port = port;
> +    }
> +}
> +
>   uint64_t xen_primary_console_get_pfn(void)
>   {
>       XenPrimaryConsoleState *s = xen_primary_console_singleton;
> @@ -142,6 +151,20 @@ static void alloc_guest_port(XenPrimaryConsoleState *s)
>       }
>   }
>   
> +static void rebind_guest_port(XenPrimaryConsoleState *s)
> +{
> +    struct evtchn_bind_interdomain inter = {
> +        .remote_dom = DOMID_QEMU,
> +        .remote_port = s->be_port,
> +    };
> +
> +    if (!xen_evtchn_bind_interdomain_op(&inter)) {
> +        s->guest_port = inter.local_port;
> +    }
> +
> +    s->be_port = 0;
> +}
> +
>   int xen_primary_console_reset(void)
>   {
>       XenPrimaryConsoleState *s = xen_primary_console_singleton;
> @@ -154,7 +177,11 @@ int xen_primary_console_reset(void)
>           xen_overlay_do_map_page(&s->console_page, gpa);
>       }
>   
> -    alloc_guest_port(s);
> +    if (s->be_port) {
> +        rebind_guest_port(s);
> +    } else {
> +        alloc_guest_port(s);
> +    }
>   
>       trace_xen_primary_console_reset(s->guest_port);
>   
> diff --git a/hw/i386/kvm/xen_primary_console.h b/hw/i386/kvm/xen_primary_console.h
> index dd4922f3f4..7e2989ea0d 100644
> --- a/hw/i386/kvm/xen_primary_console.h
> +++ b/hw/i386/kvm/xen_primary_console.h
> @@ -16,6 +16,7 @@ void xen_primary_console_create(void);
>   int xen_primary_console_reset(void);
>   
>   uint16_t xen_primary_console_get_port(void);
> +void xen_primary_console_set_be_port(uint16_t port);
>   uint64_t xen_primary_console_get_pfn(void);
>   void *xen_primary_console_get_map(void);
>   


