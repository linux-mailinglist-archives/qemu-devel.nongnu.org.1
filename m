Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A16977F45A
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 12:36:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWaMS-0005ZK-1P; Thu, 17 Aug 2023 06:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWaMP-0005Z0-OQ
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWaMN-00049O-ET
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692268570;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2suBasgIqpVdDUTOqVxcmos3NfbX8d23XlJxfPok8CQ=;
 b=Hkt5p5cKXS/37/qVyFb1C4c8SGsQUkDsPpqCEMcQdehutI0WFSUfl7mdez2RTs0FQaq1fh
 agfqZer4YEikk2zbCgwTEcJGEt8Kwu3FWEHl1FofGAMcpy+usPnaQ3zKgU4+9j/7QaM55E
 +e9VFddbFcD4ORLu1U8o1+KCE+RWH5I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-kZdrQruuObyjKMJTBpVE4A-1; Thu, 17 Aug 2023 06:36:07 -0400
X-MC-Unique: kZdrQruuObyjKMJTBpVE4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 432FD85CCE6;
 Thu, 17 Aug 2023 10:36:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53FB56B2AB;
 Thu, 17 Aug 2023 10:36:06 +0000 (UTC)
Date: Thu, 17 Aug 2023 11:36:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 00/12] tests: enable meson test timeouts to improve
 debuggability
Message-ID: <ZN34FJ/VZD13mJLC@redhat.com>
References: <20230717182859.707658-1-berrange@redhat.com>
 <871qgdap1y.fsf@linaro.org>
 <d36baa73-f266-06ab-774c-42e5dc704f7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d36baa73-f266-06ab-774c-42e5dc704f7b@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Aug 13, 2023 at 09:02:03AM +0200, Thomas Huth wrote:
> On 08/08/2023 10.57, Alex Bennée wrote:
> > 
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > Perhaps the most painful of all the GitLab CI failures we see are
> > > the enforced job timeouts:
> > > 
> > >     "ERROR: Job failed: execution took longer than 1h15m0s seconds"
> > > 
> > >     https://gitlab.com/qemu-project/qemu/-/jobs/4387047648
> > > 
> > > when that hits the CI log shows what has *already* run, but figuring
> > > out what was currently running (or rather stuck) is an horrendously
> > > difficult.
> > 
> > I had this in my tree but I see there are a number of review comments to
> > take into account. Will there be a v3 and do we want it this late in the
> > cycle?
> 
> I think this could maybe cause some false positives in the CI until we
> fine-tuned all related timeouts, so no, we don't want to have this in the
> last release candidates of 8.1. We should commit it early in the 8.2 cycle
> (hoping that Daniel has some spare minutes to release a v3), so we can iron
> out the remaining issues there.

Agreed, it is safer to wait until 8.2

I've been away on holiday, but will post a v3 after I catchup


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


