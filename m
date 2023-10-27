Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F2D7D9BEB
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:44:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO1k-0005rr-Uj; Fri, 27 Oct 2023 10:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qwO1h-0005kO-Qa
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qwO1g-0000K3-4g
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698417687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YKL7H6wfUMOZ+dQKZ9XZGlnILLMi50LUYJdcH2N9Ua0=;
 b=fku8uU69RB9uyKxUWpCGEFOoQfiXPlduC47cRHd523rJTOGUqA0tP05fhY4QBGmX06viOS
 WCc0lNK5slF4JfsbjLPJ8AQQy2aEwLq0n82tyYGjuiZyA7J6+akK02rdZM0DYCrKhGbJH8
 +uPj2sFxOWC9HCVomrHFgDLGzCW8hO4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-0GFl7i6ZPlyMtCS2i_n-fg-1; Fri, 27 Oct 2023 10:41:25 -0400
X-MC-Unique: 0GFl7i6ZPlyMtCS2i_n-fg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66fab8e9f95so6063476d6.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417685; x=1699022485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKL7H6wfUMOZ+dQKZ9XZGlnILLMi50LUYJdcH2N9Ua0=;
 b=DZ6ERV1JJhveRBSDHDvFpYTGbHx0/7Uj2qbt3gnUXuaMRvRPDFOkYrqbLzfnfDS/7/
 yyMfJTkNclAN2mcPouc+SNWFpxMOOvMTa6GLDMGXQf4gkxao4XiahpFX9/VVt9NaMZ8Y
 o3xSlCNtTmQKVvYW27hHf+BpEKrzh8T43AZ/q+0Fllyrax1Femue4O3Bkr4CcKDyozkW
 Ce0/Lujar0DibJxBZI83F+hw29ou4pwDvvSxhl5SFjvtCsfP+X+Pl/F6GzkxhmN4FCqo
 uIBmz+d9oFkaiWaobMdRvsXiHdbe3cCCNm2QDpwYY20WMTKi/QkESHmWrA1kE2N2+FkF
 tnLw==
X-Gm-Message-State: AOJu0Yz8ImRHz1kpZtnoS7ZfrpJziRPw8RWnF2jtiYgY31Fobnw8AXPz
 qWmRle/uY5BfSLjgMYFcgu3feVOFYylxYW4502m+5uSaKYzqgtENUfVLDpNjNqXqJ70gGwoiGt8
 DaB9ANfprWoknG4Q=
X-Received: by 2002:a05:6214:2b98:b0:65d:486:25c6 with SMTP id
 kr24-20020a0562142b9800b0065d048625c6mr3094545qvb.3.1698417685381; 
 Fri, 27 Oct 2023 07:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcimYRBskKHSTw1CNjZCUL+rqfgejvCMpq/LsH9uzw+Fbi48OoCqiMsCfPQlf2nJleqaA+kA==
X-Received: by 2002:a05:6214:2b98:b0:65d:486:25c6 with SMTP id
 kr24-20020a0562142b9800b0065d048625c6mr3094522qvb.3.1698417685060; 
 Fri, 27 Oct 2023 07:41:25 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 k15-20020a05621414ef00b0065b14fcfca6sm649791qvw.118.2023.10.27.07.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:41:24 -0700 (PDT)
Date: Fri, 27 Oct 2023 10:41:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 0/3] migration: Downtime tracepoints
Message-ID: <ZTvMEqYYVS4KjL0F@x1n>
References: <20231026155337.596281-1-peterx@redhat.com>
 <c8d16910-a496-410c-9c1c-68661b81f030@oracle.com>
 <ZTqb/XDnwhkTUL3s@x1n> <ZTqtieZo/VaSscp5@x1n>
 <778f6c92-221c-41d2-b0ae-4f5f4a208f65@oracle.com>
 <ZTrHAbyDxLsDl007@x1n>
 <af899e9e-a1b6-4682-ba83-6d0267e46247@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af899e9e-a1b6-4682-ba83-6d0267e46247@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Oct 27, 2023 at 09:58:03AM +0100, Joao Martins wrote:
> On 26/10/2023 21:07, Peter Xu wrote:
> > On Thu, Oct 26, 2023 at 08:33:13PM +0100, Joao Martins wrote:
> >> Sure. For the fourth patch, feel free to add Suggested-by and/or a Link,
> >> considering it started on the other patches (if you also agree it is right). The
> >> patches ofc are enterily different, but at least I like to believe the ideas
> >> initially presented and then subsequently improved are what lead to the downtime
> >> observability improvements in this series.
> > 
> > Sure, I'll add that.
> > 
> > If you like, I would be definitely happy to have Co-developed-by: with you,
> > if you agree. 
> 
> Oh, that's great, thanks!

Great!  I apologize on not asking already before a formal patch is post.

> 
> > I just don't know whether that addressed all your need, and
> > I need some patch like that for our builds.
> 
> I think it achieves the same as the other series. Or rather it re-implements it
> but with less compromise on QAPI and made the tracepoints more 'generic' to even
> other usecases and less specific to the 'checkpoint breakdown'. Which makes the
> implementation simpler (like we don't need that array storing the checkpoint
> timestamps) given that it's just tracing and not for QAPI.

Yes.  Please also feel free to have a closer look on the exact checkpoints
in that patch.  I just want to make sure that'll be able to service the
same as the patch you proposed, but with tracepoints, and I don't miss
anything important.

The dest checkpoints are all new, I hope I nailed them all right as we
would expect.

For src checkpoints, IIRC your patch explicitly tracked return path closing
while patch 4 only made it just part of final enclosure; the 4th checkpoint
is after non-iterable sent, until 5th to be the last "downtime-end". It can
cover more than "return path close":

    qemu_savevm_state_complete_precopy_non_iterable <--- 4th checkpoint
    qemu_fflush (after non-iterable sent)
    close_return_path_on_source
    cpu_throttle_stop
    qemu_mutex_lock_iothread
    migration_downtime_end                          <---- 5th checkpoint

If you see fit or necessary, I can, for example, also add one more
checkpoint right after close return path.  I just didn't know whether it's
your intention to explicitly check that point.  Just let me know if so.

Also on whether you prefer to keep a timestamp in the tracepoint itself;
I only use either "log" or "dtrace"+qemu-trace-stap for tracing: both of
them contain timestamps already.  But I can also add the timestamps
(offseted by downtime_start) if you prefer.

I plan to repost before early next week (want to catch the train for 8.2,
if it works out), so it'll be great to collect all your feedback and amend
that before the repost.

> 
> Though while it puts more work over developing new tracing tooling for users, I
> think it's a good start towards downtime breakdown "clearity" without trading
> off maintenance.

Thanks,

-- 
Peter Xu


