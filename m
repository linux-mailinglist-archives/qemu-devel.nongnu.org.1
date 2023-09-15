Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E637A2404
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:56:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhC6Y-0005Zx-Bw; Fri, 15 Sep 2023 12:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1qhC6N-0005Nw-Lc
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:55:32 -0400
Received: from forward500b.mail.yandex.net ([178.154.239.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1qhC6I-00078m-K4
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:55:31 -0400
Received: from mail-nwsmtp-mxback-production-main-13.sas.yp-c.yandex.net
 (mail-nwsmtp-mxback-production-main-13.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:f26:0:640:9628:0])
 by forward500b.mail.yandex.net (Yandex) with ESMTP id E0C185EDF8;
 Fri, 15 Sep 2023 19:55:18 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c08:b694:0:640:811:0
 [2a02:6b8:c08:b694:0:640:811:0])
 by mail-nwsmtp-mxback-production-main-13.sas.yp-c.yandex.net (mxback/Yandex)
 with HTTP id FtkurE5W44Y0-CxP1pB2O; Fri, 15 Sep 2023 19:55:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phystech.edu;
 s=mail; t=1694796918;
 bh=vlXBQhLPER25H8j097EjYvswqbRnI4huC2f/Q/ahHr8=;
 h=Message-Id:References:Date:Cc:Subject:In-Reply-To:To:From;
 b=DTWni4KsBih5/GLgH9N6+kRSTiOhvI1emTdsHvSkFUSiHo4OmCtSokUufSIp3HlAC
 xB9H5tMr+xCeODSKKDCrZ4HC551JKrLbDO2Ux8T8hQEOkVPBCay2+JS1jocpceeSLo
 uzPgxaJn5ah4nO5jhrEfS5vZIsSTaMcY5NqOqysI=
Authentication-Results: mail-nwsmtp-mxback-production-main-13.sas.yp-c.yandex.net;
 dkim=pass header.i=@phystech.edu
Received: by 24jwihnks63ygbra.sas.yp-c.yandex.net with HTTP;
 Fri, 15 Sep 2023 19:55:18 +0300
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 Viktor Prutyanov <viktor@daynix.com>, annie.li@oracle.com,
 kkostiuk@redhat.com
In-Reply-To: <ed707975-71bc-4690-a463-2e461dedcba1@daynix.com>
References: <20230913224657.11606-1-viktor@daynix.com>
 <20230913224657.11606-5-viktor@daynix.com>
 <ed707975-71bc-4690-a463-2e461dedcba1@daynix.com>
Subject: Re: [PATCH 4/5] elf2dmp: use Linux mmap with MAP_NORESERVE when
 possible
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 15 Sep 2023 19:55:18 +0300
Message-Id: <7623981694796918@24jwihnks63ygbra.sas.yp-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Received-SPF: pass client-ip=178.154.239.144;
 envelope-from=viktor.prutyanov@phystech.edu; helo=forward500b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 2023/09/14 7:46, Viktor Prutyanov wrote:
> 
>> Glib's g_mapped_file_new maps file with PROT_READ|PROT_WRITE and
>> MAP_PRIVATE. This leads to premature physical memory allocation of dump
>> file size on Linux hosts and may fail. On Linux, mapping the file with
>> MAP_NORESERVE limits the allocation by available memory.
>>
>> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
>> ---
>> contrib/elf2dmp/qemu_elf.c | 66 +++++++++++++++++++++++++++++++-------
>> contrib/elf2dmp/qemu_elf.h | 4 +++
>> 2 files changed, 58 insertions(+), 12 deletions(-)
>>
>> diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
>> index ebda60dcb8..94a8c3ad15 100644
>> --- a/contrib/elf2dmp/qemu_elf.c
>> +++ b/contrib/elf2dmp/qemu_elf.c
>> @@ -165,10 +165,37 @@ static bool check_ehdr(QEMU_Elf *qe)
>> return true;
>> }
>>
>> -int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
>> +static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
>> {
>> +#ifdef CONFIG_LINUX
> 
> Here CONFIG_LINUX is used while qemu_elf.h uses CONFIG_POSIX.

Thank you, the right one is CONFIG_LINUX.

> I also wonder if GLib implementation is really necessary.

GLib implementation is for non-Linux OS. Some of them have mmap,
but don't have MAP_NORESERVE. Some other, such as Windows, don't have
POSIX calls at all.

> 
>> + struct stat st;
>> +
>> + printf("Using Linux's mmap\n");
>> +
>> + qe->fd = open(filename, O_RDONLY, 0);
>> + if (qe->fd == -1) {
>> + eprintf("Failed to open ELF dump file \'%s\'\n", filename);
>> + return 1;
>> + }
>> +
>> + if (fstat(qe->fd, &st)) {
>> + eprintf("Failed to get size of ELF dump file\n");
>> + close(qe->fd);
>> + return 1;
>> + }
>> + qe->size = st.st_size;
>> +
>> + qe->map = mmap(NULL, qe->size, PROT_READ | PROT_WRITE,
>> + MAP_PRIVATE | MAP_NORESERVE, qe->fd, 0);
> 
> It should be possible to close the file immediately after mmap().

