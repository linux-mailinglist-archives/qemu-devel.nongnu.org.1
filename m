Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F27414D0
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEWzI-0001Oy-9a; Wed, 28 Jun 2023 11:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEWzE-0001OZ-K5
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:21:40 -0400
Received: from bg4.exmail.qq.com ([43.154.221.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEWz8-0002cR-5Z
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:21:40 -0400
X-QQ-mid: bizesmtp81t1687965149t5f4ry1g
Received: from [192.168.3.2] ( [111.196.130.174])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Jun 2023 23:12:26 +0800 (CST)
X-QQ-SSF: 01200000000000E0G000000A0000000
X-QQ-FEAT: ILHsT53NKPipxFslnVcYgK2/lqadPAiTorVQom59NqGMBjNtpVW1W2kPqYJFB
 kMvjOIfcxUVWL4JAd8c0K/EykHdQ+HBdYBrgdlIQSXfurYEaU08MlOlF6Y7c1aqvhuubHn7
 ZROVzlpH4qtJsMKndkjOt8HqSATF6ey0Zjt7aTNV/9Zm9I0YhWGO8r6eBYaNA38AkUR+VZc
 tw6Q5XToqZn6fby8thYqxhILj3vUxeKIyQWyceTLwUutt+g59qHP3S9hVlOFmRvBRyZegZ7
 K1G8nMAzUG6QxOgmJVMPQ61RIpLTYJEv4jsY7CZ/QUos2zHuuXBn+kO5Mbt3V97HdndHylf
 jcTO8V2dOwnGWE7et5WZr5mLbFQpTkU+OLBr6loukTrtGBIztw=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12074265269188029236
From: "Bin Meng" <bmeng@tinylab.org>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v3 4/6] util/osdep: Introduce qemu_close_range()
Cc: qemu-devel <qemu-devel@nongnu.org>, falcon <falcon@tinylab.org>, afaria
 <afaria@redhat.com>, kwolf <kwolf@redhat.com>, "marcandre.lureau"
 <marcandre.lureau@redhat.com>, nivanov <nivanov@cloudlinux.com>, pbonzini
 <pbonzini@redhat.com>, thuth <thuth@redhat.com>, "xuzhou.cheng"
 <xuzhou.cheng@windriver.com>
Date: Wed, 28 Jun 2023 15:12:26 +0000
Message-Id: <emfd702297-2afe-4cd7-a63a-b7acac647dbd@c21cb210.com>
In-Reply-To: <20230619111853.0161ee7b@p-imbrenda>
References: <20230617053621.50359-1-bmeng@tinylab.org>
 <20230617053621.50359-5-bmeng@tinylab.org>
 <20230619111853.0161ee7b@p-imbrenda>
User-Agent: eM_Client/9.2.1735.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.154.221.58; envelope-from=bmeng@tinylab.org;
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

On 2023/6/19 17:18:53, "Claudio Imbrenda" <imbrenda@linux.ibm.com>=20
wrote:

>On Sat, 17 Jun 2023 13:36:19 +0800
>Bin Meng <bmeng@tinylab.org> wrote:
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
>>  +    if (!r) {
>>  +        /* Success, no need to try other ways. */
>>  +        return 0;
>>  +    }
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
>
>will this compile on windows?

Yes, it will.

Regards,
Bin

