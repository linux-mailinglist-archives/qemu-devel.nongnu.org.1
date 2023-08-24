Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CEB78780E
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:36:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZFBj-0001HT-8I; Thu, 24 Aug 2023 14:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qZFBg-00019C-SP
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:36:08 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com
 ([40.107.236.40] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qZFBd-0007S4-Jk
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:36:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9Kh5rg7Q7U8Vd/dwOYHsHIHl5/V91W4PxC9k23QDYp/OyTtygktKPIrrpBkmFEe6CVgbTY26jp0xTfzW8CLkWooYVW/rlEYWLWqr+v+wtgVvDZRhMMf7kYBsLb2IRtvYeRSKEaWhkleWnoDTdm9s9QHh+kxUQO1syn/+Qlk4d30Ch/Wt5q2ZUB+lFBa7HV2BMNnD8FVcvUlOcyRgFNwuGtRoQjgV1CDZ8MvfSWdzxbl/KjfXxUu9mE2nRbqestaRFlykJoSctbrLu2h0/B7efYWFZXdfn7aEVsPRlHTKHoVTdazcwALy7P2KAPwvsniBXg1nFidZjxfbvyAwZfcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8qFApoRkIn3VYS3xbrZXOYLafWgiG+NOGl2jMidGfU=;
 b=P4QFx3Ymz0hg0rxvrURLaXBE9pylLKD54UgM41zKQRpaIVYg0DryqVRsD0YGzLI9OrG1oG5Mpk5qdBx2nsx+28KChDRnJ8J7crcTWYEtfkz0RwDib4FER1Ep4HPZgbaQbyTahBoY8b6EsxflSseGYWzprXcXsq6DPov3xRRqPKhOr2BMyvypP7a/Hjl2PN9IcJ5YhXxOCUjg1v9kh0wOQ+FIvVdoLq7PKGy562d04ozQSf8cbm/oX1yvpQUCh3hHAcgrfdLAICdZmcdFC7AOT11Htu2fC/5DZgIgWwMIHV96zqNjn3b41Kf5G+wxwRRolq5ytbmU5VL/XjWuY7hfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8qFApoRkIn3VYS3xbrZXOYLafWgiG+NOGl2jMidGfU=;
 b=Auu3RcZjZFFWiAcynmcftamu1yEh7uA23zgRTcUWl6w6PaGhsvbpaqg472341nSK9nUarOiqlpfvn9gFaKTz9Z9CoAsnDQ6Xzevcu8NcRuB9k3ntOvhBGTJ12UkDzRZ4CZubUuAVLLDWwPiVdEVMVyLl+54IzC4Xyiu6Y4gcnno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 18:30:59 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::b076:fed:d7bc:d89e]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::b076:fed:d7bc:d89e%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 18:30:58 +0000
Message-ID: <c62c483e-72ef-2ac1-ef8d-d0a5f06d46fa@amd.com>
Date: Thu, 24 Aug 2023 20:30:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/8] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_REG
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com,
 tong.ho@amd.com, vikram.garhwal@amd.com
References: <20230810191626.81084-1-francisco.iglesias@amd.com>
 <20230810191626.81084-6-francisco.iglesias@amd.com>
 <CAFEAcA8tQh=xwndU=jrnn5WAwKfYpBC0Kpwdvoc4UF+Ca-auRw@mail.gmail.com>
