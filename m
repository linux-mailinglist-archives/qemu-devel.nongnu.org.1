Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E0F7424F1
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 13:26:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpmu-0007dW-Me; Thu, 29 Jun 2023 07:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qEpmp-0007cm-QG; Thu, 29 Jun 2023 07:26:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qEpmn-0000PA-GH; Thu, 29 Jun 2023 07:26:07 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35TBH61o018252; Thu, 29 Jun 2023 11:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xNdyPHkh+eztG3S4AeVluT1wXK8sG0XxoU9BuaKlgvw=;
 b=aSEIjGH1Ya/j76gh6NRlHO21F1K2jqnXAaiodoPt30Rhe+BM9SlTLe5YnQhX0i12FAAT
 HHoc72spH0yqTdhhPOK2F1rKaLLDX06MmcgXW0ZxzKQrcyTakR92EvpqyGZ7/vXDAWyX
 rccZxOwT9NqfFePMKrho+Bu8Evtt2YLbLUdULoQ2oweuZm+AvddKrtjq6Ez2BaUX8qes
 8N6PAWKiEqCutgnZEv4cOPNZmj9IaF2XXrYxdmx/FX87P7awZkvGk5dcs4Lfr83l/wyC
 iQ4LaY+B7sClr3bLtzxgonqHfQXoaN7y+4bOhGmI8XwZVV39K9p84rCr8K9DATqbIlzR hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rh8xs85pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jun 2023 11:26:01 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35TBHwOU020537;
 Thu, 29 Jun 2023 11:26:01 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rh8xs85nj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jun 2023 11:26:00 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35T5rNf7016157;
 Thu, 29 Jun 2023 11:25:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3rdr452f81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jun 2023 11:25:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35TBPtTJ43123230
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 11:25:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52D3B2004D;
 Thu, 29 Jun 2023 11:25:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D29120049;
 Thu, 29 Jun 2023 11:25:55 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jun 2023 11:25:54 +0000 (GMT)
Date: Thu, 29 Jun 2023 13:25:53 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v3 7/7] pc-bios/s390-ccw: Don't use __bss_start with the
 "larl" instruction
Message-ID: <20230629132553.74fb709d@p-imbrenda>
In-Reply-To: <8bee7886-9b63-c7e9-6bc4-3ad8f6ce037a@redhat.com>
References: <20230629104821.194859-1-thuth@redhat.com>
 <20230629104821.194859-8-thuth@redhat.com>
 <20230629125818.09ec8ad6@p-imbrenda>
 <8bee7886-9b63-c7e9-6bc4-3ad8f6ce037a@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CtngKWqBM3fkUeMRblbHpKaJQsXR9hWt
X-Proofpoint-GUID: bRZQ1KtT0_0S3XAniL3wdtg_W6Ebd9LI
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 spamscore=0 mlxlogscore=971 lowpriorityscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290099
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 29 Jun 2023 13:12:26 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 29/06/2023 12.58, Claudio Imbrenda wrote:
> > On Thu, 29 Jun 2023 12:48:21 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> start.S currently cannot be compiled with Clang 16 and binutils 2.40:
> >>
> >>   ld: start.o(.text+0x8): misaligned symbol `__bss_start' (0xc1e5) for
> >>       relocation R_390_PC32DBL
> >>
> >> According to the built-in linker script of ld, the symbol __bss_start
> >> can actually point *before* the .bss section and does not need to have
> >> any alignment, so in certain situations (like when using the internal
> >> assembler of Clang), the __bss_start symbol can indeed be unaligned
> >> and thus it is not suitable for being used with the "larl" instruction
> >> that needs an address that is at least aligned to halfwords.
> >> The problem went unnoticed so far since binutils <= 2.39 did not
> >> check the alignment, but starting with binutils 2.40, such unaligned
> >> addresses are now refused.
> >>
> >> Fix it by loading the address indirectly instead.  
> > 
> > what are the advantages of this solution compared to your previous one
> > (i.e. align .bss) ?  
> 
> __bss_start is supposed to point to an address that is before all bss-like 
> segments. There are also segments like .sbss and .bss.plt on other 
> architectures, see https://bugzilla.redhat.com/show_bug.cgi?id=2216662#c11 .
> Seems like we don't have them on s390x yet, so currently my previous patch 
> is fine, too. But in case there will ever be an extension to the s390x ABI 
> that introduces such additional segments, we have to switch back to 
> __bss_start again. So it sounds slightly more future-proof to me to keep 
> __bss_start here, even if we need a slightly more complex startup code here now.

fair enough

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> 
>   Thomas
> 
> 


