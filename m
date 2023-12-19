Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8918681883D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 14:05:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFZlH-0002km-FI; Tue, 19 Dec 2023 08:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFZlA-0002k7-LP
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 08:03:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFZl1-0000pF-L0
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 08:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702991014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gjbsB35Qsptzv4ZyuMpQVHa+Sm/T5dLDnMD7DOxn/Q=;
 b=QYuCQCNbIL7583rd25T8hR8E5V/q7dhnLZCv7sf/sznLGflRbdWMYY49af2UAhpMmRU1OF
 Nihz18G8Y8kaAWM3x1S6OjSjYOCbm7eJYNaB1n8nH2S996tvFOtsd8NCQGqVDwMKv0RWn3
 vJPqAxSCf3Ht72bQ2qCuAPciwrwYKR0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-xVlPGfygOLSN3BRIuhYcfg-1; Tue,
 19 Dec 2023 08:03:27 -0500
X-MC-Unique: xVlPGfygOLSN3BRIuhYcfg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE52F1C0513E;
 Tue, 19 Dec 2023 13:03:26 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EF6E2026D66;
 Tue, 19 Dec 2023 13:03:22 +0000 (UTC)
Date: Tue, 19 Dec 2023 14:03:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Paul Durrant <paul@xen.org>, Ari Sundholm <ari@tuxera.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Wen Congyang <wencongyang2@huawei.com>, Alberto Garcia <berto@igalia.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Xu <peterx@redhat.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 Fam Zheng <fam@euphon.net>, Leonardo Bras <leobras@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 00/14] aio: remove AioContext lock
Message-ID: <ZYGUmYOqEceAa9TY@redhat.com>
References: <20231205182011.1976568-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205182011.1976568-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 05.12.2023 um 19:19 hat Stefan Hajnoczi geschrieben:
> v2:
> - Add Patch 2 "scsi: assert that callbacks run in the correct AioContext" [Kevin]
> - Add Patch 7 "block: remove bdrv_co_lock()" [Eric and Kevin]
> - Remove stray goto label in Patch 8 [Kevin]
> - Fix "eeked" -> "eked" typo in Patch 10 [Eric]
> 
> This series removes the AioContext locking APIs from QEMU.
> aio_context_acquire() and aio_context_release() are currently only needed to
> support the locking discipline required by AIO_POLL_WHILE() (except for a stray
> user that I converted in Patch 1). AIO_POLL_WHILE() doesn't really need the
> AioContext lock anymore, so it's possible to remove the API. This is a nice
> simplification because the AioContext locking rules were sometimes tricky or
> underspecified, leading to many bugs of the years.
> 
> This patch series removes these APIs across the codebase and cleans up the
> documentation/comments that refers to them.
> 
> Patch 1 is a AioContext lock user I forgot to convert in my earlier SCSI
> conversion series.
> 
> Patch 2 adds an assertion to the SCSI code to ensure that callbacks are invoked
> in the correct AioContext.
> 
> Patch 3 removes tests for the AioContext lock because they will no longer be
> needed when the lock is gone.
> 
> Patches 4-10 remove the AioContext lock. These can be reviewed by categorizing
> the call sites into 1. places that take the lock because they call an API that
> requires the lock (ultimately AIO_POLL_WHILE()) and 2. places that take the
> lock to protect state. There should be no instances of case 2 left. If you see
> one, you've found a bug in this patch series!
> 
> Patches 11-14 remove comments.

Thanks, applied to the block branch.

Kevin


