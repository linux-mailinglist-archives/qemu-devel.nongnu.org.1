Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C7F7B2B9C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 07:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm6FE-0007Z4-63; Fri, 29 Sep 2023 01:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm6F9-0007Ye-O3
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm6F7-000301-UX
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695966049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HTU2U5at/oGLm813r4FX2y4WkWZegF841BrqRfY0wfE=;
 b=gtV0kLZj+5RBjY9SoAD5UpSDf5xR2naMKDgwmwrn46kW0L4fAMC3lRKZjQcEwaGKf1QOuR
 sL/kgbO22zV1yvmO191Tu9zGVmFLr0pl2vl3yZwscJ2cU5pAp+K7wWc4vcuTYXgKCUENvL
 /gVzSGz0BC1UN5yy6r6StE2wc5EI2DE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-vxH9Q7eaM-6gKxzS_CaeGA-1; Fri, 29 Sep 2023 01:40:43 -0400
X-MC-Unique: vxH9Q7eaM-6gKxzS_CaeGA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1827E8032F6;
 Fri, 29 Sep 2023 05:40:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9CE1492B16;
 Fri, 29 Sep 2023 05:40:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DEEE021E6904; Fri, 29 Sep 2023 07:40:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org
Subject: Re: [PATCH] test-throttle: don't shadow 'index' variable in
 do_test_accounting()
References: <20230922105742.81317-1-berto@igalia.com>
Date: Fri, 29 Sep 2023 07:40:41 +0200
In-Reply-To: <20230922105742.81317-1-berto@igalia.com> (Alberto Garcia's
 message of "Fri, 22 Sep 2023 12:57:42 +0200")
Message-ID: <87r0mhk04m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Alberto Garcia <berto@igalia.com> writes:

> Fixes build with -Wshadow=local
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/unit/test-throttle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
> index cb587e33e7..ac35d65d19 100644
> --- a/tests/unit/test-throttle.c
> +++ b/tests/unit/test-throttle.c
> @@ -625,7 +625,7 @@ static bool do_test_accounting(bool is_ops, /* are we testing bps or ops */
>      throttle_config_init(&cfg);
>  
>      for (i = 0; i < 3; i++) {
> -        BucketType index = to_test[is_ops][i];
> +        index = to_test[is_ops][i];
>          cfg.buckets[index].avg = avg;
>      }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
and queued, thanks!


