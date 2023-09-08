Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D18A798B18
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 18:56:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeelP-0000tk-GS; Fri, 08 Sep 2023 12:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeelN-0000rl-7o
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeelK-0006wx-Qu
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694192117;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=U2KLxjdZozdaJ9sDG2HXmJ96NiAVNagn9HPIrHmS6X8=;
 b=DvK3kHipe8q1FSfKWcZ9GlRbutfSLOs4c/k1OI6JaMVHNOpipRJ4sURaMLJqS6r1ytTQzv
 Ryo0dssxEroh4gUvKM2Qdy98Smd03WoXxuDX4KJpdOjoQjkUJHAfh16b7LiSNlJWfOmMFe
 oOid8droS/TbMxNv3k0PbBybcO3Sga0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-ts5MVG3RMpi5W0urwmGwgQ-1; Fri, 08 Sep 2023 12:55:15 -0400
X-MC-Unique: ts5MVG3RMpi5W0urwmGwgQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EE858279A4;
 Fri,  8 Sep 2023 16:55:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 827352026D2C;
 Fri,  8 Sep 2023 16:55:14 +0000 (UTC)
Date: Fri, 8 Sep 2023 17:55:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Tim Wiederhake <twiederh@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 00/10] Generate x86 cpu features
Message-ID: <ZPtR8BQquJ3BRgPH@redhat.com>
References: <20230908124534.25027-1-twiederh@redhat.com>
 <20230908164846.184aba1c@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908164846.184aba1c@imammedo.users.ipa.redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

On Fri, Sep 08, 2023 at 04:48:46PM +0200, Igor Mammedov wrote:
> On Fri,  8 Sep 2023 14:45:24 +0200
> Tim Wiederhake <twiederh@redhat.com> wrote:
> 
> > Synchronizing the list of cpu features and models with qemu is a recurring
> > task in libvirt. For x86, this is done by reading qom-list-properties for
> > max-x86_64-cpu and manually filtering out everthing that does not look like
> > a feature name, as well as parsing target/i386/cpu.c for cpu models.
> 
> modulo fixing typos/name conflicts in 1st 3 patches,
> 
> I don't think it's a great idea for libvirt (or any other user) to parse
> QEMU source (whether it's C code or yaml) or other way around for users
> to influence QEMU internals.

NB It isn't for libvirt to parse at runtime, rather it is for libvirt
maintainers to consume during dev, so libvirt keeps in sync with QEMU
features.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


