Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB317B2C97
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:49:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm7JK-0003w8-Lk; Fri, 29 Sep 2023 02:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm7JG-0003vn-Uy
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm7JF-0001bT-FG
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695970148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyXeijo+L2/98vZmtX964xSc9SgqNX+iBUS6PqFrbZ8=;
 b=RSUTk/XydSwtaTvYev80Etw65s2Zb978v19baUOgIYIxzp9NBzIwCoU2HNqhIvt+EYB9gz
 GsjKCO1Hrk7bXZlFk6KJh/qnTrPH+AfZT32qdRIuXVA5Eh7N0lt44vkqM72lKs5jllgaNS
 sjXsylviSbrcP4ginICnrmtr80Wo79w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-3NPlf9IJO-ibsB2zRruUdQ-1; Fri, 29 Sep 2023 02:49:06 -0400
X-MC-Unique: 3NPlf9IJO-ibsB2zRruUdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5954C800888
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 06:49:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37EB19A
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 06:49:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4727621E6904; Fri, 29 Sep 2023 08:49:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] seccomp: avoid shadowing of 'action' variable
References: <20230922160644.438631-1-berrange@redhat.com>
 <20230922160644.438631-3-berrange@redhat.com>
Date: Fri, 29 Sep 2023 08:49:05 +0200
In-Reply-To: <20230922160644.438631-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 22 Sep 2023 17:06:44
 +0100")
Message-ID: <8734yxiie6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> This is confusing as one 'action' variable is used for storing
> a SCMP_ enum value, while the other 'action' variable is used
> for storing a SECCOMP_ enum value.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  softmmu/qemu-seccomp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/softmmu/qemu-seccomp.c b/softmmu/qemu-seccomp.c
> index d66a2a1226..4d7439e7f7 100644
> --- a/softmmu/qemu-seccomp.c
> +++ b/softmmu/qemu-seccomp.c
> @@ -283,9 +283,9 @@ static uint32_t qemu_seccomp_update_action(uint32_t a=
ction)
>      if (action =3D=3D SCMP_ACT_TRAP) {
>          static int kill_process =3D -1;
>          if (kill_process =3D=3D -1) {
> -            uint32_t action =3D SECCOMP_RET_KILL_PROCESS;
> +            uint32_t testaction =3D SECCOMP_RET_KILL_PROCESS;
>=20=20
> -            if (qemu_seccomp(SECCOMP_GET_ACTION_AVAIL, 0, &action) =3D=
=3D 0) {
> +            if (qemu_seccomp(SECCOMP_GET_ACTION_AVAIL, 0, &testaction) =
=3D=3D 0) {
>                  kill_process =3D 1;
>              } else {
>                  kill_process =3D 0;

I'd prefer @test_action.  Regardless:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


