Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F737CE008
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:35:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7dx-0001M3-OW; Wed, 18 Oct 2023 10:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qt7dr-0001Li-VV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qt7dp-0000MT-Gk
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697639719;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TWivLTmUK3qx56vDoP6C6FRISnagT5ZKZi9DXM8G0vA=;
 b=TfCMaSaVg+AZboRJVuYIA2JgbunnHvguFR9UOMzTR3SyZOvY2+3YY0qQf8ZrU63Y4yf2Gq
 drB3nuAEDiI1Y5cvRVdPFSze9pdYfCmUXJKlG6zcUyuDS/qDEmphT7CmvyDVpa3SaOj04z
 Io37ThYYaIGfJ5E6rQ4i7OINCzJeSM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-qYKuzgknPmG1XAxIbD-DFQ-1; Wed, 18 Oct 2023 10:35:16 -0400
X-MC-Unique: qYKuzgknPmG1XAxIbD-DFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17A65185A7B2;
 Wed, 18 Oct 2023 14:35:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF1E6909;
 Wed, 18 Oct 2023 14:35:14 +0000 (UTC)
Date: Wed, 18 Oct 2023 15:35:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 00/11] tests/migration-test: Allow testing older
 machine types
Message-ID: <ZS/tIJt7uqm/XUK3@redhat.com>
References: <20231018140736.3618-1-farosas@suse.de>
 <87jzrkdne2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzrkdne2.fsf@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

On Wed, Oct 18, 2023 at 11:19:01AM -0300, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > This adds support for running migration-test with two different QEMU
> > versions to test migration compatibility. The tests automatically
> > choose the latest machine type supported by both QEMU versions.
> 
> Let me point out two situations that came up while developing this:
> 
> 1) There was a generic command line change in QEMU (-audio option)
>    introduced this cycle that was ported to the command line used by
>    libqtest.c. This means that when using the same command line to
>    start both guests, the older one will not recognize the option and
>    will break.
> 
>    Ideally, we would keep command lines out of the library and require
>    each test to provide their own. Then maybe the migration code could
>    cope with the change somehow.

Right the problem is that QEMU doesn't provide a long term stable
API, but has finite sliding windows where QEMU versions can be
compatible in their CLI, determined by our minimal deprecation
period of 2 releases.

eg you can come up with a CLI that is compatible for all of 7.1, 7.2
and 8.0 but you can't neccessarily come up with a CLI that is compatible
for all of 7.1, 7.2, 8.0 and 8.1 because the lifespan of that set of
versions is greater than our deprecation period.

If we did't use -audio in libqtest, we could be compatible with current
QEMU and some old QEMUs, but not future QEMU.

If we do use -audio in libqtest, we could be compatible with current
QEMU and some future QEMUs, but not old QEMUs.

This is a no win scenario.

Now, libvirt provides a long term stable configuration for QEMU that
transcends changes in QEMU CLI.

So we could come up with a live migration test between QEMU's of an
arbitrary age difference, if we used libvirt to drive the process.
That wouldn't really be qtest though. Could perhaps we done in the
context of avocado, if we used the libvirt-python API binding, but
this would be different from other avocado tests by virtue of not
using the QEMU python classes for launch.

> 2) When fixing an issue during a release cycle, that issue can still
>    show up on the next one when using this series to test
>    compatibility. There's probably not much we can do here, but
>    remember the issues that were already fixed and ignore them when
>    they appear in these compatibiliy tests.
> 
> I don't see how to avoid the situations above, but I think their
> existence implies we cannot enable by default any sort of migration
> compatibility testing that uses a live guest.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


