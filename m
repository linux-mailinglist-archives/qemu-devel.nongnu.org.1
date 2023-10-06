Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A84037BB59A
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 12:47:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoiLU-0007FZ-Eq; Fri, 06 Oct 2023 06:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoiLR-0007FQ-9U
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 06:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoiLN-0000tf-Jt
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 06:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696589164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8SnTZ5QgMw6Zl93PZYvbnR9tQUlFFhvD3KExLXkSac=;
 b=QD9HQqa9U1oHjP7C2SUbJWMiInPOYfvLwQuPnTnoJNSbOSpy+tY+yGQXVMH81cd3CM6UXq
 wfierZqUv268hQYErcg+6+h0BCAoqaFJ97e/OUPuvIqlPPsWeEHmZikuGF+34BG7a6gyUH
 rOPgVUobrPDSP0GxbQ0YgGVGvX/torI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-lDSF8qeyPH6Tkl0NQXLwtQ-1; Fri, 06 Oct 2023 06:45:51 -0400
X-MC-Unique: lDSF8qeyPH6Tkl0NQXLwtQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECB2F101AA42;
 Fri,  6 Oct 2023 10:45:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA7A0492C37;
 Fri,  6 Oct 2023 10:45:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DADFD21E6904; Fri,  6 Oct 2023 12:45:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org,  qemu-devel@nongnu.org,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] target/ppc: Clean up local variable shadowing in
 kvm_arch_*_registers()
References: <20231006053526.1031252-1-clg@kaod.org>
Date: Fri, 06 Oct 2023 12:45:49 +0200
In-Reply-To: <20231006053526.1031252-1-clg@kaod.org> (=?utf-8?Q?=22C=C3=A9?=
 =?utf-8?Q?dric?= Le Goater"'s
 message of "Fri, 6 Oct 2023 07:35:26 +0200")
Message-ID: <8734yoni5e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> Remove extra 'i' variable to fix this warning :
>
>   ../target/ppc/kvm.c: In function =E2=80=98kvm_arch_put_registers=E2=80=
=99:
>   ../target/ppc/kvm.c:963:13: warning: declaration of =E2=80=98i=E2=80=99=
 shadows a previous local [-Wshadow=3Dcompatible-local]
>     963 |         int i;
>         |             ^
>   ../target/ppc/kvm.c:906:9: note: shadowed declaration is here
>     906 |     int i;
>         |         ^
>   ../target/ppc/kvm.c: In function =E2=80=98kvm_arch_get_registers=E2=80=
=99:
>   ../target/ppc/kvm.c:1265:13: warning: declaration of =E2=80=98i=E2=80=
=99 shadows a previous local [-Wshadow=3Dcompatible-local]
>    1265 |         int i;
>         |             ^
>   ../target/ppc/kvm.c:1212:9: note: shadowed declaration is here
>    1212 |     int i, ret;
>         |         ^
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Queued, thanks!


