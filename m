Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5097AD7C6
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 14:13:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkkRy-00057u-R5; Mon, 25 Sep 2023 08:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1qkkRu-00057e-Cp
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 08:12:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1qkkRs-0002HT-1J
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 08:12:25 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38PBdG1L020538
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 12:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=JbUtwG7KpZKI+I+NM1KXgmphHyrHWU9cXY7C7s1L9mk=;
 b=EbZVmwvdBqBlsy97eo2mxP+MikE/Eb3E3FCN1A8ICINX9V5WCdAciBsphuMD+kPhqPHy
 oQ9vuVyuRRhmUF4YsLBwlnQMzD61aEfR0UMj/jJYC8HvYMSczTXjd2756Be1CAHae/0o
 t1AP6a8uSprVGPpYq6w1TOVRe0ObUFF/Vp4xNxV6cCq/6fRzDgfqXT8Vno8Pno8xCuDu
 4KZ64ybZggzyXhaU9+XGGQrqoBvmr4RQgM0+wwnQoV05aeEhDxHx7RV0GqL4SuL89Xpw
 LPJbfa8teAcNC4LMrZm70GcctAMFhy+Hjc6WUijKbikrvUd4po3T3zawYtCXvqam/gMn sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ta53qtgq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 12:12:20 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38PBpHa5029710
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 12:12:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ta53qtgpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 12:12:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38PBSPH7008192; Mon, 25 Sep 2023 12:12:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabbmsx9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 12:12:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38PCCJwV33424112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Sep 2023 12:12:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E5F858058;
 Mon, 25 Sep 2023 12:12:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0447B58057;
 Mon, 25 Sep 2023 12:12:18 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.144.155])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Sep 2023 12:12:17 +0000 (GMT)
Message-ID: <db47b1e842d94994d0844021a4ab5423c9525a83.camel@linux.ibm.com>
Subject: Re: [PATCH v6 2/2] tpm: add backend for mssim
From: James Bottomley <jejb@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Date: Mon, 25 Sep 2023 08:12:16 -0400
In-Reply-To: <b2d53350-ce67-4c29-5d3d-6dee6484c8ed@linux.ibm.com>
References: <20230109161532.6892-1-jejb@linux.ibm.com>
 <20230109161532.6892-3-jejb@linux.ibm.com> <87bkduwxv7.fsf@pond.sub.org>
 <2629ce63-e4dd-67f3-6341-d477c39b29f7@linux.ibm.com>
 <ZQ2QdBr1a90RX7Wm@redhat.com>
 <b2d53350-ce67-4c29-5d3d-6dee6484c8ed@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dfJa09kDNpWbuoh0yQTWm1XW8Yse4KGa
X-Proofpoint-ORIG-GUID: cfb7kBj0VFCbQtBjCTp5fby_NH3ZgeYh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_08,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jejb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Fri, 2023-09-22 at 09:27 -0400, Stefan Berger wrote:
> 
> On 9/22/23 09:02, Daniel P. Berrangé wrote:
> > On Fri, Sep 22, 2023 at 08:41:19AM -0400, Stefan Berger wrote:
> > > On 9/22/23 02:00, Markus Armbruster wrote:
> > > > Found this cleaning out old mail, sorry for missing it until
> > > > now!
> > > > 
> > > > I think we owe James a quick decision wether we're willing to
> > > > take the feature.  Stefan, thoughts?
> > > I thought we discusses it back then. Does it handle snapshotting
> > > and migration correctly?
> > To quote the patch itself:
> > 
> >    +The mssim backend supports snapshotting and migration, but the
> > state
> >    +of the Microsoft Simulator server must be preserved (or the
> > server
> >    +kept running) outside of QEMU for restore to be successful.
> 
> How does 'it' support snapshotting where the state of the TPM can be 
> completely different depending on the snapshot?

In the same way we support things like external disk devices across
snapshot and migration: it's up to the owner of the device to preserve
the state for the next resume. If you muck with the state (or connect
the wrong device) all bets are off.

>   I know what it took to support this feature with swtpm/libtpms but
> I don't see the equivalent here in this backend driver nor in the TCG
> reference code that the underlying TPM 2 simulator is based upon.
> 
> I do not want to stand in the way of it being merged but please 
> understand that I will also neither maintain nor fix bugs related to
> it nor its related underlying simulator -- with James being the
> maintainer of it, this should be clear. I have reason why I am saying
> this and they come from dealing with the upstream TPM 2 reference
> code.

I already said I'll support this, and added a Maintainers entry and a
specific exclusion from your TPM maintainer entry. I'm not sure what
additional assurances I can give?

James





