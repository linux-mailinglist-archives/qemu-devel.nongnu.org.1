Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3002576C6BC
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:26:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR6Eq-0003ie-Ms; Wed, 02 Aug 2023 03:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qR6Eo-0003iS-My
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qR6En-0000b0-4j
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690961139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0/LgnspHXuf9DfEsm4l1QEXL3XcNEvYB9YIHzYDTMg=;
 b=bS76/A1DX38MraJHA6mtZDyWe1+3rdpdz/bHmmbrEg6UlIXoECFMGHTpPDYPnkhqVOsaf3
 hIY9spx0ntvbe45wCDIBUwxnPB1tIR1DlTdgfULPtzvbJY9fQqbSXazK/QyBVX9cjiXLB6
 Shx5k0gLnJpKpWUM7mvjjgm5VObqLEk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-vyAFLd1-M9-OWxrWRp05Tw-1; Wed, 02 Aug 2023 03:25:36 -0400
X-MC-Unique: vyAFLd1-M9-OWxrWRp05Tw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF04D8631DF;
 Wed,  2 Aug 2023 07:25:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D81AF7820;
 Wed,  2 Aug 2023 07:25:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9404921E692A; Wed,  2 Aug 2023 09:25:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH QEMU v3 1/3] qapi: Reformat the dirty-limit migration
 doc comments
References: <169073570563.19893.2928364761104733482-1@git.sr.ht>
 <87mszb0wm4.fsf@pond.sub.org>
 <CAK9dgmYuQKGvUAt=_xYY_a-9Fjo1Je3XS5U=Gw2hTe8hqwUeLA@mail.gmail.com>
Date: Wed, 02 Aug 2023 09:25:33 +0200
In-Reply-To: <CAK9dgmYuQKGvUAt=_xYY_a-9Fjo1Je3XS5U=Gw2hTe8hqwUeLA@mail.gmail.com>
 (Yong Huang's message of "Wed, 2 Aug 2023 08:46:29 +0800")
Message-ID: <87ttthsy6q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Yong Huang <yong.huang@smartx.com> writes:

> On Tue, Aug 1, 2023 at 8:34=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> ~hyman <hyman@git.sr.ht> writes:
>>
>> > From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>> >
>> > Reformat the dirty-limit migration doc comments to conform
>> > to current conventions as commit a937b6aa739 (qapi: Reformat
>> > doc comments to conform to current conventions).
>> >
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> Unexpected S-o-b.  Accident?
>>
> Yes, I'll fix that

With whitespace tidied up:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

[...]


