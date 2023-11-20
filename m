Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8692C7F2163
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 00:25:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5DcA-0000Vy-W9; Mon, 20 Nov 2023 18:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r5Dc8-0000VY-F5
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 18:23:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r5Dc5-0001K4-Uo
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 18:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700522612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OjvB5XaG6FkII6vnZ4jyOLOtBjWKvMTzHv6LnzAVYqk=;
 b=MYGPml/ouIWqYB2HGMi4BNdoygp7CPTSG8W+Os5O823OTeRf0KQD8SubmK61ItnW3wRR9F
 k36nW0Eg+pYaEBAGaRsfYlXSGSqAlHta8OcOTTBhjFbyDiy87OGXN3e7gMngHQqrnO3fIl
 4atqa9GlVRY99UNWOwdQavxEBshheko=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-RDNtR6tlOJa1pZriWZAxJw-1; Mon, 20 Nov 2023 18:23:30 -0500
X-MC-Unique: RDNtR6tlOJa1pZriWZAxJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F422085A58A;
 Mon, 20 Nov 2023 23:23:29 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF4592166B27;
 Mon, 20 Nov 2023 23:23:28 +0000 (UTC)
Date: Mon, 20 Nov 2023 17:23:27 -0600
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: Converting images to stdout
Message-ID: <6hipeyoml7qpxcycxbydmldohcwsle56tpeavzddpciycb4vfm@gmr7uf56skye>
References: <ZVZV2ZKcxoSargry@zeus.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVZV2ZKcxoSargry@zeus.local>
User-Agent: NeoMutt/20231103
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Nov 16, 2023 at 06:48:09PM +0100, Alberto Garcia wrote:
> Hi,
> 
> I haven't written here in a while :) but I have something small that I
> would like to discuss.
> 
> Using qemu-img to convert an image and writing the result directly to
> stdout is a question that has already been raised in the past (see
> [1] for an example) and it's clear that it's generally not possible
> because the images need to be seekable.
> 
> While I think that there's almost certainly no generic way to do
> something like that for every combination of input and output formats,
> I do think that it should be relatively easy to produce a qcow2 file
> directly to stdout as long as the input file is on disk.

Indeed, it does seem like this should be easy enough to cobble together.

> 
> I'm interested in this use case, and I think that the method would be
> as simple as this:
> 
> 1. Decide a cluster size for the output qcow2 file.
> 2. Read the input file once to determine which clusters need to be
>    allocated in the output file and which ones don't.
> 3. That infomation is enough to determine the number and contents of
>    the refcount table, refcount blocks, and L1/L2 tables.
> 4. Write the qcow2 header + metadata + allocated data to stdout.

It may also be possible to write a qcow2 file that uses the external
data bit, so that you are only writing the qcow2 header + metadata,
and reusing the existing input file as the external data.

> 
> Since this would be qcow2-specific I would probably implement this as
> a separate tool instead of adding it directly to qemu-img. This could
> go to the scripts/ directory because I can imagine that such a tool
> could be useful for other people.

Also sounds reasonable.

> 
> Because this would be an external tool it would only support a qcow2
> file with the default options. Other features like compression would
> be out of scope.

Why is compression not viable?  Are you worried that the qcow2
metadata (such as refcounts) becomes too complex?

I've also wondered how easy or hard it would be to write a tool that
can take an existing qcow2 file and defragment and/or compress it
in-place (rather than having to copy it to a second qcow2 file).

> 
> For the same reason the input would be a raw file for simplicity,
> other input files could be presented in raw format using
> qemu-storage-daemon.

Yes, getting seekable input from any other format is easy enough; it's
the streaming output that is the trickier task.

> 
> And that's the general idea, comments and questions are welcome.
> 
> Thanks!
> 
> Berto
> 
> [1] https://lists.nongnu.org/archive/html/qemu-discuss/2020-01/msg00014.html
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


