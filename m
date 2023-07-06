Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2435274A22F
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:28:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHRpt-0006ys-Q0; Thu, 06 Jul 2023 12:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHRpr-0006yW-CZ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHRpp-0005JZ-Cp
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688660880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=An39eYk9IBNtHSZEyL2r4DYl1YHhBdcJPUjR7F8M0+0=;
 b=Izl97TvalyVV0HoM0PkDJM0VU0ixVweib+U37gLGEgP/gtfHkKOeMgKvHdXpVOwu3I88ID
 G2B16Wu2oanmI7tSf/fapzlhHQ5yd/WcLMEcZIx+V9bcOuk9iSL6snudBmlKWXnWBHwveT
 K9vViE+8u0xtQhIdCT82C/7i2TxtvPA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-dPkgMda2Ou-VsuhSmlYHLA-1; Thu, 06 Jul 2023 12:27:58 -0400
X-MC-Unique: dPkgMda2Ou-VsuhSmlYHLA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-403838e9f4dso2530981cf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 09:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688660878; x=1689265678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=An39eYk9IBNtHSZEyL2r4DYl1YHhBdcJPUjR7F8M0+0=;
 b=FBV/yB7JCjatHlQRUrQQRWdGig+he/d3EiHL6XK4s4x8mn8S0T8oz4ncIBG/6LQZkL
 5zgZ7DKUa/yD4BOBwe+uxapSb+IxN9kVWoVJYO+3HtRfmv/8HqNZ+UQNl+EWveswCN4C
 rwZtj3a2V28PQPaAMnyXfCmvZeyPzuq390fo20e6dOcfK4apvAGgRsL/EreywsTuSJs0
 jsbWSz3SMJQL98GzGACfDhWwRyelp4MGSKyb+AnzF8kqA3GMs3hNuf7kHrFWlnBAhvBo
 lg1sYf9Xqn6SN/t+02J36Njxqni0VTh68yj8LlzQ/HUgfTDTpY7Tmzyk73lBu0FDavtZ
 QuWA==
X-Gm-Message-State: ABy/qLaHStsddcr6TsdMLMiJx9ELuC1+v4YLBOC7pU1RYA+pOdNS0/6s
 7jj19BNHxUF10v2InPYJt/38ZUVYyIMIIqJSL6TB2B9YqKCW81MUNtlcIRcyEvmmegztMQIzDj4
 2lFIgaZssmaVOGug=
X-Received: by 2002:a05:622a:1ba4:b0:3f6:a8e2:127b with SMTP id
 bp36-20020a05622a1ba400b003f6a8e2127bmr2854049qtb.5.1688660878311; 
 Thu, 06 Jul 2023 09:27:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHpJwSio82Sjqv7d36uKh9Jdvx1i8J2/mkPL3/W3aLRBYgDCD1BQfFnJ2SVYVHYQhzo5fO3tA==
X-Received: by 2002:a05:622a:1ba4:b0:3f6:a8e2:127b with SMTP id
 bp36-20020a05622a1ba400b003f6a8e2127bmr2854029qtb.5.1688660877980; 
 Thu, 06 Jul 2023 09:27:57 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 s13-20020ac8758d000000b0040328b5fbe2sm755115qtq.58.2023.07.06.09.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:27:57 -0700 (PDT)
Date: Thu, 6 Jul 2023 12:27:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v2 7/7] migration: Provide explicit error message for
 file shutdowns
Message-ID: <ZKbrio28Oa7mzaV1@x1n>
References: <20230705163502.331007-1-peterx@redhat.com>
 <20230705163502.331007-8-peterx@redhat.com>
 <878rbu3tgm.fsf@suse.de> <ZKXv+1eoDDlWj812@x1n>
 <87v8exjgid.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v8exjgid.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jul 06, 2023 at 10:50:34AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Jul 05, 2023 at 07:05:13PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > Provide an explicit reason for qemu_file_shutdown()s, which can be
> >> > displayed in query-migrate when used.
> >> >
> >> 
> >> Can we consider this to cover the TODO:
> >> 
> >>  * TODO: convert to propagate Error objects instead of squashing
> >>  * to a fixed errno value
> >> 
> >> or would that need something fancier?
> >
> > The TODO seems to say we want to allow qemu_file_shutdown() to report an
> > Error* when anything wrong happened (e.g. shutdown() failed)?  While this
> > patch was trying to store a specific error string so when query migration
> > later it'll show up to the user.  If so, IMHO they're two things.
> >
> 
> Ok, just making sure.
> 
> >> 
> >> > This will make e.g. migrate-pause to display explicit error descriptions,
> >> > from:
> >> >
> >> > "error-desc": "Channel error: Input/output error"
> >> >
> >> > To:
> >> >
> >> > "error-desc": "Channel is explicitly shutdown by the user"
> >> >
> >> > in query-migrate.
> >> >
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> > ---
> >> >  migration/qemu-file.c | 5 ++++-
> >> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> >> > index 419b4092e7..ff605027de 100644
> >> > --- a/migration/qemu-file.c
> >> > +++ b/migration/qemu-file.c
> >> > @@ -87,7 +87,10 @@ int qemu_file_shutdown(QEMUFile *f)
> >> >       *      --> guest crash!
> >> >       */
> >> >      if (!f->last_error) {
> >> > -        qemu_file_set_error(f, -EIO);
> >> > +        Error *err = NULL;
> >> > +
> >> > +        error_setg(&err, "Channel is explicitly shutdown by the user");
> >> 
> >> It is good that we can grep this message. However, I'm confused about
> >> who the "user" is meant to be here and how are they implicated in this
> >> error.
> >
> > Ah, here the user is who sends the "migrate-pause" command, according to
> > the example of the commit message.
> >
> 
> That's where I'm confused. There are 15 callsites for
> qemu_file_shutdown(). Only 2 of them are from migrate-pause. So I'm
> missing the logical step that links migrate-pause with this
> error_setg().
> Are you assuming that the race described will only happen
> with migrate-pause and the other invocations would have set an error
> already?

It's not a race, but I think you're right. I thought it was always the case
to shut but actually not: we do shutdown() also in a few places where we
don't really fail, either for COLO or for completion of migration.  With
the 1st patch, it'll even show in query-migrate.  Thanks for spotting it -
I could have done better.

Let's drop this patch.. sorry for the noise.

-- 
Peter Xu


