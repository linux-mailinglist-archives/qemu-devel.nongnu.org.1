Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6957696A3
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 14:45:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQSGg-0002ea-I2; Mon, 31 Jul 2023 08:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQSGe-0002eE-MQ
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:44:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQSGc-0003SZ-Nt
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690807493;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=g+3QBJ0fnGgmyVUNam/SLLIvNKztXE8xe52EV4r9FdQ=;
 b=C2vDEoZWK67ZRnLRf/iQFWnuldsyEKd6bd2UvgPGvtmqN06C4mDFTuUirKHY2ap45Hpkzt
 4G1W7LK6WeqytD3LLtahduCuwo5Z9C34ixd55BaOepKiI4J/mtgYpH2VPSkdL+oG1doPAZ
 DyMYYDZhn2WYcz4IjE3kkzO5TNDK7HU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-7QNUuSgPMOaCEo7YRe8uxw-1; Mon, 31 Jul 2023 08:44:51 -0400
X-MC-Unique: 7QNUuSgPMOaCEo7YRe8uxw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E90061C05131;
 Mon, 31 Jul 2023 12:44:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFD6E2166B25;
 Mon, 31 Jul 2023 12:44:40 +0000 (UTC)
Date: Mon, 31 Jul 2023 13:44:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with
 gcc_struct and Clang
Message-ID: <ZMesY/qgzH3cunbM@redhat.com>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-6-thuth@redhat.com>
 <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
 <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
 <CAFEAcA-F=6QqdjCSexG9kKsq9irjDGTv63xJNKQn+TD9-5U1pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-F=6QqdjCSexG9kKsq9irjDGTv63xJNKQn+TD9-5U1pg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 31, 2023 at 11:05:42AM +0100, Peter Maydell wrote:
> On Mon, 31 Jul 2023 at 10:11, Thomas Huth <thuth@redhat.com> wrote:
> > Or do you see another possibility how we could fix that timeout problem in
> > the 64-bit MSYS2 job? Still switching to clang, but compiling with
> > --extra-cflags="-Wno-unknown-attributes" maybe?
> 
> Is there any way we can separate out the "take 25 minutes to
> install a pile of packages" part from the "actually compile and
> test QEMU" part ?

Possibly, depends if msys installs all the packages to a specific
sub-directory location, or splatters all over the hierarchy. If the
former we might be able to put the whole installed sub-tree into the
gitlab cache, which is likely faster to deploy. Testing this out in
gitlab itself is kinda tedious, so needs a local windows VM to debug.
If msys relies on the registry for anything during package install,
then all bets are off, as I don't know how we'd cache & restore that.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


