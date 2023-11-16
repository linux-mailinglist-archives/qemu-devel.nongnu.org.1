Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D517EE2B4
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 15:23:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3dGC-00081E-A5; Thu, 16 Nov 2023 09:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r3dG9-00080i-Bi
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:22:21 -0500
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com
 ([40.107.93.66] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r3dG6-00048d-Ut
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:22:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3cI8hAmKfGU4JNA0HmjZcAWYGDClM3bwzqk8h3phX0t/pjWJ1MKLBV0/P/vnnm0YILKlkLBSenAL2RJaBb/RctnmyYt4ABqBeFYhSSNeI2SVOghwR7/Y3CJBngxLxXy5nMKAw8zjWBabS0Od25+xyxSZeooSp3WfXgNG5i3X67P00TqNE2Lk1fx6s1rf25BoM5PdZ25RRyLx4QVJASkrCx/bSsFaPIPuyLAcoks5+vj7HZ1pto0MLd/W3ZGntIVBohMB9gMPyLvIM2NzdlNJjNSBl+8MnHd+htSwRf4ZLEKanTIy4LI5wPOzL+yiBuzcSe5gCKruJmY16zO22tbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EW7qb4TPKKJpO61tfzfPQT31Pax5UFnM8EeqZVGxvvs=;
 b=nbQjGMstrSLPYy2HcnzqWChXaafDRs/zqF5kIBB2x9chX47J2SXkKVwbqPGriANQXCjpo/e/LJN8MK21Ijm2pzlp9rGPsEVyHxZsFPHdkpGI4zXv2vhMTyvFoU3QK+AoSdcFxfDwGjHaZi/z/4Rs7pg/OPOb5wli3XStyTen/Sx61UCDExM0D+uZ9PCJRr4+imOgMRhKh9lyfnfpzYspd1sYM9AtcaA5lmjs50LZQVDAOnNKC8DCOjZ4jsModH19YRDeKtiDzI2ZarFMmPfF9yS/7YUfzVIG2w+F/TUr7yyKfW0ZVt9B9EW/V+GetZDBZkwGOHB/NGwOBvuiIeySag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW7qb4TPKKJpO61tfzfPQT31Pax5UFnM8EeqZVGxvvs=;
 b=QhlDIgyWIWhSqQonJ9z7eIUb0cEGfrDb5vtsp+cjZ5yLN/ihjBXVUV8M1CLJUHqkr7vPhYe4p0VlUpVEXGQ3DaSouavhGTLiQSq3XC7P4DwoQe9LsffT0S/9AnIq3qFJ4j4l37Tw10Tb2kt+XbbjWI8JnNqZl6/ItG5T0mWwpG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 14:17:11 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b%7]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 14:17:11 +0000
Message-ID: <9282e81c-51a6-46be-bcfa-dfec2f04a817@amd.com>
Date: Thu, 16 Nov 2023 15:17:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2] hw/net/can/xlnx-zynqmp: Avoid underflow while
 popping TX FIFO
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>,
 Anton Kochkov <anton.kochkov@proton.me>, Qiang Liu <cyruscyliu@gmail.com>
