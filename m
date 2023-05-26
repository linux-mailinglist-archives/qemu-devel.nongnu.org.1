Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEBD712474
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 12:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2UYs-000441-4v; Fri, 26 May 2023 06:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2UYg-0003hw-7g
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2UYe-0002uk-KX
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685096428;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EwtrQOAHzNxsWIQD26QSVnBkoYwEP1YloOMRNw1fFE0=;
 b=YNkoOW3ubEFi1DaFjAcrcxprnD7b/+VTlzGwHCeZkc+GyuER637gqzegphGklYRBFPDP6k
 WI3U8nqG2R6YWcZYnwXHssrbN4kjGs6U/taBkRd9rIMtEV78nXworP8OfBvMgPzbVSbkiZ
 awQ0tdbR4Z6SXM+HSBhKWzYEnD/ttLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-RuztFnk7NQivoeNQJtY7og-1; Fri, 26 May 2023 06:20:26 -0400
X-MC-Unique: RuztFnk7NQivoeNQJtY7og-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D11285A5B5;
 Fri, 26 May 2023 10:20:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C30640CFD45;
 Fri, 26 May 2023 10:20:25 +0000 (UTC)
Date: Fri, 26 May 2023 11:20:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH 1/5] gitlab: centralize the container tag name
Message-ID: <ZHCH577CiN67vla5@redhat.com>
References: <20230517135448.262483-1-berrange@redhat.com>
 <20230517135448.262483-2-berrange@redhat.com>
 <0626bd64-581b-0324-a1d7-8eee741fc08f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0626bd64-581b-0324-a1d7-8eee741fc08f@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, May 26, 2023 at 09:25:39AM +0200, Thomas Huth wrote:
> On 17/05/2023 15.54, Daniel P. Berrangé wrote:
> > We use a fixed container tag of 'latest' so that contributors' forks
> > don't end up with an ever growing number of containers as they work
> > on throwaway feature branches.
> > 
> > This fixed tag causes problems running CI upstream in stable staging
> > branches, however, because the stable staging branch will publish old
> > container content that clashes with that needed by primary staging
> > branch. This makes it impossible to reliably run CI pipelines in
> > parallel in upstream for different staging branches.
> > 
> > This introduces $QEMU_CI_CONTAINER_TAG global variable as a way to
> > change which tag container publishing uses. Initially it can be set
> > by contributors as a git push option if they want to override the
> > default use of 'latest' eg
> > 
> >    git push gitlab <branch> -o ci.variable=QEMU_CONTAINER_TAG=fish
> > 
> > this is useful if contributors need to run pipelines for different
> > branches concurrently in their forks.

> 
> This patch no longer applies ... could you please rebase and resend a v2?
> Thanks!

I've rebased and sent a v2, but I didn't get any conflits when
rebasing, so v1 should have applied OK.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


