Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F73748952
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 18:36:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5UR-0003kM-Bv; Wed, 05 Jul 2023 12:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_tsoni@quicinc.com>)
 id 1qH5UO-0003d5-TM
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:36:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_tsoni@quicinc.com>)
 id 1qH5UM-0003ug-PL
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:36:24 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 365AxQsS027164; Wed, 5 Jul 2023 16:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1LkpsqZt0ahDlMcRJ/hQzznlhXlQT9KyKKQXVy+VVwA=;
 b=j0BV13rcXKoF92RwQihBfFAEeHa7RdeD7UM8ElWHHD6KpLXTEGlbdnRg7HKikvcW6XFh
 ifcYgx4HDFOEEhS4SIw5NicnRH7ATXQk74/nkMt3rpiM7SFw7/PELq+INyhfrWnKEHWv
 tX9lCzdrs2NbCDqKvIrs+5fMMhs0eg0lVzTokNPphYFya6yH7odZH0VSC7WRjJ8uUoyW
 o+tJqwm6MNKlRNrg2SNhVgStap8UBFZ/zozvF7H0cU1Po64+itFEYRQc1VIhzhhKXf2a
 ukUXlZT+89ZT16FD6FA/I8JLL+lXy4j5YPpySdMWHAv6Ng/TewnkuUaIU+ir7mAoNJIS Ig== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn2w59crs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 16:35:16 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com
 [10.52.223.231])
 by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 365GZF4X011338
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 5 Jul 2023 16:35:15 GMT
Received: from [10.110.49.233] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 5 Jul
 2023 09:35:15 -0700
Message-ID: <d2976893-5079-aade-0b9b-8135aa1ef44a@quicinc.com>
Date: Wed, 5 Jul 2023 09:35:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] virtio: add a new vcpu watchdog
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, zhanghao1
 <zhanghao1@kylinos.cn>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <qemu-devel@nongnu.org>
References: <20230705081813.411526-1-zhanghao1@kylinos.cn>
 <87fs62fp7f.fsf@linaro.org>
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <87fs62fp7f.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: nrGYaYwMLBlZiQUtAluHweW9DCiF7ecs
X-Proofpoint-GUID: nrGYaYwMLBlZiQUtAluHweW9DCiF7ecs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_08,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050149
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_tsoni@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/5/2023 6:42 AM, Alex Bennée wrote:
> 
> zhanghao1 <zhanghao1@kylinos.cn> writes:
> 
>> Each vcpu creates a corresponding timer task. The watchdog
>> is driven by a timer according to a certain period. Each time
>> the timer expires, the counter is decremented. When the counter
>> is "0", the watchdog considers the vcpu to be stalling and resets
>> the VM. To avoid watchdog expiration, the guest kernel driver
>> needs to periodically send a pet event to update the counter.
>>
>> Signed-off-by: zhanghao1 <zhanghao1@kylinos.cn>
>> ---
>> v2:
>>   - change the function name and remove the redundant word 'stall'
>>   - add trace-events to replace DPRINTF and qemu_log
>>   - call 'watchdog_perform_action()' to reset vm
>>   - update g_new0 to replace malloc
>>   - update only use '.generic_name'
>>   - update the bool variable 'is_initialized' to uint32_t
>>
>> v1: https://lore.kernel.org/qemu-devel/20230615061302.301754-1-zhanghao1@kylinos.cn/
> <snip>
>> +static void virtio_vcpu_watchdog_device_realize(DeviceState *dev, Error **errp)
>> +{
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> +    vwdt = VIRTIO_VCPU_WATCHDOG(dev);
>> +
>> +    virtio_init(vdev, VIRTIO_ID_WATCHDOG, 0);
> 
> This will never compile because VIRTIO_ID_WATCHDOG isn't defined
> anywhere.
> 
> Next time you post you need to also include a link to the kernel side of
> the driver and the virtio specification (or inflight patch for it).


Is this similar to vcpu stall based watchdog driver submitted and merged 
in kernel.org (by Google) sometime back?

---Trilok Soni


