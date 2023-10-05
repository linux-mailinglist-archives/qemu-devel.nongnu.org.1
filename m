Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 923B47BAA2C
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 21:30:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoU1g-0006IX-IX; Thu, 05 Oct 2023 15:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1qoU1V-0006G6-7M
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 15:28:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1qoU1H-0001d0-DW
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 15:28:36 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 395JHHWt022109; Thu, 5 Oct 2023 19:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=X/3WTW8Cz4uLBx40NmApIR+PWOfYV6k+PzjeQAwplnE=;
 b=XczvuxQEA+wMO2zLV7UH6Y2hNpudolZqzt5eWYzqhWUvOZzFIiZ9Z7z0v442NceOL/2x
 ptYiS02+pwaFiTtEG472hORc4n1Wj1dsTIMJ4ernpVUjbM4TXh4U994d2Y8PI6FaMYmT
 rUy0ANwDpC8sWDjvYFJplt7XRDV/DPEVywxv4ZoBG0g8ov/K62q8eTEMH3Lsoxr3I06G
 6HSC2sAQ0IUIv3naNglzjvyS3BQqxdV4uheth8iZlj/kmWN7BgCr6vnMPzjJRoXO9mna
 /Of3oYc/n5PMi6LpMXojI2Nsd3+G4MTy8NdOjJtncNBy6U5j0a+mWTgcySb5EfF7H4Eu 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj35urakg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 19:28:15 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395JITCI025625;
 Thu, 5 Oct 2023 19:28:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj35urajf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 19:28:15 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 395JAQ8k007460; Thu, 5 Oct 2023 19:28:13 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3teygm9my5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 19:28:13 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 395JSDAR39780976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Oct 2023 19:28:13 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28D3C58059;
 Thu,  5 Oct 2023 19:28:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E645458062;
 Thu,  5 Oct 2023 19:28:11 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.80.55])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Oct 2023 19:28:11 +0000 (GMT)
Message-ID: <6a10457659617e1cc37e8545640a4698a79766d7.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/2] tpm: add backend for mssim
From: James Bottomley <jejb@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Daniel P ." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Date: Thu, 05 Oct 2023 15:28:10 -0400
In-Reply-To: <efc8219a-5207-69a3-9b5f-49040b812f33@linaro.org>
References: <20231004184219.6594-1-jejb@linux.ibm.com>
 <20231004184219.6594-3-jejb@linux.ibm.com>
 <afab0b07-51b4-81e5-2e7f-03099a7be858@linaro.org>
 <6a9b9967d1f94d423aa87e6da007d8b3c3f08d31.camel@linux.ibm.com>
 <efc8219a-5207-69a3-9b5f-49040b812f33@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eN1po3J0cHzzkapXsm4X8h8ztVCCr-NG
X-Proofpoint-ORIG-GUID: Wkp1YsVhiwJrWFV1MTb8iQEedTIDvDr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_14,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 mlxlogscore=534 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050148
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jejb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: jejb@linux.ibm.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, 2023-10-05 at 18:11 +0200, Philippe Mathieu-Daudé wrote:
> On 5/10/23 15:57, James Bottomley wrote:
> > On Thu, 2023-10-05 at 08:49 +0200, Philippe Mathieu-Daudé wrote:
> > > On 4/10/23 20:42, James Bottomley wrote:
> > > > From: James Bottomley <James.Bottomley@HansenPartnership.com>
[...]
> > > > +.. code-block:: console
> > > > +
> > > > +  qemu-system-x86_64 <qemu-options> \
> > > > +    -tpmdev
> > > > "{'type':'mssim','id':'tpm0','command':{'type':'inet','host':'r
> > > > emot
> > > > e','port':'2321'},'control':{'type':'inet','host':'remote','por
> > > > t':'
> > > > 2322'}}" \
> > > > +    -device tpm-crb,tpmdev=tpm0
> > > 
> > > Did you test running this command line on a big-endian host?
> > 
> > Well no, big endian machines are rather rare nowadays.  However,
> > since the QIOChannelSocket abstraction is based on SocketAddress,
> > which is a qapi wrapper around strings, what makes you think the
> > endianness would matter?
> 
> You use ntoh/hton in tpm_mssim_handle_request(), so I wonder about
> the 'uint32_t cmd' in tpm_send_ctrl().

tpm_send_ctrl has a htonl for the send control command as well (The TPM
server is always network ordered, i.e. big endian).  The reason it
doesn't have one for the receive is that it only checks against zero
which is endian invariant, if that's what you're asking?

James


