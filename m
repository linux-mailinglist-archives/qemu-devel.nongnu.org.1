Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5087572A558
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 23:27:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7jcb-0006zT-Hk; Fri, 09 Jun 2023 17:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7jcZ-0006zB-GN
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 17:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7jcX-0008VK-5U
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 17:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686345968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5XA0v/Gcxpv6/a9edqzJDfMkpgPv2+sNI4m1jY1HPEU=;
 b=Wedn2HiP47Qz4fov2t7iiUY3m4+KPsbGIi+JQFacBBjZxK++ozLVdnJZWwChQrp9QxKfLS
 3NpbD2MwsGvZaMeQA5TuI11Z41hZhxxLm6omuJJUw/WrhPTl6Kc3cZUUgreOWxk2XBZZ1/
 BTYzAeIouBU+pTA6W/R7Q3HPvZzP3b0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-moi2gjSPPPSQuDc-smQ4AA-1; Fri, 09 Jun 2023 17:26:06 -0400
X-MC-Unique: moi2gjSPPPSQuDc-smQ4AA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75b337f2504so49490585a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 14:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686345966; x=1688937966;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XA0v/Gcxpv6/a9edqzJDfMkpgPv2+sNI4m1jY1HPEU=;
 b=PyADoat8uBnEUN1MK3vADP/vkTpBCqpBctsIeMPAe9f3jnZCLz5D/a8uQ30YTrh9nD
 5sYabFnd2tdpGf8jfwKHUcbx6ZRngJqj2LIGpdQgOSfdckIN8YeLGJleldNis6pIDiCC
 /8QQb2zAAQ96WrlnNJVcm+BF1MTu4HQ1cw1UxsoByv5wNJKwV+X3EM9cj/J43USU1kfM
 erstW9lcmeDKG9MnMvISyOrFVspMGIAzya408dPQ/JY7qCOA1FtJgL9PycixI5cb2SDu
 Y59QNMTefvMhieyrLyQ2dZEFauA/wkNVMeIR4Tl2JDFKwdoljXj4TuwZsq74gccYaj0g
 TGow==
X-Gm-Message-State: AC+VfDz21P+d8Say8VQXXNvgVxpQrrqowB34OCXmDbus5ZGQlrHGbwQ7
 V4v+xuqlp8aRWFLOPeLuLI/oLyXIFXVmw1+/J/F4i9mzNWFqxtySZ1C7wirTLBBtq0GS2zzxk94
 +7t7N5Eejnow0JCw=
X-Received: by 2002:a05:620a:3705:b0:75c:a2bb:5e10 with SMTP id
 de5-20020a05620a370500b0075ca2bb5e10mr2767677qkb.0.1686345966238; 
 Fri, 09 Jun 2023 14:26:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4sFhYs+lwc0QlBrpkxUHfCeM3HGIg7AvWexs1kzTwNFhwKJ06nhOeLb2u72cqN/m1DkmCGfw==
X-Received: by 2002:a05:620a:3705:b0:75c:a2bb:5e10 with SMTP id
 de5-20020a05620a370500b0075ca2bb5e10mr2767656qkb.0.1686345965949; 
 Fri, 09 Jun 2023 14:26:05 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c23-20020a05620a135700b0074e0abe59a0sm1279114qkl.78.2023.06.09.14.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 14:26:04 -0700 (PDT)
Date: Fri, 9 Jun 2023 17:26:03 -0400
From: Peter Xu <peterx@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Message-ID: <ZIOY6w5n9hLEPUCC@x1n>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com>
 <ZIHgFFSaBJWFUNd7@x1n> <ZIHhgyUv7YmWsG3H@nvidia.com>
 <ZIH2h7GAV6qirAgw@x1n> <ZIIBhmoT7H2/q0lb@nvidia.com>
 <ZIIxs9kXQyULglIJ@x1n>
 <SJ0PR11MB6744E9DE31D0424F4104FC469251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB6744E9DE31D0424F4104FC469251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 09, 2023 at 05:49:06AM +0000, Duan, Zhenzhong wrote:
> Seems vtd_page_walk_one() already works in above way, checking mapping
> changes and calling kernel for changed entries?

Agreed in most cases, but the path this patch modified is not?  E.g. it
happens in rare cases where we simply want to unmap everything (e.g. on a
system reset, or invalid context entry)?

That's also why I'm curious whether perf of this path matters at all (and
assuming now we all agree that's the only goal now..), because afaiu it
didn't really trigger in common paths.

-- 
Peter Xu


