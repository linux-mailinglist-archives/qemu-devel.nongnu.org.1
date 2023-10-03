Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9558E7B69A1
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qney9-0006af-LR; Tue, 03 Oct 2023 08:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qney6-0006a8-1b
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qney2-0005Si-FA
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696337856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+18KoJo0hjBpxEBABbzWRmC0iKfSd2Bit05hdEDUubk=;
 b=enil+biYAIpZ7K1AG5ubTNBZXikI6BmIV7V5nrIiylLFK4LZttkS+A6RJwxsWjcvrgC+mh
 gRDukA7m0FIrKM32m9Fbix2c0XJ0xwcJtWQHKaUR0iUsiGA49na7C1IOkZdDLxEBBx8Zsv
 WZxGXvKM5Ezhrn+mOHwb0NpV78HMk9Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-C5wx94YxMFiFwweENL6jxA-1; Tue, 03 Oct 2023 08:57:35 -0400
X-MC-Unique: C5wx94YxMFiFwweENL6jxA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4059475c174so7172055e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696337854; x=1696942654;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+18KoJo0hjBpxEBABbzWRmC0iKfSd2Bit05hdEDUubk=;
 b=tCyga7vk05Cds014qYv5k9TbpDzePDslbZWUhYTAoL1eBEJe2wLG6+d3BeiBEgs1qM
 0T94z8jfjQUfxBRpnx3ceuFE/j9AWol2NfybGaVcMgwjDaCAPEKdSypHysSmDNkItUxm
 0i//iP0Z/ZZKwSDMsbT2oovLXXLqD56OM39ydIkC5k4wcmB2PJnLCyaq3Svg4HuGped9
 1EmS2haMbNZRX84spAj4mgJOph3RgMXKY0cOWWWOe+5BlYkqCjWsyjcTjrIDTl7E0O20
 2FJ3V+jA36WLdIw6Rx+AgP/GcrEepdaFrla8moMrsqH9Igsb9Tzyv6QDD/mK3gX6A5sI
 s1ZQ==
X-Gm-Message-State: AOJu0YyI5L1AGrUVJJXXiJywNmGLORcWXWX4srlNuQvqC56hFS+bcbNg
 nav1ukG1/STd7iJ9TzFqrsrfItShK5c6UW++HOAQW9hcDyGNVwN1/Yoho0OGMTyEOHpGO6t0yXq
 AgO15PJlYDE1IKS0=
X-Received: by 2002:a7b:cc15:0:b0:405:499a:7fc1 with SMTP id
 f21-20020a7bcc15000000b00405499a7fc1mr13431005wmh.40.1696337854001; 
 Tue, 03 Oct 2023 05:57:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5ZdnN4CZ73I2itg2r6+8Pdjhyyad5Rh8jVgUE2uyTdUKD0glxVY1en8riGy6n5jL88ivWyA==
X-Received: by 2002:a7b:cc15:0:b0:405:499a:7fc1 with SMTP id
 f21-20020a7bcc15000000b00405499a7fc1mr13430986wmh.40.1696337853583; 
 Tue, 03 Oct 2023 05:57:33 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 z20-20020a7bc7d4000000b004064e3b94afsm9428262wmk.4.2023.10.03.05.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 05:57:32 -0700 (PDT)
Date: Tue, 3 Oct 2023 08:57:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v4 21/21] i386: Add new property to control L2 cache topo
 in CPUID.04H
Message-ID: <20231003085516-mutt-send-email-mst@kernel.org>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
 <20230914072159.1177582-22-zhao1.liu@linux.intel.com>
 <75ea5477-ca1b-7016-273c-abd6c36f4be4@linaro.org>
 <ZQQNddiCky/cImAz@liuzhao-OptiPlex-7080>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQQNddiCky/cImAz@liuzhao-OptiPlex-7080>
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

On Fri, Sep 15, 2023 at 03:53:25PM +0800, Zhao Liu wrote:
> Hi Philippe,
> 
> On Thu, Sep 14, 2023 at 09:41:30AM +0200, Philippe Mathieu-Daudé wrote:
> > Date: Thu, 14 Sep 2023 09:41:30 +0200
> > From: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Subject: Re: [PATCH v4 21/21] i386: Add new property to control L2 cache
> >  topo in CPUID.04H
> > 
> > On 14/9/23 09:21, Zhao Liu wrote:
> > > From: Zhao Liu <zhao1.liu@intel.com>
> > > 
> > > The property x-l2-cache-topo will be used to change the L2 cache
> > > topology in CPUID.04H.
> > > 
> > > Now it allows user to set the L2 cache is shared in core level or
> > > cluster level.
> > > 
> > > If user passes "-cpu x-l2-cache-topo=[core|cluster]" then older L2 cache
> > > topology will be overrode by the new topology setting.
> > > 
> > > Here we expose to user "cluster" instead of "module", to be consistent
> > > with "cluster-id" naming.
> > > 
> > > Since CPUID.04H is used by intel CPUs, this property is available on
> > > intel CPUs as for now.
> > > 
> > > When necessary, it can be extended to CPUID.8000001DH for AMD CPUs.
> > > 
> > > (Tested the cache topology in CPUID[0x04] leaf with "x-l2-cache-topo=[
> > > core|cluster]", and tested the live migration between the QEMUs w/ &
> > > w/o this patch series.)
> > > 
> > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> > > ---
> > > Changes since v3:
> > >   * Add description about test for live migration compatibility. (Babu)
> > > 
> > > Changes since v1:
> > >   * Rename MODULE branch to CPU_TOPO_LEVEL_MODULE to match the previous
> > >     renaming changes.
> > > ---
> > >   target/i386/cpu.c | 34 +++++++++++++++++++++++++++++++++-
> > >   target/i386/cpu.h |  2 ++
> > >   2 files changed, 35 insertions(+), 1 deletion(-)
> > 
> > 
> > > @@ -8079,6 +8110,7 @@ static Property x86_cpu_properties[] = {
> > >                        false),
> > >       DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
> > >                        true),
> > > +    DEFINE_PROP_STRING("x-l2-cache-topo", X86CPU, l2_cache_topo_level),
> > 
> > We use the 'x-' prefix for unstable features, is it the case here?
> 
> I thought that if we can have a more general CLI way to define cache
> topology in the future, then this option can be removed.
> 
> I'm not sure if this option could be treated as unstable, what do you
> think?
> 
> 
> Thanks,
> Zhao

Then, please work on this new generic thing.
What we don't want is people relying on unstable options.

> > 
> > >       DEFINE_PROP_END_OF_LIST()
> > >   };
> > 


