Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D67968AB383
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Apr 2024 18:41:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxrIK-0007gU-NM; Fri, 19 Apr 2024 12:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rxrI1-0007YE-MO
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:40:44 -0400
Received: from mail-bn8nam12on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2418::700]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rxrI0-00083t-7V
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:40:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqqsUbsNQk3UDKhXklPqOIpjCVXPPM0d8BHpA298Nok1cuoL+wDYsLG9KpVAM6FBKcbV//Uk3C6mKb5NQ+jjWAPWYHWenWqyxgiUdsW/o3rmXIDhbfHC0Y6cgaeTKTLNlgLuZT5mIT+GClJE4h4c0dfDxyR7ok6zXBYWG37kVsCuS8ZjUgfKBj/fCF2AoeI4UfVIE5wUo3WZOogdlrbIMt432F476Ud3Bn5KLouzVzXc7Uaxb0a+c+fVsGn6htEzV6TAagQc7dRyzQGFg75xXqJwHi9RpzjPNtF2Tq9koZW8+xE96cBuYGIZK86wc0ggV2MuOdhA20j0dAx5K3u+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2w6RcuzU/p0QopJOhENtk8juDAYJ7WQ5QKTzGUKgIU=;
 b=Db/qSHUQeVK1dDRo79APWiNYh5Q8s1tLEnvCOWPyu78zZ7hA+bzCp6GnNyiS+MUBDzOwlSsjaT4dti2Bgg4Nf0q3un/Js5CnQmTMnTpYNejoybHFfmFbHpU6Mv9bdXlDKg4xr6Is5kEd9FMM9Ew5QYx/pcwHgv0TXqssfSY+x0Dtiuo1YR7aKE3AneEuHFLRH143q7ZqfnibqWIW4HM8x89+JeSkjlrLE33OFLQEtL/8Tyti8J9IY4j7s2pdOYDSV1VhbxjJ3Sze1uJ2M7GmRjPzXOC3jTdScNMFsM/RURFSBlKQYjx9G513q04zLVfo5sNh103IVaalLwL9abHO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2w6RcuzU/p0QopJOhENtk8juDAYJ7WQ5QKTzGUKgIU=;
 b=glrRCMGAKMxs6CPfe3NRuk/xnRmjbXY6tnGC3OF8EZb6+nZkd4Xlfyf9Z9xUelWNPKameXGN2y9DQCg59aUJVVnK5ey6zNA0KBB7rmh6oeQk7CSkJX6twnREdeOX813ffX1VrFFZjC6wWvso0JW/0eerB2OTD8N68JLf8Wrf+gU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CY8PR17MB6579.namprd17.prod.outlook.com (2603:10b6:930:7c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 16:40:37 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 16:40:37 +0000
Date: Fri, 19 Apr 2024 12:40:32 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 01/12] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size
 field to output payload of identify memory device command
