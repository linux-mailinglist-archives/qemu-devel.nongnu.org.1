Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C46712548
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:10:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2VJT-0007Bj-9U; Fri, 26 May 2023 07:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1q2VJN-000773-BH
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1q2VJL-0007lQ-Ga
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685099321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uOJzuTsGll9BhzdRyFOAZyaCb9jjfJ0ymqPttzTQSh8=;
 b=KEORtEV0WzgdSu7TmrfKOWWqKwApFRk8HWQqZ04s0NRc3z0U7li+1qr45idt6gwAlWVwNe
 olyyFhN/mX4r/u0IdJQZuomFuTzDWtZZRDGg1u2gpB4A00uk+x2nSkGBhM0lEhAUCvLkcn
 ag2xhu46Arx4k3uIg+htYnqEppxFUe8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-oYHgbrO1NkeVrDKqQ6HMiw-1; Fri, 26 May 2023 07:07:20 -0400
X-MC-Unique: oYHgbrO1NkeVrDKqQ6HMiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE244384CC4A
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 11:07:19 +0000 (UTC)
Received: from fedora (unknown [10.43.2.118])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88062140EBD7;
 Fri, 26 May 2023 11:07:12 +0000 (UTC)
Date: Fri, 26 May 2023 13:07:10 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, libvir-list@redhat.com,
 Andrea Bolognani <abologna@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: query-command-line-options
Message-ID: <ZHCS3vXnyE9ouEf3@fedora>
References: <cover.1677511354.git.pkrempa@redhat.com>
 <8718b22eda052662087087b4ce659b054974c9e0.1677511354.git.pkrempa@redhat.com>
 <CABJz62PHsQHiyo06PtfcDeS1LddYyDw2pC_seObtZcLR5cPQyQ@mail.gmail.com>
 <Y/zng8+7s05O0tRd@angien.pipo.sk>
 <CABJz62OMWXAx_ExYqvvg1DvcHkiP+SkwNMQZ+56QwoHpsNBqGA@mail.gmail.com>
 <87jzzsc320.fsf_-_@pond.sub.org> <ZAdKHkUIKjPLhFn7@angien.pipo.sk>
 <87sfbjcw0s.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CMPlFjnfY5LDS+t5"
Content-Disposition: inline
In-Reply-To: <87sfbjcw0s.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--CMPlFjnfY5LDS+t5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On a Friday in 2023, Markus Armbruster wrote:
>>     { "sandbox", NULL, QEMU_CAPS_SECCOMP_SANDBOX },
>
>Does option -sandbox exist?
>
>It does since v1.2.  If CONFIG_SECCOMP is off, actually using it is a
>fatal error.  Compiling out the option entirely would be more useful, I
>guess.
>
>Is this probe still useful?

I believe so.

libvirt adds '-sandbox on' to all VMs it runs, unless the option is not
available.

Some users wanted to run libvirt with QEMUs without libseccomp,
which resulted in the following QEMU commit.

commit 0dd693ef1f15b6e9c4ba8b0118663e10338077cf
     sandbox: disable -sandbox if CONFIG_SECCOMP undefined

While using this option won't work if CONFIG_SECCOMP is off,
it should not show up in q-c-l-o so libvirt won't even try to use it.


If I'm reading
  commit 90835c2b8127406615785a9d4348ffdf3c813c8a
      seccomp: convert to meson
correctly, then the whole softmmu/qemu-seccomp.c file is only compiled
if seccomp was found.

Jano


--CMPlFjnfY5LDS+t5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQT+Rn5j0qdK2hQgnuAU0rOr/y4PvAUCZHCS2gAKCRAU0rOr/y4P
vGIUAQC5UZW12yclM3FgIyhlNj/rXpgcvEM9Fnq58hVS7f8WbwD+LphojemB1A+o
ENBS6/eg7zlpWV99b5q+vcZhx4UweQk=
=ECuz
-----END PGP SIGNATURE-----

--CMPlFjnfY5LDS+t5--


