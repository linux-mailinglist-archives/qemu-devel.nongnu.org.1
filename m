Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB6871EF5D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:43:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kzj-0006oW-Nr; Thu, 01 Jun 2023 12:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4kzg-0006jv-Tt
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4kzf-0004aB-80
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685636262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ssEqADB5z0ighSnrov3StSs0E+58rN5buTzYNH9Kad4=;
 b=BC0OAx5cbdrs7/V2HduvMfGKWKqCr/D56u956HKXa50Hkn5dZV/DI87cy/Ia0ZZOCNH75Z
 M3q1mvBFqKVTlHQMha0WzNcd3xDjzDV3taxS2V1s4TxafgxRrS/BclpD8jU2fFVvwvg0oU
 L9gRCR1yVGYprydcMuBoQ6dyQKXWLso=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-xaXVXeOLO9aPhfeFC9ap6g-1; Thu, 01 Jun 2023 12:17:41 -0400
X-MC-Unique: xaXVXeOLO9aPhfeFC9ap6g-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f7d72d552fso2639341cf.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 09:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685636261; x=1688228261;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ssEqADB5z0ighSnrov3StSs0E+58rN5buTzYNH9Kad4=;
 b=Uv8PeIGe7E3F0O0TA8e9vlys9/U+Rc1c6dujaR3bMsE/qJmyUcI9iA2AR6nBBQPhJE
 iSdPqPPEaLb191M1HakMBy+FhwoCPzSp46PdSjsYXAg+mFBtTH48Wr9jIFJ2Nc9kKtey
 NZLudBjEW+TUCQumt7GU83G5RGRXl6ev1aMOmJ6uXveirjy4I1D1OxJ3XIlT19DKZhR+
 hsRxti8kpb4tZenarL8YYCObSYovg95OH9gRAFncIcmu8cXEeLXiIv5v/h/HniPUEsr0
 3HbIlMNf3DfdC9DnZr2Ew66J2g1FtIjqtf5KUOESucpkvTlPNigqjUy4JPqmSL+m6wxR
 KvAg==
X-Gm-Message-State: AC+VfDy0gHklwEa8R9yRzY6taMMgu5aYvnQF8iPP5cuMLegO/7I7zVKg
 +1WJb2vaw0jz8Ic6BkexoCfOAuCrdSkmjbfOrPrjePTR8GZBUp3+wZFEQrUNzwTRVcEw1jksv6v
 xxyq2qqDhY7nMaGw=
X-Received: by 2002:a05:622a:19a5:b0:3f2:38d:5c84 with SMTP id
 u37-20020a05622a19a500b003f2038d5c84mr7652279qtc.4.1685636260784; 
 Thu, 01 Jun 2023 09:17:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66PQ4otmR0I8P0wSI217fc2IXxJjJITfhQTttoTX2rvC5LDeFaniK7pCslYofQ/fBRP25Llg==
X-Received: by 2002:a05:622a:19a5:b0:3f2:38d:5c84 with SMTP id
 u37-20020a05622a19a500b003f2038d5c84mr7652251qtc.4.1685636260429; 
 Thu, 01 Jun 2023 09:17:40 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 i22-20020ac84896000000b003f6c49da398sm7801443qtq.76.2023.06.01.09.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 09:17:39 -0700 (PDT)
Date: Thu, 1 Jun 2023 12:17:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 8/9] tests/qtest: make more migration pre-copy
 scenarios run non-live
Message-ID: <ZHjEohiecAsu3ht6@x1n>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-9-berrange@redhat.com>
 <ZHi5gmd+5pQhDqBF@x1n> <ZHi7xLhUp0+5cay7@redhat.com>
 <ZHi+7bgcHPUisc8d@x1n> <ZHi/beg2UqoEnk/b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHi/beg2UqoEnk/b@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 01, 2023 at 04:55:25PM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 01, 2023 at 11:53:17AM -0400, Peter Xu wrote:
> > On Thu, Jun 01, 2023 at 04:39:48PM +0100, Daniel P. Berrangé wrote:
> > > On Thu, Jun 01, 2023 at 11:30:10AM -0400, Peter Xu wrote:
> > > > Thanks for looking into this.. definitely worthwhile.
> > > > 
> > > > On Wed, May 31, 2023 at 02:23:59PM +0100, Daniel P. Berrangé wrote:
> > > > > There are 27 pre-copy live migration scenarios being tested. In all of
> > > > > these we force non-convergance and run for one iteration, then let it
> > > > > converge and wait for completion during the second (or following)
> > > > > iterations. At 3 mbps bandwidth limit the first iteration takes a very
> > > > > long time (~30 seconds).
> > > > > 
> > > > > While it is important to test the migration passes and convergance
> > > > > logic, it is overkill to do this for all 27 pre-copy scenarios. The
> > > > > TLS migration scenarios in particular are merely exercising different
> > > > > code paths during connection establishment.
> > > > > 
> > > > > To optimize time taken, switch most of the test scenarios to run
> > > > > non-live (ie guest CPUs paused) with no bandwidth limits. This gives
> > > > > a massive speed up for most of the test scenarios.
> > > > > 
> > > > > For test coverage the following scenarios are unchanged
> > > > 
> > > > Curious how are below chosen?  I assume..
> > > 
> > > Chosen based on whether they exercise code paths that are unique
> > > and interesting during the RAM transfer phase.
> > > 
> > > Essentially the goal is that if we have N% code coverage before this
> > > patch, then we should still have the same N% code coverage after this
> > > patch.
> > > 
> > > The TLS tests exercise code paths that are unique during the migration
> > > establishment phase. Once establishd they don't exercise anything
> > > "interesting" during RAM transfer phase. Thus we don't loose code coverage
> > > by runing TLS tests non-live.
> > > 
> > > > 
> > > > > 
> > > > >  * Precopy with UNIX sockets
> > > > 
> > > > this one verifies dirty log.
> > > > 
> > > > >  * Precopy with UNIX sockets and dirty ring tracking
> > > > 
> > > > ... dirty ring...
> > > > 
> > > > >  * Precopy with XBZRLE
> > > > 
> > > > ... xbzrle I think needs a diff on old/new, makes sense.
> > > > 
> > > > >  * Precopy with UNIX compress
> > > > >  * Precopy with UNIX compress (nowait)
> > > > >  * Precopy with multifd
> > > > 
> > > > What about the rest three?  Especially for two compression tests.
> > > 
> > > The compress thread logic is unique/interesting during RAM transfer
> > > so benefits from running live. The wait vs non-wait scenario tests
> > > a distinct codepath/logic.
> > 
> > I assume you mean e.g. when compressing with guest page being modified and
> > we should survive that rather than crashing the compressor?
> 
> No, i mean the compression code has a significant behaviour difference
> between its two tests, because they toggle:
> 
>  @compress-wait-thread: Controls behavior when all compression
>      threads are currently busy.  If true (default), wait for a free
>      compression thread to become available; otherwise, send the page
>      uncompressed.  (Since 3.1)
> 
> so we need to exercise the code path that falls back to sending
> uncompressed, as well as the code path that waits for free threads.

But then the question is why live is needed?

IIUC whether the wait thing triggers have nothing directly related to VM is
live or not, but whether all compress thread busy.  IOW, IIUC all compress
paths will be tested even if non-live as long as we feed enough pages to
the compressor threads.

-- 
Peter Xu


