Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE01728B79
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:59:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Oay-0004Z8-Bv; Thu, 08 Jun 2023 18:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q7Oaw-0004Yh-2v
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:59:06 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com
 ([40.107.220.74] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q7Oat-0007e6-Mm
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:59:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+pk+whsXXNeovM+JIavJj88iB7+ZbAlSapL+tcCGgII7nOyJyrvay/vybe3fo1BQq1pdCPdlIrxEzT/xEUB/7WcEf3gLaGnuqV4zSeaPHP5LAzGl/bTLOnSuDQ9yc9rL44DJwuHdZu8R9eTcTffADEOfI1xoLp3CRghmCeE9lflRjmxQUHbJnYqW0khV0a/mBCBPVvMmgtqXZXtN7g7jwpS0JoBNjSeJcNVBrmCcWuLRWkgz4eJxGX3Bf5hW3HtxwO/pUrkANueQAygL/iogJiGhQ79DlqJWarUxPPRwmGthbJndjcKxuDVmtVblPD8C2lD143cFLtZvkMA1unN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNPVK6fOGf0FU9MCXi9Kh7f4tefhx46WHXJthc2tsV4=;
 b=Ux+ucy4e558Axe+Muwy9Td3T8OL5B1Mik7FRvhE11DTwsQPdKT16zVJ8SdEK/do7Pgb8ocinQLIFAb47xGEznGMnBMDPP+i936htK7OpDIAPCHMsDdv55G/c0beRo5UCfyNOWOIkST5qEbcgGssg/FcHbzvmBj3q7JU31o7SkJOe7YGJuR2oppiTgWgDKHsaTihB0R/ek0QMgcRxBIvPRki4q3/P8KvobWzPBp1VmtvZc6WQ1yGq26BQfZfKs3UP/2tz6BbehQJBcBWz+KPt3k/GKbK3IaQvEGNwSY1TTb0QQB7KBWRSwY41XPRmriurLdUSOTjV4tA8Fg242WxrHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNPVK6fOGf0FU9MCXi9Kh7f4tefhx46WHXJthc2tsV4=;
 b=DYwOQp0FQdvH8Z+pxoDTe2TalR+MgQw500Ypi34IkQCkQc+7/EMPQZsYAFHbOf+caavTt7CyBghZhyiSyVtuYnNPe0zqPBNVPK+7+w0KnEaFSS47w81pTuIEdci+k3l0Semc0HPZwgGDgb/H/Cryp6Ut4UfItsZwu9tAs9DDqlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 22:53:54 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::1182:e204:82d8:a4e]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::1182:e204:82d8:a4e%4]) with mapi id 15.20.6477.016; Thu, 8 Jun 2023
 22:53:54 +0000
Message-ID: <757f627d-fb00-aa46-0aec-97f7d76cace5@amd.com>
Date: Thu, 8 Jun 2023 15:53:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [QEMU][PATCH v6 4/4] tests/qtest: Introduce tests for Xilinx
 VERSAL CANFD controller
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20230530212259.7111-1-vikram.garhwal@amd.com>
 <CAFEAcA9nPRghOXb6vc6eQ_4iGFW3J8z2XyZzgv8BNb1RpBO+wg@mail.gmail.com>
