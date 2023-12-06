Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E819D8065AB
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 04:35:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAifj-0005g2-8h; Tue, 05 Dec 2023 22:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1rAifg-0005fb-Tq
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 22:34:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1rAife-0007rb-Vr
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 22:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701833637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjSQU4WJdIdHd3sOhd+juFE8LrD0eIuwOH4A9w4NEcc=;
 b=Rl51OICNhjzYolWYJYXmary0z/4eD6KuNeLmQfEGm0vrUL2DHxyx3AUX/ex/zQwaeepLPy
 djsFX1KFGrJuxqc8FrBddVPETTwP8gaP5FDnQ2vURQoi5VCfy7HVGjCuxDsEzrJ/VWR/Wv
 To/z60PfYt2+GMNtdRcbAu612jsyWWM=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-4pvOE3xoOXC37oeiWKy-fg-1; Tue, 05 Dec 2023 22:33:54 -0500
X-MC-Unique: 4pvOE3xoOXC37oeiWKy-fg-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-4acf7cb4476so1857848e0c.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 19:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701833634; x=1702438434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MjSQU4WJdIdHd3sOhd+juFE8LrD0eIuwOH4A9w4NEcc=;
 b=Otxssjz5ReQuCB9JFd78Rse3WX6oGIDIgD9XRPTHGgKswnMCTkJiGaVs3RU23rndlx
 eMRdHlW4V8Uquc/GHjdM5PS7G7rZG2xdjCcLEK4Db85f3iZWg2IAWfj4BJOXLh+4K+ks
 zyiRSPoJFpO2Gq/jtug/aHUuIGGaryk2eQFIjIJ/J/vgg+9NAwasNYwAkmjmUEYLGarG
 WUJiXGimRvSXCWFdnGkDNOrwYDYJcyeObRdZSDZnWmbWLVXs3dCgt+CqYTRzjAR2JTdh
 0+RnCzygME2U1elb2oidvR0yqpieIFMu01CR+eUTa+zmV+tYhLtFpPevcAI0kl7YiVOR
 d30A==
X-Gm-Message-State: AOJu0YyST2qEGO7Bu1PXUEw4rFXza6MgL9vKeAPMZNrzAXkJGjfsGTBf
 Ls7/AOoe00y11w2JG3mkLHdiunDmlrhqfO3MzWgsL9JlAMp0DrQn0TQ5vyU2eqeUMpJQ0LJ1CSh
 9XOYDhReMBDRDLwBkimFBoypYkx6Xb+g=
X-Received: by 2002:a1f:d684:0:b0:4b2:dfc6:a081 with SMTP id
 n126-20020a1fd684000000b004b2dfc6a081mr129149vkg.5.1701833634116; 
 Tue, 05 Dec 2023 19:33:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgotLR5eEyFZuzn1PODAsgyzxJ/i0rHf2Bs9Yw58No30l2JPCLKy5+A/VDUFke8QdC9+x21Dl7nENTfn5JVGQ=
X-Received: by 2002:a1f:d684:0:b0:4b2:dfc6:a081 with SMTP id
 n126-20020a1fd684000000b004b2dfc6a081mr129142vkg.5.1701833633674; Tue, 05 Dec
 2023 19:33:53 -0800 (PST)
MIME-Version: 1.0
References: <20231113073239.270591-1-vivek.kasireddy@intel.com>
 <0e8ee2a6-c0b5-4edc-a616-1f6c3f00beaf@redhat.com>
In-Reply-To: <0e8ee2a6-c0b5-4edc-a616-1f6c3f00beaf@redhat.com>
From: YangHang Liu <yanghliu@redhat.com>
Date: Wed, 6 Dec 2023 11:33:42 +0800
Message-ID: <CAGYh1E8HKTY+GvDwQf+eJn8wW0yQ4RvhO_4AcV+-FshOq9kcMg@mail.gmail.com>
Subject: Re: [PATCH v1] target/i386/host-cpu: Use IOMMU addr width for
 passthrough devices on Intel platforms
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alex Williamson <alex.williamson@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>, Chao Yang <chayang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

After applying this patch, the Q35 + OVMF L2 VM with a igbvf will not
throw the error like:
[1]VFIO_MAP_DMA failed: Invalid argument.
[2]vfio_dma_map(0x560a1a64e3b0, 0x383000004000, 0x4000,
0x7fcfc4053000) =3D -22 (Invalid argument)

Tested-by: Yanghang Liu <yanghliu@redhat.com>





On Wed, Dec 6, 2023 at 2:08=E2=80=AFAM C=C3=A9dric Le Goater <clegoate@redh=
at.com> wrote:
>
> On 11/13/23 08:32, Vivek Kasireddy wrote:
> > A recent OVMF update has resulted in MMIO regions being placed at
> > the upper end of the physical address space. As a result, when a
> > Host device is passthrough'd to the Guest via VFIO, the following
> > mapping failures occur when VFIO tries to map the MMIO regions of
> > the device:
> > VFIO_MAP_DMA failed: Invalid argument
> > vfio_dma_map(0x557b2f2736d0, 0x380000000000, 0x1000000, 0x7f98ac400000)=
 =3D -22 (Invalid argument)
