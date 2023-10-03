Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 943677B6CA0
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qngxL-0006e6-9P; Tue, 03 Oct 2023 11:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qngxH-0006dj-Du
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qngxF-0005PN-Nw
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696345496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fQhN2b8FXFipjxiSfkyYEHU1husl4Tbr7PD0b0t5i70=;
 b=XqE+5MVsVwkHS4WQziJlsDnK8HCHuKY+LUK206Jb39rBQjTjqvHn7BZcMKnDUvFTW7UpbA
 EO/Ut4UZLz7rjdMeI8ndHFhzHjI9e1Ibf9xXA853r6VLovVCwxBEEMt2sW8GBVQDHtvzu4
 bXJ6kqKZBDySJLOCygvTJ5vbh7uadto=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-7cnuEYwGP3q00gyB2e8iuA-1; Tue, 03 Oct 2023 11:04:55 -0400
X-MC-Unique: 7cnuEYwGP3q00gyB2e8iuA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7756d0fb11dso29910085a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 08:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696345494; x=1696950294;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQhN2b8FXFipjxiSfkyYEHU1husl4Tbr7PD0b0t5i70=;
 b=olTpgeZkYLsxcpERYSTrEoEn5JZ8IBe8vnTARzRYAplJOT7V+ux1yvsrCSEimA6GuR
 jJNWswkHRQq3kYx7HHy4wolm4aRhb0p1UDYW54qIC/M96B1+Kybh4XwpNAxnEGhdrKSH
 z28suH5g5hmufSkQMLTKk2h8dtpPIaEZdV4GFjeLP/fxkguTcuX+tlH06aK2zCO0vTqN
 R6oRltlmFCtfTrJ44Ci2+A1WG5XYT+PZ7rbWoeYbxFyT2hbYxUqd/lIK3VRcA8+6eIbC
 HW52FZSt16/Bat8AwyvSghwc03bwizQcA9KplhWR4wkhfp29/+ZzVNHz7Xvmgk1AMlM3
 yDuA==
X-Gm-Message-State: AOJu0Yxw2LhDWV+Cu/vDZ59toX89p5ZUIYfPB+I/3wn0aFLy3nAfSzEM
 UMfUMArHyAjf3lZo3sG0lzBoZI639fiwvn0P0E5G7+DFVxka5BBdfe0/h8pm1hctMYAthHtEMTt
 +sGijKtAYXlsOwUW852SFzVg=
X-Received: by 2002:a05:620a:28d0:b0:76f:27af:2797 with SMTP id
 l16-20020a05620a28d000b0076f27af2797mr15511425qkp.0.1696345494434; 
 Tue, 03 Oct 2023 08:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqhyxnamfjQkk27qx+ZTS4K449X2dUZLVwTpCC+bIZ6X3urzmgU1TF4s8diB85xZBX019RKQ==
X-Received: by 2002:a05:620a:28d0:b0:76f:27af:2797 with SMTP id
 l16-20020a05620a28d000b0076f27af2797mr15511394qkp.0.1696345494087; 
 Tue, 03 Oct 2023 08:04:54 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 oo19-20020a05620a531300b0077569c302d1sm529377qkn.28.2023.10.03.08.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 08:04:53 -0700 (PDT)
Date: Tue, 3 Oct 2023 11:04:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] migration: Unify and trace vmstate field_exists() checks
Message-ID: <ZRwtkwKy2p/gN521@x1n>
References: <20230906204722.514474-1-peterx@redhat.com>
 <87ledi8aev.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ledi8aev.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Sep 07, 2023 at 08:55:52AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > For both save/load we actually share the logic on deciding whether a field
> > should exist.  Merge the checks into a helper and use it for both save and
> > load.  When doing so, add documentations and reformat the code to make it
> > much easier to read.
> >
> > The real benefit here (besides code cleanups) is we add a trace-point for
> > this; this is a known spot where we can easily break migration
> > compatibilities between binaries, and this trace point will be critical for
> > us to identify such issues.
> >
> > For example, this will be handy when debugging things like:
> >
> > https://gitlab.com/qemu-project/qemu/-/issues/932
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/vmstate.c    | 34 ++++++++++++++++++++++++++--------
> >  migration/trace-events |  1 +
> >  2 files changed, 27 insertions(+), 8 deletions(-)
> >
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index 31842c3afb..73e74ddea0 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -25,6 +25,30 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
> >  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
> >                                     void *opaque);
> >  
> > +/* Whether this field should exist for either save or load the VM? */
> > +static bool
> > +vmstate_field_exists(const VMStateDescription *vmsd, const VMStateField *field,
> > +                     void *opaque, int version_id)
> > +{
> > +    bool result;
> > +
> > +    if (field->field_exists) {
> > +        /* If there's the function checker, that's the solo truth */
> > +        result = field->field_exists(opaque, version_id);
> > +        trace_vmstate_field_exists(vmsd->name, field->name, field->version_id,
> > +                                   version_id, result);
> > +    } else {
> > +        /*
> > +         * Otherwise, we only save/load if field version is same or older.
> > +         * For example, when loading from an old binary with old version,
> > +         * we ignore new fields with newer version_ids.
> > +         */
> > +        result = field->version_id <= version_id;
> 
> This one doesn't get a trace?

Right, I didn't add that since I found mostly the bug comes from
field_exists() returning different values for different qemu binaries.
So I explicitly didn't include that otherwise we'll see tons of entries
under that regard but is probably safe.

> 
> Aside from that:
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thanks!

-- 
Peter Xu


