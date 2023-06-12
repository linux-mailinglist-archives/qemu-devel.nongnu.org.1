Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A34FC72C92A
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 17:01:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8j2D-0002RS-TQ; Mon, 12 Jun 2023 11:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1q8j1k-0002Qh-JP
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 11:00:17 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1q8j1g-00088e-A5
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 11:00:14 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CEhDuM026465; Mon, 12 Jun 2023 15:59:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=BqzTAdR/y6fspoGYyX+ETcM2zJKBGZrgXeXGHpMxZQc=;
 b=hONtvAoBeenbuYIZ/nmuRu4AwDc8g5zjrpac6aZ5SaSyavw90kRPo3HTw4gVsTSdX8Rt
 741IUfL7xsp4YLa74z4GIZMenL0corvy1/nz6YmzN8AkcUNGXCA3Qnf6vlqWMb3MbTz4
 B9yRMji+CHJc1D4gJOPoB2EkcHQVbf0nS4mSlt8oGU3zk5AIbVW2UGuDVGkpClDPDZiz
 hOPD1tuRKWJwGGeY0XF8s4WCjZ4Wy9Ow28bAXZE9sQs6Rj2N3g6QjdhtTsfVgwLgXPuS
 V++HI/D5K6w603foyLwIRy+hX8teCk4l0LbGFzK4G3nnLMQmrfv7q4AZ/vp11AxLakRi wQ== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18]
 (may be forged))
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3r4gec8mf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jun 2023 15:59:41 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CDtmYs013286; Mon, 12 Jun 2023 10:59:40 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 3r4mgvqq9v-1;
 Mon, 12 Jun 2023 10:59:40 -0400
Received: from [100.64.0.1] (prod-aoa-dallas2clt14.dfw02.corp.akamai.com
 [172.27.166.123])
 by prod-mail-relay10.akamai.com (Postfix) with ESMTP id D4EEA5FF56;
 Mon, 12 Jun 2023 14:59:35 +0000 (GMT)
Message-ID: <f9c3117e-3dc5-03fa-8fcd-4092660e44fc@akamai.com>
Date: Mon, 12 Jun 2023 09:59:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V9 00/46] Live Update
Content-Language: en-US
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Jason Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
 <zhengchuan@huawei.com>,
 Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe.mathieu.daude@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 David Hildenbrand <david@redhat.com>, John Snow <jsnow@redhat.com>,
 Peng Liang <tcx4c70@gmail.com>, "Hunt, Joshua" <johunt@akamai.com>
References: <1658851843-236870-1-git-send-email-steven.sistare@oracle.com>
 <53075574-9e73-f773-ccb1-cca42a719801@oracle.com>
 <ada81103-d4eb-dd02-45a8-176dae06d26c@akamai.com>
 <c4f8a36f-53e6-9d88-f542-bcbcf5deabd4@akamai.com>
 <2ed16545-c0f0-0103-a1e0-03fcc49959e1@oracle.com>
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <2ed16545-c0f0-0103-a1e0-03fcc49959e1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120127
X-Proofpoint-GUID: XsF-lp58DMeRcxJ5qlC5AjcIzDWKusSY
X-Proofpoint-ORIG-GUID: XsF-lp58DMeRcxJ5qlC5AjcIzDWKusSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120128
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=mgalaxy@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Steve,


On 6/7/23 12:37, Steven Sistare wrote:
> On 6/7/2023 11:55 AM, Michael Galaxy wrote:
>> Another option could be to expose "-migrate-mode-disable" (instead of enable) and just enable all 3 modes by default,
>> since we are already required to switch from "normal" mode to a CPR-specific mode when it is time to do a live update,
>> if the intention is to preserve the capability to completely prevent a running QEMU from using these modes
>> before the VM starts up.
>>
>> - Michael
>>
>> On 6/6/23 17:15, Michael Galaxy wrote:
>>> Hi Steve,
>>>
>>> In the current design you have, we have to specify both the command line parameter "-migrate-mode-enable cpr-reboot"
>>> *and* issue the monitor command "migrate_set_parameter mode cpr-${mode}".
>>>
>>> Is it possible to opt-in to the CPR mode just once over the monitor instead of having to specify it twice on the command line?
>>> This would also match the live migration model: You do not need to necessarily "opt in" to live migration mode through
>>> a command line parameter, you simply request it when you need to. Can CPR behave the same way?
>>>
>>> This would also make switching over to a CPR-capable version of QEMU much simpler and would even make it work for
>>> existing libvirt-managed guests as their command line parameters would no longer need to change. This would allow us to
>>> simply power-off and power-on existing VMs to make them CPR-capable and then work on a libvirt patch later when
>>> we're ready to do so.
>>>
>>>
>>> Comments?
> Hi Michael,
>    Requiring -migrate-enable-mode allows qemu to initialize objects
> differently, if necessary, so that migration for a mode is not blocked.
> See callers of migrate_mode_enabled.  There is only one so far, in
> ram_block_add.  If the mode is cpr-exec, then it creates anonymous ram
> blocks using memfd_create, else using MAP_ANON.  In the V7 series, this
> was controlled by a '-machine memfd-alloc=on' option.
>
> migrate-enable-mode is more future proof for the user.  If something new must
> initialize differently to support cpr, then it adds a call to migrate_mode_enabled,
> and the command line remains the same.  However, I could be persuaded to go either way.


OK, so it is cpr-exec that needs this option (because of ram block 
allocation), not really cpr-reboot.
Could the option then be made to only be required for cpr-exec and not 
cpr-reboot, then,
since cpr-reboot doesn't require that consideration?


> A secondary reason for -migrate-enable-mode is to support the only-cpr-capable
> option.  It needs to know which mode will be used, in order to check a
> mode-specific blocker list.

Still, only-cpr-capable is also optional. If and only if one needs this 
option, the mode could be
specified as part of the option itself, rather than requiring an extra 
command line parameter, no?

Further, in many clouds (including ours), our VM-management is 
generational with the
development of the software versioning, so we *always* run tests and 
know whether or not a VM is CPR-capable.

If it is not CPR-capable, we would never run the VM in the first place, 
which means we would never
really use that option at all.

I do see the appeal of the option, but could we simplify it, since it is 
opt-in?

- Michael


>
> - Steve