From: Francisco Iglesias <francisco.iglesias@amd.com>
In-Reply-To: <CAFEAcA8tQh=xwndU=jrnn5WAwKfYpBC0Kpwdvoc4UF+Ca-auRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::21) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: a85b48cf-3d16-4574-39f5-08dba4d042cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmeZWtSqTRuafAGExae+TyMBxN+hlC48Y+aCQ4XlQi/GnN9fU0fIYbzF5Q96awbUYmf1fyODkr9/bsJrPTQs53bghFmFAgYzw9LkJyjgRumBYCXtbrTs+mBtrIpJp3FZrx9q4p+hN6BvCmfcDENduLi21k9UfN9dxfAnLl2sp1qS0hPrZ8usSSFLYpyq+GpNL8HXGnsA5ObHIaqmwkwaYVfK3c1Bcmd2grbyMKafocmCtJ+pUWZQGAniDbXK31iTvXX11WESkC9ObskNflUo8Eo9JFaKo6GN+9FaJPViCWSPtYZCKO/rKImeZcK+c5MkREONq3UqFYpQ4ZLwAa7XPiXgOGSv4EvvOapPWy3EP3DEiJx42MlJtx4PksoqRt4dbTUigHH0+y/6VAlIikT5pWv8OFwFswDsccExiEkg4QRbA983n58vmrDTcQZfXU3i0WHkuzirn3Q7MPY0MJmIRC3bAovi3rDzG3eHIWS7dOlMiwxlj2oPRxGIOCaudcHGTUiGWY6ISGbk+VpuJwTD3/Xoa2VaeQjhy4nS9M1lPr1V4+BXct524Lc2DtHt8Dy4a3io52mAFHnNl9gNCLYpxiSfr2ulYxkf5T/OOiQedgNwzl35t4YoIximzDVanSGdnXObgptY1WCk8uMbCWGJJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(83380400001)(44832011)(26005)(6666004)(38100700002)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(966005)(31686004)(53546011)(41300700001)(6512007)(6506007)(2906002)(86362001)(6486002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNMendqQ01tbU55WklJM3p2a0RDOFJ5TThZU2hkbWVRNm1QR1o3ZHFieE5z?=
 =?utf-8?B?cTNucSsxUGQvaTZSWVB2b0xOcEtlNDMzekZUQkFqOTV3dXlLRjcwdE0vWXRh?=
 =?utf-8?B?cS9JUDlBT1ZBYXFGeWk5cVBobVBreTZwZDRzdmFsNzNQSzJtVk42QXhlbmNv?=
 =?utf-8?B?MDlxYml0RXpjdWJVNnIzbE0wL281cWwyZmkwOVpidlVWVGU0U2drTFg4VHhm?=
 =?utf-8?B?aHFoUjM1VTBMMkRBUmxjeDhUeE8zNHNGRVhQNlFlSVd1ejljZlZmUzhOSGpQ?=
 =?utf-8?B?ejZiSUQvTVcyZDcyYm9ES1phOEVXcG1hMVVLZ2Jpd1ZxOHl2cUZQM3VuUGtO?=
 =?utf-8?B?YnJtaTRtd2MzQytubk1FYUcvNlMzNTNFQmdXZ3pWeFFJU3REYVh4Y0tZZXlK?=
 =?utf-8?B?N0h2OXNCdWo1NDV5VHZIMk8rY0pEUmZSY2F2NHEyK0ZYMytuUXlIb2VaenhQ?=
 =?utf-8?B?SmRXMTV5cHRyam5QYnFkQXJ4aVp0U0JwUWc4NXIrdElSM0FOS3JZRXdCZDRh?=
 =?utf-8?B?RmV5b1Buc0ZFemcrUDh2ZjQycHdkOEJCQzU5WUErNzRLU2JDM2hNajVwV01p?=
 =?utf-8?B?bVdXZ1drWEcxTlBNbVRNMmhVTXN4MWs2dDZsaGdDSkRNdnp0LzhsMjRiYWFh?=
 =?utf-8?B?TGFiUVR2TFkwSTlrU1NxYnVBcTRnM0RvUEllaUFXSlM4eC9paFJSeGdKZTR0?=
 =?utf-8?B?RkRneHNaTWVDbUpHWi9zL1lNWWVBTnNGbUtxbVBxNUJoMSs0TWs2M2FrR2VC?=
 =?utf-8?B?Y2dIeEZqQnlkM0tYUHV4Q0MzdWZyZzd4WVRHcFhhWEh4R2F5ZG5vdXRjQUt0?=
 =?utf-8?B?Rys0bkxJNGVoY1RkQzNLTGdHbjlqU2tocmxiMDFSWEZWeE9OckU5NXdEZE5I?=
 =?utf-8?B?UXZacjNoSmFYM2pkd3JGVkRFTE5Nb2szZ0pYcmlZQzF4WUphOWhaaEV4VTZS?=
 =?utf-8?B?Vk1WWDhJRHJKNWxCYnE3NEVVaFZKTVVaUWpSTFdmdncxSHJQZUsvaXh3NENl?=
 =?utf-8?B?bWUyMkZ6OG04QnNxU0RORmFkWVp1dkxXWHRMZ0hkU3gyRXNRQ1B1UWlxZ2w4?=
 =?utf-8?B?Q3MwRm0rZUh4am5MQUVnVDAvSTZXcDA5cHhnckZHYkMrdzFlbG9aUEJjM0Z6?=
 =?utf-8?B?ZFJjNTBuTWh3NXhZbGJ6WlNUL2tLaWJJb1dIY1d2Ymt4ejhjNERpTXBhNXdh?=
 =?utf-8?B?QmhKOFpYTGFTSUFkM1FKcDhZdHd1akExeVYyeWJzZ0dtVVYwZG1IbStGdzRa?=
 =?utf-8?B?a0IwRkVTaGE2SHNJZmVHWEt0T0s3RjExZDB3K0dIbEFBWUxURjVuQjJjMTNF?=
 =?utf-8?B?S0p2aFBWY2N2Y0puUldmelhlM2c3K0NZQ0J5T05tZE53VVA5c2dGQ0JDSFRk?=
 =?utf-8?B?NEF2bEl3TVpPQW4xQmxVYW84cnN0Nnl5UVAvdlFHcHVuTzU1OGZsbDdETmpi?=
 =?utf-8?B?ZXJMSVRzL0RydXlDSldzQlN0SXNSc0dLNGFNek0vUnk1dENzSENJSUpEY09w?=
 =?utf-8?B?YzRZWGw4NzhmOWpqbTV5WmkyTlBXRDhWby9DVXhrMHp4ZzBLWWw4bFlyNmpQ?=
 =?utf-8?B?bjYwWlNIK2Q0ZENuNnMrYzZZaU5aQzRpcE1HU1JOMUJOakU3ZVpaakNQcWlo?=
 =?utf-8?B?NC9Bby9heGZLNEM0MTl3NXJPQ2VHSlJiNytrQmgvenBRRFZ3OUtQaGhBWGpi?=
 =?utf-8?B?QW1Wdk5nbFFPOThGS1RFTDR5Y0JZZ25jRHFlUXB1R3YrUklIUTlHYTI1MnNK?=
 =?utf-8?B?bkNxZE9oZ29zY3RZZ0N3L2pFMnhOdFlaK09oT2hjYlJXRkwvMy93a3pPdXhN?=
 =?utf-8?B?S0g0N29QTS9MM2VHNDBJSXZZNjRtN2p0dkFUOE9NTWZsODB0Zm4rK2o2UG9o?=
 =?utf-8?B?R1Y5Z1RjK3NUTkRvMEVzVlNCNklHL2tyajRpQkc5c1kvNUpnd2JOTVovTkQy?=
 =?utf-8?B?R2JIWDRMWFZTN3VDbUdONFF1SUdjZGpsYm5LU0ZqY1VzL0VMWmZKdi9xdG5w?=
 =?utf-8?B?a0xNNDRNekMxbXArdDdqTUdxMmRuMmltaDVTUStrSzNQbFl5cXoxSFRhS3Y1?=
 =?utf-8?B?RUNSbkN3TE1mT2pPOG5OVFJFK1JvRDB4SnFSZGxQeitLVnRsSmVjNG9vK0sz?=
 =?utf-8?Q?mlF+DS12/tu2R58fjjQXJ3+HD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85b48cf-3d16-4574-39f5-08dba4d042cc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 18:30:58.6765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ab6E03tDcscI5R11fGhaNGL2o9XbPs2pz5z5EPQ6YWdFHMlHExc12XbREvGqPTSST+/hFaLwfHWVM1mEszBTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957
Received-SPF: softfail client-ip=40.107.236.40;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.919, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2023-08-21 15:34, Peter Maydell wrote:
> On Thu, 10 Aug 2023 at 20:16, Francisco Iglesias
> <francisco.iglesias@amd.com> wrote:
>>
>> Introduce a model of Xilinx Versal's Configuration Frame controller
>> (CFRAME_REG).
>>
>> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
>> ---
>>   MAINTAINERS                              |   2 +
>>   hw/misc/meson.build                      |   1 +
>>   hw/misc/xlnx-versal-cframe-reg.c         | 753 +++++++++++++++++++++++
>>   include/hw/misc/xlnx-versal-cframe-reg.h | 289 +++++++++
>>   4 files changed, 1045 insertions(+)
>>   create mode 100644 hw/misc/xlnx-versal-cframe-reg.c
>>   create mode 100644 include/hw/misc/xlnx-versal-cframe-reg.h
> 
>> +static XlnxCFrame *cframes_get_frame(XlnxVersalCFrameReg *s, uint32_t addr)
>> +{
>> +    for (int i = 0; i < s->cframes->len; i++) {
>> +        XlnxCFrame *f = &g_array_index(s->cframes, XlnxCFrame, i);
>> +
>> +        if (f->addr == addr) {
>> +            return f;
>> +        }
>> +    }
>> +    return NULL;
>> +}
> 
> The handling of this and especially how it turns out in
> the migration support still feels quite awkward to me.
> 
> The operations we want here seem to be:
>   * find a cframe given the 'addr'
>   * insert a new cframe for a given 'addr', overwriting any
>     old data
>   * iterate through n cframes starting at a given 'addr'
> 
> You can do this with a GTree
> https://developer-old.gnome.org/glib/stable/glib-Balanced-Binary-Trees.html
> You can use GUINT_TO_POINTER(addr) as the keys, and use
> a Fifo32 as your data. Insert-with-overwrite is
> g_tree_replace_node(). Find-a-frame is g_tree_lookup().
> Iterate through n cframes is
>   for (node = g_tree_lookup(...), i = 0; i < n; node =
> g_tree_node_next(node), i++) {
>      ...
>   }
> 
> GTrees are supported by the migration code, there is a
> VMSTATE_GTREE_DIRECT_KEY_V() macro, so you don't need to
> do any pre-save or post-load hooks. (This to me is one
> of the main benefits of using it rather than a GArray.)
> 
> Is the data in each cframe fixed-size, or can it vary?
> The impression I get is that each cframe is always the
> same amount of data, and we use a fifo purely to handle
> the "guest writes the frame data a word at a time and
> when it's all arrived we put it into the cframe data
> structure". If so, it might be simpler to use a fifo32
> for the new_f, but have the data in the gtree structure
> be a simple fixed-size block of memory.
> 

Thank you very much for the suggestionA I'll switch to a GTree in v3! 
(And it is correct above, both regarding required operations and that 
the cframes are fixed sized).

>> +
>> +static void cframe_alloc(XlnxCFrame *f)
>> +{
>> +    f->addr = 0;
>> +    fifo32_create(&f->data, FRAME_NUM_WORDS);
>> +}
>> +
>> +static void cframe_move(XlnxCFrame *dst, XlnxCFrame *src)
>> +{
>> +    fifo32_destroy(&dst->data);
>> +    dst[0] = src[0];
>> +}
>> +
>> +static void cfrm_fdri_post_write(RegisterInfo *reg, uint64_t val)
>> +{
>> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
>> +
>> +    if (s->row_configured && s->rowon && s->wcfg) {
>> +        XlnxCFrame *new_f = &s->new_f;
>> +
>> +        if (fifo32_num_free(&new_f->data) >= N_WORDS_128BIT) {
>> +            fifo32_push(&new_f->data, s->regs[R_FDRI0]);
>> +            fifo32_push(&new_f->data, s->regs[R_FDRI1]);
>> +            fifo32_push(&new_f->data, s->regs[R_FDRI2]);
>> +            fifo32_push(&new_f->data, s->regs[R_FDRI3]);
>> +        }
>> +
>> +        if (fifo32_is_full(&new_f->data)) {
>> +            XlnxCFrame *cur_f;
>> +
>> +            /* Include block type and frame address */
>> +            new_f->addr = extract32(s->regs[R_FAR0], 0, 23);
>> +
>> +            cur_f = cframes_get_frame(s, new_f->addr);
>> +
>> +            if (cur_f) {
>> +                cframe_move(cur_f, new_f);
>> +            } else {
>> +                g_array_append_val(s->cframes, new_f[0]);
>> +            }
>> +
>> +            cframe_incr_far(s);
>> +
>> +            /* Realloc new_f */
>> +            cframe_alloc(new_f);
>> +        }
>> +    }
>> +}
>> +
>> +static void cfrm_readout_frames(XlnxVersalCFrameReg *s, uint32_t start_addr,
>> +                                uint32_t end_addr)
>> +{
>> +    for (uint32_t addr = start_addr; addr < end_addr; addr++) {
>> +        XlnxCFrame *f = cframes_get_frame(s, addr);
>> +
>> +        /* Transmit the data if a frame was found */
>> +        if (f) {
>> +            Fifo32 data = f->data;
>> +
>> +            while (!fifo32_is_empty(&data)) {
>> +                XlnxCfiPacket pkt = {};
>> +
>> +                g_assert(fifo32_num_used(&data) >= N_WORDS_128BIT);
>> +
>> +                pkt.data[0] = fifo32_pop(&data);
>> +                pkt.data[1] = fifo32_pop(&data);
>> +                pkt.data[2] = fifo32_pop(&data);
>> +                pkt.data[3] = fifo32_pop(&data);
>> +
>> +                if (s->cfg.cfu_fdro) {
>> +                    xlnx_cfi_transfer_packet(s->cfg.cfu_fdro, &pkt);
>> +                }
>> +            }
>> +        }
>> +    }
>> +}
>> +
>> +static void cfrm_frcnt_post_write(RegisterInfo *reg, uint64_t val)
>> +{
>> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
>> +
>> +    if (s->row_configured && s->rowon && s->rcfg) {
>> +        uint32_t start_addr = extract32(s->regs[R_FAR0], 0, 23);
>> +        uint32_t end_addr = start_addr + s->regs[R_FRCNT0] / FRAME_NUM_QWORDS;
>> +
>> +        cfrm_readout_frames(s, start_addr, end_addr);
>> +    }
>> +}
> 
>> +static void cframe_reg_cfi_transfer_packet(XlnxCfiIf *cfi_if,
>> +                                           XlnxCfiPacket *pkt)
>> +{
>> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(cfi_if);
>> +    uint64_t we = MAKE_64BIT_MASK(0, 4 * 8);
>> +
>> +    if (!s->row_configured) {
>> +        return;
>> +    }
>> +
>> +    switch (pkt->reg_addr) {
>> +    case CFRAME_FAR:
>> +        s->regs[R_FAR0] = pkt->data[0];
>> +        break;
>> +    case CFRAME_SFR:
>> +        s->regs[R_FAR_SFR0] = pkt->data[0];
>> +        register_write(&s->regs_info[R_FAR_SFR3], 0,
>> +                       we, object_get_typename(OBJECT(s)),
>> +                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
>> +        break;
>> +    case CFRAME_FDRI:
>> +    {
>> +        s->regs[R_FDRI0] = pkt->data[0];
>> +        s->regs[R_FDRI1] = pkt->data[1];
>> +        s->regs[R_FDRI2] = pkt->data[2];
>> +        register_write(&s->regs_info[R_FDRI3], pkt->data[3],
>> +                       we, object_get_typename(OBJECT(s)),
>> +                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
>> +        break;
>> +    }
> 
> The braces here seem to be unnecessary ?

I'll removed these in v3!

> 
>> +    case CFRAME_CMD:
>> +        ARRAY_FIELD_DP32(s->regs, CMD0, CMD, pkt->data[0]);
>> +
>> +        register_write(&s->regs_info[R_CMD3], 0,
>> +                       we, object_get_typename(OBJECT(s)),
>> +                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +}
> 
>> +static void cframe_reg_reset_enter(Object *obj, ResetType type)
>> +{
>> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
>> +        register_reset(&s->regs_info[i]);
>> +    }
>> +    memset(s->wfifo, 0, WFIFO_SZ * sizeof(uint32_t));
> 
> Doesn't reset also need to do something about s->new_f
> and the other cframes ?
> 

Ops, I'll correct above in v3!

>> +
>> +static const VMStateDescription vmstate_cframe_reg = {
>> +    .name = TYPE_XLNX_VERSAL_CFRAME_REG,
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .pre_save = cframes_reg_pre_save,
>> +    .post_load = cframes_reg_post_load,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFrameReg, 4),
>> +        VMSTATE_UINT32_ARRAY(regs, XlnxVersalCFrameReg, CFRAME_REG_R_MAX),
>> +        VMSTATE_BOOL(rowon, XlnxVersalCFrameReg),
>> +        VMSTATE_BOOL(wcfg, XlnxVersalCFrameReg),
>> +        VMSTATE_BOOL(rcfg, XlnxVersalCFrameReg),
>> +        VMSTATE_VARRAY_UINT32_ALLOC(cf_data, XlnxVersalCFrameReg, cf_dlen,
>> +                                    0, vmstate_info_uint8, uint8_t),
>> +        VMSTATE_END_OF_LIST(),
> 
> This seems to omit migration of s->new_f.
>

And above too!

Thank you again for reviewing!

Best regards,
Francisco

>> +    }
>> +};
>> +
>> +static Property cframe_regs_props[] = {
>> +    DEFINE_PROP_LINK("cfu-fdro", XlnxVersalCFrameReg, cfg.cfu_fdro,
>> +                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
>> +    DEFINE_PROP_UINT32("blktype0-frames", XlnxVersalCFrameReg,
>> +                       cfg.blktype_num_frames[0], 0),
>> +    DEFINE_PROP_UINT32("blktype1-frames", XlnxVersalCFrameReg,
>> +                       cfg.blktype_num_frames[1], 0),
>> +    DEFINE_PROP_UINT32("blktype2-frames", XlnxVersalCFrameReg,
>> +                       cfg.blktype_num_frames[2], 0),
>> +    DEFINE_PROP_UINT32("blktype3-frames", XlnxVersalCFrameReg,
>> +                       cfg.blktype_num_frames[3], 0),
>> +    DEFINE_PROP_UINT32("blktype4-frames", XlnxVersalCFrameReg,
>> +                       cfg.blktype_num_frames[4], 0),
>> +    DEFINE_PROP_UINT32("blktype5-frames", XlnxVersalCFrameReg,
>> +                       cfg.blktype_num_frames[5], 0),
>> +    DEFINE_PROP_UINT32("blktype6-frames", XlnxVersalCFrameReg,
>> +                       cfg.blktype_num_frames[6], 0),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void cframe_reg_class_init(ObjectClass *klass, void *data)
>> +{
>> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    XlnxCfiIfClass *xcic = XLNX_CFI_IF_CLASS(klass);
>> +
>> +    dc->vmsd = &vmstate_cframe_reg;
>> +    dc->realize = cframe_reg_realize;
>> +    rc->phases.enter = cframe_reg_reset_enter;
>> +    rc->phases.hold = cframe_reg_reset_hold;
>> +    device_class_set_props(dc, cframe_regs_props);
>> +    xcic->cfi_transfer_packet = cframe_reg_cfi_transfer_packet;
>> +}
>> +
>> +static const TypeInfo cframe_reg_info = {
>> +    .name          = TYPE_XLNX_VERSAL_CFRAME_REG,
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(XlnxVersalCFrameReg),
>> +    .class_init    = cframe_reg_class_init,
>> +    .instance_init = cframe_reg_init,
>> +    .interfaces = (InterfaceInfo[]) {
>> +        { TYPE_XLNX_CFI_IF },
>> +        { }
>> +    }
>> +};
>> +
>> +static void cframe_reg_register_types(void)
>> +{
>> +    type_register_static(&cframe_reg_info);
>> +}
>> +
>> +type_init(cframe_reg_register_types)
> 
> thanks
> -- PMM

