Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D9D7B2C1C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 07:57:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm6Ua-00031d-Dv; Fri, 29 Sep 2023 01:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm6UV-0002ze-Dv
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm6UT-0007JN-DV
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695967000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wiIE8vdpxXShE267kbclgaAGOh644MOJx97HDq593yw=;
 b=EPYhEdjVj9Ym6PtA7FMFBfGNZ/iAncYRO2pTxukPVIBOMzkP+7iObWOXKGNTzY+7gUTRrA
 StLojBcT5QWRn0Q9I2KsO5LSaqLDJQR8+bMjqMXybOxZ7OMePz4TT9DRgPq1v/gzxs8rA1
 KUDeKxz+N0yNeH3yAFzaMNGH7XyzPsY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-7vGo5wEPPlKEgP2nmR_zHg-1; Fri, 29 Sep 2023 01:56:36 -0400
X-MC-Unique: 7vGo5wEPPlKEgP2nmR_zHg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4E898015AB;
 Fri, 29 Sep 2023 05:56:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14A15492B16;
 Fri, 29 Sep 2023 05:56:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0A0DB21E6904; Fri, 29 Sep 2023 07:56:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,  hreitz@redhat.com,  eblake@redhat.com,
 vsementsov@yandex-team.ru,  jsnow@redhat.com,  idryomov@gmail.com,
 sw@weilnetz.de,  sstabellini@kernel.org,  anthony.perard@citrix.com,
 paul@xen.org,  pbonzini@redhat.com,  marcandre.lureau@redhat.com,
 berrange@redhat.com,  thuth@redhat.com,  philmd@linaro.org,
 stefanha@redhat.com,  fam@euphon.net,  quintela@redhat.com,
 peterx@redhat.com,  leobras@redhat.com,  kraxel@redhat.com,
 qemu-block@nongnu.org,  xen-devel@lists.xenproject.org,
 alex.bennee@linaro.org,  peter.maydell@linaro.org
Subject: Re: [PATCH v3 0/7] Steps towards enabling -Wshadow=local
References: <20230921121312.1301864-1-armbru@redhat.com>
Date: Fri, 29 Sep 2023 07:56:34 +0200
In-Reply-To: <20230921121312.1301864-1-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 21 Sep 2023 14:13:05 +0200")
Message-ID: <87il7tjze5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

Markus Armbruster <armbru@redhat.com> writes:

> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Bugs love to hide in such code.
> Evidence: PATCH 1.
>
> Enabling -Wshadow would prevent bugs like this one.  But we'd have to
> clean up all the offenders first.  We got a lot of them.
>
> Enabling -Wshadow=local should be less work for almost as much gain.
> I took a stab at it.  There's a small, exciting part, and a large,
> boring part.
>
> The exciting part is dark preprocessor sorcery to let us nest macro
> calls without shadowing: PATCH 7.

[...]

Queued.


