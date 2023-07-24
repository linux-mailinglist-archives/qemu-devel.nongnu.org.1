Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE66775F3B2
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:45:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNt2j-0004dC-WB; Mon, 24 Jul 2023 06:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qNt2g-0004cq-Ha
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qNt2e-000875-Dn
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690195430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/R/okeuwd7l+Yak8QvYcl4NLz6C4dtJUR8j+C3WADGw=;
 b=EodP7w5LZ42ouKDZkqCZlabPOeTXniwc1Sp0FZaRBKJhZp8PigB1QERfjVmiv9nGiT5Ztq
 Fj4VR7XdGHrkxfT/ETuZC5HJxAlfC8HffLYpWPBcowPQ9WTBpru6sA+MIrO0pdstQ5rE0+
 95zrnH5YOSshe4H5Fh89k8F0lcttc0U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-dYPIlKuNNnOoLvDwuxduJA-1; Mon, 24 Jul 2023 06:43:47 -0400
X-MC-Unique: dYPIlKuNNnOoLvDwuxduJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7FE2895687;
 Mon, 24 Jul 2023 10:43:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52DE04087C68;
 Mon, 24 Jul 2023 10:43:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A38821E668C; Mon, 24 Jul 2023 12:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel@nongnu.org,  ~hyman <yong.huang@smartx.com>,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH QEMU v9 2/9] qapi/migration: Introduce
 x-vcpu-dirty-limit-period parameter
References: <168987012554.14797.8679831725383645706-2@git.sr.ht>
Date: Mon, 24 Jul 2023 12:43:45 +0200
In-Reply-To: <168987012554.14797.8679831725383645706-2@git.sr.ht>
 (hyman@git.sr.ht's message of "Wed, 07 Jun 2023 21:32:59 +0800")
Message-ID: <878rb5pp26.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

I missed something...

~hyman <hyman@git.sr.ht> writes:

> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> Introduce "x-vcpu-dirty-limit-period" migration experimental
> parameter, which is in the range of 1 to 1000ms and used to
> make dirty page rate calculation period configurable.
>
> Currently with the "x-vcpu-dirty-limit-period" varies, the
> total time of live migration changes, test results show the
> optimal value of "x-vcpu-dirty-limit-period" ranges from
> 500ms to 1000 ms. "x-vcpu-dirty-limit-period" should be made
> stable once it proves best value can not be determined with
> developer's experiments.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 47dfef0278..363055d252 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -789,9 +789,14 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> +#     limit during live migration. Should be in the range 1 to 1000ms,
> +#     defaults to 1000ms.  (Since 8.1)

You need to adjust all the "Since" tags to 8.2.=20=20

[...]


