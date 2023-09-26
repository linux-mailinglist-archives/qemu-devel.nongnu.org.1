Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 469867AF588
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:49:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEy1-0002zH-Ba; Tue, 26 Sep 2023 16:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlExw-0002we-V2
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlExu-0004Vt-AV
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695761249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCHgxo91Gm/5eklSlJ++46TJ4bwuguiJVLcEeOlbAOA=;
 b=HfDJDYJoRCIicGTKDT4yWJbEcNXDy1AGpPnX6ZanrdB+SYBvhnTef6uaM4rgF0y8XbcWji
 gddCBBn7IF6Yrg/bMeadbImfWWNBTeam/ZsaT8P2hfys/LxtYZM9yW33wEMjEXS742QbjX
 ceuJDEc5XfWNdjuO4WZMFEtWZ/x5vv8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-WUFZ3_RENTmU02KJnYBgcg-1; Tue, 26 Sep 2023 16:47:24 -0400
X-MC-Unique: WUFZ3_RENTmU02KJnYBgcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45E5A28237C7;
 Tue, 26 Sep 2023 20:47:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E2312026D4B;
 Tue, 26 Sep 2023 20:47:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1199421E6900; Tue, 26 Sep 2023 22:47:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Brian Cain <bcain@quicinc.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Richard
 Henderson <richard.henderson@linaro.org>,  Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [v2] Help wanted for enabling -Wshadow=local
References: <87y1gtnggy.fsf@pond.sub.org>
 <CANCZdfoaEuOQkeRsdBYuwer2mU6=J4RQ9Vnt5JWQB=T6-q_eRA@mail.gmail.com>
Date: Tue, 26 Sep 2023 22:47:23 +0200
In-Reply-To: <CANCZdfoaEuOQkeRsdBYuwer2mU6=J4RQ9Vnt5JWQB=T6-q_eRA@mail.gmail.com>
 (Warner Losh's message of "Tue, 26 Sep 2023 09:52:39 -0600")
Message-ID: <875y3wirvo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Warner Losh <imp@bsdimp.com> writes:

> On Tue, Sep 26, 2023 at 8:43=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> Brian, Gerd, Jason, Marc-Andr=C3=A9, Michael, we need your help to enable
>> -Wshadow=3Dlocal.
>>
>> Paolo, you already took care of several subsystems (thanks!), except you
>> left a few warnings in target/i386/tcg/seg_helper.c.
>>
>>
>> Local variables shadowing other local variables or parameters make the
>> code needlessly hard to understand.  Bugs love to hide in such code.
>> Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
>> on polling error".
>>
>> Enabling -Wshadow would prevent bugs like this one.  But we have to
>> clean up all the offenders first.
>>
>> People responded quickly to my first call for help.  Thank you so much!
>>
>> I'm collecting patches in my git repo at
>> https://repo.or.cz/qemu/armbru.git in branch shadow-next, output of
>> git-shortlog appended.  I'm happy to do pull requests.  I don't mind
>> maintainers merging patches for their subsystems; interference should be
>> minimal.
>>
>> My test build is down to 19 files with warnings.  Sorted by subsystems,
>> files covered by multiple subsystems marked "(*NUMBER*)":
>>
>
> Please make sure it's disabled for the bsd-user build. I have 3 patches in
> my queue
> to fix that, but I'm recovering from an illness and trying to land a large
> number of patches
> from my gsoc student Karim and git publish is being a pain. If this can
> wait a week, I'll
> likely be better enough by then and can submit the patches. They are all
> trivial, but one
> depends on the tcg header cleanups.

Waiting a week or two for bsd-user is no problem.  We don't need to
commit all -Wshadow cleanups in one go.

Get well!

[...]


