Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 308A471FE07
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:38:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q51EL-0001WX-RQ; Fri, 02 Jun 2023 05:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q51EK-0001UM-0K
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q51EI-0007q9-AL
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685698673;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJiH3+fQb2rgIuu/gNFabUY0bNySEzufb+YpHDfE278=;
 b=gT+r+UgicyAnrzm8dkniYKQ6kawUHaU3b+uqysyoP1/O15Fpux6T/S3e4DPUgrKay6YMGK
 P5f85WYhonbYl2hX3pPozjrYSa3Q+bdHb1bJi1TP+qhMFdYx8FliSMQmkoi/wrg3mkWxok
 BIqSiPBnbuNA9pY9tI1oVa33gTVOH20=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-nGnmg9lNPCyasP627IbfnA-1; Fri, 02 Jun 2023 05:37:52 -0400
X-MC-Unique: nGnmg9lNPCyasP627IbfnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB7EB3C14ABC;
 Fri,  2 Jun 2023 09:37:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6C9340CFD45;
 Fri,  2 Jun 2023 09:37:50 +0000 (UTC)
Date: Fri, 2 Jun 2023 10:37:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Subject: Re: Big TCG slowdown when using zstd with aarch64
Message-ID: <ZHm4bClpMb1ILEE0@redhat.com>
References: <87y1l2rixp.fsf@secure.mitica> <ZHmyA40nIiUBceX0@redhat.com>
 <CAFEAcA_1FF6tBt7C=zfLcSiFPNzSecZkRMtppYbUBjwZPVfbmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_1FF6tBt7C=zfLcSiFPNzSecZkRMtppYbUBjwZPVfbmg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

On Fri, Jun 02, 2023 at 10:22:28AM +0100, Peter Maydell wrote:
> On Fri, 2 Jun 2023 at 10:10, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > I suspect that the zstd logic takes a little bit longer in setup,
> > which allows often allows the guest dirty workload to get ahead of
> > it, resulting in a huge amount of data to transfer. Every now and
> > then the compression code gets ahead of the workload and thus most
> > data is zeros and skipped.
> >
> > IMHO this feels like just another example of compression being largely
> > useless. The CPU overhead of compression can't keep up with the guest
> > dirty workload, making the supposedly network bandwidth saving irrelevant.
> 
> It seems a bit surprising if compression can't keep up with
> a TCG guest workload, though...

The multifd code seems to be getting slower and slower through the
migration. It peaks at 39 mbps, but degrades down to 4 mbps when i
test it.

I doubt that the aarch64 is specifically a problem, rather it is just
affecting timing that exposes some migration issue.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


