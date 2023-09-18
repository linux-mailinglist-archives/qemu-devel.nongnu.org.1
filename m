Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B017A498B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 14:25:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiDIP-0005G2-Ul; Mon, 18 Sep 2023 08:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qiDIE-0005FL-R8
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qiDID-0005Ij-5Y
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695039834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LPkOWd5y+dwa7xFdgbS6Xaapp4J1zzAFM/5/pE6fYGE=;
 b=ED1cPos/P3+5jYVH+u2CAJo/i+/9gTDfDSX1aMXcEXxJpHB1UGRmWhnSZ+wu8DUcdBE8sP
 rX7WHIEvMSlNVb252nPoATvqvcTdCYZxj3lKScoiOczGhJHNJZfBG4quLUl2AemuHEgkav
 SASyzbThhr/wstapvLuBVctkc01gngs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-41EdjAmMPp6BSW_6uO3nvQ-1; Mon, 18 Sep 2023 08:23:52 -0400
X-MC-Unique: 41EdjAmMPp6BSW_6uO3nvQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-412190efed6so55932901cf.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 05:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695039832; x=1695644632;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LPkOWd5y+dwa7xFdgbS6Xaapp4J1zzAFM/5/pE6fYGE=;
 b=pQINQ6sptph+Va0xaSq1jEB5GxFNEZgyYA1Nx+Avl0vVEzuvTSzLV8DNRXUaei7xGs
 ki1PyB4SFzapQQJbkToCJ251tb3jsadfy0qJVsJEWHl6uRcqGl1+c6m8r2rrV3ntAPq9
 hz5JdvJTG4B8LRy/cNe2Eovbd75viN65nqW4HPAWsS1qjGrCzUJsoEYPUjhrQX1gjO2P
 sSNQCYH/o2LoPSlQ6uNiCIlcn3mSYAPESBYj900pr9gICasym4NIW5sc/HaJUFQozmnu
 YyCCv6gbxcvxs2nPc/12yfgnrRimYajJ9XTSV8ro7RIcyfBjPKaX8KUPIn//2MRzZslU
 oi3g==
X-Gm-Message-State: AOJu0YzaH/QlKLffUhs1dqPTEtJt8K+v/ZTQJqWe/oYvTGJDHJv6xRMW
 IYzE7WCKU3GW4HWk1xhYIkpnmnSXZeV8D3VmOh7UrOPYX2uTaPYK5L0FbiFTGctI006MDppa+AZ
 41FNgqbx678pJbWI=
X-Received: by 2002:a05:622a:1aa5:b0:417:8ee1:8f6c with SMTP id
 s37-20020a05622a1aa500b004178ee18f6cmr11208673qtc.47.1695039832381; 
 Mon, 18 Sep 2023 05:23:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGke8bKgbXmW1ethejVFRSMpuraqd4uZAeaSDPxklCbot/DL2f7bEznY8+7EJgOOzG0Td3yNQ==
X-Received: by 2002:a05:622a:1aa5:b0:417:8ee1:8f6c with SMTP id
 s37-20020a05622a1aa500b004178ee18f6cmr11208657qtc.47.1695039832179; 
 Mon, 18 Sep 2023 05:23:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 p16-20020ac84610000000b0041096c33d02sm2955124qtn.17.2023.09.18.05.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 05:23:51 -0700 (PDT)
Message-ID: <23357353-2c20-e704-dc24-ccbac2c37f98@redhat.com>
Date: Mon, 18 Sep 2023 14:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 00/22] vfio: Adopt iommufd
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 eric.auger@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 chao.p.peng@intel.com
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <62367cc3-20e9-f533-5f74-2dc3cba702ce@redhat.com>
 <20230918115153.GA13733@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230918115153.GA13733@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/18/23 13:51, Jason Gunthorpe wrote:
> On Fri, Sep 15, 2023 at 02:42:48PM +0200, Cédric Le Goater wrote:
>> On 8/30/23 12:37, Zhenzhong Duan wrote:
>>> Hi All,
>>>
>>> As the kernel side iommufd cdev and hot reset feature have been queued,
>>> also hwpt alloc has been added in Jason's for_next branch [1], I'd like
>>> to update a new version matching kernel side update and with rfc flag
>>> removed. Qemu code can be found at [2], look forward more comments!
>>
>> FYI, I have started cleaning up the VFIO support in QEMU PPC. First
>> is the removal of nvlink2, which was dropped from the kernel 2.5 years
>> ago. Next is probably removal of all the PPC bits in VFIO. Code is
>> bitrotting and AFAICT VFIO has been broken on these platforms since
>> 5.18 or so.
> 
> It was fixed since then - at least one company (not IBM) still cares
> about vfio on ppc, though I think it is for a DPDK use case not VFIO.

Indeed.
I just checked on a POWER9 box running a debian sid (6.4) and device
assignment of a simple NIC (e1000e) in a ubuntu 23.04 guest worked
correctly. Using a 6.6-rc1 on the host worked also. One improvement
would be to reflect in the Kconfig files that CONFIG_IOMMUFD is not
supported on PPC so that it can not be selected.

Thanks,

C.


