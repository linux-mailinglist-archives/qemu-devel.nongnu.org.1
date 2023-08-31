Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D678878E8C7
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:51:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbdOj-0000cI-9y; Thu, 31 Aug 2023 04:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbdOg-0000bV-FR
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbdOe-0004w3-3Q
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693471879;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+pxVPXDivJQS62U0a5vP8mdOFCflUavAzwUNylS6lq0=;
 b=MRD9cUHHGcCf807oKt+r3N52QOCwS/zVOo6xT4THerP+VL38K0MguwYGxQk6oSMwp+aXPG
 JokqTOYHE0TnUAqsbkxyAQfM4QWSoqoFzr8WsPV+r58WuVJdu0lwSiyRRLJrGEEw0wvlhi
 LI4N3JjUYAc5zK+TtmGgdlGHE3mgaVQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-809U_OAUOUmouFn0uWz1Og-1; Thu, 31 Aug 2023 04:51:18 -0400
X-MC-Unique: 809U_OAUOUmouFn0uWz1Og-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF3AC80C908
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 08:51:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A8F92026D35;
 Thu, 31 Aug 2023 08:51:17 +0000 (UTC)
Date: Thu, 31 Aug 2023 09:51:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 02/10] meson: update unsupported host/CPU messages
Message-ID: <ZPBUg6EBOJQeXoCI@redhat.com>
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-3-pbonzini@redhat.com>
 <ZO3JyOmbfrLmD6pd@redhat.com>
 <CABgObfbjQjDc1pgPRVLeaVn8MS4_G4Mhve6kyVFqAVaBjTO6gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfbjQjDc1pgPRVLeaVn8MS4_G4Mhve6kyVFqAVaBjTO6gw@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Thu, Aug 31, 2023 at 10:20:26AM +0200, Paolo Bonzini wrote:
> On Tue, Aug 29, 2023 at 12:34 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > I think I agree wrt to CPUs, but in the case of OS I think
> > it is fairly accurate as-is.
> 
> Ok, I wanted to leave out the "*intends* to remove support" part,
> which is too strong; but I agree that keeping some kind of "support
> may go away in future releases unless you act" is a good idea.

Yeah, making the language a little more fuzzy would be ok.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


