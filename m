Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8B47D0D05
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 12:21:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtmbM-00073s-27; Fri, 20 Oct 2023 06:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qtmbI-0006y6-3O; Fri, 20 Oct 2023 06:19:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qtmbF-0002US-54; Fri, 20 Oct 2023 06:19:26 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ba172c5f3dso599570b3a.0; 
 Fri, 20 Oct 2023 03:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697797162; x=1698401962; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vg8YEidwOAfBJjpM3900z941cKzQF1wendv0pJHv28o=;
 b=SrMXdDVy1yCUFkwdXm0s9dV1hcOXPfzE/BAuDCBqDQcilorw1gjgUnXzliRM/lJNxS
 H0UafKX3Kl2ztXi3wUpxHyeB8Y8YWy+OhyabIBH6NlT7bVSp0j5VrG2PG91NbzIudEBZ
 9q9EllhfUua/O+U+o6W3GkBwG/yudHnELSSllAPUqa7Y94TyLrHkVFUFY3i23s+uSmCm
 TDo/60JmNv+EFycJbvzIPPAqSJgjaiwyPpG6FT2M9oFxEUF1MquDv/p0kXXQ0uZJjprL
 2JKzEDADaub7I/X2lPx6YfeIS2bERhxai820qA1L6rN0Hq2RIRZ76KxleKBHBapsO69l
 hLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697797162; x=1698401962;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vg8YEidwOAfBJjpM3900z941cKzQF1wendv0pJHv28o=;
 b=kS55vxQ3vFVHA+70IramyEx9YwhnjDOlNfqaPUEcmxEz5wb7i4lDlrF8tfrINB92C1
 pWwZ+J6fQIs6HSNhopjYkrt3oUxkGEMF/F5PZaHSOTjkU4j/NXpXglsfdUfEOdpjDGXn
 6lN8W/z/QcN5/YA4X2e35bT76jdypN6n+a9jeAC2u/BWpb9NRNh199lAyH4vXXIWuDOa
 iK9KMC+8zSEGFB6qU8uqj+J9/wRfMw8i9MxrZubFGkEeMLysrADS76Zw9+IR4WQKYyum
 BF70wzYgGtKpX0eSY9Ubjcmt6/af4LCbUnLQ0TVNaAEGrTQh0uyTmcWNiPZ2CLdAFnMr
 xOaQ==
X-Gm-Message-State: AOJu0YwrJAj0DyZBrXTorP071FpjKBDWZlkc1GdjbXk1qrZ5o1tJ8OFn
 qaC0fQXJ6LoVZkfLu5ee64g=
X-Google-Smtp-Source: AGHT+IFlUloi9z1k1rZ00RCbwCVJ4rGTQJjD+25Ti4xEjC+JEuVBQC6hxoWqJkR2/V1oq24A+tVGHg==
X-Received: by 2002:a05:6a00:2316:b0:690:c75e:25d7 with SMTP id
 h22-20020a056a00231600b00690c75e25d7mr1328312pfh.18.1697797162159; 
 Fri, 20 Oct 2023 03:19:22 -0700 (PDT)
Received: from localhost (61-68-209-245.tpgi.com.au. [61.68.209.245])
 by smtp.gmail.com with ESMTPSA id
 j69-20020a638048000000b005501b24b1c9sm1114213pgd.62.2023.10.20.03.19.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 03:19:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Oct 2023 20:19:09 +1000
Message-Id: <CWD6UZ0F1TO8.2IUPVJO2IRM6X@wheely>
Subject: Re: [PATCH v2 07/13] migration: Hack to maintain backwards
 compatibility for ppc
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Juan Quintela" <quintela@redhat.com>, <qemu-devel@nongnu.org>
Cc: "Peter Maydell" <peter.maydell@linaro.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "David Hildenbrand" <david@redhat.com>, "Samuel
 Thibault" <samuel.thibault@ens-lyon.org>, "Eric Farman"
 <farman@linux.ibm.com>, <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>,
 "Thomas Huth" <thuth@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Corey Minyard" <cminyard@mvista.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Peter Xu" <peterx@redhat.com>,
 "Corey Minyard" <minyard@acm.org>, "Stefan Berger"
 <stefanb@linux.vnet.ibm.com>, "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>, =?utf-8?q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Halil Pasic" <pasic@linux.ibm.com>,
 "Leonardo Bras" <leobras@redhat.com>, "John Snow" <jsnow@redhat.com>, "Mark
 Cave-Ayland" <mark.cave-ayland@ilande.co.uk>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Ilya Leoshkevich" <iii@linux.ibm.com>, "Jason
 Wang" <jasowang@redhat.com>, <qemu-block@nongnu.org>,
 <qemu-s390x@nongnu.org>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>, "Stefan Weil"
 <sw@weilnetz.de>, "Greg Kurz" <groug@kaod.org>
X-Mailer: aerc 0.15.2
References: <20231020090731.28701-1-quintela@redhat.com>
 <20231020090731.28701-8-quintela@redhat.com>
In-Reply-To: <20231020090731.28701-8-quintela@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri Oct 20, 2023 at 7:07 PM AEST, Juan Quintela wrote:
> Current code does:
> - register pre_2_10_vmstate_dummy_icp with "icp/server" and instance
>   dependinfg on cpu number
> - for newer machines, it register vmstate_icp with "icp/server" name
>   and instance 0
> - now it unregisters "icp/server" for the 1st instance.
>
> This is wrong at many levels:
> - we shouldn't have two VMSTATEDescriptions with the same name
> - In case this is the only solution that we can came with, it needs to
>   be:
>   * register pre_2_10_vmstate_dummy_icp
>   * unregister pre_2_10_vmstate_dummy_icp
>   * register real vmstate_icp
>
> Created vmstate_replace_hack_for_ppc() with warnings left and right
> that it is a hack.

