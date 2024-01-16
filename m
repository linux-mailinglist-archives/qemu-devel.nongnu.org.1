Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB3A82F347
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 18:35:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPnKP-0001bm-Kb; Tue, 16 Jan 2024 12:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rPnKN-0001ay-34
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 12:34:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rPnKL-0006cH-5p
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 12:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705426455;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SZGgNj8F8j93u27ywuQ/Rb8WuqQMvZvMe5xn1VdOT54=;
 b=KmM6IK77KiTIIAkraN4eHhj+x9OJqW0P2Csy/DbqW5KFSuVLLUFWbKmEFommkX1cx6iZUc
 PQKc5+cXRC1m8S2lxRZBVbmljqKFB88NoIYUrkAQIwqrOdf0W3EOor2wofZ0DtSh/YFVVX
 ip6+Yg91vdgiPfAs1Vk4xC3fgKujLK8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-kXycEnogPde8ZI-boId0dA-1; Tue, 16 Jan 2024 12:34:12 -0500
X-MC-Unique: kXycEnogPde8ZI-boId0dA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0884833AE3;
 Tue, 16 Jan 2024 17:34:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13C731C060AF;
 Tue, 16 Jan 2024 17:34:10 +0000 (UTC)
Date: Tue, 16 Jan 2024 17:34:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bohdan Kostiv <bogdan.kostiv@gmail.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Fixed '-serial none' usage breaks following '-serial
 ...' usage
Message-ID: <Zaa-EUCQJIEBcfwZ@redhat.com>
References: <CAA3Sv1LQ8yDUNLCB5WqLVZjsHffrU0uSbL_YYJW_m+Db2PhEeQ@mail.gmail.com>
 <CAFEAcA_5ip7q0Wp=jJkV7sJg=w=e08JCRqPmQuOObNe8AMZLDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_5ip7q0Wp=jJkV7sJg=w=e08JCRqPmQuOObNe8AMZLDA@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 15, 2024 at 04:14:30PM +0000, Peter Maydell wrote:
> (I've cc'd a few people who might have opinions on possible
> command-line compatibility breakage.)
> 
> On Wed, 10 Jan 2024 at 14:38, Bohdan Kostiv <bogdan.kostiv@gmail.com> wrote:
> >
> > Hello,
> >
> > I have faced an issue in using serial ports when I need to skip a couple of ports in the CLI.
> >
> > For example the ARM machine netduinoplus2 supports up to 7 UARTS.
> > Following case works (the first UART is used to send data in the firmware):
> > qemu-system-arm -machine netduinoplus2 -nographic -serial mon:stdio -kernel path-to-fw/firmware.elf
> > But this one doesn't  (the third UART is used to send data in the firmware):
> > qemu-system-arm -machine netduinoplus2 -nographic -serial none -serial none -serial mon:stdio -kernel path-to-fw/firmware.elf
> 
> Putting the patch inline for more convenient discussion:
> 
> > Subject: [PATCH] Fixed '-serial none' usage breaks following '-serial ...' usage
> >
> > Signed-off-by: Bohdan Kostiv <bohdan.kostiv@tii.ae>
> > ---
> >  system/vl.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/system/vl.c b/system/vl.c
> > index 2bcd9efb9a..b8744475cd 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -1442,8 +1442,11 @@ static int serial_parse(const char *devname)
> >      int index = num_serial_hds;
> >      char label[32];
> >
> > -    if (strcmp(devname, "none") == 0)
> > +    if (strcmp(devname, "none") == 0) {
> > +        num_serial_hds++;
> >          return 0;
> > +    }
> > +
> >      snprintf(label, sizeof(label), "serial%d", index);
> >      serial_hds = g_renew(Chardev *, serial_hds, index + 1);
> >
> > --
> > 2.39.3 (Apple Git-145)
> 
> I agree that it's the right thing to do -- '-serial none
> -serial foo' ought to set serial_hds(0) as 'none' and
> serial_hds(1) as 'foo'.
> 
> My only concern here is that this is a very very
> longstanding bug -- as far as I can see it was
> introduced in commit 998bbd74b9d81 in 2009. So I am
> a little worried that maybe some existing command lines
> accidentally rely on the current behaviour.
> 
> I think the current behaviour is:
> 
>  * "-serial none -serial something" is the same as
>    "-serial something"
>  * "-serial none" on its own disables the default serial
>    device (the docs say it will "disable all serial ports"
>    but I don't think that is correct...)
> which amounts to "the only effectively useful use of
> '-serial none' is to disable the default serial device"
> 
> and if we apply this patch:
>  * "-serial none -serial something" has the sensible behaviour
>    of "first serial port not connected/present, second serial
>    port exists" (which of those you get depends on the machine
>    model)
>  * "-serial none" on its own has no behaviour change
> 
> So I think the only affected users would be anybody who
> accidentally had an extra "-serial none" in their command
> line that was previously being overridden by a later
> "-serial" option. That doesn't seem very likely to me,
> so I think I'd be in favour of making this change and
> having something in the release notes about it.

If we don't apply this patch, then the valid use case of the reporter
here is impossible to achieve. We would have to invent a new syntax
to enable what 'serial none -serial something' should have already
been doing.  There is nothing users can do without us applying a fix
of some kind, either as proposed in the patch here, or something that
is functionally identical with different cli.


If we do apply this patch and someone was (mistakenly) relying on
'-serial none -serial something' being functionally equivalent to
'-serial something', they have an easy fix. They can just remove
the redundant '-serial none' they have and this works with any
QEMU they might see, whether ancient, current or future.


On balance, I think it is the right tradeoff to apply the proposed
patch, and accept the small risk of breaking someone who was
mistakenly relying on the broken behaviour, since the impact to
those people should be small.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