>
> OVMF and Seabios guests are impacted. Seabios 1.16.3 introduced
> the same change of the pci window placement.
>
> C.
>
> > The above failures are mainly seen on some Intel platforms where
> > the physical address width is larger than the Host's IOMMU
> > address width. In these cases, VFIO fails to map the MMIO regions
> > because the IOVAs would be larger than the IOMMU aperture regions.
> >
> > Therefore, one way to solve this problem would be to ensure that
> > cpu->phys_bits =3D <IOMMU phys_bits>
> > This can be done by parsing the IOMMU caps value from sysfs and
> > extracting the address width and using it to override the
> > phys_bits value as shown in this patch.
> >
> > Previous attempt at solving this issue in OVMF:
> > https://edk2.groups.io/g/devel/topic/102359124
> >
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Laszlo Ersek <lersek@redhat.com>
> > Cc: Dongwon Kim <dongwon.kim@intel.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   target/i386/host-cpu.c | 61 +++++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 60 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> > index 92ecb7254b..8326ec95bc 100644
> > --- a/target/i386/host-cpu.c
> > +++ b/target/i386/host-cpu.c
> > @@ -12,6 +12,8 @@
> >   #include "host-cpu.h"
> >   #include "qapi/error.h"
> >   #include "qemu/error-report.h"
> > +#include "qemu/config-file.h"
> > +#include "qemu/option.h"
> >   #include "sysemu/sysemu.h"
> >
> >   /* Note: Only safe for use on x86(-64) hosts */
> > @@ -51,11 +53,58 @@ static void host_cpu_enable_cpu_pm(X86CPU *cpu)
> >       env->features[FEAT_1_ECX] |=3D CPUID_EXT_MONITOR;
> >   }
> >
> > +static int intel_iommu_check(void *opaque, QemuOpts *opts, Error **err=
p)
> > +{
> > +    g_autofree char *dev_path =3D NULL, *iommu_path =3D NULL, *caps =
=3D NULL;
> > +    const char *driver =3D qemu_opt_get(opts, "driver");
> > +    const char *device =3D qemu_opt_get(opts, "host");
> > +    uint32_t *iommu_phys_bits =3D opaque;
> > +    struct stat st;
> > +    uint64_t iommu_caps;
> > +
> > +    /*
> > +     * Check if the user is passthroughing any devices via VFIO. We do=
n't
> > +     * have to limit phys_bits if there are no valid passthrough devic=
es.
> > +     */
> > +    if (g_strcmp0(driver, "vfio-pci") || !device) {
> > +        return 0;
> > +    }
> > +
> > +    dev_path =3D g_strdup_printf("/sys/bus/pci/devices/%s", device);
> > +    if (stat(dev_path, &st) < 0) {
> > +        return 0;
> > +    }
> > +
> > +    iommu_path =3D g_strdup_printf("%s/iommu/intel-iommu/cap", dev_pat=
h);
> > +    if (stat(iommu_path, &st) < 0) {
> > +        return 0;
> > +    }
> > +
> > +    if (g_file_get_contents(iommu_path, &caps, NULL, NULL)) {
> > +        if (sscanf(caps, "%lx", &iommu_caps) !=3D 1) {
> > +            return 0;
> > +        }
> > +        *iommu_phys_bits =3D ((iommu_caps >> 16) & 0x3f) + 1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static uint32_t host_iommu_phys_bits(void)
> > +{
> > +    uint32_t iommu_phys_bits =3D 0;
> > +
> > +    qemu_opts_foreach(qemu_find_opts("device"),
> > +                      intel_iommu_check, &iommu_phys_bits, NULL);
> > +    return iommu_phys_bits;
> > +}
> > +
> >   static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
> >   {
> >       uint32_t host_phys_bits =3D host_cpu_phys_bits();
> > +    uint32_t iommu_phys_bits =3D host_iommu_phys_bits();
> >       uint32_t phys_bits =3D cpu->phys_bits;
> > -    static bool warned;
> > +    static bool warned, warned2;
> >
> >       /*
> >        * Print a warning if the user set it to a value that's not the
> > @@ -78,6 +127,16 @@ static uint32_t host_cpu_adjust_phys_bits(X86CPU *c=
pu)
> >           }
> >       }
> >
> > +    if (iommu_phys_bits && phys_bits > iommu_phys_bits) {
> > +        phys_bits =3D iommu_phys_bits;
> > +        if (!warned2) {
> > +            warn_report("Using physical bits (%u)"
> > +                        " to prevent VFIO mapping failures",
> > +                        iommu_phys_bits);
> > +            warned2 =3D true;
> > +        }
> > +    }
> > +
> >       return phys_bits;
> >   }
> >
>
>


