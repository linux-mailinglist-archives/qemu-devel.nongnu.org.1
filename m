Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE7E7DCA8A
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 11:17:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxlmm-0006j6-5Q; Tue, 31 Oct 2023 06:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxlmk-0006if-Cb
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxlmi-0003iS-On
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698747343;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOUNuQzfjx1AV7aKo+BjESsp6YGkF3JNmt0HKNXuG1c=;
 b=WdOYyjXqKSBI0hKItvpaf6eM9Ufw8F3CQKqCAKzcU+ovyHFJUJSIdOvs8EmdNbkS8ti6IL
 o9O1dv8frdbOoQnZ5XPB3x0WhDIGVZgYxarXLHiUZ+qiW0LWCWa/oAlNYvLb5KJao6RSWT
 odAXQbsBWHYEKJq9jwjQVcNHAmGZGwc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-M0WA2Zq5OmaUPYqScab87Q-1; Tue, 31 Oct 2023 06:15:17 -0400
X-MC-Unique: M0WA2Zq5OmaUPYqScab87Q-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507a3ae32b2so6054235e87.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 03:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698747316; x=1699352116;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uOUNuQzfjx1AV7aKo+BjESsp6YGkF3JNmt0HKNXuG1c=;
 b=HmoNMTDvRjjKrvrQc2qXvDYd6PV0Gy9g3scm2Vttqa1bIu8bhCbNnQ7aGW0mcUjQd7
 rop+VQ1M7tzmPFq+Rw+qCnE3Uw1APPaezp5bTt+xIXXxm9QnCR2L00vZFKTDCOmvdscH
 xIuFWqZSBkK19blehrvBMTJj0LMA+lIdAAirvrLIlJI1jqfB35H5JCXoUJ8DUrART9tP
 WeodQH6mRbekl9J0O9pjB3DSJ9lthXAis2HFe0X9tviRK0qwh0LmiE8iuFjtrdJDlrVb
 lkItDk/80BmTuxOTYMXCW6vdnJvVfdaMO8f+YcuMkr3x0eFZ7jp0hKSAhRQkYt+yo6WZ
 CpDg==
X-Gm-Message-State: AOJu0YycRTcU9e0oCnjGgggGRbr/KqSsj5zzCRIa4dL2fyIKKhm5rifo
 pDACukgO2Paxrv9MmV/xUa+CB5r972ZfQ9JqvhfIZEKenb/y99RAdPTU9KCSZiRs+umebFZMSCl
 BIM8ko1GkGdOLB0s=
X-Received: by 2002:ac2:5306:0:b0:507:9d5d:5901 with SMTP id
 c6-20020ac25306000000b005079d5d5901mr8369712lfh.7.1698747315937; 
 Tue, 31 Oct 2023 03:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYeyOzxeQO938UeIjMqPSMnJ6p87Rx3TYvpT+xJZVctflvwpHUued/W7015C43OTS/HKA0Qg==
X-Received: by 2002:ac2:5306:0:b0:507:9d5d:5901 with SMTP id
 c6-20020ac25306000000b005079d5d5901mr8369699lfh.7.1698747315543; 
 Tue, 31 Oct 2023 03:15:15 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 j10-20020a05600c488a00b003fee6e170f9sm1266802wmp.45.2023.10.31.03.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 03:15:14 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org,  Harsh Prateek
 Bora <harshpb@linux.ibm.com>,  qemu-ppc@nongnu.org,  Daniel Henrique
 Barboza <danielhb413@gmail.com>,  Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] ppc: qtest already exports qtest_rtas_call()
In-Reply-To: <ZUBUqpn26N/hc34x@zatzit> (David Gibson's message of "Tue, 31 Oct
 2023 12:13:14 +1100")
References: <20231030163834.4638-1-quintela@redhat.com>
 <6257f025-a000-4f89-88ae-704f51afdb73@kaod.org>
 <ZUBUqpn26N/hc34x@zatzit>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 11:15:14 +0100
Message-ID: <878r7j9jyl.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

David Gibson <david@gibson.dropbear.id.au> wrote:
> On Mon, Oct 30, 2023 at 05:41:36PM +0100, C=C3=A9dric le Goater wrote:
>> On 10/30/23 17:38, Juan Quintela wrote:
>> > Having two functions with the same name is a bad idea.  As spapr only
>> > uses the function locally, made it static.
>> >=20
>> > When you compile with clang, you get this compilation error:
>> >=20
>> > /usr/bin/ld: tests/qtest/libqos/libqos.fa.p/.._libqtest.c.o: in functi=
on `qtest_rtas_call':
>> > /scratch/qemu/clang/full/all/../../../../../mnt/code/qemu/full/tests/q=
test/libqtest.c:1195:
>> > multiple definition of `qtest_rtas_call';
>> > libqemu-ppc64-softmmu.fa.p/hw_ppc_spapr_rtas.c.o:/scratch/qemu/clang/f=
ull/all/../../../../../mnt/code/qemu/full/hw/ppc/spapr_rtas.c:536:
>> > first defined here
>> > clang-16: error: linker command failed with exit code 1 (use -v to see=
 invocation)
>> > ninja: build stopped: subcommand failed.
>> > make: *** [Makefile:162: run-ninja] Error 1
>> >=20
>> > Signed-off-by: Juan Quintela <quintela@redhat.com>
>>=20
>>=20
>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> I think changing the name of one of the functions would be even
> better.  Making it static means it won't confuse the compiler, but it
> can still confuse people.

I think that made it static when it is not used anywhere else is a good
idea.

After that, I don't understand it enough to make a rename that makes
sense.

This patch is the typical fix for "make all" with clang fails here.
I let ppc maintainers to do anything more sensible.

Later, Juan.


