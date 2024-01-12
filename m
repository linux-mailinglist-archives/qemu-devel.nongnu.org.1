Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F8F82BE48
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 11:15:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOEYF-0003dT-KI; Fri, 12 Jan 2024 05:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1rOEYC-0003dB-Rs; Fri, 12 Jan 2024 05:14:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1rOEYA-00052h-H2; Fri, 12 Jan 2024 05:14:08 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40C8694i005204; Fri, 12 Jan 2024 10:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=+c3T22GlRUI1xs3dDX8O95LySohPlAZgmykRkIVe26A=;
 b=jlwltrmE7VOqdg+cjlsLO+0rujxF8he1GtRflIh34T/uB/AsdUOWRz3vIkm5efMNTSGp
 Vrtk8NxwI4NXCPNd+NWSAym5i5L9tAfwORuMxnmXa8jiobmxoTufLkpZI/uKxWugYQdM
 I2JMqTJpyzvPI6Ejk6cEgwSA+S6zPpGXPdLTSmNqg1FcvXLAzYvRNdlq/Los6FhnJQ/5
 E/WvHaz/ycpP7sYxIuRKGp1KHW+syV8mN8CiVpyMcG8MI4CgAeDSEVif6tD0vUenioLC
 U1GBe6ljK4T6Q30Fv8JcKQTX1m8I2JlGMC0r5y7bSbezlYE7AnvewAy5sQ+2N5OBawl2 Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjwf2yh7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jan 2024 10:14:03 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40C9aT7V008163;
 Fri, 12 Jan 2024 10:14:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjwf2yh7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jan 2024 10:14:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40C9TJCp022781; Fri, 12 Jan 2024 10:14:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfhk01grq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jan 2024 10:14:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40CADxRd8323716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 10:13:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B6842004D;
 Fri, 12 Jan 2024 10:13:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7199C2004B;
 Fri, 12 Jan 2024 10:13:59 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jan 2024 10:13:59 +0000 (GMT)
Date: Fri, 12 Jan 2024 11:13:58 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 3/5] qemu-options: Remove the deprecated -async-teardown
 option
Message-ID: <20240112111358.5a42cc3a@p-imbrenda>
In-Reply-To: <20240112100059.965041-4-thuth@redhat.com>
References: <20240112100059.965041-1-thuth@redhat.com>
 <20240112100059.965041-4-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9HxNfqCVOEpvILSCBIiHv3HAYggjxqbT
X-Proofpoint-GUID: m7hGVo5BdLXMgom-pyazbOYA3Q0txxM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_03,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 mlxlogscore=999 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401120078
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

On Fri, 12 Jan 2024 11:00:57 +0100
Thomas Huth <thuth@redhat.com> wrote:

> It's been marked as deprecated since QEMU 8.1 (and was only available
> since QEMU 8.0 anyway), so it should be fine to remove this now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  docs/about/deprecated.rst       |  5 -----
>  docs/about/removed-features.rst |  5 +++++
>  system/vl.c                     |  6 ------
>  qemu-options.hx                 | 10 ----------
>  4 files changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index dff4c76f1b..80eacd40ba 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -63,11 +63,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
>  However, short-form booleans are deprecated and full explicit ``arg_name=on``
>  form is preferred.
>  
> -``-async-teardown`` (since 8.1)
> -'''''''''''''''''''''''''''''''
> -
> -Use ``-run-with async-teardown=on`` instead.
> -
>  ``-chroot`` (since 8.1)
>  '''''''''''''''''''''''
>  
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index ae728b6130..43f64a26ba 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -472,6 +472,11 @@ Use ``-machine hpet=off`` instead.
>  The ``-no-acpi`` setting has been turned into a machine property.
>  Use ``-machine acpi=off`` instead.
>  
> +``-async-teardown`` (removed in 9.0)
> +''''''''''''''''''''''''''''''''''''
> +
> +Use ``-run-with async-teardown=on`` instead.
> +
>  
>  QEMU Machine Protocol (QMP) commands
>  ------------------------------------
> diff --git a/system/vl.c b/system/vl.c
> index 7e258889f3..924356f864 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -3600,12 +3600,6 @@ void qemu_init(int argc, char **argv)
>              case QEMU_OPTION_daemonize:
>                  os_set_daemonize(true);
>                  break;
> -#if defined(CONFIG_LINUX)
> -            /* deprecated */
> -            case QEMU_OPTION_asyncteardown:
> -                init_async_teardown();
> -                break;
> -#endif
>              case QEMU_OPTION_run_with: {
>                  const char *str;
>                  opts = qemu_opts_parse_noisily(qemu_find_opts("run-with"),
> diff --git a/qemu-options.hx b/qemu-options.hx
> index dafecf47d6..10c952ba3f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4975,16 +4975,6 @@ HXCOMM Internal use
>  DEF("qtest", HAS_ARG, QEMU_OPTION_qtest, "", QEMU_ARCH_ALL)
>  DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, "", QEMU_ARCH_ALL)
>  
> -#ifdef __linux__
> -DEF("async-teardown", 0, QEMU_OPTION_asyncteardown,
> -    "-async-teardown enable asynchronous teardown\n",
> -    QEMU_ARCH_ALL)
> -SRST
> -``-async-teardown``
> -    This option is deprecated and should no longer be used. The new option
> -    ``-run-with async-teardown=on`` is a replacement.
> -ERST
> -#endif
>  #ifdef CONFIG_POSIX
>  DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
>      "-run-with [async-teardown=on|off][,chroot=dir]\n"