From: Vikram Garhwal <vikram.garhwal@amd.com>
In-Reply-To: <CAFEAcA9nPRghOXb6vc6eQ_4iGFW3J8z2XyZzgv8BNb1RpBO+wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::43) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 25844719-29e4-4d09-e5a2-08db68733c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sZVXpZJ5qTSA7pvv//RdgPxFB35Xn8DWLUvBTvoTNZXMJudHN8x+tGLPrZF1zqa7olbc1/DB1SeqscBdZxIkOuCunSG4ymKJ6nnPVR9R/O3sWH7J6Jiwte93Zuramqfwf33WW3rYiTa4UyHYyDxvL8ims91kZ1VMMicYweMLpEzRYs112H9JHSdnQtCr6WjBz8sSWXHbH/8TFzDfkREri/nvS8CBiVDCb2d4qFs2v9Dc1jb3DdHr0EzR6fksBU8PnXZIGIwLDag+C+vSFX/EAnkeu6dzB2p7cibnPB1fuFZgVcpmek5IlWN2KE6cY3O03R3m00bFrQU6ewmIK8XBGhQPtT9N2mf5nYm5AyVOQt4M39/kcwVOMGFr2g2ibslyauRkXgFtyKAcuD+NHD9SQ/KP1Qf9d0eN3hXpylJVpkuOX9DtNd9cMaBjrmncJiZsFM/7wZ2f5S88dtJ2cAuw8Ly0pP1cxdisj1cLXI/e5ZHBaq6t5t8ayLcu7w+c4qQPseG6u6FrnbAN8SOwHOAzN9MCPcKXMN2IMuTJ/a9yDlfW7y9tYWBcfNj5/Yzrnd54iCEMckiyJorwj53psMZX5C0cajPypB/HOjBStMfGtEL5013KI+EvjIWiEwkMOEJJbZ2thoIC4op5kZ3D80lmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(86362001)(54906003)(66476007)(38100700002)(4326008)(66946007)(66556008)(6916009)(6486002)(478600001)(186003)(36756003)(8676002)(5660300002)(8936002)(41300700001)(2616005)(31696002)(2906002)(316002)(44832011)(31686004)(53546011)(6512007)(6506007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG0yWHN4YUFLT0F2OG9HUTNzMmRmYTlaQWdtZm5WdURCdThvVGt2dmlVbnl2?=
 =?utf-8?B?RVhFVVhYRkVSR1JzckhqNDBFVm1YZEVqZGlBbXZTanJiOEoveDB5ZkVIemFz?=
 =?utf-8?B?Yks2OVdac045R0dJdTQ3WDFHeGhNeGVTUXlJNWFvTWx1K0ZURWxkWHpOT1Jz?=
 =?utf-8?B?dHpscWJHQm1ReDl5dWZCa0lNemt1aWM3R05CbFlTYU5TRzU1VVB1MFpneS9Q?=
 =?utf-8?B?WWhuUG9OZ1pFUFBlTWxMNUtCdWVMY2tpN0NNNW53a2Q4M0YrcEhqWU40MStq?=
 =?utf-8?B?b0NtU3JZVHVRSy9UT0llajl1S25TdlVOQ1FVcmIzbkFheTh4UUw4R0huVHNk?=
 =?utf-8?B?Umo0Rlc3TDkzVzE4VUdjbTB1OEJxQkdBVldneHRnY2JYelh3dlo1L3JiUU9R?=
 =?utf-8?B?VWhtc2kyTC8xd0RNdTF3WWtJR0sxYVRTd1NFelpKVHpCRWY2T0kvTmpmU2xY?=
 =?utf-8?B?NXVieVFLQnczS1FJRWxTOGxMTlhOc2tjbHd0eng0aVVJTElVOWRJcUVPaDJY?=
 =?utf-8?B?dkN3N1IveDlVOUgybjVHdUsya1JySmQxak9mOEd6Y2dPOHArOUVWRHhMc1lQ?=
 =?utf-8?B?U3NJUER3L0dTV0NFRlZ2aVlsWjB0cXdHalJwa1grK09adjdUU2lIN01xTEJ0?=
 =?utf-8?B?emkyNlBlZ1Q0N29mUzhmQXN6ZjZpTnlCdTRtRUVxb2FxUUZkRk56N3pRVTZM?=
 =?utf-8?B?c0xCUW55WWNzejgvb2FIc2l1QnQ4WlhEbzRFZHpqcDI0OVBCU1orWHFYREdJ?=
 =?utf-8?B?c3cvWHVBL1BtVUVmYlA1bUFYRGs1ZWFxYWNqaGFNcE9jZFF0L3h1SGVLaWlR?=
 =?utf-8?B?elVDQ0JMR25teGRLdXBDbEZpbWQ1czRpWTc4M3A3bktCNm1GTG5rdkY5STlI?=
 =?utf-8?B?M3JnZ3J1dzBxa1FpSmhzTjcrUk9RcGxxVjlwUEl2YnFiS1ZzMUphQm9iTlBP?=
 =?utf-8?B?T1FrUXRCWDlZT0tXcURLSDk3T0kvYzRCZ3lMWDJVR3R5elZtU2YzaUl3bUZa?=
 =?utf-8?B?YWxTSTgzSGVyUm9CWGNaTi9RTmw0Nm11dkt3bWd3cTFRMUpFYlZSKzBXQU9B?=
 =?utf-8?B?WHdPQUx1OFVaUVFwTWl3V2NWRDFQY2EvUXZqakhlZDYrK2pUbzQ5dHRyR0U0?=
 =?utf-8?B?UysreWcwWmxtODM2VHNxTlIvUjZ5dHJaQ3BOeE54UUhQSnRQaFJ0dERHQm9n?=
 =?utf-8?B?M0VaclpYZG9lT2piMHY3M24vT3V4VkZocCt6cDRDMTY5V3pnclYvUVhzK1V0?=
 =?utf-8?B?cWdVYlRJNlJHNisxeUFocUsrT1pYY0dNMUVRb1RqNjJDYU5renJIOEs5a2tD?=
 =?utf-8?B?Nzl2ckt4VUhVdVduZWo0WDdFRW9lbVJ1bENuTzFqeWIxdmFudzhBSUVnWDJE?=
 =?utf-8?B?bmRiZkxyeHNPd0FEWE9vNVRyVXVMNHp2aVFtaUpCQkRoRXhNbkpwcndubEdE?=
 =?utf-8?B?Qmx5K01qRTlrMXV3RHV4a1FUTjVXYjZrUEdrQUlvUzBiajhEYUN4Y0g5T1F3?=
 =?utf-8?B?RGwyaDMxNXVxcXpYczB5U3J2c05sZGRVbEJXTjVIU2lza1paTUx0MUM1MFdU?=
 =?utf-8?B?a2YzOXhLb3RCU0JWSUNGU2E1ZHV0akw0NTh5aVVvU2FIWGJ6RndiSVN6dEhp?=
 =?utf-8?B?VDBSRkhkemxyQmZOcXBQc0lFT3BUdEJQeFh5M1d6WjcxS0FlTmJ0M3VFL0xj?=
 =?utf-8?B?VzNkYlFSb3k3Y2NDT3RRMlpZMnhYcTY3R3lDYzB6VE9RdFJ0UFFZb3llZzRV?=
 =?utf-8?B?cjNKZDArb0NRSjhWTEh1SkhIVG5pRVJGQmJkN2U3clhvMXhFRG5LZktQKzE2?=
 =?utf-8?B?SGlxTVR0aEI5YUI5NWxOWms3OE95OGszUys1TWd3Q1d1OS9DRkUxUjBLOExw?=
 =?utf-8?B?ODZrWDdpOGRCdEtyVUU3L1lXZkNEODZpQ0xRbHZhRUJsK25rS0NHUEY2ZWpQ?=
 =?utf-8?B?cVFYT28xRTdrREhCcnFQUEJPYThVZWZTeHB6UjEwK0tlVHhIWEdodTNQalpW?=
 =?utf-8?B?ZTlGYWE5bUZRZ2hEZU1DQUVOZTBqR09wT2xITlUyMlg1K1o0MFRkak1lMXlP?=
 =?utf-8?B?cGJlME0xZDVkMnlnV3l5MnI4NUF6SUtBZVNUbFEwQTZVczVlNkwyb3pyL3NH?=
 =?utf-8?Q?K6kMluEsN4ictkcavjZGGTsxX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25844719-29e4-4d09-e5a2-08db68733c19
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 22:53:54.3402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwBEOOm1OScPxY6MTyRAQHIXJ9h0cpJEU0OiEm0my6W3NkQEpaCNRdrX+7TARoiYVX7nAQqzgTQdoK/yCymrvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077
Received-SPF: softfail client-ip=40.107.220.74;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

