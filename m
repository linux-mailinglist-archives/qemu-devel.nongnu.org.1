Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D80B7A0FF5
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 23:39:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgu2N-0008MS-DE; Thu, 14 Sep 2023 17:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qgu2K-0008Lv-1j; Thu, 14 Sep 2023 17:38:08 -0400
Received: from mail-db3eur04on070c.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::70c]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qgu2H-0002po-Gb; Thu, 14 Sep 2023 17:38:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AozHxtlN+4UuY/UosFDXgfSLIJdkzQtq4X07gpb9+x+E++tU23yIFabA5LLVNsT+qjjauhKJ6LuCT7XaSsCVRQYqhHWxIE1dOQxxImMLf7GHflwxLEbrqKL1cF7wLE5z8GB3DDFvgWnszFyJJ5IOiyusuaRLTEKzcca1i6IOCpIusA6vqFOlqD+hT8H5SlQKi1sk4v91TW328uqPc+QB3dz9Vk7UrrSDJbYtJBD13P7AoRKesXCHsPZ6K/VggIUel9chuywVRq9tIxVMrX/4jQDNSA3vP2A2FHBOv0RNaC/nNpPSTJkXU0YsDkXnpL5VDwitHjMxuS6x2LliHDliRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VS6ef2PehWecAjjTlZ3ph2+mnW5KHfBkEDL+yo9IVVo=;
 b=OuXOTghyRvCKea3FshqAYWdKFYe6p3+zvN73SeThref9T1oxYg3KAx+bUGHDoShbsrmik5ZuHbbIK4aHj3UjSevo3ImNARE/EMSj0jBbMdUS7qB2k6DMZ+HkffP005cxqog1kxfTGj0MqFSLVuxfko7paztxtGFSr8RKcCngWcY9ZDPvX8a5fAA5a/oInr+VHCWjeGbCYUW/CjohIRfaLRnABl4aSXfgkFo1WGJVPBfA2v9j9Wvwbyx/vXxqWg66SywlywprAV0sW352grG6WsJVmrz4ImFJHtFKEYQ7/O3D87KOJ8biOMJemPsoleFugNiURpBv8HDRnw7tzxRwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VS6ef2PehWecAjjTlZ3ph2+mnW5KHfBkEDL+yo9IVVo=;
 b=j8ZvSk80EVd0kQlBojYIOe7ftj1XL7z3dnevoqOqA0RzJ9dyWJgdqrXwnk7j8Ohqm/PEJ3+ZdLysYC/EmwGuNUO0w+4PVb3Idx/LDv9cecP2bSXWUCgqoW0aHRdX07TMoMmvupR00QLkIShq2CfnyRiGnjZ3bp6iQqO/UIvwmuHwu7FTOu5VqyBCjf++/WZZAzcVNU2y/0l27lLMk5IAf3Nc0AgQtpYk8EcPH3NXBV/s9VGHdhWJynsPo71rLh1wbxwoNLdmebZRizuUgH4GphNILsP9QKbFWJayYL0DjN9+aM38Xf4W+v6IM8/se20BjMKkvyIVRQSBQH8u7clnSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com (2603:10a6:3:c1::13)
 by DBBPR08MB6281.eurprd08.prod.outlook.com (2603:10a6:10:1f6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 21:37:59 +0000
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8]) by HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8%11]) with mapi id 15.20.6792.020; Thu, 14 Sep
 2023 21:37:58 +0000
Message-ID: <e2e0bf60-1a3e-4f48-8c5a-81e16d5245ad@virtuozzo.com>
Date: Fri, 15 Sep 2023 00:40:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] qemu-img: map: report compressed data blocks
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net, vsementsov@yandex-team.ru,
 den@virtuozzo.com