Message-ID: <ZiKegIWdv2Tg16Oh@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-2-fan.ni@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418232902.583744-2-fan.ni@samsung.com>
X-ClientProxiedBy: PH0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::14) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CY8PR17MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 9069d9d8-dd66-4635-8ae3-08dc608f70d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3j1XWmR9WbYaGFAd9wLRgLdFgES7Z5Ze6RKu5IdsNE5CP99nBx5doA/Tgh6fqjZeR+jM9asWTW3spdf28EGkPoJNPMzk9bs6o7a6TUelQ1DAG3xKpRLlPCh9ojKLkzrj5ow319QWdrmAerdIwlhX20p1q6eUUGrY6vUocqRNzYg/NsL9R8G174FAmH7vWyQxi9rdnAH1lfxDGikMybuolEjJfZpnqEQBqaRwNtKA1e4sBhUBzZb6vhkPqXOpLekWwjuhPEok65nvOEfaCJYC/0OyB7pst9VYwKSODK9Q0s7zsjSAV1+gumHghchWMokB/ntr+UiT6hp3oKiao3Et4beJnJhmryZGviIcZF1bGPoZItVaOgWs0cnd0SGLf1XLvaC0F6v7/rmfP+2cikXvMkxMgHBCS4uZVEakBiQ1uyUZ/kiZNRbezvQ0wZxpPumqknNunYMVz5aWSlZX0njCMrqCAaw7UYXzqa86tcQmM9HpXONPs9ogaO3wwTeSlp+u2YKLEYONK66r2zuxDszfjdIDzsKf0/krDNg9aedDde7+W+TltYjuYg+nFfTNvudUnW3kOwWZfRya7CF6V3JYIuogklm2E5lZCJDj2k+Z8yQZHzGqATRUlcdrgLz7eryMmAB+uQ1J+5+QDztBzZL9pSgthjaXINtC95R12HeFg0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB5512.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cSlHOjT0tV65hzTWBqvV3MX/kvFJm8qL4JEaZxq+0MJLRZYnsELLBeu3x1IV?=
 =?us-ascii?Q?qq8TbAcRYWV2tdxCc8bxxcVLXo2pN/ZhZm2mFwUtRx92M3Vex5CooczPFA25?=
 =?us-ascii?Q?nTTvuw4ZdLhiSLq/JNLJuuCRyPVmj6Ei7ibbogbtcTeu+pG+AJwe0fhih6fS?=
 =?us-ascii?Q?4J1xkOUP8q8i7nAynw2q+P0/XghwiCdM9a/dXkcfq8V+hBrL9D/YXvaVPGK3?=
 =?us-ascii?Q?as4MoNpfIe9Pzbm80PLcpr1dXPQZCtO5RVPIvpj14aqK7uBqP8LVT5tyJVK0?=
 =?us-ascii?Q?BBD1W6DlXBFK2fo5ZeZz3zaTw9qCEgvu745i9rUlZ327TePHmDMr1S3Eoti8?=
 =?us-ascii?Q?BotjKQ+tYsG/q3/FAUEa6CvvbHm1vLmJC3sYyIwpkSWcnnpVqHseaNxvhRRM?=
 =?us-ascii?Q?cWvedOrg6RvhDRZ51gS23r4etsjTXCGNbWDtU7OsOk8PSKUJVnD8GM+gbhJW?=
 =?us-ascii?Q?Pj0W66nlO31+4mq9pUqmFFzIoNRdgsFD/yU5mo78BCRXrBu7Bk715G8DZSLd?=
 =?us-ascii?Q?bXS3BB0Ht5GWxb5URzqJ3kI1pGiScdaeQmm+rPK54QaHNNJFja+4l3Cht7Fd?=
 =?us-ascii?Q?ms5sk3/0qRb/+JPexhYRQF+g6NX3DBBr64fWRLcDMkZ1YVvfGe6YH/V+ELBw?=
 =?us-ascii?Q?0gErlsIzhbR1HIIl/OvbgRWBr430+X38uKQ1eJp0w2Pe7SQW27y/geikhmIs?=
 =?us-ascii?Q?ShMPxyC9Y3UKx1tuZwz5E6vdYwUs8xi+2av00uFo5j3Af43syRHbxVRYJbNZ?=
 =?us-ascii?Q?S/aC8Q5/R3aSPm57rEauk6ynexT6bwF1YYO7fvUK1kopJoJ7w23X/7EiJu9u?=
 =?us-ascii?Q?OUu7SUXyfNnGp9HbV11BuBPtW0VQm7f93PnyB1NS/+RjMsXg9Su7X4OWZzyW?=
 =?us-ascii?Q?E9vQK8KiALbieCscIgAQ3dL0uX4j7iczlBiaWDYH7CiX4b2pz9lLiivScoha?=
 =?us-ascii?Q?RApd49RWslUe02+xMO5gjW//QZIwl2spVHG3VRGl9FF/iV+DUqEIP3zNJpsj?=
 =?us-ascii?Q?OUWYvceOqfnPi973cyujf8f1U5v49VWM9mXPanImwoQuW1HNnFInJkKa1H/5?=
 =?us-ascii?Q?jFnDcBwcZVWOuD7vC4HYxa0FT25kiRbRsGLqQqKk+Sbv7LaZH4w1wk7lfJsn?=
 =?us-ascii?Q?mXcNdbhsv3teg8lzDZ27y3cwzZeJ2ZBN/3ladypXEE2XWUMu9N1MxE4DQ9Lq?=
 =?us-ascii?Q?OgqqImF68s2+OcBpxzBBI1/rbMnuNk/njuHhdj4JWFANBs6hAKfs74smF8GC?=
 =?us-ascii?Q?GXyPRk4rKsG7zgXtwqPsQ1bGcR32B3Tn1WDXxwj6ViBsEAzMtMW6dn93cqaP?=
 =?us-ascii?Q?k50bUw2m10TYmemIBxEfpFt0qlvsM4OEbtBuA5MYOSJ3QWpQ6hu9SVZCUL7b?=
 =?us-ascii?Q?bJI0l6ZTmBvk8O4fWno2Be4K12IB7PL8Ok8RVP4VI2XpecoN8T5lWyZnHbV8?=
 =?us-ascii?Q?5x9g055tpDthQLfNu4Vp/EREv1c3muqUQ9f8xpfSus1fn75oSEFEfXHdrw4a?=
 =?us-ascii?Q?UAWDG68tAj+iRrfTomVSkKWVqNyUlurO2+eQG+x9wIqeuD53QhXZupEkI8lV?=
 =?us-ascii?Q?vBUVFEI7qAxl90sr2H8X0/69PGfFZ975Io8xRzXgUF2b0IqDu2a0J9Tg+7Uc?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9069d9d8-dd66-4635-8ae3-08dc608f70d6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:40:37.1084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1ee/lQOuA3lEWWMV1HOCvAGm4syVSl6f4xm6wKYalRKeok58qF+n7aL8T0VPJI9WwRfFawwlHvvkOHPZ3DbYZ+eMB7qdGXn8OzH0NkbMM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR17MB6579
Received-SPF: pass client-ip=2a01:111:f403:2418::700;
 envelope-from=gregory.price@memverge.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Thu, Apr 18, 2024 at 04:10:52PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Based on CXL spec r3.1 Table 8-127 (Identify Memory Device Output
> Payload), dynamic capacity event log size should be part of
> output of the Identify command.
> Add dc_event_log_size to the output payload for the host to get the info.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gregory Price <gregory.price@memverge.com>

