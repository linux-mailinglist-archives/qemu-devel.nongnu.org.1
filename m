Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DC47B070D
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 16:37:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlVeL-0003Jg-Iv; Wed, 27 Sep 2023 10:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlVeK-0003JG-Bx
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlVeI-00080P-OK
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695825381;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hT0+ALZ5tglsVtxm9oroqnpwzSjZuDjW7uHcRabRB5Y=;
 b=aslLu3Im3al6xSIfBT0hpmZxmlUAqj0PXYm2VINnhN4nJbTo7RgMKUsnriMAer+STlCgho
 Emvow3XljhJZUFHjqw88doVstvYv4bM13DPhMx/LDOLUffRnOYvVR5TzHoz9OTRmiKAqmS
 AOj62mpY6c7+Md+rWNIj24+w+Sin0jw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-QS90sdpgPdCcJp11Ic0sQQ-1; Wed, 27 Sep 2023 10:36:19 -0400
X-MC-Unique: QS90sdpgPdCcJp11Ic0sQQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54F948039D2;
 Wed, 27 Sep 2023 14:36:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 316B0492C37;
 Wed, 27 Sep 2023 14:36:18 +0000 (UTC)
Date: Wed, 27 Sep 2023 15:36:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Claudio Fontana <cfontana@suse.de>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: migration maintenance, governance [Was: Re: [PATCH V4 0/2]
 migration file URI]
Message-ID: <ZRQ94J9vv83nLI4V@redhat.com>
References: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
 <dba1e07d-6ebf-9329-7be7-4702ff5dc16d@suse.de>
 <1290963e-9f63-fc70-6729-d355d247c2fd@linaro.org>
 <2f5b9774-e089-3606-905a-8b991dcc5e87@suse.de>
 <a4adf886-7018-4cf5-14d6-cd85172ea501@suse.de>
 <9833202a-8060-1e81-208e-4e240279c298@suse.de>
 <ZRQ0nOssnc0rdw6m@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRQ0nOssnc0rdw6m@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Wed, Sep 27, 2023 at 09:56:44AM -0400, Peter Xu wrote:
> Juan will be back next Monday.  Before he left, he told me that he's
> preparing the pull.
> 
> If next week there's still no pull from migration side then I suppose
> someone should start to pick up patches and send PR. I would volunteer
> myself already; I should have already perpared a pull a long time ago if I
> got ack from Juan.  If Fabiano would like to that'll also be nice.  I don't
> know how that works without delegation from the current (solo) maintainer,
> though, for either of us to become a maintainer.

Even if not actively sending a PR, a possible starting point that could
be done today, would be for someone to put up a gitlab.com branch that
contains all the outstanding patch series that are considered ready
to merge and validate a CI pipeline. That would both serve as a base for
further work, and might be useful to Juan in assembling the next pull
request.

> Before that, Fabiano can already propose a patch as at least a Reviewer
> without the need of any delegation from anyone, as he already did lots of
> work in that regard, assume he'll keep doing so to support the migration
> subsystem.

Yes, anyone is free to self-propose themselves as reviewers.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


