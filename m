Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3935B714F3E
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 20:20:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3hRr-0006Qi-V1; Mon, 29 May 2023 14:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1q3hRp-0006QM-4a
 for qemu-devel@nongnu.org; Mon, 29 May 2023 14:18:25 -0400
Received: from mail-dm6nam10on2068.outbound.protection.outlook.com
 ([40.107.93.68] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1q3hRn-0000Tv-EY
 for qemu-devel@nongnu.org; Mon, 29 May 2023 14:18:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APxr14XBYeZ+vh1ezO6ApWGTEr8G0kRG3YpVHZIQ/7deq3lH2zWGbrLjU5jSGvK9ciNdUIyYzQLRVcpkebVmw+lIKr6iYWDVy0vlay4wMvT3RYOIoRYsxVsMqKhgJb9mXnYJQh9L8kt/sDCq0Bbz6oQNnz2xm30roLQcw6qVL/Y/J6+1mcAozIKwOOkY2lqmHtVulicd4He86owIW6EfKD9xiuWREgCXEBGofsO0KQQCMJ1qx5o9MkbrDhVTMsE2e83fVfO80fztydpLiJYd2LsaOMcAfajSitd6g8bREeIIzPY9W75sCBOmYRLQvlORK/aFkMuz3qkiD4aA78Q7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WLhgzJve80XRqYSkUkWlR0TAoJwzLOqFx2rtgaQB6Y=;
 b=Qrf9DbWQMDvEgscEX7co2vVVan8VRCfUmdH3wKZBQloXR7a/EL6tMS+NPDHy7Mmw1knHI+bvzCCwAseMDPiTrU5Ig7vqtp53DgOUnhdnUNhYcnzjvFjkRXD3tbXL80rPw1TlHfHgcLJnSLvrVby3QdcEtOkVVFUYGDuiKU0uyg1gj1yAK6uzyVe1IjEZgSf1S7Q7GREZlpiBHh4f2VSifxgweV6pA4FAa1uPyat1BgALNWuCbDGN3ExoqQix3VyWsRb8C3VS3QjN2Herwu5lLV58Dt/c7OYJlXV39SJX5zdadgNp49mChUYZBtj6K1pK6Bz/FbBxCbqfxH8oM6h6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WLhgzJve80XRqYSkUkWlR0TAoJwzLOqFx2rtgaQB6Y=;
 b=DX8aYAg0+YMVw0cEfzINt5UbVVPsOwo7YEGEJOnS1V0Kod/xz+6rrQPEo1MjuzKRqhHzwW0wAQZMg4bSnS5gg9mnd65JFmkBhI82NHtRdsi4y/Rgyv+2/JGzviOqvFiAPBdwsLQhQablMMC99D5CyAM9i09St36TjSC8u1WlBXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA0PR17MB4175.namprd17.prod.outlook.com (2603:10b6:806:82::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Mon, 29 May
 2023 18:13:16 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 18:13:15 +0000
Date: Mon, 29 May 2023 14:13:07 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vincent Hache <vhache@rambus.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [RFC] cxl: Multi-headed device design
Message-ID: <ZHTrMyQfd8AhxMe5@memverge.com>
References: <ZBpe6btfLuuAS35g@memverge.com>
 <20230515171807.00006d8f@Huawei.com>
 <ZGMglwWwZCP4FUtW@memverge.com>
 <20230517151859.000055b4@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517151859.000055b4@Huawei.com>
X-ClientProxiedBy: BLAP220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::27) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA0PR17MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 734a1efb-7b60-4fb3-004f-08db60705f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0XJXm+RrAF5JSfB4EzSPNJDJm1hjgblAWoW4yjugZdXH+vXsgQQxqRbX4PqSdLq2A3C2cvN07Teq7YgZPy+3umTNP/Z+zWmJ6NUafkCM8kmTWEYbjhKvPo8CUabfzc3P5yK6HuX4OFhwct4C6NEw/KvhAW2GEufygBwW71vVJ2TqtH0anjFeddDasWwWqydevLjuLauHcjkFhPKxACQBlHFIMwUzKdqxOWDMQ0+vpaN5q34u4WnIOKEwys7emIVQ+KXOLF9qnBrM3U7sLzFqqiJNsio2HO++TlILQMKRgHp2d4K+1w4rjjlHqqpLPN8TeRN0L2uGZK7M1ZCqZDIsgqDx+PeWMnKYGXwlkn2CNzpjtyVlWf6gnBtW2fXXlRiBCIhthVVpvb3gUQh6N6Yw7Gb7ocqNfQQvhyb2IJHYdgmaJuhrn24fYbT29NCyp+WG95uy754it/hSmKabqNeBmEDSKXHzmcCIYWt0hjiKxsNt/qGXZdq4ilnypoBmebmQ7eAn/LZy6QFBi+qEBnfXKMMcaVmCaUFK23N+wyJjNJ0JoSIGrQiEuwxUmnj8LuH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB5512.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39830400003)(136003)(346002)(366004)(376002)(451199021)(4326008)(86362001)(36756003)(41300700001)(186003)(8676002)(8936002)(83380400001)(6512007)(6506007)(26005)(2616005)(66946007)(54906003)(478600001)(316002)(6916009)(66476007)(66556008)(5660300002)(6666004)(6486002)(38100700002)(44832011)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EkoE1A+aJ5HumAF3Bc2BErD1caHJlUPW+JFmmSgwClMf8qEkzthvDYjVao2n?=
 =?us-ascii?Q?vVh6B5hp6AQVl+QRryG+Pg6gdoAHVfgp/e1jKEolna2uTuPsWAjl5hYtp/NM?=
 =?us-ascii?Q?BlJWq+PUqTFi5SkqJ8PZiQoIRm7iIIzETz4UdUI9vD0GNETEogWXyCWf8XZm?=
 =?us-ascii?Q?2/rpiS+H5llLpnRl5QztkztpMwGgdzXEFujU0GmEAlVbqd+DLrIEDgYhSQuX?=
 =?us-ascii?Q?0lkTM63Dtil2z0dMkRHKHNgC0969dZWdeLQ2sjAZjPnsA3XC4I/+6cGELzrC?=
 =?us-ascii?Q?GOZaM6dimXN7GZ7vyDNuvSuwULgxaeKfNJsbPaml9Dfb/lbVQT+HKmjllChN?=
 =?us-ascii?Q?0/e04p3A2cnnrA8g82V+i/xmfEgK8vjVPI5xGTRegcaxPumh8rmi26UAtscN?=
 =?us-ascii?Q?rsZGGNQkC5XZTye9327HCMpcYcQZA5S8BmpZXdkBGWZ4EbTig29zzvt2rOmA?=
 =?us-ascii?Q?8zvI8BxHVhbNaEP7AA+3oad0fUeC47UaLa+6nm2Ip9hEmb9wwYam74HHtn38?=
 =?us-ascii?Q?yH/OZl3knFBxt/Jj/eFCR1NWcGJfk9opC53xILKu/rt/9V2ocyKe+cqeawuE?=
 =?us-ascii?Q?TYvHlN1caUePhITVl9ox+AwwKoAJAtIu6j9d4PuJwrdtP3knrjflfqapmshN?=
 =?us-ascii?Q?IFWy2KYXc3303J6Mf+bPGOexP5j+42+JcPo+YSuOtRx2+x8ZL4nALrRuPcCb?=
 =?us-ascii?Q?i0H2oOfbmcS8wxoEugTmnaH+uIIUdgGxH8SUxn3HBkVBWJIjoRHxk1TyOeg6?=
 =?us-ascii?Q?Z3FfTuAEcgJnw37Yn5FE2uK5HENOF0/RRsg8ivkhvE8fyZjQ5kmnbbBx9oAm?=
 =?us-ascii?Q?eo2hes8N3ITQCJDOhGDzUihlQUGmojde1rBp0BN9ScM073agSwKNCffRMcJc?=
 =?us-ascii?Q?3E+UQAG9n1MYE3QNf8ghQcmDJXdZTix/HeSCSipIx8uTvRa2kzLfnndcupkL?=
 =?us-ascii?Q?bFZu8rTak1E5YqbWdhcEJWCNfazNb8r6r3vrsq6nSbnoCRH9/6rOLbk8NhQp?=
 =?us-ascii?Q?+8+nUWp7973A7J/SdhHATMIAHuHSG3BDcCji2X22hBcCyVi4jM2BFDi+72HP?=
 =?us-ascii?Q?Wz3BQ4pYuCUwSe9G+Hodl7u1hUdCUjtVy+Wv0BkkQ52OT2WE5M6Dvp37x5XD?=
 =?us-ascii?Q?Y33S+/nUXnx0eUaJq9P4NhuGYCoaeXh9DZ2FWwbKBgduD9KvSOODI4ki9TDL?=
 =?us-ascii?Q?s/VpDJyIUkfluK47eWkOS/HjnE2V1ghMC16zUc7kvMeniIZt4jVX4D23bYMQ?=
 =?us-ascii?Q?bkiCa5WZFSb5WC8FNnit3QHZrZx1BueH7zufyWCzUFKTAxmuoXPXja9ExkqX?=
 =?us-ascii?Q?e2MGQPApREbeJ2W2E9ZAr8clxDnUhFVS8LMeB0i4v5sYYaAYodO7tria9lbR?=
 =?us-ascii?Q?ah8q5zEo+OT3R9O/w7/hbzlXOeq+NfsEuzFEHBDAopRVk8YNFIFD10Aau4NB?=
 =?us-ascii?Q?+ZesHowE/1v+8r4fyl2DZnvAU/SiVzEj0a1vQ7flew4gwWABmfg5ra4M9KKN?=
 =?us-ascii?Q?rQJaXidlreevc1FUTJGLHgCXY8AEGw/srHzKLuEE3npPoEm8qscP6+OsXZb1?=
 =?us-ascii?Q?itZzVIrL835LBPvqp37ramby/NRgLIPMlWf4BWZUwkEznMTT54bK5k0NBasx?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734a1efb-7b60-4fb3-004f-08db60705f2e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 18:13:15.5095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVGAxvIgLckXQk0Nc1m6LtPBtuFm74gpCxYiCtNiVlMXAM59scLqVqzEaxHXTiWZ971hgqTARsB6sRls5liS3NTwjLmvF7MY4esw20qyAmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR17MB4175
