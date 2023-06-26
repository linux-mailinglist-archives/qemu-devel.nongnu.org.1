Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0EB73D9C4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:31:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhcX-0003Cj-DR; Mon, 26 Jun 2023 04:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qDhcM-0003AA-HH
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qDhcK-0004vJ-Dg
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687768232;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42so3AaTMuEPQCsMOb2kRv45HcUWQpFJhPHZ7RToAG4=;
 b=BOCmK6Rfi8mXqwBA5uvHWgl5nZKTM3QtDGvNU3VOBLYiySo0kpNs9+TMcXnL4JWbOVGnfZ
 LVywNbwioDCLVOmzAoGg9c2uGJ7+5tMkH2TYxBZflh4R7fLfGjHBKZmJnQZlB4ncqA5fr3
 I0ZQRiSOHaFkgpGTthzr1PsedR5wmmU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-RNy7ntNoMSKD7pvXWa_mUg-1; Mon, 26 Jun 2023 04:30:28 -0400
X-MC-Unique: RNy7ntNoMSKD7pvXWa_mUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3AA93C1CCC6;
 Mon, 26 Jun 2023 08:30:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C629A1121319;
 Mon, 26 Jun 2023 08:30:26 +0000 (UTC)
Date: Mon, 26 Jun 2023 09:30:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH 2/2] accel: Re-enable WHPX cross-build on case sensitive
 filesystems
Message-ID: <ZJlMoCTx0rBUNP0i@redhat.com>
References: <20230624142211.8888-1-philmd@linaro.org>
 <20230624142211.8888-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230624142211.8888-3-philmd@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, Jun 24, 2023 at 04:22:11PM +0200, Philippe Mathieu-Daudé wrote:
> Since MinGW commit 395dcfdea ("rename hyper-v headers and def
> files to lower case") [*], WinHvPlatform.h and WinHvEmulation.h
> got respectively renamed as winhvplatform.h / winhvemulation.h.
> 
> The mingw64-headers package included in the Fedora version we
> use for CI does include this commit; and meson fails to detect
> these present-but-renamed headers while cross-building (on
> case-sensitive filesystems).
> 
> Use the renamed header in order to detect and successfully
> cross-build with the WHPX accelerator.
> 
> Note, on Windows hosts, the libraries are still named as
> WinHvPlatform.dll and WinHvEmulation.dll, so we don't bother
> renaming the definitions used by load_whp_dispatch_fns() in
> target/i386/whpx/whpx-all.c.
> 
> [*] https://sourceforge.net/p/mingw-w64/mingw-w64/ci/395dcfdea
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  meson.build                      | 4 ++--
>  target/i386/whpx/whpx-internal.h | 4 ++--
>  target/i386/whpx/whpx-all.c      | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


