Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99E7D9F0D
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 19:54:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwR1W-0004ug-Tv; Fri, 27 Oct 2023 13:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qwR1Q-0004tE-5Z; Fri, 27 Oct 2023 13:53:24 -0400
Received: from mail-mw2nam10on20613.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::613]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qwR1M-0007CZ-RO; Fri, 27 Oct 2023 13:53:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFpzU6j2Q++w/XdQWVo7nOnw4X2co8hxP2L0l+mtxQZMRNzqX6fH5NeSGtR6byTa1AAKoC2CGCprpcsx37xNfTcbTD053lMCj/lRYOcINUrnQomDII/7IKkNXMhEF32+mvjtXAtz6zd/IAR8BBQcOhwBgFJY2H9S4s3d7IeBBj9DpxZ4GMz9yJ7uN6ECeVZWMSrTi7bcI/L8oMuoCJbd/QYJhmtT4bgHUuj1+wGT6DEJV7J1/lQh2fmd/G89T5ITs4o2e9iLFlcIdocOQT+R+VB2guursf8OYJwvR9Gj3tfXoQ3m/wNWH75OB1D4Qyj+GaCexOVqht9DR6sa7YXxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGQQzQGvh9OkQJ830hgNOQZilgpDHlw7JFdOrIfgRns=;
 b=TLe8kGKvEVX7f3+IiVv77OM1LNSQg4WZ8RwUL1iXf+ucyOdo8OVfCLhSzl1B5OZZMHCi4TYZ+Xv5sqM+tMtCi4GMFZrlt6HlVe3iSkXHqGEN+r2ymvy+e6SjwuVvRLZxKJokYOlO9l2OSowC3LbQab+T9iK0BPyZE0p+96eUVDABMCWVdE6dF5inH9J3RlQP4Rg9inh3VrgLYbr73n2p1J76RL3s+eyY3S89ADN5UrYKDLbjxiX8PazMqVSl/TTX6mUv04oLF0I70vQlz0fUDNpmQG1dMOMCxZKabP/EmvuolecQcvLGLI6CLs5GdbqosbKYtXzjeRv2fIhtNMwzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGQQzQGvh9OkQJ830hgNOQZilgpDHlw7JFdOrIfgRns=;
 b=GNX10iCAA5Rsycnm5eEXi4pbqX9XT+Fw5BoZph0yjTUAg4o6ZRDg35HliyEz/waK1zdqsbVK0RYMrVHap4VMFPrBYmZp8iomp43eTeOD4xZX32zQQiZiGAqotsSs0D5fLeYUC4Gghc9qajZ2ub0fY1fq+cvuftm1soDN5dM4o3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by BY5PR12MB4869.namprd12.prod.outlook.com (2603:10b6:a03:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 17:53:15 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::bc0e:2b8d:357c:675e]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::bc0e:2b8d:357c:675e%7]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 17:53:15 +0000
Date: Fri, 27 Oct 2023 10:53:12 -0700
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Vikram Garhwal <fnu.vikram@xilinx.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Add the can documenation file to the CAN
 section
