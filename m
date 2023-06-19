Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9A1734FD7
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 11:24:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBB7K-00072J-PU; Mon, 19 Jun 2023 05:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qBB7I-00071W-62
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:24:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qBB7G-0003H3-Aw
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:24:07 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35J8uh1b011872; Mon, 19 Jun 2023 09:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=V+81pi3FfF65LU0O+0t4wpzFudO8GtXpyje/ZgK8yv4=;
 b=lMZ7fz4ZeHe+0796s+IzLnp0ErP6+hgvE0U/jHbIHU1Llm/5VoO72d9BvgK1x058exm9
 soQ0EyKh6SYfWYJVGwsBgkYcRmdzj6u8RmbX3zD+GCfHNHdWgdyN2V0wd0qNw/fh1crv
 v7xiaVb19vzdxglzYR5KcuNI7zNUzKB+ndoY9YYvgzKvb2wqNfP2o05i6y63ptpRzKwE
 3KBmzGbGRFetyJQZyET5O6CdxZVFsqtnLx2PtUV00wIIQ4+dfWozYhBZM+KIxi36a0aw
 je7LWBEZ6OrNMu/EtElDShNI1ASUXuUh307n0pppM4kZ5A8JqfrUxCVh9lI7vLdQZQOG xA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3raky28nnq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jun 2023 09:24:04 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35J9IB2q007092;
 Mon, 19 Jun 2023 09:24:04 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3raky28nn5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jun 2023 09:24:03 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35J6ovvT006976;
 Mon, 19 Jun 2023 09:24:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3r94f50xx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jun 2023 09:24:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35J9NxRl62062990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jun 2023 09:23:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB53A2004B;
 Mon, 19 Jun 2023 09:23:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D3E120040;
 Mon, 19 Jun 2023 09:23:59 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Jun 2023 09:23:59 +0000 (GMT)
Date: Mon, 19 Jun 2023 11:23:41 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Bin Meng <bmeng@tinylab.org>
Cc: qemu-devel@nongnu.org, Zhangjin Wu <falcon@tinylab.org>, Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH v3 6/6] net: tap: Use qemu_close_range() to close fds
Message-ID: <20230619112341.1b9e98de@p-imbrenda>
In-Reply-To: <20230617053621.50359-7-bmeng@tinylab.org>
References: <20230617053621.50359-1-bmeng@tinylab.org>
 <20230617053621.50359-7-bmeng@tinylab.org>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3on0qLIrMouL8pkpPyorJ5HrhgbMZow8
X-Proofpoint-GUID: aBXotlc58lrvnZ4dcnKCESkBLscHCVAi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Sat, 17 Jun 2023 13:36:21 +0800
Bin Meng <bmeng@tinylab.org> wrote:

> From: Zhangjin Wu <falcon@tinylab.org>
> 
> Current codes using a brute-force traversal of all file descriptors
> do not scale on a system where the maximum number of file descriptors
> is set to a very large value (e.g.: in a Docker container of Manjaro
> distribution it is set to 1073741816). QEMU just looks frozen during
> start-up.
> 
> The close-on-exec flag (O_CLOEXEC) was introduced since Linux kernel
> 2.6.23, FreeBSD 8.3, OpenBSD 5.0, Solaris 11. While it's true QEMU
> doesn't need to manually close the fds for child process as the proper
> O_CLOEXEC flag should have been set properly on files with its own
> codes, QEMU uses a huge number of 3rd party libraries and we don't
> trust them to reliably be using O_CLOEXEC on everything they open.
> 
> Modern Linux and BSDs have the close_range() call we can use to do the
> job, and on Linux we have one more way to walk through /proc/self/fd
> to complete the task efficiently, which is what qemu_close_range() does.
> 
> Reported-by: Zhangjin Wu <falcon@tinylab.org>
> Co-developed-by: Bin Meng <bmeng@tinylab.org>
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Change to use qemu_close_range() to close fds for child process efficiently
> - v1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-1-bmeng@tinylab.org/
> 
>  net/tap.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/net/tap.c b/net/tap.c
> index 1bf085d422..d482fabdff 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -446,13 +446,13 @@ static void launch_script(const char *setup_script, const char *ifname,
>          return;
>      }
>      if (pid == 0) {
> -        int open_max = sysconf(_SC_OPEN_MAX), i;
> +        unsigned int last_fd = sysconf(_SC_OPEN_MAX) - 1;
> +
> +        /* skip stdin, stdout and stderr */
> +        qemu_close_range(3, fd - 1);
> +        /* skip the currently used fd */
> +        qemu_close_range(fd + 1, last_fd);
>  
> -        for (i = 3; i < open_max; i++) {
> -            if (i != fd) {
> -                close(i);
> -            }
> -        }
>          parg = args;
>          *parg++ = (char *)setup_script;
>          *parg++ = (char *)ifname;
> @@ -536,16 +536,15 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
>          return -1;
>      }
>      if (pid == 0) {
> -        int open_max = sysconf(_SC_OPEN_MAX), i;
> +        unsigned int last_fd = sysconf(_SC_OPEN_MAX) - 1, fd = sv[1];

please put fd on its own line

>          char *fd_buf = NULL;
>          char *br_buf = NULL;
>          char *helper_cmd = NULL;
>  
> -        for (i = 3; i < open_max; i++) {
> -            if (i != sv[1]) {
> -                close(i);
> -            }
> -        }
> +        /* skip stdin, stdout and stderr */
> +        qemu_close_range(3, fd - 1);
> +        /* skip the currently used fd */
> +        qemu_close_range(fd + 1, last_fd);
>  
>          fd_buf = g_strdup_printf("%s%d", "--fd=", sv[1]);
>  


