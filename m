Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBF70474A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 10:05:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pypfd-0000cR-D6; Tue, 16 May 2023 04:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pypfZ-0000c4-CQ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pypfW-0007Kf-7o
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684224265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvvST2NQ3cdrD3COrZqu/6ttW6CyqTc4Wlbulp0Q268=;
 b=YKcQNX/F6DH2Ii30IlXo1gRBlf75M1TmDnVlbjW0cW/Z1MMpfhVL4+0Sftp8wTj5curAc2
 f7i/wU85i/yi2G/JHTWzpQNVGNlO2FhnmFnYbPRXA5+zOhSIhDIy7ADu0QGDWKTEzQzWMv
 hRdQJ3Dr9ro+DflsTwXXYGomM2EloVY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-7k9WTerJOS-HIrb49zVCYQ-1; Tue, 16 May 2023 04:04:22 -0400
X-MC-Unique: 7k9WTerJOS-HIrb49zVCYQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C232D185A7A4;
 Tue, 16 May 2023 08:04:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95D6E492B01;
 Tue, 16 May 2023 08:04:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A853A21E681C; Tue, 16 May 2023 10:04:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org,  atar4qemu@gmail.com,  Jakub =?utf-8?B?SmVybcOh?=
 =?utf-8?B?xZk=?= <jakub@jermar.eu>,  qemu-stable@nongnu.org
Subject: Re: [PATCH] Revert "hw/sparc64/niagara: Use blk_name() instead of
 open-coding it"
References: <20230515151104.1350155-1-armbru@redhat.com>
 <3334226e-f96e-5f17-2b67-f29bb9f0256a@ilande.co.uk>
Date: Tue, 16 May 2023 10:04:20 +0200
In-Reply-To: <3334226e-f96e-5f17-2b67-f29bb9f0256a@ilande.co.uk> (Mark
 Cave-Ayland's message of "Tue, 16 May 2023 08:00:29 +0100")
Message-ID: <87ilcsvh17.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 15/05/2023 16:11, Markus Armbruster wrote:
>
>> This reverts commit 1881f336a33a8a99cb17ab1c57ed953682e8e107.
>> This commit breaks "-drive if=3Dpflash,readonly=3Don,file=3Dimage.iso". =
 It
>> claims to merely replace an open-coded version of blk_name() by a
>> call, but that's not the case.  Sorry for the inconvenience!
>
> Ah so was this a case of replacing something that shouldn't have been rep=
laced in the first place, or does it require a follow-up patch?

I was looking at inclusions of block/block_int*.h outside the block
subsystem, and went "Oh, I can get rid of this one!"  Nope, brain
malfunction.

Reducing such inclusions is always nice, but the code this patch
restores isn't broken, and no follow-up fix is required.

>> Reported-by: Jakub Jerm=C3=A1=C5=99 <jakub@jermar.eu>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>

[...]

> Regardless of the above:
>
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Thanks!


