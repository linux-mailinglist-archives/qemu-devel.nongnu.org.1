Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C173982AECD
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 13:35:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNuHJ-0005qc-TE; Thu, 11 Jan 2024 07:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNuH1-0005Wt-4I
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:35:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNuGy-0006MX-0x
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704976498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCoAI8KxMdLfNcMwvhgWEu+8HfOlFYH1qErLIwRtpAU=;
 b=i0OKTITV8dFPopMcCms1Kvh1neI87Uph8cFFZ5AoRkTwJHV6V+7fiQBnba3t3COVeRwt52
 hB53Wca3UKUmVup0kQtcebqdvA3I529ez6tVaqnb9VlQU9UU3tm7Ph1vKLpKsk/YVnp8uF
 rNpiTf87ny/lkRyuJGOvaJrXUlmGo3Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-zxXgXFebMnSrxiBZ3QxPzA-1; Thu, 11 Jan 2024 07:34:57 -0500
X-MC-Unique: zxXgXFebMnSrxiBZ3QxPzA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17FEE85A589;
 Thu, 11 Jan 2024 12:34:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9186492C2E;
 Thu, 11 Jan 2024 12:34:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E58BB21E6682; Thu, 11 Jan 2024 13:34:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 1/1] dump: Fix HMP dump-guest-memory -z without -R
In-Reply-To: <20231222093827.951039-2-armbru@redhat.com> (Markus Armbruster's
 message of "Fri, 22 Dec 2023 10:38:27 +0100")
References: <20231222093827.951039-1-armbru@redhat.com>
 <20231222093827.951039-2-armbru@redhat.com>
Date: Thu, 11 Jan 2024 13:34:55 +0100
Message-ID: <87cyu8vyj4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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

Any takers?

Markus Armbruster <armbru@redhat.com> writes:

> -z without -R has no effect: the dump format remains @elf.  Fix the
> logic error so it becomes @kdump-zlib.
>
> Fixes: e6549197f7ed (dump: Add command interface for kdump-raw formats)
> Fixes: CID 1523841
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  dump/dump-hmp-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
> index b428ec33df..d9340427c3 100644
> --- a/dump/dump-hmp-cmds.c
> +++ b/dump/dump-hmp-cmds.c
> @@ -41,7 +41,7 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *q=
dict)
>          dump_format =3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
>      }
>=20=20
> -    if (zlib && raw) {
> +    if (zlib) {
>          if (raw) {
>              dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_ZLIB;
>          } else {


