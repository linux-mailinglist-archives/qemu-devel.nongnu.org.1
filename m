Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 566737B9732
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 00:12:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoA55-0007xF-Qo; Wed, 04 Oct 2023 18:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qoA52-0007vH-39; Wed, 04 Oct 2023 18:10:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qoA4n-0006PM-VH; Wed, 04 Oct 2023 18:10:55 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 394LbEOt018030; Wed, 4 Oct 2023 22:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0Ie1xRC/fjgYVpjq0TBs1VZSM3mB+oNgoNssErWBVUo=;
 b=Qon2eae8Fe3FqkChJ7KB1BJh/W8u/cSjrKbAH9Yosbjs6F4PN6Uxf08rljRTnEXY9fn0
 7/roZuIkWmYzkJWEgdeyMZjd8Z4VALvGgeGUCVPKK1ZVjRA4zYKOQeyQbR79IN62jERl
 NvOiYLPCilIZcvxVXwQ3HQSBE1VM63HGlspEk1vFGD70cAmycm95D+RFW9qK8K08x7W+
 +uD8+SrWTz5CIb2z9/Ix1OiUzqup5q/y9+Ozspbuli2GzIMXWACSyEvqW1uyNQ/yC/Ul
 LmnbhUjcCvvV3RmMy9HQT6aO+Z8BlclErol3AtfFg8Rv8v0oLm6kDtLwUfOkW5SxsPu7 Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thfaja1yp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 22:10:33 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 394M5UDl032066;
 Wed, 4 Oct 2023 22:10:33 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thfaja1xx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 22:10:33 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 394LUMZN010881; Wed, 4 Oct 2023 22:05:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf0q24eqk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 22:05:31 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 394M5U9W3212004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Oct 2023 22:05:31 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1A1F5805D;
 Wed,  4 Oct 2023 22:05:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7ED058056;
 Wed,  4 Oct 2023 22:05:29 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  4 Oct 2023 22:05:29 +0000 (GMT)
Message-ID: <1ec86854-d364-55b2-49d6-77d444b71876@linux.ibm.com>
Date: Wed, 4 Oct 2023 18:05:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/21] qapi: Inline QERR_MISSING_PARAMETER definition
 (constant parameter)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, integration@gluster.org
References: <20231004173158.42591-1-philmd@linaro.org>
 <20231004173158.42591-16-philmd@linaro.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231004173158.42591-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n3dfvSZGC0qn5Z9H1JlFdYZnb1KrRTfg
X-Proofpoint-ORIG-GUID: n0qao1XlIHm3RIS2mRTQNb7XERkuwhXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 spamscore=0 clxscore=1011 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040163
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528, SPF_HELO_NONE=0.001,
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


On 10/4/23 13:31, Philippe Mathieu-Daudé wrote:
> Address the comment added in commit 4629ed1e98
> ("qerror: Finally unused, clean up"), from 2015:
>
>    /*
>     * These macros will go away, please don't use
>     * in new code, and do not add new ones!
>     */
>
> Mechanical transformation using the following
> coccinelle semantic patches:
>
>      @match@
>      expression errp;
>      constant param;
>      @@
>           error_setg(errp, QERR_MISSING_PARAMETER, param);
>
>      @script:python strformat depends on match@
>      param << match.param;
>      fixedfmt; // new var
>      @@
>      if param[0] == '"': # Format skipping '"',
>          fixedfmt = f'"Parameter \'{param[1:-1]}\' is missing"'
>      else: # or use definition.
>          fixedfmt = f'"Parameter " {param} " is missing"'
>      coccinelle.fixedfmt = cocci.make_ident(fixedfmt)
>
>      @replace@
>      expression match.errp;
>      constant match.param;
>      identifier strformat.fixedfmt;
>      @@
>      -    error_setg(errp, QERR_MISSING_PARAMETER, param);
>      +    error_setg(errp, fixedfmt);
>
> and:
>
>      @match@
>      constant param;
>      @@
>           error_report(QERR_MISSING_PARAMETER, param);
>
>      @script:python strformat depends on match@
>      param << match.param;
>      fixedfmt; // new var
>      @@
>      fixedfmt = f'"Parameter \'{param[1:-1]}\' is missing"'
>      coccinelle.fixedfmt = cocci.make_ident(fixedfmt)
>
>      @replace@
>      constant match.param;
>      identifier strformat.fixedfmt;
>      @@
>      -    error_report(QERR_MISSING_PARAMETER, param);
>      +    error_report(fixedfmt);
>
> Signed-off-by: Philippe Mathieu-Daud޸ <philmd@linaro.org>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>




