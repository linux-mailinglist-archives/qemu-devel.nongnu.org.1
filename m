Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FB8743E9F
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 17:21:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFFw7-0005r5-1a; Fri, 30 Jun 2023 11:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qFFw0-0005nU-25
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:21:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qFFvx-0006IJ-N7
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:21:19 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UFH9LA020930
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 15:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=d3loUdWREi3zcILsGjItQg1cfqSvOKpQy+fVS66pVMU=;
 b=kNK4dHqPItCU18MNyCED2ojjaw5X9wxw5ZgqAd2g1FzSXIHN007ABOpbH0kcX/Ve8cGA
 fcGM2sdm4b4EXp0MPUVSY4mDsjBFdTkdpbxzexKiQE2ddVaVH1tSoj2eOT9TqrHI4jmB
 IyZdTlf0ppEN2lPgKLQKV2ILjeDOjjhVgcMaAJPxEqFmVVrp5XEtX/bDo7cBE2l92wAO
 NaZu95P+nKWu5CQwc21/jWxULffug0qv336msSi5ncBRpegwOI9qLreUw/4H8O3goJ3N
 +4VwSpiNHdz+3OpfU3dhexoZuKtU2y3GKueQ2NoU3LThBh03lzLaUYpklSwYhlsSRGXY 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj1j802t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 15:21:14 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UFJEp2029067
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 15:21:14 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj1j802qp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 15:21:14 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35UCMcWq012730;
 Fri, 30 Jun 2023 15:21:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rdr453458-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 15:21:10 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UFL7Sd3277442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 15:21:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE19920043;
 Fri, 30 Jun 2023 15:21:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71DFB20040;
 Fri, 30 Jun 2023 15:21:07 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 15:21:07 +0000 (GMT)
Date: Fri, 30 Jun 2023 17:18:41 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] os-posix: Allow 'chroot' via '-run-with' and deprecate
 the old '-chroot' option
Message-ID: <20230630171841.2deb7591@p-imbrenda>
In-Reply-To: <20230630150112.435874-1-thuth@redhat.com>
References: <20230630150112.435874-1-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NOKx-ocVRlZRucy-3ACB-AFSq8Yw7BXP
X-Proofpoint-GUID: _6ZqNHZ6QDTbTWtO836BKaX54TcsnxJ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300127
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 30 Jun 2023 17:01:12 +0200
Thomas Huth <thuth@redhat.com> wrote:

