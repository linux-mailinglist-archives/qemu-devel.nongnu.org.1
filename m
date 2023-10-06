Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E797BB690
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:39:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qojAU-0006q1-2v; Fri, 06 Oct 2023 07:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qojAL-0006cx-Dl
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qojAJ-0000YK-2Q
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LGcRG6sW4PUvUKXRDEwQ2kbjhkASkPuGrdQBg6kcLE=;
 b=e8ipYQeiSOgtqj0meK98cr4cHRYBY73TZsVOFvCuaUZboMTs86/81qe8n41E6KT1yUACtC
 0i69eLxlSYxiYk3bZpptr0thPVWVDFpbU64nGML1BjPcvpfYnwVLr7aeyrm8pFq9afFmsU
 /P6Jwzr+mg/rSmepPbTGtIY7MG1lsAQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-xnCDnnvZOx-LDSh_hFxBjA-1; Fri, 06 Oct 2023 07:38:28 -0400
X-MC-Unique: xnCDnnvZOx-LDSh_hFxBjA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61267811E8D;
 Fri,  6 Oct 2023 11:38:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FA36492C37;
 Fri,  6 Oct 2023 11:38:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 43ECD21E6904; Fri,  6 Oct 2023 13:38:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org,  qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/virtio/vhost: Silence compiler warnings in vhost
 code when using -Wshadow
References: <20231004114809.105672-1-thuth@redhat.com>
 <18f1faab-71f4-4dbd-a319-fcd65721f58b@tls.msk.ru>
 <87h6n4p1ts.fsf@pond.sub.org>
 <29a2a188-ec5b-452f-be63-92e8f0ec7110@tls.msk.ru>
 <20231006072416-mutt-send-email-mst@kernel.org>
Date: Fri, 06 Oct 2023 13:38:27 +0200
In-Reply-To: <20231006072416-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Fri, 6 Oct 2023 07:24:34 -0400")
Message-ID: <87v8bkj80c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Oct 06, 2023 at 01:45:51PM +0300, Michael Tokarev wrote:
>> 06.10.2023 11:55, Markus Armbruster =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> > Michael Tokarev <mjt@tls.msk.ru> writes:
>> >=20
>> > > Applied to my trivial-patches tree, thanks!
>> > >=20
>> > > Marcus, you picked up previous patches of this theme, --
>> > > you can continue this tradition if you like :)
>> >=20
>> > I intend to post a pull request for the -Wshadow patches that have
>> > R-bys.  I'm also tracking the unreviewed ones, and hope they get
>> > reviewed.
>>=20
>> Ahh, ok.
>>=20
>> I've added my own R-bys for the ones I picked up, and for this one
>> by Thomas too:
>>=20
>> Reviewed-By: Michael Tokarev <mjt@tls.msk.ru>
>>=20
>> /mjt
>
> it would be better to deal with all of them in one place tbh.

I just sent a pull request.  Thanks for all the reviews!


