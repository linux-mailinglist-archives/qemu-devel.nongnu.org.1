Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4916C72BAF8
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 10:41:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8d7B-0002I9-UU; Mon, 12 Jun 2023 04:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1q8d72-0002As-NY
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:41:22 -0400
Received: from mail-os0jpn01on2128.outbound.protection.outlook.com
 ([40.107.113.128] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1q8d6z-0007MI-Ep
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:41:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwqwg68n9MY7YTkA7MYSAU0xkByyGjxJ6d7Fhva/Tf9jl0QjqvDO1ht63SIM6diabm6n7SMom8t/NOtg80A80wPZHHawXyaL8iWxPgJVULT6tp2l6zlPZXlYc+We9WkWs9MeTGM62ca/MyUyZfSyez9/dGsL4r2RJUJ0zr6b4GUbyHOW5RHJvFTgnaKcpnzhYRzKT12kvhIE0ZceTY6aytp+PzLgWpbsjnwt0Xv8bNl2yRliddWS964zX3qejNq2NM3w3sUobBFkYDCEQbDTOp/tsJBbOW/7Qj4Ojt/0yb9320z0KSRGfOOm5dbO+G3nRYj5pTAwzBv1riFppSRDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKV4OEsG/WHbemO8ZnOeMIi7jV9JI8cCBh5kLlm4mmk=;
 b=KnHYy7Ikjz56Z5XxatwKkzteiFD+9Dg6p54PTEE74wr7qTqZpaWKz4hFhV5BpEGNA4MJ3lXbDMdMLSlLde1UkNdN9YixrwStgMOqqh/p4EIblfKuCxRiDzcFB+26qndInIDrRDnazmrNScFZFPfbJ94C7pRw5RNWaAavvRCl5FDp8NTJx4cCib6qzTOI0iGe7IYFPy/vhnmOWwVRE3umUvnUgM6tIYQJWXWR07oz4Au9UMnMGVlRP1a3Xk1Nqm2A7AoMWsluR1KXjwdJ1s7617WAA7V1gVAV3tnYsFVJieI5O0OFojsHsfUf05w5HPhiZVXut/dPnSn4CiDgdxIzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKV4OEsG/WHbemO8ZnOeMIi7jV9JI8cCBh5kLlm4mmk=;
 b=fRCxHuDGCXslhG1NTjyTF14lT6OBqDkfm5N4lSgTHwMgSorYtw1nBzFo8LHRuH+am/3vQo546V4qaR4L9Cv9WzcUIgbpyUiOSwutCQMSgDGZ61Lqvw2l9hVUTKs6x4RyvBXOSLBlEE/RN8iTOlzkF8BdgfN4785hWL3i9+g0Db8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TY1P286MB3293.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2e5::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Mon, 12 Jun 2023 08:36:09 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a0fc:750e:507b:2606]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a0fc:750e:507b:2606%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 08:36:09 +0000
Date: Mon, 12 Jun 2023 16:36:02 +0800
From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
To: Gerd Hoffmann <kraxel@redhat.com>,
	"Canokeys.org" <contact@canokeys.org>
