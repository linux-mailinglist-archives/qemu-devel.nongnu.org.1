Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 671F774157C
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:43:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXIm-0002qM-OV; Wed, 28 Jun 2023 11:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEXIi-0002od-8b
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:41:48 -0400
Received: from bg4.exmail.qq.com ([43.155.67.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEXId-0000Mp-RV
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:41:47 -0400
X-QQ-mid: bizesmtp63t1687966831tzhbrb58
Received: from [192.168.3.2] ( [111.196.130.174])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Jun 2023 23:40:29 +0800 (CST)
X-QQ-SSF: 01200000000000F0G000000A0000000
X-QQ-FEAT: +oIWmpEafD/3klI07IbeaiW9WrTTbzDizGFr+0F8dvduODMTiHv4Pw/I4kcOW
 +z1HawdZhaTA2FdpGwbdmXi7QTw43YRC8SedEvowmHqMlWYqKOO1dcM54cUOcGq7UpKzo6X
 x0/MjSItKjnV0KHnN5JhlamtOnSgTJoIZQ1t+zl6H2eIk9KSXQiyP4NhXnYF2Y4lkElnhpP
 rUB4upH7OEd/QeitxaEmqFv+F4mgqjtBPIxNlEpt27vbq/w71Um7SV6gY7SWo86ZXN8dT7N
 CoaPi1S+B6B6UTS7QPtFJUSgvQa9NgzTO/H0iBiFNedLTg0AsgJGBGfxFTd4XUpkJ3xlcCR
 8X9+1WcHU5/xsisDXDbzXWVlYtO9WsMR8O262AEpzW74CYSCGaGM/G/pe7n/fHNj5SY1/Xr
 2nKfrakgDNA=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6689032385058060457
From: "Bin Meng" <bmeng@tinylab.org>
To: "Markus Armbruster" <armbru@redhat.com>
Subject: Re: [PATCH v3 4/6] util/osdep: Introduce qemu_close_range()
Cc: qemu-devel <qemu-devel@nongnu.org>, falcon <falcon@tinylab.org>, afaria
 <afaria@redhat.com>, kwolf <kwolf@redhat.com>, "marcandre.lureau"
 <marcandre.lureau@redhat.com>, nivanov <nivanov@cloudlinux.com>, pbonzini
 <pbonzini@redhat.com>, thuth <thuth@redhat.com>, "xuzhou.cheng"
 <xuzhou.cheng@windriver.com>
Date: Wed, 28 Jun 2023 15:40:29 +0000
Message-Id: <emcf50c253-7acd-4f5c-b1b4-7d837a81923f@c21cb210.com>
In-Reply-To: <87a5wv24cy.fsf@pond.sub.org>
References: <20230617053621.50359-1-bmeng@tinylab.org>
 <20230617053621.50359-5-bmeng@tinylab.org> <87a5wv24cy.fsf@pond.sub.org>
User-Agent: eM_Client/9.2.1735.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.155.67.158; envelope-from=bmeng@tinylab.org;
 helo=bg4.exmail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL=0.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: Bin Meng <bmeng@tinylab.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 2023/6/19 17:22:53, "Markus Armbruster" <armbru@redhat.com> wrote:

>Bin Meng <bmeng@tinylab.org> writes:
>
>>  This introduces a new QEMU API qemu_close_range() that closes all
>>  open file descriptors from first to last (included).
>>
>>  This API will try a more efficient call to close_range(), or walk
>>  through of /proc/self/fd whenever these are possible, otherwise it
>>  falls back to a plain close loop.
>>
>>  Co-developed-by: Zhangjin Wu <falcon@tinylab.org>
>>  Signed-off-by: Bin Meng <bmeng@tinylab.org>
>>
>>  ---
>>
>>  Changes in v3:
>>  - fix win32 build failure
>>
>>  Changes in v2:
>>  - new patch: "util/osdep: Introduce qemu_close_range()"
>>
>>   include/qemu/osdep.h |  1 +
>>   util/osdep.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 49 insertions(+)
>>
>>  diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>>  index cc61b00ba9..e22434ce10 100644
>>  --- a/include/qemu/osdep.h
>>  +++ b/include/qemu/osdep.h
>>  @@ -560,6 +560,7 @@ int qemu_open_old(const char *name, int flags, ...)=
;
>>   int qemu_open(const char *name, int flags, Error **errp);
>>   int qemu_create(const char *name, int flags, mode_t mode, Error **errp=
);
>>   int qemu_close(int fd);
>>  +int qemu_close_range(unsigned int first, unsigned int last);
>>   int qemu_unlink(const char *name);
>>   #ifndef _WIN32
>>   int qemu_dup_flags(int fd, int flags);
>>  diff --git a/util/osdep.c b/util/osdep.c
>>  index e996c4744a..91275e70f8 100644
>>  --- a/util/osdep.c
>>  +++ b/util/osdep.c
>>  @@ -30,6 +30,7 @@
>>   #include "qemu/mprotect.h"
>>   #include "qemu/hw-version.h"
>>   #include "monitor/monitor.h"
>>  +#include <dirent.h>
>>
>>   static const char *hw_version =3D QEMU_HW_VERSION;
>>
>>  @@ -411,6 +412,53 @@ int qemu_close(int fd)
>>       return close(fd);
>>   }
>>
>>  +int qemu_close_range(unsigned int first, unsigned int last)
>>  +{
>>  +    DIR *dir =3D NULL;
>>  +
>>  +#ifdef CONFIG_CLOSE_RANGE
>>  +    int r =3D close_range(first, last, 0);
>
>close_range(2) explains flag
>
>        CLOSE_RANGE_UNSHARE
>               Unshare  the specified file descriptors from any other proc=
esses
>               before closing them, avoiding races with other  threads  sh=
aring
>               the file descriptor table.
>
>Can anybody explain the races this avoids?

The kernel commit [1] which adds the close_range syscall says:

unshare(CLONE_FILES) should only be needed if the calling
task is multi-threaded and shares the file descriptor table with another
thread in which case two threads could race with one thread allocating=20
file
descriptors and the other one closing them via close_range().

>
>
>>  +    if (!r) {
>>  +        /* Success, no need to try other ways. */
>>  +        return 0;
>>  +    }
>
>What are the failure modes of close_range() where the other ways are
>worth trying?

Added first < last check in v4 so that the technically close_range()=20
should not fail.

>
>
>>  +#endif
>>  +
>>  +#ifdef __linux__
>>  +    dir =3D opendir("/proc/self/fd");
>>  +#endif
>>  +    if (!dir) {
>>  +        /*
>>  +         * If /proc is not mounted or /proc/self/fd is not supported,
>>  +         * try close() from first to last.
>>  +         */
>>  +        for (int i =3D first; i <=3D last; i++) {
>>  +            close(i);
>>  +        }
>>  +
>>  +        return 0;
>>  +    }
>>  +
>>  +#ifndef _WIN32
>>  +    /* Avoid closing the directory */
>>  +    int dfd =3D dirfd(dir);
>
>This directory contains "." "..", "0", "1", ...
>
>>  +
>>  +    for (struct dirent *de =3D readdir(dir); de; de =3D readdir(dir))=
 {
>>  +        int fd =3D atoi(de->d_name);
>
>Maps "." and ".." to 0.  Unclean.
>
>Please use qemu_strtoi(de->d_name, NULL, 10, &fd), and skip entries
>where it fails.

Fixed in v4.

>
>
>>  +        if (fd < first || fd > last) {
>>  +            /* Exclude the fds outside the target range */
>>  +            continue;
>>  +        }
>>  +        if (fd !=3D dfd) {
>>  +            close(fd);
>>  +        }
>>  +    }
>>  +    closedir(dir);
>>  +#endif /* _WIN32 */
>>  +
>>  +    return 0;
>>  +}
>
>I'd prefer to order this from most to least preferred:
>
>     close_range()
>     iterate over /proc/self/fd
>     iterate from first to last
>
>Unlike close_range(), qemu_close_range() returns 0 when last < first.
>If we want to deviate from close_range(), we better document the
>differences.
>
>This is a generalized version of async-teardown.c's close_all_open_fd().
>I'd mention this in the commit message.  Suggestion, not demand.

[1]=20
https://github.com/torvalds/linux/commit/278a5fbaed89dacd04e9d052f4594ffd0e=
0585de

Regards,
Bin