Message-ID: <ZTv5CEOPsHEzDvAV@amd.com>
References: <20231027060931.242491-1-thuth@redhat.com>
 <76180120-130b-9a86-b86d-ba3bec43d9fc@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76180120-130b-9a86-b86d-ba3bec43d9fc@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|BY5PR12MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: 893cc9fc-ebd3-4528-b166-08dbd7159844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdSF8KUKzQXt+2/EjStOg2Wy0RfWQmtWlJudXFBVbX/X7Ng68wVbw9Sarrp46lntFse7XG8t6ErUpxoUIXl0cfY5gvgU5P4YDGN25NpfbjzGOcSGSJoZUAhGXYlcjACH+4zYQadyGLfWQnM+hptRwAUySTeLM41P7tSiORlPsNPsZEPoRwiIN1V+a++ZnT2HiPy5RPW40LJ8Hopkd2O5E1S8DeCdN2+tFxB7HczMsa+XrjsWbYQR8qhmQjFaqE12CO7JBdApUWOadZ15w7diwejjphoiwpheMkulD8n6ZiyOiMRzGyEfBTflaAgyOzUMWkxAu1zfWGeU1iJCTndJUs7hAHpQPUXMAxmsR3MaVQ8vY9XvuA14+JUWdFE6P8PFF4UgMR+hgtkwm0EH6iHcBbmHuSx9gG91i8puVoy/kYZJPZosYC6bz0OheCxxOK603pxtGOD7I354HRkBN7qT058bfbaQ3SCkWziI2QJC9kSfcYF7HsmCqxSTnBDLnjODKUKdR30deWnWW6q9TsEYdYJuOF25f34CwaTxwPb9Bq1EIeH67WtAQXegN1Bh6VFAqvN88EezZs7BWFG6SUCPLBzOSSxYXfkCDyRJlWYLtWCXFBuuxRip8NfnNgsCPus5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(83380400001)(53546011)(6506007)(6666004)(6512007)(66946007)(2616005)(6486002)(478600001)(316002)(26005)(66556008)(66476007)(6916009)(54906003)(41300700001)(5660300002)(2906002)(86362001)(4744005)(4326008)(36756003)(8936002)(44832011)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWRTNDdYV1d3N24yVlUwZGZ0R2FBenJDeVBOWmtOZjBieXBObzk4SEMwUkZU?=
 =?utf-8?B?Ti80eGdPUXFEZG1PL2tNY3VPZDBPL0FDUW51WjlLcWtYaXZoRnRQVGt0Q0Vo?=
 =?utf-8?B?V2FOUHNXTkNLWHBDZ1krbWc4OFcrSU1BSlV2dnJGbE11aU1oanUyYXlNODZQ?=
 =?utf-8?B?bEx3YUhxTTlTdXZRSWRuV21iblB0S3dLWjJwV3lFRzhTZmo5aDE2bytkN0Rs?=
 =?utf-8?B?T1ZLN1dwalZvbjZWaWNYQVhZT1M3SVV4MGhTdUhJc1hueUUrbEh1MDFOZlZa?=
 =?utf-8?B?OHRnR3pndlc4VEZPREFVWWNxVWMycTBSTWdUR0RIS2VuVVVFMTNiM1d6WUNh?=
 =?utf-8?B?UnpHQk1pbWVmQ0lFblptRzhybjFUck9tRnhNRmZicUN1bVJzdi80SUtJcElp?=
 =?utf-8?B?cVRLVnE2WE9SOUtsN1BWRFVoSWRUbGtsNHRDUDJPemFRaURvbHlJNU8wMXdY?=
 =?utf-8?B?b09zamlFUGZ4enZVQ1Z2SS94Y2UvSXd4cEsrQVZDeiswRjZFalovTVlBbEs1?=
 =?utf-8?B?OU5kcFRqODB1djZXaUU5Y1hpZVRESHhYdHZlRS9PNEQvN3BFc08xNnQ3Tmw1?=
 =?utf-8?B?OUtwQmFrWDdHeGZ4cENJMjJadWJRREFsOUliTUVTNUJkUGtpaVdOZGxXcjJM?=
 =?utf-8?B?Q0tDZTFVcHp0NGVxRW9zYUxjYmtyRjRFMUQ2a2VnNnY3QUg2eC9SNkZHK0FP?=
 =?utf-8?B?d05PYkpWV203UUMyL0RuL2ZybTFzNG1YWkQxZk5mc1ZSUWtKZ25OZEo5OWpz?=
 =?utf-8?B?bm5xc0Y5d2c5VU9TS0V6NlhUTm5TSGJkZXBRVEJkcUYyOStMNUVldDZlNWdm?=
 =?utf-8?B?bVMyZ1A4LzNNSW9QRDN1Q3AzVXBYN2ZIRjR6RTh3OUo5bWNWN0dTUGx5bEhJ?=
 =?utf-8?B?NHVveUM4RjR6SG9IMFQxVnEvV09RN0FXdWNkTzFVOHZVcTBmSW5OSGRpK2pI?=
 =?utf-8?B?bkFWUTcySGRaeWUxVDZqS3BKOExKSTA2Q2xIQ1lUNllwR1ZjM2RNcWIwUGdQ?=
 =?utf-8?B?MFJkRkZuUzlMMXNrd0ZQSE1yNnhTTlZ3VHNuUElvNTd2Qk5GdXBYT3FFUDNv?=
 =?utf-8?B?M1ZKcHJPM3dydzdZTFdJazFaaDhZRE5QSkxXc2Jscko5VjEwQ0piSStsc3ZY?=
 =?utf-8?B?Q2swTXVMVVpyYUErejU5L3R0WGRJZWxMTGhGRU41V2RweWR0cS9Rdkdnc2tu?=
 =?utf-8?B?cEZuMm1RdEtpYVorTjFZMkpNYjU4R1ZZQi84YVRRcnBkNjgraUtaY1dTditQ?=
 =?utf-8?B?NmluVnEvR283ZmZ3dUgxend3MmgrM1l5by9BRXY1M0RsUS83ejFoR1BvMnlY?=
 =?utf-8?B?MHUvVC8rWXFSc3QxZEZaSitvYXJDMVdqSng1eE04NFJIK0RyU3l1Y2NueVZQ?=
 =?utf-8?B?ZTl2V0ZUZlNQUlVEUmhtN082NjdQQ3JJdjVPR1FiL3V1NStWcWQ2M2o4cVBW?=
 =?utf-8?B?TmZQR0kvaGZ6aEw5NnJxYm5XTnNPSnBVSFM2WENZT3dVdktqeTdKWFlOZUlm?=
 =?utf-8?B?dzBtZ2s1RzlNMytUamdZdnRRbENtMVhTNkFjYzhJR3hPM2ZCd25iblRkc3FT?=
 =?utf-8?B?M0Qxc1NWUVRjMzJURGMyYVFLK2szSWtsRDBCMnVKb2N2cHBQb2szTHFFNmhU?=
 =?utf-8?B?ZndoVThXc0ZqNWpmaE9OQnh0Q1JTTGZSNEVaUnBEcmQ5eSsyRENpQ1JVbXdj?=
 =?utf-8?B?c053WHAvUzBqQkNxblB4SFdjK2ZnTW9BM1dWcitHbmdLT1JmcUtOUWRRTmc2?=
 =?utf-8?B?d09VV3d3SUh0aCtSbm82LzlPOHVzNlVtSDVQMWNLeWRidTZiZ2RtN25TMlBx?=
 =?utf-8?B?TWowV2crSmp3ZDVIanVyNkVXV2IxeTQrWjlhM2czeStpbWVZRTVhTG5lbDNU?=
 =?utf-8?B?N2NxdWtOYnZ3NnF0bC8wRFpsd1lRWUZRdStrWEV4VzJRd0REOW1qTzB4YXhk?=
 =?utf-8?B?MkRCeDdHK3pZVm9JV04raHprb0ZnWEl5aGFZaFFidlNzZTA4TjhxanZvSm1l?=
 =?utf-8?B?Vldybk9UNEc3V2RUV3MydXAyMlRndlpJTjZSNzJhOU56Ti9TMDUxanpZemJ4?=
 =?utf-8?B?MWoxRHlYUWRydVdIWGxsOFNnK3hlck9kZEY0TktmdVlGbWxWQjhoaXFKU3lJ?=
 =?utf-8?Q?zOTfCTSZu1CeKa5eoQrtsOtxs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893cc9fc-ebd3-4528-b166-08dbd7159844
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 17:53:15.3859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8k6lrrGrOT0ENTaKzy3UjLf5SqkkH6KMX05TZ25aKd8aYAvXVssVM33a9IqbDlCUN7Uk8jGGJWo7kAyBzG7W1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4869
Received-SPF: softfail client-ip=2a01:111:f400:7e89::613;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Oct 27, 2023 at 10:44:35AM +0200, Philippe Mathieu-Daudé wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> On 27/10/23 08:09, Thomas Huth wrote:
> > Add can.rst to the corresponding section in MAINTAINERS, so that
> > the maintainers get CC:-ed on corresponding patches.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   MAINTAINERS | 1 +
> >   1 file changed, 1 insertion(+)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Vikram Garhwal <vikram.garhwal@amd.com>
> 

