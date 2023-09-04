Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD3D7914B3
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:27:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5r0-0003to-Om; Mon, 04 Sep 2023 05:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qd5qz-0003sv-10
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qd5qw-0008QO-NX
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693819597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JaiYsLSaA2+7v1W4m4aBP6Lnpbfe1oeD5zadKTYYAQU=;
 b=iyQI7rXY6ZcZz0lI2Z44JA3NvgkbzQ8m5/G69l9nSsh0X9qeACxA2SR7c9ByKa5+B+ELEZ
 GIDzAsIapryWQUGPYCu1sJKCpkNvxpxJ26ftHadLCrd2pybpo47+NTGtp2Cuili+rmr0ww
 q5BBicXy1B1EtTIH/1GFhn/z+xKFTB0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-zUn86kEuMLSS-VYsRkJAZQ-1; Mon, 04 Sep 2023 05:26:34 -0400
X-MC-Unique: zUn86kEuMLSS-VYsRkJAZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8407A3C19365;
 Mon,  4 Sep 2023 09:26:33 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.211])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F08111121314;
 Mon,  4 Sep 2023 09:26:31 +0000 (UTC)
Date: Mon, 4 Sep 2023 11:26:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, srowe@mose.org.uk, mike.maslenkin@gmail.com,
 qemu-block@nongnu.org, t.lamprecht@proxmox.com, a.lauterer@proxmox.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [POC 2/2] add test exposing AHCI reset issue
Message-ID: <ZPWixrdk1z4vHWTm@redhat.com>
References: <20230824133831.617833-1-f.ebner@proxmox.com>
 <20230824133831.617833-2-f.ebner@proxmox.com>
 <dec39419-cecf-ce7f-2b8c-af47575f80f2@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dec39419-cecf-ce7f-2b8c-af47575f80f2@proxmox.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 25.08.2023 um 12:17 hat Fiona Ebner geschrieben:
> Am 24.08.23 um 15:38 schrieb Fiona Ebner:
> > Fails without the previous commit "hw/ide: reset: cancel async DMA
> > operation before reseting state".
> > 
> > I haven't ever written such a test before, but I wanted something to
> > expose the problem more easily. It hardcodes the behavior that the
> > pending write actually is done during reset, which might not be ideal.
> > It could just check that the first sector is still intact instead.
> > 
> > If I should make this a proper test, I'd be happy about some guidance,
> > but not sure if required for such a specific one-off issue. After all,
> > a different variation of the bug might have written to some other
> > sector not covered by this test.
> > 
> 
> While trying to turn it into a proper test with Philippe's and Thomas's
> suggestions, I wanted to add a comment about the buffer size. So I tried
> figuring out what the "magic" value is. At the very beginning, I had
> tried 4 KiB, but then the callback wouldn't be pending, so I just picked
> 512 KiB for my proof-of-concept. It turns out to be racy though, and
> with a buffer size of 64 KiB, it is flaky whether or not the callback is
> still pending on my system. Should I just pick a large enough buffer
> size (maybe 4 MiB) and hope for the best?

If the problem is that the request may complete too fast, have you tried
using I/O throttling? This is a common approach in qemu-iotests.

Note however that a single big request won't be throttled. If you exceed
the limit, it's only the next request that has to wait until we made up
for the previous one. So you'll want to set the limit below the request
size of a first request (so that we do get some delay), but not much
lower (to avoid having to wait for too long), and then send the second
request that should be delayed for a bit.

Kevin


