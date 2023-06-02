Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1537203F3
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:04:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q55MK-00078T-CV; Fri, 02 Jun 2023 10:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q55MI-00077p-Bt
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:02:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q55MG-0001OS-MT
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:02:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f6e13940daso21135315e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685714543; x=1688306543;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q3+2nxWKhEybZJVxTpVZkSmqT+Hw2pMNAqpuveaFq5Y=;
 b=tN2se5egujkm+U1Xayu2Hq+MOla9rTRvSkU99Nt9FwLp9m8QSMmZc8NgFICM/L4Lgi
 bqsAXcWxdjCzMhkH4mX2OtX8bkqvEFCiEfYx48Lx1+Kra4AV2KXxjr57jrUgAPH5IzO+
 MuFh/8tGYajTQ7TNHCrJCrnGrXusvE1rMTmAOvOAgR/W8ZvS4WF7rwCLnd7/6LxG4SI0
 iYXKE1lNrrV1aUXOyurP6JB5iyBsW3CRZ4qDbp3qyxZ1/T1a/WMdTQ8U00a1kBiJ5XGK
 VaPVf2vjRwqtTFKxGmE8gH9w8lSdmoPLBzPPu4L0XW1+ST+FDRBwz9kxtZogzPLGMSFk
 DZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685714543; x=1688306543;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3+2nxWKhEybZJVxTpVZkSmqT+Hw2pMNAqpuveaFq5Y=;
 b=f9/dT+tCRZ8KsTUbi/gg4xw3xkLuDYx1/NxdobDKNE9I/FX3H4DHeVDVnU8Ednr3lM
 ULQIVfsZ1fYWN8FLkbjLuPWX3Fzbx+7hRuOGIFW5c+Bt/hGg7JhThUxRBh/w6x633mRo
 JeMcXiyfY/0nOYx86y6ePxgmdGFOpV6nNSh32SSHwYuCJwj7AVSlwNK8lhmyzosQP8J2
 DCb7rulTzuPBmEx5vi8yOmg8tarhJsqLM5GiGTUv5lu1TIrtj8EfROitGp5GkTYBg2Bs
 CXQgA1nTsCMz4HSXtK6PXAUrAY64bibQjq7zlb4sSILZUMihYeKTJSExdoN7TwwMNMA8
 GvOg==
X-Gm-Message-State: AC+VfDwfxJOuOLK/72ya6fjEZJQjYNYdnHeGcade7jHYU1PV0cFLBOdj
 UZMOhaK/pn1HeVKrhwmfYmvJQg==
X-Google-Smtp-Source: ACHHUZ69MtFeTrQWYZJ2hQRTVixcEs54D1oF2y5Zoa609cjcxDh92fElG+aLaH0h+PHRCeUIRAVybw==
X-Received: by 2002:a5d:4eca:0:b0:306:3f97:4847 with SMTP id
 s10-20020a5d4eca000000b003063f974847mr27168wrv.65.1685714543104; 
 Fri, 02 Jun 2023 07:02:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 w16-20020adfd4d0000000b0030aefa3a957sm1801142wrk.28.2023.06.02.07.02.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 07:02:22 -0700 (PDT)
Message-ID: <6b9b825a-53c9-52d9-c74b-443089d7eb85@linaro.org>
Date: Fri, 2 Jun 2023 16:02:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 0/4] vfio/pci: Atomic Ops completer support
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: mst@redhat.com, Robin Voetter <robin@streamhpc.com>,
 Alex Williamson <alex.williamson@redhat.com>, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org, clg@redhat.com
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
 <4301d6f4-a394-02e3-4773-823976b2e593@streamhpc.com>
 <20230531162446.2bc9a26c.alex.williamson@redhat.com>
 <806908a3-11a8-7d17-e13f-8f516bf43744@linaro.org>
In-Reply-To: <806908a3-11a8-7d17-e13f-8f516bf43744@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Markus, Marc-André,

> On 1/6/23 00:24, Alex Williamson wrote:
>> Policy decisions like that are generally left to management tools, so
>> there would always be a means to enable or disable the feature.  In
>> fact, that's specifically why I test that the Atomic Op completer bits
>> are unset in the root port before changing them so that this automatic
>> enablement could live alongside a command line option to statically
>> enable some bits.
>>
>> That does however remind me that it is often good with these sorts of
>> "clever" automatic features to have an opt-out, so I'll likely add an
>> x-no-rp-atomics device option in the next version to provide that.

Still thinking about this series I remembered since commit a3c45b3e62
("qapi: New special feature flag "unstable"") the "x-" prefix is
obsolete (superseded) in QAPI generated code.

I wonder about device properties:

$ git grep -F '"x-' hw | wc -l
      130

$ git grep -F '"x-' hw/vfio/pci.c
hw/vfio/pci.c:2987:        error_setg(errp, "x-balloon-allowed only 
potentially compatible "
hw/vfio/pci.c:3335: 
DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
hw/vfio/pci.c:3342:    DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", 
VFIOPCIDevice,
hw/vfio/pci.c:3344:    DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
hw/vfio/pci.c:3346:    DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
hw/vfio/pci.c:3348:    DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, 
features,
hw/vfio/pci.c:3350:    DEFINE_PROP_BOOL("x-enable-migration", VFIOPCIDevice,
hw/vfio/pci.c:3352:    DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, 
vbasedev.no_mmap, false),
hw/vfio/pci.c:3353:    DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
hw/vfio/pci.c:3355:    DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, 
no_kvm_intx, false),
hw/vfio/pci.c:3356:    DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, 
no_kvm_msi, false),
hw/vfio/pci.c:3357:    DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, 
no_kvm_msix, false),
hw/vfio/pci.c:3358:    DEFINE_PROP_BOOL("x-no-geforce-quirks", 
VFIOPCIDevice,
hw/vfio/pci.c:3360:    DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", 
VFIOPCIDevice, no_kvm_ioeventfd,
hw/vfio/pci.c:3362:    DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", 
VFIOPCIDevice, no_vfio_ioeventfd,
hw/vfio/pci.c:3364:    DEFINE_PROP_UINT32("x-pci-vendor-id", 
VFIOPCIDevice, vendor_id, PCI_ANY_ID),
hw/vfio/pci.c:3365:    DEFINE_PROP_UINT32("x-pci-device-id", 
VFIOPCIDevice, device_id, PCI_ANY_ID),
hw/vfio/pci.c:3366:    DEFINE_PROP_UINT32("x-pci-sub-vendor-id", 
VFIOPCIDevice,
hw/vfio/pci.c:3368:    DEFINE_PROP_UINT32("x-pci-sub-device-id", 
VFIOPCIDevice,
hw/vfio/pci.c:3370:    DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, 
igd_gms, 0),
hw/vfio/pci.c:3371: 
DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
hw/vfio/pci.c:3374:    DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", 
VFIOPCIDevice, msix_relo,

Is there a plan to use something similar for QOM properties?
Is it OK to keep using the "x-" prefix there?

Thanks,

Phil.

