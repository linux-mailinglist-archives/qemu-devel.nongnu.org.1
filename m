Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F113F7D0D06
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 12:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtmdQ-0002Jp-Ub; Fri, 20 Oct 2023 06:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qtmdN-0002HX-EO; Fri, 20 Oct 2023 06:21:37 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qtmdL-0003Us-I1; Fri, 20 Oct 2023 06:21:37 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6ce2cf67be2so418789a34.2; 
 Fri, 20 Oct 2023 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697797292; x=1698402092; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6XpQDkV+ddExaFmcy6q/Y1PX3uCxd2m4rImMmrU/Ww=;
 b=Q1n7gnczH6qm9bkWBR6735l389o/Gf3/9n3szJGPa92HMqF9xpGWk7PTIA2VUmzJ20
 yn3s5h8j2B4XAoSr/Sc8+gJv7fwel0sQ97WDvT8oqkySfTMqaCcVSzrp+2Q2Ry0jxeGp
 xaS6X/7DW9ZyC7LOzw9XeorrWfiVpF4jLdVl2riQnW3c2xlVwNaKIy3yZyMJkSaagrkp
 jkeaQhBjuP7Ex1M3pDcqZuENfAiduV4SXtklAsIYw72IWQRAJUEtd4HAZxkr5yeXD+p2
 msghrVlaAYqJEMdNyYeYFavcL4eOnnGI74z2hpXeo4J407xSxjbkmHUIaSiIlLuOzFH5
 V/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697797292; x=1698402092;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E6XpQDkV+ddExaFmcy6q/Y1PX3uCxd2m4rImMmrU/Ww=;
 b=p0GAjy8SueHF5eyTzpqxi+fzz5GI8kZTC8XvcmJY+2FXZuf+HtoGmihAb0HjBhzD1w
 MgGSEY9BYaA2Yc6x5oEG5S9BGrEcOS1fwmO3/mXSg+XhwM2Hk+5FeN92KI6wjgftBlJn
 1KoiUny8qrxieiDrDQgTN+r7b3ifPwgoA7tbKjVd9REDFhDkLsfayMFtcK8rbPrUxJhO
 k0zGAHvS/+U3v9yh0TAvaoPdu1lp3XUTlxt+6/0BktqyXus0D5ezW3qkAeUZ8qMSkDLI
 dNAQ70O0clerBeg2CocROueY4jwrd98hvNwUWoyN88uFlZO3gk0plCTXFZOKjVZho4Gc
 xidQ==
X-Gm-Message-State: AOJu0YwB8orNvSWcpeMdbHezge+zqrKTR0WrhE7QlJMc7bRtkybiJhU4
 fcEfjglBCqzRb0xrGntDcXc=
X-Google-Smtp-Source: AGHT+IF4LTf/FJxAh/xGVbSMry+aoRJsiWXoeD9Bz1UFnFSl0IDj48HZoNLAtCRGQfm3QUXns0KI8w==
X-Received: by 2002:a05:6830:16c9:b0:6c4:8441:f90 with SMTP id
 l9-20020a05683016c900b006c484410f90mr1387547otr.24.1697797292661; 
 Fri, 20 Oct 2023 03:21:32 -0700 (PDT)
Received: from localhost (61-68-209-245.tpgi.com.au. [61.68.209.245])
 by smtp.gmail.com with ESMTPSA id
 y21-20020aa79af5000000b0068be348e35fsm1190429pfp.166.2023.10.20.03.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 03:21:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Oct 2023 20:21:19 +1000
Message-Id: <CWD6WMVZLLFS.185IFJ3HZS0I0@wheely>
Cc: "Juan Quintela" <quintela@redhat.com>, <qemu-devel@nongnu.org>, "Stefan
 Berger" <stefanb@linux.vnet.ibm.com>, "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>, <qemu-ppc@nongnu.org>,
 <qemu-s390x@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>, "Corey
 Minyard" <cminyard@mvista.com>, "Samuel Thibault"
 <samuel.thibault@ens-lyon.org>, "Richard Henderson"
 <richard.henderson@linaro.org>, "David Hildenbrand" <david@redhat.com>,
 "Ilya Leoshkevich" <iii@linux.ibm.com>, "Fabiano Rosas" <farosas@suse.de>,
 "Eric Farman" <farman@linux.ibm.com>, "Peter Xu" <peterx@redhat.com>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "John Snow"
 <jsnow@redhat.com>, <qemu-block@nongnu.org>, "Mark Cave-Ayland"
 <mark.cave-ayland@ilande.co.uk>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, =?utf-8?q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Stefan Weil" <sw@weilnetz.de>,
 <qemu-arm@nongnu.org>, "Jason Wang" <jasowang@redhat.com>, "Corey Minyard"
 <minyard@acm.org>, "Leonardo Bras" <leobras@redhat.com>, "Thomas Huth"
 <thuth@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "David Gibson" <david@gibson.dropbear.id.au>, "Halil Pasic"
 <pasic@linux.ibm.com>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 07/13] RFC migration: icp/server is a mess
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Greg Kurz" <groug@kaod.org>
X-Mailer: aerc 0.15.2
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-8-quintela@redhat.com>
 <20231019233958.17abb488@bahia> <CWD3OHT178VU.3NF8B5Y5BOK1S@wheely>
 <20231020103344.34baea63@bahia>
