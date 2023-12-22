Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D88AD81CA14
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 13:39:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGemh-00076z-Lx; Fri, 22 Dec 2023 07:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGeme-00074u-Ee
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:37:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGemc-0005S9-NE
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703248661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDpG+ehSig30Pki5bcmw/Shty1UruFD9BRhUTs7TfEo=;
 b=WcFwA6qVZQky/LtN8bx+Ept+HhxhjNTzcNNAWDefSroyJMlolx0SH32+DzNnzJHnd9UdWs
 8mhw4DOlflZBjEtU5EWor1TEqkHNfJ+TRYk6eSlIqynEFbTfe6D0PaR9CVTRWqaovbMV51
 jJy6NU7QGi0Uia2ZEyXn9qY4cssLg54=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-De1n69VoM7iMxDfLa_KiUQ-1; Fri, 22 Dec 2023 07:37:37 -0500
X-MC-Unique: De1n69VoM7iMxDfLa_KiUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E5F91019DF0;
 Fri, 22 Dec 2023 12:37:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B4B8C15A0C;
 Fri, 22 Dec 2023 12:37:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BEB021E6920; Fri, 22 Dec 2023 13:37:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Annie.li" <annie.li@oracle.com>
Cc: qemu-devel@nongnu.org,  imammedo@redhat.com,  miguel.luis@oracle.com
Subject: Re: [RFC PATCH 01/11] acpi: hmp/qmp: Add hmp/qmp support for
 system_sleep
In-Reply-To: <bc3d29ae-48ab-3d85-24e7-89f4f08f9c9f@oracle.com> (Annie li's
 message of "Tue, 5 Dec 2023 16:46:46 -0500")
References: <20231205002143.562-1-annie.li@oracle.com>
 <20231205002356.1239-1-annie.li@oracle.com>
 <87r0k075ij.fsf@pond.sub.org>
 <bc3d29ae-48ab-3d85-24e7-89f4f08f9c9f@oracle.com>
Date: Fri, 22 Dec 2023 13:37:36 +0100
Message-ID: <87h6kah0q7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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

"Annie.li" <annie.li@oracle.com> writes:

> Hi Markus,
>
> On 12/5/2023 3:34 PM, Markus Armbruster wrote:
>> You neglected to cc: QAPI schema maintainers.  I found it by chance.
>> Next time :)
> Yep, should have cc to the maintainers.
>>
>> Annie Li <annie.li@oracle.com> writes:
>>
>>> Following hmp/qmp commands are implemented for pressing virtual
>>> sleep button,
>>>
>>> hmp: system_sleep
>>> qmp: { "execute": "system_sleep" }
>>>
>>> These commands put the guest into suspend or other power states
>>> depending on the power settings inside the guest.
>>
>> How is this related to system_wakeup?
>
> Both 'system_sleep' and 'system_wakeup' trigger the event to notify the
> guest OSPM the sleep button has been pressed. 'system_wakeup' triggers
> wake up notification when the guest is in suspend state.

Thanks.  Would it make sens to work this into the QAPI schema doc
comments somehow?

[...]


