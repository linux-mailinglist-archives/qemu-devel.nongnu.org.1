Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 604057CB4F0
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 22:57:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsUcu-0007Lh-1o; Mon, 16 Oct 2023 16:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qsUcr-0007LO-Gn; Mon, 16 Oct 2023 16:55:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qsUcp-0005F2-2N; Mon, 16 Oct 2023 16:55:45 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GKjUZF005343; Mon, 16 Oct 2023 20:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=BdIloZlCB6Un0WsQCfsYhWXmbyrlWWV1g/TKAwEHp14=;
 b=LJT3WH3q2yRitFuOndAoNE/Df/qLF+rHRhb4XUcviLxQ4WeNpx7LTGZnwg1/JerHQXxf
 dFQMUu3iOovTSuww8qjn42zwC7RApMXhLRA/DAyVc9yjiJETKugYCNuj0J1iw0Zhn9RE
 KWIXEEMxA8FnERGwxjwcLrYDbsuNbnSF55yO8n2IJpIhYOYQphC1Mc35zbARsmxWydk7
 ZYSFTYlRSmghBUCQBUlR9ha+9CEspkBky+yAwOYvsa/8ol5BBy/LRgnWDKgAvEUSWR/V
 YJ6ZbrJnbZG020XQtrS34VPqwtTvTAdkKkKW+N34GeQp4EWCXqGn1NDAeOqfPxlg1Tdd WA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tscg5gd5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 20:55:33 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GKjmnr006985;
 Mon, 16 Oct 2023 20:55:32 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tscg5gd5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 20:55:32 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GIwRvj030719; Mon, 16 Oct 2023 20:55:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr7hjb410-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 20:55:32 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39GKtVQl20185820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 20:55:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6158458058;
 Mon, 16 Oct 2023 20:55:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E51E658059;
 Mon, 16 Oct 2023 20:55:30 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Oct 2023 20:55:30 +0000 (GMT)
Message-ID: <24edab4dde9a02341378b49babce49dc56b74c1c.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] ppc/pnv: Add an I2C controller model
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com
Date: Mon, 16 Oct 2023 15:55:30 -0500
In-Reply-To: <31467531-ed8c-507e-1a39-3271fa375e59@linaro.org>
References: <20231012200851.3020858-1-milesg@linux.vnet.ibm.com>
 <20231012200851.3020858-2-milesg@linux.vnet.ibm.com>
 <31467531-ed8c-507e-1a39-3271fa375e59@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yCmJSW5WOlcCLonH9eg7xrrOf1MRX9Pp
X-Proofpoint-ORIG-GUID: w79C7OqUMlHxAn6hvQzE0V48pGqQdW8V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310160182
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

