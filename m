Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7E37D8DD9
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 06:43:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwEfg-0007Xw-7e; Fri, 27 Oct 2023 00:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qwEfe-0007Xo-Gh
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 00:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qwEfc-0008L0-IT
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 00:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698381723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Mc3JYOXFzzWoYPjoJ6iSbttdUBzHcBHwZhF2oY19TU=;
 b=E+MYcgCIjJxKfMR6dUdCe4DR57sey45czcXqPXtI1qPH1k4z7h6tNwjIzJoSq0Fbs3lTIG
 6MDkiWhZ2Zu43MbOJt9/1zVF4p3onI8sANZC/wWMQC07+Hvn0KdAJWtnbhyk2Vmc4URbHZ
 N4sYbicaHFHvKPf8HsBKanQkm8g6Tm8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-USLHiJZ_MLqKLhnrc9x5MA-1; Fri, 27 Oct 2023 00:41:54 -0400
X-MC-Unique: USLHiJZ_MLqKLhnrc9x5MA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1F51811E7B;
 Fri, 27 Oct 2023 04:41:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 756E81C060AE;
 Fri, 27 Oct 2023 04:41:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E81421E6A1F; Fri, 27 Oct 2023 06:41:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,
 marcandre.lureau@redhat.com,  berrange@redhat.com,  thuth@redhat.com,
 philmd@linaro.org,  bcain@quicinc.com,  imp@bsdimp.com, stefanha@redhat.com
Subject: Re: [PATCH 0/1] Enable -Wshadow=local
References: <20231026053115.2066744-1-armbru@redhat.com>
 <CAJSP0QW2uVv1s6JnNFj5HC13vO=yGsGB0wb_mRJvUQXoeCLvQA@mail.gmail.com>
Date: Fri, 27 Oct 2023 06:41:52 +0200
In-Reply-To: <CAJSP0QW2uVv1s6JnNFj5HC13vO=yGsGB0wb_mRJvUQXoeCLvQA@mail.gmail.com>
 (Stefan Hajnoczi's message of "Fri, 27 Oct 2023 09:52:24 +0900")
Message-ID: <878r7o7k33.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Thu, 26 Oct 2023 at 14:32, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Requires Brian's pull request and two patches from Thomas to compile:
>>
>>     [PULL 0/2] hex queue - GETPC() fixes, shadowing fixes
>>     [PATCH v2] block/snapshot: Fix compiler warning with -Wshadow=local
>>     [PATCH v2] migration/ram: Fix compilation with -Wshadow=local
>>
>> Stefan, the PR was posted a week ago; anything blocking it?
>
> It's not in a pull request, so I won't see it. I don't have tooling
> that can spot individual patch series that need to go into
> qemu.git/master, so I rely on being emailed about them.

I'm inquiring about this one:

    https://lore.kernel.org/qemu-devel/20231019021733.2258592-1-bcain@quicinc.com/

Looks like a PR to me.

> Would you like me to merge this patch series into qemu.git/master?

Yes, I'd like you merge Brian's PR I linked to.

[...]


