Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B3077F488
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 12:53:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWacs-0000uO-DV; Thu, 17 Aug 2023 06:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1qWack-0000uF-Ml
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:53:06 -0400
Received: from mail-db3eur04on2098.outbound.protection.outlook.com
 ([40.107.6.98] helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1qWacd-0002Cr-Bs
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:53:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZXX/X8dSgUfUkQXX8kG+rBqbcM/1s3kqSxfW3OyJSa3Z/Jj15wpeGHckVjhbogy2PESeDsOrEM9bgeBQP4ciBJnmcaeJiFsi4F/wKVR+QI7HKicNkkjwZMlxkvWGky8ESp+PH0VQDiXiObpsLdAelRf6JKSKlm5UCfkDvUnZC4UMoltjt7r7YklsdOlys2ftVjv2bZLU+qaYGJ9fqa79wIlIGJTdQ5a2gMSE4UVgYechsoWKHPWQ41sdTI4foL8FIVWBoTGKTCt92dgRqFMgx/PGMKFJ49gOCCEH5o60DxmEwW18vctkoC3PzgLMM671s+c+0F1fR/gCP1sV1UG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSiivTjn6gsNDIZk9NyuY0VABsnPrccoy5JTN2Vz5IU=;
 b=G8Wm6NPe3TeRtkfYS3ohM2BIgMjeuNDvAm19YPZ6Xtvtgv0ItEbY06CdrN6HRiKb02D6pHAA/+cAHY8eaeE7FhulT3saMFU9IWoBkPN+0AkMm87mZDcISKZ04EHTTqE2AEYcz0f/qkmg0EmYJWAhYQDh2rWSPdPoh7sEU/k4rH/69/s/4D1L4xa8dF0715Yh5MCAH9jQ+IxslOuy6DWn6aF3mQ3QkyQnDJ2yGUTC5QigiG5aCTVvl+DDEnHFn9Of2swfp2yCuJZ166JDZzH0gUtVfg/fi88oqgZpEp/yDTegamfGPLoOIBBI7ubNo9S0JT9zIK1Twkj9CEEPAcI+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSiivTjn6gsNDIZk9NyuY0VABsnPrccoy5JTN2Vz5IU=;
 b=a6BBdSa3mCr12gpw3I4W4qM0LN8aA3wD0ZFYO2CiMAryzur8VAspkph+ABqeJL9moVtaquUh9FuWoh2sAQQFfePZfoIcLoCAFNYcBD8hCv6vpt90Kt+cFY22VgbU+k3mLtLusx3u46D1YgW9Nnt8vOCfnCvLFDgsc2IphkgdMir5sYNibHbkFbnbcK574tCwjMILsvVvigQwrbXchLyjHUiV+ZBsD8OSYVywNgTomEVN0MBfA0hp7D8Lcf87is8kzF/Ddy6cZs4FZ6ZQEACxx8AbSuooFFbTAEIL/tHkkuaSA8wzqMVtu6QG9twnU7mc53Ay02f/KquLs61GK4KNMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAVPR08MB8965.eurprd08.prod.outlook.com (2603:10a6:102:328::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 10:47:51 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 10:47:51 +0000
Message-ID: <59a42366-58e2-7147-1bd4-e85b446b0477@virtuozzo.com>
Date: Thu, 17 Aug 2023 12:47:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] qga: Start qemu-ga service after NetworkManager start
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Efim Shevrin <efim.shevrin@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, den@openvz.org
References: <20230816200446.1408797-1-efim.shevrin@virtuozzo.com>
 <ZN318fFGAsT4up83@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <ZN318fFGAsT4up83@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0202CA0026.eurprd02.prod.outlook.com
 (2603:10a6:803:14::39) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAVPR08MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f7a2ba-8f20-48c0-5c34-08db9f0f675b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdNNiI/rQCayJyYmZvLIpFGvvkVfgfp2VOoTD7aI6Br+0TXnOeASZaab1tzkkExDT3bZXFK8jZo41hSTf62/0TtOT9bx3GuINOUEbK5M41RbGnNSxG84ue1H+nr05FS114coYJ/br6XHl5tf1fhse8eW9sadBHzR5hFvoiI0YgwD/ADbwBfCNuHeEz3bZsm0BDY7ZrCzao2K+I1IthAMCqOx2LwGAlDV9OFBhpbgQ4v5iv/FRfjO4bvKP+XiS0pWLszaU+LMwJOeSYi720yRxpup7syrh0DUH3bJJGaAZPM2GVZiKed8jy5CCdqe9ife3dQyztPdqMzJx+kYW7tSCve9daC210v/O1q8DM3q1t6gd40Mli9OD2JLduA69j0yJvGuvJULyJC+9JbOj2zakffb9gYUpKM7BD9+ykNiGmH3ZiB/FC/7wfoXDEJPgJZU7QFqTdCfEAUSy7soixrTanP7viHqIx494G8rFEk/ELEvB1Hi4WMG8Fpni9qUC7BCuGCGYc9jJp45D0sZxEZEAhjmP+B/nQS0z3N3nhtSKv5j3besET3Ji08KQ7Y/Ywy6tkwp0qeYVc5jGHOE2NGqh0eTk6gQUtD7lvRkEVxY/O2tq2XyF2+MgPVLljv26t1wIBg0OwDN31y557eHt9Lgeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(316002)(6636002)(110136005)(66946007)(66476007)(66556008)(31686004)(5660300002)(41300700001)(38100700002)(4326008)(8936002)(8676002)(26005)(2906002)(31696002)(83380400001)(478600001)(86362001)(53546011)(6512007)(6486002)(6506007)(36756003)(6666004)(107886003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2dGSFI1OTBpNmJwd0pJOTBTRzhHalE5ZFBhSFBpa1MyQ2Vka0pOQ0pNeHJZ?=
 =?utf-8?B?Y0pFL21ReHZBQk1qOEhiYzIveGN1TnJTU3RuZ3A4Z2FvVVV5MTFkMjNJdWps?=
 =?utf-8?B?N3JoVElUSnYzTE8rTDhjYzgxcWIrQ0xLUWxFOTV0bXFhajg0WkttbG0veG94?=
 =?utf-8?B?WW1haHFNWGg0bmdFOXlxUXhqbXBEcUxPQ2tMa0VYWFNJaSt1dFVVdlRwT3pv?=
 =?utf-8?B?MnJvaWFWQ20rRnQ5UE9jOU5CNmhHK0YzaGxHcjhiQm14UmdBa29GeGs5S0NH?=
 =?utf-8?B?VC9HckFkRVJtbCtTQjFvQmNkdjBHUCtzdVZqNjg1UHdFM204bHdRVXkrczJK?=
 =?utf-8?B?eW1jNUdWY2kySXl6aWFCSWZ3MG9WV1VEbWt0UHlyMUZsVXp1a3ZiZjNSQVYy?=
 =?utf-8?B?WUNBaXorQStmUi9YS1FmTThjV292SjhmSWgxNnpvN0lOZ0ZFc3ZqK1NmU2JT?=
 =?utf-8?B?dzVKL01IbUh1eWtNaUFheVZMNEpPenpIQXMvWUtXZXpnU0xjWitMRjJyRnZx?=
 =?utf-8?B?c1h5bC9yeURnb0VWOUk2Nmc2UnEyQXlONnAzZmVnSEdMVHh3TmorYVg5ZE5P?=
 =?utf-8?B?TzBiVFdRNllZSzBUc2ovQXF1YVdmbXNjeFV2T0RGV2hHMENaOG95KzliRm85?=
 =?utf-8?B?UmhyTVpZZk0rQlFYeE5WQ0xxUkljbHd0WXhJdkxBS3U0WHlIUUs4Q0xBMzBZ?=
 =?utf-8?B?RU5BSlFVRkhmeUNPSEJPZ2lTMVMwSGVYQWIwbUErM2MvR0RGWHozMUp6T0gv?=
 =?utf-8?B?QmtLSFFNa1h5YWRROFhLTkEwRUFaYWwrYkRlNjFodVh4SGlBN01oeDdqdklM?=
 =?utf-8?B?VHNUd1dKblZBUjkrTTdveXZGVVAwaDB1YVZSWE84dGJQalJKZEZzcUFZMldF?=
 =?utf-8?B?ZEpHWDkzd29yT1lKWEM4N0NqUWNlREx2NnUvTjkxSG9ZdXlPTG41SGRDUHZ1?=
 =?utf-8?B?MTF4c0VnWnpuOFN0YnNMYXJXTmRGTVh4aFdtZHlTZnBvdkRNVllLSlBmSFB3?=
 =?utf-8?B?RjVFdXRqSXNFdk4xbloyRG5LUFpzQ05mQm8ra0RjMWlac0NrVU83N0tQWXJj?=
 =?utf-8?B?OGRYQTdFdU5pOTBKcnB3TVBENzZRcUdHdk1QS1NWRE1KWHZaWjV1ZkpWZDRh?=
 =?utf-8?B?TlJYb0ZTdHVNaGdZZVFxVGtZeXJDRFl2SVpqZmM2dzlSejRZYkhyRFdGUGtt?=
 =?utf-8?B?dWFqRnNRbnk4YTFYbXlWdHNEQVdLMmNGc1ZKQTlJc0dqQXc3UE5SVkcrSUlz?=
 =?utf-8?B?WFRWZjF4SHNnK3NUejdvbmN3ZHNsNWFFVm1CYlY2MllvdmVtbTdHR3Z5cm45?=
 =?utf-8?B?UUF1dlptOXUrY3lZWjNVTTZ1VERZNnVSOFJObENrclQ4aXdxbXNBNjJPMGdW?=
 =?utf-8?B?aWxFZm55dkJiQmFuZmk2b0g5d2FVR3JlRUErQ2NQSlNhQTh1U2JieWlSNDlu?=
 =?utf-8?B?OTNMb2NPa1ZONmI1MnhLamtwZFdYSnNDSlNGT3c0WE1XMWJ0enMrb0dHeFBW?=
 =?utf-8?B?OG5KdnhHMnE0MW81M1dvRVJQSUNFWlZHd0w3bUpxbm50b3dBQXhJdFlNYWlQ?=
 =?utf-8?B?SEQyY0lPeE9DdTRJR09EMm5naTFMQXZSVDdFcm5mUXBTaGtXb25mRG1aL0RF?=
 =?utf-8?B?ZFJSRk1zRk9JK0tYWVYrYSs5U01hUTVpS0Z1RWh1RmQ5NE1UMHhudUlSUGhT?=
 =?utf-8?B?a080UUp1TTdSVFdqa0hwcjRIWGZ4eVdZSkVYcFR2TUkwczNrWXpYWUNURHBG?=
 =?utf-8?B?cSs0Ty9uNnhXUHowVkIrWkgxZTVmRTIrSHpIaE9JSWJMTEdiV2Jsd041eXNZ?=
 =?utf-8?B?MzhpYTR4aXp5RW84UjVTeGw4ZEs1eE9CSjFUMUFlRDdhUlFIOUlaSG9YSmtz?=
 =?utf-8?B?RTgyLzVSenBXdElCQ1Y0Z0NOVVZldW93YitMWXFtUWhCbU53VjBSNUNibGlo?=
 =?utf-8?B?MHI4Nm9CdDdGUzhteSs3eFQ1OUdKeVRTcXFHeVFqSFAzT0wyV0FMU1kzZDRK?=
 =?utf-8?B?UmpyOFd5SGJ0TThWb0swcWhxOXZGcXE2aGpISXhBYnZzSkJPRWdYdW1ibkVw?=
 =?utf-8?B?Lzh3eXV5VHVWZXRJRkRoTWZyYkRzdHRmWTFvL09xSlpiOGhTNFZJNmhVbHFp?=
 =?utf-8?Q?LGUOGpg8CRc77H4sdbhgjK40x?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f7a2ba-8f20-48c0-5c34-08db9f0f675b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 10:47:51.2214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+1x3fCi+2NPOP1706rF6gQyjl4iwQ+sgGtBtPZQQfimxO46ft2j/7WEBM5HtvVDFBHXz5jR69+674KUQbtnHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8965
Received-SPF: pass client-ip=40.107.6.98; envelope-from=den@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On 8/17/23 12:26, Daniel P. Berrangé wrote:
> On Thu, Aug 17, 2023 at 04:04:46AM +0800, Efim Shevrin via wrote:
>> From: Fima Shevrin <efim.shevrin@virtuozzo.com>
>>
>> When the guest OS starts, qemu-ga sends an event to the host.
>> This event allows services on the host to start configuring
>> the already running guest OS. When configuring network settings,
>> it is possible that an external service will receive a signal
>> from qemu-ga about the start of guest OS, while NetworkManager
>> may not be running yet. Therefore, network setting may not
>> be available. With the current patch, we eliminate the described
>> race condition between qemu-ga and NetworkManager for guest OS
>> network setting cases.
> A host mgmt app should not be assuming that networking is
> running at all, and if it is, the guest might not even be
> on the same subnet as the host. Conceivably someone could
> even be using QGA to inject files to configure networking.
>
> Overall, IMHO, it is wrong to correlate host notification
> that QGA is running, with any assumption about state of
> the guest networking.
>
> IOW, I don't think we should make an attempt to serialize
> startup of QGA after guest networking. The QGA should be
> run as soon as its data transport (virtio-serial/vsock)
> is available, which is the current state.
>
> If a host consumer of QGA wants to do something with
> guest networking, they should check for guest network
> state with the 'guest-network-get-interfaces' command.

This is very tight question at my opinion.

Frankly speaking my original intention here would be
to put QGA at the very end of the startup sequence
in order to avoid complications. In the other case
any host side software, which would like to control
the guest behavior will be in trouble.

For example, yet another common application is a
guest backup, here I would say application based
backup. In a normal case this is done through
    /etc/qemu-ga/fsfreeze-hook

I would say that agent should start very last, in the
other case *ANY* software working through the agent
must take efforts to avoid such transient state, which
is complicated.

Den

