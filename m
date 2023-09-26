Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8177AEE8E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 16:54:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql9Rh-0006UI-Ct; Tue, 26 Sep 2023 10:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql9Rf-0006Tt-Gc
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql9Re-00007u-26
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695740028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S5McVS5y8zaM8j5emX+taVA8EWQeM104dveCTUtYdj0=;
 b=GKeX51CyBCFCDfSSJhOS1YgFTrmKhajfCj6NWOWxZ0yweKKmJ5jadhvicbiCUSLDztjjj/
 fhGy4zRqgwJjm0UnQeEeIlkRThmqL/DCKdrZsU2icFYiEW/aXEgsC4W0KjRZtKolw5vuRu
 FHRm5doRItOnkFHbkmSV5c6r+w6kRYs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-iokyCnMiMyi6EK7PaLqQBw-1; Tue, 26 Sep 2023 10:53:46 -0400
X-MC-Unique: iokyCnMiMyi6EK7PaLqQBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A088E3800A02
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 14:53:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E7EE40C6EA8
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 14:53:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 88A6421E6900; Tue, 26 Sep 2023 16:53:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/i386/seg_helper: remove shadowed variable
References: <20230925144922.529963-1-pbonzini@redhat.com>
 <8734z1qdli.fsf@pond.sub.org>
 <CABgObfbt5ZsbQy2D9wb9Ns+rc_r3+6-Y_oG3O8Pe0+T3XtxBzg@mail.gmail.com>
Date: Tue, 26 Sep 2023 16:53:45 +0200
In-Reply-To: <CABgObfbt5ZsbQy2D9wb9Ns+rc_r3+6-Y_oG3O8Pe0+T3XtxBzg@mail.gmail.com>
 (Paolo Bonzini's message of "Tue, 26 Sep 2023 16:33:55 +0200")
Message-ID: <874jjhnfye.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il mar 26 set 2023, 15:16 Markus Armbruster <armbru@redhat.com> ha scritt=
o:
>
>> I still get these:
>>
>> ../target/i386/tcg/seg_helper.c: In function =E2=80=98switch_tss_ra=E2=
=80=99:
>> ../target/i386/tcg/seg_helper.c:344:22: warning: declaration of =E2=80=
=98ptr=E2=80=99
>> shadows a previous local [-Wshadow=3Dcompatible-local]
>>   344 |         target_ulong ptr;
>>       |                      ^~~
>> ../target/i386/tcg/seg_helper.c:245:18: note: shadowed declaration is he=
re
>>   245 |     target_ulong ptr;
>>       |                  ^~~
>> ../target/i386/tcg/seg_helper.c:345:18: warning: declaration of =E2=80=
=98e2=E2=80=99
>> shadows a parameter [-Wshadow=3Dcompatible-local]
>>   345 |         uint32_t e2;
>>       |                  ^~
>> ../target/i386/tcg/seg_helper.c:235:48: note: shadowed declaration is he=
re
>>   235 |                          uint32_t e1, uint32_t e2, int source,
>>       |                                       ~~~~~~~~~^~
>> ../target/i386/tcg/seg_helper.c:402:22: warning: declaration of =E2=80=
=98ptr=E2=80=99
>> shadows a previous local [-Wshadow=3Dcompatible-local]
>>   402 |         target_ulong ptr;
>>       |                      ^~~
>> ../target/i386/tcg/seg_helper.c:245:18: note: shadowed declaration is he=
re
>>   245 |     target_ulong ptr;
>>       |                  ^~~
>> ../target/i386/tcg/seg_helper.c:403:18: warning: declaration of =E2=80=
=98e2=E2=80=99
>> shadows a parameter [-Wshadow=3Dcompatible-local]
>>   403 |         uint32_t e2;
>>       |                  ^~
>> ../target/i386/tcg/seg_helper.c:235:48: note: shadowed declaration is he=
re
>>   235 |                          uint32_t e1, uint32_t e2, int source,
>>       |                                       ~~~~~~~~~^~
>>
>
> There's another seg_helper patch. 8)

Ah, missed it, because it doesn't have "shadow" in the subject.  Added
to my collection now.  Thanks!


