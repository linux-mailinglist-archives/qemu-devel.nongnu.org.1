Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C4C7B7D67
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 12:39:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzGy-0004o2-Hf; Wed, 04 Oct 2023 06:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qnzGs-0004mw-Hr
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qnzGr-0004VG-48
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696415903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oeUeOzNQn5LeTtsXk8c9WPhKgOvhr5/PqRXx+JhEJ4=;
 b=BNkPM419E+8oHdhZU7ItxJQCfm+a02KhWmtJhZE2Z4R3Att5FX7YxgGyncjcNvLRQN3XoA
 ANTPwdBPexn2AQa43QJ1KbV/HT/YT9wo8+fEsTCrwCIfLpHZY3vW4S0+xbM36VDWrhzOOE
 OLzZaCkkSpWAGdx4rS9bFD+5rEjPpJw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-vGl9cecWNjqRjPc_MXRkfQ-1; Wed, 04 Oct 2023 06:38:20 -0400
X-MC-Unique: vGl9cecWNjqRjPc_MXRkfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 051B2802E5A;
 Wed,  4 Oct 2023 10:38:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D690E40C6EA8;
 Wed,  4 Oct 2023 10:38:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E629521E6904; Wed,  4 Oct 2023 12:38:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org,  qemu-devel@nongnu.org,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Nicholas Piggin <npiggin@gmail.com>,  Markus
 Armbruster <armbru@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2] target/ppc: Rename variables to avoid local variable
 shadowing in VUPKPX
References: <20230929083143.234553-1-clg@kaod.org>
Date: Wed, 04 Oct 2023 12:38:18 +0200
In-Reply-To: <20230929083143.234553-1-clg@kaod.org> (=?utf-8?Q?=22C=C3=A9d?=
 =?utf-8?Q?ric?= Le Goater"'s
 message of "Fri, 29 Sep 2023 10:31:43 +0200")
Message-ID: <87a5syk6zp.fsf@pond.sub.org>
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> and fix such warnings :
>
>   ../target/ppc/int_helper.c: In function =E2=80=98helper_vupklpx=E2=80=
=99:
>   ../target/ppc/int_helper.c:2025:21: warning: declaration of =E2=80=98r=
=E2=80=99 shadows a parameter [-Wshadow=3Dlocal]
>    2025 |             uint8_t r =3D (e >> 10) & 0x1f;                    =
           \
>         |                     ^
>   ../target/ppc/int_helper.c:2033:1: note: in expansion of macro =E2=80=
=98VUPKPX=E2=80=99
>    2033 | VUPKPX(lpx, UPKLO)
>         | ^~~~~~
>   ../target/ppc/int_helper.c:2017:41: note: shadowed declaration is here
>    2017 |     void helper_vupk##suffix(ppc_avr_t *r, ppc_avr_t *b)       =
         \
>         |                              ~~~~~~~~~~~^
>   ../target/ppc/int_helper.c:2033:1: note: in expansion of macro =E2=80=
=98VUPKPX=E2=80=99
>    2033 | VUPKPX(lpx, UPKLO)
>         | ^~~~~~
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Queued.  Thanks!


