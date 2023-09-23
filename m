Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5577AC3DE
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 19:12:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qk6AN-0005xc-Qz; Sat, 23 Sep 2023 13:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qk6AJ-0005xM-Ke
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 13:11:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qk6AH-0006E6-MS
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 13:11:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38NHBRD5018254; Sat, 23 Sep 2023 17:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=FIpLfEdRjJHHs2knvTXywu+7vxANYdLgXcmoYU9A0Ww=;
 b=SH2ucd3XNNttEpbSXKdzpTKLKxIW72zpy2pUiZHUyNTz1kRl2Rrq0JvX5R14DIMHDdW0
 sDEctMbsKEZe07pnlRKXN1rq9mCIjrEk2hPzbsQthI/ix3Hx2odF/E/IhRWNGUsLdRas
 nMDgFJIX9Z1re0yJYArVE6vyJKWBFKvOteVZb9rmQnOlSXg3zSlLdpFlKlafc2EVz9WI
 h2MNLG+vtKOO1UrVCZve5TIeefZk5q1zza/O35dbZtJtHVs7m/0EtVWNz/iNRYKV0ZAG
 rz79PAvaptxS5hSH1FqIt9LsjPz6PVmfEdDG/cs+aaGPbKyz0IMnrOhTb+lv0Me3Qytj 9A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9pyw94pe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 Sep 2023 17:11:27 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38NHBQ5w025928
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 Sep 2023 17:11:26 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sat, 23 Sep
 2023 10:11:25 -0700
Date: Sat, 23 Sep 2023 22:41:21 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
Subject: Re: Question on Qemu flash driver - pflash_cfi01
Message-ID: <20230923171121.GE552050@quicinc.com>
References: <20230923121009.GD552050@quicinc.com>
 <CAFEAcA_vyJyrg3oK8XEnoS3ZDE6BNKUXJALKPi8-VEKXA9j=Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_vyJyrg3oK8XEnoS3ZDE6BNKUXJALKPi8-VEKXA9j=Ug@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: ITGv5898iCoNwJlYf_QKr12W2e_5WpSa
X-Proofpoint-ORIG-GUID: ITGv5898iCoNwJlYf_QKr12W2e_5WpSa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-23_15,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 spamscore=0
 mlxlogscore=938 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309230145
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

* Peter Maydell <peter.maydell@linaro.org> [2023-09-23 13:39:55]:

> On Sat, 23 Sept 2023 at 13:11, Srivatsa Vaddagiri
> <quic_svaddagi@quicinc.com> wrote:
> >
> > cfi01 driver initializes a rom device with ops represented by pflash_cfi01_ops.
> >
> > static const MemoryRegionOps pflash_cfi01_ops = {
> >     .read_with_attrs = pflash_mem_read_with_attrs,
> >     .write_with_attrs = pflash_mem_write_with_attrs,
> >     .endianness = DEVICE_NATIVE_ENDIAN,
> > };
> >
> >
> >     memory_region_init_rom_device(
> >         &pfl->mem, OBJECT(dev),
> >         &pflash_cfi01_ops,
> >         pfl,
> >         pfl->name, total_len, errp);
> >
> > This region is also mapped in guest address space. For ex: hw/arm/virt.c does
> > that by:
> >
> > virt_flash_map1() {
> >
> >     memory_region_add_subregion(sysmem, base,
> >                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
> > }
> >
> > It is not clear to me under what circumstance would the callbacks listed in
> > pflash_cfi01_ops be invoked. Is rom device memory supposed to be of trap/emulate
> > type, so that guest read of that memory will get trapped and handled by ops
> > listed in pflash_cfi01_ops? I see that a hypervisor accelerator's memory
> > listener callback gets notified of that memory range and appears to be
> > registering that as "read-only" memory. A read of that memory range from guest
> > need not necessarily cause a trap for example, in which case when would
> > pflash_mem_read_with_attrs get invoked?
> 
> A "rom device" is (as described in
> https://www.qemu.org/docs/master/devel/memory.html) a device which
> works like RAM for reads (directly accessing a region of host memory),
> but like MMIO for writes (invoking a callback).
> 
> ROM devices also have two modes:
>  (1) "romd mode" is the default; as above, reads go to memory,
>      and writes go to the write function in the MemoryRegionOps
>  (2) "romd mode disabled" means that both reads and writes
>      go to the functions in the MemoryRegionOps
> The device can use memory_region_rom_device_set_romd() to
> switch between these.
> 
> For the pflash devices, we use these so that in normal
> circumstances, execution and reading from the flash is fast.
> But the guest still has the ability to reprogram the flash
> (by writing commands to it); when the guest is programming the
> flash, reads from the device don't return the flash data, they
> return command responses. So when the guest starts programming
> the flash, the device puts itself into "romd disabled" mode,
> so that it can handle the read accesses correctly. Once the
> programming has finished it can switch back into romd mode again.

Ah ok ..its clear to me now.

I see that when romd_mode is false, accelerators like KVM remove memory
mapping so both read/writes trap, which matches what you describe above.

Thanks!
vatsa

