Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1AF81BFE3
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:08:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQGj-00039x-B6; Thu, 21 Dec 2023 16:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQGZ-00039V-G6
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:07:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQGW-0002Ev-BZ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703192854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dyvq2s0akWxu95rqBe9pJMD6TZQ2Yh8FOWR79X+Ve8M=;
 b=BhAN3jFNXsa8b1pFDohP4Hyzcua/enp+pIe1fbrW0hRfMrGV2TkmrQZziG5+yeGb5aMV7+
 R4kchnp8j7cABfZ5rD0EJZevVzZM8inerR07w+Dl5TbBXWf4voInEP8ZfzdPMFEcW38Rmf
 VZvxI8OYmN8gRHs78RB8vqc8tQGQsH4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-4NgmT8o9PES4JJpkJv7j4w-1; Thu,
 21 Dec 2023 16:07:29 -0500
X-MC-Unique: 4NgmT8o9PES4JJpkJv7j4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18C5D3806283;
 Thu, 21 Dec 2023 21:07:29 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 533452166B31;
 Thu, 21 Dec 2023 21:07:23 +0000 (UTC)
Date: Thu, 21 Dec 2023 22:07:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Michal Privoznik <mprivozn@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/4] virtio-blk: add iothread-vq-mapping parameter
Message-ID: <ZYSpCQ7kJufg9zWT@redhat.com>
References: <20231220134755.814917-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220134755.814917-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 20.12.2023 um 14:47 hat Stefan Hajnoczi geschrieben:
> v4:
> - Use DummyVirtioForceArrays naming in QAPI schema [Markus]
> v3:
> - Rebased onto Kevin's block branch
> - Add StringOutputVisitor "<omitted>" patch to fix "info qtree" crash
> - Fix QAPI schema formatting [Markus]
> - Eliminate unnecessary local variable in get_iothread_vq_mapping_list() [Markus]
> 
> virtio-blk and virtio-scsi devices need a way to specify the mapping between
> IOThreads and virtqueues. At the moment all virtqueues are assigned to a single
> IOThread or the main loop. This single thread can be a CPU bottleneck, so it is
> necessary to allow finer-grained assignment to spread the load. With this
> series applied, "pidstat -t 1" shows that guests with -smp 2 or higher are able
> to exploit multiple IOThreads.
> 
> This series introduces command-line syntax for the new iothread-vq-mapping
> property is as follows:
> 
>   --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothread":"iothread0","vqs":[0,1,2]},...]},...'
> 
> IOThreads are specified by name and virtqueues are specified by 0-based
> index.
> 
> It will be common to simply assign virtqueues round-robin across a set
> of IOThreads. A convenient syntax that does not require specifying
> individual virtqueue indices is available:
> 
>   --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothread":"iothread0"},{"iothread":"iothread1"},...]},...'
> 
> There is no way to reassign virtqueues at runtime and I expect that to be a
> very rare requirement.
> 
> Note that JSON --device syntax is required for the iothread-vq-mapping
> parameter because it's non-scalar.
> 
> Based-on: 81e69329d6a4018f4b37d15b6fc845fbe585a93b (https://repo.or.cz/qemu/kevin.git block)

Thanks, applied to the block branch. We agreed off-list that the
remaining problems can be fixed in follow-up patches.

Kevin


