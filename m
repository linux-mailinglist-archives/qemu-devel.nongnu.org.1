Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D5B7631A2
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 11:19:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOafX-000258-Lz; Wed, 26 Jul 2023 05:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOafQ-00024l-Is
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 05:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOafO-0005Ju-5P
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 05:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690363125;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I5eRNYK/TbGLe4hOHp5yJ77OpBrBruOmHeZY45LQqEk=;
 b=Fpel+ef/HfzEAbUUBqXr8q0t4yEVcjLXtY7V8OOoMy9WE88dwWxAN29wyuld8c17OMPQSw
 YLZNDMffzpnKZsZrP+OeWY55dAVSsJR8tH7+LKSitYdQAIQVuxTcrr9OxwqX9eql7dgE09
 Qly0W82EWaP9KYRRaVa6QuJu4sAmXkA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-pdXKCWf2McinlbvDLwr5QQ-1; Wed, 26 Jul 2023 05:18:41 -0400
X-MC-Unique: pdXKCWf2McinlbvDLwr5QQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FFCA80269A;
 Wed, 26 Jul 2023 09:18:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80F6740C2063;
 Wed, 26 Jul 2023 09:18:39 +0000 (UTC)
Date: Wed, 26 Jul 2023 10:18:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: how to build qemu 8.1 - keycodemapdb?
Message-ID: <ZMDk7V9qfzab94Hg@redhat.com>
References: <efc23b6f-861f-43eb-a4b4-900f45e77ef6@tls.msk.ru>
 <93e9c611-9453-e1d2-5b18-547c76f70c6c@tls.msk.ru>
 <fc51603b-c89a-c3d5-f59c-c191847c6c1d@tls.msk.ru>
 <ZMDeSBP7tkYowKV6@redhat.com>
 <0b562fb1-5fc0-38d8-f0d0-65f52f726bc5@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b562fb1-5fc0-38d8-f0d0-65f52f726bc5@tls.msk.ru>
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

On Wed, Jul 26, 2023 at 12:05:41PM +0300, Michael Tokarev wrote:
> 26.07.2023 11:50, Daniel P. Berrangé wrote:
> ..
> > > make-release.sh apparently does the right thing. But the published
> > > tarball does not include the 3 required sub-projects anyway.
> > > 
> > > Is it about how the release is made?  What is used to make the
> > > actual release tarball, is it not make-release.sh?
> > 
> > make-release is what I expect to be used for making release
> > tarballs.
> 
> When I run ./scripts/make-release 8.1.0-rc1 , the resulting tarball
> includes the necessary submodules in subprojects/.
> 
> It is more: it includes 2 copies of berkeley-softfloat & berkeley-testfloat,
> one in subprojects/ and one in roms/edk2/ArmPkg/Library/ArmSoftFloatLib/ .
> 
> But the tarballs published on qemu.org does not include these.
> 
> So I conclude the tarballs were not created using make-release.sh.

I filed an issue for this and marked it as a release blocker.

  https://gitlab.com/qemu-project/qemu/-/issues/1791

rc0 was broken in the same way too.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


