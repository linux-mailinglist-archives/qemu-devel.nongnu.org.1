Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E97477F1
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 19:39:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGjyM-0007xO-Ty; Tue, 04 Jul 2023 13:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fweimer@redhat.com>)
 id 1qGjyH-0007vc-0a
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 13:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fweimer@redhat.com>)
 id 1qGjyE-0007Pp-MT
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 13:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688492265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwPTR2hH8hiWHBPRn7zMv3s8S0pQ1futli008kvEN2g=;
 b=Q9a+1Ii4bhifqOTXZ6tVoe/mC+jGAkcamCf2yeXHlLgz0MriQSoQbrrmVoVw06CNm0NEw+
 2b6CIaeg1DvtDm3xayBjKGyebB+mk2UkKn1ZI1VxFYAA/kXxQ90a5J7xwk0Szke1nbkgar
 GHxE6PFuchJBRAaZ7/J5DENrIbvXAyc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-ZL0BjnfpMZyX5WJDMmngSg-1; Tue, 04 Jul 2023 13:37:43 -0400
X-MC-Unique: ZL0BjnfpMZyX5WJDMmngSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C2A21C05EA0;
 Tue,  4 Jul 2023 17:37:43 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FB5A200B415;
 Tue,  4 Jul 2023 17:37:41 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,  laurent@vivier.eu,
 Sajan Karumanchi <sajan.karumanchi@amd.com>
Subject: Re: GLibC AMD CPUID cache reporting regression (was Re: qemu-user
 self emulation broken with default CPU on x86/x64)
References: <c0a35ed3-7e4a-aea6-a3bd-9f0e4079f4e0@linaro.org>
 <ZKM4LV5UboN7PGni@redhat.com>
Date: Tue, 04 Jul 2023 19:37:39 +0200
In-Reply-To: <ZKM4LV5UboN7PGni@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 3 Jul 2023 22:05:49 +0100")
Message-ID: <87v8ez4ly4.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=fweimer@redhat.com;
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

* Daniel P. Berrang=C3=A9:

> On Mon, Jul 03, 2023 at 06:03:08PM +0200, Pierrick Bouvier wrote:
>> Hi everyone,
>>=20
>> Recently (in d135f781 [1], between v7.0.0 and v8.0.0), qemu-user default=
 cpu
>> was updated to "max" instead of qemu32/qemu64.
>>=20
>> This change "broke" qemu self emulation if this new default cpu is used.
>>=20
>> $ ./qemu-x86_64 ./qemu-x86_64 --version
>> qemu-x86_64: ../util/cacheflush.c:212: init_cache_info: Assertion `(isiz=
e &
>> (isize - 1)) =3D=3D 0' failed.
>> qemu: uncaught target signal 6 (Aborted) - core dumped
>> Aborted
>>=20
>> By setting cpu back to qemu64, it works again.
>> $ ./qemu-x86_64 -cpu qemu64 ./qemu-x86_64  --version
>> qemu-x86_64 version 8.0.50 (v8.0.0-2317-ge125b08ed6)
>> Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
>>=20
>> Commenting assert does not work, as qemu aligned malloc fail shortly aft=
er.
>>=20
>> I'm willing to fix it, but I'm not sure what is the issue with "max" cpu
>> exactly. Is it missing CPU cache line, or something else?
>
> I've observed GLibC is issuing CPUID leaf 0x8000_001d
>
> QEMU 'max' CPU model doesn't defnie xlevel, so QEMU makes it default
> to the same as min_xlevel, which is calculated to be 0x8000_000a.
>
> cpu_x86_cpuid() in QEMU sees CPUID leaf 0x8000_001d is above 0x8000_000a,
> and so  considers it an invaild CPUID and thus forces it to report
> 0x0000_000d which is supposedly what an invalid CPUID leaf should do.
>
>
> Net result: glibc is asking for 0x8000_001d, but getting back data
> for 0x0000_000d.
>
> This doesn't end happily for obvious reasons, getting garbage for
> the dcache sizes.
>
>
> The 'qemu64' CPU model also gets CPUID leaf 0x8000_001d capped back
> to 0x0000_000d, but crucially qemu64 lacks the 'xsave' feature bit,
> so QEMU returns all-zeroes for CPUID leaf 0x0000_000d. Still not
> good, but this makes glibc report 0 for DCACHE_*, which in turn
> avoids tripping up the nested qemu which queries DCACHE sysconf.
>
> So the problem is thus more widespread than just 'max' CPU model.
>
> Any QEMU CPU model with vendor=3DAuthenticAMD and the xsave feature,
> and the xlevel unset, will cause glibc to report garbage for the
> L1D cache info
>
> Any QEMU CPU model with vendor=3DAuthenticAMD and without the xsave
> feature, and the xlevel unset, will cause glibc to report zeroes
> for L1D cache info
>
> Neither is good, but the latter at least doesn't trip up the
> nested QEMU when it queries L1D cache info.
>
> I'm unsure if QEMU's behaviour is correct with calculating the
> default 'xlevel' values for 'max', but I'm assuming the xlevel
> was correct for Opteron_G4/5 since those are explicitly set
> in the code for along time.

We are tracking this as:

  New AMD cache size computation logic does not work for some CPUs,
  hypervisors
  <https://sourceware.org/bugzilla/show_bug.cgi?id=3D30428>

I filed it after we resolved the earlier crashes because the data is
clearly not accurate.  I was also able to confirm that impacts more than
just hypervisors.

Sajan posted a first patch:

  [PATCH] x86: Fix for cache computation on AMD legacy cpus.
  <https://sourceware.org/pipermail/libc-alpha/2023-June/148763.html>

However, it changes the reported cache sizes on some older CPUs compared
to what we had before (although the values are no longer zero at least).

Thanks,
Florian


