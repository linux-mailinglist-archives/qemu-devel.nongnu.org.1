Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B967AB258
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 14:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjfTP-00048n-Fw; Fri, 22 Sep 2023 08:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qjfTM-00048T-M4
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 08:41:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qjfTK-0004WC-2Q
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 08:41:28 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38MCcSPY015922
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 12:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=J1YEduTOEczH9J2VCayI1pgLSyqYeO+bCOosjKqbx5k=;
 b=UTAXM+XE+1iwR/i1rKPZtrut+WX+Y16lJL5KYAySv0Yf+92HAV2kjD3iNvu9+nsUuM5e
 Xt/PN7BMo9f0jbG4L9PoK+hyhELwq2dggqyRi2n5uNv2TWYpOAQs2u3PgQ7ceAkGt8cx
 MC6PypLoiwZGlA4NAMb9d6z29NDINXst76uE2NJCyWlG9czp//5/zbs8odEmyPiijcTN
 epVnrNCHeI+76ztUvfSaThQAr8JnxssEgg3drqV6Qv6/mCx3gSoq3ERDOIKM4zFghP6+
 O5j6hXjhoxPjNBbfa1NRPvFDPp5CQOpuwGPHKNr6Pa8HhLERZafftzn61JXFTGFBy0qd Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t990s3bvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 12:41:22 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38MCcwWB016429
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 12:41:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t990s3bvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Sep 2023 12:41:21 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38MCacHQ018810; Fri, 22 Sep 2023 12:41:21 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t8tsp1mu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Sep 2023 12:41:21 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38MCfKUp2491038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 12:41:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2EA358061;
 Fri, 22 Sep 2023 12:41:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5502058056;
 Fri, 22 Sep 2023 12:41:20 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 22 Sep 2023 12:41:20 +0000 (GMT)
Message-ID: <2629ce63-e4dd-67f3-6341-d477c39b29f7@linux.ibm.com>
Date: Fri, 22 Sep 2023 08:41:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 2/2] tpm: add backend for mssim
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, James Bottomley <jejb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20230109161532.6892-1-jejb@linux.ibm.com>
 <20230109161532.6892-3-jejb@linux.ibm.com> <87bkduwxv7.fsf@pond.sub.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <87bkduwxv7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rq565-hH-hWEtIu9HCRBWnlzDfcYMwkD
X-Proofpoint-GUID: Ni-jc7TVhT01NT50M2j5281Id1hq7k8z
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_10,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 mlxscore=0 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220107
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 9/22/23 02:00, Markus Armbruster wrote:
> Found this cleaning out old mail, sorry for missing it until now!
>
> I think we owe James a quick decision wether we're willing to take the
> feature.  Stefan, thoughts?

I thought we discusses it back then. Does it handle snapshotting and 
migration correctly?

   Stefan

