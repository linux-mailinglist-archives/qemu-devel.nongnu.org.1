Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89063708322
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdyM-0008HZ-Ep; Thu, 18 May 2023 09:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzdyJ-0008Gk-Qw
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzdyI-0000qD-8B
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684417629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eojCvYVbTxxEhPYFRSnGUvesrVF4GNBQRhEJbqtnb3I=;
 b=chHWRKDfUtrqCFcVJ3+oL9tofMxKAfo6c2WLT8Qim9svz09cucmxkJUkkyIDUzn9sgSbn+
 wu5CO6UAKyd1gtphaFkEldxcgDrNeEcsyvLydctvSY4cvOc4x5B+6RnplgNBhPIikXZLH5
 82A9HQt5LDWYgNvDuRfUR4v+W78zDp0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-Xb0i0n-9N3KH4ctteKdIew-1; Thu, 18 May 2023 09:47:06 -0400
X-MC-Unique: Xb0i0n-9N3KH4ctteKdIew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6880E185A79C;
 Thu, 18 May 2023 13:47:05 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E243B1402657;
 Thu, 18 May 2023 13:47:04 +0000 (UTC)
Date: Thu, 18 May 2023 08:47:03 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: hreitz@redhat.com, armbru@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2 18/19] cutils: Improve qemu_strtod* error paths
Message-ID: <vmtoohswtp4tmiugg3ynb2u6miuyucgq7itqb4ljkpfsqqm7ew@c6xxbyb6domb>
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-19-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512021033.1378730-19-eblake@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Thu, May 11, 2023 at 09:10:32PM -0500, Eric Blake wrote:
> 
> Previous patches changed all integral qemu_strto*() error paths to
> guarantee that *value is never left uninitialized.  Do likewise for
> qemu_strtod.  Also, tighten qemu_strtod_finite() to never return a
> non-finite value (prior to this patch, we were rejecting "inf" with
> -EINVAL and unspecified result 0.0, but failing "9e999" with -ERANGE
> and HUGE_VAL - which is infinite on IEEE machines - despite our
> function claiming to recognize only finite values).
> 
> Auditing callers, we have no external callers of qemu_strtod, and
> among the callers of qemu_strtod_finite:
> 
> - qapi/qobject-input-visitor.c:qobject_input_type_number_keyval() and
>   qapi/string-input-visitor.c:parse_type_number() which reject all
>   errors (does not matter what we store)
> 
> - utils/cutils.c:do_strtosz() incorrectly assumes that *endptr points
>   to '.' on all failures (that is, it is not distinguishing between
>   EINVAL and ERANGE; and therefore still does the WRONG THING for
>   "9.9e999".  The change here does not entirely fix that (a later
>   patch will tackle this more systematically), but at least the value
>   of endptr is now less likely to be out of bounds on overflow
> 
> - our testsuite, which we can update to match what we document
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> 
> ---

cc'ing qemu-stable for comments, since this patch fixes a sanitizer
issue flagged in https://gitlab.com/qemu-project/qemu/-/issues/1629.
While we decided the read-out-of-bounds in qemu_strtosz() is probably
not CVE-worthy (if you have control over the command line or QMP, you
can probably do much worse than cause a size parser to segfault), it
does raise the question of whether this patch is useful for
qemu-stable.  What's more, taking this patch in isolation without all
the prerequisite patches is probably sufficient to prevent the
read-out-of-bounds, but still leaves qemu_strtosz() with some odd
corner cases; while taking the whole series is a much bigger
committment but easier to analyze as a unit given that a lot of thte
series is testsuite unit test additions.  But either way, we'd need
reviews on this series if anyone thinks it warrants backports to
stable releases.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