> ---
>   backends/dbus-vmstate.c        |  2 +-
>   block/gluster.c                | 21 +++++++++++----------
>   block/monitor/block-hmp-cmds.c |  6 +++---
>   dump/dump.c                    |  4 ++--
>   hw/usb/redirect.c              |  2 +-
>   softmmu/qdev-monitor.c         |  2 +-
>   softmmu/tpm.c                  |  4 ++--
>   softmmu/vl.c                   |  4 ++--
>   ui/input-barrier.c             |  2 +-
>   ui/ui-qmp-cmds.c               |  2 +-
>   10 files changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
> index 57369ec0f2..e781ded17c 100644
> --- a/backends/dbus-vmstate.c
> +++ b/backends/dbus-vmstate.c
> @@ -413,7 +413,7 @@ dbus_vmstate_complete(UserCreatable *uc, Error **errp)
>       }
>
>       if (!self->dbus_addr) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "addr");
> +        error_setg(errp, "Parameter 'addr' is missing");
>           return;
>       }
>
> diff --git a/block/gluster.c b/block/gluster.c
> index ad5fadbe79..8d97d698c3 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -530,20 +530,20 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
>
>       num_servers = qdict_array_entries(options, GLUSTER_OPT_SERVER_PATTERN);
>       if (num_servers < 1) {
> -        error_setg(&local_err, QERR_MISSING_PARAMETER, "server");
> +        error_setg(&local_err, "Parameter 'server' is missing");
>           goto out;
>       }
>
>       ptr = qemu_opt_get(opts, GLUSTER_OPT_VOLUME);
>       if (!ptr) {
> -        error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_VOLUME);
> +        error_setg(&local_err, "Parameter " GLUSTER_OPT_VOLUME " is missing");
>           goto out;
>       }
>       gconf->volume = g_strdup(ptr);
>
>       ptr = qemu_opt_get(opts, GLUSTER_OPT_PATH);
>       if (!ptr) {
> -        error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_PATH);
> +        error_setg(&local_err, "Parameter " GLUSTER_OPT_PATH " is missing");
>           goto out;
>       }
>       gconf->path = g_strdup(ptr);
> @@ -562,7 +562,8 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
>
>           ptr = qemu_opt_get(opts, GLUSTER_OPT_TYPE);
>           if (!ptr) {
> -            error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_TYPE);
> +            error_setg(&local_err,
> +                       "Parameter " GLUSTER_OPT_TYPE " is missing");
>               error_append_hint(&local_err, GERR_INDEX_HINT, i);
>               goto out;
>
> @@ -592,16 +593,16 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
>
>               ptr = qemu_opt_get(opts, GLUSTER_OPT_HOST);
>               if (!ptr) {
> -                error_setg(&local_err, QERR_MISSING_PARAMETER,
> -                           GLUSTER_OPT_HOST);
> +                error_setg(&local_err,
> +                           "Parameter " GLUSTER_OPT_HOST " is missing");
>                   error_append_hint(&local_err, GERR_INDEX_HINT, i);
>                   goto out;
>               }
>               gsconf->u.inet.host = g_strdup(ptr);
>               ptr = qemu_opt_get(opts, GLUSTER_OPT_PORT);
>               if (!ptr) {
> -                error_setg(&local_err, QERR_MISSING_PARAMETER,
> -                           GLUSTER_OPT_PORT);
> +                error_setg(&local_err,
> +                           "Parameter " GLUSTER_OPT_PORT " is missing");
>                   error_append_hint(&local_err, GERR_INDEX_HINT, i);
>                   goto out;
>               }
> @@ -648,8 +649,8 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
>                   goto out;
>               }
>               if (!ptr) {
> -                error_setg(&local_err, QERR_MISSING_PARAMETER,
> -                           GLUSTER_OPT_PATH);
> +                error_setg(&local_err,
> +                           "Parameter " GLUSTER_OPT_PATH " is missing");
>                   error_append_hint(&local_err, GERR_INDEX_HINT, i);
>                   goto out;
>               }
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> index ca2599de44..90e593ed38 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -252,7 +252,7 @@ void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
>       };
>
>       if (!filename) {
> -        error_setg(&err, QERR_MISSING_PARAMETER, "target");
> +        error_setg(&err, "Parameter 'target' is missing");
>           goto end;
>       }
>       qmp_drive_mirror(&mirror, &err);
> @@ -281,7 +281,7 @@ void hmp_drive_backup(Monitor *mon, const QDict *qdict)
>       };
>
>       if (!filename) {
> -        error_setg(&err, QERR_MISSING_PARAMETER, "target");
> +        error_setg(&err, "Parameter 'target' is missing");
>           goto end;
>       }
>
> @@ -356,7 +356,7 @@ void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
>            * In the future, if 'snapshot-file' is not specified, the snapshot
>            * will be taken internally. Today it's actually required.
>            */
> -        error_setg(&err, QERR_MISSING_PARAMETER, "snapshot-file");
> +        error_setg(&err, "Parameter 'snapshot-file' is missing");
>           goto end;
>       }
>
> diff --git a/dump/dump.c b/dump/dump.c
> index e173f1f14c..642b952985 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -2096,11 +2096,11 @@ void qmp_dump_guest_memory(bool paging, const char *file,
>           return;
>       }
>       if (has_begin && !has_length) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "length");
> +        error_setg(errp, "Parameter 'length' is missing");
>           return;
>       }
>       if (!has_begin && has_length) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "begin");
> +        error_setg(errp, "Parameter 'begin' is missing");
>           return;
>       }
>       if (has_detach) {
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index ac6fa34ad1..83bfc9dc19 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -1426,7 +1426,7 @@ static void usbredir_realize(USBDevice *udev, Error **errp)
>       int i;
>
>       if (!qemu_chr_fe_backend_connected(&dev->cs)) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "chardev");
> +        error_setg(errp, "Parameter 'chardev' is missing");
>           return;
>       }
>
> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index b17aec4357..b7b2bf18d4 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -622,7 +622,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>
>       driver = qdict_get_try_str(opts, "driver");
>       if (!driver) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "driver");
> +        error_setg(errp, "Parameter 'driver' is missing");
>           return NULL;
>       }
>
> diff --git a/softmmu/tpm.c b/softmmu/tpm.c
> index 8437c4efc3..3a7d4b5c67 100644
> --- a/softmmu/tpm.c
> +++ b/softmmu/tpm.c
> @@ -106,13 +106,13 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
>
>       id = qemu_opts_id(opts);
>       if (id == NULL) {
> -        error_report(QERR_MISSING_PARAMETER, "id");
> +        error_report("Parameter 'id' is missing");
>           return 1;
>       }
>
>       value = qemu_opt_get(opts, "type");
>       if (!value) {
> -        error_report(QERR_MISSING_PARAMETER, "type");
> +        error_report("Parameter 'type' is missing");
>           tpm_display_backend_drivers();
>           return 1;
>       }
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 98e071e63b..840ac84069 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -1801,7 +1801,7 @@ static void object_option_parse(const char *optarg)
>
>           type = qemu_opt_get(opts, "qom-type");
>           if (!type) {
> -            error_setg(&error_fatal, QERR_MISSING_PARAMETER, "qom-type");
> +            error_setg(&error_fatal, "Parameter 'qom-type' is missing");
>           }
>           if (user_creatable_print_help(type, opts)) {
>               exit(0);
> @@ -2266,7 +2266,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>       bool qtest_with_kvm;
>
>       if (!acc) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "accel");
> +        error_setg(errp, "Parameter 'accel' is missing");
>           goto bad;
>       }
>
> diff --git a/ui/input-barrier.c b/ui/input-barrier.c
> index 2d57ca7079..ecbba4adc2 100644
> --- a/ui/input-barrier.c
> +++ b/ui/input-barrier.c
> @@ -493,7 +493,7 @@ static void input_barrier_complete(UserCreatable *uc, Error **errp)
>       Error *local_err = NULL;
>
>       if (!ib->name) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "name");
> +        error_setg(errp, "Parameter 'name' is missing");
>           return;
>       }
>
> diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
> index a95fd35948..0e350fc333 100644
> --- a/ui/ui-qmp-cmds.c
> +++ b/ui/ui-qmp-cmds.c
> @@ -195,7 +195,7 @@ void qmp_client_migrate_info(const char *protocol, const char *hostname,
>           }
>
>           if (!has_port && !has_tls_port) {
> -            error_setg(errp, QERR_MISSING_PARAMETER, "port/tls-port");
> +            error_setg(errp, "Parameter 'port/tls-port' is missing");
>               return;
>           }
>

