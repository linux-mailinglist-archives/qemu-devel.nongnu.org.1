Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B469770512F
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 16:46:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyvvk-0003et-0g; Tue, 16 May 2023 10:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4936e02c6=anthony.perard@citrix.com>)
 id 1pyvvf-0003dq-Sm; Tue, 16 May 2023 10:45:32 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4936e02c6=anthony.perard@citrix.com>)
 id 1pyvvd-0006IA-9X; Tue, 16 May 2023 10:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1684248329;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XPbviYIhCynnrTIGSWjvBLeKf07MWzJPqOrTjUu9r5I=;
 b=XB4HtVOalC2BaqNJ1vN70biRkZ855cE9yxeX9eOPdJf30+ClBuByOo2Z
 jBzgeTQ5itq7NpV3MpXsb4dsxRC5G9RQzDJQriBaZjFi7+89Mu7fQkFiW
 M16le6xUvfV3ruerhawwazCXJTbQvU5iGrCqXfL3ZkMZGASgUPFSFCiFS Y=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 107987435
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:whRtCqtW8dSVJ8Y1YoA9u9FhXufnVIVYMUV32f8akzHdYApBsoF/q
 tZmKTzTbv2PZDChf91yaYjg805SvJaHzdJnTFNlpHo3HylE+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg3HVQ+IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4bKj6Vv0gnRkPaoQ5AKHySFPZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwN3MOXDqN3tuMkbuybOVSj5QkINnWM9ZK0p1g5Wmx4fcORJnCR+PB5MNC3Sd2jcdLdRrcT
 5NHM3w1Nk2GOkARfA5NU/rSn8/x7pX7WzRetFKSo7tx+2XJxRZ9+LPsLMDUapqBQsA9ckOw/
 zqZrjSmXkpHXDCZ4RqoqHy1tv3GoS+lQpsYLe2gr85hpELGkwT/DzVJDADm8JFVkHWWQM5SJ
 UUS+iMGt6U+9EW3CNL6WnWQrneBlhMBQ9pXFas85R3l4rDW5ACUHUAeQzJBYcBgv8gzLRQzy
 16Pg97tDBR1vbGVQG7b/bCRxRu/NDMNKnQDeQceQAcF6sWlq4Y25jrfQ9AmHKOrg9ndHTDr3
 yvMvCU4n68Uj8MAy+O851+vqzCxvYXASiYv6wnXV37j5QR8DKavapay4F7U4N5aIYqZR0XHt
 38B8+CG7OEKCJ2lkC2LSf8KWraz6J6tKzLVm0xmBZQJ7Tmh+3e/O4tX5VlWKUt0O9wIfhfpa
 UXQvhhNopleIBOCRqh2aZP3O9kCwq3pFNCjXffRBvJCfZ1uLieG+i90bEKd1myrl1Ij+YklO
 JybeNygS3YXD6hq1iGxQc8Z0Lki3Cd4wnncLbj+xg6s3L7YbWabRLMPOUaLRu885aKA5g7S9
 r53LNCWwh9SVOn/ZCj/8oMJK10Oa38hCvjes8FLe/STChBrFGEoF7naxrZJU4homK5Pn/zg5
 HyxWkZEjlH4gBXvLB6WQmpuZLPmQdB0qndTFTQmOlC62n4iSZyi4KcWa908erxP3O98yvp6Z
 +MId8WJHrJETTGv0yQcYIj6qoNgdTyhlB6DMyOjazV5dJllLyTS5ff7cwrr8iQSHGy7uKMWu
 7mI1QreWdwPSmxKFM/LbNq/wlX3umIS8MprUk7VZ9NXf07v2I5tLSP3k7kwOc5kARDOxieTk
 Q+fGwpC/cHCpoY09J/CgqXsh52uFe1/E1FTH23R4Ky5HSbf92unh4RHVY6gZD3YSSb49buvY
 c1TyPfzNuBBm0xF26J8Cbtq0bAW/dbjp7ZGiA9jGR3jZkymELp6LlGa3MNEsetGwboxhOetc
 hvRoJ8AY+zPYZ67VgdLf2LJc9hvy9kL2Trgx/psGX+r7SZR8ISOAUJeLySD3Xk1wKRODKspx
 uIoucgz4gO5iwY3Ptvush2451hgPVRbDfx568hy7JvDz1NylwocOcC05jreusnnVjlaDqU9z
 tZ4boLmjq8U+EfNemFb+ZPljbsE3sRmVPynITY/y7W1djjt3KdfMP55q25fouFpIvJvjYpO1
 pBDbREdGEl3124AaDJ/d26tARpdIxaS51b8zVAE/EWAERn0DzOQcjxkZbnXlKz8z467Vmkzw
 V1l4Dy9DWaCkD/ZhEPepnKJW9S8FIcsp2UuaeisHtifHolSXAcJdpSGPDJSwzO+WJNZuaEyj
 bUylAqGQfGhZHF4TmxSI9Xy6In8vzjadDMfEa0+pfhh8KO1UGja5AVi4nuZIqtlT8EmO2fjY
 yCyDqqjjyiD6Rs=
