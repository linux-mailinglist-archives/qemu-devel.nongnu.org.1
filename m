Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF178D622
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLDf-0006BS-1g; Wed, 30 Aug 2023 09:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbLDC-00061a-Qn
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbLD8-00042O-Q4
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693401978;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsknubTbMQ5pfcSc55uiQXZOUAq9sBnfLcmWh2HJ5WE=;
 b=NpvUV1mExvFFPDZ2Rqp97kLEm0K3TgeNqaldF/NK81UjFBuo+mR5M06uFqVvth2ZjP+45p
 KUl+/6dIu2XWGudOIQQjcjOKeVkvOkAfl6WMUaF7seVobpj+NZ+ckmtAhi9I1zJIFmq9vb
 GLoNpD0DoS483g0dQSU3Pl3od/OUNkc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-y8mG_wgOPUylQMOKLVsL-Q-1; Wed, 30 Aug 2023 09:26:14 -0400
X-MC-Unique: y8mG_wgOPUylQMOKLVsL-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12F84803E2E;
 Wed, 30 Aug 2023 13:26:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 076832166B25;
 Wed, 30 Aug 2023 13:26:11 +0000 (UTC)
Date: Wed, 30 Aug 2023 14:26:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org,
 yuri.benditovich@daynix.com, yan@daynix.com
Subject: Re: [PATCH v6 4/5] qmp: Added new command to retrieve eBPF blob.
Message-ID: <ZO9DcmJB/6wmwW6F@redhat.com>
References: <20230808233015.2295947-1-andrew@daynix.com>
 <20230808233015.2295947-5-andrew@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808233015.2295947-5-andrew@daynix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 09, 2023 at 02:30:14AM +0300, Andrew Melnychenko wrote:
> Now, the binary objects may be retrieved by id.
> It would require for future qmp commands that may require specific
> eBPF blob.
> 
> Added command "request-ebpf". This command returns
> eBPF program encoded base64. The program taken from the
> skeleton and essentially is an ELF object that can be
> loaded in the future with libbpf.
> 
> The reason to use the command to provide the eBPF object
> instead of a separate artifact was to avoid issues related
> to finding the eBPF itself. eBPF object is an ELF binary
> that contains the eBPF program and eBPF map description(BTF).
> Overall, eBPF object should contain the program and enough
> metadata to create/load eBPF with libbpf. As the eBPF
> maps/program should correspond to QEMU, the eBPF can't
> be used from different QEMU build.
> 
> The first solution was a helper that comes with QEMU
> and loads appropriate eBPF objects. And the issue is
> to find a proper helper if the system has several
> different QEMUs installed and/or built from the source,
> which helpers may not be compatible.
> 
> Another issue is QEMU updating while there is a running
> QEMU instance. With an updated helper, it may not be
> possible to hotplug virtio-net device to the already
> running QEMU. Overall, requesting the eBPF object from
> QEMU itself solves possible failures with acceptable effort.
> 
> Links:
> [PATCH 3/5] qmp: Added the helper stamp check.
> https://lore.kernel.org/all/20230219162100.174318-4-andrew@daynix.com/
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  ebpf/ebpf.c           | 70 +++++++++++++++++++++++++++++++++++++++++++
>  ebpf/ebpf.h           | 31 +++++++++++++++++++
>  ebpf/ebpf_rss.c       |  6 ++++
>  ebpf/meson.build      |  2 +-
>  qapi/ebpf.json        | 56 ++++++++++++++++++++++++++++++++++
>  qapi/meson.build      |  1 +
>  qapi/qapi-schema.json |  1 +
>  7 files changed, 166 insertions(+), 1 deletion(-)
>  create mode 100644 ebpf/ebpf.c
>  create mode 100644 ebpf/ebpf.h
>  create mode 100644 qapi/ebpf.json

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


