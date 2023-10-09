Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADE67BDC66
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 14:41:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qppZc-0006RC-8g; Mon, 09 Oct 2023 08:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qppZX-0006Py-9R
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qppZN-00066j-L3
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696855269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBbqRJuie/RtASpOPm/E+liHMmFG9vTLSCLZqZvxUqo=;
 b=QNbrj6iQGGwqfYFtRCJsB8Hno4ZY11dRyknqy0qzmF7QmbqE1yjeA2E8f0xcwi4cG0Gi9+
 BLh+swfrr3KJMnsqn9O9uNkXlTaeaXXX5kBI1sB3w9Z5oqr5GehavRmXGzlJuP5//DawEf
 2Pl5lbQDnp7zhCWOg78MLF4jH0wjr+4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-sbXQx99aPIWxPyB_delydA-1; Mon, 09 Oct 2023 08:41:07 -0400
X-MC-Unique: sbXQx99aPIWxPyB_delydA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 294C83C025D0;
 Mon,  9 Oct 2023 12:41:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 094D7C0FE2D;
 Mon,  9 Oct 2023 12:41:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0D76021E6904; Mon,  9 Oct 2023 14:41:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] system/vl: Use global &bdo_queue in configure_blockdev()
References: <20231009093152.51270-1-philmd@linaro.org>
 <87sf6k2isd.fsf@pond.sub.org>
 <9cd1675b-22a4-ee2a-fde0-bb87c7c5bd26@linaro.org>
Date: Mon, 09 Oct 2023 14:41:06 +0200
In-Reply-To: <9cd1675b-22a4-ee2a-fde0-bb87c7c5bd26@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 9 Oct 2023 13:54:50
 +0200")
Message-ID: <878r8c2ckd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 9/10/23 12:26, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> Commit d11bf9bf0f ("vl: Factor configure_blockdev() out of main()")
>>> passed &bdo_queue as argument, but this isn't really necessary since
>>> there is only one call, so we still use the global variable.
>>>
>>> Dropping the &bdo_queue argument allows to silence this global shadow
>>> warning:
>>>
>>>    softmmu/vl.c:678:54: error: declaration shadows a variable in the gl=
obal scope [-Werror,-Wshadow]
>>>    static void configure_blockdev(BlockdevOptionsQueue *bdo_queue,
>>>                                                         ^
>>>    softmmu/vl.c:172:29: note: previous declaration is here
>>>    static BlockdevOptionsQueue bdo_queue =3D QSIMPLEQ_HEAD_INITIALIZER(=
bdo_queue);
>> Not sure this is an improvement.  Up to Paolo, I guess.
>
> Any alternative suggestion? I'm looking at enabling -Wshadow with Clang
> to avoid Clang users not getting the -Wshadow=3Dlocal warnings until a
> maintainer test their patches on CI.

Rename to @bdos?


