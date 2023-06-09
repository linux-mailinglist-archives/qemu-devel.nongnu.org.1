Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAF6729F6F
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7cII-0003dn-FE; Fri, 09 Jun 2023 09:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7cIG-0003dd-Td
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7cIF-00032c-8Y
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686317802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2eZ12lkThj2IWogeENIs9h7/dv5+lmqzk3CVSioIGLQ=;
 b=WNPHqZ0SFitBcg62t4TCtz0O+675zJRNTfMkX5d393+zso4dZ2fBWVYddT37gLCI3xdDhs
 8ylnZ5oBICfylbjucQN1Q5B5lvzRfQlW2zsCFAnMQvI+p790BZmkM+DKRF4p2Zss9G4KeO
 Sr/LquzoP6naw2m+tuB01G4W0fepTLc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Mza2CtPUM9KejyjV62eEeg-1; Fri, 09 Jun 2023 09:36:40 -0400
X-MC-Unique: Mza2CtPUM9KejyjV62eEeg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-62b683503e0so3578706d6.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 06:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686317800; x=1688909800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2eZ12lkThj2IWogeENIs9h7/dv5+lmqzk3CVSioIGLQ=;
 b=dVYihwYn7T28uH4cs2Dcl0hdSlxe3WHLsSAMZE4nPUOJ2gRhk32mEXRI/3x3fzmEju
 08Oa+ui2CGb2vbuzg2kZh9uwPCpiN9mdAy6YgGPNWbh8r9HIb9ocC6XImN9wh5BByfA1
 xYIh7tbJ3vU6vXubJqv35C4vmtQTRTEQoKJGUge0tA2NwsYaydIkuJxCrvVZC2DYyL5L
 2iXdaiLnK3qBOJlrOmnXfJJkf7d+DcCvZsvADzrmgjFMo/XLtIYmaWE8Tna6GwffPIWC
 PTdWm9Fa04H0tCD2R9qzkczrNb4tXNrFUIN9FZqwnny+VuWVjGFPrI9gs/KSSvSUv7NJ
 NZXQ==
X-Gm-Message-State: AC+VfDxx+8SfGLUphcXlFqjIZAysM7ueXYC6sU8U5QhZ8irjf7ei0mK4
 k1mJuSdCsIp4r5tiO/PeRNjXJRIf3OKBOGCmOteQQaYTNMmGiagXIgcSzunPWVjSBbFAQqMPFzt
 A50cxoeyR0bsCSxM=
X-Received: by 2002:a05:6214:768:b0:628:268c:1d72 with SMTP id
 f8-20020a056214076800b00628268c1d72mr1818055qvz.5.1686317799715; 
 Fri, 09 Jun 2023 06:36:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5oQ1Yd5eAW0DgF1XVhy2KdW9khzjTW1Rxm/wL4hLCqnI/lG5ZnX0hnUMjtBBa0r1caV/funA==
X-Received: by 2002:a05:6214:768:b0:628:268c:1d72 with SMTP id
 f8-20020a056214076800b00628268c1d72mr1818031qvz.5.1686317799411; 
 Fri, 09 Jun 2023 06:36:39 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 s3-20020a0cb303000000b0062b35b691cdsm1142911qve.93.2023.06.09.06.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 06:36:38 -0700 (PDT)
Date: Fri, 9 Jun 2023 09:36:37 -0400
From: Peter Xu <peterx@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
 "cjia@nvidia.com" <cjia@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v3 4/5] intel_iommu: Fix address space unmap
Message-ID: <ZIMq5d1zGnYD9jsu@x1n>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-5-zhenzhong.duan@intel.com>
 <ZIHcEMO2ZWp636t+@x1n>
 <SJ0PR11MB6744928AFD8CCB2C8C78D7959251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB6744928AFD8CCB2C8C78D7959251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
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

On Fri, Jun 09, 2023 at 03:31:46AM +0000, Duan, Zhenzhong wrote:
> 
> 
> >-----Original Message-----
> >From: Peter Xu <peterx@redhat.com>
> >Sent: Thursday, June 8, 2023 9:48 PM
> >To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >Cc: qemu-devel@nongnu.org; mst@redhat.com; jasowang@redhat.com;
> >pbonzini@redhat.com; richard.henderson@linaro.org; eduardo@habkost.net;
> >marcel.apfelbaum@gmail.com; alex.williamson@redhat.com;
> >clg@redhat.com; david@redhat.com; philmd@linaro.org;
> >kwankhede@nvidia.com; cjia@nvidia.com; Liu, Yi L <yi.l.liu@intel.com>; Peng,
> >Chao P <chao.p.peng@intel.com>
> >Subject: Re: [PATCH v3 4/5] intel_iommu: Fix address space unmap
> >
> >On Thu, Jun 08, 2023 at 05:52:30PM +0800, Zhenzhong Duan wrote:
> >> During address space unmap, corresponding IOVA tree entries are also
> >> removed. But DMAMap is set beyond notifier's scope by 1, so in theory
> >> there is possibility to remove a continuous entry above the notifier's
> >> scope but falling in adjacent notifier's scope.
> >
> >This function is only called in "loop over all notifiers" case (or replay() that just
> >got removed, but even so there'll be only 1 notifier normally iiuc at least for
> >vt-d), hopefully it means no bug exist (no Fixes needed, no backport needed
> >either), but still worth fixing it up.
> 
> Not two notifiers as vtd-ir splits for vt-d?

The two notifiers will all be attached to the same IOMMU mr, so
IOMMU_NOTIFIER_FOREACH() will loop over them all always?

And this actually shouldn't matter, IMHO, as the IR split has the
0xfeeXXXXX hole only, so when notifying with end=0xfee00000 (comparing to
end=0xfedfffff) it shouldn't make a difference iiuc because there should
have no iova entry at 0xfee00000 anyway in the tree.

-- 
Peter Xu


