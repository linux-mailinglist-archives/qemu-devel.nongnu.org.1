Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A3750068
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:49:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUb2-0005Et-N4; Wed, 12 Jul 2023 03:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qJUb0-0005Dq-SF
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qJUaz-0003C9-G1
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689148148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TI8sMo9dcspBHPFjOtplyLd7Y+0Eky95LPprMfjsfxk=;
 b=hYck5FROZXKCOoSSBVHyFBsRhJNLkdnrFM0p5f91giIZYrSvEVFxNXi12GItdw6IF2tmYk
 iKHN8Y8EcraJ5pAGfHQu6UxKQeQ9UsbCdvJxON6Wojr4VjvEHaD97UGqVoiMkEXMKekrrg
 FN5K7pDs/HjQwn4hLXPtE1oNWXnyh3s=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-jtxp9N1cO0KZx57ioc8AZw-1; Wed, 12 Jul 2023 03:49:04 -0400
X-MC-Unique: jtxp9N1cO0KZx57ioc8AZw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0786D384CC4C;
 Wed, 12 Jul 2023 07:49:04 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9179B492B01;
 Wed, 12 Jul 2023 07:49:03 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, "open list:Overall KVM CPUs"
 <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH v4 02/24] Update linux-header per VFIO device cdev v14
In-Reply-To: <20230712072528.275577-3-zhenzhong.duan@intel.com>
Organization: Red Hat GmbH
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
 <20230712072528.275577-3-zhenzhong.duan@intel.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 12 Jul 2023 09:49:02 +0200
Message-ID: <87v8epk1sh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
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

On Wed, Jul 12 2023, Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  linux-headers/linux/iommufd.h | 347 ++++++++++++++++++++++++++++++++++
>  linux-headers/linux/kvm.h     |  13 +-
>  linux-headers/linux/vfio.h    | 142 +++++++++++++-
>  3 files changed, 498 insertions(+), 4 deletions(-)
>  create mode 100644 linux-headers/linux/iommufd.h

Hi,

if this patch is intending to pull code that is not yet integrated in
the Linux kernel, please mark this as a placeholder patch. If the code
is already integrated, please run a full headers update against a
released version (can be -rc) and note that version in the patch
description.

Thanks!


