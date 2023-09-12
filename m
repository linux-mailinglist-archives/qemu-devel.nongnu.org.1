Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 569D779D360
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4B4-00009N-FA; Tue, 12 Sep 2023 10:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg4B2-0008OA-IX
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg4Ay-0000yJ-Ae
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694528135;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+260vb1Ej7++ZaiEWxkX6MDaucQgJFobrhdQexa1fY=;
 b=JIradUBRX7+mffyicV8AxesYzRxMla8dVG852WyeVM+tZuZ3hSmiH5WmQ2UQzhJWMgCrN3
 j4BOP/K67aK5buCHabJ92J77jnQxA8+1qSERYbSCX4MFtfwVueI/SKeh8z41sVnR4TbcTT
 0xFOIvB32nT31ZsbUi5nV5ZDNNea1Bc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-MBe4g2vHMfWgtZXWlClD-g-1; Tue, 12 Sep 2023 10:15:32 -0400
X-MC-Unique: MBe4g2vHMfWgtZXWlClD-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C474101FAA0;
 Tue, 12 Sep 2023 14:15:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CC7840C2064;
 Tue, 12 Sep 2023 14:15:30 +0000 (UTC)
Date: Tue, 12 Sep 2023 15:15:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH] gitlab-ci/cirrus: Increase timeout to 100 minutes
Message-ID: <ZQBygFxijkkQWNO/@redhat.com>
References: <20230912133829.61352-1-stefanha@redhat.com>
 <ZQBtH7rBWm2Sze68@redhat.com>
 <CAJSP0QWUqry-CtrnL8hodgD6gsJGVCaY5vG5Tn5UHecZT0kQ3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QWUqry-CtrnL8hodgD6gsJGVCaY5vG5Tn5UHecZT0kQ3g@mail.gmail.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 12, 2023 at 10:02:17AM -0400, Stefan Hajnoczi wrote:
> On Tue, 12 Sept 2023 at 09:53, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Sep 12, 2023 at 09:38:29AM -0400, Stefan Hajnoczi wrote:
> > > The 80m timeout is not enough:
> > >
> > >   672/832 qemu:block / io-qcow2-041          OK             39.77s   1 subtests passed
> > >   Timed out!
> >
> > IIUC, that 'timed out' message is coming from Cirrus CI logs, which
> > we can see over on the cirrus task:
> >
> >   https://cirrus-ci.com/task/6462328380588032
> >
> > > https://gitlab.com/qemu-project/qemu/-/jobs/5058610599
> >
> > This reports duration "64 minutes", vs a GitLab timeout of 1hr20.
> >
> > IOW, we're not hitting the gitlab timeout, we're hitting hte
> > Cirrus CI timeout, which defaults to 60 minutes.  The other
> > 4 minuts gitlab reports is likely because Cirrus queued the
> > job for 4 minutes before starting execution.
> 
> I'm glad you spotted that. I'm not familiar with Cirrus. Could you
> send a patch that sets 'timeout_in'?

Yes, testing now

  https://gitlab.com/berrange/qemu/-/commit/c15d677de5ed2965464bc6212f049ed9785c4434

  https://gitlab.com/berrange/qemu/-/jobs/5069195895

  https://cirrus-ci.com/task/5135339078025216

The cirrus CI job page looks to be picking up the elevated timeout.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


