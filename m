Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE007DECBE
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 07:01:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyQkt-0000yS-7l; Thu, 02 Nov 2023 02:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyQkk-0000xr-6c
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 02:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyQkf-0003sM-Ni
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 02:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698904819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1qxDVk5/CFFc0lT9wHQXKfcD3o1Rayu719Yw9CcoEWk=;
 b=UME19SwruRD0JdP4RRqQN+XOdB9CdIsXH61WTF/7hujTPmmc1wRdnu2xWlZP78Cwzokdyj
 ZJR5diuGxy5CM4619STJN1FZnNpwUsRq/cI49X2gjh9ZPA9JpbvqBDOMgdnPDZnvazdSzO
 GJG4w3hRzIoAIrNLqBn9mC1y+TQIjWc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-wLKQVQGlO3iF2BK3aQQ4JQ-1; Thu,
 02 Nov 2023 02:00:17 -0400
X-MC-Unique: wLKQVQGlO3iF2BK3aQQ4JQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B8432806670;
 Thu,  2 Nov 2023 06:00:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41C37492BE0;
 Thu,  2 Nov 2023 06:00:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 48BEF21E6A1F; Thu,  2 Nov 2023 07:00:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: quintela@redhat.com,  qemu-devel@nongnu.org,  philmd@linaro.org,
 thuth@redhat.com,  kkostiuk@redhat.com,  berrange@redhat.com,
 dwmw@amazon.co.uk,  pbonzini@redhat.com,  joe.jin@oracle.com
Subject: Re: [PATCH v3 1/1] hmp: synchronize cpu state for lapic info
References: <20231026211938.162815-1-dongli.zhang@oracle.com>
 <87edhc9inl.fsf@secure.mitica>
 <f0adae79-7c6c-3e52-3bd1-f2e094d4a735@oracle.com>
Date: Thu, 02 Nov 2023 07:00:16 +0100
In-Reply-To: <f0adae79-7c6c-3e52-3bd1-f2e094d4a735@oracle.com> (Dongli Zhang's
 message of "Tue, 31 Oct 2023 15:24:20 -0700")
Message-ID: <871qd8elu7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

Dongli Zhang <dongli.zhang@oracle.com> writes:

> Hi Juan,
>
> On 10/30/23 09:31, Juan Quintela wrote:
>> Dongli Zhang <dongli.zhang@oracle.com> wrote:
>>> While the default "info lapic" always synchronizes cpu state ...
>>>
>>> mon_get_cpu()
>>> -> mon_get_cpu_sync(mon, true)
>>>    -> cpu_synchronize_state(cpu)
>>>       -> ioctl KVM_GET_LAPIC (taking KVM as example)
>>>
>>> ... the cpu state is not synchronized when the apic-id is available as
>>> argument.
>>>
>>> The cpu state should be synchronized when apic-id is available. Otherwi=
se
>>> the "info lapic <apic-id>" always returns stale data.
>>>
>>> Reference:
>>> https://urldefense.com/v3/__https://lore.kernel.org/all/20211028155457.=
967291-19-berrange@redhat.com/__;!!ACWV5N9M2RV99hQ!KOLfuCesLC4T6ka9bjf4x6nc=
C34GPK9pVvWwOJhbwSZw2fwp3Mxlakk0fnR-NCoqRPKOX7X4SOAxozQBC7VQ$=20
>>>
>>> Cc: Joe Jin <joe.jin@oracle.com>
>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
>>=20
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>=20
>> But I wonder how I did get CC'd on this patch O:-)
>>=20
>
> Thank you very much!
>
> This component does not have a maintainer. I just blindly cc all suggested
> reviewers :), in order to get it reviewed and merged.
>
> get_maintainer.pl: No maintainers found, printing recent contributors.
> get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

I posted a fix the other day:

    Subject: [PATCH] MAINTAINERS: Fully cover target/i386/*
    Message-ID: <20231030085336.2681386-1-armbru@redhat.com>
    https://lore.kernel.org/all/20231030085336.2681386-1-armbru@redhat.com/

> Thank you very much!