References: <20231115151711.89170-1-philmd@linaro.org>
From: Francisco Iglesias <francisco.iglesias@amd.com>
In-Reply-To: <20231115151711.89170-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0323.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::11) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7ac252-7da2-48c5-cfc8-08dbe6aeb92d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvhJg/Z2wMg4hwC/h3jE2zJQ9cnbYfzyaAa6RcpRfY9m/QmcZ9W1bAGvzWV61ds9q/l0PQxZcXVCaUW+JUEF/2UHItM/VvHrcP1ew5nES8Spp4oQ1qCwyjBxx2tfxD9d1cDO691dZxn4xt+tdRzhdB60t+70UCba6B3sVSldvbdphpOQt/xBAKaooln4jSBO5n8B6slFTasKmlIrmtFWBXUrd0ob2vKxzmfnzl/9VQZoZ8nBuiWxkwNKkTKnWQgm/Hi5oEtJp/cIfnSq/XQLcrrXMqapKt6TLNa9X+kHgNybp6pFKb2mWPYPZwCq0lTkH5CcoHJ8ZhKK9sTTne6o6K6IOCSagsr813DUOVGcPZqEUR97JXeAt116CAvdoBqOXVcOamwgLW9cWykDmi/snool3V0qpd7Po7vCFnx3ogabdGlDNqZXmJCEriEs88JNncUum/jzyNza6moyYRxwYPpFjTxflLzbMVKHnJm+FwyZCFd/H5NWW200P1a8KSRUd4yBizbYUSAVm1KBR7jlar1OQ3ZC2LTRnBrkzuL5JmboRZHMrScSDfA9IPvKl7pa7mIHN7JzkAqDhXnsL4aIDt1N4Wb3VwIokDBv+zd8wv27zd7pTj2wOy4rxWhGm5MfP25+yB54cBpS4Z4UXwYwSdn4ddxMddGe+5vUAAEIKNv8pWNhOuAC5wJ/yw/NU3C0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(66946007)(66476007)(54906003)(66556008)(38100700002)(86362001)(31696002)(83380400001)(26005)(36756003)(6506007)(6512007)(2616005)(53546011)(6666004)(2906002)(966005)(4001150100001)(316002)(6486002)(5660300002)(8676002)(4326008)(8936002)(478600001)(44832011)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1dpeTF6VHJoVCs2UUFEWHQ0VVlOakY1dkhpWWc2SlVKeHRxdHJiOEFEUmlG?=
 =?utf-8?B?aFl0ajNJVWw4ZkR2cjJYSTV4aXkxNFpGdGw3OHVmT1IxdHVyRjNyN2ZRbUxv?=
 =?utf-8?B?Q29TNWhvRjk1SEs0Sjk0Mno3RnpQWnRLWnl3VmdaMnZKR2djMGErNkVWUGlm?=
 =?utf-8?B?dkJPNjVLRFplRXFTSEtpRC9lZHZ0eUYrSDJPa0FKdmw3OXBaU004Q1VEQmwy?=
 =?utf-8?B?OXJQTjVkL0ViRjk5TXA3UmxGZHBJSnNnMUsrcm04U2hoMGV1SWJXd3ZuSmJJ?=
 =?utf-8?B?MTZ6ZWU5bkpSSHZmWGZDWGJkK1VzclFtK0VDY2t2dXFBMW5Oc0VtR1dRMmk4?=
 =?utf-8?B?VThFcnBnNjVBbnE1Nk1vdEdPR1BqaUZZYUdYNjUzdktyTi9CWk42Sk92QW5M?=
 =?utf-8?B?VndSZ09rZ2F3UUg5TFRJR0VpZVpOOG5hbU04blhobVpiUHp1TmhZcjJIY1o2?=
 =?utf-8?B?OWhNelFhc2hQTllmbkZJV2xLOVV6S1hrOGZqY3pweFJsN0FSM0dCRW1tak92?=
 =?utf-8?B?QzFybEEzcVNZOE40RXpjbnRrT2RjeHdTc2RnTS9MOWNNWUxyQXhXektNeVlO?=
 =?utf-8?B?NTE2WFZJNFNrZmh3c2UxOEtoQ0NucUlSTUNTNUc5Ry9oc3ZBanhzd2xPYmRN?=
 =?utf-8?B?eVI5SU5HalJERTJ0TGdmbFpCcWhuY1ZHUXoyOU80SmxTbXpYc1NvMURMSVZ5?=
 =?utf-8?B?UmRTSFpBWkFQdXVISzNIQ3FEcms5YjAyWWFDcUp6S1czV0VYQVk5Z290WXlp?=
 =?utf-8?B?SzB4WS9HeTVDeWlveXh5ekFMZ2JKelVoOUtTZzBacXFxbXI1dUtJTERvRkRE?=
 =?utf-8?B?NzY1bVJGY2lORHptaDlVdlFwWExDVjRvUlNGMDhpYkJPUXBFK0t0L2RrWnRa?=
 =?utf-8?B?TjlSVDhKKzloMXpIVWUyclk2Q2pET25MS2VsdmdVRTd1cXowQTV3eHZsSFpY?=
 =?utf-8?B?aEEzTUx6aVZ6bllBM1RtbHdBVzdPb1pIVTVpY3FFbDF3bnVQdVBzcWdHTEVD?=
 =?utf-8?B?WWRXZnVvbTJnZndzc09xR0NQU2wvU2k1NW1qME1Kd3F1akJKbGlpRnJEYzFE?=
 =?utf-8?B?WlRPYmdrSURBQlN6SmxvUS9OYzlsLzBFR2xacXJKUVZpVkFKN1VWVHhDU1BQ?=
 =?utf-8?B?cHBSYTViR0h6a0pLT3M3aGtiakdDekZIWVB6aEZmOVJ0VExsUDVqQ3oxSEdP?=
 =?utf-8?B?K3J0Qk04ZTN4Z3A4YXpQV1RZaHhKc2FKcDd3eGRqSjFmckU4eVB0akpFRm43?=
 =?utf-8?B?ejlLNTh3K3pTZmpuS01UMXR2bStsNGQ1OWROeHdUYWJoVVc4aHl1MTBBUWtz?=
 =?utf-8?B?TXpNWnJ6eXpwSjRkYzlwTWxwT0lWY0J2ODRTWXZBdUUxNjFveHpOOWljZzhH?=
 =?utf-8?B?TlJRelcyczRzV001L2R5WEZrVXdCbzBSdld3RkUyc2tEMDZkSHhRUSt2c01Q?=
 =?utf-8?B?YnhBOE1GWTFaZmdJc2o2OFJrcUp3OHhYbEh6eUdkTkQwUUhvLzJ3Mnh6WDBK?=
 =?utf-8?B?cDJ3OFpXS3gxYVQybExPMklJb3ZMaFB1dVhHVFhXWGkxc1F2RzgvQ3JTaWwy?=
 =?utf-8?B?eGViS3d4N0pmQ0FLRkJzSHY2NGtJMXRFMjlOcTluVkRuMlRoWk04MHQ2UkhW?=
 =?utf-8?B?bWpVODRidWR4bXVON3Z2QzVoY21vUG42RWZvdUw0MDJraWJZUFNiTTRBSFFp?=
 =?utf-8?B?N0xpa2RmamNIdXo3N3JsWVc4ZGdmTm5qT0tWVlpvMVhKNVpzUVZWSzRkYVR3?=
 =?utf-8?B?NHB3MEN2OHRjcXBVcUVkaDJCWGhBL25hL3MwMUdET2JlcHJaWE5BSWhLSUg5?=
 =?utf-8?B?VkdpNStScGttOE5tQktUcldueUE0eGpnTWc1RHlHMkRtOVhmQmE5VjA3OFJT?=
 =?utf-8?B?ZVdlRnZDSXZ2UU82UVo0RlZQRm1qTUVJa1RUODFjR3lPZDJRSmtvYUtzWmpu?=
 =?utf-8?B?WHFrMFlDLzBiNXAxbWtZenkwVHR1anJWajA1RkFFVTlsNGVhRHA0ZStQWWRm?=
 =?utf-8?B?KzUyVDN2WEZkM0EyNk5Oc2NTOWFwTEpEQmZRUVFldy9hK2ExalVtWlBwTFFv?=
 =?utf-8?B?eDRaYTBoOFFZNTl3YnQ2VG1NSUFidjB6a1hNTGRwaktLWjcvTXQza0psK1h2?=
 =?utf-8?Q?kwMxcEuG/WJOmX9RlhyjD4mFw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7ac252-7da2-48c5-cfc8-08dbe6aeb92d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 14:17:11.1138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrFeXUvBAW5Fx3fR6jcaDk8UYWkjaGhaAyfbx3xnDI7fA0Zc72lyqMD7vKhbkTPb0zgiz6ry7qL+PohRKE5edw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190
