Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D77177B15DA
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 10:17:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlmCa-0008Le-QI; Thu, 28 Sep 2023 04:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlmCU-0008LF-Up
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 04:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlmCT-0000oc-93
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 04:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695889004;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ES3eh617MTEXql4r7kSGjZNcPcnprWgAlJ5k3pc7u+I=;
 b=akdlhyvxSXgXk7X//nMfUPgEGhN/s6VaRyKcDel+w4tJWcF8Y9gtQl57inSCJystxLvFOk
 zjCVx8G93UYz7KHYamAmuYOTJhpTjCulryre8CLggXnfWLie6RPYP8zno3XseazkX8u6cC
 xkNdviYToVXczlq1KyFY5Sdwdsc/PCM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-yr_3DnSCMsObzchzJyWMNw-1; Thu, 28 Sep 2023 04:16:42 -0400
X-MC-Unique: yr_3DnSCMsObzchzJyWMNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EBDB85A5A8;
 Thu, 28 Sep 2023 08:16:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F23C2156702;
 Thu, 28 Sep 2023 08:16:41 +0000 (UTC)
Date: Thu, 28 Sep 2023 09:16:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu
Subject: Re: [PATCH 03/13] audio: allow returning an error from the driver init
Message-ID: <ZRU2Z1Es1zr9wyBK@redhat.com>
References: <20230928073705.871327-1-pbonzini@redhat.com>
 <20230928073705.871327-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230928073705.871327-4-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 28, 2023 at 09:36:47AM +0200, Paolo Bonzini wrote:
> An error is already printed by audio_driver_init, but we can make
> it more precise if the driver can return an Error *.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  audio/alsaaudio.c   |  2 +-
>  audio/audio.c       | 11 +++++++++--
>  audio/audio_int.h   |  2 +-
>  audio/coreaudio.m   |  2 +-
>  audio/dbusaudio.c   |  2 +-
>  audio/dsoundaudio.c |  2 +-
>  audio/jackaudio.c   |  2 +-
>  audio/noaudio.c     |  2 +-
>  audio/ossaudio.c    | 11 ++++++++---
>  audio/paaudio.c     |  7 +++++--
>  audio/pwaudio.c     | 16 +++++++++-------
>  audio/sdlaudio.c    |  5 +++--
>  audio/sndioaudio.c  |  2 +-
>  audio/spiceaudio.c  |  5 ++++-
>  audio/wavaudio.c    |  2 +-
>  15 files changed, 47 insertions(+), 26 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


