Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 138047C6527
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 08:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqosm-0001Wo-C5; Thu, 12 Oct 2023 02:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqosR-0001HF-St
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 02:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqosQ-0002ua-5A
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 02:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697090931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=munozUPaeovICyLGXpqcIJhl6yDySEvPlJ/d0bXoJYk=;
 b=Uki75k5ec1DVgZBW2uEZR0ATzT/I/chhJ6Xv2n0TVsDB7+Oy+Q2MvQ50QXFxfzfL3KAezi
 ZlmZl+YhMOGj6XWXa3k2Mdm+OXLtfNWD3Wd4FzHzAa7nX5bXgThzAqipOx1aovBjyKxRSx
 4xu6TTOwb3nsjKwgcvo2jPn7iXLPwO8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-EBtHxFVaNnigjVrBgh95DA-1; Thu, 12 Oct 2023 02:08:44 -0400
X-MC-Unique: EBtHxFVaNnigjVrBgh95DA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1138D858F1D
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:08:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E51BAC5796D
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:08:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B97221E6904; Thu, 12 Oct 2023 08:08:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/virtio/virtio-gpu: Fix compiler warning when
 compiling with -Wshadow
References: <20231009084559.41427-1-thuth@redhat.com>
Date: Thu, 12 Oct 2023 08:08:43 +0200
In-Reply-To: <20231009084559.41427-1-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 9 Oct 2023 10:45:59 +0200")
Message-ID: <8734ygnzis.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Thomas Huth <thuth@redhat.com> writes:

> Avoid using trivial variable names in macros, otherwise we get
> the following compiler warning when compiling with -Wshadow=3Dlocal:
>
> In file included from ../../qemu/hw/display/virtio-gpu-virgl.c:19:
> ../../home/thuth/devel/qemu/hw/display/virtio-gpu-virgl.c:
>  In function =E2=80=98virgl_cmd_submit_3d=E2=80=99:
> ../../qemu/include/hw/virtio/virtio-gpu.h:228:16: error: declaration of =
=E2=80=98s=E2=80=99
>  shadows a previous local [-Werror=3Dshadow=3Dcompatible-local]
>   228 |         size_t s;
>       |                ^
> ../../qemu/hw/display/virtio-gpu-virgl.c:215:5: note: in expansion of mac=
ro
>  =E2=80=98VIRTIO_GPU_FILL_CMD=E2=80=99
>   215 |     VIRTIO_GPU_FILL_CMD(cs);
>       |     ^~~~~~~~~~~~~~~~~~~
> ../../qemu/hw/display/virtio-gpu-virgl.c:213:12: note: shadowed declarati=
on
>  is here
>   213 |     size_t s;
>       |            ^
> cc1: all warnings being treated as errors
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued.  Thanks!


