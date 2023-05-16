Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90495704A92
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:31:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrwQ-00076B-6x; Tue, 16 May 2023 06:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pyrwN-00075N-7l
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pyrwL-0001li-KE
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684232995;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DUxQNL/RUfil2/+8hUiv9uyKXi9qVBKhHFeQ8jOgd2M=;
 b=RRIjVuQGRpwJF6ooPtN3zk33nytZ+2Ky2Rfe5xUAAuy4y5oeIO5fdL+g993SQttxRoFctS
 SAuhJ+wLTLp8jG2KPhAkp7O+y7E0Ntn8ljjrSDmNspDNWds7cOfZxS2+okZwv5S0OJvEdm
 j9S1N492t9UF93bGpll5dWYCxFozW0U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-F728VMmsOj2x3L10KR0BFA-1; Tue, 16 May 2023 06:29:54 -0400
X-MC-Unique: F728VMmsOj2x3L10KR0BFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB2E8867955;
 Tue, 16 May 2023 10:29:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC1F11410DD5;
 Tue, 16 May 2023 10:29:51 +0000 (UTC)
Date: Tue, 16 May 2023 11:29:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Andrew Melnychenko <andrew@daynix.com>, jasowang@redhat.com,
 mst@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 yuri.benditovich@daynix.com, yan@daynix.com
Subject: Re: [PATCH v2 5/6] qmp: Added new command to retrieve eBPF blob.
Message-ID: <ZGNbHcbeN0klbBjU@redhat.com>
References: <20230512122902.34345-1-andrew@daynix.com>
 <20230512122902.34345-6-andrew@daynix.com>
 <ZGIAUxfLmI6hm3VT@redhat.com> <87zg64u0g7.fsf@pond.sub.org>
 <ZGNE0bk2zCDpUkYS@redhat.com> <87ilcsshgf.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ilcsshgf.fsf@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 16, 2023 at 12:23:28PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, May 16, 2023 at 10:47:52AM +0200, Markus Armbruster wrote:
> 
> [...]
> 
> >> So, this is basically a way to retrieve an eBPF program by some
> >> well-known name.
> >> 
> >> Ignorant question: how are these programs desposited?
> >
> > The eBPF code blob is linked into QEMU at build time. THis API lets
> > libvirt fetch it from QEMU, in base64 format. When libvirt later
> > creates NICs, it can attach the eBPF code blob to the TAP device (which
> > requires elevated privilleges that QEMU lacks). NB, libvirt would fetch
> > the eBPF code from QEMU when probing capabilities, as once a VM is
> > running it is untrusted.
> 
> Okay, I can see how that helps.  I trust the blob is in a read-only
> segment.  Ideally, libvirt fetches it before the guest runs.

Whether the blob is in a read-only segment or not isn't important,
because it transits writable memory in the QMP command marshalling.

IOW, if we're trying to mitigate against compromised QEMU, we
*must* fetch it before vCPUs are started. If we're super paranoid,
we would want to fetch it before even opening untrusted disk images
too.  It might push towards fetching it while probing capabilities
from a throw-away QEMU with "-m none"

> Please improve the QAPI schema doc comments to explain why and how the
> feature is to be used in a bit more detail.  The existing text
> 
>     Function returns eBPF object that can be loaded with libbpf.
>     Management applications (g.e. libvirt) may load it and pass file
>     descriptors to QEMU. Which allows running QEMU without BPF capabilities.
> 
> is too terse.
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


