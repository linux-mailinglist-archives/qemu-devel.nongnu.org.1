Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7521729720
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZXo-0007oU-JW; Fri, 09 Jun 2023 06:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7ZXm-0007oL-Hx
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7ZXc-0008Hc-Rd
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686307223;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tD4KCWk5BAGDEbrlIyuFbtJ0JHsMVjYkpYM5L+2m5bk=;
 b=eJf5mIBb3v7VBdO7hIZzI22alcc2G4eicvDCBQrMZUfpilzJPP+7EB4iy6UxS/7wYZb6L9
 ZXh6+DoFSoOwRu/3PHtcQp5QTNUy/HBjttwnfeeoZfadZI/ATb55wq2/AVgyAt+tLF2dej
 hCReCGXNSs6CPfcXsF6cK+MEig2qORI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-l8EoQfbzOJqnr_vf2qtdEA-1; Fri, 09 Jun 2023 06:40:20 -0400
X-MC-Unique: l8EoQfbzOJqnr_vf2qtdEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0065B380392B;
 Fri,  9 Jun 2023 10:40:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E39940C1438;
 Fri,  9 Jun 2023 10:40:18 +0000 (UTC)
Date: Fri, 9 Jun 2023 11:40:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 24/42] migration-test: Re-enable multifd_cancel test
Message-ID: <ZIMBjznHKJCMA76s@redhat.com>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-25-quintela@redhat.com>
 <ZILaiceoEZSpJsLe@redhat.com> <87ttvhc4uu.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttvhc4uu.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jun 09, 2023 at 12:22:33PM +0200, Juan Quintela wrote:
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> > On Fri, Jun 09, 2023 at 12:49:25AM +0200, Juan Quintela wrote:
> >
> > Please explain why this is considered ok, given the comment about
> > why it is disabled. ie if we fixed something, refrence the commit.
> 
> I did in the cover letter, will put that on the commit:
> 
> - We used to share dest_serial file for the two targets of migration (to
>   and to2), where we have a race.
> 
> - this series fixes the races in two ways:
> 
>   * we wait for "to" to finish before we launch "to2", so the race can't
>     happen.
> 
>   * One of the reasons why I created GuestState is that I needed a place
>     to store the serial file name (now I call it "target" and "target2").
> 
> - I put on the cover letter that this is not enough, we also need
>   Fabiano fix for the thread list.
> 
> - Peter Mayel was the most vocal about this particular failure, I cc'd
>   him and asked on the cover letter for the people to used to have
>   failures to test.
> 
> So how should I handled this to be clearer?

Details just need to be in the commit message, because cover letters
aren't visible when someone is looking back at 'git log' to find out
why the test was re-enabled.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


