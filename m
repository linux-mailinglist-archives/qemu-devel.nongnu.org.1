Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2332A7FF3B9
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 16:38:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8j6w-0004Qz-7N; Thu, 30 Nov 2023 10:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r8j6u-0004Px-K8
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 10:37:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r8j6s-000641-KW
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 10:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701358669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6qoZeizOrIoX5+IEVB6SrzIu+Yq/+LhpB6CYJwRTltI=;
 b=Jr4HKpX4JzEM7uvB3IK2WCWJ2oJiV/ck2oiivD1t3dW3swpsQI1a0peeBGAZuE981W9cdr
 8xfYRr/qpjEf3SomuwvSZ5j//sjcnX7bgoidVXVpg12/PxHijw9kXawN579ynxTBpfMEwi
 BK+tV1MOcZdjF2FCTm8k9AaF/LIi52c=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-1uqivsOnMFqZ9Lef-dtdvQ-1; Thu, 30 Nov 2023 10:37:47 -0500
X-MC-Unique: 1uqivsOnMFqZ9Lef-dtdvQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6d64f85d4d4so1066053a34.1
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 07:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701358667; x=1701963467;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6qoZeizOrIoX5+IEVB6SrzIu+Yq/+LhpB6CYJwRTltI=;
 b=TCEQh08DE+MOv+wl3mdYtv46z9H2g+r1N2PILa0q7ABZdl95FpL2Lq4wY8isLwAR9C
 j9I9Vum9I8O/KnHeGAiWlftBkOI0UbWOkpdv/WUEii0JyWLAONVKYurPMgV3HbgX9MBw
 uiZ0aXCI348eb9bP2cSeIK0EQCHlLrvkLoKnyDkFWftAWe+shH7m51fmiIhKHZ6EYVTu
 5bdflyHE/RHhUL91OpcWGiE9n09TuEdRbvWanNoDsVqtxY5mr7oHgglYPymod/l2TKMu
 IWr0CwBUmSfaMRBRl2RclUnSAGp+CPpTwXBvcs9QYkwOu64HEhDHNMXfJh4A6tOe/yGD
 UWEA==
X-Gm-Message-State: AOJu0Yyqz6rc4IohPlZwyEWflOdVI5oy6xcOuQOuUX+G+7G/KnTuWGRr
 RHgWSh3qqoW0EXti/sL9bJFcgjmlYMsb2NFmUIJ4nMYJRROY/oiyVdKRoPCbZfTQf7Kf8qeVlFa
 7IK9QBqncyMstx8U=
X-Received: by 2002:a9d:5c0f:0:b0:6d6:441a:a6c with SMTP id
 o15-20020a9d5c0f000000b006d6441a0a6cmr22802173otk.12.1701358667118; 
 Thu, 30 Nov 2023 07:37:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGmtPfsIsmjEJzuYoRjR8LKtSFGFpkyhmshhXm4mO202bsSMBbKgWPNIRpYOq47L6mJreS2Q==
X-Received: by 2002:a9d:5c0f:0:b0:6d6:441a:a6c with SMTP id
 o15-20020a9d5c0f000000b006d6441a0a6cmr22802159otk.12.1701358666888; 
 Thu, 30 Nov 2023 07:37:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 lf10-20020a0562142cca00b0067a864a9391sm480137qvb.13.2023.11.30.07.37.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 07:37:46 -0800 (PST)
Message-ID: <1d43153f-215a-4e2f-810f-553e4192c27f@redhat.com>
Date: Thu, 30 Nov 2023 16:37:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pcie_sriov: Remove g_new assertion
Content-Language: en-US
To: YangHang Liu <yanghliu@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231123075630.12057-1-akihiko.odaki@daynix.com>
 <53966853-640a-4581-a08d-8b452afc4c2a@redhat.com>
 <CAGYh1E-4fiF+Y0JBKPRwJNbuJzdJuWnR6yA-eNLBjW9++xov3w@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <CAGYh1E-4fiF+Y0JBKPRwJNbuJzdJuWnR6yA-eNLBjW9++xov3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/30/23 10:52, YangHang Liu wrote:
> After applying this patch, the VM with a igbvf will not crash during reboot.
> 
> Tested-by: Yanghang Liu<yanghliu@redhat.com <mailto:yanghliu@redhat.com>>

Michael, do you have plans to send a PR for -rc3 ?

Thanks,

C.



> 
> On Mon, Nov 27, 2023 at 5:12 PM Cédric Le Goater <clg@redhat.com <mailto:clg@redhat.com>> wrote:
> 
>     On 11/23/23 08:56, Akihiko Odaki wrote:
>      > g_new() aborts if the allocation fails so it returns NULL only if the
>      > requested allocation size is zero. register_vfs() makes such an
>      > allocation if NumVFs is zero so it should not assert that g_new()
>      > returns a non-NULL value.
>      >
>      > Fixes: 7c0fa8dff8 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
>      > Buglink: https://issues.redhat.com/browse/RHEL-17209 <https://issues.redhat.com/browse/RHEL-17209>
>      > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>>
> 
> 
>     Reviewed-by: Cédric Le Goater <clg@redhat.com <mailto:clg@redhat.com>>
> 
>     Thanks,
> 
>     C.
> 
> 
>      > ---
>      >   hw/pci/pcie_sriov.c | 1 -
>      >   1 file changed, 1 deletion(-)
>      >
>      > diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>      > index 5ef8950940..a1fe65f5d8 100644
>      > --- a/hw/pci/pcie_sriov.c
>      > +++ b/hw/pci/pcie_sriov.c
>      > @@ -178,7 +178,6 @@ static void register_vfs(PCIDevice *dev)
>      >       num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>      >
>      >       dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
>      > -    assert(dev->exp.sriov_pf.vf);
>      >
>      >       trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
>      >                                PCI_FUNC(dev->devfn), num_vfs);
> 
> 


