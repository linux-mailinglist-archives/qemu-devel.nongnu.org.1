Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B2F785F03
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 19:57:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYs5Q-0004qX-EZ; Wed, 23 Aug 2023 13:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qYs5A-0004q7-MD
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 13:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qYs58-0002Ei-S5
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 13:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692813348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MLIs8Cx20YpCO9jsIYZZYYS3hwhYZvPyGjkGiNFcibk=;
 b=Q91NrAjTVKCbNKu6+YtOoX0+fymgvJV6XN8bNMH2Coe1ZR8SR3JYgwhO3J81IEDsAUY2WN
 blbHUTswdPbVfvvOaQYb7RxwuMpcGXQz68ip5WibOKF8IMK7z/8Wti2XbA1JmNeFmX9qMB
 2xaPdDNv+MGpQNBIug+L+RGGKIyYVLQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-U057pLz_O9m-Qw1OMaSBdQ-1; Wed, 23 Aug 2023 13:55:47 -0400
X-MC-Unique: U057pLz_O9m-Qw1OMaSBdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF99D8D40A1;
 Wed, 23 Aug 2023 17:55:46 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99FD4C15BAE;
 Wed, 23 Aug 2023 17:55:46 +0000 (UTC)
Date: Wed, 23 Aug 2023 12:55:44 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 22/24] tests/: spelling fixes
Message-ID: <xu3di33awphpggqem25ebfasbveyyvb35fznf4b46xjgxiucv4@nawbmm3tgxqp>
References: <cover.1691405748.git.mjt@tls.msk.ru>
 <20230823055155.1917375-23-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823055155.1917375-23-mjt@tls.msk.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Wed, Aug 23, 2023 at 08:51:53AM +0300, Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---

> +++ b/tests/qemu-iotests/298
> @@ -142,5 +142,5 @@ class TestTruncate(iotests.QMPTestCase):
>  
>          # Probably we'll want preallocate filter to keep align to cluster when
> -        # shrink preallocation, so, ignore small differece
> +        # shrink preallocation, so, ignore small difference

The sentence as a whole still comes across awkwardly; maybe shorten and reword to:

The preallocate filter may keep cluster alignment when shrinking, so
ignore small differences

> +++ b/tests/qtest/fuzz/generic_fuzz.c
> @@ -847,7 +847,7 @@ static void generic_pre_fuzz(QTestState *s)
>   *
>   * This function attempts to produce an input that:
> - * Ouptut: maps a device's BARs, set up three DMA patterns, triggers
> + * Output: maps a device's BARs, set up three DMA patterns, triggers
>   *          functionality A device, replaces the DMA patterns with a single
> - *          patten, and triggers device functionality B.
> + *          pattern, and triggers device functionality B.

As long as you're touching neighboring lines,

s/functionality A device/device functionality A/

> +++ b/tests/unit/test-throttle.c
> @@ -136,5 +136,5 @@ static void test_compute_wait(void)
>          g_assert(double_cmp(bkt.level, (i + 1) * (bkt.max - bkt.avg) / 10));
>          /* We can do bursts for the 2 seconds we have configured in
> -         * burst_length. We have 100 extra miliseconds of burst
> +         * burst_length. We have 100 extra milliseconds of burst
>           * because bkt.level has been leaking during this time.
>           * After that, we have to wait. */
> @@ -380,5 +380,5 @@ static void test_is_valid(void)
>      /* zero are valids */
>      test_is_valid_for_value(0, true);
> -    /* positives numers are valids */
> +    /* positives numbers are valids */

Multiple grammar errors in this function.  Should be:

/* negative numbers are invalid */
/* zero is valid */
/* positive numbers are valid */


All other changes in this patch look good.  With additional tweaks,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


