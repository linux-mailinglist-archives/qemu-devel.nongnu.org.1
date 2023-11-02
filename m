Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D18817DED05
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:00:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyRg8-0006nm-K9; Thu, 02 Nov 2023 02:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyRg6-0006nF-9R
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 02:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyRg4-0005NT-TJ
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 02:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698908380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M2UPW+7B1ABDmT70nOcXWh9vaqA2llGi3HlHU2Y+ITE=;
 b=GT26JPnsUKA4t6tqrxj4fm7EAXiwZ37pNSckrpR9gQ3pSq1PsgWh6g9V0EAmHzpv5vehzN
 341lEFXlPr1r6X923hi83rtmbE9u84McDzPIAyQB99gE91nJiPyLrcXWVx6hTVn3upBNod
 +y2swF6QiYvFVc04aou0JGx9v3hkeNs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-NqH7_S6XOamu8W2vdLkcxA-1; Thu,
 02 Nov 2023 02:59:37 -0400
X-MC-Unique: NqH7_S6XOamu8W2vdLkcxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF79E3C28649;
 Thu,  2 Nov 2023 06:59:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F55F40C6EBC;
 Thu,  2 Nov 2023 06:59:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A2E621E6A1F; Thu,  2 Nov 2023 07:59:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Dinah B <dinahbaum123@gmail.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>
Subject: Re: [PATCH v3 1/3] qapi: Moved architecture agnostic data types to
 `machine`
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
 <20230730064057.357598-2-dinahbaum123@gmail.com>
 <87r0omzz78.fsf@pond.sub.org>
 <CAH50XRd_7w1OzLpyBZt-MRL4HMA6_MoKg28qO3h65UU2Dt2uFw@mail.gmail.com>
Date: Thu, 02 Nov 2023 07:59:35 +0100
In-Reply-To: <CAH50XRd_7w1OzLpyBZt-MRL4HMA6_MoKg28qO3h65UU2Dt2uFw@mail.gmail.com>
 (Dinah B.'s message of "Tue, 31 Oct 2023 22:24:13 -0400")
Message-ID: <87o7gcd4iw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

Dinah B <dinahbaum123@gmail.com> writes:

> Hi,
>
> I noticed that qapi now has a machine-common category - do you think these
> changes would be more appropriate in that file
> rather than "machine" for the revision?

You're right.

We created machine-common.json for stuff needed by both machine.json and
machine-target.json.  The alternative was to have machine-target.json
include machine.json instead.  When we discussed which alternative to
pick, I didn't remember your patch adds the include.

Picking both makes no sense.  Please look into adding stuff in a way
that avoids the include.

Thanks for paying attention!

> Thanks and sorry for the delay,

I'm not in a hurry here :)


