Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A3BB94798
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Sep 2025 07:51:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0vtx-0000ae-WD; Tue, 23 Sep 2025 01:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0vts-0000aA-Mo
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 01:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0vto-0004HA-04
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 01:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758606548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+muTdS5Q37hSYqjB2kwKc1m/VXhNp5C1/9gn16SrAyQ=;
 b=RaAN4U74sMxMdDgt/vFTW9nlD/N6dCSgMcbxPkGm3wmT4SJiYesfn7GPsrb2v8hokyTUQd
 CLgzRqldhTgf8BHEtl5eeSUFJ80O5kXnqiOhbhsnEmfyV0srNtMNjNGyN+t8Gt3gfMC2wd
 MYeG8bsoB/l/pPsnWwM75VVTKscV14I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-K23I_-ZWP5C7JPL8CUqm7w-1; Tue,
 23 Sep 2025 01:49:06 -0400
X-MC-Unique: K23I_-ZWP5C7JPL8CUqm7w-1
X-Mimecast-MFC-AGG-ID: K23I_-ZWP5C7JPL8CUqm7w_1758606545
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DBFB18004D4; Tue, 23 Sep 2025 05:49:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 381D3195608E; Tue, 23 Sep 2025 05:49:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5BDD821E6A27; Tue, 23 Sep 2025 07:49:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Fabiano
 Rosas <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest: optimize qtest_get_machines
In-Reply-To: <9136ecc5-a6cb-4c16-a0a5-a9090790667f@oracle.com> (Steven
 Sistare's message of "Mon, 22 Sep 2025 14:22:05 -0400")
References: <1758290310-349623-1-git-send-email-steven.sistare@oracle.com>
 <87frchtx5j.fsf@pond.sub.org>
 <9136ecc5-a6cb-4c16-a0a5-a9090790667f@oracle.com>
Date: Tue, 23 Sep 2025 07:49:02 +0200
Message-ID: <87ecrxg1m9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Steven Sistare <steven.sistare@oracle.com> writes:

> On 9/20/2025 3:12 AM, Markus Armbruster wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> qtest_get_machines returns the machines supported by the QEMU binary
>>> described by an environment variable and caches the result.  If the
>>> next call to qtest_get_machines passes the same variable name, the cached
>>> result is returned, but if the name changes, the caching is defeated.
>>> To make caching more effective, remember the path of the QEMU binary
>>> instead.  Different env vars, eg QTEST_QEMU_BINARY_SRC and
>>> QTEST_QEMU_BINARY_DST, usually resolve to the same path.
>>>
>>> Before the optimization, the test /x86_64/migration/precopy/unix/plain
>>> exec's QEMU and calls query-machines 3 times.  After optimization, that
>>> only happens once.  This does not significantly speed up the tests, but
>>> it reduces QTEST_LOG output, and launches fewer QEMU instances, making
>>> it easier to debug problems.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> 
>> I guess this is a followup to an observation I made during review of my
>> [PATCH 1/5] qtest/qom-test: Plug memory leak with -p:
>> 
>>      Message-ID: <87h5ymdzrf.fsf@pond.sub.org>
>>      https://lore.kernel.org/qemu-devel/87h5ymdzrf.fsf@pond.sub.org/
>> 
>> Appreciated!
>
> In truth, this new patch is not intended to reduce leaks.  If it does,
> that is a bonus :)

Harmless misunderstanding!  During review of my patch (which we didn't
take, because it was incomplete and flawed), I pointed out the cache
thrashing your patch fixes.  That's all.


