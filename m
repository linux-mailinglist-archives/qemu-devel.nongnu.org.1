Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EAA7DF4A2
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 15:11:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyYPZ-0007pG-92; Thu, 02 Nov 2023 10:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyYPX-0007oL-Sr
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyYPW-0005si-74
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698934261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Crl62ADJ0uoEpbVHG3l3MIlFa/mnlR9JP+TsBeqPwfk=;
 b=D7y3d5Cy7S/B9nMP8y9fi+O8lgDToLqgo3DVIUfT8SWJi3tkv2Oi3xeG+Pi+TxVU8DZTKB
 HTz/nKD7dGG5sAGtffFvP9EEseTlBh+XnCQstSGNjwkalnrrLAjhigPBUpgyJDe1Xabmw1
 Jcrl+3/S8Xlgdu2a87qhSddI+PF2MQ8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-l-ISniKIOJSlCy_ej57rqg-1; Thu,
 02 Nov 2023 10:10:55 -0400
X-MC-Unique: l-ISniKIOJSlCy_ej57rqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A0181C05193;
 Thu,  2 Nov 2023 14:10:55 +0000 (UTC)
Received: from redhat.com (unknown [10.39.195.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E66E02026D4C;
 Thu,  2 Nov 2023 14:10:53 +0000 (UTC)
Date: Thu, 2 Nov 2023 15:10:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 0/2] virtio-blk: add iothread-vq-mapping parameter
Message-ID: <ZUOt7G+xdnLOBR5S@redhat.com>
References: <20230918161604.1400051-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918161604.1400051-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

Am 18.09.2023 um 18:16 hat Stefan Hajnoczi geschrieben:
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
> Based-on: 20230912231037.826804-1-stefanha@redhat.com ("[PATCH v3 0/5] block-backend: process I/O in the current AioContext")

Does this strictly depend on patch 5/5 of that series, or would it just
be a missed opportunity for optimisation by unnecessarily running some
requests from a different thread?

I suspect it does depend on the other virtio-blk series, though:

[PATCH 0/4] virtio-blk: prepare for the multi-queue block layer
https://patchew.org/QEMU/20230914140101.1065008-1-stefanha@redhat.com/

Is this right?

Given that soft freeze is early next week, maybe we should try to merge
just the bare minimum of strictly necessary dependencies.

Kevin