References: <20230907210226.953821-1-andrey.drobyshev@virtuozzo.com>
 <20230907210226.953821-3-andrey.drobyshev@virtuozzo.com>
 <b6yyul657xkv3usgp7vrczy6r5xssbhmzfgftvrp2srlnct7gt@ja5barlss2kh>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <b6yyul657xkv3usgp7vrczy6r5xssbhmzfgftvrp2srlnct7gt@ja5barlss2kh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To HE1PR0802MB2331.eurprd08.prod.outlook.com
 (2603:10a6:3:c1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2331:EE_|DBBPR08MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 1664cd83-fd5e-40d2-4f85-08dbb56adcb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTa4pAunxn9JWYCHOJpSqkH6zh33UrAZ30OhglnbZ6qVb3l9LICerbl6riexv1qhIQzXwl4H/WhuIZ6+QdIFlXHa5owqkz1H1hnNfKT6v99rC6aV/tsfSP7KAM9wZxYY4zzBhv6Bmgu+96uP83pBuLL4W71H0kcUOJjT6oCnMeiqQR30444SkcQL47ES8XDWz27vNFtRP3iQB+20sHHNCz7wGXvMCwOWPwvsRFQsfIxq7luUmzjSgAySgipmdAdwHIQqTAAH4zHKz9CPcK7UskDtYSwyQkXZAddWcX9dYWjR8JJCwN+lZ8K2YPKuZzBV9gDCoeJiTQi/tc80Oxuh/T+Rf083FamskMQpTN4XOeKb/p7tvyTfQgJCdRYmxNVyuLNJzCq7d7TD9K9G8T8DkzroJsui725Wut8gUcc/ot2GHKPu5lV2UdFrJkJkOwEDNJweQ6LVAk8y0Z00ZwFAWKupVM6l6hCTuXi5MyNLb2GTueigtkZebQ1BAGnLIIQkZ+diydZjJGQuljfjv4PTWgYauHFezMo3p9WRQWtzLJYAbbz5fCO1V6Y83erOmtuNru1v5bhPZuk7rXVwSvKhsAuM+LcgfqVjF7dUZvoKiM6yYy0EcHTO0Ez6awC7PHKxdakmKjq+wjjmLA+LIBhoWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0802MB2331.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39850400004)(136003)(396003)(346002)(451199024)(186009)(1800799009)(2616005)(107886003)(44832011)(5660300002)(4326008)(26005)(8676002)(8936002)(6666004)(53546011)(6486002)(6512007)(6506007)(31686004)(83380400001)(478600001)(316002)(6916009)(66476007)(41300700001)(66556008)(66946007)(36756003)(31696002)(2906002)(86362001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTMvOHY1akpYSzJ0WVVkWW5UaDUvaEFpZE83ZWRvdXIrM3ZieG5sMmxXSllM?=
 =?utf-8?B?ejNHK0d5YUx0MFZCREtiVjhsNWZQeTFTV0hTbS9VTnNKQmJFTkc3bGFEZVF0?=
 =?utf-8?B?SEdzb0ZTSm1NZTBPZDdVZDFtOXZ5V3pRUldoYU5PVmRtRnNWRWZabU51TEx2?=
 =?utf-8?B?UURlUWhrNjhWVHY0NEZTblNFbTBvbkJMVzR3dGk5Y1Z2YkVJS2xkZy82bkor?=
 =?utf-8?B?SWtRUGlKWWRZK1ZaOTcxVFdaMDVXYTNVNHI1cWN2Yjg0REJYK1VIYU9kUlBJ?=
 =?utf-8?B?NCtMM1pHYjNPWDNhdzdBaHAwZHZybHVPNW5hMHRzVEtiY2dxUlZ4YzVQZVVk?=
 =?utf-8?B?dzYvNVg5TnpUQjdESE9qV0VYTkxGMHdiYWRFbG0zTGk5Z2NzRXFRSkpOTkFP?=
 =?utf-8?B?VDBzMUJWMGVCUzhxc1FkcTRJa25OZ0NqNHI2ZytyTnZ0N1N6SnVZSldlSkdJ?=
 =?utf-8?B?OUNheitlcWdkVjQ2T1AwOG5hY2RMZ2JsaDdaWVU4ck1qOU1ZWmRNVVVCZlpr?=
 =?utf-8?B?S0FDbDRET1dmRnBkWHNwUytCSzBWVmZNYzdDaHEzeEY2SWpaOXVOeUFKVTlG?=
 =?utf-8?B?YzM2N2xOaU9yc3VRdnVjd0ZuMm82d1pjYXAreWRpeVFhYjN4YWtOMXNRbUtY?=
 =?utf-8?B?dFhNUldvQ2liRzdPcldaWVRRc0F3ZFB0WTY1ZnlJK05HT3dsWDFKQXlpd3lp?=
 =?utf-8?B?UlEvWVg2VEUvMnhtVi9KSGgvQUw0WXNUNnY0b0ZnTDBlNGFKQk0xeG4zclhY?=
 =?utf-8?B?eXFSVE5rVnZEdjVwb1pnSFlxS283dTUxYmVzZW05VWdCS3U4SXBBTllwU3NX?=
 =?utf-8?B?NU5VcHdaTUtpSVllaFN3dVdwTUVlYmE2bHVNbFRneTc4UjlzVmJSMGZla3VF?=
 =?utf-8?B?SW0wYjRZOTJPZlZJQW5aQlQySnZqbXFQWTgrd0FVemNQbjJPMmpBQS9KMEhs?=
 =?utf-8?B?SG4zVlpTZTByaDhUejVnaUp6Z2gwSWFqM096UHQ2b2RWUlk0anZybE5vSzZt?=
 =?utf-8?B?by91bFF6WTJWekkzWTZtSGlHWVJLNnp5RGV0Y2xzTlpiQVpWT3YzWFVBL29V?=
 =?utf-8?B?UzVUdkN5V2xWa015WVBzVGpxSmxJd2h0MXczclAwQkk2YnFyc1RuNDYzMlNX?=
 =?utf-8?B?dTNucFFwTFV1VlRvam5iQnU1ZktqdTdBMmNXNURoM0pDeThkREg1YmN1UFpK?=
 =?utf-8?B?REtWZDdYSlhMS0xrTjlIcEhPN2FFL1pvUWwzaUpNYlpacmZWQk4vWXZiM0Jm?=
 =?utf-8?B?cllXWG9aMWZOWjN4aUZNc01qTi9aSWxXbDN0c2k1ek9zWVozTGNIdWZPMDJv?=
 =?utf-8?B?ZGdUMzFLeFIwRldrQ3dlUWlWQUVXRFZ2L0hTcmFmTERwUWJIeUpQd3hSd1lQ?=
 =?utf-8?B?cS83UzJERXN1bjFCS08yWWQ3SlRQaW5ZdGxPZzVCVEQ3b2xESmdtY3gvRXo0?=
 =?utf-8?B?b3hVUTZsQ1VISzBnb2poSHFZMG5pekF4YzdmWGxnWEx1QnNHckF6RzI3aG9S?=
 =?utf-8?B?ZWMva2lGT1ZRVjJ6TFQ3cUpHNGtFZE55a2lsRFk4ZStqMDZiNGgvdTg1blBp?=
 =?utf-8?B?bFBzNHRPRXo4TG5nWEVQeXpRbWw1MGY3QmVPUE5vYm1lY0xVTXRLOEorLzFq?=
 =?utf-8?B?WTNWVkNXckVHQ2NycWVvYjZ2RmxielNqZkRzUEFlb2pJTTBJTDkvYnFPaTBC?=
 =?utf-8?B?Y3R1cjNmVTJQSnZKaVpOdEk0cHU3NXFaM0pJLzZqZ01wNE1lbE1KdWRqcExq?=
 =?utf-8?B?UFZ5MzVwdVRsbko1RXpQa0ZlSWJURGtrRFF0WTFyclVReVNsTHR1NjRQSkp5?=
 =?utf-8?B?OHhaa2Z1WHFzMDh4RFZaTTltZjQ1aUJMUGZrTjludVh2dzhVWVFTV3VkYUp3?=
 =?utf-8?B?VmlJZlhBd0V3VWtET2c2TEJtVWR5QWRZck1lN1JTS2I3bXpjbnNsK05oREhP?=
 =?utf-8?B?WXB3UVhQdW9lSjI0L3pRZVVzbnVteFFWQ1pQdGxGRUk4eTBRSXVza2tuY3ln?=
 =?utf-8?B?amZvd1gwSFI5OW9CamtJYWE1VmFGVGdUdXdFOEtkUDVxMDVndWI3cHpCR3Ny?=
 =?utf-8?B?SGgzMVludE1VdkNtKzliYTFYOXRDOEtUa0xMeERQbk40U1dHaVI3d2tJZ1cy?=
 =?utf-8?B?Q2FlYXdFQjArdFEydTVVU29oNEJKZG9OOE82Qnh6T2swdCtWNGlkNzVEMTR3?=
 =?utf-8?Q?TrrsCmkPttZIrSDj/qs6998=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1664cd83-fd5e-40d2-4f85-08dbb56adcb6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2331.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 21:37:58.1505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ywkVMggldpa+QCOmq2HbQoabatMxvNRWjGE4Qa9bhgamsAX4JRke/ts0ZedhkTp7rLm2JjCe/8U6tXe/hiAJu0b0LnbSsDmzmY818QsgaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6281
Received-SPF: pass client-ip=2a01:111:f400:fe0c::70c;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 9/15/23 00:17, Eric Blake wrote:
> On Fri, Sep 08, 2023 at 12:02:26AM +0300, Andrey Drobyshev wrote:
>> Right now "qemu-img map" reports compressed blocks as containing data
>> but having no host offset.  This is not very informative.  Instead,
>> let's add another boolean field named "compressed" in case JSON output
>> mode is specified.  This is achieved by utilizing new allocation status
>> flag BDRV_BLOCK_COMPRESSED for bdrv_block_status().
>>
>> Also update the expected qemu-iotests outputs to contain the new field.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
> 
>> +++ b/qapi/block-core.json
>> @@ -409,6 +409,9 @@
>>  #
>>  # @zero: whether the virtual blocks read as zeroes
>>  #
>> +# @compressed: true indicates that data is stored compressed.  Only valid
>> +#     for the formats whith support compression (since 8.2)
> 
> s/whith/which/
> 
> "compressed":false seems universally valid for all other file formats,
> and the field is not marked as optional.  Do we really need the
> disclaimer?  Could we get by with the shorter 'Will be false for
> formats that do not support compression', or by omitting it
> altogether?
> 

You're right, this remark should've been removed as it only makes sense
in case of the field being optional.  Feel free to remove it altogether,
or I can send a follow-up if you prefer.

Andrey

