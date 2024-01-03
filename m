Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5797E822F04
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 14:58:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL1kc-00036t-Gn; Wed, 03 Jan 2024 08:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rL1kW-00036Z-5I
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:57:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rL1kQ-00036g-GD
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704290249;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjHbWzosTwzrKfITSM8M8K9N3DfWmnxVMIM4JTG0hes=;
 b=SCi880rLFbD2irtqm0Chwj92Uut/O1TnMhlU/hIQh56L0iaqVDT+ADaSsL3cSb4EhlIzs1
 zVI8G4I/d/YmZNvYCswHJ8vqzEdwUEYZ7B+JIAMtHkqFPChaMdlQHte0QQ94gHvcosso0v
 GZx8YWtBWJB9lwqm3QjGmFiq3fLAsEo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-SP0fPvUjO4eq5qdkQy71jg-1; Wed, 03 Jan 2024 08:57:28 -0500
X-MC-Unique: SP0fPvUjO4eq5qdkQy71jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1B7184ACA0;
 Wed,  3 Jan 2024 13:57:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24F823C27;
 Wed,  3 Jan 2024 13:57:25 +0000 (UTC)
Date: Wed, 3 Jan 2024 13:57:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ui: drop VNC feature _MASK constants
Message-ID: <ZZVnwxDv_k6g4_cW@redhat.com>
References: <20240103122600.2399662-1-berrange@redhat.com>
 <a81a9bb0-4d5b-40bb-b6b2-87c70ba23743@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a81a9bb0-4d5b-40bb-b6b2-87c70ba23743@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 03, 2024 at 02:26:41PM +0100, Philippe Mathieu-Daudé wrote:
> On 3/1/24 13:26, Daniel P. Berrangé wrote:
> > Each VNC feature enum entry has a corresponding _MASK constant
> > which is the bit-shifted value. It is very easy for contributors
> > to accidentally use the _MASK constant, instead of the non-_MASK
> > constant, or the reverse. No compiler warning is possible and
> > it'll just silently do the wrong thing at runtime.
> > 
> > By introducing the vnc_set_feature helper method, we can drop
> > all the _MASK constants and thus prevent any future accidents.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   ui/vnc.c | 34 +++++++++++++++++-----------------
> >   ui/vnc.h | 21 ++++-----------------
> >   2 files changed, 21 insertions(+), 34 deletions(-)
> 
> 
> > @@ -599,6 +582,10 @@ static inline uint32_t vnc_has_feature(VncState *vs, int feature) {
> >       return (vs->features & (1 << feature));
> >   }
> > +static inline void vnc_set_feature(VncState *vs, int feature) {
> 
> Even stricter using s/int/VncFeatures/ enum type.

Even with that, the compiler happily lets you pass arbitrary int values
even if they're not mapped to VncFeature enum constants, so it doesn't
make it any stricter.  None the less it is beneficial as it makes it
self-documenting, so I'll change that.

> 
> With that:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> > +    vs->features |= (1 << feature);
> > +}
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


