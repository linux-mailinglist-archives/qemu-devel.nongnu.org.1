Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 852A07BA17B
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 16:53:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoPiO-0003HP-0J; Thu, 05 Oct 2023 10:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoPiL-0003H9-8w
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoPiJ-0002eS-FA
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696517550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iZ9Vxv6NW5k6kQY+zJXrArYJgt6OYpUwlsKnGntUfUE=;
 b=MIQqz+NmSz27yDl45cNVR49trtlVNVFXHrfeJDdDHSy0kmmgl3uXraLW7ucYtkULJF5H5S
 gGpAjJxCQ6gEBUsLzMc/7SA2XPAHVHa5MwuQKTZMW9InARHqyKQ/yI7kSbxCHYYh0ajbbD
 0WUmeAexHLbXLkea3IjQAlSefkrhKEU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-rMQaNOWLPZ6dlLzO8Zn4hw-1; Thu, 05 Oct 2023 10:52:23 -0400
X-MC-Unique: rMQaNOWLPZ6dlLzO8Zn4hw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3ae3056a67fso301627b6e.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 07:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696517542; x=1697122342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZ9Vxv6NW5k6kQY+zJXrArYJgt6OYpUwlsKnGntUfUE=;
 b=wjvWCYIwMYAmxOchRem3jlYI5+CPSIfpbS0LSq3KA+FUlcWpPnwiFzlMCOrG4HZl3i
 DP6d6gALSmNWTj8dGp4QuLBpJVnH4EIPxAHBIwE4QNGoTX0PxL/j9JELL/b/+t/wzq5x
 gKq5ROiGwtb66dXsebaIYGg0/C5kr1S4ZsZnsLkTf18+kgZElofJClv8WBUbjaVX2TT6
 7C4YSakWViktmxLbkm2sNEXeNTKVKmQCTC9Mb/gGBJPDIaKo3teF5DmOlGVUgI7Z/egC
 hvpWIR/Z5xNlRXDQ2Gw2mHCJLCYEZUodtXCc1KWMvZc+Etu1LRJ7k1IVn4MxXGNix9kr
 3dCg==
X-Gm-Message-State: AOJu0YygpC6bXvrLm43034M49PxAlIfBKIBnryCxXlCjZU7/1KHVK7LR
 GXvg0ISZBuU2mClL83EOqD3qrn6Gld2qKTbi62eci+HheqX7VnbFSE7Zla9ILhUDQJqEz5DMVOP
 Gtq98Vo3WrV9pEsc=
X-Received: by 2002:a05:6808:138b:b0:3ad:aadd:6cbf with SMTP id
 c11-20020a056808138b00b003adaadd6cbfmr6576632oiw.0.1696517541932; 
 Thu, 05 Oct 2023 07:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnbv5C2feq1kwmy7Qja1D9p8910RJ4dYCHrikU+n0YQMGXythPyeKHAzWDNNkLn6EPxe9CUA==
X-Received: by 2002:a05:6808:138b:b0:3ad:aadd:6cbf with SMTP id
 c11-20020a056808138b00b003adaadd6cbfmr6576622oiw.0.1696517541639; 
 Thu, 05 Oct 2023 07:52:21 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g26-20020ac870da000000b00400a99b8b38sm522668qtp.78.2023.10.05.07.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 07:52:21 -0700 (PDT)
Date: Thu, 5 Oct 2023 10:52:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 28/52] migration/rdma: Check negative error values the
 same way everywhere
Message-ID: <ZR7Nov6Gu+4V14jf@x1n>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-29-armbru@redhat.com>
 <5b2560b5-63ed-37f0-5367-07ca55d43ab4@fujitsu.com>
 <87wmwed824.fsf@pond.sub.org> <87jzs2uz5d.fsf@secure.mitica>
 <ZR2ZYNB2Mw1Tej9i@x1n> <87a5sxaahv.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5sxaahv.fsf@pond.sub.org>
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

On Thu, Oct 05, 2023 at 07:45:00AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Sorry Zhijian, I missed this email.
> >
> > On Wed, Oct 04, 2023 at 06:32:14PM +0200, Juan Quintela wrote:
> >> > * Avoid non-negative integer error values.
> >
> > Perhaps we need to forbid that if doing this.
> >
> > I can see Zhijian's point, where "if (ret)" can also capture unexpected
> > positive returns, while "if (ret < 0)" is not clear on who's handling ret>0
> > case.  Personally I like that, too.
> 
> It's clear either way :)
> 
> The problem is calling a function whose contract specifies "return 0 on
> success, negative value on failure".
> 
> If it returns positive value, the contract is broken, and all bets are
> off.
> 
> If you check the return value like
> 
>     if (ret < 0) {
>         ... handle error and fail ...
>     }
>     ... carry on ...
> 
> then an unexpected positive value will clearly be treated as success.
> 
> If you check it like
> 
>     if (ret) {
>         ... handle error and fail ...
>     }
>     ... carry on ...
> 
> then it will clearly be treated as failure.
> 
> But we don't know what it is!  Treating it as success can be wrong,
> treating it as failure can be just as wrong.

Right, IMHO the major difference is when there's a bug in the retval
protocl of the API we're invoking.

With "if (ret)" we capture that protocol bug, treating it as a failure (of
that buggy API). With "if (ret<0)" we don't yet capture it, either
everything will just keep working, or something weird happens later.  Not
so predictable in this case.

Thanks,

-- 
Peter Xu


