Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8967D5AAF
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 20:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvMGD-0004HQ-Cg; Tue, 24 Oct 2023 14:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvMGA-0004H1-PV; Tue, 24 Oct 2023 14:36:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvMG4-0002Zw-A0; Tue, 24 Oct 2023 14:36:10 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OIV1xq006346; Tue, 24 Oct 2023 18:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=aKfFY5OGwS1224jgRb7/d73YMGPrcl9KFZEsty01Xdc=;
 b=cGIHfHSEluCjwtc4pOB/CdDbd7u+QENjsaEeQidd0Ceml3Q4Tqe6mYt/vgagypOXfhMJ
 4cMCDMe9j/tdqY5Gr4NG8wTSxxQgYsiJRwuEWWbMV3XOaeZBaOygF/gGU/d6wKorIi+b
 tGeLJTvC78GNqfay0CQRdNgPJgNm0VOKWtNsb0oJwOur1UD5dRBGfUsq0OYcZTXBv2kS
 kcG8khUZ3T1IcsLO4XnLW3kkT1qssGqT1ozaEtjKQWvKGOBwBMfzpWaFvxCCOwi+2h09
 HidZWGqRHSZEGzrg7rnV31fDWcVAWUxR/E83zRQ4UJcT+kzVrNoFTAjnbrTMhTHWjdye MQ== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txjvsrvxe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 18:35:48 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OIDC9V010315; Tue, 24 Oct 2023 18:35:48 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbyhnq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 18:35:48 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OIZlh213500952
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 18:35:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 790C958061;
 Tue, 24 Oct 2023 18:35:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35E5C58056;
 Tue, 24 Oct 2023 18:35:47 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 18:35:47 +0000 (GMT)
Message-ID: <a8ca6e4e89ec34b68bb246e9d6e4bf5277a42d15.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH] misc/led: LED state is set opposite of what is expected
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, philmd@linaro.org
Date: Tue, 24 Oct 2023 13:35:46 -0500
In-Reply-To: <CAFEAcA9ZLk7XYpjOQ-_9JXELK_qjgW3ABmpHY=aiPa+DS-131A@mail.gmail.com>
References: <20231024173923.4041874-1-milesg@linux.vnet.ibm.com>
 <CAFEAcA9ZLk7XYpjOQ-_9JXELK_qjgW3ABmpHY=aiPa+DS-131A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FyocSLNbGmhtdOJjzIlmrzLUIvYzFrxV
X-Proofpoint-ORIG-GUID: FyocSLNbGmhtdOJjzIlmrzLUIvYzFrxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_18,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1011 spamscore=0 mlxlogscore=512
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310240159
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, 2023-10-24 at 18:46 +0100, Peter Maydell wrote:
> On Tue, 24 Oct 2023 at 18:40, Glenn Miles <milesg@linux.vnet.ibm.com>
> wrote:
> > Testing of the LED state showed that when the LED polarity was
> > set to GPIO_POLARITY_ACTIVE_LOW and a low logic value was set on
> > the input GPIO of the LED, the LED was being turned off when it was
> > expected to be turned on.
> 
> It looks to me from reading the code like the bug is there
> for active-high GPIO as well ?

Yes, this should fix the issue for both situations.

> 
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > ---
> >  hw/misc/led.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/misc/led.c b/hw/misc/led.c
> > index f6d6d68bce..96cad7578e 100644
> > --- a/hw/misc/led.c
> > +++ b/hw/misc/led.c
> > @@ -63,7 +63,7 @@ static void led_set_state_gpio_handler(void
> > *opaque, int line, int new_state)
> >      LEDState *s = LED(opaque);
> > 
> >      assert(line == 0);
> > -    led_set_state(s, !!new_state != s->gpio_active_high);
> > +    led_set_state(s, !new_state != s->gpio_active_high);
> >  }
> 
> Maybe "!!new_state == s->gpio_active_high" would be clearer?
> Then you can see that we are (1) converting the int new_state
> to a bool with the !! idiom and (2) we enable the LED for a
> high input and active-high GPIO.
> 
> thanks
> -- PMM

Yes, I agree,  that is easier to read.  Thanks!

Glenn


