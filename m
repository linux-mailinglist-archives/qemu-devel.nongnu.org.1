Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB99797F8E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 02:16:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeP9d-0000Ch-Fz; Thu, 07 Sep 2023 20:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeP9b-0000CZ-Ba
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 20:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeP9Y-00040p-0X
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 20:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694132115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uXd0ZDt8ZC9QLp1LYV2OkgCPgDEPAzAE/EZaHQgXIyo=;
 b=Ma7AGFMV/G3DNcK5S0oBo9A/OtGrUwVBuK77gzUQ8Ot4n8LR870BAmm6bCqgpwGNXCzOc1
 YcST2MtaEfFtFgDt8hXjvQ5TPRTrC68UMyw99qSXvEm14gSrr5TCpyr8/mNRdC5fJafRxy
 9zd4NPdULfdTCu7hA6qHsgpavV/pwBw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-x0Me8mn-OEWl1lIA0_nAIg-1; Thu, 07 Sep 2023 20:15:13 -0400
X-MC-Unique: x0Me8mn-OEWl1lIA0_nAIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EA10101A529;
 Fri,  8 Sep 2023 00:15:11 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF26B2026D76;
 Fri,  8 Sep 2023 00:15:10 +0000 (UTC)
Date: Thu, 7 Sep 2023 19:15:08 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, den@virtuozzo.com
Subject: Re: [PATCH v2 4/3] qemu-iotests/197: use more generic commands for
 formats other than qcow2
Message-ID: <5uj3con3dyrkw4bxsci2fhilaf5u76lya2zbqawq74supj2qvz@aqububmuguho>
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
 <20230907220718.983430-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907220718.983430-1-andrey.drobyshev@virtuozzo.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Fri, Sep 08, 2023 at 01:07:18AM +0300, Andrey Drobyshev via wrote:
> In the previous commit e2f938265e0 ("tests/qemu-iotests/197: add
> testcase for CoR with subclusters") we've introduced a new testcase for
> copy-on-read with subclusters.  Test 197 always forces qcow2 as the top
> image, but allows backing image to be in any format.  That last test
> case didn't meet these requirements, so let's fix it by using more
> generic "qemu-io -c map" command.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  tests/qemu-iotests/197     |  8 ++++----
>  tests/qemu-iotests/197.out | 18 ++++++++----------
>  2 files changed, 12 insertions(+), 14 deletions(-)

Tested-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
> index f07a9da136..8ad2bdb035 100755
> --- a/tests/qemu-iotests/197
> +++ b/tests/qemu-iotests/197
> @@ -136,18 +136,18 @@ IMGPROTO=file IMGFMT=qcow2 TEST_IMG_FILE="$TEST_WRAP" \
>  $QEMU_IO -c "write -P 0xaa 0 64k" "$TEST_IMG" | _filter_qemu_io
>  
>  # Allocate individual subclusters in the top image, and not the whole cluster
> -$QEMU_IO -c "write -P 0xbb 28K 2K" -c "write -P 0xcc 34K 2K" "$TEST_WRAP" \
> +$QEMU_IO -f qcow2 -c "write -P 0xbb 28K 2K" -c "write -P 0xcc 34K 2K" "$TEST_WRAP" \
>      | _filter_qemu_io

Adding the -f qcow2 makes sense (this is a test of subcluster
behavior); and the backing file remains whatever format was passed to
./check.

> +++ b/tests/qemu-iotests/197.out
> @@ -42,17 +42,15 @@ wrote 2048/2048 bytes at offset 28672
>  2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  wrote 2048/2048 bytes at offset 34816
>  2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Offset          Length          File
> -0               0x7000          TEST_DIR/t.IMGFMT
> -0x7000          0x800           TEST_DIR/t.wrap.IMGFMT
> -0x7800          0x1000          TEST_DIR/t.IMGFMT
> -0x8800          0x800           TEST_DIR/t.wrap.IMGFMT
> -0x9000          0x7000          TEST_DIR/t.IMGFMT
> +28 KiB (0x7000) bytes not allocated at offset 0 bytes (0x0)
> +2 KiB (0x800) bytes     allocated at offset 28 KiB (0x7000)
> +4 KiB (0x1000) bytes not allocated at offset 30 KiB (0x7800)
> +2 KiB (0x800) bytes     allocated at offset 34 KiB (0x8800)
> +28 KiB (0x7000) bytes not allocated at offset 36 KiB (0x9000)
>  read 4096/4096 bytes at offset 30720

Same information, but without the backing file details (which clears
up the problem with -nbd).

Reviewed-by: Eric Blake <eblake@redhat.com>

Adding to my NBD queue, for a pull request soon.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


