Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEF8746CD6
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:06:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbyk-0008KS-9v; Tue, 04 Jul 2023 05:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qGbyi-0008KC-TU
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qGbyh-0007tb-0K
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688461542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=auHYNaNBiHRxlDzlcQkmis1/aL9BjB4ID11oQNInT64=;
 b=LBrjKbXSo/Zi+vFWIBj0akXJcrbUfjPROukLAbt3NtgkXexWV8QX6AjaG5cKT9jc1YCX+n
 XsMpn2kmh52aqVKMsMDYpUW/ZVoiE6G0p14b7b0sp2LztVIIh62txeyi8nn2KdNVE8Be5I
 0svuHBMPT1b/fEbuN7twdJHQfW3IdCE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-80dIaazfMS2Indtq_Enchg-1; Tue, 04 Jul 2023 05:05:38 -0400
X-MC-Unique: 80dIaazfMS2Indtq_Enchg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F6B1185A794;
 Tue,  4 Jul 2023 09:05:37 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13F6A2166B34;
 Tue,  4 Jul 2023 09:05:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: oliver.upton@linux.dev, salil.mehta@huawei.com, james.morse@arm.com,
 gshan@redhat.com, Shaoqin Huang <shahuang@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 2/5] linux-headers: Import arm-smccc.h from Linux
 v6.4-rc7
In-Reply-To: <20230626064910.1787255-3-shahuang@redhat.com>
Organization: Red Hat GmbH
References: <20230626064910.1787255-1-shahuang@redhat.com>
 <20230626064910.1787255-3-shahuang@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 04 Jul 2023 11:05:35 +0200
Message-ID: <87a5wchwrk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On Mon, Jun 26 2023, Shaoqin Huang <shahuang@redhat.com> wrote:

> Copy in the SMCCC definitions from the kernel, which will be used to
> implement SMCCC handling in userspace.
>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  linux-headers/linux/arm-smccc.h | 240 ++++++++++++++++++++++++++++++++
>  1 file changed, 240 insertions(+)
>  create mode 100644 linux-headers/linux/arm-smccc.h

I think you need to add this to the headers update script, so that
changes get propagated in the future as well.

(I'd just add it to the script and do the update in one go.)


