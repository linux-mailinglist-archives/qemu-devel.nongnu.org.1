Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00118755EA4
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 10:39:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLJl8-0000bU-TG; Mon, 17 Jul 2023 04:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fweimer@redhat.com>)
 id 1qLJl1-0000az-T5
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 04:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fweimer@redhat.com>)
 id 1qLJkz-0000dC-Ei
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 04:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689583138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kaXs3M3bwOW5qK4t4esxqK02hzuChm6YuEhSl5P/JTg=;
 b=Kda1HtMSU8zn8wMNrm12Dt0kmP0DrQRDZjUAgMka5BIJbF3ATm+e70VLo/58MDxxwQKWLL
 b9eo3/R1XNwpdwL7s4p5C98StGds3C8JxAwgl6izOHizebUV2CyEKD0lhjnd/pAPqKdNPC
 Ta+Ez1WEohFv6LlFTK/eZ/BOqRZaetA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-paWaAmuIOheGNfLMT-huXw-1; Mon, 17 Jul 2023 04:38:54 -0400
X-MC-Unique: paWaAmuIOheGNfLMT-huXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3103101A54E;
 Mon, 17 Jul 2023 08:38:53 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C775B40C2063;
 Mon, 17 Jul 2023 08:38:52 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: libc-alpha@sourceware.org, qemu-devel@nongnu.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Missing cache information on x86-64 under Intel TDX (glibc bug 30643)
Date: Mon, 17 Jul 2023 10:38:50 +0200
Message-ID: <87mszv7x0l.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=fweimer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This is a continuation of glibc bug 30037, whose root cause was not
fixed:

  Missing cache information on x86-64 under Intel TDX
  <https://sourceware.org/bugzilla/show_bug.cgi?id=3D30643>

  glibc 2.34 and newer segfault if CPUID leaf 0x2 reports zero=20
  <https://sourceware.org/bugzilla/show_bug.cgi?id=3D30037>

Not sure if there is a public mailing list yet where TDX enablement is
discussed.  I'll point a few folks to this thread privately.

The core of the issue is that CPUID.02H comes back as all zero.  Current
glibc uses CPUID.02H as the starting point to determine cache topology,
so we get back all zeros:

# getconf -a | grep CACHE
LEVEL1_ICACHE_SIZE                 0
LEVEL1_ICACHE_ASSOC=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
LEVEL1_ICACHE_LINESIZE             0
LEVEL1_DCACHE_SIZE                 0
LEVEL1_DCACHE_ASSOC                0
LEVEL1_DCACHE_LINESIZE             0
LEVEL2_CACHE_SIZE                  0
LEVEL2_CACHE_ASSOC                 0
LEVEL2_CACHE_LINESIZE              0
LEVEL3_CACHE_SIZE                  0
LEVEL3_CACHE_ASSOC                 0
LEVEL3_CACHE_LINESIZE              0
LEVEL4_CACHE_SIZE                  0
LEVEL4_CACHE_ASSOC=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
LEVEL4_CACHE_LINESIZE=20=20=20=20=20=20=20=20=20=20=20=20=20=20

This will almost certainly cause application hangs and crashes if they
use the cache line sizes to divide up arrays for processing.  Size 0
means that either no progress is made, or a division-by-zero trap
occurs.

(Full =E2=80=9Ccpuid -1 -r=E2=80=9D output below, from an Azure TDX instanc=
e, shared
with permission.)

The current all-00H behavior is arguably not within the description of
the Intel SDM because it lists special FEH and FFH descriptors to
redirect to other CPUID information sources.  (Current glibc only
handles 0FFH redirects, apparently.)  Some applications can get the
cache information using those other means (ignoring CPUID.02H or using
it as fallback only).  Looking at Debian Code Search results, direct
CPUID.02H are somewhat common:

<https://codesearch.debian.net/search?q=3Dcpuid%5Cs*%5C%282%2C&literal=3D0&=
perpkg=3D1>

It looks like a few code snippets were copied around quite a bit.
(You'd need to look at the context, though, to see if these applications
are actually impacted.)

I would prefer if this could be fixed in Intel TDX because it's the only
the way we avoid additional userspace porting of applications, or at
least impact analysis.  But if TDX can't be fixed for some reason, we
need to treat the all-00H as an instruction to glibc to gather the cache
information by some other means.

Thanks,
Florian

# /usr/bin/cpuid -1 -r=20=20
CPU:
   0x00000000 0x00: eax=3D0x00000021 ebx=3D0x756e6547 ecx=3D0x6c65746e edx=
=3D0x49656e69
   0x00000001 0x00: eax=3D0x000806f8 ebx=3D0x00020800 ecx=3D0xfffaba17 edx=
=3D0x1fabfbff
   0x00000002 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000003 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000004 0x00: eax=3D0x00004121 ebx=3D0x02c0003f ecx=3D0x0000003f edx=
