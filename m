Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9686579E19A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:09:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKwC-0004zY-I4; Wed, 13 Sep 2023 04:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgKw4-0004zB-Hc
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgKvu-0006F1-Vw
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694592548;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LllN/mhX59r60cqPsDCNWb6IBrN3xEyKO1GfeJGAwMU=;
 b=O7Fkbv7n4x6qCdCBMpGCqqoJq06CSodZoOkDl3m3oamIiNHF0JFgjyMQLpKXz4B4EIaXXL
 sBBJ+JllQPFXwWNpr9hvuWhdoNVimp4P3H6cE7/2kNmCqfKr42mtjNYPB5+xY2afEj83bg
 xTK765+n7gmkKDHVM9nYpF6u5Efq5/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-AN5tlYEWOYyzfdZtNjZsmQ-1; Wed, 13 Sep 2023 04:09:05 -0400
X-MC-Unique: AN5tlYEWOYyzfdZtNjZsmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAA9F88B7A1;
 Wed, 13 Sep 2023 08:09:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1561B40C6EA8;
 Wed, 13 Sep 2023 08:09:03 +0000 (UTC)
Date: Wed, 13 Sep 2023 09:09:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PULL v1 1/1] tpm: fix crash when FD >= 1024
Message-ID: <ZQFuHc4bz3/d7YmA@redhat.com>
References: <20230912214110.482744-1-stefanb@linux.ibm.com>
 <20230912214110.482744-2-stefanb@linux.ibm.com>
 <c3238434-2ec8-c060-9bb6-59a1a5f9de3a@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3238434-2ec8-c060-9bb6-59a1a5f9de3a@tls.msk.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 13, 2023 at 09:41:48AM +0300, Michael Tokarev wrote:
> 13.09.2023 00:41, Stefan Berger wrote:
> > From: Marc-Andr޸ Lureau <marcandre.lureau@redhat.com>
> > 
> > Replace select() with poll() to fix a crash when QEMU has a large number
> > of FDs.
> > 
> > Fixes:
> > https://bugzilla.redhat.com/show_bug.cgi?id=2020133
> 
> Please keep these on the same line next time.
> 
> And there's an UTF8 issue with Marc-André's name writing
> as Phil already pointed out (fixing in Cc of this email).
> Git usually DTRT here, dunno how that can happen.

It has often happened in the past when people have (mistakenly)
configured the tool used to send patches to use a non-UTF8
charset.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


