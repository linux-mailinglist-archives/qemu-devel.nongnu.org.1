Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9077E26A8
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:24:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00WI-0007O9-Td; Mon, 06 Nov 2023 09:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r00WH-0007Ny-RD
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:24:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r00WF-0005vQ-QG
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699280639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3xwRKmAyatFee40klAmv/HGB8HGiZWGVeaKOzzWQ/s=;
 b=TY2JWzVgJR1NTMlB5SuEw/oyHjj8rkyuzd691nEVveDtld5W3RZe6MNtb8jWtJ++1+/Lrd
 Lxegeu7lEIinfvslVzP640RXcldPMIvAc2hGm5YROzuNbKL13q6vHBe/rZXWBu71ClBwje
 CYzqSlhe6V/Tt6f8L4cSqI8ci81Z03c=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-rgL_ekXSMNGWtjs7E2Jh3Q-1; Mon, 06 Nov 2023 09:23:57 -0500
X-MC-Unique: rgL_ekXSMNGWtjs7E2Jh3Q-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3b2e6189e6aso6940448b6e.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699280637; x=1699885437;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n3xwRKmAyatFee40klAmv/HGB8HGiZWGVeaKOzzWQ/s=;
 b=S5RI5oUqxNJx2fp7bxIPMMSeuqcrwg3oS8VRB4apFv7vMEdl9Hi+i+36Sxggn9olbK
 1avbOT3xHf6YzwhsK5qfvn/AWgo0s8vmza8D0jGRsMqejBwxPdcar0WPxXAHn08VQ/zf
 FY33Dx1UJrGjWq9S2KsJf4yxA/ntHhcJNtyl+eMgwr5CTzacrQjM4Sca/oy29JOL4y0t
 sAd+SJBpA59QEVj1rGb0Hrpr6wurzeMj4aCm3OMJvhsqPLv/mGpE7pjawFmz8I1IKS6l
 8MC8AHolcj/isWB38Qhked1pl3+JNo8EQXbzglLQQxH+JKQoutXtnINPLsv8wCjChAqb
 USeQ==
X-Gm-Message-State: AOJu0YyJKzIHNhiNZktsKnQhbUgyV5R+ytU+Vut7+t7aKP7b93QhBNJ8
 MCh0BKKLHo8cZC4EXmJZJxpEvEV11oLYRujyqYlbQ/DGRz+lROWmEthXBaKJYQuJSa971p7wXJm
 e6aazZAJ1TNImy1s=
X-Received: by 2002:aca:2202:0:b0:3a3:6329:4cb7 with SMTP id
 b2-20020aca2202000000b003a363294cb7mr31710963oic.9.1699280637170; 
 Mon, 06 Nov 2023 06:23:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8F+0eRKo5pL3tPOwair4uShUPdZCTn+RPtPknGHA6Cqb7hmzn/gQ/bPvJTcU7DN3GHk1tvw==
X-Received: by 2002:aca:2202:0:b0:3a3:6329:4cb7 with SMTP id
 b2-20020aca2202000000b003a363294cb7mr31710946oic.9.1699280636941; 
 Mon, 06 Nov 2023 06:23:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a05620a135100b007742ad3047asm3296097qkl.54.2023.11.06.06.23.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:23:56 -0800 (PST)
Message-ID: <cfff5924-2aa9-4741-adbb-2647a3549402@redhat.com>
Date: Mon, 6 Nov 2023 15:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/41] vfio: Adopt iommufd
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 11/2/23 08:12, Zhenzhong Duan wrote:
> Hi,
> 
> Thanks all for giving guides and comments on previous series, here is
> the v4 of pure iommufd support part.
> 
> Based on Cédric's suggestion, this series includes an effort to remove
> spapr code from container.c, now all spapr functions are moved to spapr.c
> or spapr_pci_vfio.c, but there are still a few trival check on
> VFIO_SPAPR_TCE_*_IOMMU which I am not sure if deserved to introduce many
> callbacks and duplicate code just to remove them. Some functions are moved
> to spapr.c instead of spapr_pci_vfio.c to avoid compile issue because
> spapr_pci_vfio.c is arch specific, or else we need to introduce stub
> functions to those spapr functions moved.
> 
> 
> PATCH 1-5: Move spapr functions to spapr*.c

PATCH 1-5 applied to vfio-next.

Thanks,

C.


