Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2189690E532
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jun 2024 10:06:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJqJn-0007Bh-1n; Wed, 19 Jun 2024 04:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sJqJk-0007BT-QQ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 04:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sJqJi-0008Rp-3H
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 04:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718784316;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DrHQzSJxD0yU22xS1M5/CqxwDzpDkyoFzOwZhS4ugwU=;
 b=PpKPaltFi3EEgD6UZl6/sBvEqcDarMKNM69JrB1y0p57npoWN6PASv5EnseKHjrnlHVOnv
 9M3prUBWAHkDrZg4I6MYEFNyEgRQaAOdusP8LjMHaR8qIXW2+r9cNRoGZCbFpmZh8NH2PY
 UEpplIRAERRVmMh4YDksm0yjG4x12Gs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-lU-1zdsGPlSwmovR8GVfTg-1; Wed,
 19 Jun 2024 04:05:10 -0400
X-MC-Unique: lU-1zdsGPlSwmovR8GVfTg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D92F19560AA; Wed, 19 Jun 2024 08:05:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A490B300022A; Wed, 19 Jun 2024 08:05:06 +0000 (UTC)
Date: Wed, 19 Jun 2024 09:05:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org,
 jansene@google.com, mett@google.com, jpcottin@google.com
Subject: Re: [PATCH 3/3] exec: use char* for pointer arithmetic
Message-ID: <ZnKRLj3usYxmAIOE@redhat.com>
References: <20240618224604.879275-1-rkir@google.com>
 <495d3ddc-ce73-4ef5-badd-16ed61f9a5aa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <495d3ddc-ce73-4ef5-badd-16ed61f9a5aa@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Jun 18, 2024 at 04:05:36PM -0700, Richard Henderson wrote:
> On 6/18/24 15:46, Roman Kiryanov wrote:
> > @@ -2839,7 +2839,7 @@ static inline uint8_t address_space_ldub_cached(MemoryRegionCache *cache,
> >   {
> >       assert(addr < cache->len);
> >       if (likely(cache->ptr)) {
> > -        return ldub_p(cache->ptr + addr);
> > +        return ldub_p((char*)cache->ptr + addr);
> 
> We require "char *" with a space.
> 
> With all of those fixed,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> PS: I'm annoyed that standards never adopted arithmetic on void *.

NB, QEMU is explicitly *NOT* targetting the C standard, we are
targetting the C dialect supported by GCC and CLang only. IOW,
if they have well defined behaviour for arithmetic on void *,
then we are free to use it.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