=3D0x00000000
   0x00000004 0x01: eax=3D0x00004122 ebx=3D0x01c0003f ecx=3D0x0000003f edx=
=3D0x00000000
   0x00000004 0x02: eax=3D0x00004143 ebx=3D0x03c0003f ecx=3D0x000007ff edx=
=3D0x00000000
   0x00000004 0x03: eax=3D0x00004163 ebx=3D0x0380003f ecx=3D0x0001bfff edx=
=3D0x00000000
   0x00000004 0x04: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000005 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000006 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000007 0x00: eax=3D0x00000001 ebx=3D0xf1bf2ff9 ecx=3D0x1b415fe6 edx=
=3D0xffd14410
   0x00000007 0x01: eax=3D0x00001c30 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000008 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000009 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000a 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000b 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000c 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000d 0x00: eax=3D0x000600e7 ebx=3D0x00002b00 ecx=3D0x00002b00 edx=
=3D0x00000000
   0x0000000d 0x01: eax=3D0x0000001f ebx=3D0x000029c0 ecx=3D0x00001800 edx=
=3D0x00000000
   0x0000000d 0x02: eax=3D0x00000100 ebx=3D0x00000240 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000d 0x05: eax=3D0x00000040 ebx=3D0x00000440 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000d 0x06: eax=3D0x00000200 ebx=3D0x00000480 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000d 0x07: eax=3D0x00000400 ebx=3D0x00000680 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000d 0x0b: eax=3D0x00000010 ebx=3D0x00000000 ecx=3D0x00000001 edx=
=3D0x00000000
   0x0000000d 0x0c: eax=3D0x00000018 ebx=3D0x00000000 ecx=3D0x00000001 edx=
=3D0x00000000
   0x0000000d 0x11: eax=3D0x00000040 ebx=3D0x00000ac0 ecx=3D0x00000002 edx=
=3D0x00000000
   0x0000000d 0x12: eax=3D0x00002000 ebx=3D0x00000b00 ecx=3D0x00000006 edx=
=3D0x00000000
   0x0000000e 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000f 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000010 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000011 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000012 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000012 0x01: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000012 0x02: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000013 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000014 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000015 0x00: eax=3D0x00000001 ebx=3D0x00000054 ecx=3D0x017d7840 edx=
=3D0x00000000
   0x00000016 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000017 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000018 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000019 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000001a 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000001b 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000001b 0x01: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000001c 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000001d 0x00: eax=3D0x00000001 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000001d 0x01: eax=3D0x04002000 ebx=3D0x00080040 ecx=3D0x00000010 edx=
=3D0x00000000
   0x0000001e 0x00: eax=3D0x00000000 ebx=3D0x00004010 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000001f 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000001f 0x01: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000020 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000021 0x00: eax=3D0x00000000 ebx=3D0x65746e49 ecx=3D0x20202020 edx=
=3D0x5844546c
   0x20000000 0x00: eax=3D0x00000000 ebx=3D0x65746e49 ecx=3D0x20202020 edx=
=3D0x5844546c
   0x40000000 0x00: eax=3D0x4000000c ebx=3D0x7263694d ecx=3D0x666f736f edx=
=3D0x76482074
   0x40000001 0x00: eax=3D0x31237648 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x40000002 0x00: eax=3D0x0000585d ebx=3D0x000a0000 ecx=3D0x00000001 edx=
=3D0x00000447
   0x40000003 0x00: eax=3D0x0000ae7f ebx=3D0x00628030 ecx=3D0x00000002 edx=
=3D0xe0be47a2
   0x40000004 0x00: eax=3D0x00360e24 ebx=3D0x00000fff ecx=3D0x00000034 edx=
=3D0x00000000
   0x40000005 0x00: eax=3D0x00000800 ebx=3D0x00000800 ecx=3D0x00009720 edx=
=3D0x00000000
   0x40000006 0x00: eax=3D0x0000000f ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x40000007 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x40000008 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x40000009 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x4000000a 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x4000000b 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x4000000c 0x00: eax=3D0x00000000 ebx=3D0x00000003 ecx=3D0x00000000 edx=
=3D0x00000000
   0x40000100 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80000000 0x00: eax=3D0x80000008 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80000001 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000121 edx=
=3D0x2c100800
   0x80000002 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80000003 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80000004 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80000005 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80000006 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80000007 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80000008 0x00: eax=3D0x00003934 ebx=3D0x00000200 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80860000 0x00: eax=3D0x00000000 ebx=3D0x65746e49 ecx=3D0x20202020 edx=
=3D0x5844546c
   0xc0000000 0x00: eax=3D0x00000000 ebx=3D0x65746e49 ecx=3D0x20202020 edx=
=3D0x5844546c


