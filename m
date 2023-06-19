Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D90734FD8
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 11:24:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBB7M-00072z-0G; Mon, 19 Jun 2023 05:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qBB7J-00071g-AS
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:24:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qBB7H-0003HE-Do
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:24:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35J9FmtQ022907; Mon, 19 Jun 2023 09:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=xg5UMKatpSs+anSARnUhN+GgCOHk3aRqv4ZAX+TdK4k=;
 b=UIfJj5BrIU4gIX4/t9ceejBEQcWxR+ZeS1RcGgYeFwUA4luL4i8Z8Me+sgFq6eqC0HhU
 ucajaqJu4dcimMrd8hSctlQo0Hrhyz4zd2g89ivZgrictRHgtlUVpFSIidnx6sgUegPX
 lIfQ4lJbmnIhrnevfb3zwbSCcMyrlyEOS5mqCO4t2BrgRQj0GXNxzKzhsa5d0VcMykJa
 lKjWqbo1jE0ONn+n0C3o5MmEgWp9202vpqAcU0MyqKovGUbJhQ5Uy9TYo7Z26yrfCtHR
 obVabTiXEbrf/XyYLdDdvgXpiJ6saytAXr5eKjeQdXHyO7jIgfOa3go4hS0Y7iFc53nJ 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rakvxgpg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jun 2023 09:24:05 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35J9Mu56019212;
 Mon, 19 Jun 2023 09:24:05 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rakvxgpeq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jun 2023 09:24:05 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35J6phZc008679;
 Mon, 19 Jun 2023 09:24:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3r943e0y6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jun 2023 09:24:01 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35J9NwvM42992146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jun 2023 09:23:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E65E20040;
 Mon, 19 Jun 2023 09:23:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F83A2004B;
 Mon, 19 Jun 2023 09:23:58 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Jun 2023 09:23:58 +0000 (GMT)
Date: Mon, 19 Jun 2023 11:18:53 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Bin Meng <bmeng@tinylab.org>
Cc: qemu-devel@nongnu.org, Zhangjin Wu <falcon@tinylab.org>, Alberto Faria
 <afaria@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?TWFyYy1B?=
 =?UTF-8?B?bmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Nikita Ivanov
 <nivanov@cloudlinux.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Xuzhou Cheng <xuzhou.cheng@windriver.com>
Subject: Re: [PATCH v3 4/6] util/osdep: Introduce qemu_close_range()
Message-ID: <20230619111853.0161ee7b@p-imbrenda>
In-Reply-To: <20230617053621.50359-5-bmeng@tinylab.org>
References: <20230617053621.50359-1-bmeng@tinylab.org>
 <20230617053621.50359-5-bmeng@tinylab.org>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _7j2wY0ifg95D49gUJGaC7aSPXvoY_8s
X-Proofpoint-ORIG-GUID: 3MtyaFFnHTMglDBN0Bftiv3bgMV1H32y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=922
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190081
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, 17 Jun 2023 13:36:19 +0800
Bin Meng <bmeng@tinylab.org> wrote:

> This introduces a new QEMU API qemu_close_range() that closes all
> open file descriptors from first to last (included).
> 
> This API will try a more efficient call to close_range(), or walk
> through of /proc/self/fd whenever these are possible, otherwise it
> falls back to a plain close loop.
> 
> Co-developed-by: Zhangjin Wu <falcon@tinylab.org>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> 
> ---
> 
> Changes in v3:
> - fix win32 build failure
> 
> Changes in v2:
> - new patch: "util/osdep: Introduce qemu_close_range()"
> 
>  include/qemu/osdep.h |  1 +
>  util/osdep.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index cc61b00ba9..e22434ce10 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -560,6 +560,7 @@ int qemu_open_old(const char *name, int flags, ...);
>  int qemu_open(const char *name, int flags, Error **errp);
>  int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
>  int qemu_close(int fd);
> +int qemu_close_range(unsigned int first, unsigned int last);
>  int qemu_unlink(const char *name);
>  #ifndef _WIN32
>  int qemu_dup_flags(int fd, int flags);
> diff --git a/util/osdep.c b/util/osdep.c
> index e996c4744a..91275e70f8 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -30,6 +30,7 @@
>  #include "qemu/mprotect.h"
>  #include "qemu/hw-version.h"
>  #include "monitor/monitor.h"
> +#include <dirent.h>
>  
>  static const char *hw_version = QEMU_HW_VERSION;
>  
> @@ -411,6 +412,53 @@ int qemu_close(int fd)
>      return close(fd);
>  }
>  
> +int qemu_close_range(unsigned int first, unsigned int last)
> +{
> +    DIR *dir = NULL;
> +
> +#ifdef CONFIG_CLOSE_RANGE
> +    int r = close_range(first, last, 0);
> +    if (!r) {
> +        /* Success, no need to try other ways. */
> +        return 0;
> +    }
> +#endif
> +
> +#ifdef __linux__
> +    dir = opendir("/proc/self/fd");
> +#endif
> +    if (!dir) {
> +        /*
> +         * If /proc is not mounted or /proc/self/fd is not supported,
> +         * try close() from first to last.
> +         */
> +        for (int i = first; i <= last; i++) {
> +            close(i);

will this compile on windows?

> +        }
> +
> +        return 0;
> +    }
> +
> +#ifndef _WIN32
> +    /* Avoid closing the directory */
> +    int dfd = dirfd(dir);
> +
> +    for (struct dirent *de = readdir(dir); de; de = readdir(dir)) {
> +        int fd = atoi(de->d_name);
> +        if (fd < first || fd > last) {
> +            /* Exclude the fds outside the target range */
> +            continue;
> +        }
> +        if (fd != dfd) {
> +            close(fd);
> +        }
> +    }
> +    closedir(dir);
> +#endif /* _WIN32 */
> +
> +    return 0;
> +}
> +
>  /*
>   * Delete a file from the filesystem, unless the filename is /dev/fdset/...
>   *