Received-SPF: softfail client-ip=40.107.93.66;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Hi Philippe, good catch!

On 2023-11-15 16:17, Philippe Mathieu-Daudé wrote:
> Per https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Message-Format
> 
>    Message Format
> 
>    The same message format is used for RXFIFO, TXFIFO, and TXHPB.
>    Each message includes four words (16 bytes). Software must read
>    and write all four words regardless of the actual number of data
>    bytes and valid fields in the message.
> 
> There is no mention in this reference manual about what the
> hardware does when not all four words are written. To fix the
> reported underflow behavior when DATA2 register is written,
> I choose to fill the data with the previous content of the
> ID / DLC / DATA1 registers, which is how I expect hardware
> would do.
> 
> Note there is no hardware flag raised under such condition.
> 
> Reported-by: Qiang Liu <cyruscyliu@gmail.com>
> Fixes: 98e5d7a2b7 ("hw/net/can: Introduce Xilinx ZynqMP CAN controller")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1425
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Tested with the CAN tests from 'make check-qtest-aarch64'
> ---
>   hw/net/can/xlnx-zynqmp-can.c | 49 +++++++++++++++++++++++++++++++++---
>   1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
> index e93e6c5e19..58938b574e 100644
> --- a/hw/net/can/xlnx-zynqmp-can.c
> +++ b/hw/net/can/xlnx-zynqmp-can.c
> @@ -434,6 +434,51 @@ static bool tx_ready_check(XlnxZynqMPCANState *s)
>       return true;
>   }
>   
> +static void read_tx_frame(XlnxZynqMPCANState *s, Fifo32 *fifo, uint32_t *data)
> +{
> +    unsigned used = fifo32_num_used(fifo);

For the case when there are multiple frames in the fifo we need to swap 
above to:

unsigned used = fifo32_num_used(fifo) > CAN_FRAME_SIZE ? 0 : 
fifo32_num_used(fifo);

With above minor modification:

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

Best regards,
Francisco

> +    bool is_txhpb = fifo == &s->txhpb_fifo;
> +
> +    assert(used > 0);
> +    used %= CAN_FRAME_SIZE;
> +
> +    /*
> +     * Frame Message Format
> +     *
> +     * Each frame includes four words (16 bytes). Software must read and write
> +     * all four words regardless of the actual number of data bytes and valid
> +     * fields in the message.
> +     * If software misbehave (not writting all four words), we use the previous
> +     * registers content to initialize each missing word.
> +     */
> +    if (used > 0) {
> +        /* ID, DLC, DATA1 missing */
> +        data[0] = s->regs[is_txhpb ? R_TXHPB_ID : R_TXFIFO_ID];
> +    } else {
> +        data[0] = fifo32_pop(fifo);
> +    }
> +    if (used == 1 || used == 2) {
> +        /* DLC, DATA1 missing */
> +        data[1] = s->regs[is_txhpb ? R_TXHPB_DLC : R_TXFIFO_DLC];
> +    } else {
> +        data[1] = fifo32_pop(fifo);
> +    }
> +    if (used == 1) {
> +        /* DATA1 missing */
> +        data[2] = s->regs[is_txhpb ? R_TXHPB_DATA1 : R_TXFIFO_DATA1];
> +    } else {
> +        data[2] = fifo32_pop(fifo);
> +    }
> +    /* DATA2 triggered the transfer thus is always available */
> +    data[3] = fifo32_pop(fifo);
> +
> +    if (used) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Incomplete CAN frame (only %u/%u slots used)\n",
> +                      TYPE_XLNX_ZYNQMP_CAN, used, CAN_FRAME_SIZE);
> +    }
> +}
> +
>   static void transfer_fifo(XlnxZynqMPCANState *s, Fifo32 *fifo)
>   {
>       qemu_can_frame frame;
> @@ -451,9 +496,7 @@ static void transfer_fifo(XlnxZynqMPCANState *s, Fifo32 *fifo)
>       }
>   
>       while (!fifo32_is_empty(fifo)) {
> -        for (i = 0; i < CAN_FRAME_SIZE; i++) {
> -            data[i] = fifo32_pop(fifo);
> -        }
> +        read_tx_frame(s, fifo, data);
>   
>           if (ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, LBACK)) {
>               /*

