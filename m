Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8585734FBF
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 11:24:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBB7K-00071e-3y; Mon, 19 Jun 2023 05:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qBB7H-00071M-L1
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:24:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qBB7F-0003Fl-26
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:24:06 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35J9MYSk027138; Mon, 19 Jun 2023 09:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=wFplvQ+st/Ax9xaSYSbveoi7bz/jQ/ap7BgMr/HRQYI=;
 b=Ypnz7O39SMZfdrpLjC+o+j0m9wBVS6SzKxHEDteL6gX3Fy5jMSECJBlg1c/P6Bj4mcuv
 alztmQblAR0aUceE9h46g306XEXoBCkEG3Y4K+k7IDj+MxB5h7XFu6m22+9H3T8cD85W
 fHuhPElteuhTBLcqSv3eIdUoKbvu2dLJEMcb/rbxE6CWFfU9rx8QvtiV6d540JWetUMt
 qinczsYAXlalu7EZnJ+9J9kAAaSsLeCfZKIqWMLl/z2CfEA4nUKfRgS/PiXm48XpSmGa
 4c/sGvlgZYn1VJcHa0Q9qKBheHOxslnp+RKiBHA4zv5NPBDIGi/02EHwWOsctOKFmhm4 bg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ramb60122-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jun 2023 09:24:01 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35J9N0iC028370;
 Mon, 19 Jun 2023 09:24:01 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ramb6011m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jun 2023 09:24:01 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35J9LuqX009469;
 Mon, 19 Jun 2023 09:23:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r94f50xsr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jun 2023 09:23:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35J9NvlA22217454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jun 2023 09:23:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 110F820043;
 Mon, 19 Jun 2023 09:23:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD94020040;
 Mon, 19 Jun 2023 09:23:56 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Jun 2023 09:23:56 +0000 (GMT)
Date: Mon, 19 Jun 2023 11:19:52 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Bin Meng <bmeng@tinylab.org>
Cc: qemu-devel@nongnu.org, Zhangjin Wu <falcon@tinylab.org>, Juan Quintela
 <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 5/6] util/async-teardown: Use qemu_close_range() to
 close fds
Message-ID: <20230619111952.0b7d86f2@p-imbrenda>
In-Reply-To: <20230617053621.50359-6-bmeng@tinylab.org>
References: <20230617053621.50359-1-bmeng@tinylab.org>
 <20230617053621.50359-6-bmeng@tinylab.org>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mr3p-3Apxh71kNkyu0mZsUz8Y0_COEES
X-Proofpoint-GUID: vTTYgSYTXqCAzXsktA4OXQvcrAyALIHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=740 classifier=spam adjust=0 reason=mlx scancount=1
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

On Sat, 17 Jun 2023 13:36:20 +0800
Bin Meng <bmeng@tinylab.org> wrote:

> From: Zhangjin Wu <falcon@tinylab.org>
> 
> Based on the old close_all_open_fd() of util/async-teardown.c, a new
> generic qemu_close_range() has been added in osdep.c.
> 
> Now, let's switch over to use the generic qemu_close_range().
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> 
> ---
> 
> Changes in v3:
> - limit the last_fd of qemu_close_range() to sysconf(_SC_OPEN_MAX)
> 
> Changes in v2:
> - new patch: "util/async-teardown: Use qemu_close_range() to close fds"
> 
>  util/async-teardown.c | 42 ++----------------------------------------
>  1 file changed, 2 insertions(+), 40 deletions(-)
> 
> diff --git a/util/async-teardown.c b/util/async-teardown.c
> index 7e0177a8da..e102912f3f 100644
> --- a/util/async-teardown.c
> +++ b/util/async-teardown.c
> @@ -29,44 +29,6 @@
>  
>  static pid_t the_ppid;
>  
> -/*
> - * Close all open file descriptors.
> - */
> -static void close_all_open_fd(void)
> -{
> -    struct dirent *de;
> -    int fd, dfd;
> -    DIR *dir;
> -
> -#ifdef CONFIG_CLOSE_RANGE
> -    int r = close_range(0, ~0U, 0);
> -    if (!r) {
> -        /* Success, no need to try other ways. */
> -        return;
> -    }
> -#endif
> -
> -    dir = opendir("/proc/self/fd");
> -    if (!dir) {
> -        /* If /proc is not mounted, close fds one by one. */
> -        int open_max = sysconf(_SC_OPEN_MAX), i;
> -        for (i = 0; i < open_max; i++) {
> -                close(i);
> -        }
> -        return;
> -    }
> -    /* Avoid closing the directory. */
> -    dfd = dirfd(dir);
> -
> -    for (de = readdir(dir); de; de = readdir(dir)) {
> -        fd = atoi(de->d_name);
> -        if (fd != dfd) {
> -            close(fd);
> -        }
> -    }
> -    closedir(dir);
> -}
> -
>  static void hup_handler(int signal)
>  {
>      /* Check every second if this process has been reparented. */
> @@ -84,6 +46,7 @@ static int async_teardown_fn(void *arg)
>      struct sigaction sa = { .sa_handler = hup_handler };
>      sigset_t hup_signal;
>      char name[16];
> +    int open_max = sysconf(_SC_OPEN_MAX);
>  
>      /* Set a meaningful name for this process. */
>      snprintf(name, 16, "cleanup/%d", the_ppid);
> @@ -92,9 +55,8 @@ static int async_teardown_fn(void *arg)
>      /*
>       * Close all file descriptors that might have been inherited from the
>       * main qemu process when doing clone, needed to make libvirt happy.
> -     * Not using close_range for increased compatibility with older kernels.
>       */
> -    close_all_open_fd();
> +    qemu_close_range(0, open_max - 1);

I think it would look easier to read if you just put the sysconf() call
here and avoid an extra variable

>  
>      /* Set up a handler for SIGHUP and unblock SIGHUP. */
>      sigaction(SIGHUP, &sa, NULL);


