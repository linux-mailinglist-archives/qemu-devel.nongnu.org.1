Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 379867A9249
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:50:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEQy-0001QG-MX; Thu, 21 Sep 2023 03:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qjEQx-0001Ph-95
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qjEQu-0000LZ-Q3
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695282547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I26WjnF2mbRr9OVfOmIItSLn4ttoO6Y5GY7ERATKQWM=;
 b=PoIKcWmEeu0mDuBh1vsZIZ36akga8U/0hYoAS9MtfF4cN2DndgP+6PNXf456IOCKhf/qYI
 WMMP6wWJS6iIs7OF7sHB6WgKfXbBM22uY2vENwb5GnlQ6P/YDwoxEN3gjxQriAHpz9961q
 WzfLx8Rw9rLWn8yCE3k7CYkSpbQbwdQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-3EwaSF8fOu6AZ74JoacRJA-1; Thu, 21 Sep 2023 03:49:03 -0400
X-MC-Unique: 3EwaSF8fOu6AZ74JoacRJA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ADFB101A529;
 Thu, 21 Sep 2023 07:49:03 +0000 (UTC)
Received: from [10.39.192.127] (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED457492C37;
 Thu, 21 Sep 2023 07:49:01 +0000 (UTC)
Message-ID: <994de057-a709-c0db-5063-d44e9b311efd@redhat.com>
Date: Thu, 21 Sep 2023 09:49:00 +0200
MIME-Version: 1.0
Subject: Re: Concerns regarding e17bebd049 ("dump: Set correct vaddr for ELF
 dump")
Content-Language: en-US
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
 Jon Doron <arilou@gmail.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <87h6nqxdth.fsf@oracle.com> <ZQqj9tFS7cLMTkHv@jondnuc>
 <87edisycgu.fsf@oracle.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <87edisycgu.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/20/23 19:35, Stephen Brennan wrote:
> Hi Jon,
> 
> Jon Doron <arilou@gmail.com> writes:
>> Hi Stephen,
>> Like you have said the reason is as I wrote in the commit message, 
>> without "fixing" the vaddr GDB is messing up mapping and working with 
>> the generated core file.
> 
> For the record I totally love this workaround :)
> 
> It's clever and gets the job done and I would have done it in a
> heartbeat. It's just that it does end up making vmcores that have
> incorrect data, which is a pain for debuggers that are actually designed
> to look at kernel core dumps.
> 
>> This patch is almost 4 years old, perhaps some changes to GDB has been 
>> introduced to resolve this, I have not checked since then.
> 
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   NOTE           0x0000000000000168 0x0000000000000000 0x0000000000000000
>                  0x0000000000001980 0x0000000000001980         0x0
>   LOAD           0x0000000000001ae8 0x0000000000000000 0x0000000000000000
>                  0x0000000080000000 0x0000000080000000         0x0
>   LOAD           0x0000000080001ae8 0x0000000000000000 0x00000000fffc0000
>                  0x0000000000040000 0x0000000000040000         0x0
> 
> (gdb) info files
> Local core dump file:
>         `/home/stepbren/repos/test_code/elf/dumpfile', file type elf64-x86-64.
>         0x0000000000000000 - 0x0000000080000000 is load1
>         0x0000000000000000 - 0x0000000000040000 is load2
> 
> $ gdb --version 
> GNU gdb (GDB) Red Hat Enterprise Linux 10.2-10.0.2.el9
> Copyright (C) 2021 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> 
> 
> It doesn't *look like* anything has changed in this version of GDB. But
> I'm not really certain that GDB is expected to use the physical
> addresses in the load segments: it's not a kernel debugger.

The paging=off vmcores dumped by QEMU are primarily meant for the
"crash" utility <https://github.com/crash-utility/crash.git>, not gdb.
Crash builds upon gdb (it downloads a gdb tarball at build time, IIRC),
but either way, the vmcores are meant to be consumed by "crash", and
crash *is* a kernel debugger (both live, and post-mortem).

So, from my perspective: "whatever works with 'crash'". If you revert
Jon's commit and the vmcores continue working with "crash", I won't object.

I commented similarly under Jon's v1 patch -- as long as paging=off
dumps continue working with "crash", I'm fine:

http://mid.mail-archive.com/7961a154-f139-af73-613d-94b88bf95392@redhat.com

For reference, these are the v1 through v3 patch threads, from 2019:

http://mid.mail-archive.com/20181225125344.4482-1-arilou@gmail.com
http://mid.mail-archive.com/20190108130219.18550-1-arilou@gmail.com
http://mid.mail-archive.com/20190109082203.27142-1-arilou@gmail.com

Laszlo


> 
> I think hacking the p_vaddr field _is_ the way to get GDB to behave in
> the way you want: allow you to read physical memory addresses.
> 
>> As I'm no longer using this feature and have not worked and tested it 
>> in a long while, so I have no obligations to this change, but perhaps
>> someone else might be using it...
> 
> I definitely think it's valuable for people to continue being able to
> use QEMU vmcores generated with paging=off in GDB, even if GDB isn't
> desgined for it. It seems like a useful hack that appeals to the lowest
> common denominator: most people have GDB and not a purpose-built kernel
> debugger. But maybe we could point to a program like the below that will
> tweak the p_paddr field after the fact, in order to appeal to GDB's
> sensibilities?
> 
> Thanks,
> Stephen
> 
> ---
> #include <stdbool.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <string.h>
> #include <byteswap.h>
> 
> #include <elf.h>
> 
> static void fail(const char *msg)
> {
> 	fprintf(stderr, "%s\n", msg);
> 	exit(EXIT_FAILURE);
> }
> 
> static void perror_fail(const char *pfx)
> {
> 	perror(pfx);
> 	exit(EXIT_FAILURE);
> }
> 
> static void usage(void)
> {
> 	puts("usage: phys2virt COREFILE");
> 	puts("Modifies the ELF COREFILE so that load segments have their virtual");
> 	puts("address value copied from the physical address field.");
> 	exit(EXIT_SUCCESS);
> }
> 
> static int endian(void)
> {
> 	union {
> 		uint32_t ival;
> 		char     cval[4];
> 	} data;
> 	data.ival = 1;
> 	if (data.cval[0])
> 		return ELFDATA2LSB;
> 	else
> 		return ELFDATA2MSB;
> }
> 
> int main(int argc, char **argv)
> {
> 	char *filename;
> 	FILE *f;
> 	Elf64_Ehdr hdr;
> 	Elf64_Phdr *phdrs;
> 	off_t phoff;
> 	int phnum, phentsize;
> 	bool bswap;
> 
> 	if (argc != 2 || strcmp(argv[1], "-h") == 0)
> 		usage();
> 
> 	filename = argv[1];
> 	f = fopen(filename,  "r+");
> 	if (!f)
> 		perror_fail("open");
> 
> 	if (fread(&hdr, sizeof(hdr), 1, f) != 1)
> 		perror_fail("read elf header");
> 
> 	if (memcmp(hdr.e_ident, ELFMAG, 4) != 0)
> 		fail("not an ELF file");
> 
> 	if (hdr.e_ident[EI_CLASS] != ELFCLASS64)
> 		fail("file is not 64-bits: unsupported");
> 
> 	if (bswap) {
> 		phoff = bswap_64(hdr.e_phoff);
> 		phnum = bswap_16(hdr.e_phnum);
> 		phentsize = bswap_16(hdr.e_phentsize);
> 	} else {
> 		phoff = hdr.e_phoff;
> 		phnum = hdr.e_phnum;
> 		phentsize = hdr.e_phentsize;
> 	}
> 	if (phentsize != sizeof(Elf64_Phdr))
> 		fail("error: mismatch between phentsize and sizeof(Elf64_Phdr)");
> 
> 	if (fseek(f, phoff, SEEK_SET) < 0)
> 		perror_fail("fseek");
> 
> 	phdrs = calloc(phnum, phentsize);
> 	if (!phdrs)
> 		fail("error: allocation error");
> 
> 	if (fread(phdrs, phentsize, phnum, f) != phnum)
> 		perror_fail("fread phdrs");
> 
> 	for (int i = 0; i < phnum; i++)
> 		phdrs[i].p_vaddr = 0; //phdrs[i].p_paddr;
> 
> 	if (fseek(f, phoff, SEEK_SET) < 0)
> 		perror_fail("fseek");
> 	if (fwrite(phdrs, phentsize, phnum, f) != phnum)
> 		perror_fail("fwrite phdrs");
> 
> 	fclose(f);
> 	return EXIT_SUCCESS;
> }
> 


