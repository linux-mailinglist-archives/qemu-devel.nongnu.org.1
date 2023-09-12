Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C0979D4BD
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 17:25:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg5Es-00037g-7Y; Tue, 12 Sep 2023 11:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg5Ep-000376-PT
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:23:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg5En-0003a2-HN
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694532217;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3DYKot7IbxVJ0Dcq4QL8pPuRl2vIoYE/oC6OC1PxY5M=;
 b=EmfT1oWV6Geob5zpSHHwe+Xo48nhb3eiOnggqbwaHXOvsvCEKAAE0E+tdC+VPiRExAGog4
 r3uFXB+OfVmcHd7YDRoEViRgpvnEh+/MJkXx1YjvbDEn21rpcWt0BpmHhrwA3Y0UEvMwcj
 vPghgOKeqN9umlPnBg4WgbwLCoIIujw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-sRFqp8fqN7ebpETq_p1kZA-1; Tue, 12 Sep 2023 11:23:33 -0400
X-MC-Unique: sRFqp8fqN7ebpETq_p1kZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A24E38143A5;
 Tue, 12 Sep 2023 15:23:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A6F640C2064;
 Tue, 12 Sep 2023 15:23:30 +0000 (UTC)
Date: Tue, 12 Sep 2023 16:23:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Bin Meng <bmeng@tinylab.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: cherry-picking something to -stable which might require other
 changes
Message-ID: <ZQCCcM1gUy3ODnyj@redhat.com>
References: <e6385fc7-0889-ea16-4fc0-337796814636@tls.msk.ru>
 <CAJSP0QUfF64wWQbbAqKpeUWGEOz6jB2ZHkmJhaRXfRDFLpD_kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QUfF64wWQbbAqKpeUWGEOz6jB2ZHkmJhaRXfRDFLpD_kw@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 12, 2023 at 10:00:46AM -0400, Stefan Hajnoczi wrote:
> When I backport patches into RHEL, the general process I follow is:
> 1. For context conflicts, just adjust the patch to resolve them.
> 2. For real dependencies, backport the dependencies, if possible.
> 3. If backporting the dependencies is not possible, think of a
> downstream-only solution. This should be rare.
> 
> People make different backporting decisions (just like structuring
> patch series). It can be a matter of taste.

I tend to try to cherry-pick the dependancies in case (1) too
unless they are functionally invasive. Any time you manually
adjust a patch, you increase the likelihood that later cherry
picks will also require manual work. So I always favour a clean
cherry-pick until the point the functional risk becomes
unacceptable in the context of testing the change I'm pulling
back.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


