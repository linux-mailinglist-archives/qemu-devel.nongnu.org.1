Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B3A7CDD46
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6al-0004Zg-9b; Wed, 18 Oct 2023 09:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt6ad-0004Yl-46
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt6ab-00042l-Ke
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697635675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q2CGHvkERvyAnX/3Y6qun7rPuJfcIb7x7iILHqpdU4U=;
 b=gZ3ny482KbBSTKZnjmm1ONDPz6zzz6HDhC2YTPFamdxxCd4A7HpaBj/HZnTENh6ZeGwExn
 tMJW9k7EtGGQ/MH2fm/jWBb4FVslIHOSHzDgwOk1iGQI1Sl7NBPZWbWcxaNCJH8zrTkn51
 zqzNvr5Az/vjs7YsFkhjiMvtT0aLyR8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-8z9psDSCPf6j_rg3AVxHig-1; Wed, 18 Oct 2023 09:27:43 -0400
X-MC-Unique: 8z9psDSCPf6j_rg3AVxHig-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4084163ecd9so773345e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635662; x=1698240462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2CGHvkERvyAnX/3Y6qun7rPuJfcIb7x7iILHqpdU4U=;
 b=ZAhbf1+r3KzJWNo6Vvzol6q2xtCkkN2GSwAnTeVK4Trg8JcNVX3UGQC2Npfhb4RfLN
 Penl9IeFyb82MtBPjXgshrU/0zE5yltnh7m7K+MjLDDFIXnDexgiavKg2Ny8o8tdKuiF
 81cdNJ1LpU5MFOURJoHTotf3yaXKfgauRgCjRksncXMoYroAkEXaGN8gijgjw5eXAxQF
 9KLjhr6jgSVcgMsrg+uX/TUvjqOWd400EtKuixfcy3HcARyMUku49E6Souy5NSH3fCDD
 U/+OIf89c8UYTnac57KcDh2PEJb9qoU6+X1+TpTI61kDa3D6OW7PXtHxOcjkmMlHAYF2
 TgEQ==
X-Gm-Message-State: AOJu0Yx+FhmwA3GBDVjRj7E2vhTJItz02ipko3kuiL93XJixgpUBPpIF
 mhSge17YWpTQA8eTMYvln9uAL7kDl8AYj0YAp0UD5sImFK5k0rJvwob34UldrQ5mbx7GUqh/WLp
 fSz/j05jVpYu8mUY=
X-Received: by 2002:a05:600c:4f51:b0:405:4a78:a892 with SMTP id
 m17-20020a05600c4f5100b004054a78a892mr4200432wmq.9.1697635662082; 
 Wed, 18 Oct 2023 06:27:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRLQmnTOhxa40So/9tgw6ExYiM878K1y9NscxSf609ymSVnj6Z3SZBQdI8bp8hJ2VcClWHYg==
X-Received: by 2002:a05:600c:4f51:b0:405:4a78:a892 with SMTP id
 m17-20020a05600c4f5100b004054a78a892mr4200415wmq.9.1697635661693; 
 Wed, 18 Oct 2023 06:27:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a05600010d100b003197869bcd7sm2125386wrx.13.2023.10.18.06.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 06:27:40 -0700 (PDT)
Date: Wed, 18 Oct 2023 09:27:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH] i386/pc: Drop pc_machine_kvm_type()
Message-ID: <20231018092715-mutt-send-email-mst@kernel.org>
References: <20231007065819.27498-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007065819.27498-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Oct 07, 2023 at 02:58:19AM -0400, Xiaoyao Li wrote:
> pc_machine_kvm_type() was introduced by commit e21be724eaf5 ("i386/xen:
> add pc_machine_kvm_type to initialize XEN_EMULATE mode") to do Xen
> specific initialization by utilizing kvm_type method.
> 
> commit eeedfe6c6316 ("hw/xen: Simplify emulated Xen platform init")
> moves the Xen specific initialization to pc_basic_device_init().
> 
> There is no need to keep the PC specific kvm_type() implementation
> anymore. So we'll fallback to kvm_arch_get_default_type(), which
> simply returns 0.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Woodhouse <dwmw@amazon.co.uk>

Seems ok

Acked-by: Michael S. Tsirkin <mst@redhat.com>

kvm thing so please merge through that tree.


> ---
>  hw/i386/pc.c         | 5 -----
>  include/hw/i386/pc.h | 3 ---
>  2 files changed, 8 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index aad7e8ccd1d7..41783b137b9a 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1730,11 +1730,6 @@ static void pc_machine_initfn(Object *obj)
>      cxl_machine_init(obj, &pcms->cxl_devices_state);
>  }
>  
> -int pc_machine_kvm_type(MachineState *machine, const char *kvm_type)
> -{
> -    return 0;
> -}
> -
>  static void pc_machine_reset(MachineState *machine, ShutdownCause reason)
>  {
>      CPUState *cs;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index bec38cb92cf7..ad7149cb10b5 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -305,15 +305,12 @@ extern const size_t pc_compat_1_5_len;
>  extern GlobalProperty pc_compat_1_4[];
>  extern const size_t pc_compat_1_4_len;
>  
> -int pc_machine_kvm_type(MachineState *machine, const char *vm_type);
> -
>  #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>      static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
>      { \
>          MachineClass *mc = MACHINE_CLASS(oc); \
>          optsfn(mc); \
>          mc->init = initfn; \
> -        mc->kvm_type = pc_machine_kvm_type; \
>      } \
>      static const TypeInfo pc_machine_type_##suffix = { \
>          .name       = namestr TYPE_MACHINE_SUFFIX, \
> 
> base-commit: 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d
> -- 
> 2.34.1


