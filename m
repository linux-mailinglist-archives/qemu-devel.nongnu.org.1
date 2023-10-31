Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 613837DD708
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 21:26:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxvHp-0001Gk-Fr; Tue, 31 Oct 2023 16:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qxvHn-0001Ga-Hm
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:24:27 -0400
Received: from mail-sn1nam02on2043.outbound.protection.outlook.com
 ([40.107.96.43] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qxvHl-0004Jn-Cv
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4Jz5NECU3GIrNhsHA2g/pns5TF5EUFAuKWdN+XdoM7+hwxRgGNxcU1ga87Oh+16MNZPfPcwtlJVd5ToRS1AvwTAb/XegE42es2gg1okxSjcuwjrtys4cPYMHT0VdfFXs+LKVwH4dPZi7yi3R0b4+6h8IjquVD3sChUCe7hNTpV0OaJbxcBfln9aJrX/De9Mr5Tf3NIwcH1zbRxPrK5LBzhKCQonHuGEXeTnogqGw37K+S6epvFi5LNaJWcXhKGuDw9UMmk1idhkKRm7FaxnhbvPmyWoQByWwy+NusssHP1Xjn62C8iuVg1VulSzDpTdiPenxcerfcnAosWDUPJT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KL9t877ZDfBnNIxdxSj8WnU1DGDOizjY74SPgWm2zaE=;
 b=gE7mxyaj8YfuF7aoprwUB3AD71i03bU/l+ZsckrM6JXWe7lzc8rAWw2SC27st/j8m0mW1XEy2Spig0wHa1S2jlzKmZEP0WdlER5rFiKMFEBBXe1ffdSLmiudr3KPKbf+3j7eC00PndP57WuvhiMu3juR5dwagPzrv7oFmpzMmZ2qaKjCi+PcE4nBWw89/MXxlMsknZNFJarUiCOQ8Vxsd92II+0X6bZWJpFT9Y70tB3vfKxdN3bZkATINKb1eylrSrcXz785TXFA/49OPrNF0MWCZZvdOEOHnicywb/5d7KPsHvt8UVPzAgVOcvgqxOU+aNCZMckCaFNgaj8ua1G6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KL9t877ZDfBnNIxdxSj8WnU1DGDOizjY74SPgWm2zaE=;
 b=byQGAQOV3FNZZ1XG6WlLojTXwgdrjBz/3ygiXD5D8e/ES50BRPpHq8Xm05F5BVRI6qMgPN+TYk8sGux8tzGwZy/g1pXBgfdImrVMVjDNo9ncHFOsD5Y/uOj0EONpkvIu6Up1fXPh+qaY0OBMnNucPQN2cRtCYHc2grJJe6E652Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 20:19:18 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::bc0e:2b8d:357c:675e]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::bc0e:2b8d:357c:675e%7]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 20:19:17 +0000
Date: Tue, 31 Oct 2023 13:19:06 -0700
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clegoate@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: intermittent qtest-aarch64/xlnx-canfd-test test failure
Message-ID: <ZUFhOhQpj6UVawyZ@amd.com>
References: <fd2b7868-2ac5-64a1-d66f-3025c1da6bd1@tls.msk.ru>
 <76165393-f7ef-40fb-883f-ba8654856467@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76165393-f7ef-40fb-883f-ba8654856467@redhat.com>
