Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1845C7A5DB9
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:25:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWxn-0006js-5v; Tue, 19 Sep 2023 05:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qiWxk-0006jH-5k; Tue, 19 Sep 2023 05:24:08 -0400
Received: from mail-vi1eur05on2070a.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::70a]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qiWxh-0001A2-KW; Tue, 19 Sep 2023 05:24:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlFOapBZ22yY9OIPWiY+zl2OPmcgoOUzPVzq//fmhQeaHGpQs5Xj78gAlCX2oAD7lWJwbSfSPt4LaOTdyh6LKpHwPz+K7HY+h+JL7x41Pb8sKyMd72exTVGqDpodMKO6NFrN7594+Lps61abRAq42m5nyH6QEJYK1MpukPQ2X5XEdTR4az6s6zNwn04XeSPPvUQGZEcHrlJc1IGy2klrlnpb3/uuoGeNVq7ylGl1DzlJLO1kxOOGVWq5s0dC6bV7LSoPB/jgCW3PdC4V4xWg81L4yMommtiAnIuMAEdjRqG0MR//ARuIBLJ73ADHZiqZQYAMpvrQGQSnxGrD0PbqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hkHYTsYZObb/aqY282QDuAd4O0KWYHRC0bXrJwpJ18=;
 b=EnDmQJu0RZSTpMcUVSMjZml9aKF3gYvUXI8pKDFOfEGuK8FnCDxD2TihRfuX54yCgfaU+C7eTbgSlH5zqJzSrmst07Ug26awWb2AAx45+DvV4Brs9HFPln+CwpudewPIurB9DrA5miQs1lRQ+c3bNnOxrsTCRlZdRi0SVmnu2nPbBD/fJfaCLHpiDzbMAkYCA7vTDlq3OLFGlv0qk9iPbcUmrh7pUp57/cTlk8cPt3cCfme077d7D7Or/cjWQxEvdRivzhJXBGVNO+gKMeK4GZxtY3W93KR1BCybOO/cq+obkR1zBpfFqSInj7ifD2SC1hCi/uK5vKzaVINfRllArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hkHYTsYZObb/aqY282QDuAd4O0KWYHRC0bXrJwpJ18=;
 b=MoExJBxUiDr3GS6/dqiAPVuXhiliB3n+uaYCshYBAYBDY2gD6m1MgzSphbUjwvJa7nYG2hPMeUvn56WVamf1zbt3QuRUmKgPp0RlcJ5i1aoyu6UxC384nG6qqFad9pTE0JIKE8mMfAxO7MSqetGIs6wPADookaxO8/iIBH4l54mzTt4z0X/ySoDHosEJ1te+xyz1BnXYVlIybJNNWaabRqXx87PFAyMsugXQtQVGUeOUb3jCEuyVAV9yseBWZAJgrEgX17TEUxNZgnvvLzYVPxKjbnnXqW2zLXxhEpns2v+53lsSxFvAG+YO39Mv3+BM1XcnZivl9h8B8KH0svVBvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com (2603:10a6:3:c1::13)
 by DU0PR08MB8709.eurprd08.prod.outlook.com (2603:10a6:10:403::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 09:23:58 +0000
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8]) by HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8%11]) with mapi id 15.20.6792.026; Tue, 19 Sep
 2023 09:23:58 +0000
