Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92444746D83
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:34:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcPq-0001zP-A6; Tue, 04 Jul 2023 05:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGcPn-0001yM-JB; Tue, 04 Jul 2023 05:33:43 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGcPl-00072W-FW; Tue, 04 Jul 2023 05:33:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 15300746361;
 Tue,  4 Jul 2023 11:33:21 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DAD1E74635C; Tue,  4 Jul 2023 11:33:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D8C61746335;
 Tue,  4 Jul 2023 11:33:20 +0200 (CEST)
Date: Tue, 4 Jul 2023 11:33:20 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 03/13] ppc440: Add a macro to shorten PCIe controller
 DCR registration
In-Reply-To: <e42417b6-e4d1-5137-85d6-837dd438d862@linaro.org>
Message-ID: <1dee5084-261c-9698-2251-b82a00cd0c39@eik.bme.hu>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <e8ae82b0b6c10e48acbc297fa15d9e5f4befc9d2.1688421085.git.balaton@eik.bme.hu>
 <e42417b6-e4d1-5137-85d6-837dd438d862@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-18609294-1688463200=:43117"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-18609294-1688463200=:43117
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 4 Jul 2023, Philippe Mathieu-Daudé wrote:
> On 4/7/23 00:02, BALATON Zoltan wrote:
>> It is more readable to wrap the complex call to ppc_dcr_register in a
>> macro when needed repeatedly.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/ppc440_uc.c | 76 +++++++++++++++++-----------------------------
>>   1 file changed, 28 insertions(+), 48 deletions(-)
>
>
>> +#define PPC440_PCIE_DCR(s, dcrn) \
>> +    ppc_dcr_register(&(s)->cpu->env, (s)->dcrn_base + (dcrn), s, \
>
> '(s), \'

The parenthesis here would be superfluous as it stands alone in a function 
parameter between commas so no matter what you substitue here should not 
have an unwanted side effect (unless it has a comma but that's an error 
anyway) so maybe this is not needed.

>> +                     &dcr_read_pcie, &dcr_write_pcie)
>> +
>> +
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks for the quick review, I'll post a v2 in a few days to wait a bit if 
anobody else has any other request.

Regards,
BALATON Zoltan
--3866299591-18609294-1688463200=:43117--

