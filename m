Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2EF7FD0A3
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 09:24:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8FrR-0007zc-5o; Wed, 29 Nov 2023 03:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1r8FrO-0007zB-Eq
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 03:23:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1r8FrM-0001Ok-RO
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 03:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701246231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADmzhu/8DY+OfJQEMmAt4FVjfP0nIt8HrPxBGzZjuDg=;
 b=P3si8cc/2bDB0yk8S3JWjGdda59l1/iVV3is1HqBwz3BELVbeKRjxfsBhOgvbTJOXgOT6M
 4zptgTIUYY2sZ4ht6EoSqCGOYXg9RA6mOW63ao8I8Qk5t2uu/HmKQivYSg6PzZ3g+eebj1
 FB7I+Wrnb1mJ9pokDpfwGVkCKtPQFs4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-DXFV8MskP368vtIdLBzRtQ-1; Wed, 29 Nov 2023 03:23:48 -0500
X-MC-Unique: DXFV8MskP368vtIdLBzRtQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0C87805957;
 Wed, 29 Nov 2023 08:23:47 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A03821C060AE;
 Wed, 29 Nov 2023 08:23:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH v2 3/3] hw/misc/pvpanic: add support for normal shutdowns
In-Reply-To: <20231128-pvpanic-shutdown-v2-3-830393b45cb6@t-8ch.de>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20231128-pvpanic-shutdown-v2-0-830393b45cb6@t-8ch.de>
 <20231128-pvpanic-shutdown-v2-3-830393b45cb6@t-8ch.de>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 29 Nov 2023 09:23:46 +0100
Message-ID: <874jh5x90t.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 28 2023, Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wrote:

> Shutdown requests are normally hardware dependent.
> By extending pvpanic to also handle shutdown requests, guests can
> submit such requests with an easily implementable and cross-platform
> mechanism.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
> ---
>  docs/specs/pvpanic.rst                   | 2 ++
>  hw/misc/pvpanic.c                        | 5 +++++
>  include/hw/misc/pvpanic.h                | 2 +-
>  include/standard-headers/linux/pvpanic.h | 1 +
>  4 files changed, 9 insertions(+), 1 deletion(-)

(...)

> diff --git a/include/standard-headers/linux/pvpanic.h b/include/standard-=
headers/linux/pvpanic.h
> index 54b7485390d3..38e53ad45929 100644
> --- a/include/standard-headers/linux/pvpanic.h
> +++ b/include/standard-headers/linux/pvpanic.h
> @@ -5,5 +5,6 @@
>=20=20
>  #define PVPANIC_PANICKED	(1 << 0)
>  #define PVPANIC_CRASH_LOADED	(1 << 1)
> +#define PVPANIC_SHUTDOWN       	(1 << 2)
>=20=20
>  #endif /* __PVPANIC_H__ */
>

This hunk needs to come in via a separate headers update, or has to be
split out into a placeholder patch if it is not included in the Linux
kernel yet.


