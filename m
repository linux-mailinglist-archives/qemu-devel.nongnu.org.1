Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDD671F64D
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:59:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4rFp-0001li-Fr; Thu, 01 Jun 2023 18:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4rFk-0001js-5r
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4rFi-0007NH-DR
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685660321;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTn2A712nO6ZR2IY/Eo/WqCvTdVUSQgRpU4AwaRHiGI=;
 b=IZBKGJ9NCjy7mKhzw5FLKxpxMPNaZXM7oflH/D6FCyEds/gmIcdgmr6sN4neKs14ZoFTsf
 jdqdjtlxFI7ZxEJunHbN7yPPsHG7SCKgzHiOB7J9y48u7ggILu2xxed/l/TZV9j0Occ3L+
 xjuoYilqnOW7rh/3+wpbm2KtvKtqXQg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-3dD_W7kuO9e-vU7fcj7wyw-1; Thu, 01 Jun 2023 18:58:39 -0400
X-MC-Unique: 3dD_W7kuO9e-vU7fcj7wyw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3062e5d0cd3so737938f8f.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 15:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685660318; x=1688252318;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YTn2A712nO6ZR2IY/Eo/WqCvTdVUSQgRpU4AwaRHiGI=;
 b=RMB/6o/XcP3h7Zs8uTOlqX07UzhTJcEEX5XRqwSqgdyooAxeHXTFT2PNQemRDrJpJn
 MgIKw/dscVqI6PD2Ov7SWNDYe1713se3dxjF13RDvSZocOmv5AVWkcCF2cP4R4LWaENL
 OutC415p4SjthdvIyKCxUgMBrYHEJ09JRMxn7cQFKaoMkV5i6UYVYo5cPSmUZWCZv4++
 knrssKevTDMVrXVZjzvtT652paZo2rLm9iXAOFTGeF9QIGaqSA/jDUze9mxFFmpJdquW
 HqToXSNSuQYxnBtm1BTRNlF5lmkzRaDb6ii30Tg9VWsJtnRyB9NwYawReeauA+ySDyrL
 RMQg==
X-Gm-Message-State: AC+VfDzzZ22FG9ZhTf0Nx41Hx0jRPR1AvuhRVuOHC6wQxm0o62OANXFd
 O/lcXHUctJdUTX5NpDQ28wCw33xVrI+clEYlFtB/FE2tUjd9KCoBXykfmn7NdNp3L/m2Kdy+AFL
 2Y8P9QsI4jHAxOWP4CfXsRVlWjw==
X-Received: by 2002:adf:ef8d:0:b0:30a:e4f0:40f7 with SMTP id
 d13-20020adfef8d000000b0030ae4f040f7mr3017978wro.2.1685660318423; 
 Thu, 01 Jun 2023 15:58:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7S7muKyyZs1h51rOLJ8bemRl9Dz28WUbpc3t8RZaZwuPK/UCko9pQFvt3lMVPnNfLZPHScSg==
X-Received: by 2002:adf:ef8d:0:b0:30a:e4f0:40f7 with SMTP id
 d13-20020adfef8d000000b0030ae4f040f7mr3017971wro.2.1685660318141; 
 Thu, 01 Jun 2023 15:58:38 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 e16-20020adfe390000000b003048477729asm11577972wrm.81.2023.06.01.15.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 15:58:37 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,  Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 8/9] tests/qtest: make more migration pre-copy
 scenarios run non-live
