Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F36719597
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:29:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dgd-0006ax-Vp; Thu, 01 Jun 2023 04:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4dgb-0006aj-Ky
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:29:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4dgZ-0002BU-S2
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685608171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2iUVzZhN6M2jHe4QFgtY4oZri16UaHZzwDKhYnKRqNc=;
 b=TSlc8Np+ndRiZKrXMuGkUpITlPPn3W2mfCq+G69tuji5YO18b1/4UchoMFTB2BdgeANzUv
 wwGkGFa+lNGzMGPXRb9oRqL31F0kuPnOr+cujSkK6u0fA+JM2Mc7HdZR1E89bcdpU8ovC9
 z9qpbkhpEv6YgxRv5u0v1/FXvucSO5I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-eZ015c6JPnqY0_CKvIOQHg-1; Thu, 01 Jun 2023 04:29:27 -0400
X-MC-Unique: eZ015c6JPnqY0_CKvIOQHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4143A1C04180;
 Thu,  1 Jun 2023 08:29:27 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96C2D421D7;
 Thu,  1 Jun 2023 08:29:26 +0000 (UTC)
Date: Thu, 1 Jun 2023 10:29:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Using json: in common.rc's TEST_IMG
Message-ID: <ZHhW5Qff1p2x0oB+@redhat.com>
References: <CAJSP0QX5XFw81XrHHn9p1pX+1y7tc+xMJLVx9YgRsMCkUwjW7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QX5XFw81XrHHn9p1pX+1y7tc+xMJLVx9YgRsMCkUwjW7Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

Am 31.05.2023 um 21:00 hat Stefan Hajnoczi geschrieben:
> Hi Hanna,
> I'm adding the io_uring block driver (block/blkio.c) to qemu-iotests
> and hit a syntax issue with json:.
> 
> In tests/qemu-iotests/common.rc where TEST_IMG_FILE and TEST_IMG are
> defined for each IMGPROTO, I'm unable to come up with a TEST_IMG that
> works with all test cases. Some test cases want:
> 
>   TEST_IMG="json:{\"file.driver\":\"io_uring\",\"file.filename\":\"$TEST_IMG_FILE\"}"
> 
> While others want:
> 
>   TEST_IMG="json:{\"driver\":\"io_uring\",\"filename\":\"$TEST_IMG_FILE\"}"
> 
> It seems to depend on how TEST_IMG is used by the tests.

The first one makes more sense, doesn't the second one override the
image format and effectively use raw images by going to the protocol
driver directly?

But should we use json: at all? All the other protocols don't make use
of it, but just use the real protocol prefix, i.e. what I would expect
here is io_uring:/foo/bar (which is already covered by the else branch
in common.rc).

Maybe this doesn't work currently for the libblkio block driver because
it doesn't implement .bdrv_parse_filename, but it would be nice to
support for human users anyway, so maybe just implement it as a small
wrapper around bdrv_parse_filename_strip_prefix()?

> For example, 001 works with the first version. When I use the second
> version it fails with:
> 
>   qemu-io: can't open device
> json:{"driver":"io_uring","filename":"/home/stefanha/qemu/build/scratch/raw-io_uring-001/t.raw"}:
> A block device must be specified for "file"
> 
> The opposite is true for 077, which works with the second version but
> fails as follows with the first version:
> 
>   qemu-io: can't open device
> blkdebug::json:{"file.driver":"io_uring","file.filename":"/home/stefanha/qemu/build/scratch/raw-io_uring-077/t.raw"}:
> Must specify either driver or file
> 
> This only seems to happen with json: because the other protocols use
> TEST_IMG=nfs://... and so on without any problems.
> 
> Any ideas?

Another problem I remember with json: is that you need different
escaping in qemu-img and -drive in qemu-system-*: The latter requires
commas to be doubled.

So with a single $TEST_IMG, you won't be able to cover both the tools
and the system emulator anyway.

Kevin


