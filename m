Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 934C4975C4B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Sep 2024 23:13:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soUd1-0004mu-5Z; Wed, 11 Sep 2024 17:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1soUcp-0004kY-ET; Wed, 11 Sep 2024 17:11:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1soUcj-0003Ar-OL; Wed, 11 Sep 2024 17:11:39 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BDQC47027443;
 Wed, 11 Sep 2024 21:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=f
 CtVPr6cEJWU3bZrxTX7PzZzvkXd/QKPDcIB9J5Ofu8=; b=UcN6Sewgt4HKx0uek
 r4ceJ71XOo9au984+RpzI50spPFZCynvPTmDPX8HZNdG1sNrIAiQ0WNKb70D2nd6
 fLx87weppD4V1coPHtZFiNEJrCyLlaEL5nFB2xbCWvPZv874HUidPGyf4xUsGAa/
 KmIJ+dnpfXuORsXYgOGSTjIT7LLyehHcpEMhrGGXXnLE+dxnHP/wfNih681LCaSr
 I3KQvOUDyyrRj4eMA5UHrKuNPC+mS7F74AJn2VCodhhNhvNogjF/acqLpOl+oyXa
 52ua2co7lsspXms34iMA3bYyy+QJ0iC1s9DNOFRmoLFgru7PD+6WrhCpK1cbke4O
 I82/w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejar6ra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Sep 2024 21:11:21 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48BLBLXM015168;
 Wed, 11 Sep 2024 21:11:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejar6r7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Sep 2024 21:11:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48BIWCxd019843;
 Wed, 11 Sep 2024 21:11:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25q41v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Sep 2024 21:11:19 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48BLBIDW46662334
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2024 21:11:18 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFFED5805A;
 Wed, 11 Sep 2024 21:11:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4605C58056;
 Wed, 11 Sep 2024 21:11:17 +0000 (GMT)
Received: from [9.61.185.100] (unknown [9.61.185.100])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Sep 2024 21:11:17 +0000 (GMT)
Message-ID: <a58519cf-90ce-4bdf-aa5a-04c3526d7192@linux.ibm.com>
Date: Wed, 11 Sep 2024 17:11:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v15 04/11] s390x/pci: Check for multifunction
 after device realization
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240823-reuse-v15-4-eddcb960e289@daynix.com>
 <2b5d2fce-8a1e-4f50-a5d2-0c4aaa2880af@redhat.com>
 <eaebda7d-c61e-4ed8-a6b9-98e5f48f26ff@daynix.com>
 <8dbc553b-c3ae-4f11-accb-6dee10e9758e@linux.ibm.com>
 <8127d7f8-4917-4545-be66-62688157224a@daynix.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <8127d7f8-4917-4545-be66-62688157224a@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9dJ5EJKoAqD9ocdPvWCXNym8StBtxtT4
X-Proofpoint-GUID: 6SHdP3qSHm6KXPxGuGq2j_vc-_XsJv0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409110161
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/11/24 11:15 AM, Akihiko Odaki wrote:
> On 2024/09/11 22:53, Matthew Rosato wrote:
>> On 9/11/24 6:58 AM, Akihiko Odaki wrote:
>>> On 2024/09/11 18:38, Cédric Le Goater wrote:
>>>> +Matthew +Eric
>>>>
>>>> Side note for the maintainers :
>>>>
>>>> Before this change, the igb device, which is multifunction, was working
>>>> fine under Linux.
>>>>
>>>> Was there a fix in Linux since :
>>>>
>>>>     57da367b9ec4 ("s390x/pci: forbid multifunction pci device")
>>>>     6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug handler")
>>>>
>>>> ?
>> The timing of those particular commits predates the linux s390 kernel support of multifunction/SR-IOV.  At that time it was simply not possible on s390.
> 
> Is it OK to remove this check of multifunction now?

Yes, I think removing the check (which AFAIU was broken since 6069bcdeacee) will get us back to the behavior Cedric was seeing, where a device that reports multifunction in the config space is still allowed through but only the PF will be usable in the guest.

> 
> This code is not working properly with SR-IOV and misleading. It is better to remove the code if it does no good.
> 
> It would be nice if anyone confirms multifunction works for s390x with the code removed.

Even if you remove the check, multifunction itself won't work in the s390x guest without these missing CLP pieces too.  When I have some time I'll hack something together to fabricate some CLP data and try it out, but it sounds like Cedric could use his setup to right now at least verify that the PF itself should remain usable in the guest (current behavior).

> 
>>
>>>>
>>>> s390 PCI devices do not have extended capabilities, so the igb device
>>>> does not expose the SRIOV capability and only the PF is accessible but
>>>> it doesn't seem to be an issue. (Btw, CONFIG_PCI_IOV is set to y in the
>>>> default Linux config which is unexpected)
>>
>> The linux config option makes sense because the s390 kernel now supports SR-IOV/multifunction.
>>
>>>
>>> Doesn't s390x really see extended capabilities? hw/s390x/s390-pci-inst.c has a call pci_config_size() and pci_host_config_write_common(), which means it is exposing the whole PCI Express configuration space. Why can't s390x use extended capabilities then?
>>>
>>
>> So, rather than poking around in config space, s390 (and thus the s390 kernel) has an extra layer of 'capabilities' that it generally relies on to determine device functionality called 'CLP'.  Basically, there are pieces of CLP that are not currently generated (or forwarded from the host in the case of passthrough) by QEMU that would be needed by the guest to recognize the SRIOV/multifunction capability of a device, despite what config space has in it.  I suspect this is exactly why only the PF was available to your igb device then (missing CLP info made the device appear to not have multifunction capability as far as the s390 guest is concerned - fwiw adding CLP emulation to enable that is on our todo list).
> 
> What is expected to happen if you poke the configuration space anyway? I also wonder if there is some public documentation of CLP and relevant aspect of PCI support in s390x.

On s390, the contents of config space might be what is directly reported by the device or may have been modified by a firmware layer in between the device and the LPAR (logical partition that is the closest thing to bare-metal on s390 where you could run a linux host).  It's not that config space can't be read on s390 or anything like that, rather that the base s390 PCI kernel layer makes its decisions about multifunction based specifically on what is reported via CLP.  If CLP doesn't report that the device is multifunction capable (which it never does for a s390x QEMU guest today) then it is treated as not having multifunction support.

Unfortunately, the CLP details are not publicly documented.

> 
>>
>> Sounds like the short-term solution here would be to continue allowing the PF without multifunction being visible to the guest (so as to not regress prior functionality) and then aim for proper support after with the necessary CLP pieces.
> 
> I agree; we can keep the PF working.

Thanks!

Matt


