Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2997FC00D
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 18:12:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r81by-00072O-4b; Tue, 28 Nov 2023 12:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r81bv-000728-EI
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 12:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r81bs-0004aR-C5
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 12:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701191453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EiI5JhTMyZJmV0cR3yos+uj0NmIWu1JI7YhhqiLki7w=;
 b=A951riYa38ZrnDyKo9ga3v4mPJQv6BQC2EziWTTV0OVCSuItANCBE2UFTSWLTS94CbUPzV
 yt3umwkmZx4gZAsjRmP9trraf2chrnj2NKAcXG98WyTsUI8A7FPCPH5HMXcH2K9QQsGm95
 XMJi2DIINCfxFiiSpfVRkx9RtSWIRkg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-VzS_TrGkPeGQGScrGg0qCg-1; Tue, 28 Nov 2023 12:10:51 -0500
X-MC-Unique: VzS_TrGkPeGQGScrGg0qCg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-67a1d6648d9so51404806d6.3
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 09:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701191451; x=1701796251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EiI5JhTMyZJmV0cR3yos+uj0NmIWu1JI7YhhqiLki7w=;
 b=nekt9FuuXBBUz9uVZDs+VOZuh6SgwjpwJ9+QYQJJ2j9EF4uMgFqhzDREQ7LL/owXIR
 KnqnDV0R6AJtdkIU/QD7o5qFIUQsxe3HAt4Whw3CTxd3M7MhQHvTmF6CV1uIHdfUb5lb
 D46ZOrOEyGJ6Wq1iEHhBKUjH0mSLV2bfoqlGcZ9gpfQWqZquJ72ujXCqbcr0l10iRIXS
 sNITB+cjpp7HgS9MnKD1UmjwIWZu1/R7illR/ewnLxrLTC18TLqX2fmWuf9R7s+QKycH
 1m934uLxSZwSvn8m3ZpWQXn7mTq4UkHCy5vZmt0MNqq/TayPIOPjMbnegYMoceVgqFuU
 BthA==
X-Gm-Message-State: AOJu0Yw8f3jC9vpzJ9F+ACSDic3ernTX1bD6BfQT6N/MuZMRy40QEGiC
 Pnw7d+q9x5HPlqyu0iD2V0RJbPS8tzs9xApGp3n4mMHXY/SeKuVv8E+5EfPeU58F9QYX/Qbf4Et
 a6bSQTEqNbMzWhYQ=
X-Received: by 2002:ad4:4582:0:b0:67a:2c28:ce06 with SMTP id
 x2-20020ad44582000000b0067a2c28ce06mr10266327qvu.63.1701191451011; 
 Tue, 28 Nov 2023 09:10:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyyS4ZvL3PtoRux2tHOA2UBeb7DOY6qOVGSDNxSK5KNxAhHwJm3Keg1r6OVVqGJonttZX2xg==
X-Received: by 2002:ad4:4582:0:b0:67a:2c28:ce06 with SMTP id
 x2-20020ad44582000000b0067a2c28ce06mr10266310qvu.63.1701191450754; 
 Tue, 28 Nov 2023 09:10:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 mk13-20020a056214580d00b0067a1fcbecd2sm3950456qvb.50.2023.11.28.09.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 09:10:50 -0800 (PST)
Message-ID: <e3c75e69-c634-426e-9fe2-77059ca8292d@redhat.com>
Date: Tue, 28 Nov 2023 18:10:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/27] vfio: Adopt iommufd
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/21/23 09:43, Zhenzhong Duan wrote:
> Hi,
> 
> Thanks all for giving guides and comments on previous series, this is
> the remaining part of the iommufd support.
> 
> Besides suggested changes in v6, I'd like to highlight two changes
> for final review:
> 1. Instantiate can_be_deleted callback to fix race where iommufd object
>     can be deleted before vfio device
> 2. After careful re-thinking, I'd like to follow Nicolin's suggestion in v5,
>     remove is_ioas check which indeed looks heavy just for tracepoint.
>     In fact we can get corresponding info by looking over trace context.
> 
> PATCH 1: Introduce iommufd object
> PATCH 2-9: add IOMMUFD container and cdev support
> PATCH 10-17: fd passing for cdev and linking to IOMMUFD
> PATCH 18: make VFIOContainerBase parameter const
> PATCH 19-21: Compile out for IOMMUFD for arm, s390x and x86
> PATCH 22-26: vfio device init code cleanup
> PATCH 27: add iommufd doc



Applied to vfio-next.

Thanks,

C.




