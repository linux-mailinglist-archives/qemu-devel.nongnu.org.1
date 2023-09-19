Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F23C7A5EFF
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:04:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXa4-0006nt-VY; Tue, 19 Sep 2023 06:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiXa0-0006kG-Se
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiXZz-0003TU-03
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695117818;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jhgm9ZzJGTvRCNArC+zoaS3n0jJFVu4Z7S/YFKDQFMM=;
 b=LkkjpsjaPxMFdxnJSJzcChYxi0Qs4gI9NcA4nkTIxjskWwJqH21ORivWZk+B+xPr/Q1yfc
 ekk7Xszk1P4m3VmpD7aRzTWKABfZi2xRM8caRc0a/ZW966mxFf4SaGhAfl7/Bj6IFlmfJI
 o9N0ieb4H9dzK8i2ikY6kSoZ+IpnLkU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-R9GkBU-kObik8hT4WUl5Kg-1; Tue, 19 Sep 2023 06:03:32 -0400
X-MC-Unique: R9GkBU-kObik8hT4WUl5Kg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B0EF29AB407;
 Tue, 19 Sep 2023 10:03:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A531110F1BE7;
 Tue, 19 Sep 2023 10:03:31 +0000 (UTC)
Date: Tue, 19 Sep 2023 11:03:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] Net patches
Message-ID: <ZQlx8UGoLzW0iKpw@redhat.com>
References: <ZPsKUDp7nVS/Z+j2@redhat.com>
 <4508010f-12e8-8565-d091-e8c68ae0493e@ovn.org>
 <ZPsQcu0HYBaTScnb@redhat.com>
 <755f9eb1-d97f-a359-3050-f3289374655b@ovn.org>
 <ZPsscpzj9fNtCEOY@redhat.com>
 <c406b8fb-a2f1-8eb2-abc5-af2474edf940@ovn.org>
 <ZQLAkNPdOA4ncDvF@redhat.com>
 <bfcf7272-c4c9-3b30-28ed-065ee374d681@ovn.org>
 <ZQlebHldXOFZATSo@redhat.com>
 <93d3a6fa-6bad-8765-c78d-3df4a993d202@ovn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93d3a6fa-6bad-8765-c78d-3df4a993d202@ovn.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 19, 2023 at 11:39:31AM +0200, Ilya Maximets wrote:
> On 9/19/23 10:40, Daniel P. Berrangé wrote:
> > On Mon, Sep 18, 2023 at 09:36:10PM +0200, Ilya Maximets wrote:
> >> Thanks!  That worked.  Though I wasn't able to test much anyway as
> >> this thing burned through all my free compute credits less than
> >> half way through the pipeline. :D
> >>
> >> So, AFAIU, it's not something an occasional contributor like me can
> >> use, unless they are spending their own money.
> > 
> > That is not the expected behaviour.
> > 
> > If your repo is a fork of https://gitlab.com/qemu-project/qemu it
> > should benefit from a *massive* x125 reduction on CI costs.
> > 
> > The critical thing is that it *MUST* have been created with the
> > 'Fork' button on qemu-project/qemu.
> 
> Yeah, it might be that the problem is caused by me accidentally
> forking the gitlab.com/qemu/qemu repo instead of qemu-project.
> 
> It is fairly confusing that qemu/qemu is not the main repository
> of QEMU project.  It seems to be some sort of automated account
> and it closely follows updates of the main repository.  It also
> has a better name, and it is *not a fork* of the qemu-project.
> There practically no indication that qemu/qemu is not a main
> repository, except for an icon and a lower star/fork count.
> It's easy to fork the wrong one.
> 
> Do you folks have control over this account?  Could you maybe add
> a description that it is not the official QEMU repository and add
> a link to qemu-project?  Right now qemu-project/qemu states that
> it is a "QEMU main repository", but qemu/qemu doesn't say anything.

The https://gitlab.com/qemu account is a user profile who has
been squatting on that name for a while. I vaguely recall we
tried to claim it with gitlab but because it regularly pushes
code it isn't considered inactive and thus there's nothing we
can do about it :-(


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


