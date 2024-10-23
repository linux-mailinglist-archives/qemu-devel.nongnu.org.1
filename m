Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B4C9ACB7F
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Oct 2024 15:43:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bdU-00006Z-Ct; Wed, 23 Oct 2024 09:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1t3bdS-00005k-M3
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:42:50 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1t3bdR-000694-1p
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:42:50 -0400
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
 by m0050095.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 49NBYpRa007494; Wed, 23 Oct 2024 14:42:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=H8cH7QROsfTcKDV96gsOlv8ktjv5KqtXBTNSWtzgLgU=; b=OEgwl7ASwszy
 wo44c2POXcPWGTth+nzBOJwcJzfXNPh440waCeP1yrYvRb2nHrlqi/eVIh39NpLo
 PqFFzIXJTC8xtUtLe7/D5j4G32SUNA58Pnns0iFgw2nQOpo+Wc5FE3FJGePbB5O6
 uaMfasQi+1W8Eux3r3/V9KBZfCMVLCdsW047d0JYyPWMNxZwfEUcZJmibdIo9VIt
 XskVPOaQ0qG8Ul4HYUXzwYTjjeQPs2u+cPaHtYuGkMCN9igRkNLEpH6oSPGyyTWS
 KPTcsQM/Rx0L5L9+kVYLH4b+sRjTHdEEdHLj0JaNJvxJWs1Kgs8Xc4sgIEVZOt3x
 odqwr9V0Cg==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18]
 (may be forged))
 by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 42em2c9d76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 14:42:24 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 49ND9RNa020481; Wed, 23 Oct 2024 09:42:23 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 42emm3kr4e-1;
 Wed, 23 Oct 2024 09:42:23 -0400
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com
 [172.27.97.51])
 by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 99426341AE;
 Wed, 23 Oct 2024 13:42:21 +0000 (GMT)
Message-ID: <8d6e9e80-d496-4420-a346-618545dc66e7@akamai.com>
Date: Wed, 23 Oct 2024 08:42:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
From: Michael Galaxy <mgalaxy@akamai.com>
To: Yu Zhang <yu.zhang@ionos.com>
Cc: Sean Hefty <shefty@nvidia.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 Wangjialin <wangjialin23@huawei.com>
References: <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com> <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com> <Zvrq7nSbiLfPQoIY@x1n>
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
 <ZvsAV0MugV85HuZf@x1n> <c24fa344-0add-477d-8ed3-bf2e91550e0b@akamai.com>
 <Zv8P8uQmSowF8sGl@x1n> <6211c525-0b9b-4eba-ac3c-2ac796c8ec83@akamai.com>
 <CAHEcVy7_WveokcN+3J2Qqxg8oJ1BT8sNoU2qUHeU8oZWwVyS6g@mail.gmail.com>
 <856d4f0e-8742-4848-acc5-dbaa5d21c9fd@akamai.com>
Content-Language: en-US
In-Reply-To: <856d4f0e-8742-4848-acc5-dbaa5d21c9fd@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_11,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230081
X-Proofpoint-ORIG-GUID: 0yRC9-lsUM8Lkc3bRu8WfrbJ8YmfcOFf
X-Proofpoint-GUID: 0yRC9-lsUM8Lkc3bRu8WfrbJ8YmfcOFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230082
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=mgalaxy@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi All,

This is just a heads up: I will be changing employment soon, so my 
Akamai email address will cease to operate this week.

My personal email: michael@flatgalaxy.com. I'll re-subscribe later once 
I have come back online to work soon.

Thanks!

- Michael

On 10/7/24 08:45, Michael Galaxy wrote:
> Hi,
>
> On 10/7/24 03:47, Yu Zhang wrote:
>> !-------------------------------------------------------------------|
>>    This Message Is From an External Sender
>>    This message came from outside your organization.
>> |-------------------------------------------------------------------!
>>
>> Sure, as we talked at the KVM Forum, a possible approach is to set up
>> two VMs on a physical host, configure the SoftRoCE, and run the
>> migration test in two nested VMs to ensure that the migration data
>> traffic goes through the emulated RDMA hardware. I will continue with
>> this and let you know.
>>
> Acknowledged. Do share if you have any problems with it, like if it 
> has compatibility issues
> or if we need a different solution. We're open to change.
>
> I'm not familiar with the "current state" of this or how well it would 
> even work.
>
> - Michael
>
>
>> On Fri, Oct 4, 2024 at 4:06 PM Michael Galaxy <mgalaxy@akamai.com> 
>> wrote:
>>>
>>> On 10/3/24 16:43, Peter Xu wrote:
>>>> !-------------------------------------------------------------------|
>>>>     This Message Is From an External Sender
>>>>     This message came from outside your organization.
>>>> |-------------------------------------------------------------------!
>>>>
>>>> On Thu, Oct 03, 2024 at 04:26:27PM -0500, Michael Galaxy wrote:
>>>>> What about the testing solution that I mentioned?
>>>>>
>>>>> Does that satisfy your concerns? Or is there still a gap here that 
>>>>> needs to
>>>>> be met?
>>>> I think such testing framework would be helpful, especially if we 
>>>> can kick
>>>> it off in CI when preparing pull requests, then we can make sure 
>>>> nothing
>>>> will break RDMA easily.
>>>>
>>>> Meanwhile, we still need people committed to this and actively 
>>>> maintain it,
>>>> who knows the rdma code well.
>>>>
>>>> Thanks,
>>>>
>>> OK, so comments from Yu Zhang and Gonglei? Can we work up a CI test
>>> along these lines that would ensure that future RDMA breakages are
>>> detected more easily?
>>>
>>> What do you think?
>>>
>>> - Michael
>>>

