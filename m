Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 305A794AF2B
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Aug 2024 19:52:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbkpK-0007hA-45; Wed, 07 Aug 2024 13:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbkpH-0007Fv-Bc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbkpF-0000rA-88
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723053112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tjtJZnsCwKGBU7+faKgvEX9QKCYE3Q/W8aTyuLEQb9I=;
 b=NLF32rB6lMLgJDRDHU8jgBZKLNcFYd5Wg4mhrwr3C3KT4YGN3eQ3eE5G3nlqOjhPzF8oyy
 MFTOtwViEO5Q53yR5sffK/AbSXVr0Bxvz7jTpAw9KL4FwAwLY1RtTyr7IAMnj0k722qXNE
 ytLNB0HiZ15KolSQYQtWo1TxYGBqzU0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-c7-hAANYPMaZaqE5QqlZNw-1; Wed,
 07 Aug 2024 13:51:50 -0400
X-MC-Unique: c7-hAANYPMaZaqE5QqlZNw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 026A41956095; Wed,  7 Aug 2024 17:51:50 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 047DA19560A3; Wed,  7 Aug 2024 17:51:48 +0000 (UTC)
Date: Wed, 7 Aug 2024 12:51:46 -0500
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH for-9.1 0/2] NBD: don't print raw server error text to
 terminal
Message-ID: <zdteerkybfw4edllrhniov5myf6lwsrjvsze5mcudm2wqtvwlc@42arzwa6mz6s>
References: <20240802194156.2131519-4-eblake@redhat.com>
 <dkp3je5pohqlrxqrbzwd7maxgljr4gknhlmorae6ihi3vx2t4u@z3vvc5ml7vwj>
 <20240805191131.GE1450@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805191131.GE1450@redhat.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Aug 05, 2024 at 08:11:31PM GMT, Richard W.M. Jones wrote:
> On Mon, Aug 05, 2024 at 01:48:12PM -0500, Eric Blake wrote:
> > On Fri, Aug 02, 2024 at 02:26:04PM GMT, Eric Blake wrote:
> > > I've requested a CVE from Red Hat, and hope to have an assigned number
> > > soon.  Meanwhile, we can get review started, to make sure this is
> > > ready to include in 9.1.  'qemu-img info' should never print untrusted
> > > data in a way that might take over a user's terminal.
> > > 
> > > There are probably other spots where qemu-img info is printing
> > > untrusted data (such as filenames), where we probably ought to use the
> > > same sanitization tactics as shown here.  Identifying those spots
> > > would be a useful part of this review, and may mean a v2 that is even
> > > more extensive in the number of patches.
> > 
> > In fact, should we insist that 'qemu-img info XXX' refuse to accept
> > any control characters on any command-line filename, and that it
> > reject any backing file name with control characters as a malformed
> > qcow2 file?  For reference, we JUST fixed qemu-img info to change
> > qcow2 files with a claimed backing file of json:... to favor the local
> > file ./json:... over the potentially dangerous user-controlled
> > format/protocol description, so we are _already_ changing how strict
> > qemu-img is for 9.1, and adding one more restriction to avoid
> > escape-sequence madness makes sense.
> > 
> > Note that with:
> > 
> > touch $'\e[m' && qemu-img info --output=json $'\e[m'
> > 
> > we already escape our output, but without --output=json, we are
> > vulnerable to user-controlled ESC leaking through to stdout for more
> > than just the NBD server errors that I addressed in v1 of this patch
> > series.  Hence my question on whether v2 of the series should touch
> > more places in the code, and whether doing something like flat-out
> > refusing users stupid enough to embed control characters in their
> > filenames is a safe change this close to release.
> 
> You could say if someone gives you a "malicious" text file which you
> cat to stdout, it could change your terminal settings.  I don't think
> therefore any of this is very serious.  We should probably fix any
> obvious things, but it doesn't need to happen right before 9.1 is
> released, we can take our time.

After consulting with Red Hat security, they agree: their decision at
this time is that any CVE related to escape sequences taking over a
terminal would best be filed against the terminal and/or shell that
allowed the escape, rather than against every single app that can
produce such pass-through output.  So at this time they were unwilling
to issue a CVE against qemu for this particular issue, and I will
clean up the subject line for v2.

So I agree that cleaning up low-hanging fruit is still worth it, but
no longer a reason to rush this series into 9.1.  If it still gets a
timely positive review, I can include it alongside the other NBD
patches (we are fixing a CVE with qemu hitting SEGV on
nbd-server-stop).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


