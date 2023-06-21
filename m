Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4FA737E22
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:14:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtu0-0004V1-Ai; Wed, 21 Jun 2023 05:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qBttz-0004Uq-5b
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qBttx-0004J5-85
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687338799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZ9ktT4Eh9F/iysuXReeZ/Zgb498YEJuY6y0yvrcOVk=;
 b=NSWJpUyFhyoimCstd//Q/hCCECrGwTdGQ2TQEY5xKFI2Yp/phDrMAzWCIKwNpKGe3mwfPo
 c1tGSfTscUQQzc4cqteFP6leIPSnMNiAytyF580wqjDqTUIbEQiAywgxESpEuYpvG82eH+
 UsV+sI0UEk3KGFLsLBimT2Baond9EgE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-CeWkMUtxP-6rOvP4cNUW_Q-1; Wed, 21 Jun 2023 05:13:15 -0400
X-MC-Unique: CeWkMUtxP-6rOvP4cNUW_Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f9068f47ceso82310655e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 02:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687338794; x=1689930794;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fZ9ktT4Eh9F/iysuXReeZ/Zgb498YEJuY6y0yvrcOVk=;
 b=PbkkL8hBottYzutbjM75JOcDZnrSozFmmgMPfHEdrgsvhhHvitwIj4us5SUvVxySbO
 NMr00yp+9nUwpbQ2WPk5gk8XSe04R65vMfJVl9KbK6GMmg/xe2R1So0O/YnoMsCxWDJo
 8V1lg7df26Txp3RUAbIgeDi/0ZHl63rjU7bgqjJ4ivCwDRxkJGyoWQ5dKwlHEMVyZKAF
 9TiBtv8S+50k13YJbDUkcYTrOiEjIr4JPKIM/9NwTuF3RZXSKK+nVaskNiDLK+x6Ir7t
 DgwwZIV/3mdNTVFDM49riaOx8ZWURgVyfTxHIX5Kd/Blr7b9lLDX02gdnC1kENHwW/TL
 bGVQ==
X-Gm-Message-State: AC+VfDyQ46K0/UW5m1Cno7BoRiM9lfaCa76cfew7ZY4r8eOJym4egXvZ
 ERHw+FdYGoop8oeSZ5GGS3sZrgc6nrz5y/raeTboyHGwc21a/IYi1jFxjkU9bMWhVE+YGBIGFSh
 62M6CLPSnVaV87/g=
X-Received: by 2002:a7b:ca4e:0:b0:3f9:c00:51d3 with SMTP id
 m14-20020a7bca4e000000b003f90c0051d3mr10017877wml.13.1687338794579; 
 Wed, 21 Jun 2023 02:13:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zSURX4iy4tyNa87bhFip7d7IgYZts5FPLXXfc4JStxY5ysKaGV5wIgLhTw7dchhuBVouokQ==
X-Received: by 2002:a7b:ca4e:0:b0:3f9:c00:51d3 with SMTP id
 m14-20020a7bca4e000000b003f90c0051d3mr10017857wml.13.1687338794211; 
 Wed, 21 Jun 2023 02:13:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:9c00:7978:3030:9d9a:1aef?
 (p200300cbc70b9c00797830309d9a1aef.dip0.t-ipconnect.de.
 [2003:cb:c70b:9c00:7978:3030:9d9a:1aef])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a056000114400b0030ae93bd196sm3958899wrx.21.2023.06.21.02.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 02:13:13 -0700 (PDT)
Message-ID: <13593b65-7df3-7ebc-0759-82c6731eb04b@redhat.com>
Date: Wed, 21 Jun 2023 11:13:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] tpm_crb: mark memory as protected
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 jasowang@redhat.com, mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, eric.auger@redhat.com,
 Peter Xu <peterx@redhat.com>
References: <20230620195054.23929-1-lvivier@redhat.com>
 <20230620195054.23929-3-lvivier@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230620195054.23929-3-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 20.06.23 21:50, Laurent Vivier wrote:
> This memory is not correctly aligned and cannot be registered
> by vDPA and VFIO.
> 
> An error is reported for vhost-vdpa case:
> qemu-kvm: vhost_vdpa_listener_region_add received unaligned region
> 
> To make it ignored by VFIO and vDPA devices, mark it as RAM_PROTECTED.

So, VFIO will simply skip these sections via 
vfio_listener_valid_section() I guess.

Yes, it will report an error but it will happily continue.

So regarding vDPA, we're also only concerned about removing the reported 
error, everything else works as expected?

-- 
Cheers,

David / dhildenb


