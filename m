Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B77AA73D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 05:08:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjWW4-00008F-K6; Thu, 21 Sep 2023 23:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruyang@redhat.com>) id 1qjWVy-00007L-5d
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 23:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruyang@redhat.com>) id 1qjWVw-0002XL-9F
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 23:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695352050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F8H6TjO+Bbw2lg6kY6367tlLHXF7ti8mu8AOnn6bhwk=;
 b=i4FGrnjkoeIH4VDnO87rQ/UDh85N6BarR8KURxUlm/E8m+tiSreMih+Uyjae3a3dXp3lRt
 /pCeyJxHb1Fh4epRagnQ5q/2a9cAf9f5M8KZRB+m6r13EdejUgB3A5/JQeGREFGi6uAMSt
 hvM9Fut4WHZEobzvFzFy0XEbwCsI3uE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-P1wbydkEPbCpXmVL2iiRGQ-1; Thu, 21 Sep 2023 23:06:22 -0400
X-MC-Unique: P1wbydkEPbCpXmVL2iiRGQ-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7927c463e22so24960039f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 20:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695351982; x=1695956782;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F8H6TjO+Bbw2lg6kY6367tlLHXF7ti8mu8AOnn6bhwk=;
 b=ZESI0O/5S4cwOEtaHCepRq/3ypxGVl1pd19biVWjVItxRFGbO528I7N/xrYIimVaF8
 f5tZ3cOCHt2kk5mFa+L8AHb9fmCjMbRSWeiAr6UgLmT1j2svcWIlSg+8mZaX7LEDWpJF
 IIunW9kRNSeX2hvqA3yyU5z8/wSC9ff3n3zep2Svj/9jaqs3fvmcE6k7JtEtNdt/xRex
 bt5YVUxbRVN7BU7/TqWUVtbdZRk4AFou3tAg2NU0R9LixRVu/t9F7x4k6fTo+Owi/8L0
 Tcs3Ep2CeIJNco36oRJ2qRpDq2dQWupzokgdNFnHXVrhf34MRYKA8eO+wGWTtZBoTg6N
 YMfQ==
X-Gm-Message-State: AOJu0YyYKyZADkegCbdAz+/9bIj7tGkWfKqZs5k1QFUkcz4BAzqy6B6V
 p+lEgzkg38/eltLAHj4M5nH8eoU8GEuzXsuMcdDhkQg1p12SUdI1QTHzPAPr/2H/7KNiSvGofDf
 Z8oLHuqM142VL1MeyzMwvK+EMptbjJ3w=
X-Received: by 2002:a92:c147:0:b0:34f:36ae:e8c3 with SMTP id
 b7-20020a92c147000000b0034f36aee8c3mr7526327ilh.1.1695351981832; 
 Thu, 21 Sep 2023 20:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvz1i4sXuMRTWdYmjqhJuAejCUEXw9PjB2rQdl06U40zDY2TiiusgaS1xni/SoxhF+LgPt4+wjjN/X4H+sPjw=
X-Received: by 2002:a92:c147:0:b0:34f:36ae:e8c3 with SMTP id
 b7-20020a92c147000000b0034f36aee8c3mr7526310ilh.1.1695351981523; Thu, 21 Sep
 2023 20:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <87h6nqxdth.fsf@oracle.com> <ZQqj9tFS7cLMTkHv@jondnuc>
 <87edisycgu.fsf@oracle.com> <87bkdwyc3v.fsf@oracle.com>
In-Reply-To: <87bkdwyc3v.fsf@oracle.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 22 Sep 2023 11:06:01 +0800
Message-ID: <CALu+AoTJXtnS8dV-uL_Ov0CEYq1YTX7KTuOSwFdo+1tNB8hqJw@mail.gmail.com>
Subject: Re: Concerns regarding e17bebd049 ("dump: Set correct vaddr for ELF
 dump")
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org, 
 linux-debuggers@vger.kernel.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laszlo Ersek <lersek@redhat.com>, 
 "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>,
 Lianbo Jiang <lijiang@redhat.com>, 
 =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ruyang@redhat.com;
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

Not sure if crash people subscribed to linux-debuggers, let's add more
cc for awareness about this thread.

On Thu, 21 Sept 2023 at 01:45, Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> > Hi Jon,
> >
> > Jon Doron <arilou@gmail.com> writes:
> >> Hi Stephen,
> >> Like you have said the reason is as I wrote in the commit message,
> >> without "fixing" the vaddr GDB is messing up mapping and working with
> >> the generated core file.
> >
> > For the record I totally love this workaround :)
> >
> > It's clever and gets the job done and I would have done it in a
> > heartbeat. It's just that it does end up making vmcores that have
> > incorrect data, which is a pain for debuggers that are actually designed
> > to look at kernel core dumps.
> >
> >> This patch is almost 4 years old, perhaps some changes to GDB has been
> >> introduced to resolve this, I have not checked since then.
> >
> > Program Headers:
> >   Type           Offset             VirtAddr           PhysAddr
> >                  FileSiz            MemSiz              Flags  Align
> >   NOTE           0x0000000000000168 0x0000000000000000 0x0000000000000000
> >                  0x0000000000001980 0x0000000000001980         0x0
> >   LOAD           0x0000000000001ae8 0x0000000000000000 0x0000000000000000
> >                  0x0000000080000000 0x0000000080000000         0x0
> >   LOAD           0x0000000080001ae8 0x0000000000000000 0x00000000fffc0000
> >                  0x0000000000040000 0x0000000000040000         0x0
> >
> > (gdb) info files
> > Local core dump file:
> >         `/home/stepbren/repos/test_code/elf/dumpfile', file type elf64-x86-64.
> >         0x0000000000000000 - 0x0000000080000000 is load1
> >         0x0000000000000000 - 0x0000000000040000 is load2
> >
> > $ gdb --version
> > GNU gdb (GDB) Red Hat Enterprise Linux 10.2-10.0.2.el9
> > Copyright (C) 2021 Free Software Foundation, Inc.
> > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> > This is free software: you are free to change and redistribute it.
> > There is NO WARRANTY, to the extent permitted by law.
> >
> >
> > It doesn't *look like* anything has changed in this version of GDB. But
> > I'm not really certain that GDB is expected to use the physical
> > addresses in the load segments: it's not a kernel debugger.
> >
> > I think hacking the p_vaddr field _is_ the way to get GDB to behave in
> > the way you want: allow you to read physical memory addresses.
> >
> >> As I'm no longer using this feature and have not worked and tested it
> >> in a long while, so I have no obligations to this change, but perhaps
> >> someone else might be using it...
> >
> > I definitely think it's valuable for people to continue being able to
> > use QEMU vmcores generated with paging=off in GDB, even if GDB isn't
> > desgined for it. It seems like a useful hack that appeals to the lowest
> > common denominator: most people have GDB and not a purpose-built kernel
> > debugger. But maybe we could point to a program like the below that will
> > tweak the p_paddr field after the fact, in order to appeal to GDB's
> > sensibilities?
>
> And of course I sent the wrong copy of the file. Attached is the program
> I intended to send (which properly handles endianness and sets the vaddr
> as expected).
>


