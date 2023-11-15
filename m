Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8867EC13E
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 12:25:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3E0a-0008H0-Ra; Wed, 15 Nov 2023 06:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1r3E0Z-0008GN-01
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 06:24:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1r3E0W-0008Ax-2u
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 06:24:34 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFAU7LD000720
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 11:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zRl5g8xUJlCTC3uBuBOekVFbPyx99Z+Ce/1Zwo3PSkI=;
 b=SYjx5Z3yUcTejsUyAgTPXm0Gsqdrn3O3RudZb2g8+7nXCdy9kgwDMGAmpOo+QRr/w5P3
 9HhM3FAcJ13pylOekKnuu9P5eY/NaUerxNVwPX80j24BR6HiimrBtkWYZnDuDUnfxhTH
 tRT6zzxN2sCqJq2s3QfG+YolabtKxikbvR8kUpxjRnsd5zyhAYa+k1FaxY/jUGo6tz0Q
 IzyguwxJ4ACTt2IWsXmRvvOYePcv3nfNrJohEP45JSr/sUhxjfvenpZBo8oMVH3ioXpb
 4R7ddElSwUXrDffMJGo0cJZtabNiDUBl7ys3MMEus8CdKro6gtV16g5G2wkQMc5fPUzS RA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucuac0bpj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 11:24:25 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AFBOHRU002899
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 11:24:17 GMT
Received: from [10.110.118.25] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 03:24:16 -0800
Message-ID: <509b4103-02ed-437b-018e-44fd4250ce05@quicinc.com>
Date: Wed, 15 Nov 2023 12:24:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/virtio-gpu: Fix test_vhost_user_vga_virgl
 for edid support
To: <qemu-devel@nongnu.org>
References: <20231114203456.319093-1-thuth@redhat.com>
Content-Language: en-US
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <20231114203456.319093-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 1e0D2u8-X1Zxan9QyHFm_2Swiy-GYDDY
X-Proofpoint-GUID: 1e0D2u8-X1Zxan9QyHFm_2Swiy-GYDDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_10,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

On 14/11/2023 21:34, Thomas Huth wrote:
> The "edid" feature has been added to vhost-user-gpu in commit
> c06444261e20 ("contrib/vhost-user-gpu: implement get_edid feature"),
> so waiting for "features: +virgl -edid" in the test does not work
> anymore, it's "+edid" instead of "-edid" now!
> 
> While we're at it, move the expected string to the preceeding
> exec_command_and_wait_for_pattern() instead (since waiting for
> empty string here does not make too much sense).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>

> ---
>   tests/avocado/virtio-gpu.py | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/avocado/virtio-gpu.py b/tests/avocado/virtio-gpu.py
> index 89bfecc715..6091f614a4 100644
> --- a/tests/avocado/virtio-gpu.py
> +++ b/tests/avocado/virtio-gpu.py
> @@ -149,10 +149,8 @@ def test_vhost_user_vga_virgl(self):
>               # TODO: probably fails because we are missing the VirGL features
>               self.cancel("VirGL not enabled?")
>           self.wait_for_console_pattern("as init process")
> -        exec_command_and_wait_for_pattern(
> -            self, "/usr/sbin/modprobe virtio_gpu", ""
> -        )
> -        self.wait_for_console_pattern("features: +virgl -edid")
> +        exec_command_and_wait_for_pattern(self, "/usr/sbin/modprobe virtio_gpu",
> +                                          "features: +virgl +edid")
>           self.vm.shutdown()
>           qemu_sock.close()
>           vugp.terminate()

