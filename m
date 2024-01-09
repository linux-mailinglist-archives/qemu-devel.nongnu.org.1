Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED07828767
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 14:51:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNCUH-0008Gf-GZ; Tue, 09 Jan 2024 08:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNCUF-0008GX-7i
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNCU4-0008D9-S6
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704808174;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZEbfq1Jmbp8c9m0T2RO9gr80yl5sJbjesl62ILq3lts=;
 b=XppiojOsB3ZJbU2zwpv/kEpNcqIQHdmkhvalznPWVtfPS8VEfslgj/sg6RnsZxUEurnEZX
 AzP1DcFioT5Es85giOBy5Z+3I9OxAQtb79ECMJ8XY1tXyjbLvDKMlDhErtAvEnwRZxvx8q
 3RY3MDcpjEF8idTygV5l91teb/uKvPw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-7wgdjxRmNByEqLA93My54A-1; Tue,
 09 Jan 2024 08:49:31 -0500
X-MC-Unique: 7wgdjxRmNByEqLA93My54A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D10803C2A1C2;
 Tue,  9 Jan 2024 13:49:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D25C2166B32;
 Tue,  9 Jan 2024 13:49:28 +0000 (UTC)
Date: Tue, 9 Jan 2024 13:49:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/6] net: fix non-deterministic failures of the
 'netdev-socket' qtest
Message-ID: <ZZ1O5m2i_lz1fLMr@redhat.com>
References: <20240104162942.211458-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240104162942.211458-1-berrange@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Jason,

As the net/ maintainer, could you take a look at this series.
This failure has been causing pain for CI for quite a while.

If you're happy with it, I can include it in a pending pull
request of other misc patches I have.

On Thu, Jan 04, 2024 at 04:29:36PM +0000, Daniel P. Berrangé wrote:
> We've previously bumped up the timeouts in the netdev-socket qtest
> to supposedly fix non-deterministic failures, however, the failures
> are still hitting CI.
> 
> A simple 'listen()' and 'connect()' pairing across 2 QEMU processes
> should be very quick to execute, even under high system load, so it
> was never likely that the test was failing due to timeouts being
> reached.
> 
> The actual root cause was a race condition in the test design. It
> was spawning a QEMU with a 'server' netdev, and then spawning one
> with the 'client' netdev. There was insufficient synchronization,
> however, so it was possible for the 2nd QEMU process to attempt
> to 'connect()' before the 'listen()' call was made by the 1st QEMU.
> 
> In the test scenarios that did not use the 'reconnect' flag, this
> would result in the client QEMU never getting into the expected
> state. The test code would thus loop on 'info network' until
> hitting the maximum wait time.
> 
> This series reverts the increased timeouts, and fixes synchronization
> in the test scenarios. It also improves reporting of errors in the
> socket netdev backend so that 'info network' reports what actually
> went wrong rather than a useless generic 'connection error' string.
> This will help us diagnose any future CI problems, should they occurr.
> 
> Daniel P. Berrangé (6):
>   Revert "netdev: set timeout depending on loadavg"
>   Revert "osdep: add getloadavg"
>   Revert "tests/qtest/netdev-socket: Raise connection timeout to 120
>     seconds"
>   net: add explicit info about connecting/listening state
>   net: handle QIOTask completion to report useful error message
>   qtest: ensure netdev-socket tests have non-overlapping names
> 
>  include/qemu/osdep.h        | 10 ---------
>  meson.build                 |  1 -
>  net/stream.c                | 18 +++++++++++-----
>  tests/qtest/netdev-socket.c | 42 +++++++------------------------------
>  4 files changed, 21 insertions(+), 50 deletions(-)
> 
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


