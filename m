Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1207DED17
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:11:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyRq4-0000qu-80; Thu, 02 Nov 2023 03:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyRpy-0000qL-30
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyRpv-0001y3-3g
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698908990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LKRPi0DjgiJz4dHj6mtC+mh5UCrm8Yi++4FQC1LhHHY=;
 b=BNmiAvvXrddpXWcOWyXHdMs+6u+v4dEzLUxe9TMdOmu+I1PhxiAGp/US5sSrx9BSoXbDSO
 +H5XdjDi8Slg1TZX1T7CfWy173l/cyS5f2BLTTXPVQmTET4hK25l7Hq3wEjc+F+zGh25dE
 J0Fs1FJcKCgCSJMI5jipTSdsVt2BRsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-JxA6k7wIN_KlK1f9nqz1Rw-1; Thu, 02 Nov 2023 03:09:45 -0400
X-MC-Unique: JxA6k7wIN_KlK1f9nqz1Rw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2FC180F830;
 Thu,  2 Nov 2023 07:09:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2F942026D4C;
 Thu,  2 Nov 2023 07:09:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6D5C921E6A1F; Thu,  2 Nov 2023 08:09:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>,  QEMU
 Developers <qemu-devel@nongnu.org>,  "open list:Network Block Dev..."
 <qemu-block@nongnu.org>,  BALATON Zoltan <balaton@eik.bme.hu>,  "Daniel P.
 Berrange" <berrange@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: -drive if=none: can't we make this the default?
References: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
 <e3bb64a2-fb72-4e8d-a0b2-89ee35365fb3@tls.msk.ru>
 <ZUFK/BHG2WMhAiWG@redhat.com>
 <CAFEAcA_6nPW2f0+zvtYAg6d7ZJJMLxqFzNOyDY0wLgVFNcoahw@mail.gmail.com>
Date: Thu, 02 Nov 2023 08:09:43 +0100
In-Reply-To: <CAFEAcA_6nPW2f0+zvtYAg6d7ZJJMLxqFzNOyDY0wLgVFNcoahw@mail.gmail.com>
 (Peter Maydell's message of "Wed, 1 Nov 2023 11:21:29 +0000")
Message-ID: <87jzr0d420.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

[...]

> Also, you can't arbitrarily change the command-line compat
> requirements because of how you've chosen to (re-)implement an
> option. That doesn't mean the current syntax is set in stone, but
> I'm pretty sure the command line isn't at the HMP "we can change
> it without deprecation" level of compat promises.

True.

The monitor's clear split between stable (most of QMP) and unstable
(some of QMP, all of HMP) has worked well for us.

CLI could use a similar split.  It's a way off, though.


PS: Let's not rehash the "make QMP the only stable interface" discussion
now.  I doubt anything new could be said.


