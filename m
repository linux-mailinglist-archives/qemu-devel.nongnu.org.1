Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C4671FD36
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:11:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q50nz-0007Vd-Om; Fri, 02 Jun 2023 05:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q50nw-0007VU-SF
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q50ns-0005Yv-SM
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685697035;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=V9C3W7SoLJyNuV0KwK2lDyQZEO7054hW00C5DjXn2kw=;
 b=Rwp2J10HNHNChSXRmG8EZc7VMVeJco/5Z2qfGDeFZ3bMrzOaQKXEl9ETT0EBZ9aW52Zbuu
 5GvyITN8dz63lpof/oSAJRw6lMHW9h1TEqZhGqeajwEAkNMtS4kVgCpl3dQo8BYVX3ebK0
 OwG5pZcIOOYXPU88IH4mNYl7MTNyDto=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-3AilliMfO2WMNtgJ1wO0Vw-1; Fri, 02 Jun 2023 05:10:32 -0400
X-MC-Unique: 3AilliMfO2WMNtgJ1wO0Vw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4723A1C0514F;
 Fri,  2 Jun 2023 09:10:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4A5F2166B25;
 Fri,  2 Jun 2023 09:10:30 +0000 (UTC)
Date: Fri, 2 Jun 2023 10:10:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Richard Henderson <rth@twiddle.net>
Subject: Re: Big TCG slowdown when using zstd with aarch64
Message-ID: <ZHmyA40nIiUBceX0@redhat.com>
References: <87y1l2rixp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1l2rixp.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

On Thu, Jun 01, 2023 at 11:06:42PM +0200, Juan Quintela wrote:
> 
> Hi
> 
> Before I continue investigating this further, do you have any clue what
> is going on here.  I am running qemu-system-aarch64 on x86_64.
> 
> $ time ./tests/qtest/migration-test -p /aarch64/migration/multifd/tcp/plain/none


> real	0m4.559s
> user	0m4.898s
> sys	0m1.156s

> $ time ./tests/qtest/migration-test -p /aarch64/migration/multifd/tcp/plain/zlib

> real	0m1.645s
> user	0m3.484s
> sys	0m0.512s
> $ time ./tests/qtest/migration-test -p /aarch64/migration/multifd/tcp/plain/zstd

> real	0m48.022s
> user	8m17.306s
> sys	0m35.217s
> 
> 
> This test is very amenable to compression, basically we only modify one
> byte for each page, and basically all the pages are the same.
> 
> no compression: 4.5 seconds
> zlib compression: 1.6 seconds (inside what I would expect)
> zstd compression: 48 seconds, what is going on here?

This is non-deterministic. I've seen *all* three cases complete in approx
1 second each. If I set 'QTEST_LOG=1', then very often the zstd test will
complete in < 1 second.

I notice the multifd tests are not sharing the setup logic with the
precopy tests, so they have no set any migration bandwidth limit.
IOW migration is running at full speed.

What I happening is that the migrate is runing so fast that the guest
workload hasn't had the chance to dirty any memory, so 'none' and 'zlib'
tests only copy about 15-30 MB of data, the rest is still all zeroes.

When it is fast, the zstd test also has similar low transfer of data,
but when it is slow then it transfers a massive amount more, and goes
through a *huge* number of iterations

eg I see dirty-sync-count over 1000:

{"return": {"expected-downtime": 221243, "status": "active", "setup-time": 1, "total-time": 44028, "ram": {"total": 291905536, "postcopy-requests": 0, "dirty-sync-count": 1516, "multifd-bytes": 24241675, "pages-per-second": 804571, "downtime-bytes": 0, "page-size": 4096, "remaining": 82313216, "postcopy-bytes": 0, "mbps": 3.7536507936507939, "transferred": 25377710, "dirty-sync-missed-zero-copy": 0, "precopy-bytes": 1136035, "duplicate": 124866, "dirty-pages-rate": 850637, "skipped": 0, "normal-bytes": 156904067072, "normal": 38306657}}}


I suspect that the zstd logic takes a little bit longer in setup,
which allows often allows the guest dirty workload to get ahead of
it, resulting in a huge amount of data to transfer. Every now and
then the compression code gets ahead of the workload and thus most
data is zeros and skipped.

IMHO this feels like just another example of compression being largely
useless. The CPU overhead of compression can't keep up with the guest
dirty workload, making the supposedly network bandwidth saving irrelevant.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


