Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 022EC7E0268
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 12:56:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyslI-0004Ff-Dz; Fri, 03 Nov 2023 07:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyslH-0004FA-6U
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 07:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyslC-0007Qj-Fd
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 07:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699012483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p5P6rdhDQl3b3SrcXIzXcg6iSux+XwU+I8Q2XZYQjRg=;
 b=QcPfVrh3sjjDFO11gAnJlHjjM1mxd1NNOkRc4Rp4ih3iDKZcXaOF+c8D5f9wQWDE2MElhz
 /T+disxGN8H/g1SyKbTnjCdG0pxhliiH+s5NixlRDkDjbzt4/IrNeSKdLVAI6VVS7gyRLI
 j46DN1L0JzPhQmjgUdw4BeJT9Ktvzd4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-FV0meGJoPriHqyI6QHYAiA-1; Fri,
 03 Nov 2023 07:54:40 -0400
X-MC-Unique: FV0meGJoPriHqyI6QHYAiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB3213C025BB;
 Fri,  3 Nov 2023 11:54:39 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD0E65031;
 Fri,  3 Nov 2023 11:54:37 +0000 (UTC)
Date: Fri, 3 Nov 2023 12:54:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eblake@redhat.com, hreitz@redhat.com,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
Message-ID: <ZUTffE0wfjLH2u+e@redhat.com>
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
 <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
 <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru>
 <87o7gbyy8w.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7gbyy8w.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 03.11.2023 um 10:36 hat Markus Armbruster geschrieben:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
> > On 11.10.23 13:18, Fiona Ebner wrote:
> >> Am 10.10.23 um 19:55 schrieb Vladimir Sementsov-Ogievskiy:
> >>> On 09.10.23 12:46, Fiona Ebner wrote:
> >>>>
> >>>> Initially, I tried to go for a more general 'job-change' command, but
> >>>> I couldn't figure out a way to avoid mutual inclusion between
> >>>> block-core.json and job.json.
> >>>>
> >>>
> >>> What is the problem with it? I still think that job-change would be better.
> >>>
> >> If going for job-change in job.json, the dependencies would be
> >> job-change -> JobChangeOptions -> JobChangeOptionsMirror -> MirrorCopyMode
> >> query-jobs -> JobInfo -> JobInfoMirror
> >> and we can't include block-core.json in job.json, because an inclusion
> >> loop gives a build error.
> 
> Let me try to understand this.
> 
> Command job-change needs its argument type JobChangeOptions.
> 
> JobChangeOptions is a union, and JobChangeOptionsMirror is one of its
> branches.
> 
> JobChangeOptionsMirror needs MirrorCopyMode from block-core.json.
> 
> block-core.json needs job.json for JobType and JobStatus.
> 
> >> Could be made to work by moving MirrorCopyMode (and
> >> JobChangeOptionsMirror, JobInfoMirror) to job.json or some place that
> >> can be included by both job.json and block-core.json. Moving the
> >> type-specific definitions to the general job.json didn't feel right to
> >> me. Including another file with type-specific definitions in job.json
> >> feels slightly less wrong, but still not quite right and I didn't want
> >> to create a new file just for MirrorCopyMode (and
> >> JobChangeOptionsMirror, JobInfoMirror).
> >> And going further and moving all mirror-related things to a separate
> >> file would require moving along things like NewImageMode with it or
> >> create yet another file for such general things used by multiple block-jobs.
> >> If preferred, I can try and go with some version of the above.
> >> 
> >
> > OK, I see the problem. Seems, that all requires some good refactoring. But that's a preexisting big work, and should not hold up your series. I'm OK to proceed with block-job-change.
> 
> Saving ourselves some internal refactoring is a poor excuse for
> undesirable external interfaces.

I'm not sure how undesirable it is. We have block-job-* commands for
pretty much every other operation, so it's only consistent to have
block-job-change, too.

Having job-change, too, might be nice in theory, but we don't have even
a potential user for it at this point (i.e. a job type that isn't a
block job, but for which changing options at runtime makes sense).

> We need to answer two questions before we do that:
> 
> 1. How much work would the refactoring be?
> 
> 2. Is the interface improvement this enables worth the work?
> 
> Let's start with 1.
> 
> An obvious solution is to split JobType and JobStatus off job.json to
> break the dependency of block-core.json on job.json.
> 
> But I'd like us to investigate another one.  block-core.json is *huge*.
> It's almost a quarter of the entire QAPI schema.  Can we spin out block
> jobs into block-job.json?  Moves the dependency on job.json from
> block-core.json to block-job.json.

It also makes job.json depend on block-job.json instead of
block-core.json, so you only moved the problem without solving it.

Kevin


