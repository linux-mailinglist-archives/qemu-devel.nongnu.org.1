Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3D77E71DB
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:03:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AHR-00044O-Nl; Thu, 09 Nov 2023 14:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1AHI-00040E-AX; Thu, 09 Nov 2023 14:01:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1AHG-0007kO-9Q; Thu, 09 Nov 2023 14:01:20 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9HJgem015534; Thu, 9 Nov 2023 19:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=fWXjlu/u/tO7gF0K5YzYEeoWa/fM1Nanp0JM0eR9PNc=;
 b=c+YfMO0WNpqT0RJUbfspHbci0IkxQvJbSw8VMCtMRbJ9FwzEOSGAkswB9K+g1MgNSro6
 Ty/D+Vaw+QkqZpZq6NQiiifYdhmmoEeHHe3iWmr4TguMHcLWRvDqlL3zy+yerWKpU85N
 x9NDcaYApxrjoywlKrXWFkC05ghyjoTPPaXcR/bMRJbfPhYN6HsT5j09YUXpRZNGo21+
 SsMHTcQBmL7rvgOo/4aWOXGIvS320C6IdnbWqOEh6h81Tw3EEQR+6fRrtDii0r+yCK/G
 W3qfTDc+JDpGgaH0L68DO5rZ6fbMqkQ128YWUSavmQGPH6+JAwW9dCsD39ejA3CPLMYi 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u93qptxav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 19:01:01 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A9InB4W027325;
 Thu, 9 Nov 2023 19:01:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u93qptxah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 19:01:01 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9GkDVk014372; Thu, 9 Nov 2023 19:01:00 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w225xrq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 19:01:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A9J10Bb46334498
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Nov 2023 19:01:00 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E49BC5805D;
 Thu,  9 Nov 2023 19:00:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B916358052;
 Thu,  9 Nov 2023 19:00:59 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Nov 2023 19:00:59 +0000 (GMT)
Message-ID: <da1784db9f22e09c3bdc4478a9540e708debca15.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] ppc/pnv: Fix potential overflow in I2C model
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat <fbarrat@linux.ibm.com>, Nicholas
 Piggin <npiggin@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 09 Nov 2023 13:00:59 -0600
In-Reply-To: <20231109171525.1129353-1-clg@kaod.org>
References: <20231109171525.1129353-1-clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j0z8XLK9kffHX0rMlWZIqQvrxdlY8kZX
X-Proofpoint-GUID: O2YNscRx54ObuBe1XJMgiIfxJFJqOMaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=903 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311090138
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Thu, 2023-11-09 at 18:15 +0100, Cédric Le Goater wrote:
> Coverity warns that "i2c_bus_busy(i2c->busses[i]) << i" might
> overflow
> because the expression is evaluated using 32-bit arithmetic and then
> used in a context expecting a uint64_t.
> 
> While we are at it, introduce a PNV_I2C_MAX_BUSSES constant and check
> the number of busses at realize time.
> 
> Fixes: Coverity CID 1523918
> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
> 
>  v2: - check PNV_I2C_MAX_BUSSES in realize
>      - removed extra space before cast.
> 
>  hw/ppc/pnv_i2c.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> index f75e59e70977..483d91d15a77 100644
> --- a/hw/ppc/pnv_i2c.c
> +++ b/hw/ppc/pnv_i2c.c
> @@ -151,6 +151,7 @@
>  #define I2C_RESET_S_SDA_REG             0x11
> 
>  #define PNV_I2C_FIFO_SIZE 8
> +#define PNV_I2C_MAX_BUSSES 64
> 
>  static I2CBus *pnv_i2c_get_bus(PnvI2C *i2c)
>  {
> @@ -437,7 +438,7 @@ static uint64_t pnv_i2c_xscom_read(void *opaque,
> hwaddr addr,
>      case I2C_PORT_BUSY_REG: /* compute busy bit for each port  */
>          val = 0;
>          for (i = 0; i < i2c->num_busses; i++) {
> -            val |= i2c_bus_busy(i2c->busses[i]) << i;
> +            val |= (uint64_t)i2c_bus_busy(i2c->busses[i]) << i;
>          }
>          break;
> 
> @@ -641,6 +642,11 @@ static void pnv_i2c_realize(DeviceState *dev,
> Error **errp)
> 
>      assert(i2c->chip);
> 
> +    if (i2c->num_busses > PNV_I2C_MAX_BUSSES) {
> +        error_setg(errp, "Invalid number of busses: %u", i2c-
> >num_busses);
> +        return;
> +    }
> +
>      pnv_xscom_region_init(&i2c->xscom_regs, OBJECT(i2c),
> &pnv_i2c_xscom_ops,
>                            i2c, "xscom-i2c", PNV9_XSCOM_I2CM_SIZE);
> 

Thanks, Cédric.  Looks good to me!

Reviewed-by: Glenn Miles <milesg@linux.vnet.ibm.com>


