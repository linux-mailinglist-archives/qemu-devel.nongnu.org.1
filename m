Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D94CB710D01
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:10:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Ai1-0001Ty-JL; Thu, 25 May 2023 09:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2Ahw-0001S3-2V
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2Ahu-0008Dd-3q
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685020121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MvS0gVWHWKUbqVn2qVYS9i4DRi8s++aOYqAAidNZmNw=;
 b=hE0JprM6OR3tkRLpfysF4vH8ntlnUC/V4JWGxQ3faOgGqPrhOKglCDGjS+n6UlKKTp6Q38
 Y2PewPbfDtGLu+WdXrIQiILKGz0lxHOyeb4bke5riT1Z7ANIxO52xrSIHgVogVjxbtjmGn
 e5rxSv/ct47nHPpCmF4WXutuGKNaIvk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-8yUMu30vMeS_ZwAereptmg-1; Thu, 25 May 2023 09:08:37 -0400
X-MC-Unique: 8yUMu30vMeS_ZwAereptmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD73429AB443;
 Thu, 25 May 2023 13:08:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 908A920296C6;
 Thu, 25 May 2023 13:08:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A45D21E692E; Thu, 25 May 2023 15:08:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrei Gudkov <gudkov.andrei@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <quintela@redhat.com>,  <peterx@redhat.com>,
 <leobras@redhat.com>,  <eblake@redhat.com>