In-Reply-To: <20231020103344.34baea63@bahia>
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri Oct 20, 2023 at 6:33 PM AEST, Greg Kurz wrote:
> On Fri, 20 Oct 2023 17:49:38 +1000
> "Nicholas Piggin" <npiggin@gmail.com> wrote:
>
> > On Fri Oct 20, 2023 at 7:39 AM AEST, Greg Kurz wrote:
> > > On Thu, 19 Oct 2023 21:08:25 +0200
> > > Juan Quintela <quintela@redhat.com> wrote:
> > >
> > > > Current code does:
> > > > - register pre_2_10_vmstate_dummy_icp with "icp/server" and instanc=
e
> > > >   dependinfg on cpu number
> > > > - for newer machines, it register vmstate_icp with "icp/server" nam=
e
> > > >   and instance 0
> > > > - now it unregisters "icp/server" for the 1st instance.
> > > >=20
> > > > This is wrong at many levels:
> > > > - we shouldn't have two VMSTATEDescriptions with the same name
> > > > - In case this is the only solution that we can came with, it needs=
 to
> > > >   be:
> > > >   * register pre_2_10_vmstate_dummy_icp
> > > >   * unregister pre_2_10_vmstate_dummy_icp
> > > >   * register real vmstate_icp
> > > >=20
> > > > As the initialization of this machine is already complex enough, I
> > > > need help from PPC maintainers to fix this.
> > > >=20
> > > > Volunteers?
> > > >=20
> > > > CC: Cedric Le Goater <clg@kaod.org>
> > > > CC: Daniel Henrique Barboza <danielhb413@gmail.com>
> > > > CC: David Gibson <david@gibson.dropbear.id.au>
> > > > CC: Greg Kurz <groug@kaod.org>
> > > >=20
> > > > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > > > ---
> > > >  hw/ppc/spapr.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index cb840676d3..8531d13492 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -143,7 +143,12 @@ static bool pre_2_10_vmstate_dummy_icp_needed(=
void *opaque)
> > > >  }
> > > > =20
> > > >  static const VMStateDescription pre_2_10_vmstate_dummy_icp =3D {
> > > > -    .name =3D "icp/server",
> > > > +    /*
> > > > +     * Hack ahead.  We can't have two devices with the same name a=
nd
> > > > +     * instance id.  So I rename this to pass make check.
> > > > +     * Real help from people who knows the hardware is needed.
> > > > +     */
> > > > +    .name =3D "pre-2.10-icp/server",
> > > >      .version_id =3D 1,
> > > >      .minimum_version_id =3D 1,
> > > >      .needed =3D pre_2_10_vmstate_dummy_icp_needed,
> > >
> > > I guess this fix is acceptable as well and a lot simpler than
> > > reverting the hack actually. Outcome is the same : drop
> > > compat with pseries-2.9 and older.
> > >
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> > So the reason we can't have duplicate names registered, aside from it
> > surely going bad if we actually send or receive a stream at the point
> > they are registered, is the duplcate check introduced in patch 9? But
> > before that, this hack does seem to actually work because the duplicate
> > is unregistered right away.
> >=20
>
> Correct.
>
> > If I understand the workaround, there is an asymmetry in the migration
> > sequence in that receiving an unexpected object would cause a failure,
> > but going from newer to older would just skip some "expected" objects
> > and that didn't cause a problem. So you only have to deal with ignoring
> > the unexpected ones going form older to newer.
> >=20
>
> Correct.
>
> > Side question, is it possible to flag the problem of *not* receiving
> > an object that you did expect? That might be a source of bugs too.
> >=20
>
> AFAICR we try to only migrate state that differs from reset : the
> destination cannot really assume it will receive anything for a
> given device.

That's true, I guess you could always add some flag yourself if
you certainly need something.

>
> > Anyway, I wonder if we could fix this spapr problem by adding a special
> > case wild card instance matcher to ignore it? It's still a bit hacky
> > but maybe a bit nicer. I don't mind deprecating the machine soon if
> > you want to clear the wildcard hack away soon, but it would be nice to
> > separate the deprecation and removal from the fix, if possible.
> >=20
> > This patch is not tested but hopefully helps illustrate the idea.
> >=20
>
> I'm not sure this will fly with older QEMUs that don't know about
> VMSTATE_INSTANCE_ID_WILD... but I'll let Juan comment on that.

You could be right about that. He gave a simpler solution now
anyway.

Thanks,
Nick

