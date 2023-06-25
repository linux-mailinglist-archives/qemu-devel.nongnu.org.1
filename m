Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A586373D1AF
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 17:28:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDRdg-0001T0-5L; Sun, 25 Jun 2023 11:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qDRdb-0001Sk-GI
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 11:26:51 -0400
Received: from bg4.exmail.qq.com ([43.154.221.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qDRdU-0007bn-Ta
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 11:26:50 -0400
X-QQ-Spam: true
X-QQ-mid: bizesmtp67t1687706257tolbwf5d
Received: from [192.168.3.2] ( [111.196.130.174])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 25 Jun 2023 23:17:35 +0800 (CST)
X-QQ-SSF: 01200000000000E0G000000A0000000
From: "Bin Meng" <bmeng@tinylab.org>
To: imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v3 3/6] util/async-teardown: Fall back to close fds one by
 one
Cc: qemu-devel <qemu-devel@nongnu.org>, falcon <falcon@tinylab.org>, armbru
 <armbru@redhat.com>, mst <mst@redhat.com>
Date: Sun, 25 Jun 2023 15:17:35 +0000
Message-Id: <em22e77c66-45e8-43dc-b893-fa9acc0f44c7@c21cb210.com>
In-Reply-To: <20230619111823.17960b3a@p-imbrenda>
References: <20230617053621.50359-1-bmeng@tinylab.org>
 <20230617053621.50359-4-bmeng@tinylab.org>
 <20230619111823.17960b3a@p-imbrenda>
User-Agent: eM_Client/9.2.1735.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz6a-0
Received-SPF: pass client-ip=43.154.221.58; envelope-from=bmeng@tinylab.org;
 helo=bg4.exmail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_SBL=0.141,
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

On 2023/6/19 17:18:23, "Claudio Imbrenda" <imbrenda@linux.ibm.com> wrote:

>On Sat, 17 Jun 2023 13:36:18 +0800
>Bin Meng <bmeng@tinylab.org> wrote:
>
>>  When opening /proc/self/fd fails, current codes just return directly,
>>  but we can fall back to close fds one by one.
>>
>>  Signed-off-by: Bin Meng <bmeng@tinylab.org>
>>
>>  ---
>>
>>  (no changes since v2)
>>
>>  Changes in v2:
>>  - new patch: "util/async-teardown: Fall back to close fds one by one"
>>
>>   util/async-teardown.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>>  diff --git a/util/async-teardown.c b/util/async-teardown.c
>>  index 3ab19c8740..7e0177a8da 100644
>>  --- a/util/async-teardown.c
>>  +++ b/util/async-teardown.c
>>  @@ -48,7 +48,11 @@ static void close_all_open_fd(void)
>>
>>       dir =3D opendir("/proc/self/fd");
>>       if (!dir) {
>>  -        /* If /proc is not mounted, there is nothing that can be done. =
*/
>>  +        /* If /proc is not mounted, close fds one by one. */
>>  +        int open_max =3D sysconf(_SC_OPEN_MAX), i;
>>  +        for (i =3D 0; i < open_max; i++) {
>>  +                close(i);
>>  +        }
>>           return;
>>       }
>>       /* Avoid closing the directory. */
>
>a few patches later, you replace the whole close_all_open_fd() with a
>generic version, I don't see a point in changing the code here.

I meant to do a 100% replacement, and this patch added the missing loop.

>
>
>this patch is useless, just drop it

Regards,
Bin

