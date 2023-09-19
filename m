Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FC67A6EB9
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 00:36:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qijK9-0000Zd-QV; Tue, 19 Sep 2023 18:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qijK8-0000ZP-0Y; Tue, 19 Sep 2023 18:36:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qijK6-0006hL-66; Tue, 19 Sep 2023 18:36:03 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JMZnW8021376; Tue, 19 Sep 2023 22:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=MiBq3HiUPB4Jwong/oyRRP5vb/zUzNx0DlNbmqD6IiE=;
 b=stxqnGdlcmZXJ/EHFwEyFO2z8DpHxG4F3uUjMCkTjG6ZPYmINrtzheAfgbRUcqHiKl79
 86X076COBp8h3LqA9N3fl2Ta62vH29fvom0KslINCl5cbBYHMZ+RCxcRXUvwlDLOMuhA
 xltYMS93PuUs51nrddD4VZxFu4cQm9+cs1Nvm+oREUm/c0oaOg/TPxcBkQyVvWQ5p+lh
 ag/0ODTajGnyB3U0AUzPQrAPpGQRoCNMIWlfV2gYr9Td4yTtd3N8W5V+uf/C21eptjpg
 nXrMYlSWCZUCr8XemFhWaRqRBHKyvwo54k8n4JKGCST5d2QnjZqifhg+iDEcUbBTZUt2 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7kd2hnj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 22:35:55 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38JMZtp5022056;
 Tue, 19 Sep 2023 22:35:55 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7kd2hmp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 22:35:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JLAwHE010364; Tue, 19 Sep 2023 22:01:12 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5rwk7xqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 22:01:12 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38JM1Bj936569542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 22:01:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 836415805E;
 Tue, 19 Sep 2023 22:01:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8F7358050;
 Tue, 19 Sep 2023 22:01:10 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 22:01:10 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 19 Sep 2023 17:01:10 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, "open
 list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 4/4] target/ppc: Add migration support for BHRB
In-Reply-To: <CVJ3HRR2EADR.15F9G78LN7PKL@wheely>
References: <20230912192144.3330174-1-milesg@linux.vnet.ibm.com>
 <20230912202514.3382619-1-milesg@linux.vnet.ibm.com>
 <CVJ3HRR2EADR.15F9G78LN7PKL@wheely>
Message-ID: <0fbe0003b26b9f0334912d4bc77561d3@linux.vnet.ibm.com>
X-Sender: milesg@linux.vnet.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rjhGaCxD-xTOk_HupAvueTq_jjGg5ppu
X-Proofpoint-GUID: XQYf4uuw33wcym6dTPOpp8iR6Ca87tZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_12,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190193
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023-09-14 20:20, Nicholas Piggin wrote:
> On Wed Sep 13, 2023 at 6:25 AM AEST, Glenn Miles wrote:
>> Adds migration support for Branch History Rolling
>> Buffer (BHRB) internal state.
>> 
>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
>> ---
>>  target/ppc/machine.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>> 
>> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
>> index b195fb4dc8..89146969c8 100644
>> --- a/target/ppc/machine.c
>> +++ b/target/ppc/machine.c
>> @@ -314,6 +314,7 @@ static int cpu_post_load(void *opaque, int 
>> version_id)
>> 
>>      if (tcg_enabled()) {
>>          pmu_mmcr01a_updated(env);
>> +        hreg_bhrb_filter_update(env);
>>      }
>> 
>>      return 0;
>> @@ -670,6 +671,27 @@ static const VMStateDescription vmstate_compat = 
>> {
>>      }
>>  };
>> 
>> +#ifdef TARGET_PPC64
>> +static bool bhrb_needed(void *opaque)
>> +{
>> +    PowerPCCPU *cpu = opaque;
>> +    return (cpu->env.flags & POWERPC_FLAG_BHRB) != 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_bhrb = {
>> +    .name = "cpu/bhrb",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = bhrb_needed,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINTTL(env.bhrb_num_entries, PowerPCCPU),
> 
> Maybe don't need bhrb_num_entries since target machine should have the
> same?
> 

Removed.

>> +        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
>> +        VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, 
>> BHRB_MAX_NUM_ENTRIES),
> 
> Is it possible to migrate only bhrb_num_entries items? Wants a VARRAY
> AFAIKS but there is no VARRAY_UINT64?
> 
> Since all sizes are the same 32 now, would it be possible to turn it
> into a VARRAY sometime later if supposing a new CPU changed to a
> different size, and would the wire format for the VARRAY still be
> compatible with this fixed size array, or does a VARRAY look different
> I wonder?
> 

I looked into this some more.  It turns out that the UINT32 in 
VARRAY_UINT32
is referring to the size of the field that holds the number of entries 
in
the array, not the size of the array elements.  So, it is possible to do 
this
with the VARRAY_UINT32 type.  I would need to change the type for 
bhrb_num_entries
to a uint32_t and also, since VARRAY_UINT32 requires the array field to 
be a
pointer to an array, I would need to store the address of the array in 
another
field.


> Thanks,
> Nick

Thank you for taking the time to review my code!

Glenn