Hi Peter,
Thanks for sharing the details. I will fix these and send a follow up 
patch soon.

On 6/8/23 2:42 AM, Peter Maydell wrote:
> On Tue, 30 May 2023 at 22:23, Vikram Garhwal <vikram.garhwal@amd.com> wrote:
>> The QTests perform three tests on the Xilinx VERSAL CANFD controller:
>>      Tests the CANFD controllers in loopback.
>>      Tests the CANFD controllers in normal mode with CAN frame.
>>      Tests the CANFD controllers in normal mode with CANFD frame.
>>
>> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Hi; Coverity has spotted some issues with this test code; could
> you investigate and send followup patches, please ?
>
>
>> +static void match_rx_tx_data(const uint32_t *buf_tx, const uint32_t *buf_rx,
>> +                             bool is_canfd_frame)
>> +{
>> +    uint16_t size = 0;
>> +    uint8_t len = CAN_FRAME_SIZE;
>> +
>> +    if (is_canfd_frame) {
>> +        len = CANFD_FRAME_SIZE;
>> +    }
> Here len is either 4 (if !is_canfd_frame) or 18 (if is_canfd_frame)...
>
>> +
>> +    while (size < len) {
> ...and we loop with size always less than len...
>
>> +        if (R_RX0_ID_OFFSET + 4 * size == R_RX0_DLC_OFFSET)  {
>> +            g_assert_cmpint((buf_rx[size] & DLC_FD_BIT_MASK), ==,
>> +                            (buf_tx[size] & DLC_FD_BIT_MASK));
>> +        } else {
>> +            if (!is_canfd_frame && size == 4) {
> ...so here this condition can never be true: if !is_canfd_frame
> then we know size is less than 4.
>
> What was the intention here ?
>
> (CID 1512900)
>
>> +                break;
>> +            }
>> +
>> +            g_assert_cmpint(buf_rx[size], ==, buf_tx[size]);
>> +        }
>> +
>> +        size++;
>> +    }
>> +}
>> +/*
>> + * Xilinx CANFD supports both CAN and CANFD frames. This test will be
>> + * transferring CAN frame i.e. 8 bytes of data from CANFD0 and CANFD1 through
>> + * canbus. CANFD0 initiate the data transfer to can-bus, CANFD1 receives the
>> + * data. Test compares the can frame data sent from CANFD0 and received on
>> + * CANFD1.
>> + */
>> +static void test_can_data_transfer(void)
>> +{
>> +    uint32_t buf_tx[CAN_FRAME_SIZE] = { 0x5a5bb9a4, 0x80000000,
>> +                                        0x12345678, 0x87654321 };
>> +    uint32_t buf_rx[CAN_FRAME_SIZE] = { 0x00, 0x00, 0x00, 0x00 };
> The buf_rx[] array here is only 4 bytes long...
>
>> +    uint32_t status = 0;
>> +
>> +    generate_random_data(buf_tx, false);
>> +
>> +    QTestState *qts = qtest_init("-machine xlnx-versal-virt"
>> +                " -object can-bus,id=canbus"
>> +                " -machine canbus0=canbus"
>> +                " -machine canbus1=canbus"
>> +                );
>> +
>> +    configure_canfd(qts, MSR_NORMAL_MODE);
>> +
>> +    /* Check if CANFD0 and CANFD1 are in Normal mode. */
>> +    status = qtest_readl(qts, CANFD0_BASE_ADDR + R_SR_OFFSET);
>> +    status = status & STATUS_REG_MASK;
>> +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
>> +
>> +    status = qtest_readl(qts, CANFD1_BASE_ADDR + R_SR_OFFSET);
>> +    status = status & STATUS_REG_MASK;
>> +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
>> +
>> +    write_data(qts, CANFD0_BASE_ADDR, buf_tx, false);
>> +
>> +    send_data(qts, CANFD0_BASE_ADDR);
>> +    read_data(qts, CANFD1_BASE_ADDR, buf_rx);
> ...but read_data() will write up to 17 bytes of data to the buffer,
> if the incoming data from the device claims it to be a canfd frame.
> The device shouldn't really do that, but the point of a test is
> that the device might not be functioning correctly, so we should
> size buf_rx[] large enough to fit whatever read_data() writes to it.
>
> (CID 1512899)
>
>> +    match_rx_tx_data(buf_tx, buf_rx, false);
>> +
>> +    qtest_quit(qts);
>> +}
> thanks
> -- PMM


