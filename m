Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C796766853
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 11:11:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPJJU-0007QV-1D; Fri, 28 Jul 2023 04:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qPJJR-0007PW-BZ
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qPJJP-0004O8-KM
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690534742;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hJUpbNKdocn6IQKkh7OTGVUY2qCy83V5HHwQKIZ4qs=;
 b=ajtQt8tjbrl9y821Vpp5gwU5R26D5ouX3+TPlbHYvugSYvc6cqoutDOZSP4NnB5sEUAsjt
 Xn8Zu4ErP4bqTjs/4xSSUedJPWeR3LKlNJS4LlAGtJ7MUM56Dyl62xjMAyMUNMS2Q/bkzs
 PbGfJg2znb9Y8KFTAd0+mYU7siVtMVs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-689-HcfN6JEtNWuDOUAHGJH5cQ-1; Fri, 28 Jul 2023 04:59:00 -0400
X-MC-Unique: HcfN6JEtNWuDOUAHGJH5cQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D421C802A7D;
 Fri, 28 Jul 2023 08:58:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8881840C2063;
 Fri, 28 Jul 2023 08:58:57 +0000 (UTC)
Date: Fri, 28 Jul 2023 09:58:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Bin Meng <bin.meng@windriver.com>
Subject: Re: [PATCH] gitlab: remove duplication between msys jobs
Message-ID: <ZMODTyTzJrKiDPo5@redhat.com>
References: <20230726161942.229093-1-berrange@redhat.com>
 <0d0f9f65-2ead-6852-20c2-a83e256eecac@redhat.com>
 <ZMJJS5lUtPKpld0q@redhat.com>
 <a56c06a0-a6b4-cee6-be97-3586a836f4d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a56c06a0-a6b4-cee6-be97-3586a836f4d3@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

On Fri, Jul 28, 2023 at 10:35:35AM +0200, Thomas Huth wrote:
> On 27/07/2023 12.39, Daniel P. Berrangé wrote:
> > On Wed, Jul 26, 2023 at 08:21:33PM +0200, Thomas Huth wrote:
> > > On 26/07/2023 18.19, Daniel P. Berrangé wrote:
> ...
> > > Anyway, before we unify the compiler package name suffix between the two
> > > jobs, I really would like to see whether the mingw Clang builds QEMU faster
> > > in the 64-bit job ... but so far I failed to convince meson to accept the
> > > Clang from the mingw package ... does anybody know how to use Clang with
> > > MSYS2 properly?
> > 
> > AFAIK it shouldn't be anything worse than
> > 
> >    CC=clang ./configure ....
> > 
> > if that doesn't work then its a bug IMHO
> 
> No, it's not that easy ... As Marc-André explained to me, MSYS2 maintains a
> completely separate environment for Clang, i.e. you have to select this
> different environment with $env:MSYSTEM = 'CLANG64' and then install the
> packages that have the "mingw-w64-clang-x86_64-" prefix.
> 
> After lots of trial and error, I was able to get a test build here:
> 
>  https://gitlab.com/thuth/qemu/-/jobs/4758605925
> 
> I had to disable Spice and use --disable-werror in that build to make it
> succeed, but at least it shows that Clang seems to be a little bit faster -
> the job finished in 58 minutes. So if we can get the warnings fixed, this
> might be a solution for the timeouts here...

Those packing warnings look pretty serious

C:/GitLab-Runner/builds/thuth/qemu/include/block/nvme.h:1781:16: warning: unknown attribute 'gcc_struct' ignored [-Wunknown-attributes]

This means CLang is using the MSVC struct packing ABI for bitfields,
which is different from the GCC struct packing ABI. If any of those
structs use bitfields and are exposed as guest hardware ABI, or in
migration vmstate, then this is potentially broken compilation.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