> We recently introduced "-run-with" for options that influence the
> runtime behavior of QEMU. This option has the big advantage that it
> can group related options (so that it is easier for the users to spot
> them) and that the options become introspectable via QMP this way.
> So let's start moving more switches into this option group, starting
> with "-chroot" now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  docs/about/deprecated.rst |  5 +++++
>  os-posix.c                | 35 ++++++++++++++++++++++++++++++++++-
>  util/async-teardown.c     | 21 ---------------------
>  qemu-options.hx           | 18 +++++++++++++-----
>  4 files changed, 52 insertions(+), 27 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0743459862..1cf53b86ce 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -116,6 +116,11 @@ Use "whpx" (on Windows) or "hvf" (on macOS) instead.
>  
>  Use ``-run-with async-teardown=on`` instead.
>  
> +``-chroot`` (since 8.1)
> +'''''''''''''''''''''''
> +
> +Use ``-run-with chroot=dir`` instead.
> +
>  ``-singlestep`` (since 8.1)
>  '''''''''''''''''''''''''''
>  
> diff --git a/os-posix.c b/os-posix.c
> index 90ea71725f..0ae1fb2347 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -38,6 +38,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/config-file.h"
>  #include "qemu/option.h"
> +#include "qemu/module.h"
>  
>  #ifdef CONFIG_LINUX
>  #include <sys/prctl.h>
> @@ -148,6 +149,7 @@ int os_parse_cmd_args(int index, const char *optarg)
>          }
>          break;
>      case QEMU_OPTION_chroot:
> +        warn_report("option is deprecated, use '-run-with chroot=...' instead");
>          chroot_dir = optarg;
>          break;
>      case QEMU_OPTION_daemonize:
> @@ -158,18 +160,25 @@ int os_parse_cmd_args(int index, const char *optarg)
>      case QEMU_OPTION_asyncteardown:
>          init_async_teardown();
>          break;
> +#endif
>      case QEMU_OPTION_run_with: {
> +        const char *str;
>          QemuOpts *opts = qemu_opts_parse_noisily(qemu_find_opts("run-with"),
>                                                   optarg, false);
>          if (!opts) {
>              exit(1);
>          }
> +#if defined(CONFIG_LINUX)
>          if (qemu_opt_get_bool(opts, "async-teardown", false)) {
>              init_async_teardown();
>          }
> +#endif
> +        str = qemu_opt_get(opts, "chroot");
> +        if (str) {
> +            chroot_dir = str;
> +        }
>          break;
>      }
> -#endif
>      default:
>          return -1;
>      }
> @@ -348,3 +357,27 @@ int os_mlock(void)
>      return -ENOSYS;
>  #endif
>  }
> +
> +static QemuOptsList qemu_run_with_opts = {
> +    .name = "run-with",
> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_run_with_opts.head),
> +    .desc = {
> +#if defined(CONFIG_LINUX)
> +        {
> +            .name = "async-teardown",
> +            .type = QEMU_OPT_BOOL,
> +        },
> +#endif
> +        {
> +            .name = "chroot",
> +            .type = QEMU_OPT_STRING,
> +        },
> +        { /* end of list */ }
> +    },
> +};
> +
> +static void register_teardown(void)
> +{
> +    qemu_add_opts(&qemu_run_with_opts);
> +}
> +opts_init(register_teardown);
> diff --git a/util/async-teardown.c b/util/async-teardown.c
> index 3ab19c8740..62cdeb0f20 100644
> --- a/util/async-teardown.c
> +++ b/util/async-teardown.c
> @@ -12,9 +12,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/config-file.h"
> -#include "qemu/option.h"
> -#include "qemu/module.h"
>  #include <dirent.h>
>  #include <sys/prctl.h>
>  #include <sched.h>
> @@ -147,21 +144,3 @@ void init_async_teardown(void)
>      clone(async_teardown_fn, new_stack_for_clone(), CLONE_VM, NULL);
>      sigprocmask(SIG_SETMASK, &old_signals, NULL);
>  }
> -
> -static QemuOptsList qemu_run_with_opts = {
> -    .name = "run-with",
> -    .head = QTAILQ_HEAD_INITIALIZER(qemu_run_with_opts.head),
> -    .desc = {
> -        {
> -            .name = "async-teardown",
> -            .type = QEMU_OPT_BOOL,
> -        },
> -        { /* end of list */ }
> -    },
> -};
> -
> -static void register_teardown(void)
> -{
> -    qemu_add_opts(&qemu_run_with_opts);
> -}
> -opts_init(register_teardown);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b57489d7ca..f49d4c0e3c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4670,11 +4670,12 @@ ERST
>  
>  #ifndef _WIN32
>  DEF("chroot", HAS_ARG, QEMU_OPTION_chroot, \
> -    "-chroot dir     chroot to dir just before starting the VM\n",
> +    "-chroot dir     chroot to dir just before starting the VM (deprecated)\n",
>      QEMU_ARCH_ALL)
>  #endif
>  SRST
>  ``-chroot dir``
> +    Deprecated, use '-run-with chroot=...' instead.
>      Immediately before starting guest execution, chroot to the specified
>      directory. Especially useful in combination with -runas.
>  ERST
> @@ -4861,13 +4862,16 @@ SRST
>      This option is deprecated and should no longer be used. The new option
>      ``-run-with async-teardown=on`` is a replacement.
>  ERST
> +#endif
> +#ifdef CONFIG_POSIX
>  DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
> -    "-run-with async-teardown[=on|off]\n"
> -    "                misc QEMU process lifecycle options\n"
> -    "                async-teardown=on enables asynchronous teardown\n",
> +    "-run-with [async-teardown=on|off][,chroot=dir]\n"
> +    "                Set miscellaneous QEMU process lifecycle options:\n"
> +    "                async-teardown=on enables asynchronous teardown (Linux only)\n"
> +    "                chroot=dir chroot to dir just before starting the VM\n",
>      QEMU_ARCH_ALL)
>  SRST
> -``-run-with``
> +``-run-with [async-teardown=on|off][,chroot=dir]``
>      Set QEMU process lifecycle options.
>  
>      ``async-teardown=on`` enables asynchronous teardown. A new process called
> @@ -4880,6 +4884,10 @@ SRST
>      performed correctly. This only works if the cleanup process is not
>      forcefully killed with SIGKILL before the main QEMU process has
>      terminated completely.
> +
> +    ``chroot=dir`` can be used for doing a chroot to the specified directory
> +    immediately before starting the guest execution. This is especially useful
> +    in combination with -runas.
>  ERST
>  #endif
>  


