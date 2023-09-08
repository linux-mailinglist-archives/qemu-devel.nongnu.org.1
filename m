Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F07986F2
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:19:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaSS-0000Pk-1e; Fri, 08 Sep 2023 08:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeaSN-0000Ny-3Q
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeaSH-0005ge-70
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694175560;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rL7NY/jEU9GL8QLcasB+zoyeFo09WfNF6UjfQJuE8g=;
 b=Ujxk7AhkhF8cGZ0SkU80Rynq8ufC836k6hwA647osRXeMKlSHbWdrt83D4V2yxkV/RZx/w
 38YVf22VOkW8qJygIDAPfmkmmfFThmqjAk0nE3zy9m3X1ffizB0k1HY5jOVO7mQQk1o+Sg
 XGySDFdGMsfUBQVwKXAZEw3AD779Wxs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-P4dG_mFlOyeOFMV2C2YqJA-1; Fri, 08 Sep 2023 08:19:17 -0400
X-MC-Unique: P4dG_mFlOyeOFMV2C2YqJA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45504101A529;
 Fri,  8 Sep 2023 12:19:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B73E493112;
 Fri,  8 Sep 2023 12:19:15 +0000 (UTC)
Date: Fri, 8 Sep 2023 13:19:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 William Tsai <williamtsai1111@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 0/1] qom: fix setting of qdev array properties
Message-ID: <ZPsRQbj39h3RCuEr@redhat.com>
References: <20230904162544.2388037-1-berrange@redhat.com>
 <ZPbt0io6He9mE2SB@redhat.com> <87edja9vkr.fsf@pond.sub.org>
 <CAFEAcA-OVUqhwUprR2MJW24yxWpvz9zxv7u7iGqnYhtaGNM96w@mail.gmail.com>
 <ZProov27HNpHmz5j@redhat.com> <ZPrpCBa9ZWMweHqT@redhat.com>
 <ZPsQo21JwhtGBMMN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPsQo21JwhtGBMMN@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Sep 08, 2023 at 02:16:35PM +0200, Kevin Wolf wrote:
> Am 08.09.2023 um 11:27 hat Daniel P. Berrangé geschrieben:
> > On Fri, Sep 08, 2023 at 11:25:54AM +0200, Kevin Wolf wrote:
> > > Am 07.09.2023 um 11:35 hat Peter Maydell geschrieben:
> > > > On Thu, 7 Sept 2023 at 10:33, Markus Armbruster <armbru@redhat.com> wrote:
> > > > >
> > > > > Kevin Wolf <kwolf@redhat.com> writes:
> > > > >
> > > > > > Am 04.09.2023 um 18:25 hat Daniel P. Berrangé geschrieben:
> > > > > >> By the time of the 8.2.0 release, it will have been 2 years and 6
> > > > > >> releases since we accidentally broke setting of array properties
> > > > > >> for user creatable devices:
> > > > > >>
> > > > > >>   https://gitlab.com/qemu-project/qemu/-/issues/1090
> > > > > >
> > > > > > Oh, nice!
> > > > >
> > > > > Nice?  *Awesome*!
> > > > >
> > > > > > Well, maybe that sounds a bit wrong, but the syntax that was broken was
> > > > > > problematic and more of a hack,
> > > > >
> > > > > A monstrosity, in my opinion.  I tried to strangle it in the crib, but
> > > > > its guardians wouldn't let me.  Can dig up references for the morbidly
> > > > > curious.
> > > > 
> > > > I don't care about the syntax on the command line much (AFAIK that's
> > > > just the rocker device). But the actual feature is used more widely
> > > > within QEMU itself for devices created in C code, which is what it
> > > > was intended for. If you want to get rid of it you need to provide
> > > > an adequate replacement.
> > > 
> > > I have a patch to use QList (i.e. JSON lists) that seems to work for the
> > > rocker case. Now I need to find and update all of those internal
> > > callers. Should grepping for '"len-' find all instances that need to be
> > > changed or are you aware of other ways to access the feature?
> > 
> > IMHO we can just leave the internal only code callers unchanged. I was
> > about to send this patch to prevent usage leaking into user creatable
> > devices:
> > [...]
> 
> The bug report is about a user creatable device (rocker) that doesn't
> work any more, so forbidding the case entirely doesn't really improve
> the situation.

Oh, sure we still need to patch rocker.c to make it use a QAPI friendly
way of accepting the list of devices.

The forbidding patch was just to proactively prevent the bad design
practice recurring in the future.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


