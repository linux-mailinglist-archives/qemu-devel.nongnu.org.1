Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84034770774
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 20:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRzAT-0002pl-J2; Fri, 04 Aug 2023 14:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qRzAM-0002is-Pk
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 14:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qRzAK-0008Gi-Ud
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 14:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691172284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sw64/Tm68nJcHRXcy2dd0qXaCnP0J47c0cDXAKTYNAg=;
 b=F+p/y9fBPdDLzXQYO4TGND7HLnwfgC6nSGzsHQoEgbjIH6FwTC5gNVhJVzip4uewffKAX7
 fwmhGcuXYsHAebWfY23OxgMss+PvtaX2TVbORThQxBxrEvH1wMe3JrZ6h+ULOX6pp96wML
 Ii1MFugOzrlJkVGvQfbWNz0YvIAz2rU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-19UV-2VUOtORirexaqOl4w-1; Fri, 04 Aug 2023 14:04:40 -0400
X-MC-Unique: 19UV-2VUOtORirexaqOl4w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A585857FF8;
 Fri,  4 Aug 2023 18:04:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 054E940282C;
 Fri,  4 Aug 2023 18:04:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F6B921E692A; Fri,  4 Aug 2023 20:04:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrei Gudkov <gudkov.andrei@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <yong.huang@smartx.com>,
 <quintela@redhat.com>,  <peterx@redhat.com>,  <leobras@redhat.com>,
 <eblake@redhat.com>
Subject: Re: [PATCH v2] migration/calc-dirty-rate: millisecond-granularity
 period
References: <8ddb0d40d143f77aab8f602bd494e01e5fa01614.1691161009.git.gudkov.andrei@huawei.com>
Date: Fri, 04 Aug 2023 20:04:38 +0200
In-Reply-To: <8ddb0d40d143f77aab8f602bd494e01e5fa01614.1691161009.git.gudkov.andrei@huawei.com>
 (Andrei Gudkov's message of "Fri, 4 Aug 2023 18:03:27 +0300")
Message-ID: <87fs4y3cqx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Andrei Gudkov <gudkov.andrei@huawei.com> writes:

> Introduces alternative argument calc-time-ms, which is the
> the same as calc-time but accepts millisecond value.
> Millisecond granularity allows to make predictions whether
> migration will succeed or not. To do this, calculate dirty
> rate with calc-time-ms set to max allowed downtime, convert
> measured rate into volume of dirtied memory, and divide by
> network throughput. If the value is lower than max allowed
> downtime, then migration will converge.
>
> Measurement results for single thread randomly writing to
> a 1/4/24GiB memory region:
>
> +--------------+-----------------------------------------------+
> | calc-time-ms |                dirty rate MiB/s               |
> |              +----------------+---------------+--------------+
> |              | theoretical    | page-sampling | dirty-bitmap |
> |              | (at 3M wr/sec) |               |              |
> +--------------+----------------+---------------+--------------+
> |                             1GiB                             |
> +--------------+----------------+---------------+--------------+
> |          100 |           6996 |          7100 |         3192 |
> |          200 |           4606 |          4660 |         2655 |
> |          300 |           3305 |          3280 |         2371 |
> |          400 |           2534 |          2525 |         2154 |
> |          500 |           2041 |          2044 |         1871 |
> |          750 |           1365 |          1341 |         1358 |
> |         1000 |           1024 |          1052 |         1025 |
> |         1500 |            683 |           678 |          684 |
> |         2000 |            512 |           507 |          513 |
> +--------------+----------------+---------------+--------------+
> |                             4GiB                             |
> +--------------+----------------+---------------+--------------+
> |          100 |          10232 |          8880 |         4070 |
> |          200 |           8954 |          8049 |         3195 |
> |          300 |           7889 |          7193 |         2881 |
> |          400 |           6996 |          6530 |         2700 |
> |          500 |           6245 |          5772 |         2312 |
> |          750 |           4829 |          4586 |         2465 |
> |         1000 |           3865 |          3780 |         2178 |
> |         1500 |           2694 |          2633 |         2004 |
> |         2000 |           2041 |          2031 |         1789 |
> +--------------+----------------+---------------+--------------+
> |                             24GiB                            |
> +--------------+----------------+---------------+--------------+
> |          100 |          11495 |          8640 |         5597 |
> |          200 |          11226 |          8616 |         3527 |
> |          300 |          10965 |          8386 |         2355 |
> |          400 |          10713 |          8370 |         2179 |
> |          500 |          10469 |          8196 |         2098 |
> |          750 |           9890 |          7885 |         2556 |
> |         1000 |           9354 |          7506 |         2084 |
> |         1500 |           8397 |          6944 |         2075 |
> |         2000 |           7574 |          6402 |         2062 |
> +--------------+----------------+---------------+--------------+
>
> Theoretical values are computed according to the following formula:
> size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),
> where size is in bytes, time is in seconds, and wps is number of
> writes per second.
>
> Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> ---
>  qapi/migration.json   | 14 ++++++--
>  migration/dirtyrate.h | 12 ++++---
>  migration/dirtyrate.c | 81 +++++++++++++++++++++++++------------------
>  3 files changed, 67 insertions(+), 40 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8843e74b59..82493d6a57 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1849,7 +1849,11 @@
>  # @start-time: start time in units of second for calculation
>  #
>  # @calc-time: time period for which dirty page rate was measured
> -#     (in seconds)
> +#     (rounded down to seconds).
> +#
> +# @calc-time-ms: actual time period for which dirty page rate was
> +#     measured (in milliseconds).  Value may be larger than requested
> +#     time period due to measurement overhead.
>  #
>  # @sample-pages: number of sampled pages per GiB of guest memory.
>  #     Valid only in page-sampling mode (Since 6.1)
> @@ -1866,6 +1870,7 @@
>             'status': 'DirtyRateStatus',
>             'start-time': 'int64',
>             'calc-time': 'int64',
> +           'calc-time-ms': 'int64',
>             'sample-pages': 'uint64',
>             'mode': 'DirtyRateMeasureMode',
>             '*vcpu-dirty-rate': [ 'DirtyRateVcpu' ] } }
> @@ -1908,6 +1913,10 @@
>  #     dirty during @calc-time period, further writes to this page will
>  #     not increase dirty page rate anymore.
>  #
> +# @calc-time-ms: the same as @calc-time but in milliseconds.  These
> +#    two arguments are mutually exclusive.  Exactly one of them must
> +#    be specified. (Since 8.1)
> +#
>  # @sample-pages: number of sampled pages per each GiB of guest memory.
>  #     Default value is 512.  For 4KiB guest pages this corresponds to
>  #     sampling ratio of 0.2%.  This argument is used only in page
> @@ -1925,7 +1934,8 @@
>  #                                                 'sample-pages': 512} }
>  # <- { "return": {} }
>  ##
> -{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64',
> +{ 'command': 'calc-dirty-rate', 'data': {'*calc-time': 'int64',
> +                                         '*calc-time-ms': 'int64',
>                                           '*sample-pages': 'int',
>                                           '*mode': 'DirtyRateMeasureMode'} }
>  

Having both @calc-time and @calc-time-ms is ugly.

Can we deprecate @calc-time?

I don't like the name @calc-time-ms.  We don't put units in names
elsewhere.

Differently ugly: new member containing the fractional part, i.e. time
in seconds = calc-time + fractional-part / 1000.  With a better name, of
course.

[...]


