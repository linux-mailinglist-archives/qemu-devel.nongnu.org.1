Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E958059DF
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 17:19:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAY8e-0004LX-Ny; Tue, 05 Dec 2023 11:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAY8b-0004L1-T6
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 11:19:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAY8a-0008Fv-8B
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 11:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701793147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=17SUlxu8i208QLcwfD26ePDzzIAWTYEftUyzX3Ahdkw=;
 b=cDjHP3yX75RLZnD4WFkOwQ0UH5kHYpFCTDU4sPCTRn6LN1gKh7dZT+PW4a53fhVgo+nUCV
 qwlX3E6tCG91THe1GNj5CH6j7MPlHhUio/tOeD3/QN8nP5SNnXYgZ65kz4XqtN5w2mq4iU
 jcZsUXkKoqHSmvvlUkQ5Ok3eZ4DMRlw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-5o12qjClO6ycQImrxWKdkw-1; Tue, 05 Dec 2023 11:19:02 -0500
X-MC-Unique: 5o12qjClO6ycQImrxWKdkw-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-58e28c5b6aeso557011eaf.0
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 08:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701793142; x=1702397942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17SUlxu8i208QLcwfD26ePDzzIAWTYEftUyzX3Ahdkw=;
 b=djHVpkO/ZNZWa6YKCgH78ZqAxg0nBXOjOktYJcAUi5bYPUBopqCvYui9UO0echsanL
 QIRv73LZEQ3Q8bEGFrBVYxA5e5FJxEjyEJYq7N2TfiWFJdlKqJRJXnnjiYpi1xKPgtkt
 wN6qW2F8sZsnWf35RYTKdtzzJc7Qd6U7jzQmGISVtaeFf65mdDeux5/o6yM7iOk0CPkG
 yJclojRTYSGMh2rpkpufRj8gzqu0QMSvu2ZFT3y7FHWL1iQLwxLLuDj0gv1LR/fHdna7
 VbMYjBT0xXS2+tK+pCoEVVNV9jX2xBnHAOgWFFDjlcgEgajhQG1jk/SB7hH77uCQQL0f
 QPbg==
X-Gm-Message-State: AOJu0YzJChyvEr3rnU7R2G1hAXcQ1C/u+AFEjS0L+CukobBzhLB4QuRj
 CDrRS+85MrnZDeVMrfSAga5C+wiYvz/9YUpoP0seCAVAomQ7uuWeQ8Yi8t9bE29/M9tXiOWzwaR
 mQBa97L9sbYLWzAw=
X-Received: by 2002:a4a:a2c8:0:b0:58d:ddcb:db1a with SMTP id
 r8-20020a4aa2c8000000b0058dddcbdb1amr16290198ool.1.1701793141986; 
 Tue, 05 Dec 2023 08:19:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHad4sTpBMXZtFOhAZoWN4X5hbVy3sPAMUNyRm6BkpVyMzy+eopD/w21qgy6qjyNCYnnVpdZw==
X-Received: by 2002:a4a:a2c8:0:b0:58d:ddcb:db1a with SMTP id
 r8-20020a4aa2c8000000b0058dddcbdb1amr16290179ool.1.1701793141636; 
 Tue, 05 Dec 2023 08:19:01 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 z27-20020a05620a101b00b0077d8fdc7e84sm5202664qkj.5.2023.12.05.08.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 08:19:01 -0800 (PST)
Date: Tue, 5 Dec 2023 11:18:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 05/14] migration: propagate suspended runstate
Message-ID: <ZW9NcwNropqV_7Kz@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
 <ZWkVbiQNl16hC1LW@x1n>
 <ea771378-33c4-4d4e-9de2-d39310028d10@oracle.com>
 <ZW4LX9FpfTj77TZv@x1n> <87r0k1n4r7.fsf@suse.de>
 <ZW4wTK0dld9pPCtX@x1n> <87o7f5n08z.fsf@suse.de>
 <ZW5M19173nTZTLv1@x1n> <87cyvkn7j7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cyvkn7j7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Dec 05, 2023 at 09:44:12AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Dec 04, 2023 at 06:09:16PM -0300, Fabiano Rosas wrote:
> >> Right, I got your point. I just think we could avoid designing this new
> >> string format by creating new fields with the extra space:
> >> 
> >> typedef struct QEMU_PACKED {
> >>     uint32_t size;
> >>     uint8_t runstate[50];
> >>     uint8_t unused[50];
> >>     RunState state;
> >>     bool received;
> >> } GlobalState;
> >> 
> >> In my mind this works seamlessly, or am I mistaken?
> >
> > I think what you proposed should indeed work.
> >
> > Currently it's:
> >
> >     .fields = (VMStateField[]) {
> >         VMSTATE_UINT32(size, GlobalState),
> >         VMSTATE_BUFFER(runstate, GlobalState),
> >         VMSTATE_END_OF_LIST()
> >     },
> >
> > I had a quick look at vmstate_info_buffer, it mostly only get()/put() those
> > buffers with its sizeof(), so looks all fine.  For sure in all cases we'd
> > better test it to verify.
> >
> > One side note is since we so far use qapi_enum_parse() for the runstate, I
> > think the "size" is not ever used..
> >
> > If we do want a split, IMHO we can consider making runstate[] even smaller
> > to just free up the rest spaces all in one shot:
> >
> >   typedef struct QEMU_PACKED {

[1]

> >       uint32_t size;
> >       /*
> >        * Assuming 16 is good enough to fit all possible runstate strings..
> >        * This field must be a string ending with '\0'.
> >        */
> >       uint8_t runstate[16];
> >       /* 0x00 when QEMU doesn't support it, or "0"/"1" to reflect its state */
> >       uint8_t vm_was_suspended[1];
> >       /*
> >        * Still free of use space.  Note that we only have 99 bytes for use
> >        * because the last byte (the 100th byte) must be zero due to legacy
> >        * reasons, if not it may be set to zero after loaded on dest QEMU. 
> >        */
> 
> I'd add a 'uint8_t reserved;' to go along with this comment instead of
> leaving a hole.

Note that "struct GlobalState" is not a binary format but only some
internal storage, what really matters is vmstate_globalstate.  Here the
"uint8_reserved" will be a pure waste of 1 byte in QEMU binary, imho.

I think I just copied what you had previously and extended it, logically I
don't think we ever need QEMU_PACKED right above [1].  We can also drop
"size" directly here, but this can be done later.

-- 
Peter Xu