Cc: qemu-devel@nongnu.org, tlaurion <insurgo@riseup.net>
Subject: [PATCH 0/2] canokey: documentation fixes
Message-ID: <ZIbY8nBXQbv2qZJ8@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: SJ0PR05CA0186.namprd05.prod.outlook.com
 (2603:10b6:a03:330::11) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|TY1P286MB3293:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f16616-d9b8-4a77-cf27-08db6b201275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aks9QjgU4rk0u5i70P0O+JcHhOUB1E/Q3+RCRdpRswYEZ8RjPXrGzf75r9AHWu2Q7+bfpdv9/IR76GuE0AtH1RyCUORnbxBujNGTSegOXA1ksrghoLPYsbefQqPfOCV+NsCwRH2t73QwShueXybCPl9fdfWE/pnPa0gNvkdoxQxyVLI1eKmGULwJaq9V7PAUWy/IMv9Eg2a52ebpE8Nmr+O5vLIYCW1vYelgbDz3ZivRieXWxsiXY3lkS/4Xn7l/xuwDI7N2fw+5FhMg+JMdiMKmieksv7r7d0+rugfOo75MWDyDW20zIXLJWXx/zjkk1vCrHElj47E/5wMFH8B3NklaYCfwldlKyKG/TQSUEU4zDMDnH4/FuZolbrM2FCV2ELzNGe4Kr4qCNidMZ/5SZ5TpcChqJiX8BoyPog1yI3tXxAoDpXiKiZ3emPvRJ9fdGsB050wXcmZGSXaXquLvmdjKYn2Pmuwb3Ia1ZxB5L++G/SPG0NCvgXIPGyCwUbQv4noq4nMCRFptqOQ4mCKxin/DeY0vahdijpH7Kmv08o0TVIo5EPf+KA1z/1h7FV9YX1ynfXHqVrYP+ifUNHdOgFMjW0t8JEyS94VHZqcycgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(376002)(346002)(396003)(39830400003)(366004)(136003)(451199021)(2906002)(4744005)(66476007)(83380400001)(786003)(5660300002)(8936002)(66556008)(8676002)(41300700001)(66946007)(110136005)(316002)(966005)(478600001)(6486002)(6666004)(86362001)(186003)(38100700002)(4326008)(9686003)(6512007)(6506007)(33716001)(41320700001)(49092004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7nFQDF/N5oUdbrZnPSsSkdBgaNVaoRuozxbI0L1yvi/2pkr9VeXrAPbq2vMD?=
 =?us-ascii?Q?2uLw8Nv+A8YNqvT7TPdTl79KuUT9IKvoHg8gj7m9ZJhZpC/8fwJBJbhX1cg1?=
 =?us-ascii?Q?InxryItn6AmIhFTzgmkDtXWYA5L6UAB/KHtb5q6JWhkFcv2wSG8lUtTIfo7Q?=
 =?us-ascii?Q?h0xAy5oT9f4mbWgkuLR4QlMiwmK4vwzqJiYa7QyRt7QgpnbbH4o88AVbpXHn?=
 =?us-ascii?Q?Nqw96iHDabd8NEpel4rJYBrz/urJQsbGJJq7y/jREB/urtfSEXRkfm1M3BkQ?=
 =?us-ascii?Q?6yPyEfauiuikafbW++gm2juN0TtGJWM3874wvzpCkVS+ovfCUzWcCBdmhHQT?=
 =?us-ascii?Q?RSP9GkV7+wWcq+cTnSqkqYr8Kb6hWqSG+MdHgO62l+C7ndwL8P1zm3KhLmqc?=
 =?us-ascii?Q?0CMiSHNaZHeDaaxYtAfFEhoLWqlfHuUf5Yrj07lX+09EXN59vOCHjX6hx4gD?=
 =?us-ascii?Q?atqMdG24IIiSLVG2h/1Rl3GuwUpwuyoLLqBAw/F6HlpTcKfr4CCmX7sqPEYZ?=
 =?us-ascii?Q?DiBIw3JtvyxAUb1dwf2B3BAzD0Lh1i936dsn80Kt8W9LeHoVO+g0Mv5OfOOV?=
 =?us-ascii?Q?OjH3zkiL9dP5Dy0BmNjtw6viyUcU6+Kb0PNWPgpCCsbBgM8eQnppx5opq0lu?=
 =?us-ascii?Q?M923Pne87dMNsgE/ucraRH/ZrsTOse49FuwQqMK0+tj/geYRa2nNADFkBgDI?=
 =?us-ascii?Q?9Sqmt1hcrfE9H+4UhvDa/SXoJDzPAzLoBC5OV1OXbtrfmL/6KIFd9Wx5gdSj?=
 =?us-ascii?Q?iJdBb335n+r/73G/t/vLWLd+djb/v35mtwm25ik3dzwWiAkxVIvBHlyuZFb9?=
 =?us-ascii?Q?N+QW2/KhON9/xHkR8S/x3beXvNATDub71wsdb3NvgatDzhyD8/NZjBKq850M?=
 =?us-ascii?Q?B5uYWrzGNT/3FLAbJOjI8AvTXK7MNZl6cvJ8kKHpRqinEv5sDDTR2OxI0UKX?=
 =?us-ascii?Q?XSIs954ZIs163shHBEsv0teHpIWuy+KHd0BRlIDp5EBRoQ2fJ9UfjZV6qNxG?=
 =?us-ascii?Q?EPRlXL7Xy+E6pc/fGmb9AX+itHAlf10UFFODItlSHTE/YOfMqjESJnQzCOzs?=
 =?us-ascii?Q?lNeA02aE2L5hM4obxI/OdGSpY1w/TyjRpG3xHzHKPNQCsCh2LKIXPxtTr7hC?=
 =?us-ascii?Q?3Tl7BBPtXewCeptd4PMqyBuXlEaxMyNIU7PEY3/zVpLcWKOmFexSyAO+nLBS?=
 =?us-ascii?Q?nsfnHUOKXgMswC37lANuu53iArUWl7xuB6DnqiYTABhg2HTIvVevJRblbcvS?=
 =?us-ascii?Q?G5DySPYL0PTAV0uA4792lZuJz/tVqmKg/Hm/Z3AaXAhTaNcckasIj9jLwMJO?=
 =?us-ascii?Q?v0LXPN9l7MGn5dVrKG+/E43PAG9jjFCnCdvp4eiKlUjHeGOGRGcd3oXsppIy?=
 =?us-ascii?Q?PzLM/U2V2BolcahmfXuuER02ommnZjTvAqJZdY0/XJtTkA7kAoMCGckmb5f2?=
 =?us-ascii?Q?GdWKfBgvcOICjPEkISFFitsVNRWv1JN4jVioIR/AnoCDFuszDOqpLarAJwVO?=
 =?us-ascii?Q?BwbVJsltqYV1JYWviWSTQM1Mh5S8jY6H+l9S5IDMufCQPltrvrtEwvspES9p?=
 =?us-ascii?Q?C2W1vMcOVJ03gny3lZw5FadjstGOhgX671L1I9Dk?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f16616-d9b8-4a77-cf27-08db6b201275
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 08:36:09.7176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmW7tacecUAjZPNDvVK33DDzxm5eEYSDFXQVsXTvlCaFEXMVs2Zhh/lNAHLPYdJb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3293
Received-SPF: pass client-ip=40.107.113.128; envelope-from=i@zenithal.me;
 helo=JPN01-OS0-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This patch series updates the documentation for
canokey in QEMU.

Kraxel, could you please pass these patches?
I still do not get my gpg key signed.
Hopefully I could meet some QEMU maintainers soon
and then I can send a PULL.

The following patch also needs to be passed.
https://lore.kernel.org/qemu-devel/ZE5z+2WbvVpTa82H@Sun/

Thanks,

Hongren (Zenithal) Zheng (2):
  docs/system/devices/canokey: fix recursive cloning
  docs/system/devices/canokey: update implementations and web console

 docs/system/devices/canokey.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.37.2


