Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 444D47AC1BA
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 14:12:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qk1Sx-0007YW-Iu; Sat, 23 Sep 2023 08:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qk1Sw-0007YO-0L
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 08:10:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qk1Sl-0000Fp-NO
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 08:10:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38NC8iZj021828; Sat, 23 Sep 2023 12:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : reply-to : mime-version : content-type;
 s=qcppdkim1; bh=i1MRs4P4IjQ7cQ0pnYEq6StIXN06UTp4ZSCg6c28uJM=;
 b=CAPryrzP8Rh4Sl+i5AdzDNXJRS75ypXiDJg+IkTKVivY4ezr5OaacUunM3lalI1RRtM3
 vQRepaV77g5sxCqtLdOcQNw66l0WHVbl0qWgUTo8+Z91maxu6+631jM+VIp0JSRYJq8X
 D3Tmoa0YYhSSUKakdE2BA7K2Hijn0yIosdutSvGFeu//iBLkJjXGGuK8um/zml1GcH0s
 6ip0RWBzmW8ExjNdM//SL3iVQZh45D0cbKpVYNxAIsTVHTgep/q3MJOZ98O1RljO3NAY
 27MIRaknqBoDUQGLbRGzqme/D+DN+zNS6zBKgm+kz4h65vbWvs2y0CdyVshunczlkNwe vQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9rsq0ppf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 Sep 2023 12:10:15 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38NCAFfr025480
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 Sep 2023 12:10:15 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sat, 23 Sep
 2023 05:10:13 -0700
Date: Sat, 23 Sep 2023 17:40:09 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, <quic_svaddagi@quicinc.com>
Subject: Question on Qemu flash driver - pflash_cfi01
Message-ID: <20230923121009.GD552050@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 8agTkHtzHsv2UjpaeCrc31_7rch8z3hS
X-Proofpoint-ORIG-GUID: 8agTkHtzHsv2UjpaeCrc31_7rch8z3hS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-23_09,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 mlxlogscore=494 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309230101
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

cfi01 driver initializes a rom device with ops represented by pflash_cfi01_ops.

static const MemoryRegionOps pflash_cfi01_ops = {
    .read_with_attrs = pflash_mem_read_with_attrs,
    .write_with_attrs = pflash_mem_write_with_attrs,
    .endianness = DEVICE_NATIVE_ENDIAN,
};


    memory_region_init_rom_device(
        &pfl->mem, OBJECT(dev),
        &pflash_cfi01_ops,
        pfl,
        pfl->name, total_len, errp);

This region is also mapped in guest address space. For ex: hw/arm/virt.c does
that by:

virt_flash_map1() {

    memory_region_add_subregion(sysmem, base,
		sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
}

It is not clear to me under what circumstance would the callbacks listed in
pflash_cfi01_ops be invoked. Is rom device memory supposed to be of trap/emulate
type, so that guest read of that memory will get trapped and handled by ops
listed in pflash_cfi01_ops? I see that a hypervisor accelerator's memory
listener callback gets notified of that memory range and appears to be
registering that as "read-only" memory. A read of that memory range from guest
need not necessarily cause a trap for example, in which case when would
pflash_mem_read_with_attrs get invoked?

- vatsa

