Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E2A710E4E
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:27:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BvM-0002vY-7E; Thu, 25 May 2023 10:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q2BvH-0002v6-Uh
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q2BvD-0001Nz-Lb
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dU8sdSLr2/b8yCV1X78hSmmrTpxqmBRSnlffKFh5rlw=;
 b=YuuFWWYwrQ9RWJMpZ4lmYezWclfNdApPYYyLE3ObCtbmmzIr8PYxwWthqBG70DyvpCSdeM
 Xw5rDPvT86GdqWmpRzXgKBvmbECMgEqUvZ95CRudQLiU4VZm6E+YGxxPNB5xI8+U7X1zxQ
 GBekCr6ayqoLQq2vWV/y/G4sR4kAOoM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-IaNKP-tFP8iaXQoC4ERAdw-1; Thu, 25 May 2023 10:26:28 -0400
X-MC-Unique: IaNKP-tFP8iaXQoC4ERAdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24455101A55C;
 Thu, 25 May 2023 14:26:28 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B4F6C154D1;
 Thu, 25 May 2023 14:26:27 +0000 (UTC)
Date: Thu, 25 May 2023 09:26:25 -0500
From: Eric Blake <eblake@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?Sm/Do28=?= Silva <jsilva@suse.de>, 
 Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>, 
 Dario Faggioli <dfaggioli@suse.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [RFC PATCH 3/6] Convert query-block/info_block to coroutine
Message-ID: <i2zakx3qtd5kodcay6uablx7pawdkx2sh2pl33ump4ssxwhuiv@z7auumqij7ry>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523213903.18418-4-farosas@suse.de>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, May 23, 2023 at 06:39:00PM -0300, Fabiano Rosas wrote:
> From: Lin Ma <lma@suse.com>
> 
> Sometimes the query-block performs time-consuming I/O(say waiting for
> the fstat of NFS complete), So let's make this QMP handler runs in a
> coroutine.

Grammar suggestions:

Sometimes the query-block command performs time-consuming I/O (say
waiting for the fstat of NFS to complete), so let's make this QMP
handler run in a coroutine.

> 
> The following patch moves the fstat() into a thread pool.
> 
> Signed-off-by: Lin Ma <lma@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

> ---
> +++ b/qapi/block-core.json
> @@ -838,7 +838,7 @@
>  #    }
>  ##
>  { 'command': 'query-block', 'returns': ['BlockInfo'],
> -  'allow-preconfig': true }
> +  'allow-preconfig': true, 'coroutine': true }

Rereading docs/devel/qapi-code-gen.rst:

| Coroutine safety can be hard to prove, similar to thread safety.  Common
| pitfalls are:
| 
| - The global mutex isn't held across ``qemu_coroutine_yield()``, so
|   operations that used to assume that they execute atomically may have
|   to be more careful to protect against changes in the global state.
| 
| - Nested event loops (``AIO_WAIT_WHILE()`` etc.) are problematic in
|   coroutine context and can easily lead to deadlocks.  They should be
|   replaced by yielding and reentering the coroutine when the condition
|   becomes false.
| 
| Since the command handler may assume coroutine context, any callers
| other than the QMP dispatcher must also call it in coroutine context.
| In particular, HMP commands calling such a QMP command handler must be
| marked ``.coroutine = true`` in hmp-commands.hx.

I agree that you also need to change the HMP handler, but the commit
message didn't mention that other than in the subject line.  The
commit message could also do a better job at explaining how you have
audited that merely adding the coroutine marker is safe (ie. that all
of the calls made by query_block are already coroutine safe).  While
the intent behind this patch is on the right track, I'm not sure if I
have enough information to say whether it is safe, or if there are
other lurking problems we will need to fix first.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