Thanks. We'll look at deprecating 2.9 soon so this can all be removed.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> CC: Cedric Le Goater <clg@kaod.org>
> CC: Daniel Henrique Barboza <danielhb413@gmail.com>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Greg Kurz <groug@kaod.org>
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/vmstate.h | 11 +++++++++++
>  hw/intc/xics.c              | 17 +++++++++++++++--
>  hw/ppc/spapr.c              | 25 +++++++++++++++++++++++--
>  migration/savevm.c          | 18 ++++++++++++++++++
>  4 files changed, 67 insertions(+), 4 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 9ca7e9cc48..65deaecc92 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1230,6 +1230,17 @@ static inline int vmstate_register(VMStateIf *obj,=
 int instance_id,
>                                            opaque, -1, 0, NULL);
>  }
> =20
> +/**
> + * vmstate_replace_hack_for_ppc() - ppc used to abuse vmstate_register
> + *
> + * Don't even think about using this function in new code.
> + *
> + * Returns: 0 on success, -1 on failure
> + */
> +int vmstate_replace_hack_for_ppc(VMStateIf *obj, int instance_id,
> +                                 const VMStateDescription *vmsd,
> +                                 void *opaque);
> +
>  /**
>   * vmstate_register_any() - legacy function to register state
>   * serialisation description and let the function choose the id
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index c7f8abd71e..a03979e72a 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -335,8 +335,21 @@ static void icp_realize(DeviceState *dev, Error **er=
rp)
>              return;
>          }
>      }
> -
> -    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp)=
;
> +    /*
> +     * The way that pre_2_10_icp is handling is really, really hacky.
> +     * We used to have here this call:
> +     *
> +     * vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, i=
cp);
> +     *
> +     * But we were doing:
> +     *     pre_2_10_vmstate_register_dummy_icp()
> +     *     this vmstate_register()
> +     *     pre_2_10_vmstate_unregister_dummy_icp()
> +     *
> +     * So for a short amount of time we had to vmstate entries with
> +     * the same name.  This fixes it.
> +     */
> +    vmstate_replace_hack_for_ppc(NULL, icp->cs->cpu_index, &vmstate_icp_=
server, icp);
>  }
> =20
>  static void icp_unrealize(DeviceState *dev)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cb840676d3..a75cf475ad 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -143,6 +143,11 @@ static bool pre_2_10_vmstate_dummy_icp_needed(void *=
opaque)
>  }
> =20
>  static const VMStateDescription pre_2_10_vmstate_dummy_icp =3D {
> +    /*
> +     * Hack ahead.  We can't have two devices with the same name and
> +     * instance id.  So I rename this to pass make check.
> +     * Real help from people who knows the hardware is needed.
> +     */
>      .name =3D "icp/server",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> @@ -155,16 +160,32 @@ static const VMStateDescription pre_2_10_vmstate_du=
mmy_icp =3D {
>      },
>  };
> =20
> +/*
> + * See comment in hw/intc/xics.c:icp_realize()
> + *
> + * You have to remove vmstate_replace_hack_for_ppc() when you remove
> + * the machine types that need the following function.
> + */
>  static void pre_2_10_vmstate_register_dummy_icp(int i)
>  {
>      vmstate_register(NULL, i, &pre_2_10_vmstate_dummy_icp,
>                       (void *)(uintptr_t) i);
>  }
> =20
> +/*
> + * See comment in hw/intc/xics.c:icp_realize()
> + *
> + * You have to remove vmstate_replace_hack_for_ppc() when you remove
> + * the machine types that need the following function.
> + */
>  static void pre_2_10_vmstate_unregister_dummy_icp(int i)
>  {
> -    vmstate_unregister(NULL, &pre_2_10_vmstate_dummy_icp,
> -                       (void *)(uintptr_t) i);
> +    /*
> +     * This used to be:
> +     *
> +     *    vmstate_unregister(NULL, &pre_2_10_vmstate_dummy_icp,
> +     * 	                    (void *)(uintptr_t) i);
> +     */
>  }
> =20
>  int spapr_max_server_number(SpaprMachineState *spapr)
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 8622f229e5..d3a30686d4 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -846,6 +846,24 @@ static void vmstate_check(const VMStateDescription *=
vmsd)
>      }
>  }
> =20
> +/*
> + * See comment in hw/intc/xics.c:icp_realize()
> + *
> + * This function can be removed when
> + * pre_2_10_vmstate_register_dummy_icp() is removed.
> + */
> +int vmstate_replace_hack_for_ppc(VMStateIf *obj, int instance_id,
> +                                 const VMStateDescription *vmsd,
> +                                 void *opaque)
> +{
> +    SaveStateEntry *se =3D find_se(vmsd->name, instance_id);
> +
> +    if (se) {
> +        savevm_state_handler_remove(se);
> +    }
> +    return vmstate_register(obj, instance_id, vmsd, opaque);
> +}
> +
>  int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
>                                     const VMStateDescription *vmsd,
>                                     void *opaque, int alias_id,


