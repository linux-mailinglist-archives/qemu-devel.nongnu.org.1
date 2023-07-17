Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4B875643A
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 15:17:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLO6Y-00030Z-Dv; Mon, 17 Jul 2023 09:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLO6L-0002zP-WE
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 09:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLO6K-0000nG-91
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 09:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689599837;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Khn4PkMMRJAfDB9a2/J3K+3TtSDjExyFOTvHEzvJ9I=;
 b=dKmQc2oFyCLOVMcv+EEwBR8XTJpkeJP0mPYTWF+H/tCjM/eTHH+z5qnQxrrtQuDO/GsFBo
 Lat/7lhKtm5kQqcf/ixJDTmrNviy+ETAmalXzPR8CmB7ndZyJ7lIKSNjJfSK6sHDNb/5ek
 hcxaiAbSHYdqAf+NHZPdQ4+PH61JPx0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-fMKxSOT1PbK9ECmqSF9pwA-1; Mon, 17 Jul 2023 09:17:14 -0400
X-MC-Unique: fMKxSOT1PbK9ECmqSF9pwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79D298631DF;
 Mon, 17 Jul 2023 13:17:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00C8440C6F4C;
 Mon, 17 Jul 2023 13:17:11 +0000 (UTC)
Date: Mon, 17 Jul 2023 14:17:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Erik Skultety <eskultet@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v3 0/4] tests/vm/freebsd: Get up-to-date package list
 from lcitool
Message-ID: <ZLU/VS75+TEiB3+r@redhat.com>
References: <20230711144922.67491-1-philmd@linaro.org>
 <96e8c829-74fe-f5ce-0fb0-26de60b9416e@redhat.com>
 <ZLU0Sz8nUUrlZlsY@ridgehead.tt.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLU0Sz8nUUrlZlsY@ridgehead.tt.lan>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

On Mon, Jul 17, 2023 at 02:30:03PM +0200, Erik Skultety wrote:
> On Mon, Jul 17, 2023 at 02:18:34PM +0200, Thomas Huth wrote:
> > On 11/07/2023 16.49, Philippe Mathieu-Daudé wrote:
> > > Inspired by this patch from Thomas:
> > > https://lore.kernel.org/qemu-devel/20230531090415.40421-1-thuth@redhat.com/
> > > 
> > > Instead of updating the package list manually, use lcitool vars file.
> > > 
> > > Since v2:
> > > - Commit generated json (Daniel)
> > > 
> > > Since v1:
> > > - Addressed Erik & Daniel comments (generate in JSON)
> > > 
> > > Philippe Mathieu-Daudé (4):
> > >    tests/lcitool: Generate distribution packages list in JSON format
> > >    tests/lcitool: Refresh generated files
> > >    tests/vm: Introduce get_qemu_packages_from_lcitool_json() helper
> > >    tests/vm/freebsd: Get up-to-date package list from lcitool vars file
> > > 
> > >   tests/docker/dockerfiles/debian-amd64.docker |  2 -
> > >   tests/docker/dockerfiles/ubuntu2004.docker   |  2 -
> > >   tests/docker/dockerfiles/ubuntu2204.docker   |  2 -
> > 
> > Thanks, I'm queuing your patches for my next pull request - but I'm dropping
> > the hunks that change libpmem-dev and libxen-dev in the docker files -
> > otherwise this would just get reverted once somebody using a x86 host runs
> > the refresh step again. I hope this issue can be tackled by a future lcitool
> > update instead.
> > 
> >  Thomas
> > 
> 
> Can you guys please create an issue at
> https://gitlab.com/libvirt/libvirt-ci.git to have this officially tracked?

Done:

https://gitlab.com/libvirt/libvirt-ci/-/issues/26


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


