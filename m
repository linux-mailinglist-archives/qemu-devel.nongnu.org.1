Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D425F738CB1
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 19:08:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC1IJ-0007CU-JB; Wed, 21 Jun 2023 13:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qC1IE-0007CA-3Q
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 13:06:54 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qC1IC-0006wK-Dp
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 13:06:53 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mgvj3-1pbagH2ZCv-00hJs4; Wed, 21 Jun 2023 19:06:48 +0200
Message-ID: <7538c78f-37dc-0b15-8245-dead0ec0bd88@vivier.eu>
Date: Wed, 21 Jun 2023 19:06:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 05/24] q800: move CPU object into Q800MachineState
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <20230621085353.113233-6-mark.cave-ayland@ilande.co.uk>
 <eaa9eb9e-1a1f-82a6-7daa-3fe547f59c24@eik.bme.hu>
 <be3b7427-5f76-76af-d47a-d2f233357349@ilande.co.uk>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <be3b7427-5f76-76af-d47a-d2f233357349@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wSWccEmf9jQxe9wZgNeNnrMqaw8WWccUOl6ZhSgV4488f62RHrF
 MO/9udzfl1I5Zf5+RRclCyxTGGQ4yx0JG1asbjHLZxAqCdUj6aud8nEvcDMMLxdrO6m/fAB
 eMjn4mT6Qc6T1HFiWD2gOa+LiAXtA2Iy36COB5j6e+fdbsBtSgl95QpB2+RfDAPSfYuHCTx
 Ar5ZKJBqxHqpMZyOA8nKA==
UI-OutboundReport: notjunk:1;M01:P0:nIAlxlqo3+k=;sXWerpfGGEo4JFO+WWVbv+ByblW
 XOv0RiZjRcQ8jUgV+yYQj6/X5/+C5EqetSnIbFw/zOf1m79LGKa1HtY5uJxwrndHJXc9IN2tK
 anb+NCMdoJUT0WDfV1Hm2PyvOYgT3teDshL3sfZWJQHjXsRHug8JsTq30yS5Tqsq4QbjAQLb7
 Y1l8BEV/Sx4mfj3ZzIv/svTrpoyEmZsvK+iS92Eikp6X+OMQHUxAyEr7Rgm75GGI7AEjAaMZY
 TRM3F65ThIFpyy4JytbGkoVqV3qazlgJq17d/XekbD1sSqpsrTUkVgMHmKX0r04kgPWQaehAG
 jEtltpozv6ys2j74QCktF+7nshpeQi5rdOH9ASEGxxShQMqI1Hge2dkvYl2ZBO7mP3uQrj1nm
 swe/Xu1VbMoOu0SFtcmQQJrertWBrYGV2oacXi1mN6YkjMzUTTfF+VjgJ/fXehaT0v5moQKkL
 iXaBdCVidNti7oyAtH8ycS/A53eWk4UQhFW6Ez5z1b0UEeW1FYE/5oXcZlws6bHFcceSW8YYg
 +OU4FtTuLBrIdyhwhP1UXlkN9t8EuBP3r0I/LNjpjb5U6zHABlkW9M/3U7b1SMZPqDbLYmp5A
 G+zi0uq07s7OXNegdNGFFPnLob0CLWe20/KsJCPlSbDCDOzfDoPnwFOpsWahu5XVreyuCY7E/
 YplUiv2J0g965x2z3UgtkA519fnhVqKDmFDjlUap/w==
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 21/06/2023 à 16:28, Mark Cave-Ayland a écrit :
> On 21/06/2023 12:56, BALATON Zoltan wrote:
> 
>> On Wed, 21 Jun 2023, Mark Cave-Ayland wrote:
>>> Also change the instantiation of the CPU to use object_initialize_child()
>>> followed by a separate realisation.
>>
>> Also seems to restrict valid CPU types but not mentioned in commit message. Should this patch be 
>> split up?
> 
> Hmmm good point. Laurent, would you like me to split this into a separate patch or would updating 
> the commit message be sufficient?

I'm going to merge the series. Could you send me the update of the commit message?

Thanks,
Laurent


