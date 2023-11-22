Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04E7F3FA5
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 09:07:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5iG4-0007uH-GX; Wed, 22 Nov 2023 03:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r5iG2-0007tB-H2
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 03:06:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r5iG0-0008CN-EZ
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 03:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700640405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=peZR1nnPDD3wp4PjtV3unl51rOjOZlWVnxf2qMfUne4=;
 b=QVjvslGePvnnltSaSJDOws9uO1A4ySPOXRMWB9xp8xzt9/xInjfnbdQPqy5RBoDyMJHheA
 M/4xxMs8iYpKybAs5xMS/h59qWWRpefXenmAKImmrvn0K4zDJaEv/CByV74YOp2faVze49
 6QWKwvDJfJdEB4mAsUXTmIkeWLFm/Dg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-XPfwJjZ2Pi-R_luvY-7T8g-1; Wed, 22 Nov 2023 03:06:42 -0500
X-MC-Unique: XPfwJjZ2Pi-R_luvY-7T8g-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5c87663a873so73059107b3.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 00:06:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700640402; x=1701245202;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=peZR1nnPDD3wp4PjtV3unl51rOjOZlWVnxf2qMfUne4=;
 b=MXvcQDklpGcuHYaHoIQbALKrGh7NX90Go3PF2KQzCWYRhFyDu7B3gq0Vdkts0gVWnp
 m/Jkf/1yEwQmKU05jwO2m8s0lS6Bn6F42bIbWbf604PdAtbMjQRDCYcP36x9r7fWgCvN
 lxnrmUbxZom29kqCwUzwj6u1OrD1lvEiBa1ey12+SKWAv7MYE0UU+AseJWd/OZ3rJK51
 2KreB0zgZ4uqLP7vaZlhnlUPXF3Vch1lmVhTDreTkEpN227mU97BGjvZ/XFvxwWIUKCf
 EPLgj0wXyzkJplAJI1BoYd47In/EgN1WMU47Qr81HWhH/b3uJa2YJL2B83q/pEBSE9tB
 2a/Q==
X-Gm-Message-State: AOJu0YwpLinmg/BU8mFLr7iPoGTvGi8h8xitojlbr1zRTeByd4oj6BVX
 Bah5+zL+P45o+G/TVHmWDPQ1H0IuPoUyGMGim1iUwhP9RnlXZ/Ue0WW4Ni7ixfUgD6LOn8U3PN0
 WLTMU4jcxrOoXELE=
X-Received: by 2002:a25:d614:0:b0:db0:2161:5950 with SMTP id
 n20-20020a25d614000000b00db021615950mr1427100ybg.63.1700640402246; 
 Wed, 22 Nov 2023 00:06:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFatHhaieqNyagbeWw1JTvEf6XfjhY3MJV8bSpHAWBNNqgWOou9Cf/piz1mUWqe6D46rHYWog==
X-Received: by 2002:a25:d614:0:b0:db0:2161:5950 with SMTP id
 n20-20020a25d614000000b00db021615950mr1427096ybg.63.1700640401971; 
 Wed, 22 Nov 2023 00:06:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a0cd64f000000b0067266b7b903sm4675913qvj.5.2023.11.22.00.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 00:06:41 -0800 (PST)
Message-ID: <365127fc-b161-4947-845d-cead7fa2e399@redhat.com>
Date: Wed, 22 Nov 2023 09:06:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/27] vfio: Adopt iommufd
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Thomas Huth <thuth@redhat.com>
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
 <182862f2-d339-4cba-aacf-bab06868272c@redhat.com>
 <SJ0PR11MB67449AA8E37A7CCCEF0B54CC92BAA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67449AA8E37A7CCCEF0B54CC92BAA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


>> The series is pushed on top of vfio-next in the vfio-8.2 tree :
>>
>>    https://github.com/legoater/qemu/commits/vfio-8.2
>>
>> with a little extra to deal with a PPC build failure.
> 
> Thanks Cédric. That's strange I didn't see this failure on my env
> which has CONFIG_VFIO_PCI enabled by default for PPC.


The compile issue shows with --without-default-devices.

VFIO is always selected (see ppc/Kconfig) but VFIO_PCI is not when
--without-default-devices is used. Hence the compile failure because
of the common vfio-pci routines exported in pci.c.

Ideally, we should use an 'imply VFIO' in ppc/Kconfig because VFIO
is not a required subsystem for the pseries machine. If that was
the case, we wouldn't compile the VFIO EEH hooks defined in
hw/ppc/spapr_pci_vfio.c :

   bool spapr_phb_eeh_available(SpaprPhbState *sphb);
   int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
                                     unsigned int addr, int option);
   int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state);
   int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option);
   int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
   void spapr_phb_vfio_reset(DeviceState *qdev);

It is not that simple to fix. The simpler approach is to force compile
of VFIO PCI in ppc/Kconfig with a 'select VFIO_PCI'. we should improve
that.

Thanks,

C.



