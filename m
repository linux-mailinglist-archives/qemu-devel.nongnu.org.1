Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B9578504A
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 08:00:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYguP-0003AL-TE; Wed, 23 Aug 2023 02:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYguM-000374-6n
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYguK-0000Y1-0q
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692770394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMRjCZcsMn4oHCIdLdsGS2R1sBG+QeWOHf3LMBSHfF4=;
 b=R904JsrRQ7JCYeyj2rMZEqX3Ldf+zcJ69CJ+lv+RXCBhHGA9QN7dR5Pkl0Lh/BjtjOxCfy
 1uwYkuFLGITc5Zy1YoiBrz+x0xAfnEQNyQHAvkmsagJlukmbL/O+WkTxxO6gtafAzM6Dqt
 at3+NPJntdAJWCgqKQMfZ87uiYGQk+U=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-ZcsuXqSyMqaPnWCtDXGdwg-1; Wed, 23 Aug 2023 01:59:50 -0400
X-MC-Unique: ZcsuXqSyMqaPnWCtDXGdwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CD4B28EA6FD;
 Wed, 23 Aug 2023 05:59:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D4B240C2073;
 Wed, 23 Aug 2023 05:59:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5710221E690D; Wed, 23 Aug 2023 07:59:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Juan Quintela
 <quintela@redhat.com>
Subject: Re: [RFC PATCH] docs/style: permit inline loop variables
References: <20230822155004.1158931-1-alex.bennee@linaro.org>
 <CAFEAcA8_tqboXDen6OPY-AeZ3BY7p3vYMeG77YQJ=cKA_GRMaQ@mail.gmail.com>
Date: Wed, 23 Aug 2023 07:59:49 +0200
In-Reply-To: <CAFEAcA8_tqboXDen6OPY-AeZ3BY7p3vYMeG77YQJ=cKA_GRMaQ@mail.gmail.com>
 (Peter Maydell's message of "Tue, 22 Aug 2023 16:57:02 +0100")
Message-ID: <87jztmz4bu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 22 Aug 2023 at 16:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> I've already wasted enough of my time debugging aliased variables in
>> deeply nested loops.
>
> In theory we could try to enable -Wshadow and deal with
> all the existing cases of aliasing, which would then
> allow us to turn it into an error and catch your bugs :-)

In practice, a quick compile with -Wshadow -Wno-error=3Dshadow coughs up
almost 6000 warnings.  There are duplicates since we compile many files
multiple times, so I piped through sort -u | wc -l, and got about 1200.

> Anyway, I think declaration-in-for-loop is OK and we
> already have quite a lot of instances of it.

Acked-by: Markus Armbruster <armbru@redhat.com>