IronPort-HdrOrdr: A9a23:i8/w/66P2n8iNL3sBQPXwBHXdLJyesId70hD6qkRc20pTiX8ra
 uTdZsgtCMc9wxhPk3I9ertBEDCewKkyXcN2/hrAV76ZnidhILKFvAf0WKB+V3d8kTFn4Y26U
 4HScdD4bbLYGSS4/yV3OHEe+xQuOVvJJrY59s3sx9WPGZXgtlbnmRE4/GgYylLraB9dP8EKK
 Y=
X-Talos-CUID: =?us-ascii?q?9a23=3AZLK7BGsYtRCVIPp0+bq9dZAP6Is6MX7v5nmJGnX?=
 =?us-ascii?q?pAG9PRIOcGVic6J5rxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AYNIFCA2MWV/pGIwZcp8iK6/F0TUjw4n0Blk9g5w?=
 =?us-ascii?q?6t5eeLCZJay/EvD+TXdpy?=
X-IronPort-AV: E=Sophos;i="5.99,278,1677560400"; d="scan'208";a="107987435"
Date: Tue, 16 May 2023 15:45:14 +0100
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: <qemu-devel@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, <qemu-block@nongnu.org>, Paul Durrant
 <paul@xen.org>, Peter Lieven <pl@kamp.de>, Stefan Weil <sw@weilnetz.de>, Xie
 Yongji <xieyongji@bytedance.com>, Kevin Wolf <kwolf@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Richard
 Henderson <richard.henderson@linaro.org>, David Woodhouse
 <dwmw2@infradead.org>, Coiby Xu <Coiby.Xu@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Stefano Garzarella <sgarzare@redhat.com>, Philippe
 =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Daniel
 =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Julia Suvorova
 <jusual@redhat.com>, <xen-devel@lists.xenproject.org>, <eesposit@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, "Richard W.M. Jones"
 <rjones@redhat.com>, Fam Zheng <fam@euphon.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v5 12/21] xen-block: implement BlockDevOps->drained_begin()
Message-ID: <481d1f56-298c-49a3-9a55-5a205d4b20fd@perard>
References: <20230504195327.695107-1-stefanha@redhat.com>
 <20230504195327.695107-13-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230504195327.695107-13-stefanha@redhat.com>
Received-SPF: pass client-ip=216.71.155.168;
 envelope-from=prvs=4936e02c6=anthony.perard@citrix.com;
 helo=esa5.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, May 04, 2023 at 03:53:18PM -0400, Stefan Hajnoczi wrote:
> @@ -819,11 +841,9 @@ void xen_block_dataplane_start(XenBlockDataPlane *dataplane,
>      blk_set_aio_context(dataplane->blk, dataplane->ctx, NULL);
>      aio_context_release(old_context);
>  
> -    /* Only reason for failure is a NULL channel */
> -    aio_context_acquire(dataplane->ctx);
> -    xen_device_set_event_channel_context(xendev, dataplane->event_channel,
> -                                         dataplane->ctx, &error_abort);
> -    aio_context_release(dataplane->ctx);
> +    if (!blk_in_drain(dataplane->blk)) {

There's maybe something missing in the patch.
xen_block_dataplane_start() calls xen_device_bind_event_channel() just
before xen_block_dataplane_attach().

And xen_device_bind_event_channel() sets the event context to
qemu_get_aio_context() instead of NULL.

So, even if we don't call xen_block_dataplane_attach() while in drain,
there's already a fd_handler attach to the fd. So should
xen_device_bind_event_channel() be changed as well? Or maybe a call to
xen_block_dataplane_detach() would be enough.

(There's only one user of xen_device_bind_event_channel() at the moment
so I don't know if other implementation making use of this API will want
to call set_event_channel_context or not.)

> +        xen_block_dataplane_attach(dataplane);
> +    }
>  
>      return;
>  

-- 
Anthony PERARD

