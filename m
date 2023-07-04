Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 774FE746EC6
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 12:34:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGdME-0002Iv-BP; Tue, 04 Jul 2023 06:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGdMD-0002If-2B
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 06:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGdMB-0004ob-Ja
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 06:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688466842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fg5IVy4ZvFqCsfDYAiRcAj/p6G/9geY37bV+jCz3l7s=;
 b=Y/M4tQ2OkwQ5yHstVYieUK5afwRHicoUUdjPleILyeNstubuUB7TLVXh1jx6YxyoJeHtLT
 4ROPldmLR2YrgDIiHdN380PmPj71f9aP5qflYzBtvIbUhs0wMoS34HYEStTWq5MWMsw/Md
 eU/+o7e0Sc8mnnb5/jsZtUI44U9JPmU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-u_4D9skcMdu8bA_sBPaynA-1; Tue, 04 Jul 2023 06:34:01 -0400
X-MC-Unique: u_4D9skcMdu8bA_sBPaynA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-53ba38cf091so5576088a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 03:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688466840; x=1691058840;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fg5IVy4ZvFqCsfDYAiRcAj/p6G/9geY37bV+jCz3l7s=;
 b=CQ3kUKUarzT1QCxuAV1zNhoTlpEW4E1t8EWaBiVxO2g0S8g5enXg8/dZu9vPM1ZkpT
 dXI9NLoyH3jKbhHuRGmaLzsOmod35dpGd6XCpBMbcqQC/or2UK2PbTzbMfW5PDCL9f8T
 n74f+xYIU3cWgYGi/RqXsvtainntEkXIs67YOW83dS5zDBs/uDQpUqXSQa+X9hsmtLpQ
 Nw9lp9LB5JAsdIoRcUGLB1hUg6nFodzq4Dd1rfeXC7Q0+jIHJHcuP3gfqIPvq7qgM4eK
 HF2Wzup9ryTmUXcG6YuR9WImwb8aZBMAkKJYzcKY+VuvpwAiz7RBvnQ+rorgPHocBxCy
 kD2w==
X-Gm-Message-State: ABy/qLZlv/gpHTyq4TxSfcICXD19a0tyMiybrcaT6uQXjjGdeTxi/D08
 WGw2x1zs6D9K8za8bMZEbrMUQaXIbz+8v3bva29VrDD8RVJTsoDPKpKwBRIPzYdauqaZ8ZsohJs
 PqdWzT6BdtJo7Yu4=
X-Received: by 2002:a17:902:c406:b0:1b6:783d:9ba7 with SMTP id
 k6-20020a170902c40600b001b6783d9ba7mr19602044plk.27.1688466840281; 
 Tue, 04 Jul 2023 03:34:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEyZkmkB7AsguthIllVJu+YU5tcChS7Ga2KbzNLMkAyVAhYpwb/NrOllD7wcqQDwH9tV6vtHQ==
X-Received: by 2002:a17:902:c406:b0:1b6:783d:9ba7 with SMTP id
 k6-20020a170902c40600b001b6783d9ba7mr19602021plk.27.1688466839935; 
 Tue, 04 Jul 2023 03:33:59 -0700 (PDT)
Received: from smtpclient.apple ([115.96.131.170])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a170902bd8e00b001aad714400asm16771924pls.229.2023.07.04.03.33.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Jul 2023 03:33:59 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <D23A8D44-FA51-44C7-8AE3-65B10CDB0976@redhat.com>
Date: Tue, 4 Jul 2023 16:03:54 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC9C1732-B33B-4A09-8CB4-6B02F422DD02@redhat.com>
References: <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
 <20230630055717-mutt-send-email-mst@kernel.org>
 <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
 <bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com>
 <DFB3B0B7-1F61-4779-9833-2AF1BA3BDFA6@redhat.com>
 <2ffee496-ec63-ad04-a90b-8c2fadbf3657@daynix.com>
 <20230702005916-mutt-send-email-mst@kernel.org>
 <63B46F8F-A52C-4BFC-BAFD-06ACAF2AA6E1@redhat.com>
 <d6368f95-3adf-9d49-82b4-a138a32010a4@daynix.com>
 <D23A8D44-FA51-44C7-8AE3-65B10CDB0976@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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



> On 04-Jul-2023, at 11:09 AM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 04-Jul-2023, at 10:31 AM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>>=20
>> On 2023/07/03 15:08, Ani Sinha wrote:
>>>> On 02-Jul-2023, at 10:29 AM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>=20
>>>> On Sat, Jul 01, 2023 at 04:09:31PM +0900, Akihiko Odaki wrote:
>>>>> Yes, I want the slot number restriction to be enforced. If it =
worries you
>>>>> too much for regressions, you may implement it as a warning first =
and then
>>>>> turn it a hard error when the next development phase starts.
>>>>=20
>>>> That's not a bad idea.
>>> If we had not enforced the check strongly, the tests that we fixed =
would not get noticed.
>>=20
>> Perhaps so, but we don't have much time before feature freeze. I =
rather want to see the check implemented as warning in 8.1 instead of =
delaying the initial implementation of the check after 8.1 (though I =
worry if it's already too late for 8.1.)
>=20
> The feature hard freeze window starts from 12th of next week. So I am =
still debating whether to keep the hard check or just have a warning. If =
the hard check causes regressions, we can always revert it to a warning =
later.

mst?


