Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B307A4B70
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:15:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFxk-0000Qe-1V; Mon, 18 Sep 2023 11:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiFxi-0000QH-K4
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiFxg-0001HD-KD
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695050095;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mBi+GrP/fMicAK+eyLMmb1BmHNQhtP+f4qKX83WfSpQ=;
 b=TGpUB07uRH78LiV2iPJpcy4RRpoFvA8IgbkJIEbU5Aub3+d28xIBmQ8z0G+NgGFFL2b8bL
 UEW/Y8659JqEcDP2FCBbCYzYsnLAZfF2tth5avUlXan7GlAcDvIJvixs0nUS2sKVBxvnoE
 KerdSnf/PhyKOMH5D5oH/CglbuwKbeA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-omWYfzXZN2SPx_BiUsdI-g-1; Mon, 18 Sep 2023 11:14:52 -0400
X-MC-Unique: omWYfzXZN2SPx_BiUsdI-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4A233800BA5;
 Mon, 18 Sep 2023 15:14:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EA1A170EC;
 Mon, 18 Sep 2023 15:14:50 +0000 (UTC)
Date: Mon, 18 Sep 2023 16:14:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: kkostiuk@redhat.com, michael.roth@amd.com, qemu-devel@nongnu.org,
 hmodi@aviatrix.com
Subject: Re: [PATCH 2/3] qga: Add optional stream-output argument to guest-exec
Message-ID: <ZQhpZ+2doxD7vaR8@redhat.com>
References: <cover.1695034158.git.dxu@dxuuu.xyz>
 <604ef5fd5bda8acdb837b5d28ec405e9fb0332a3.1695034158.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <604ef5fd5bda8acdb837b5d28ec405e9fb0332a3.1695034158.git.dxu@dxuuu.xyz>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

On Mon, Sep 18, 2023 at 04:54:22AM -0600, Daniel Xu wrote:
> Currently, commands run through guest-exec are "silent" until they
> finish running. This is fine for short lived commands. But for commands
> that take a while, this is a bad user experience.
> 
> Usually long running programs know that they will run for a while. To
> improve user experience, they will typically print some kind of status
> to output at a regular interval. So that the user knows that their
> command isn't just hanging.
> 
> This commit adds support for an optional stream-output parameter to
> guest-exec. This causes subsequent calls to guest-exec-status to return
> all buffered output. This allows downstream applications to be able to
> relay "status" to the end user.
> 
> If stream-output is requested, it is up to the guest-exec-status caller
> to keep track of the last seen output position and slice the returned
> output appropriately. This is fairly trivial for a client to do. And it
> is a more reliable design than having QGA internally keep track of
> position -- for the cases that the caller "loses" a response.

I can understand why you want this incremental output facility,
but at the same time I wonder where we draw the line for QGA
with users needing a real shell session instead.

When there is a long lived command, then IMHO it is also likely
that there will be a need to kill the background running command
too.

We quickly end up re-inventing a shell in QGA if we go down this
route.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


