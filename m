Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A22177A067B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:52:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmk5-00083O-AR; Thu, 14 Sep 2023 09:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qgmjp-0007yt-Jg
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qgmjm-0007W4-K3
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694699427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UcHna+eJdO4LZfxRwHAavh5g3+XqGGpcIAnlR8LTWSQ=;
 b=eVYW0rpaNWzNifDd0DI89SfPoKLlKYI0im+XR1GgjbO98G5ydhNQAWy3Jfpfp84O918EfD
 mDKW6vtk7t9CM9LGmFJaazrNKLqZd9HaF6C1Z+jxWSLLgLpniMGwd2fdZmhwDhCFIqAQT3
 4NZuPyGuviHSv+sLPlCbXWi3DitkyCs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-Qfl5xTNJNpOLe7NXejF6ug-1; Thu, 14 Sep 2023 09:50:25 -0400
X-MC-Unique: Qfl5xTNJNpOLe7NXejF6ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB933823D79
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:50:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9CFF2904
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:50:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5D42F21E6900; Thu, 14 Sep 2023 15:50:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 07/11] qapi: fix example of query-rocker-of-dpa-flows
 command
References: <20230911104017.65397-1-victortoso@redhat.com>
 <20230911104017.65397-8-victortoso@redhat.com>
Date: Thu, 14 Sep 2023 15:50:23 +0200
In-Reply-To: <20230911104017.65397-8-victortoso@redhat.com> (Victor Toso's
 message of "Mon, 11 Sep 2023 12:40:15 +0200")
Message-ID: <87ttrwn9sw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Victor Toso <victortoso@redhat.com> writes:

> Example output has a comment embedded in the array. Remove it.
> The end result is a list of size 1.
>
> Signed-off-by: Victor Toso <victortoso@redhat.com>
> ---
>  qapi/rocker.json | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/qapi/rocker.json b/qapi/rocker.json
> index 31ce0b36f6..858e4f4a45 100644
> --- a/qapi/rocker.json
> +++ b/qapi/rocker.json
> @@ -249,8 +249,7 @@
>  #                   "cookie": 0,
>  #                   "action": {"goto-tbl": 10},
>  #                   "mask": {"in-pport": 4294901760}
> -#                  },
> -#                  {...more...},
> +#                  }
>  #    ]}
>  ##
>  { 'command': 'query-rocker-of-dpa-flows',

The schema patches in this series fix typos, except for this patch and
the next one, which drop "more of the same omitted for brevity" text.  I
believe you drop the text because it doesn't parse as JSON.

Fine if the example still make sense afterwards.  Do they?

Shortening examples is a reasonable thing to do.  Perhaps we should
adopt a conventional way to do it, and teach the proposed generator to
cope with it.  What do you think?