X-ClientProxiedBy: SJ0PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::20) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|DS0PR12MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: c65ee22a-5eed-4558-5c9e-08dbda4ea87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEEbDHo/tChzrOtk5dXoTsOBW6xJYHcmLzlsqfSjFifqe/aOpzP3FCCcsC4aiMvnC3ZLBUNoXamriAdwtuVCLBNpnCVL1S/5hP6d+1MNYXamf2covF74dxOQi8qiSImRGlD4Un+lCU5YFNjBl4tzqSa0pCMG5h/jl1cGHywH9h3sKoIue8nV/+EPiinwW6P110YNJmC/+TgKnNA3ML2yklvjw/hKgJrBBuyRbYK8jcWiWvSjxbMFEcsBDw+FBUUxERKmODg6xafPfRvSzyZrfFNIK+lIuQvt9ys8um3HVYV2UGpqHWa3wZftRFVp/qVfKSsmqgnD3BIRi1zORKP9rGBpPf5I7yN+z5KkZXEA9DNPIhYjTOV2FWGsyIOCaMDjPyUW5lTxeuJuVRRRGdvkzuhlas0TdjpGuIfRhzJhz0GiuQU5ZOinb61X98GbK9ucBNILKMUSuTsppS+B91rXOBbGK5hlBi8ddtRzpKRBBtRvf1kJCr9iFMhHqs1+tv39WNapelJUyQviFVSQewJ/S0VNWOFxQTlEmzT2ldYlrTZKRr5C7oAM4F3j71odYhF9zzxaECW+9kBsx44jMoEa1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(84970400001)(2906002)(5660300002)(44832011)(41300700001)(38100700002)(36756003)(8676002)(8936002)(4326008)(316002)(54906003)(26005)(6512007)(6666004)(66556008)(66476007)(66946007)(6916009)(2616005)(66574015)(86362001)(6506007)(966005)(53546011)(83380400001)(478600001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGRTMlB5YW9tbzJYcU91UWczQ25wSkdybVlpaXQ3L25EOW43dktJd0ZFQnNS?=
 =?utf-8?B?MlZGNllKS0FkRjdIRkRuZzhHdFRGSC9pRWVWZlUraFg0SXVFSGVHcW1sNjRU?=
 =?utf-8?B?Z0grZ3JnQS9Sd1lFSE84TmRsN2dpSlIxeUFsY0ppU1VEeEdSNldPSS9ZRndK?=
 =?utf-8?B?d252NEVvWngrYnc5TFh6bEp5Q2dmbUpjanE5N3cyVXJlRTZDbW5vM2FSbEZr?=
 =?utf-8?B?R1VFWFZTRzJMZU9idW9JVjVHc2pFZWcwWGkySHBVUTAya1BMOFJUYS9Mc1Vq?=
 =?utf-8?B?NUYxVVFjSlFtOXFlRzkraGl5dGd6ZTdjMWRjNnNiOXpKUkxsYTlEUTZkQkFL?=
 =?utf-8?B?S1Nwa2NWNVlXSnBhaEx3Nkgxbm1hSmNLdFBCMXZQUHl0anNyTWpza2FFZW9P?=
 =?utf-8?B?RStmelRySzRVRFMwS243SERCcTFWVEg5ai9OTWVMMkl6ZFFtd2E2TWR0Q2xY?=
 =?utf-8?B?MmpCb1hmS0FXSVZESWRSOEp0bFFkaDBnRko0amxobUgxckdlYWM1cnFZWENY?=
 =?utf-8?B?UUFTckhBNWYzT2tVbHQ0bkhWUTlxamRjTmU5OEVRTkZZL1prYWMvZmJ0ZThy?=
 =?utf-8?B?MW5oNVhlazV5RDdDbXluNGUyUVhrRlArelpKd2UwWG1LWGF0NndmalpWaU0z?=
 =?utf-8?B?V0ZwMmFMYkVFaWp4aXFZQnJmSlZHNSt1TzJlcmNTMUY2dWJrT3NiZ2FQaTlE?=
 =?utf-8?B?bnNvdzlWdWJGRnpmRWRrODhrS3p3UDYrOGtkK3VoeUttQm02eTVjUHRHbk5O?=
 =?utf-8?B?aHpHZmdTOGk5eTFYUXNvaTd2MnI5TzdBdjlrcUxNMUdEZUlUN0pjU0NVbkhR?=
 =?utf-8?B?K1V5YkJ2S2M0UWdGNjVtYWlFNlBBR25SUHN5MFRJdVRzSnV3b0lKUEdGWHFH?=
 =?utf-8?B?MWhMYm13bFU2MjljV1F4RmxBTWNYc1hvRFREeHZuUGIvWVMza0ZkYmlDZ0Vz?=
 =?utf-8?B?UitJdVo4RkYrUTdvZWk4ckZEVjBZSGRyY1l2TUgxZVhQTWpOYjEwTnlTclFJ?=
 =?utf-8?B?U0VzSnF4Sk81QnI5YThxdjRLbG1LQmNTUllGaWYvcUVQTHFIcmZ4UVk4YXR6?=
 =?utf-8?B?WFg3d3JxcSt0Ym5mcGdyN3phbVdGbWxWbDdVYW44bHVhOGxBcDJub3pzc1Vl?=
 =?utf-8?B?VkRsNFR2czlZMmZFV2JiK1lHaFc1K2NuSTh4bkFocU5uaS96aTRFdm1PMUJP?=
 =?utf-8?B?TGNSNWROc0FxVmlPV0FxeWlrZ2xFRHdqNCtoNjE2bTlIVjFvY2JVZzVOWDYw?=
 =?utf-8?B?UGFXWHFWUTliUnpobElWV01HNVowKzVRMGdYM2xiVEJ5RU13NWRiVWZXYkhE?=
 =?utf-8?B?cGxUaUN0d2lEd083OER3QWRHR2llU3o2VnB2YVBIb0owVncvbSt2UlpzWS9l?=
 =?utf-8?B?ZEVlSDJPbzhXZXhzdVBLdUNXTGYzeGtOMWlvSzJQNURpWkhTN08zcFFNUlV3?=
 =?utf-8?B?cnpKNk42dGhmNThJT1FjZ2MxTFZzVml5cjI1M3FicjdRZnhKMGU1RkcvR1RG?=
 =?utf-8?B?aE9vUkpEVnVYQUI4cTFFem1GSGdzdkEzOURSbC82S014S0wzdmNIQ2lkTzJx?=
 =?utf-8?B?bFJGWVVYbDV0SkVBTkdCVkdrbW5ndk5GeDR0blZXd0ZISUdEcjRSOHBSTHZt?=
 =?utf-8?B?ck5aSE91SVRKSUxRa2MvWW5yODlrTU5IQWRBY1lUQTBIb2xoM25nTndyczd5?=
 =?utf-8?B?ZWt5VExheWg2SWRnZnlIQlYyL056cFlCd1d1MXBrM1djNzdSSldBb3hwWW9Z?=
 =?utf-8?B?Y20rVVhqcGQxNVhxRERaSm5JcElva3oybXZvTll5cGdOOExHdzNkNDVEWk1m?=
 =?utf-8?B?a2M4dGhaUmhXS0hPMmpqblYvS0hJQXFuL2tjbm5BbFF6b2xCeXVraEF3QjlO?=
 =?utf-8?B?WWFVMVIyaFF3TTIwNVduZ2Y4cjJpWEUwS3pPdkdBZWhsZ0R4VXRyNTc3U2o4?=
 =?utf-8?B?Qi9LR2NMWTl0eUl6UXVrUWNkQ1BEcnJMYktKb0tINTF2TzhkMVlmeDVvN1NB?=
 =?utf-8?B?ajI3cFNMUElFZ2N4dXJvMERmamVNZUIydUVDVFZFSlAxRkVIMzBNa2ZSQUJx?=
 =?utf-8?B?TG9tbzdZZmFPZm82VnRjWWNIQU51OUVkdUxSQXlBTURLSXRBUXp1ZzNodlZ1?=
 =?utf-8?Q?u2FBcXBnxmX44QZABDUQUUWsi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65ee22a-5eed-4558-5c9e-08dbda4ea87b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 20:19:17.4105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2mWo9NHzxNYt5Lr4iYngtphHZBG377bfQYEEc4OREBR2SlSgw5otaR8uoRlEM0MHBuqQlVDhEqns+VccvdwUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533
Received-SPF: softfail client-ip=40.107.96.43;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

Hi Michael & Cedric,
On Mon, Oct 30, 2023 at 05:19:38PM +0100, Cédric Le Goater wrote:
> On 9/21/23 09:51, Michael Tokarev wrote:
> > Hi!
> > 
> > While doing stable-8.1.1 preparation, I've a CI failure of ubuntu-20.04-s390x-all here:
> > 
> > https://gitlab.com/qemu-project/qemu/-/jobs/5132720046
> > 
> > ▶ ERROR:../tests/qtest/xlnx-canfd-test.c:265:match_rx_tx_data: \
> >    assertion failed ((buf_rx[size] & DLC_FD_BIT_MASK) == (buf_tx[size] & DLC_FD_BIT_MASK)): (2281701376 == 2147483648)
> > 
> >   qemu:qtest+qtest-aarch64 / qtest-aarch64/xlnx-canfd-test  \
> >             ERROR           0.77s   killed by signal 6 SIGABRT
> > 
> > Re-run of this test went successfully.  However, the assert looks
> > a bit scary, and the fact that it does not fail in a reliable way
> > is a bit troubling too.  Is it a flaky test or there's something
> > else in qemu with concurrent threads?
> > 
> > I don't see this assert in previous test runs.  But ubuntu-20.04-s390x-all
> > test fails quite often due to other reasons, so it isn't conclusive.
> > 
> > Should something be done with this?
> > 
> > The testing is done for commit f2fc49c302036315db6e8c9f74592decc3be0476,
> > which is in staging-8.1 branch only temporarily.
> > 
I tried with staging-8.1 and didn't see this error. I ran it with registry.gitlab.com/legoater/qemu/qemu/fedora-i386-cross:latest on a x86 host machine. Can you please share more about how you are running
the testes? It will be greatly helpful to me in reproducing the issue and fixing
it.
> > Thanks,
> > 
> > /mjt
> > 
> 
> I had the same CI error in job https://gitlab.com/legoater/qemu/-/jobs/5416150239
> ▶ 170/258 ERROR:../tests/qtest/xlnx-canfd-test.c:265:match_rx_tx_data: assertion failed ((buf_rx[size] & DLC_FD_BIT_MASK) == (buf_tx[size] & DLC_FD_BIT_MASK)): (2281701376 == 2147483648) ERROR
> 170/258 qemu:qtest+qtest-aarch64 / qtest-aarch64/xlnx-canfd-test           ERROR           0.49s   killed by signal 6 SIGABRT
> > > > QTEST_QEMU_BINARY=./qemu-system-aarch64 PYTHON=/builds/legoater/qemu/build/pyvenv/bin/python3 MALLOC_PERTURB_=60 G_TEST_DBUS_DAEMON=/builds/legoater/qemu/tests/dbus-vmstate-daemon.sh /builds/legoater/qemu/build/tests/qtest/xlnx-canfd-test --tap -k
> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> stderr:
> **
> ERROR:../tests/qtest/xlnx-canfd-test.c:265:match_rx_tx_data: assertion failed ((buf_rx[size] & DLC_FD_BIT_MASK) == (buf_tx[size] & DLC_FD_BIT_MASK)): (2281701376 == 2147483648)
> (test program exited with status code -6)
> 
> I could reproduce on PPC64 and s390x systems.
> 
> C.
> 

