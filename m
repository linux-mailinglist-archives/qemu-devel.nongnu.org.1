Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E19397436B7
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:12:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF97r-0002JI-CM; Fri, 30 Jun 2023 04:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qF97B-0001QE-Ju
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qF977-0000pQ-9i
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688112259;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8WHnmkXrd/x160UB2JUOjCPI0UZ/W0C4aLfqAlpQMg=;
 b=PxBysNafZEowkCFSytCXLdt44ry3305zlAAWbGTyUeIOFzUO0F7kBQ87IqBF/JzRsskn61
 liKLMT3fyidKAYz84k594PfCFi3FabJ0O4rET3/rHPf5dIQv6+ZGx9j5XD7bkNX4TegpK4
 IEpLKk95elkIl28Ld3BNvnDgJL52LYY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-7ABavY4KMjKQ19PnjoVaPw-1; Fri, 30 Jun 2023 04:04:16 -0400
X-MC-Unique: 7ABavY4KMjKQ19PnjoVaPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D716738117EC;
 Fri, 30 Jun 2023 08:04:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D359A14682F9;
 Fri, 30 Jun 2023 08:04:14 +0000 (UTC)
Date: Fri, 30 Jun 2023 09:04:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Andrew Melnychenko <andrew@daynix.com>, mst@redhat.com,
 armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 yuri.benditovich@daynix.com, yan@daynix.com
Subject: Re: [PATCH v3 0/6] eBPF RSS through QMP support.
Message-ID: <ZJ6MfLs+yLx/yQyV@redhat.com>
References: <20230614221026.56950-1-andrew@daynix.com>
 <CACGkMEsDw8sUeJB340f8cdqEFnQRXccDxq6pe+87KDzOBMHZpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsDw8sUeJB340f8cdqEFnQRXccDxq6pe+87KDzOBMHZpg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Jun 30, 2023 at 01:06:22PM +0800, Jason Wang wrote:
> On Thu, Jun 15, 2023 at 6:29 AM Andrew Melnychenko <andrew@daynix.com> wrote:
> >
> > This series of patches provides the ability to retrieve eBPF program
> > through qmp, so management application may load bpf blob with proper capabilities.
> > Now, virtio-net devices can accept eBPF programs and maps through properties
> > as external file descriptors. Access to the eBPF map is direct through mmap()
> > call, so it should not require additional capabilities to bpf* calls.
> > eBPF file descriptors can be passed to QEMU from parent process or by unix
> > socket with sendfd() qmp command.
> >
> > Possible solution for libvirt may look like this: https://github.com/daynix/libvirt/tree/RSS_eBPF (WIP)
> >
> > Changes since v2:
> >  * moved/refactored QMP command
> >  * refactored virtio-net
> 
> I've queued this series, but a question left:
> 
> mmap() support for eBPF maps is not supported from day0, should we
> fallback to syscall for the OS that doesn't support that?

How recent is mmap() support ? Is it difficult to do a fallback ?

As since is a new feature, there's no inherant expectation of support
for arbitrary old platforms. So only worth investing in a fallback if
it is easy, or there's a very compelling reason to support certain
old platforms.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


