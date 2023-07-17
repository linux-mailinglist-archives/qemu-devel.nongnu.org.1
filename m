Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF4A7568B0
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:06:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLQiF-0002Pc-Ik; Mon, 17 Jul 2023 12:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLQhs-0002Ch-2n
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLQhp-0004MR-AD
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689609851;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DwCJxum5WJPYwEDWEuNkqaCZURCnSxvFBoq7ZS/6+0Q=;
 b=Q4Ue4dttOj9L8G9p735krI0fd06wV1J6bHtBKprlhec99XoJvIvaZ8Jth6tzy1ZKJZnaS0
 IqPBZe3CltsmCHU9RFqHTCFUv9t+4U0YKO3fGGC9JFyRmMOpAQ+1ge99jkarElTe9stnua
 nHil/2JdEZjADhNYAHdf/b+nCJWmcyA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-4WQTGe8vPfCODHT1Y2X5PQ-1; Mon, 17 Jul 2023 12:04:07 -0400
X-MC-Unique: 4WQTGe8vPfCODHT1Y2X5PQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A1E9867940;
 Mon, 17 Jul 2023 16:04:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1FFD40C2063;
 Mon, 17 Jul 2023 16:04:05 +0000 (UTC)
Date: Mon, 17 Jul 2023 17:04:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Bin Meng <bin.meng@windriver.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH-for-8.1] hw/sd/sdcard: Allow users to bypass the
 power-of-2 size check
Message-ID: <ZLVmc9Cofb+7HC4H@redhat.com>
References: <20230717155316.17714-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717155316.17714-1-philmd@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jul 17, 2023 at 05:53:16PM +0200, Philippe Mathieu-Daudé wrote:
> Since we committed a9bcedd15a ("hw/sd/sdcard: Do not allow invalid
> SD card sizes") to preclude some guests to access beyond the size
> of the card (leading to security issues such CVE-2020-13253), various
> users complained this prevent them to run guests potencially well
> behaving with non-power-of-2 card sizes. In order to allow them to
> experiment with such guests, add a property to disable the pow2
> check.
> 
> Resolves: https://bugs.launchpad.net/qemu/+bug/1910586
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/297
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1754

IIUC from skimming those issues, it is more or less agreed
that having a power-of-2 check is not the right thing to
do in QEMU.

We've only kept it because no one has done the work to figure
out what the correct solution is so far and we didn't want to
leave the CVE open.

In theory we might oneday do the correct fix and remove this
bogus pow2 check. With that in mind...

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/sd/sd.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 77a717d355..feada6607a 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -108,6 +108,7 @@ struct SDState {
>      uint8_t spec_version;
>      BlockBackend *blk;
>      bool spi;
> +    bool bypass_pow2_size_check;
>  
>      /* Runtime changeables */
>  
> @@ -2126,6 +2127,9 @@ static void sd_instance_finalize(Object *obj)
>      timer_free(sd->ocr_power_timer);
>  }
>  
> +#define PROP_NAME_BYPASS_POW2_SIZE_CHECK \
> +    "allow-unsafe-unsupported-not-power-of-2-size"

...this property is at best a hack caused by our inability to
correctly fix the CVE so far.

This suggests it ought to have the 'x-' prefix to indicate
it isn't our desired long term solution and is liable to
change.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


