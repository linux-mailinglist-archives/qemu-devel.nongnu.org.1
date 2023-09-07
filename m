Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A20E797155
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 11:46:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeBZv-0001JO-Jj; Thu, 07 Sep 2023 05:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qeBZf-0001DJ-UV
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qeBZd-0001j2-46
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694079914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFo4kCKptL5vyrQKrsJ8EyQFDhRulxFJgf8F1Kfxf7M=;
 b=Om1gMhdQ9zJVLEm0MNSGFgCw3VUHof+8UH+bXbHlVb4jwtpXDMbXk6a9Glh1io0Ote9i8P
 yAXKL7aE8/A1DlRbwCF5xE5/i1vZAX6PDNxjqfy9PaAQBCnfm+Vy2M9cAYdBvAQV7Y3r/9
 /hFvaEqmPvCLHL11dRt2IRsImKT9rv8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613--0qcaw3UPQKtupTXg8BwcA-1; Thu, 07 Sep 2023 05:45:11 -0400
X-MC-Unique: -0qcaw3UPQKtupTXg8BwcA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA585817077;
 Thu,  7 Sep 2023 09:45:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A41A4525726;
 Thu,  7 Sep 2023 09:45:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B03C521E6936; Thu,  7 Sep 2023 11:45:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  William Tsai <williamtsai1111@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,  Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/1] qom: fix setting of qdev array properties
References: <20230904162544.2388037-1-berrange@redhat.com>
Date: Thu, 07 Sep 2023 11:45:09 +0200
In-Reply-To: <20230904162544.2388037-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 4 Sep 2023 17:25:43
 +0100")
Message-ID: <874jk69v16.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> By the time of the 8.2.0 release, it will have been 2 years and 6
> releases since we accidentally broke setting of array properties
> for user creatable devices:
>
>   https://gitlab.com/qemu-project/qemu/-/issues/1090
>
> Some context:
>
> * Initial identification / report on the mailing list
>
>    https://lists.gnu.org/archive/html/qemu-devel/2022-07/msg00111.html
>
> * Sub-thread of that exploring the background on need/use of array
>   properties:
>
>    https://lists.gnu.org/archive/html/qemu-devel/2022-07/msg01531.html
>
> * Markus' initial PoC for an order preserving QDict impl
>
>    https://lists.gnu.org/archive/html/qemu-devel/2022-07/msg00758.html
>
> * A later (unrelated?) patch for order preserving QDict impl
>
>    https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03229.html
>
> * A re-posting of the new patch
>
>    https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg00292.html
>
> Personally I'm not a fan of the introducing the order preserving QDict
> impl, because I feel that the need to preserve QDict ordering is a
> design bug. Not that I think the current ordering when iterating over
> QDict is in any way special. I just rather see the ordering left as
> "undefined" and any callers that need a specific ordering should apply
> what they need.

QDict preserving order was never intended to be part of the interface.
But then Hyrum's Law kicked in.

Since it's been broken for so long, we now have a chance to kick it back
out.

However, if we want an order-preserving hash table (stress on *if*!), be
it for QDict or other uses: do it the elegant way it's done in Python.
Fun little project, but I couldn't justify the expense of doing it.

[...]