>
> James Bottomley <jejb@linux.ibm.com> writes:
>
>> From: James Bottomley <James.Bottomley@HansenPartnership.com>
>>
>> The Microsoft Simulator (mssim) is the reference emulation platform
>> for the TCG TPM 2.0 specification.
>>
>> https://github.com/Microsoft/ms-tpm-20-ref.git
>>
>> It exports a fairly simple network socket based protocol on two
>> sockets, one for command (default 2321) and one for control (default
>> 2322).  This patch adds a simple backend that can speak the mssim
>> protocol over the network.  It also allows the two sockets to be
>> specified on the command line.  The benefits are twofold: firstly it
>> gives us a backend that actually speaks a standard TPM emulation
>> protocol instead of the linux specific TPM driver format of the
>> current emulated TPM backend and secondly, using the microsoft
>> protocol, the end point of the emulator can be anywhere on the
>> network, facilitating the cloud use case where a central TPM service
>> can be used over a control network.
>>
>> The implementation does basic control commands like power off/on, but
>> doesn't implement cancellation or startup.  The former because
>> cancellation is pretty much useless on a fast operating TPM emulator
>> and the latter because this emulator is designed to be used with OVMF
>> which itself does TPM startup and I wanted to validate that.
>>
>> To run this, simply download an emulator based on the MS specification
>> (package ibmswtpm2 on openSUSE) and run it, then add these two lines
>> to the qemu command and it will use the emulator.
>>
>>      -tpmdev mssim,id=tpm0 \
>>      -device tpm-crb,tpmdev=tpm0 \
>>
>> to use a remote emulator replace the first line with
>>
>>      -tpmdev "{'type':'mssim','id':'tpm0','command':{'type':inet,'host':'remote','port':'2321'}}"
>>
>> tpm-tis also works as the backend.
>>
>> Signed-off-by: James Bottomley <jejb@linux.ibm.com>
> [...]
>
>> diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
>> index 535912a92b..1398735956 100644
>> --- a/docs/specs/tpm.rst
>> +++ b/docs/specs/tpm.rst
>> @@ -270,6 +270,38 @@ available as a module (assuming a TPM 2 is passed through):
>>     /sys/devices/LNXSYSTEM:00/LNXSYBUS:00/MSFT0101:00/tpm/tpm0/pcr-sha256/9
>>     ...
>>   
>> +The QEMU TPM Microsoft Simulator Device
>> +---------------------------------------
>> +
>> +The TCG provides a reference implementation for TPM 2.0 written by
>
> Suggest to copy the cover letter's nice introductory paragraph here:
>
>    The Microsoft Simulator (mssim) is the reference emulation platform
>    for the TCG TPM 2.0 specification.
>
>    It provides a reference implementation for TPM 2.0 written by
>
>> +Microsoft (See `ms-tpm-20-ref`_ on github).  The reference implementation
>> +starts a network server and listens for TPM commands on port 2321 and
>> +TPM Platform control commands on port 2322, although these can be
>> +altered.  The QEMU mssim TPM backend talks to this implementation.  By
>> +default it connects to the default ports on localhost:
>> +
>> +.. code-block:: console
>> +
>> +  qemu-system-x86_64 <qemu-options> \
>> +    -tpmdev mssim,id=tpm0 \
>> +    -device tpm-crb,tpmdev=tpm0
>> +
>> +
>> +Although it can also communicate with a remote host, which must be
>> +specified as a SocketAddress via json on the command line for each of
> Is the "via JSON" part in "must be specified ... on the command line"
> correct?  I'd expect to be able to use dotted keys as well, like
>
>      -tpmdev type=mssim,id=tpm0,command.type=inet,command.host=remote,command.port=2321',control.type=inet,control.host=remote,control.port=2322
>
> Aside: I do recommend management applications stick to JSON.
>
>> +the command and control ports:
>> +
>> +.. code-block:: console
>> +
>> +  qemu-system-x86_64 <qemu-options> \
>> +    -tpmdev "{'type':'mssim','id':'tpm0','command':{'type':'inet','host':'remote','port':'2321'},'control':{'type':'inet','host':'remote','port':'2322'}}" \
>> +    -device tpm-crb,tpmdev=tpm0
>> +
>> +
>> +The mssim backend supports snapshotting and migration, but the state
>> +of the Microsoft Simulator server must be preserved (or the server
>> +kept running) outside of QEMU for restore to be successful.
>> +
>>   The QEMU TPM emulator device
>>   ----------------------------
>>   
>> @@ -526,3 +558,6 @@ the following:
>>   
>>   .. _SWTPM protocol:
>>      https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioctls.pod
>> +
>> +.. _ms-tpm-20-ref:
>> +   https://github.com/microsoft/ms-tpm-20-ref
>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> index ed78a87ddd..12482368d0 100644
>> --- a/monitor/hmp-cmds.c
>> +++ b/monitor/hmp-cmds.c
>> @@ -731,6 +731,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>>       unsigned int c = 0;
>>       TPMPassthroughOptions *tpo;
>>       TPMEmulatorOptions *teo;
>> +    TPMmssimOptions *tmo;
>>   
>>       info_list = qmp_query_tpm(&err);
>>       if (err) {
>> @@ -764,6 +765,14 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>>               teo = ti->options->u.emulator.data;
>>               monitor_printf(mon, ",chardev=%s", teo->chardev);
>>               break;
>> +        case TPM_TYPE_MSSIM:
>> +            tmo = &ti->options->u.mssim;
>> +            monitor_printf(mon, ",command=%s:%s,control=%s:%s",
>> +                           tmo->command->u.inet.host,
>> +                           tmo->command->u.inet.port,
>> +                           tmo->control->u.inet.host,
>> +                           tmo->control->u.inet.port);
>> +            break;
>>           case TPM_TYPE__MAX:
>>               break;
>>           }
>> diff --git a/qapi/tpm.json b/qapi/tpm.json
>> index 2b491c28b4..f9dde35377 100644
>> --- a/qapi/tpm.json
>> +++ b/qapi/tpm.json
>> @@ -5,6 +5,7 @@
>>   ##
>>   # = TPM (trusted platform module) devices
>>   ##
> Blank line, please.
>
>> +{ 'include': 'sockets.json' }
>>   
>>   ##
>>   # @TpmModel:
>> @@ -49,7 +50,7 @@
>     #
>     # @passthrough: TPM passthrough type
>     #
>     # @emulator: Software Emulator TPM type (since 2.11)
>>   #
> Missing member documentation:
>
>     # @mssim: <brief description here> (since 8.2)
>
>>   # Since: 1.5
>>   ##
>> -{ 'enum': 'TpmType', 'data': [ 'passthrough', 'emulator' ],
>> +{ 'enum': 'TpmType', 'data': [ 'passthrough', 'emulator', 'mssim' ],
>>     'if': 'CONFIG_TPM' }
>>   
>>   ##
>> @@ -64,7 +65,7 @@
>>   # Example:
>>   #
>>   # -> { "execute": "query-tpm-types" }
>> -# <- { "return": [ "passthrough", "emulator" ] }
>> +# <- { "return": [ "passthrough", "emulator", "mssim" ] }
> Thanks for updating the example.
>
>>   #
>>   ##
>>   { 'command': 'query-tpm-types', 'returns': ['TpmType'],
>> @@ -117,6 +118,22 @@
>>     'data': { 'data': 'TPMEmulatorOptions' },
>>     'if': 'CONFIG_TPM' }
>>   
>> +##
>> +# @TPMmssimOptions:
> Please capitalize similar to TPMPassthroughOptions and
> TPMEmulatorOptions: TPMMssimOptions.
>
>> +#
>> +# Information for the mssim emulator connection
>> +#
>> +# @command: command socket for the TPM emulator
> Blank line, please.
>
>> +# @control: control socket for the TPM emulator
>> +#
>> +# Since: 7.2.0
> Since 8.2
>
>> +##
>> +{ 'struct': 'TPMmssimOptions',
>> +  'data': {
>> +      '*command': 'SocketAddress',
>> +      '*control': 'SocketAddress' },
> Locally consistent indentation is
>
>       'data': { '*command': 'SocketAddress',
>                 '*control': 'SocketAddress' },
>
>> +  'if': 'CONFIG_TPM' }
>> +
>>   ##
>>   # @TpmTypeOptions:
>>   #
>> @@ -124,6 +141,7 @@
>>   #
>>   # @type: - 'passthrough' The configuration options for the TPM passthrough type
>>   #        - 'emulator' The configuration options for TPM emulator backend type
>> +#        - 'mssim' The configuration options for TPM emulator mssim type
>>   #
>>   # Since: 1.5
>>   ##
>> @@ -131,7 +149,8 @@
>>     'base': { 'type': 'TpmType' },
>>     'discriminator': 'type',
>>     'data': { 'passthrough' : 'TPMPassthroughOptionsWrapper',
>> -            'emulator': 'TPMEmulatorOptionsWrapper' },
>> +            'emulator': 'TPMEmulatorOptionsWrapper',
>> +            'mssim' : 'TPMmssimOptions' },
>>     'if': 'CONFIG_TPM' }
>>   
>>   ##
>> @@ -150,7 +169,8 @@
>>               'id' : 'str' },
>>     'discriminator': 'type',
>>     'data': { 'passthrough' : 'TPMPassthroughOptions',
>> -            'emulator': 'TPMEmulatorOptions' },
>> +            'emulator': 'TPMEmulatorOptions',
>> +            'mssim': 'TPMmssimOptions' },
>>     'if': 'CONFIG_TPM' }
>>   
>>   ##
> Address my nitpicking, and you may add
>
> Acked-by: Markus Armbruster <armbru@redhat.com>
>

