Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D907BB59B
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 12:47:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoiMT-0007mC-2i; Fri, 06 Oct 2023 06:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qoiMC-0007PE-9T; Fri, 06 Oct 2023 06:46:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qoiM6-00010S-RN; Fri, 06 Oct 2023 06:46:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 937BC282E4;
 Fri,  6 Oct 2023 13:46:53 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D244C2D5E0;
 Fri,  6 Oct 2023 13:46:48 +0300 (MSK)
Message-ID: <3a1ea91e-03cf-4350-8f28-ba9fd78b1e30@tls.msk.ru>
Date: Fri, 6 Oct 2023 13:46:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dump: Silence compiler warning in dump code when
 compiling with -Wshadow
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org
References: <20231004131338.215081-1-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231004131338.215081-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

04.10.2023 16:13, Thomas Huth:
> Rename a variable to make this code compilable with -Wshadow.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-By: Michael Tokarev <mjt@tls.msk.ru>

>   dump/dump.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/dump/dump.c b/dump/dump.c
> index d4ef713cd0..d3578ddc62 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1872,20 +1872,20 @@ static void dump_init(DumpState *s, int fd, bool has_format,
>       if (vmci) {
>           uint64_t addr, note_head_size, name_size, desc_size;
>           uint32_t size;
> -        uint16_t format;
> +        uint16_t guest_format;
>   
>           note_head_size = dump_is_64bit(s) ?
>               sizeof(Elf64_Nhdr) : sizeof(Elf32_Nhdr);
>   
> -        format = le16_to_cpu(vmci->vmcoreinfo.guest_format);
> +        guest_format = le16_to_cpu(vmci->vmcoreinfo.guest_format);
>           size = le32_to_cpu(vmci->vmcoreinfo.size);
>           addr = le64_to_cpu(vmci->vmcoreinfo.paddr);
>           if (!vmci->has_vmcoreinfo) {
>               warn_report("guest note is not present");
>           } else if (size < note_head_size || size > MAX_GUEST_NOTE_SIZE) {
>               warn_report("guest note size is invalid: %" PRIu32, size);
> -        } else if (format != FW_CFG_VMCOREINFO_FORMAT_ELF) {
> -            warn_report("guest note format is unsupported: %" PRIu16, format);
> +        } else if (guest_format != FW_CFG_VMCOREINFO_FORMAT_ELF) {
> +            warn_report("guest note format is unsupported: %" PRIu16, guest_format);
>           } else {
>               s->guest_note = g_malloc(size + 1); /* +1 for adding \0 */
>               cpu_physical_memory_read(addr, s->guest_note, size);