Subject: Re: [PATCH] qapi: better docs for calc-dirty-rate and friends
References: <fe7d32a621ebd69ef6974beb2499c0b5dccb9e19.1684854849.git.gudkov.andrei@huawei.com>
Date: Thu, 25 May 2023 15:08:35 +0200
In-Reply-To: <fe7d32a621ebd69ef6974beb2499c0b5dccb9e19.1684854849.git.gudkov.andrei@huawei.com>
 (Andrei Gudkov's message of "Tue, 23 May 2023 18:19:56 +0300")
Message-ID: <87sfbkpnho.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Andrei Gudkov <gudkov.andrei@huawei.com> writes:

> Rewrote calc-dirty-rate documentation. Briefly described
> different modes of dirty page rate measurement. Added some
> examples. Fixed obvious grammar errors.
>
> Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> ---
>  qapi/migration.json | 107 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 77 insertions(+), 30 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 179af0c4d8..19b51444b5 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1735,14 +1735,14 @@
>  ##
>  # @DirtyRateStatus:
>  #
> -# An enumeration of dirtyrate status.
> +# Dirty page rate measurement status.
>  #
> -# @unstarted: the dirtyrate thread has not been started.
> +# @unstarted: measuring thread has not been started yet
>  #
> -# @measuring: the dirtyrate thread is measuring.
> +# @measuring: measuring thread is running
>  #
> -# @measured: the dirtyrate thread has measured and results are
> -#     available.
> +# @measured: dirty page rate is measured and the results are
> +#     available
>  #
>  # Since: 5.2
>  ##
> @@ -1752,13 +1752,14 @@
>  ##
>  # @DirtyRateMeasureMode:
>  #
> -# An enumeration of mode of measuring dirtyrate.
> +# Method used to measure dirty page rate.  Differences between
> +# available methods are explained in @calc-dirty-rate.
>  #
> -# @page-sampling: calculate dirtyrate by sampling pages.
> +# @page-sampling: use page sampling
>  #
> -# @dirty-ring: calculate dirtyrate by dirty ring.
> +# @dirty-ring: use dirty ring
>  #
> -# @dirty-bitmap: calculate dirtyrate by dirty bitmap.
> +# @dirty-bitmap: use dirty bitmap
>  #
>  # Since: 6.2
>  ##
> @@ -1768,26 +1769,25 @@
>  ##
>  # @DirtyRateInfo:
>  #
> -# Information about current dirty page rate of vm.
> +# Information about measured dirty page rate.
>  #
>  # @dirty-rate: an estimate of the dirty page rate of the VM in units
> -#     of MB/s, present only when estimating the rate has completed.
> +#     of MiB/s. Value is present only when @status is 'measured'.

For consistency, please put two spaces between setences.

>  #
> -# @status: status containing dirtyrate query status includes
> -#     'unstarted' or 'measuring' or 'measured'
> +# @status: current status of dirty page rate measurements
>  #
>  # @start-time: start time in units of second for calculation
>  #
> -# @calc-time: time in units of second for sample dirty pages
> +# @calc-time: time period in units of second for which dirty page
> +#     rate was measured

Maybe

   # @calc-time: time period for which dirty page rate was measured
   #     (in seconds)

>  #
> -# @sample-pages: page count per GB for sample dirty pages the default
> -#     value is 512 (since 6.1)
> +# @sample-pages: number of sampled pages per each GiB of guest

per GiB

> +#     memory.  Value is valid only in page-sampling mode (Since 6.1)

Suggest "Valid only in ..."

>  #
> -# @mode: mode containing method of calculate dirtyrate includes
> -#     'page-sampling' and 'dirty-ring' (Since 6.2)
> +# @mode: mode that was used to measure dirty page rate (Since 6.2)
>  #
> -# @vcpu-dirty-rate: dirtyrate for each vcpu if dirty-ring mode
> -#     specified (Since 6.2)
> +# @vcpu-dirty-rate: dirty rate for each vCPU if dirty-ring mode
> +#     was specified (Since 6.2)
>  #
>  # Since: 5.2
>  ##
> @@ -1803,15 +1803,50 @@
>  ##
>  # @calc-dirty-rate:
>  #
> -# start calculating dirty page rate for vm
> -#
> -# @calc-time: time in units of second for sample dirty pages
> -#
> -# @sample-pages: page count per GB for sample dirty pages the default
> -#     value is 512 (since 6.1)
> -#
> -# @mode: mechanism of calculating dirtyrate includes 'page-sampling'
> -#     and 'dirty-ring' (Since 6.1)
> +# Starts measuring dirty page rate of the VM.  Results can be

Imperative mood: "Start measuring ..."

> +# retrieved with @query-dirty-rate after measurements are completed.
> +#
> +# Dirty page rate is the number of pages changed in a given time
> +# period expressed in MiB/s.  The following methods of calculation
> +# are available:
> +#
> +# 1. In page sampling mode, a random subset of pages are selected
> +#    and hashed twice: once in the beginning of measurement time

Suggest "once at the beginning"

> +#    period, another one -- in the end.  If two hashes for some page

Suggest ", and once again at the end".

> +#    are different, the page is counted as changed.  Since this
> +#    method relies on sampling and hashing, calculated dirty page
> +#    rate is only the estimation of its true value.  Setting
> +#    @sample-pages to higher value improves estimation quality but

Suggest "Increasing @sample-pages improves estimation quality at the
cost ..."

> +#    at the cost of higher computational overhead.
> +#
> +# 2. Dirty bitmap mode captures writes to memory by temporarily
> +#    revoking write access to all pages and counting page faults.

Comma before "and".

> +#    Information about modified pages is collected into bitmap,

"into a bitmap"

> +#    where each bit corresponds to one guest page.  This mode
> +#    requires that KVM accelerator property "dirty-ring-size=N"

Suggest just "dirty-ring-size" (omit "=N").

> +#    is *not* set.
> +#
> +# 3. Dirty ring mode is similar to dirty bitmap mode, but the
> +#    information about modified pages is collected into ring buffer.
> +#    This mode tracks page modification per each vCPU separately.

Either "for each vCPU" or "per vCPU".

> +#    It requires that KVM accelerator property "dirty-ring-size=N"
> +#    is set.

Suggest just "dirty-ring-size" (omit "=N").

> +#
> +# @calc-time: time period in units of second for which dirty page rate
> +#    is calculated.  Note that larger @calc-time values will typically
> +#    result in smaller dirty page rates because page dirtying is a
> +#    one-time event.  Once some page is counted as dirty during
> +#    @calc-time period, further writes to this page will not increase
> +#    dirty page rate anymore.

Please indent one more, for consistency.

> +#
> +# @sample-pages: number of sampled pages per each GiB of guest memory.
> +#     Default value is 512.  For 4KiB guest pages this corresponds to
> +#     sampling ratio of 0.2%.  This argument is used only in page
> +#     sampling mode. (Since 6.1)

Two spaces between '.' and '(', please.

> +#
> +# @mode: mechanism for tracking dirty pages.  Default value is
> +#    'page-sampling'.  Others are 'dirty-bitmap' and 'dirty-ring'.
> +#    (Since 6.1)
>  #
>  # Since: 5.2
>  #
> @@ -1828,9 +1863,21 @@
>  ##
>  # @query-dirty-rate:
>  #
> -# query dirty page rate in units of MB/s for vm
> +# Query results of the most recent invocation of @calc-dirty-rate.
>  #
>  # Since: 5.2
> +#
> +# Examples:
> +#
> +# 1. Measurement is in progress:
> +#
> +# <- {"status": "measuring", "sample-pages": 512,
> +#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10}
> +#
> +# 2. Measurement has been completed:
> +#
> +# <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
> +#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10}
>  ##
>  { 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }

This is *sooo* much better than before.  Thank you!

An R-by from a migration maintainer would be nice.

If you agree with my suggestions, I can apply them in my tree, saving
you a respin.  Let me know.

Acked-by: Markus Armbruster <armbru@redhat.com>


