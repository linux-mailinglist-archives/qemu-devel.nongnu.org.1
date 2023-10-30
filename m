Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 344D67DBC74
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 16:15:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTxu-0001eP-5n; Mon, 30 Oct 2023 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxTxs-0001eC-Oi
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxTxr-00020q-0I
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698678841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qhYSLfiM/3fnlMueHi2ToNTP+bfEOa/la2JbUiGqFx0=;
 b=NRttkrqJUi+zhiRJi4G6EToYK4SwqPvKvNRAlSB89VG9ihkfcJhFp58d8Xt74usjuQBSV1
 br6dJufV1msuTFMVCmo1n//66UjMZPhqjpINRNXFCqU/J5qhxuILLMJW7pWIxr98ozgNTF
 OWBBjwTje1qOiDLGR59IWft45t1DUn4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-Qrez31iUPu6irMatRpRZqw-1; Mon, 30 Oct 2023 11:13:59 -0400
X-MC-Unique: Qrez31iUPu6irMatRpRZqw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d48cfd295so17126526d6.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 08:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698678839; x=1699283639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhYSLfiM/3fnlMueHi2ToNTP+bfEOa/la2JbUiGqFx0=;
 b=rsgVAjSp2cug+LKay71FK7DWybnZIt03Ue16q8KYqxBfVLrxKuu8A5dCSpYmEQejzg
 14lCEetXuEKMPdZr1jZH28s5boSou/3OUWVdKIQgk8S9IJ1778ucxQgkIYkVc5ABnf7O
 MBbd0eXPQM5CHhyWGVoXhPW8N1wc9EtPmXH+scZfYVGbc45hJanvqmXnZ8eEinuJzBm9
 w9B0XiVlMfr4vJBnUpQISCEIAlSxZm7SkWzPu0fRV1d8ofp7xcobmuBgsXdp9gVhr9jR
 FRVmwxm3ypi4JTKR1lc6iK/pf4zyVT793DoeiPilGWKHH7G7lOT0LQVCZZE3mQlxuTCN
 lCkA==
X-Gm-Message-State: AOJu0Yw8bZAPdSGgvRe2R6nQYfVu0Wva7hyJpVhFcSRAiZ5UuXpkPjpu
 MiJ/Zow2ljA0AtJH82IMWEqDmdmbuJXzb9XuE6IX4Lm8JsYIx1UHBPnPQSlaNCPXmnpb0Ptly+h
 t8QORaWdq1MebudgkquxUnP8=
X-Received: by 2002:a05:6214:4405:b0:66d:1178:8729 with SMTP id
 oj5-20020a056214440500b0066d11788729mr10675131qvb.0.1698678838715; 
 Mon, 30 Oct 2023 08:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvUlk1qg1+WJI8wv5SNYvmFJ5ceYmzjIkWe/UNPeSOrDT2w3bActNlFxavuHt5wm+riNZqQA==
X-Received: by 2002:a05:6214:4405:b0:66d:1178:8729 with SMTP id
 oj5-20020a056214440500b0066d11788729mr10675119qvb.0.1698678838397; 
 Mon, 30 Oct 2023 08:13:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 qr2-20020a05620a390200b0076c96e571f3sm3388186qkn.26.2023.10.30.08.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 08:13:58 -0700 (PDT)
Date: Mon, 30 Oct 2023 11:13:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 0/3] migration: Downtime tracepoints
Message-ID: <ZT/IM4gz6s6PfKg8@x1n>
References: <20231026155337.596281-1-peterx@redhat.com>
 <c8d16910-a496-410c-9c1c-68661b81f030@oracle.com>
 <ZTqb/XDnwhkTUL3s@x1n> <ZTqtieZo/VaSscp5@x1n>
 <778f6c92-221c-41d2-b0ae-4f5f4a208f65@oracle.com>
 <ZTrHAbyDxLsDl007@x1n>
 <af899e9e-a1b6-4682-ba83-6d0267e46247@oracle.com>
 <ZTvMEqYYVS4KjL0F@x1n>
 <e6be9230-2f63-4c48-9db4-5eff2c4399eb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6be9230-2f63-4c48-9db4-5eff2c4399eb@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

