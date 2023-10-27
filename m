Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD9D7D9E20
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 18:39:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPqv-0002Wg-Bn; Fri, 27 Oct 2023 12:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qwPqt-0002Vz-CS
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qwPqq-0005ON-AT
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698424703;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1VRcJ5h2CnF28186q/caluBI0qALfY6P/RoKVRjF8sI=;
 b=QWAAO6R6rhjiNLfncJ90KwkCl1A+xOQAftJ0ikmkLI4mmTO3d8crLLY5fdcaLNjvH0Lcob
 IHg1KK6NOk5oA1CkFjubl9ani4xIifpbTuPfyGY7ziGKes4pPe3ATjcQ/+Rw3T9lyyh/8f
 49P9oAB7Tf+LGUEmJ1MEOrt3czOy50I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-NZ56rxFHOt-tDeKLIRVSFw-1; Fri, 27 Oct 2023 12:38:19 -0400
X-MC-Unique: NZ56rxFHOt-tDeKLIRVSFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12125185A780;
 Fri, 27 Oct 2023 16:38:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AE6A1121320;
 Fri, 27 Oct 2023 16:38:16 +0000 (UTC)
Date: Fri, 27 Oct 2023 17:38:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 09/23] ui/console: allow to override the default VC
Message-ID: <ZTvndl9Bocy2YLOa@redhat.com>
References: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
 <20231025190818.3278423-10-marcandre.lureau@redhat.com>
 <CABJz62N7-Bo8j=Dopt960=q8Q+CnDQRDWjMLFLqsLMOq_aZxHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABJz62N7-Bo8j=Dopt960=q8Q+CnDQRDWjMLFLqsLMOq_aZxHg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

On Fri, Oct 27, 2023 at 05:53:19AM -0700, Andrea Bolognani wrote:
> On Wed, Oct 25, 2023 at 11:08:03PM +0400, marcandre.lureau@redhat.com wrote:
> > If a display is backed by a specialized VC, allow to override the
> > default "vc:80Cx24C". For that, set the dpy.type just before creating
> > the default serial/parallel/monitor.
> >
> > As suggested by Paolo, if the display doesn't implement a VC (get_vc()
> > returns NULL), use a fallback that will use a muxed console on stdio.
> >
> > This changes the behaviour of "qemu -display none", to create a muxed
> > serial/monitor by default.
> 
> Have you verified that this doesn't break libvirt? We use '-display
> none' for every single VM we run.

IIUC we're ok as this logic appears to be skipped when -nodefaults
is set.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