In-Reply-To: <ZHjEohiecAsu3ht6@x1n> (Peter Xu's message of "Thu, 1 Jun 2023
 12:17:38 -0400")
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-9-berrange@redhat.com> <ZHi5gmd+5pQhDqBF@x1n>
 <ZHi7xLhUp0+5cay7@redhat.com> <ZHi+7bgcHPUisc8d@x1n>
 <ZHi/beg2UqoEnk/b@redhat.com> <ZHjEohiecAsu3ht6@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 02 Jun 2023 00:58:36 +0200
Message-ID: <877csmrdr7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Jun 01, 2023 at 04:55:25PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, Jun 01, 2023 at 11:53:17AM -0400, Peter Xu wrote:
>> > On Thu, Jun 01, 2023 at 04:39:48PM +0100, Daniel P. Berrang=C3=A9 wrot=
e:
>> > > On Thu, Jun 01, 2023 at 11:30:10AM -0400, Peter Xu wrote:
>> > > > Thanks for looking into this.. definitely worthwhile.
>> > > >=20
>> > > > On Wed, May 31, 2023 at 02:23:59PM +0100, Daniel P. Berrang=C3=A9 =
wrote:
>> > > > > There are 27 pre-copy live migration scenarios being tested. In =
all of
>> > > > > these we force non-convergance and run for one iteration, then l=
et it
>> > > > > converge and wait for completion during the second (or following)
>> > > > > iterations. At 3 mbps bandwidth limit the first iteration takes =
a very
>> > > > > long time (~30 seconds).
>> > > > >=20
>> > > > > While it is important to test the migration passes and convergan=
ce
>> > > > > logic, it is overkill to do this for all 27 pre-copy scenarios. =
The
>> > > > > TLS migration scenarios in particular are merely exercising diff=
erent
>> > > > > code paths during connection establishment.
>> > > > >=20
>> > > > > To optimize time taken, switch most of the test scenarios to run
>> > > > > non-live (ie guest CPUs paused) with no bandwidth limits. This g=
ives
>> > > > > a massive speed up for most of the test scenarios.
>> > > > >=20
>> > > > > For test coverage the following scenarios are unchanged
>> > > >=20
>> > > > Curious how are below chosen?  I assume..
>> > >=20
>> > > Chosen based on whether they exercise code paths that are unique
>> > > and interesting during the RAM transfer phase.
>> > >=20
>> > > Essentially the goal is that if we have N% code coverage before this
>> > > patch, then we should still have the same N% code coverage after this
>> > > patch.
>> > >=20
>> > > The TLS tests exercise code paths that are unique during the migrati=
on
>> > > establishment phase. Once establishd they don't exercise anything
>> > > "interesting" during RAM transfer phase. Thus we don't loose code co=
verage
>> > > by runing TLS tests non-live.
>> > >=20
>> > > >=20
>> > > > >=20
>> > > > >  * Precopy with UNIX sockets
>> > > >=20
>> > > > this one verifies dirty log.
>> > > >=20
>> > > > >  * Precopy with UNIX sockets and dirty ring tracking
>> > > >=20
>> > > > ... dirty ring...
>> > > >=20
>> > > > >  * Precopy with XBZRLE
>> > > >=20
>> > > > ... xbzrle I think needs a diff on old/new, makes sense.
>> > > >=20
>> > > > >  * Precopy with UNIX compress
>> > > > >  * Precopy with UNIX compress (nowait)
>> > > > >  * Precopy with multifd
>> > > >=20
>> > > > What about the rest three?  Especially for two compression tests.
>> > >=20
>> > > The compress thread logic is unique/interesting during RAM transfer
>> > > so benefits from running live. The wait vs non-wait scenario tests
>> > > a distinct codepath/logic.
>> >=20
>> > I assume you mean e.g. when compressing with guest page being modified=
 and
>> > we should survive that rather than crashing the compressor?
>>=20
>> No, i mean the compression code has a significant behaviour difference
>> between its two tests, because they toggle:
>>=20
>>  @compress-wait-thread: Controls behavior when all compression
>>      threads are currently busy.  If true (default), wait for a free
>>      compression thread to become available; otherwise, send the page
>>      uncompressed.  (Since 3.1)
>>=20
>> so we need to exercise the code path that falls back to sending
>> uncompressed, as well as the code path that waits for free threads.
>
> But then the question is why live is needed?
>
> IIUC whether the wait thing triggers have nothing directly related to VM =
is
> live or not, but whether all compress thread busy.  IOW, IIUC all compress
> paths will be tested even if non-live as long as we feed enough pages to
> the compressor threads.

It is even wrong.

We didn't fix this for compression:

commit 007e179ef0e97eafda4c9ff2a9d665a1947c7c6d
Author: Ilya Leoshkevich <iii@linux.ibm.com>
Date:   Tue Jul 5 22:35:59 2022 +0200

    multifd: Copy pages before compressing them with zlib
=20=20=20=20
    zlib_send_prepare() compresses pages of a running VM. zlib does not
    make any thread-safety guarantees with respect to changing deflate()
    input concurrently with deflate() [1].


Not that anyone is going to use any accelerator to run zlib when we are
compression just 4k.

Intel AT engine had to also move to 64 pages at a time to make it a
difference.  As said, I can't think of a single scenary where
compression is a good option.

Later, Juan.


