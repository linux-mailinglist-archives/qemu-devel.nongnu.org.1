Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDE076E727
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 13:42:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRWKR-0006qQ-SV; Thu, 03 Aug 2023 07:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRWKM-0006pq-Gc
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRWKF-0001zs-Rm
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691061422;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUKdnkjkx6mPMIUD3LOAE0/ulvrquP5G/YBJEgPL5WI=;
 b=Y8aYCT44KhkDkEfKetv6xHmwhdeGMCKZCtfrPqUBrZtcf5QXLa2dLvGFAInno/hYrwPJJ/
 nTxbfwEh5D/AEVlGqdm/I8UxRAJYhViMb5gQCHjuNAaAGaOVptEd6GbtyWj/7zu/uj6QBl
 a13POputjB9mFP7iSef/7yBuIfE/9Hg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-SonH5ta1P8uU_L5MhgmrGQ-1; Thu, 03 Aug 2023 07:16:58 -0400
X-MC-Unique: SonH5ta1P8uU_L5MhgmrGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A4FE858290;
 Thu,  3 Aug 2023 11:16:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E889F40C2063;
 Thu,  3 Aug 2023 11:16:56 +0000 (UTC)
Date: Thu, 3 Aug 2023 12:16:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/8] gitlab: always use updated msys installer
Message-ID: <ZMuMpniVleJtk8o2@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
 <20230801130403.164060-4-berrange@redhat.com>
 <52b5237e-b302-ecde-2373-f833034e4132@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52b5237e-b302-ecde-2373-f833034e4132@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Wed, Aug 02, 2023 at 05:49:42PM +0200, Thomas Huth wrote:
> On 01/08/2023 15.03, Daniel P. Berrangé wrote:
> > We current reference an msys installer binary from mid-2022, which means
> > after installation, it immediately has to re-download a bunch of newer
> > content. This wastes precious CI time.
> > 
> > The msys project publishes an installer binary with a fixed URL that
> > always references the latest content. We cache the downloads in gitlab
> > though and so once downloaded we would never re-fetch the installer
> > leading back to the same problem.
> > 
> > To deal with this we also fetch the pgp signature for the installer
> > on every run, and compare that to the previously cached signature. If
> > the signature changes, we re-download the full installer.
> > 
> > This ensures we always have the latest installer for msys, while also
> > maximising use of the gitlab cache.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>


> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> ... I think the original idea was to use a "tagged" version to avoid that we
> have some kind of "rolling release" here, but since the latest content is
> fetched anyway during the following update, that idea was likely not working
> as expected...

I think using the "latest" installer is also more in keeping with what
we do for other distros, where we'll always pick up the latest content
when the containers get rebuilt, or macOS/FreeBSD where we pick the
latest from Ports/HomeBrew.  

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


