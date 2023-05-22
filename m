Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1612670BA66
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 12:51:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1386-0001vh-0K; Mon, 22 May 2023 06:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q1382-0001vN-8D
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q137z-0002g5-Ox
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684752658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsRPVZDfLl82brKxyoZYlWsHyLg7oHjz9b2xGuLMHdo=;
 b=izIjDig/GqA8NwUOt2yKibWnj/er4CffTaYhclSst14P2buVfGuu2HVTSAeYVR/7+Ydb4/
 dU6mFJ8aUjcxX88uWDTK4w3GjimZkx7pal2uZ7R32Y7vJrZz+Kfdb4XO4cOsx5cz7U6pf9
 sPjWBzZEikUVND053785xqeFNMBbdvA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-rX41fMwnMZmjvEen_lfMxA-1; Mon, 22 May 2023 06:50:56 -0400
X-MC-Unique: rX41fMwnMZmjvEen_lfMxA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73BCC1C05EAA;
 Mon, 22 May 2023 10:50:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53425492B0B;
 Mon, 22 May 2023 10:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3072E21E692E; Mon, 22 May 2023 12:50:55 +0200 (CEST)
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
 <ZGOUmRu0/Ckca6J6@redhat.com> <87lehonwnj.fsf@pond.sub.org>
 <ZGOe2i1ia1qdMuJm@redhat.com>
Date: Mon, 22 May 2023 12:50:55 +0200
In-Reply-To: <ZGOe2i1ia1qdMuJm@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 16 May 2023 16:18:50 +0100")
Message-ID: <87v8gkljw0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Tue, May 16, 2023 at 05:06:24PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Tue, May 16, 2023 at 04:04:39PM +0200, Markus Armbruster wrote:

[...]

>> >> However, I now wonder why we fetch it from QEMU.  Why not ship it with
>> >> QEMU?
>> >
>> > Fetching it from QEMU gives us a strong guarantee that the eBPF
>> > code actually matches the QEMU binary we're talking to, which is
>> > useful if you're dealing with RPMs which can be upgraded behind
>> > your back, or have multiple parallel installs of QEMU.
>>=20
>> Yes, but what makes this one different from all the other things that
>> need to match?
>
> Many of the external resources QEMU uses don't need to be a precise
> match to a QEMU version, it is sufficient for them to be of "version
> X or newer".  eBPF programs need to be a precise match, because the
> QEMU code has assumptions about the eBPF code it uses, such as the
> configuration maps present.
>
> There is another example where a perfect match is needed - loadable
> .so modules. eg if you're running QEMU and trigger dlopen of a QEMU
> module, the loaded module needs to come from the perfect matching
> build. Most distros don't solve that, but there was something added
> a while back that let QEMU load modules from a specific location.
>
> The idea was that the RPM/Deb package manager can upgrade the
> modules, but the modules from the previously installed QEMU would be
> kept in somewhere temporary like /var/run/...., so that pre-existing
> running QEMU could still load the exact matched .sos. While that hack
> kinda works it has too many moving parts for my liking, leaving failure
> scenarios open. IMHO, being able to directly fetch the resource=20
> directly from QEMU is a better strategy for eBPF programs, as it
> eliminates more of the failure scenarios with very little effort.

On the other hand, yet another way to solve the same class of problem.

If we decide that's what we want, the rationale needs to be worked into
the commit message.


