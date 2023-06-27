Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9703A73FFE7
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 17:40:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEAmW-0003eY-FH; Tue, 27 Jun 2023 11:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qEAmU-0003cG-Bv; Tue, 27 Jun 2023 11:39:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qEAmS-0004dX-91; Tue, 27 Jun 2023 11:39:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35REd3Zf007112; Tue, 27 Jun 2023 15:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=C9XtCg7ib6Y1so2sFbQZ4q+7D9uO9H50xx2zsF5d9XM=;
 b=U+hZJG8Zmy84QA4zQSHUya4VAR5Xy/jhjOmGmxBnPZ70qCYjfATtzuJ+XaZ9J/DBZoj0
 PBFz200T2L0n7pobo+zpEFcFiaZ246QVsCHemovaDu5fMOnYR/0xutOtVpExj4QMbqbP
 VRUUE+Q7f9GmO560CNWgxSEev+vgfc8iZUXHhROh3V5BRpQ1EcKTCieQg/b965WJ9Y3i
 p81JeAUbZxFD25qnhxUhsZilHnocTl4J2gFhCrJqYEO5xwsOAqjrhfVo6y35aQ4Azvaq
 TXRQmf6mttxaU1jtEcN9rcNLVeOeRc2qfgMn7XG9X8Dl61G99NHieWX3SR5Wbleu4ptk og== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfrdt9bd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 15:38:57 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35RFctmN020253
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 15:38:55 GMT
Received: from [10.111.135.140] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 27 Jun
 2023 08:38:54 -0700
Message-ID: <16bc062c-f479-54b2-1435-f4ce53e30f2f@quicinc.com>
Date: Tue, 27 Jun 2023 16:38:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: add PCIe node into DT
To: Peter Maydell <peter.maydell@linaro.org>
CC: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 <qemu-devel@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>,
 <qemu-arm@nongnu.org>
References: <20230626075207.623535-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA-K_2SLxbq90TpUyzLpiC0U2WVJe7ffaC_TH66K-=GV4A@mail.gmail.com>
 <b26c98d3-3e9f-331e-acbd-ae0c451e0ed3@quicinc.com>
 <CAFEAcA_rg4CbE1Y9mTQmPs_KBqb-S=3Z5Hh78gbVUD6R7DR0hg@mail.gmail.com>
 <d8e93b7b-5e86-5e26-21cd-fefb76f88204@quicinc.com>
 <CAFEAcA8L--h_3QvKff66mw3VG7G__hwv=syw2hU2Qby8jkJPRw@mail.gmail.com>
From: Leif Lindholm <quic_llindhol@quicinc.com>
In-Reply-To: <CAFEAcA8L--h_3QvKff66mw3VG7G__hwv=syw2hU2Qby8jkJPRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: rxwCvJcb6RHxlKTCBZ1EQyZc8RwvAXlS
X-Proofpoint-GUID: rxwCvJcb6RHxlKTCBZ1EQyZc8RwvAXlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270143
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2023-06-27 15:27, Peter Maydell wrote:
>> Serious question: would it be preferable if we moved to a custom DT node
>> where we stick everything in as KEY=VALUE pairs to reduce this confusion?
> 
> I don't really mind, I just want it to be clear what is going on here
> so that when I'm reviewing patches I have a design I can keep in mind.

No, I totally understand that. I'm just feeling that the call we made to 
use DT to pass this information tends to put everyone's mind into the 
wrong state when reviewing.

> The way this was presented to me originally, at least as I recall
> it, was "this board will work the way that real hardware does, ie
> the firmware knows what hardware it was built for".
 >
> In that
> setup QEMU doesn't need to tell the firmware anything, except
> a very limited set of things which it's more convenient to have
> flexible and specifiable on the QEMU command line, like number of
> CPUs and size of RAM. And that's what the comments in the source say
> at the moment:
> 
> /*
>   * Firmware on this machine only uses ACPI table to load OS, these limited
>   * device tree nodes are just to let firmware know the info which varies from
>   * command line parameters, so it is not necessary to be fully compatible
>   * with the kernel CPU and NUMA binding rules.
>   */
> 
> So that's the design I've been implicitly reviewing these changes
> against.

I still agree fully with the above. But possibly I meant less by what I 
said than you heard. Human language, eh?

The only things that *need* hardcoding really are:
- What (family of) platform(s) is this? (sbsa-ref)
- Start of Secure memory.
- Start of Non-secure memory.
- Mechanism by which to receive platform configuration data that might
   differ at runtime.

Admittedly, using QEMU gives us more flexibility than would be likely in 
a real platform - like specifying any supported CPU that can access the 
whole address map. A real platform would be very unlikely to have 
runtime detection for everything from Cortex-A57 to Neoverse-N2 - but 
it's genuinely useful for our (non-platform-specific) firmware 
development to be able to do that.

> It is pretty surprising to me to hear that in real-world systems
> the firmware is not built to know exactly where its UART, USB
> controller, etc are and that it is instead asking some board
> management controller chip for all this information and being
> fully-flexible in the firmware that runs on the application CPU,
> but I have zero experience in that area so that's just my
> lack of knowledge speaking.

As an example, in said previous design we were prototyping having the 
ability to hold PCIe space inside 48 bits (to work with non-LPA2-aware
operating systems utilising 4k pages) and having a software-configurable 
option to expand into 52 bits (enabling more space for both DRAM and 
PCIe), where an LPA2-aware (or 64k-paged) OS was used.

The addresses (from the application processor's perspective) of certain 
other i/o blocks were also ultimately decided by a microcontroller 
programming the CMN. So even if we "decided" on locations for them and 
stuck to those for simplicity, they weren't actually hard-wired.

> If there's a standard/common protocol for how the BMC communicates
> that info to the application-CPU firmware then it might be
> less confusing to use it, I guess. But I'm not inherently
> opposed to putting this stuff in a dtb-format blob.

Not really. If anything I'm hoping to inspire standardisation along 
those axes by having libraries available to just plug in.

> (Side note: is the commit message line "Trusted Firmware will
> read it and provide to next firmware level." intended to
> mean "TF will take this dtb node and pass it on", or merely
> "TF will take the information in this dtb node and use
> it to construct or modify the ACPI tables it passes to the
> next level"?)

The latter.
We're kind of working our way backwards towards the design we ultimately 
want, so the DT was originally placed in NS DRAM since that let us reuse 
more of the mach-virt code in edk2 rather than needing to rewrite 
everything to get anything working.

Now we're getting versioning in place, we will eventually deprecate that 
and move the DT to Secure DRAM, dropping access to it for Non-secure 
firmware. But we never exposed the DT to the OS as a configuration 
table, it was always used to generate the bits of ACPI that weren't just 
hardcoded.

/
     Leif



/
     Leif



