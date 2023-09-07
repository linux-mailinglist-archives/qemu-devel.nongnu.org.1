Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC3B797144
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 11:34:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeBON-0001mu-Pc; Thu, 07 Sep 2023 05:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qeBOM-0001lF-2o
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:33:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qeBOG-0005Sc-G4
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694079210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLSOQa/Ulap84AfI6Is+00Xg9foiYY4udij11KdYyG8=;
 b=QyCdpGNh1f7QDsd1elqcxWCXu1OpJHr2F8YnZ+8e3Oz9Zsyvgv/xPq8uOIE+h0UpzJNCVJ
 dnpc4KxBecdGkK1KlZ3g/54/Xvc3LAOjho+3cLwnU9cj77YQNAIKuNGkPQ1Z+CjFerE69j
 GM7Gd3DvlE8d80Gt0LFlKFOlva76a+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-c7ppZvLeMzyLgSd9m7Viow-1; Thu, 07 Sep 2023 05:33:28 -0400
X-MC-Unique: c7ppZvLeMzyLgSd9m7Viow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 357388E3421;
 Thu,  7 Sep 2023 09:33:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0353E2026D76;
 Thu,  7 Sep 2023 09:33:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CD2221E6936; Thu,  7 Sep 2023 11:33:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,  William Tsai
 <williamtsai1111@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 0/1] qom: fix setting of qdev array properties
References: <20230904162544.2388037-1-berrange@redhat.com>
 <ZPbt0io6He9mE2SB@redhat.com>
Date: Thu, 07 Sep 2023 11:33:24 +0200
In-Reply-To: <ZPbt0io6He9mE2SB@redhat.com> (Kevin Wolf's message of "Tue, 5
 Sep 2023 10:58:58 +0200")
Message-ID: <87edja9vkr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 04.09.2023 um 18:25 hat Daniel P. Berrang=C3=A9 geschrieben:
>> By the time of the 8.2.0 release, it will have been 2 years and 6
>> releases since we accidentally broke setting of array properties
>> for user creatable devices:
>>=20
>>   https://gitlab.com/qemu-project/qemu/-/issues/1090
>
> Oh, nice!

Nice?  *Awesome*!

> Well, maybe that sounds a bit wrong, but the syntax that was broken was
> problematic and more of a hack,

A monstrosity, in my opinion.  I tried to strangle it in the crib, but
its guardians wouldn't let me.  Can dig up references for the morbidly
curious.

>                                 and after two years there is clearly no
> need to bring the exact same syntax back now.

Exactly.

> So I'd suggest we bring the funcionality back, but with proper QAPI
> lists instead of len-foo/foo[*].
>
> If we ever want to continue with command line QAPIfication, this change
> would already solve one of the compatibility concerns we've had in the
> past.
>
>> I still think for user creatable devices we'd be better off just
>> mandating the use of JSON syntax for -device and thus leveraging
>> the native JSON array type. This patch was the quick fix for the
>> existing array property syntax though.
>
> I agree, let's not apply this one. It puts another ugly hack in the
> common QOM code path just to bring back the old ugly hack in qdev.

Since -device supports both JSON and dotted keys, we'd still offer a
(differently ugly) solution for users averse to JSON.


