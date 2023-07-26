Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E47763081
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 10:51:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOaEC-00039l-Fz; Wed, 26 Jul 2023 04:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOaDz-00039R-GW
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 04:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOaDx-0001EN-TJ
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 04:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690361424;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=POck8eO7NA+cEH1ZwLyjJ2vTH0dWUSvCp6Dd37bqmEk=;
 b=BKGWElaLh/7UCrwwZN4gjpLhFXfwI1UjhImPmZ2S99VORQOuiU6jDCsjz8n1663KgIK7ev
 OmkUz/KG2xR0HLaZanmH02A9KAvbhbtU6zsLFCTINClDjny0MkXbufBTle4xGHUG1K7AVl
 fIAWCd+9FwuejCR325IT2jqVIUW+45w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-MytW1IqLMKmMaEIeRaaxTg-1; Wed, 26 Jul 2023 04:50:20 -0400
X-MC-Unique: MytW1IqLMKmMaEIeRaaxTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86541805951;
 Wed, 26 Jul 2023 08:50:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5CF9F782E;
 Wed, 26 Jul 2023 08:50:18 +0000 (UTC)
Date: Wed, 26 Jul 2023 09:50:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: how to build qemu 8.1 - keycodemapdb?
Message-ID: <ZMDeSBP7tkYowKV6@redhat.com>
References: <efc23b6f-861f-43eb-a4b4-900f45e77ef6@tls.msk.ru>
 <93e9c611-9453-e1d2-5b18-547c76f70c6c@tls.msk.ru>
 <fc51603b-c89a-c3d5-f59c-c191847c6c1d@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc51603b-c89a-c3d5-f59c-c191847c6c1d@tls.msk.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

On Wed, Jul 26, 2023 at 10:15:24AM +0300, Michael Tokarev wrote:
> 26.07.2023 09:41, Michael Tokarev wrote:
> 
> > Looks like scripts/make-release.sh needs some updating.

FWIW, i see the same problem as you:

$ ./configure  --target-list=x86_64-softmmu --disable-download
Using './build' as the directory for build output

ERROR: missing subprojects

This is not a GIT checkout but subproject content appears to
be missing. Do not use 'git archive' or GitHub download links
to acquire QEMU source archives. Non-GIT builds are only
supported with source archives linked from:

  https://www.qemu.org/download/#source

Developers working with GIT can use scripts/archive-source.sh
if they need to create valid source archives.


> make-release.sh apparently does the right thing. But the published
> tarball does not include the 3 required sub-projects anyway.
> 
> Is it about how the release is made?  What is used to make the
> actual release tarball, is it not make-release.sh?

make-release is what I expect to be used for making release
tarballs.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


