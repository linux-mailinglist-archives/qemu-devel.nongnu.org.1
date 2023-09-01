Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 857AC78FBC1
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:29:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc1OO-0000SU-G2; Fri, 01 Sep 2023 06:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qc1OC-0000Rq-WE
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qc1OA-0005gg-K5
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693564109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sJ6k8sc3WQNaZFxBVTfduaT9stgucg0qTFXYj2eSTok=;
 b=hhXvwEvbq0qxaSecvTCboxTPXTWDG4mgAYJWJD5Hlx2MPMjopixdJTrAR+P5O7s2Ak/eWC
 nUxOce0GFgHorsTl53NL/bS/mFw6JqObTTDo6TA2VGM8M9nAln2kHw3RDNaU3ZR5mRY5lL
 5NQoKZAmwqtDaggGAMS+/jPyPi2RcWo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-eRSwTPnzMG6cigL187v-6w-1; Fri, 01 Sep 2023 06:28:26 -0400
X-MC-Unique: eRSwTPnzMG6cigL187v-6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54D433C1ACD5;
 Fri,  1 Sep 2023 10:28:26 +0000 (UTC)
Received: from localhost (unknown [10.42.28.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 233B11402C01;
 Fri,  1 Sep 2023 10:28:26 +0000 (UTC)
Date: Fri, 1 Sep 2023 11:28:25 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu-img: Update documentation for compressed images
Message-ID: <20230901102825.GF7636@redhat.com>
References: <20230901102430.23856-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901102430.23856-1-kwolf@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 01, 2023 at 12:24:30PM +0200, Kevin Wolf wrote:
> Document the 'compression_type' option for qcow2, and mention that
> streamOptimized vmdk supports compression, too.
> 
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Looks good, so:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

> ---
>  docs/tools/qemu-img.rst | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 15aeddc6d8..ca5a2773cf 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -106,7 +106,11 @@ by the used format or see the format descriptions below for details.
>  
>  .. option:: -c
>  
> -  Indicates that target image must be compressed (qcow format only).
> +  Indicates that target image must be compressed (qcow/qcow2 and vmdk with
> +  streamOptimized subformat only).
> +
> +  For qcow2, the compression algorithm can be specified with the ``-o
> +  compression_type=...`` option (see below).
>  
>  .. option:: -h
>  
> @@ -776,7 +780,7 @@ Supported image file formats:
>  
>    QEMU image format, the most versatile format. Use it to have smaller
>    images (useful if your filesystem does not supports holes, for example
> -  on Windows), optional AES encryption, zlib based compression and
> +  on Windows), optional AES encryption, zlib or zstd based compression and
>    support of multiple VM snapshots.
>  
>    Supported options:
> @@ -794,6 +798,17 @@ Supported image file formats:
>    ``backing_fmt``
>      Image format of the base image
>  
> +  ``compression_type``
> +    This option configures which compression algorithm will be used for
> +    compressed clusters on the image. Note that setting this option doesn't yet
> +    cause the image to actually receive compressed writes. It is most commonly
> +    used with the ``-c`` option of ``qemu-img convert``, but can also be used
> +    with the ``compress`` filter driver or backup block jobs with compression
> +    enabled.
> +
> +    Valid values are ``zlib`` and ``zstd``. For images that use
> +    ``compat=0.10``, only ``zlib`` compression is available.
> +
>    ``encryption``
>      If this option is set to ``on``, the image is encrypted with
>      128-bit AES-CBC.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org


