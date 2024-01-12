Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEBC82BDB8
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 10:52:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOECM-0001De-DX; Fri, 12 Jan 2024 04:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1rOECK-0001Bv-0u
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 04:51:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1rOECI-0008Od-O9
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 04:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705053088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAG00ljOa7+phiUrv2MGISLhoCpEHfQlKCeaQZhiYgo=;
 b=Nzv3XV5KBP66Rb4VyygOiXASwH/oGkwzPrOPOWq0/qcTweokaGBwMWYksxqy/fNsWAcCDl
 Ff5ov8B3nkGU56+cAZyZ+rUZg735RioFDbuTT0EEu7a42rceDK1YCGz63uvgj3pdamVCUA
 Oo3zTMDcfQgx/fSi8kv9u6ciOnsUXm0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-S6EgxB4GO5-qojcarBfyUw-1; Fri, 12 Jan 2024 04:51:21 -0500
X-MC-Unique: S6EgxB4GO5-qojcarBfyUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9096B101A52A;
 Fri, 12 Jan 2024 09:51:21 +0000 (UTC)
Received: from localhost (unknown [10.22.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A72A112131D;
 Fri, 12 Jan 2024 09:51:21 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH v4 4/4] hw/misc/pvpanic: add support for normal shutdowns
In-Reply-To: <20240107-pvpanic-shutdown-v4-4-81500a7e4081@t-8ch.de>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de>
 <20240107-pvpanic-shutdown-v4-4-81500a7e4081@t-8ch.de>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 12 Jan 2024 10:51:20 +0100
Message-ID: <87bk9qop5z.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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

On Sun, Jan 07 2024, Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wrote:

> Shutdown requests are normally hardware dependent.
> By extending pvpanic to also handle shutdown requests, guests can
> submit such requests with an easily implementable and cross-platform
> mechanism.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
> ---
>  docs/specs/pvpanic.rst    | 2 ++
>  hw/misc/pvpanic.c         | 5 +++++
>  include/hw/misc/pvpanic.h | 3 ++-
>  3 files changed, 9 insertions(+), 1 deletion(-)

Not deeply involved with this, but looks reasonable to me.

Acked-by: Cornelia Huck <cohuck@redhat.com>