On Fri, 2023-10-13 at 10:58 +0200, Philippe Mathieu-Daudé wrote:
> Hi Glenn, Cédric,
> 
> On 12/10/23 22:08, Glenn Miles wrote:
> > From: Cédric Le Goater <clg@kaod.org>
> > 
> > The more recent IBM power processors have an embedded I2C
> > controller that is accessible by software via the XSCOM
> > address space.
> > 
> > Each instance of the I2C controller is capable of controlling
> > multiple I2C buses (one at a time).  Prior to beginning a
> > transaction on an I2C bus, the bus must be selected by writing
> > the port number associated with the bus into the PORT_NUM
> > field of the MODE register.  Once an I2C bus is selected,
> > the status of the bus can be determined by reading the
> > Status and Extended Status registers.
> > 
> > I2C bus transactions can be started by writing a command to
> > the Command register and reading/writing data from/to the
> > FIFO register.
> > 
> > Not supported :
> > 
> >   . 10 bit I2C addresses
> >   . Multimaster
> >   . Slave
> > 
> > Signed-off-by: Cédric Le Goater <clg@kaod.org>
> > [milesg: Split wiring to powernv9 into its own commit]
> > [milesg: Added more detail to commit message]
> > [milesg: Added SPDX Licensed Identifier to new files]
> > [milesg: updated copyright dates]
> > [milesg: Added use of g_autofree]
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > ---
> > 
> > Changes in v2:
> >      - Updated copyright dates
> >      - Removed copyright paragraph (replaced by SPDX-License-
> > Identifier)
> >      - Added use of g_autofree
> > 
> >   hw/ppc/meson.build         |   1 +
> >   hw/ppc/pnv_i2c.c           | 673
> > +++++++++++++++++++++++++++++++++++++
> >   include/hw/ppc/pnv_i2c.h   |  38 +++
> >   include/hw/ppc/pnv_xscom.h |   3 +
> >   4 files changed, 715 insertions(+)
> >   create mode 100644 hw/ppc/pnv_i2c.c
> >   create mode 100644 include/hw/ppc/pnv_i2c.h
> > +/* I2C mode register */
> > +#define I2C_MODE_REG                    0x6
> > +#define I2C_MODE_BIT_RATE_DIV           PPC_BITMASK(0, 15)
> > +#define I2C_MODE_PORT_NUM               PPC_BITMASK(16, 21)
> > +#define I2C_MODE_ENHANCED               PPC_BIT(28)
> > +#define I2C_MODE_DIAGNOSTIC             PPC_BIT(29)
> > +#define I2C_MODE_PACING_ALLOW           PPC_BIT(30)
> > +#define I2C_MODE_WRAP                   PPC_BIT(31)
> > +static I2CBus *pnv_i2c_get_bus(PnvI2C *i2c)
> > +{
> > +    uint8_t port = GETFIELD(I2C_MODE_PORT_NUM, i2c-
> > >regs[I2C_MODE_REG]);
> > +
> > +    if (port >= i2c->num_busses) {
> 
> Can we sanitize in pnv_i2c_xscom_write() instead ...?

Hi Phil,

Thanks for taking a look.  You have a good question!  I tried reading
through the spec that I have in order to see how the hardware reacts to
an invalid port number being written to the mode register and didn't
find anything obvious.

If we did what you suggest, how do we prevent attempts from accessing
an invalid bus?  The options I see are:

1) Do an assert on the port value being valid so invalid port values
result in the process dieing.  Uses the big hammer, but simple to
implement and exposes problems early on.

2) Fail the xscom write.  There doesn't seem to be an easy way to
notify software of the xscom write failure, and xscom write failures
probably shouldn't happen as long as we are writing to a correct xscom
address.

3) Allow the xscom write, but prevent writing an invalid port value. 
Simple, but hides the failure and will probably lead to less obvious
failures down the road.

Do you have other suggestions?  Honestly, I don't like any of these
options, but if I had to pick one, I'd probably choose option 1.  Even
though it's the sledge hammer approach, it prevents access of an
invalid bus, and exposes the error early on.

Cedric's approach allows for the invalid port values to be written to
the register which is, IMHO, most likely what the hardware would do. 
However, it does look like there are some areas where we do not handle
getting a NULL pointer from pnv_i2c_get_bus() correctly.  For example,
i2c_bus_busy() doesn't check for NULL and yet we are passing the return
value of pnv_i2c_get_bus into that function without checking it.

So, after looking into this a bit, I think I prefer Cedric's approach
with the addition of auditing all of the places where pnv_i2c_get_bus()
is called and handling the NULL case better.

Of course, I may have missed something and look forward to other
suggestions as well.

Thanks,

Glenn

> 
> > +        qemu_log_mask(LOG_GUEST_ERROR, "I2C: invalid bus number
> > %d/%d\n", port,
> > +                      i2c->num_busses);
> > +        return NULL;
> > +    }
> > +    return i2c->busses[port];
> > +}
> > +static void pnv_i2c_xscom_write(void *opaque, hwaddr addr,
> > +                                uint64_t val, unsigned size)
> > +{
> > +    PnvI2C *i2c = PNV_I2C(opaque);
> > +    uint32_t offset = addr >> 3;
> > +
> > +    switch (offset) {
> > +    case I2C_MODE_REG:
> 
> ... here?
> 
> > +        i2c->regs[offset] = val;
> > +        if (i2c_bus_busy(pnv_i2c_get_bus(i2c))) {
> > +            i2c->regs[I2C_STAT_REG] |= I2C_STAT_INVALID_CMD;
> > +            qemu_log_mask(LOG_GUEST_ERROR, "I2C: command in
> > progress\n");
> > +        }
> > +        break;
> 
> [...]
> 
> Regards,
> 
> Phil.


