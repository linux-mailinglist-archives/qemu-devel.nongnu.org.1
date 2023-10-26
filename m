Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F33507D7D0D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 08:51:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvuCs-0005yv-2Q; Thu, 26 Oct 2023 02:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvuCq-0005yQ-Sq
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 02:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvuCo-0000zO-Qr
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 02:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698303057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkVyydPg0WZqRmaySWYd2pk4rRSRkHIeSuGMAE6yW4A=;
 b=WLLGVh4Rdv8Zzg6U9Hn7x7pRPg6kiqBEojKITAL2JU7RMvYHCbwkUSndF3AaeMW7CDCVfp
 PJ+jfERq2Cvc/XWrm0d7HNpQLGJNmfujd2JuQeLXCI01y5IGUEybqU7dTUpmaceodRj2rK
 gEt4gLA0Q40pALyk1IfMBKFZ+6hePxQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-g9OhtRV-Ox2TwjCfX-j2MQ-1; Thu,
 26 Oct 2023 02:50:54 -0400
X-MC-Unique: g9OhtRV-Ox2TwjCfX-j2MQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19A8329ABA10;
 Thu, 26 Oct 2023 06:50:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3F7E2026D4C;
 Thu, 26 Oct 2023 06:50:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DCBE121E6A1F; Thu, 26 Oct 2023 08:50:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,
 pbonzini@redhat.com,  marcandre.lureau@redhat.com,  berrange@redhat.com,
 bcain@quicinc.com,  imp@bsdimp.com,  stefanha@redhat.com,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/1] meson: Enable -Wshadow=local
References: <20231026053115.2066744-1-armbru@redhat.com>
 <20231026053115.2066744-2-armbru@redhat.com>
 <148731e1-7734-6f87-5b7c-e91e0e121880@linaro.org>
 <ad92f0db-7640-492d-a966-4cf883f46308@redhat.com>
 <5f330d44-6e42-3275-8be6-8b06cb40f093@linaro.org>
Date: Thu, 26 Oct 2023 08:50:52 +0200
In-Reply-To: <5f330d44-6e42-3275-8be6-8b06cb40f093@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 26 Oct 2023 08:17:55
 +0200")
Message-ID: <87a5s5dghf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

> On 26/10/23 08:12, Thomas Huth wrote:
>> On 26/10/2023 07.58, Philippe Mathieu-Daud=C3=A9 wrote:

[...]

>>> $ ../configure
>>> The Meson build system
>>> Version: 1.2.1
>>> Build type: native build
>>> Project name: qemu
>>> Project version: 8.1.50
>>> C compiler for the host machine: cc (clang 15.0.0 "Apple clang version =
15.0.0 (clang-1500.0.40.1)")
>>> C linker for the host machine: cc ld64 1015.7
>>> Host machine cpu family: aarch64
>>> Host machine cpu: aarch64
>>> Program sh found: YES (/bin/sh)
>>> Objective-C compiler for the host machine: clang (clang 15.0.0)
>>> Objective-C linker for the host machine: clang ld64 1015.7
>
>
>>> Compiler for Objective-C supports arguments -Wshadow=3Dlocal: NO
>>>
>>> So:
>>>
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks!

>>> Now don't blame me for posting patches with trigger shadow=3Dlocal
>>> warnings because I am not testing that locally.
>>>
>>> I find it a bit unfair to force me rely on CI or other machines
>>> rather than my host machine to check for warnings. I'd have
>>> rather waited this option support lands first in Clang before
>>> enabling this flag.

I'm not forcing anyone just yet, I'm merely posting a patch to solicit
feedback :)

PRO: It stops the backsliding.  Thomas had to fix two new instances
already.

CON: Developers using only Clang may post patches that fail CI.  We
don't know how annoying that will be in practice.

>> Huh, that situation is already pre-existing, e.g. with -Wimplicit-fallth=
rough=3D2 ... and if you're too afraid, you can always install gcc via home=
brew to check.
>
> OK, fine.

I suggest to take the patch now, and if the CON turns out to outweigh
the PRO, revert it.


