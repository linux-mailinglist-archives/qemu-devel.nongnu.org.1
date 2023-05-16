Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C59F7051AD
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 17:08:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pywG7-0001dy-3u; Tue, 16 May 2023 11:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pywG0-0001d6-5H
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pywFy-0002kx-OP
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684249589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ZuK9iiVVg/uCFA85oKnDYSnzsHywZ7y2bdMTaBVy4w=;
 b=GD5dgp2/zLzKZIeHu7twA4BdZePwji1IIhFyAiUDKSG/JQpv5oecDn+Pzg5dem+06hWhqh
 Dx35gj8tMv/0pCcRxDcO++k8OrnSuJdFbHK9s+oWRW9l5gC7yBsIgfOAIJoi7oyhs8AyzO
 8jk3hLdBMFLGSAyFy+l1QdLigVqNgGw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-L0IIi2KeOaeS0zREZZe3ZQ-1; Tue, 16 May 2023 11:06:26 -0400
X-MC-Unique: L0IIi2KeOaeS0zREZZe3ZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08BEB10146E3;
 Tue, 16 May 2023 15:06:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB81640C2063;
 Tue, 16 May 2023 15:06:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE60521E66E3; Tue, 16 May 2023 17:06:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Andrew Melnychenko <andrew@daynix.com>,  jasowang@redhat.com,
 mst@redhat.com,  eblake@redhat.com,  qemu-devel@nongnu.org,
 yuri.benditovich@daynix.com,  yan@daynix.com
Subject: Re: [PATCH v2 5/6] qmp: Added new command to retrieve eBPF blob.
References: <20230512122902.34345-1-andrew@daynix.com>
 <20230512122902.34345-6-andrew@daynix.com>
 <ZGIAUxfLmI6hm3VT@redhat.com> <87zg64u0g7.fsf@pond.sub.org>
 <ZGNE0bk2zCDpUkYS@redhat.com> <87ilcsshgf.fsf@pond.sub.org>
 <ZGNbHcbeN0klbBjU@redhat.com> <87ilcspe2w.fsf@pond.sub.org>
 <ZGOUmRu0/Ckca6J6@redhat.com>
Date: Tue, 16 May 2023 17:06:24 +0200
In-Reply-To: <ZGOUmRu0/Ckca6J6@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 16 May 2023 15:35:05 +0100")
Message-ID: <87lehonwnj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, May 16, 2023 at 04:04:39PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Tue, May 16, 2023 at 12:23:28PM +0200, Markus Armbruster wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >>=20
>> >> > On Tue, May 16, 2023 at 10:47:52AM +0200, Markus Armbruster wrote:
>> >>=20
>> >> [...]
>> >>=20
>> >> >> So, this is basically a way to retrieve an eBPF program by some
>> >> >> well-known name.
>> >> >>=20
>> >> >> Ignorant question: how are these programs desposited?
>> >> >
>> >> > The eBPF code blob is linked into QEMU at build time. THis API lets
>> >> > libvirt fetch it from QEMU, in base64 format. When libvirt later
>> >> > creates NICs, it can attach the eBPF code blob to the TAP device (w=
hich
>> >> > requires elevated privilleges that QEMU lacks). NB, libvirt would f=
etch
>> >> > the eBPF code from QEMU when probing capabilities, as once a VM is
>> >> > running it is untrusted.
>> >>=20
>> >> Okay, I can see how that helps.  I trust the blob is in a read-only
>> >> segment.  Ideally, libvirt fetches it before the guest runs.
>> >
>> > Whether the blob is in a read-only segment or not isn't important,
>> > because it transits writable memory in the QMP command marshalling.
>>=20
>> True.  We could bypass marshalling.  Unclean hack.  Or we could sign the
>> bits cryptograhically.  Key management headaches.  Not worth it, because
>> fetching it before QEMU becomes untrusted is easier.
>>=20
>> However, I now wonder why we fetch it from QEMU.  Why not ship it with
>> QEMU?
>
> Fetching it from QEMU gives us a strong guarantee that the eBPF
> code actually matches the QEMU binary we're talking to, which is
> useful if you're dealing with RPMs which can be upgraded behind
> your back, or have multiple parallel installs of QEMU.

Yes, but what makes this one different from all the other things that
need to match?