On Fri, Oct 27, 2023 at 11:17:41PM +0100, Joao Martins wrote:
> On 27/10/2023 15:41, Peter Xu wrote:
> > On Fri, Oct 27, 2023 at 09:58:03AM +0100, Joao Martins wrote:
> >> On 26/10/2023 21:07, Peter Xu wrote:
> >>> On Thu, Oct 26, 2023 at 08:33:13PM +0100, Joao Martins wrote:
> >>>> Sure. For the fourth patch, feel free to add Suggested-by and/or a Link,
> >>>> considering it started on the other patches (if you also agree it is right). The
> >>>> patches ofc are enterily different, but at least I like to believe the ideas
> >>>> initially presented and then subsequently improved are what lead to the downtime
> >>>> observability improvements in this series.
> >>>
> >>> Sure, I'll add that.
> >>>
> >>> If you like, I would be definitely happy to have Co-developed-by: with you,
> >>> if you agree. 
> >>
> >> Oh, that's great, thanks!
> > 
> > Great!  I apologize on not asking already before a formal patch is post.
> > 
> >>
> >>> I just don't know whether that addressed all your need, and
> >>> I need some patch like that for our builds.
> >>
> >> I think it achieves the same as the other series. Or rather it re-implements it
> >> but with less compromise on QAPI and made the tracepoints more 'generic' to even
> >> other usecases and less specific to the 'checkpoint breakdown'. Which makes the
> >> implementation simpler (like we don't need that array storing the checkpoint
> >> timestamps) given that it's just tracing and not for QAPI.
> > 
> > Yes.  Please also feel free to have a closer look on the exact checkpoints
> > in that patch.  I just want to make sure that'll be able to service the
> > same as the patch you proposed, but with tracepoints, and I don't miss
> > anything important.
> > 
> > The dest checkpoints are all new, I hope I nailed them all right as we
> > would expect.
> > 
> Yeah, it looks like so; but I am no master of postcopy so I don't have quite the
> cirurgical eye there.
> 
> Perhaps for the loadvm side, 'precopy-bh-enter' suggests some ambiguity (given
> that precopy happens on both source and destination?). Perhaps being explicit in
> either incoming-bh-enter? or even prefix checkpoint names by 'source' on source
> side for example to distinguish?

I don't think src has a bottom half; if not considering cleanup_bh as part
of migration at all.  Destination's BH is a major part of migration.

In all cases, let me prefix them with "src"/"dst" then, hopefully even clearer.

> 
> > For src checkpoints, IIRC your patch explicitly tracked return path closing
> > while patch 4 only made it just part of final enclosure; the 4th checkpoint
> > is after non-iterable sent, until 5th to be the last "downtime-end". It can
> > cover more than "return path close":
> > 
> >     qemu_savevm_state_complete_precopy_non_iterable <--- 4th checkpoint
> >     qemu_fflush (after non-iterable sent)
> >     close_return_path_on_source
> >     cpu_throttle_stop
> >     qemu_mutex_lock_iothread
> >     migration_downtime_end                          <---- 5th checkpoint
> > 
> > If you see fit or necessary, I can, for example, also add one more
> > checkpoint right after close return path.  I just didn't know whether it's
> > your intention to explicitly check that point.  Just let me know if so.
> > 
> It was put there because it was a simple catch-all from the source PoV on how
> much the destination is taking. Of course bearing in mind that without
> return-path then such metric/tracepoint is not available. On the other hand, with
> migration_downtime_end I think we have the equivalent in that resume checkpoint.
> So we just need to make the diff between that and the non-iterable and I think
> we have the same things as I was looking for (even more I would say).
> 
> > Also on whether you prefer to keep a timestamp in the tracepoint itself;
> > I only use either "log" or "dtrace"+qemu-trace-stap for tracing: both of
> > them contain timestamps already.  But I can also add the timestamps
> > (offseted by downtime_start) if you prefer.
> > 
> Perhaps it is easy to wrap the checkpoint tracepoint in its own function to
> allow extension of something else e.g. add the timestamp (or any other data into
> the checkpoints) or do something in a particular checkpoint of the migration.
> The timing function from qemu would give qemu own idea of time (directly
> correlable with the downtime metric that applications consume) which would be
> more consistent? though I am at too minds on this whether to rely on tracing
> stamps or align with what's provided to applications.

Yes it should be more consistent.  Let me add them into the checkpoints.

Thanks,

-- 
Peter Xu