Message-ID: <d09840c9-07cc-4fd4-beb6-10b374587a92@virtuozzo.com>
Date: Tue, 19 Sep 2023 12:26:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] qemu-img: rebase: use backing files' BlockBackend
 for buffer alignment
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
 <20230915162016.141771-4-andrey.drobyshev@virtuozzo.com>
 <a4836464-22c3-2a49-0128-2dc4a98b5092@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <a4836464-22c3-2a49-0128-2dc4a98b5092@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To HE1PR0802MB2331.eurprd08.prod.outlook.com
 (2603:10a6:3:c1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2331:EE_|DU0PR08MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a60e934-5878-49f6-79cd-08dbb8f22722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f49lrdyP7UL4SRaNQVE6Mt1F7CfF0MuLI4SmPjZ4ucmuGqR/Fma7uiE8hyqerxuxtSYHrIoCGZ+wJMD97SQSf+tXFbQdhZB0m0KkmN0lXlOpB6WDmlqzjk3BiO/XJ7lAHDKeTRwemtZ01VlP0kry2u75paH+HsupFM3gAc6xr3DfZ6KH0xCbrDLh4ZItP+8mY9BiXxd9DSQyO05+6AuONkS+bTwdbiqMFIY3lxH8h8zOL6xICTy4idfceDGWIFSKYsfao8T3uModgGIFXgE69hjOI7Mqs27H2aMO4WNOn0rVvsaAjetzgs+9g3tN6esEv4kPALBvODhq2wm90gQy2hD2OEm/2+3wXwNpiOF0WRNCXvoT4MSMU5l0B1sI2DNmosRMvRDoGjmMmS2l/U9SOO9i3lM41LbJWRZOEneJcCL8owZP9JT2I64kKfLigAh4FIlCZ1beCziZpcRWsMRzzz4dRpVmZtVVVUzaxaCA8GFH/NZuITRla/dEVCTMQnYZxIh7STmKc9LLc2cxicGVGmTIej37s8ilmujK5cHaVaBhPpWEz3clOZ2y7HsNRVhVttTAoVhoJYLlJcXMXUcbSMibOCCpcl8Z+p/iUWPEeUciSE4uJdn4E0iPK0/KzQEifgdHRvaRQmuRPst1Asy5Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0802MB2331.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(39850400004)(366004)(451199024)(1800799009)(186009)(41300700001)(66946007)(107886003)(8936002)(4326008)(66556008)(66476007)(316002)(5660300002)(31686004)(8676002)(44832011)(478600001)(6666004)(2906002)(2616005)(53546011)(6512007)(26005)(83380400001)(86362001)(38100700002)(31696002)(36756003)(6486002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmlKVytFZHVTZXMxTU5Na3NnRXhwbldWZGpQMHdZNmVvUW5TNzZ0SE42WEFR?=
 =?utf-8?B?SDNLL2lUclQ2dXpQRlNMZnN5ZHkraDQrdU9sWEZCNTlTTkxoVEllSnZhV1cr?=
 =?utf-8?B?SXBsbjVWMjlpNk9DTUtKQVJqQXhUR20wcEVCd2xLNU1FNGIyd3NJTVlDemlx?=
 =?utf-8?B?OU5oNlZPS1JiNHZxcU5tMzRVcURnSE03a2tvZWxZWFN4WmVtSTRDSi9GVmU1?=
 =?utf-8?B?cFk2K2g5U3A0cFpzbGtadzhmeklza1NSSW9EWkw1R1lacnRvMS9pRENsb3R6?=
 =?utf-8?B?TlJzZTZmUFA1bE1MQk1mc2xUenV0N3FIY1FobStGaXZweTd4aVM5QXR4MlRw?=
 =?utf-8?B?N0tTdnJFdWIwV3pPU0tzNHJHWVVVUDMrQkdiSjJMbUZoMWp1QzFSN1l0Y2c1?=
 =?utf-8?B?UTlPaUhtOFc0RnZ3NWRMTEM1c1doTmxFTGNteUp0L1NOVzFMbHhrWi9oQytn?=
 =?utf-8?B?ZklZTzF1Wm53bmh4NzJTcmU5SGR4RCtDUk5sOGQ1M0daaVBxaXcvRFRrUEJi?=
 =?utf-8?B?empoVVVhQWRhbjJpT0VjdSsvYldJYldRc1VscHJwRmFza1hDcVB5OGxITGM4?=
 =?utf-8?B?QXlHNlZ6clhaL1RIU1dEV1lWaUVnTE0yMkJySTd5b2lkd0FYMVgxRjluTWlt?=
 =?utf-8?B?U1lpSlcvb1pGUVUzYTRVNGNrT2hqbmxjRjB2NUZrTWswM1dxbjg0c21XMldt?=
 =?utf-8?B?QkpVU2ZxYnVwYndoNFBzOWhHUENzVncxWkpKb2lnejF2a1FmVHN3c0FtMjYw?=
 =?utf-8?B?cC9QYW9kV2xKVlBlWXZkUjJjRzlLeDJhRmhkUHZHSFNtQUFrSFc3cEJiQUtB?=
 =?utf-8?B?MVRSWTNyaUpOWm82MGk3M0hYM2VGNDJiUmxxY3FqMllodlk1YnE0UkhGQnlp?=
 =?utf-8?B?NC9mbFVnR0cvZUZRKzZKSW5qMzJRbmJ5UldNZmpuKzNHWGRVS3ZKYm9Yc1o0?=
 =?utf-8?B?Y0ZkaG5FUEFCZG9lZXVCUTlrdzYvdWRoYmMwbFB0bDd3cFpuN0NVb0ZuSzhu?=
 =?utf-8?B?YVQxdmNRVW54NUlTRk9wOENTVEp2RFdtdFplSHd5eSs2My9vTkRoR0lWN1ZE?=
 =?utf-8?B?cmdBOTZSbWlyTUl4TDZOSHVlRWdXY2g5N05PdWJCZXJOSlY3eDZXWlJXOFAz?=
 =?utf-8?B?Vjlkd2RCenlINEVoQkNNU3NRWkFySzM0dVJUaDBpU0xCdUVZajRjelEveWRN?=
 =?utf-8?B?eTFDdU5nSnQzOFlNV3RQR1hqZjlKdHlBQnowQlgyRmVFYmY0Y2E2VFFyajVS?=
 =?utf-8?B?eTF2dDg1MjFnSi9aK1MrK1BDamNpWVNsZ0JXK2doSnBQUjhMdjJ5d1F5MmN4?=
 =?utf-8?B?R0Y2NzhtWUF4Z2MrWFM4cGdTL2hSZ3liUTE2eDJhR2xlc2JId2VFallrQWxm?=
 =?utf-8?B?eEkrYXlCNWdjRWtFNzdqQldNaDFPU0JaTElaZDVmUXlOYjFFUm5tc2ZyTVUx?=
 =?utf-8?B?d0h1VnJuZ1ViTDl0ckNPWVBHMVVEU1RMRjRUSkhTbkkzMnlrUkxwbUowMEFD?=
 =?utf-8?B?a2FBNjduaFM0QTBsSjVwYUFkUDRQSVZ4RUEzaXlTeHBhcDROR3gvdlkzMzNJ?=
 =?utf-8?B?QzRZMnhIMHd0MVZEN1NSbjhhY2RmanY3bDc2aWJxOFQ0anNUdzQ4bUhWb1h2?=
 =?utf-8?B?aks3RXY5cmtZV0NtUWdNdDh4SzlQUXFjdzIwQmoxNGZVMWEzUGRlcmt5NC9x?=
 =?utf-8?B?eFl1eTREaVVBUlA2NW43ejRoU0NTdEVOeFArTy9hUUlZR0JTTFM3cnZFNW5V?=
 =?utf-8?B?emJXN2t5Uld0VElmcHZvMmxCWTd4L3F2NFIvZEJTcC9DdVdFM2tYU3JyMXNW?=
 =?utf-8?B?NG8xTEVDTVVITDVvdUxyTXNsZjlzbUl4S2o3dGNqVTc3dXlKUFRsTUxSNkx4?=
 =?utf-8?B?dFoxbzcwZUdobTF3L0JLcjVUMTNLTGZ2VkloUTdKR24wUjZ2Y1RCRUtpWUpD?=
 =?utf-8?B?UDFRSk1nckF1ZUNncWRQSzlpaldkcitobHBTdXRxZklWVVB0RWIrUjVNNU1Z?=
 =?utf-8?B?YnRyMWJlMjYvMk1uUDU5aTNWNUZMLzNaKy82OStEampVUm5uMzdrcTJnanlR?=
 =?utf-8?B?YzJEbGFKbDFjeVlDRWhaeTZ4NURhMEhVSVFXK2xYMjhrczFxWlZmQXpjaHZ1?=
 =?utf-8?B?dVRoMGlQS2l0TUhoZUJwcjZYSXhYNkRGdkV5ZjRRMTduTWwxOFNHUlFraHBZ?=
 =?utf-8?Q?2bhR2HNIaR17st06X+QklwU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a60e934-5878-49f6-79cd-08dbb8f22722
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2331.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 09:23:58.2887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Axs9SR+Nlz58M02XSUtqqdLmDF/UbbQgQYzPpTAXamTpVnCqmk74WkKq4dFllk06lwmoTKj4b39j/lc125CIiiyk8Kh7fZLkzA34yk2x8+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8709
Received-SPF: pass client-ip=2a01:111:f400:7d00::70a;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 9/19/23 11:18, Hanna Czenczek wrote:
> On 15.09.23 18:20, Andrey Drobyshev wrote:
>> Since commit bb1c05973cf ("qemu-img: Use qemu_blockalign"), buffers for
>> the data read from the old and new backing files are aligned using
>> BlockDriverState (or BlockBackend later on) referring to the target
>> image.
>> However, this isn't quite right, because buf_new is only being used for
>> reading from the new backing, while buf_old is being used for both
>> reading
>> from the old backing and writing to the target.  Let's take that into
>> account
>> and use more appropriate values as alignments.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   qemu-img.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 50660ba920..d12e4a4753 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -3750,8 +3750,13 @@ static int img_rebase(int argc, char **argv)
>>           int64_t n;
>>           float local_progress = 0;
>>   -        buf_old = blk_blockalign(blk, IO_BUF_SIZE);
>> -        buf_new = blk_blockalign(blk, IO_BUF_SIZE);
>> +        if (blk_old_backing && bdrv_opt_mem_align(blk_bs(blk)) >
>> +            bdrv_opt_mem_align(blk_bs(blk_old_backing))) {
>> +            buf_old = blk_blockalign(blk, IO_BUF_SIZE);
>> +        } else {
>> +            buf_old = blk_blockalign(blk_old_backing, IO_BUF_SIZE);
>> +        }
> 
> As I read this, if blk_old_backing is NULL, we will go to the
> blk_blockalign(blk_old_backing, IO_BUF_SIZE) path.  I think if it is
> NULL, we should align on blk instead.
> 
> Hanna

You're right, thanks for noticing.  Will fix that.

> 
>> +        buf_new = blk_blockalign(blk_new_backing, IO_BUF_SIZE);
>>             size = blk_getlength(blk);
>>           if (size < 0) {
> 


