Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 589F476ED92
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:06:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRZth-0001PD-Ik; Thu, 03 Aug 2023 11:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRZte-0001ON-8O
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRZta-0000e7-W8
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691075145;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3TwFnJAasPHYbFgi3RNroYueJEGpUONO/lcNA45Lu3c=;
 b=PFWxAxRZVbRsboXC3eplRLmgXENQX2XsiUgeXbInuhHMYjX5uDWOlXyGtRR8YDzv7TEfaY
 JuSFrDb0EfkmIYWecUS6hLgYjNBlE9ATRKVGGwbidzi6riFneTTRCsIpEfUTmKNCnT1wN8
 oE0tl3bTNn7k9LOUtucCPRO5sk6oN7c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-8H6M-UgjPwyzF9Gdt0aDJg-1; Thu, 03 Aug 2023 11:05:41 -0400
X-MC-Unique: 8H6M-UgjPwyzF9Gdt0aDJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12469881B26;
 Thu,  3 Aug 2023 15:05:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E08C5796B;
 Thu,  3 Aug 2023 15:05:38 +0000 (UTC)
Date: Thu, 3 Aug 2023 16:05:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 mst@redhat.com, boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 eduardo@habkost.net
Subject: Re: [PATCH v3 1/3] qmp: remove virtio_list, search QOM tree instead
Message-ID: <ZMvCPyQxQPi58mmM@redhat.com>
References: <20230803145500.2108691-1-jonah.palmer@oracle.com>
 <20230803145500.2108691-2-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230803145500.2108691-2-jonah.palmer@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Aug 03, 2023 at 10:54:58AM -0400, Jonah Palmer wrote:
> The virtio_list duplicates information about virtio devices that already
> exist in the QOM composition tree. Instead of creating this list of
> realized virtio devices, search the QOM composition tree instead.
> 
> This patch modifies the QMP command qmp_x_query_virtio to instead
> recursively search the QOM composition tree for devices of type
> 'TYPE_VIRTIO_DEVICE'. The device is also checked to ensure it's
> realized.
> 
> [Jonah: In the previous commit the qmp_x_query_virtio function was
>  iterating through devices found via. qmp_qom_list and appending
>  "/virtio-backend" to devices' paths to check if they were a virtio
>  device.
> 
>  This method was messy and involved unneeded string manipulation.
> 
>  Instead, we can use recursion with object_get_root to iterate through
>  all parent and child device paths to find virtio devices.
> 
>  The qmp_find_virtio_device function was also updated to simplify the
>  method of determining if a path is to a valid and realized virtio
>  device.]

FWIW, this "history" would typically go after the '---' but before
the diffstat, as it is relevant to reviewers of this new v3, but
doesn't need to get into the permanent git log once merged.

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/virtio-qmp.c | 96 ++++++++++++++++++------------------------
>  hw/virtio/virtio-qmp.h |  7 ---
>  hw/virtio/virtio.c     |  6 ---
>  3 files changed, 40 insertions(+), 69 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


