Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8475B7088E1
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:01:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjo6-0006ES-6t; Thu, 18 May 2023 16:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1pzjo1-00068t-Op
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1pzjnz-0004dA-Ld
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684440055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/CURRJzCFKNNeNG/dxJlMkqz4W8LyO9peKE8rqFKIs=;
 b=coss5jS8kJ1IRK5vuzN4fqWcBKdNfrQWot7RndZ/GiR9hR6mKF+wRFJbxX81LnxO/ubLYa
 x1UZeezAVxIfLUtjSF9MUe8GM4grnDH4hWnEJvIBAZNhHW3f9RkzRTA+SUfCI41c1eNmh6
 pNpyBhRNOOErIBVeMkeuOhMkgN5dYnk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-6J4LkYJ7MJufWpe8OxBYCA-1; Thu, 18 May 2023 16:00:50 -0400
X-MC-Unique: 6J4LkYJ7MJufWpe8OxBYCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDB8C85A5B1;
 Thu, 18 May 2023 19:45:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB16040C2063;
 Thu, 18 May 2023 19:45:46 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
 id 6545516CCFB; Thu, 18 May 2023 15:45:46 -0400 (EDT)
Date: Thu, 18 May 2023 15:45:46 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, virtio-fs@redhat.com,
 Erik Schilling <erik.schilling@linaro.org>
Subject: Re: Status of DAX for virtio-fs/virtiofsd?
Message-ID: <ZGaAalXSMhPb3eqe@redhat.com>
References: <87v8grlzu9.fsf@linaro.org>
 <CAJSP0QX+NeJ8Z5d+2ocUUVj4EGopxKT+trmEfacgvhE7TqCokQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QX+NeJ8Z5d+2ocUUVj4EGopxKT+trmEfacgvhE7TqCokQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 17, 2023 at 12:26:18PM -0400, Stefan Hajnoczi wrote:
> On Wed, 17 May 2023 at 11:54, Alex Bennée <alex.bennee@linaro.org> wrote:
> Hi Alex,
> There were two unresolved issues:
> 
> 1. How to inject SIGBUS when the guest accesses a page that's beyond
> the end-of-file.
> 2. Implementing the vhost-user messages for mapping ranges of files to
> the vhost-user frontend.
> 
> The harder problem is SIGBUS. An mmap area may be larger than the
> length of the file. Or another process could truncate the file while
> it's mmapped, causing a previously correctly sized mmap to become
> longer than the actual file. When a page beyond the end of file is
> accessed, the kernel raises SIGBUS.
> 
> When this scenario occurs in the DAX Window, kvm.ko gets some type of
> vmexit (fault) and the code currently enters an infinite loop because
> it expects KVM memory regions to resolve faults. Since there is no
> page backing that part of the vma, the fault handling fails and the
> code loops trying to do this forever.
> 
> There needs to be a way to inject this fault back into the guest.
> However, we did not found a way to do that. We considered Machine
> Check Exceptions (MCEs), x86 interrupts, and paravirtualized
> approaches. None of them looked like a clean and sane way to do this.
> The Linux maintainers for MCEs and kvm.ko were not excited about
> supporting this.
> 
> So in the end, SIGBUS was never solved. It leads to a DoS because the
> host kernel will enter an infinite loop. We decided that until there
> is progress on SIGBUS, we can't go ahead with DAX Windows in
> production.
> 
> The easier problem is adding new vhost-user messages. It does lead to
> a fundamental change in the vhost-user protocol: the presence of the
> DAX Window means there are memory ranges that cannot be accessed via
> shared memory. Imagine Device A has a DAX Window and Device B needs to
> DMA to/from it. That doesn't work because the mmaps happen inside the
> frontend (QEMU), so Device B doesn't have access to the current
> mappings. The fundamental change to vhost-user is that virtqueue
> descriptor mapping code must now deal with the situation where guest
> addresses are absent from the shared memory regions and instead send
> vhost-user protocol messages to read/write to/from bounce buffers
> instead. The rest of the device backend does not require modification.
> This is a slow path, but at least it works whereas currently the I/O
> would fail because the memory is absent. Other solutions to the
> vhost-user DMA problem exist, but this is the one that Dave and I last
> discussed.
> 
> In the end, there is still work to do to make the DAX Window
> supportable. There is experimental code out there that kind of works,
> but we felt it was incomplete.

I feel that it will be good if someone can solve the vhost-user problem
first and get patches upstream. Now virtiofsd support from qemu has
been removed, so someone will have to add DAX support to rust virtiofsd.
(And make correspoding vhost-user changes in qemu).

Once that is done, someone can look into MCE issue.

With vhost-user problem solved, DAX will be usable in non-shared mode.
That is just pass through host filesystem into the guest and even host
can't make modifications. And that should steer clear us of the truncation
issue.

virtiofs DAX is a good piece of technology and provides speed up in many
cases. Will be sad to see the patches lost.

Now people are posting fixes to kernel side of DAX and there is no good
way to test these. I will try to make it work with old DAX branch david
had to test kernel changes but I am sure at some point of time it will
stop working and I don't want virtiofs kernel DAX code to become unstable.

Will be good if somebody takes up this project and makes it happen.

Thanks
Vivek

> 
> To your specific questions:
> 
> >  * What VMM/daemon combinations has DAX been tested on?
> 
> Only the experimental virtio-fs Kata Containers kernels and QEMU
> builds that were available a few years ago. I don't think the code has
> been rebased.
> 
> >  * Isn't it time the vhost-user spec is updated?
> 
> I don't know if Dave ever wrote the spec for or implemented the final
> version of the vhost-user protocol messages we discussed.
> 
> >  * Is anyone picking up Dave's patches for the QEMU side of support?
> 
> Not at the moment. It would be nice to support, but someone needs the
> energy/time/focus to deal with the outstanding issues I mentioned.
> 
> If you want to work on it, feel free to include me. I can help dig up
> old discussions and give input.
> 
> Stefan
> 


