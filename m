Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D8B82B266
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 17:05:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxYi-0007CO-TY; Thu, 11 Jan 2024 11:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNxYY-0007BO-IP
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:05:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNxYV-0000kX-Ct
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704989115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKVd+DRmVJsVeaohR1mZypDtz2D65qz+Sgea77ugSk0=;
 b=jI+yYgkZ+afQdyl+cWatDlUmQSkCzjJWmZEHPJPcUifcbocPFMrYufKuGN9w2hRRnzrcPd
 B4qNndfdz7tAz/mi8ncEsVrJ9NTXa0clt2/tIRUQI7Jnq1NDa2NvgP9BeX2B/hFhUGACTG
 +83p6yRztSJi4TQt/zvt2BPjSTpmvIY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-8IkOwqzxO4qhJq_FoH6BLg-1; Thu,
 11 Jan 2024 11:05:11 -0500
X-MC-Unique: 8IkOwqzxO4qhJq_FoH6BLg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0915380606E;
 Thu, 11 Jan 2024 16:05:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E1FF5012;
 Thu, 11 Jan 2024 16:05:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B66AA21E6691; Thu, 11 Jan 2024 17:05:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org,  Stephen Brennan <stephen.s.brennan@oracle.com>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH v2 1/1] dump: Fix HMP dump-guest-memory -z without -R
In-Reply-To: <CAJ+F1C+c1VPOE8umoSED2EeKQcttcv=Y=3UQ=gGP6_hOCGL8Sg@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 11 Jan 2024
 19:10:03 +0400")
References: <20231222093827.951039-1-armbru@redhat.com>
 <20231222093827.951039-2-armbru@redhat.com>
 <87cyu8vyj4.fsf@pond.sub.org>
 <CAJ+F1C+c1VPOE8umoSED2EeKQcttcv=Y=3UQ=gGP6_hOCGL8Sg@mail.gmail.com>
Date: Thu, 11 Jan 2024 17:05:09 +0100
Message-ID: <87ply7svnu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi Markus
>
> On Thu, Jan 11, 2024 at 4:36=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Any takers?
>>
>
> I have it in my "dump" queue, but it's the only patch I got so far (I
> could have missed others).
>
> If it can go through my other means, that's fine with me

Let's try qemu-trivial (cc'ed).  Thanks!

>> Markus Armbruster <armbru@redhat.com> writes:


