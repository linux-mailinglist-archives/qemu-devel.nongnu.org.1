Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7369B72564A
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 09:47:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6nt4-0007TX-UU; Wed, 07 Jun 2023 03:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6nt2-0007Mr-4w
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6nt0-0003WQ-Ky
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686124037;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHgHVhUaN18vzcVrliWCecQiV4CXkPNeecx+mQE7wwQ=;
 b=X9pZ0ralnM3UK3/HRRmXTvmocJIw3RW3uP/X6BmNxL2+uUSy9tAMZpoRcEsDasLLl3VdNR
 ypJPr/xQ9HcXRNex9+qJ6bnUTGGJ6qAHA3ZUQQIUWZU6eCht86SKThSU2IZxFsA2Vh601N
 DrRnvZkj/r6NE5cPoJem2igjEuL9AAI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-cnhiwu-tM-yOs6oituH84w-1; Wed, 07 Jun 2023 03:47:14 -0400
X-MC-Unique: cnhiwu-tM-yOs6oituH84w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FE243C0BE43
 for <qemu-devel@nongnu.org>; Wed,  7 Jun 2023 07:47:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1134492B00;
 Wed,  7 Jun 2023 07:47:13 +0000 (UTC)
Date: Wed, 7 Jun 2023 08:47:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michal =?utf-8?B?UHLDrXZvem7DrWs=?= <mprivozn@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 thuth@redhat.com
Subject: Re: [PATCH v2 00/10] meson: replace submodules with wrap files
Message-ID: <ZIA1/5KQC15t47Sp@redhat.com>
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <e9efc1a4-b292-10a1-9058-76f7c8ac9867@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9efc1a4-b292-10a1-9058-76f7c8ac9867@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

On Wed, Jun 07, 2023 at 09:41:40AM +0200, Michal Prívozník wrote:
> On 6/5/23 11:52, Paolo Bonzini wrote:
> > This series replaces git submodules for bundled libraries with .wrap
> > files that can be used directly by meson for subprojects. 
> 
> Pardon my lack of knowledge, but even after I clone new repo and run:
> 
>   ./configure --enable-donwload && make && make test
> 
> I still see berkeley-softfloat-3 submodule missing:
> 
>   git submodule status
>   ...
>   0c37a43527f0ee2b9584e7fb2fdc805e902635ac roms/vbootrom
>   fatal: no submodule mapping found in .gitmodules for path
> 'tests/fp/berkeley-softfloat-3'
> 
> Is this expected?

Yet another example of submodules sucking. Once we removed the submodules
from .gitmodules, git doesn't know what to do with the existing chcked
out submodules from before this time.

Best thing todo is purge all existing submodules, eg

  git submodule deinit --all --force

and if there are stale directories left over, manually delete those too,
so you get back to a more pristine checkout state.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