Received-SPF: none client-ip=40.107.93.68;
 envelope-from=gregory.price@memverge.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, May 17, 2023 at 03:18:59PM +0100, Jonathan Cameron wrote:
> > 
> > i.e. an SLD does not require an FM-Owned LD for management, but an MHD,
> > MLD, and DCD all do (at least in theory).
> 
> DCD 'might' though I don't think anything in the spec rules that you 'must'
> control the SLD/MLD via the FM-API, it's just a spec provided option.
> From our point of view we don't want to get more creative so lets assume
> it does.
> 
> I can't immediately think of reason for a single head SLD to have an FM owned
> LD, though it may well have an MCTP CCI for querying stuff about it from an FM.
> 

Before I go running off into the woods, it seems like it would be simple
enough to simply make an FM-LD "device" which simply links a mhXXX device
and implements its own Mailbox CCI.

Maybe not "realistic", but to my mind this appears as a separate
character device in /dev/cxl/*. Maybe the realism here doesn't matter,
since we're just implementing for the sake of testing.  This is just a
straightforward way to pipe a DCD request into the device and trigger
DCD event log entries.

As commented early, this is done as a QEMU fed event.  If that's
sufficient, a hack like this feels like it would be at least mildly
cleaner and easier to test against.


Example: consider a user wanting to issue a DCD command to add capacity.

Real world: this would be some out of band communication, and eventually
this results in a DCD command to the device that results in a
capacity-event showing up in the log. Maybe it happens over TCP and
drills down to a Redfish event that talks to the BMC that issues a
command over etc etc MTCP emulations, etc.

With a simplistic /dev/cxl/memX-fmld device a user can simply issue these
commands without all that, and the effect is the same.

On the QEMU side you get something like:

-device cxl-type3,volatile-memdev=mem0,bus=rp0,mhd-head=0,id=mem0,mhd-main=true
-device cxl-mhsld,type3=mem0,bus=rp0,headid=0,id=mhsld1,shmid=XXXXX
-device cxl-fmld,mhsld=mdsld1,bus=rp1,id=mem0-fmld,shmid=YYYYY

on the Linux side you get:
/dev/cxl/mem0
/dev/cxl/mem0-fmld

in this example, the shmid for mhsld is a shared memory region created
with mkipc that implements the shared state (basically section bitmap
tracking and the actual plumbing for DCD, etc). This limits the emulation
of the mhsld to a single host for now, but that seems sufficient.

The shmid for cxl-fmld implements any shared state for the fmld,
including a mutex, that allows all hosts attached to the mhsld to have
access to the fmld.  This may or may not be realistic, but it would
allow all head-attached hosts to send DCD commands over its own local
fabric, ratehr than going out of band.

This gets us to the point where, at a minimum, each host can issue its
own DCD commands to add capacity to itself.  That's step 1.

Step 2 is allow Host A to issue a DCD command to add capacity to Host B.

I suppose this could be done via a backgruond thread that waits on a
message to show up in the shared memory region?

Being somewhat unfamiliar with QEMU, is it kosher to start background
threads that just wait on events like this, or is that generally frowed
upon?  If done this way, it would stimplify the creation and startup
sequence at least.

~Gregory

