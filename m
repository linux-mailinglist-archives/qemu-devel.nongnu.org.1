Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E3871264F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 14:11:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2WHp-0004yp-SA; Fri, 26 May 2023 08:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2WHj-0004yh-9e
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2WHe-0005T3-Hp
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685103061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7qtyz0CgvoI2rSk0juAWqzYL6zZJNiqyTVFULuG4YAY=;
 b=An0ARr3QRBvQHjkUU8tdKrFGmEcZ16pUnLz9gZiY3FSmauy2VPuVRRATZdSPcpYge7WyGF
 yD0igb1Ltg0EvsbRrRXL9BcHN5R7FIVPiiTPabqUuSpz6VzV9ULouLzCKdEwuoQzcqycqZ
 J3pYyzLW4BdC/SBlMWAlfi7nTzcUy2M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-BnzRzTpcP7ORIn9rRoo6-w-1; Fri, 26 May 2023 08:10:59 -0400
X-MC-Unique: BnzRzTpcP7ORIn9rRoo6-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90804811E8D
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 12:10:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 708F5C154D2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 12:10:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E35D21E692E; Fri, 26 May 2023 14:10:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>,  libvir-list@redhat.com,  Andrea
 Bolognani <abologna@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: query-command-line-options
References: <cover.1677511354.git.pkrempa@redhat.com>
 <8718b22eda052662087087b4ce659b054974c9e0.1677511354.git.pkrempa@redhat.com>
 <CABJz62PHsQHiyo06PtfcDeS1LddYyDw2pC_seObtZcLR5cPQyQ@mail.gmail.com>
 <Y/zng8+7s05O0tRd@angien.pipo.sk>
 <CABJz62OMWXAx_ExYqvvg1DvcHkiP+SkwNMQZ+56QwoHpsNBqGA@mail.gmail.com>
 <87jzzsc320.fsf_-_@pond.sub.org> <ZAdKHkUIKjPLhFn7@angien.pipo.sk>
 <87sfbjcw0s.fsf@pond.sub.org> <ZHCS3vXnyE9ouEf3@fedora>
Date: Fri, 26 May 2023 14:10:58 +0200
In-Reply-To: <ZHCS3vXnyE9ouEf3@fedora> (=?utf-8?Q?=22J=C3=A1n?= Tomko"'s
 message of "Fri, 26 May 2023 13:07:10 +0200")
Message-ID: <875y8fb8dp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

J=C3=A1n Tomko <jtomko@redhat.com> writes:

> On a Friday in 2023, Markus Armbruster wrote:
>>>     { "sandbox", NULL, QEMU_CAPS_SECCOMP_SANDBOX },
>>
>>Does option -sandbox exist?
>>
>>It does since v1.2.  If CONFIG_SECCOMP is off, actually using it is a
>>fatal error.  Compiling out the option entirely would be more useful, I
>>guess.
>>
>>Is this probe still useful?
>
> I believe so.
>
> libvirt adds '-sandbox on' to all VMs it runs, unless the option is not
> available.
>
> Some users wanted to run libvirt with QEMUs without libseccomp,
> which resulted in the following QEMU commit.
>
> commit 0dd693ef1f15b6e9c4ba8b0118663e10338077cf
>     sandbox: disable -sandbox if CONFIG_SECCOMP undefined
>
> While using this option won't work if CONFIG_SECCOMP is off,
> it should not show up in q-c-l-o so libvirt won't even try to use it.

You're right: the option exists regardless of CONFIG_SECCOMP, but it
shows up in q-c-l-o only when CONFIG_SECCOMP is on.

> If I'm reading
>  commit 90835c2b8127406615785a9d4348ffdf3c813c8a
>      seccomp: convert to meson
> correctly, then the whole softmmu/qemu-seccomp.c file is only compiled
> if seccomp was found.
>
> Jano


