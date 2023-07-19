Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E287597C5
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:10:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7sT-0007Ns-D8; Wed, 19 Jul 2023 10:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qM7sQ-0007NQ-MF; Wed, 19 Jul 2023 10:10:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qM7sO-00042v-Ov; Wed, 19 Jul 2023 10:10:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JDbJvl013634; Wed, 19 Jul 2023 14:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0KmfabzjhOn5UCCJSCezurO04QKFf2o400HLrSE0m3g=;
 b=Q/gfwfWyFEaysnC2Gl3thnLkfSnKjNkiKaDo0ZL2Ogipx8oZIdkZOX6Pwm3YBO4q48Aj
 g7lDU7Edmd0bNa42tnBygQi4cbjOoLk7Duxd/CZo9tDLHxoJYeW9GHvcJ1/vGKbiY14y
 Je/78XBf53by/IE363egPhgiMoy3qYtOPePgFL8bHLEZQMqDPTNMT71gVP4BfRHMQpFa
 GJhDxGXsgEhkr29gyQzbGDNkPewrxxXmpr6S9Dw+Pwd5Kcp43E4Kma2BLWguFmWaPe/Q
 jHL69GRjluM2HYqmA7HiOgAR0Y/el40ZBF4HgVz6SByDaBJZyHuQCngforaGMnBhrARE 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxfmhtxta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 14:09:49 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JE6V7B020991;
 Wed, 19 Jul 2023 14:09:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxfmhtxrx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 14:09:49 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JCjmmj003362; Wed, 19 Jul 2023 14:09:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65xj0pj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 14:09:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36JE9g1J63766958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 14:09:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7EAA2004B;
 Wed, 19 Jul 2023 14:09:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FC0B20040;
 Wed, 19 Jul 2023 14:09:42 +0000 (GMT)
Received: from [9.155.200.205] (unknown [9.155.200.205])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 19 Jul 2023 14:09:42 +0000 (GMT)
Message-ID: <96099107-b944-2582-df6a-4a4b90c0ade7@linux.ibm.com>
Date: Wed, 19 Jul 2023 16:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v21 17/20] tests/avocado: s390x cpu topology test
 dedicated CPU
Content-Language: en-US
From: Pierre Morel <pmorel@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, nsg@linux.ibm.com, frankja@linux.ibm.com,
 berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-18-pmorel@linux.ibm.com>
In-Reply-To: <20230630091752.67190-18-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q81rPUorOO4rPFcvsM87e_N70So87tI5
X-Proofpoint-GUID: WZ8RPug4fCR3JHnVG7U5s5DXa2NSOXJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_09,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pmorel@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Same as for the previous test.

I rewrite this to check the guest view.


On 6/30/23 11:17, Pierre Morel wrote:
> A dedicated CPU in vertical polarization can only have
> a high entitlement.
> Let's check this.
>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   tests/avocado/s390_topology.py | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
> index 4855e5d7e4..cba44bec91 100644
> --- a/tests/avocado/s390_topology.py
> +++ b/tests/avocado/s390_topology.py
> @@ -287,3 +287,31 @@ def test_entitlement(self):
>           self.check_topology(1, 0, 0, 0, 'medium', False)
>           self.check_topology(2, 1, 0, 0, 'high', False)
>           self.check_topology(3, 1, 0, 0, 'high', False)
> +
> +    def test_dedicated(self):
> +        """
> +        This test verifies that QEMU modifies the entitlement change correctly
> +        for a dedicated CPU after several guest polarization change requests.
> +
> +        :avocado: tags=arch:s390x
> +        :avocado: tags=machine:s390-ccw-virtio
> +        """
> +        self.kernel_init()
> +        self.vm.launch()
> +        self.wait_until_booted()
> +
> +        self.system_init()
> +
> +        res = self.vm.qmp('set-cpu-topology',
> +                          {'core-id': 0, 'dedicated': True})
> +        self.assertEqual(res['return'], {})
> +
> +        self.check_topology(0, 0, 0, 0, 'high', True)
> +
> +        self.guest_set_dispatching('1');
> +
> +        self.check_topology(0, 0, 0, 0, 'high', True)
> +
> +        self.guest_set_dispatching('0');
> +
> +        self.check_topology(0, 0, 0, 0, 'high', True)

