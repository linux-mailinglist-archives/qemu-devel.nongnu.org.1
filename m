Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E017923C9
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:06:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXdZ-0006q7-Oi; Tue, 05 Sep 2023 11:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdXdY-0006pv-99
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:06:40 -0400
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com
 ([40.107.237.55] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdXdO-0007ws-GP
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:06:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCKAqTgDagxIz6prXXkOnoVdW+vMKltMIzgQL5GXwM/uyeZVWeeP1GMIDQdLN/B4yrxu/tznEaLrBDdSAAJyzj/3B8QEaB/FqKYIlkQrRRUOHHeTkFUOUo1oqU7B+IFO+5jfFfSvhkSZkrNfxmOo+6dq/d+cwuKA37mEAIodGcXnbG40yt46LLuU7evVT0xURXKsv7emUcezQ/SQ6ZVjPTcJoot9eSezOAJZ+/iuDd07zCl4U2ENCs18GrAyGHvk6qOA50B2C7MRcLcUUgH+zl1Y23qTLL6MWSXKcCQvz02AH2XAYQnFgQdpk6rCMEerCu8snOmpZsqxzt6mUFEndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlP8gU6efLHHAS6K6YgWJpelN7OgtjD0gNELcFekKy0=;
 b=OUUG8V9TIKdfvIKd6zlrZCaw20xs9ipMgAXRmNVLqbEbPlZpfoBBCfETd6fX0JDagnTQDOFPGba6aBGwAsZ/41QP03fcmmfsXIinS7VjuLfRVeq9en350EWBnKwJBkpvJC4jLJJvcX7liFFV7NIkR3l1Ll/d5OHtdJhpU+kYvKztHX+LFSdrMhZLZ8Id5dILXuIHb4/kw4dJ9JNVHlMEfWZJGWcIqS5lLKBb8GrPpDPqkPjWUSpDHKYOC4xx1pefyUNtLidkm2ueHJfqwE+Q0Vk87wUNA6B684Y3zjIhJfnBdKygQNRVzmInw+dUQixvvauzv+2U8F+7NDOQV9HLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlP8gU6efLHHAS6K6YgWJpelN7OgtjD0gNELcFekKy0=;
 b=FqabqNM1qsFlCPPR1ZMlsKlp7BMD3QlewO3GrBArEuK4lmKPJb9FiRXvEIOSF6pM/eNT5sM3EplVpkD55psPlsYgJPxscphHvRYnPHm0cf+wfCttDFP3dtzMWAlu2U5cBxN/j7VCuEnsOrPfvFEQhGY4uwac8yeoQVb3iqt30uM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 15:01:20 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::1be:2aa7:e47c:e73e]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::1be:2aa7:e47c:e73e%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 15:01:20 +0000
Date: Tue, 5 Sep 2023 10:01:09 -0500
From: John Allen <john.allen@amd.com>
To: Joao Martins <joao.m.martins@oracle.com>, babu.moger@amd.com
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, william.roche@oracle.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] i386: Add support for SUCCOR feature
Message-ID: <ZPdCtajSXBxzbovL@johallen-workstation>
References: <20230726204157.3604531-1-john.allen@amd.com>
 <20230726204157.3604531-2-john.allen@amd.com>
 <3856285a-a612-382b-905e-77ac1627de29@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3856285a-a612-382b-905e-77ac1627de29@oracle.com>
X-ClientProxiedBy: YQZPR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::25) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|PH0PR12MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a808e1-5ed3-4ab9-9c26-08dbae20f688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i66nqEcOHXxpEh1GpUZIR4VHEBFexoiS61IacTvbQ+PioNFMmCnImPhvp/F3cp4PDlDUTUs5rB4SrppIU52aPwpz/cknlPnilz1Z+egifdqQUbOaZokl2RLhpTL5+VvkKSTLdFeRAyBi1NykKsJ0jKuwQQ0nfXQzRXxPLHOIddLSUuIfBtbO+/vQ+3peaTOOUOT1FS12FdUuCrG7w5MDaN6QOm4R0EIiF5tEEcZPQgf6groUB+Qe6v4eum/+Su8rj8q1EBXS/nolADuhRDqkYj137BgOSjCuainkiaV0C2DCicRQhUUuo3ebV5XXE6AbNNvpyGXN9jywfqUIDKHoZRfhyTLUQt/nAvSbqQoJPnOnpjbFbHicZINKhbZBkgfEEpGQkGxxZ6T+v2n2kEIR6wL6LRKe/h5Uz4SYCxKdCo6ZkabFmPAafeAd1jk7SvryuOlmwLniYHQ1z+cacT+QfS9FEJ7yF+FNWVAdezrFlhPsFNSw10sB5lBJgd44jib+ZDzbFdjpza9U8GqtWMYxJVH0pl9RmO1A/5zI0k5NrYE0RQgNVfwYWVpBlt4rqU/t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5995.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(6666004)(6512007)(9686003)(6486002)(4326008)(8936002)(8676002)(83380400001)(53546011)(6636002)(66556008)(66476007)(66946007)(316002)(6506007)(478600001)(41300700001)(5660300002)(44832011)(38100700002)(86362001)(33716001)(26005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W30nOiy6JTIImpSnjMviyk/qIqxMH1GkNFZqeTiGPokQZ1//UGrkjbuAE1DE?=
 =?us-ascii?Q?ZJbqW7XntcBFV+dWksSNdc8xJ5gjNzmn83+V85Gby7EQNAD5PT7+yO3iQbWN?=
 =?us-ascii?Q?UStQCb+r6+Iaz5cTrMZuyjZKABnyQuUNy3JobcF1Dfg4BzbYAVuMLjLSWNyj?=
 =?us-ascii?Q?zQmNUDgYqftDVl7QWjv3Qa08qTKonN7TCEOVYac8EAqG08NEowWIdX0PVqty?=
 =?us-ascii?Q?yrUAh5AbSho6QXNghoBnfg9N2hZoWSUo2VCcEJ3c3hIom/0riwEK4XulBoiN?=
 =?us-ascii?Q?JPn1tTfWdxxFxdhaxyxXKFNttA5DKqk0OHoGipyfqkD0pXwwsAUxmwMH6Ux0?=
 =?us-ascii?Q?QixRLv3ZkcHsnLSDzcOvdewixIZvE7NkZzc+kYMe++EP20pgPMYGyVmxGQI1?=
 =?us-ascii?Q?rZ6a7AtlkSFXdhXtdW4Ku/QaLlD3MD29ULoIUF5ukrd0A5cP7leFoMy6LxsU?=
 =?us-ascii?Q?/yCI8J/gvUhUAg0Ut/taLfa/LhHGuJ7lIHkFUpoIZwCTEE6D9hiGYgkeg3Bl?=
 =?us-ascii?Q?sNkMdJxkroeQkOYWJTMkCSffN0oyCxiN4SoaOeYAJ7by3rYFFKpyoQ87IrRP?=
 =?us-ascii?Q?ySXvfCAz+N0770/3Zz1cHAH0lCU7xVCIUL5nHJkWsq1xlldBJA8ZGUnukRl9?=
 =?us-ascii?Q?4V/vYbZ+5y8fISWvrbBrSyOlNtbd9ONJQSC0ODMrVrjHO0xVINqNwCIyJJ9k?=
 =?us-ascii?Q?2dtpQKxt1lgBZwQK17vj5LfbJhaRYzDV48gkgSUSi010QhGWQJBwrR6YHRMI?=
 =?us-ascii?Q?kyJ+yzlJG1GwM+kZKHVL6awJKc1eicLi8/83pFm3Xvb2TlQbDxm0RpsUIIgg?=
 =?us-ascii?Q?6gyznwij4msRc5H/IbImuW3+GRuw/w/NPyZl+o6v1pVz5fIBMLJ0OcwQyYNG?=
 =?us-ascii?Q?ZYLzn8KWivOpsYkdZxNxjw420yl/Azmf+y15o6JF66jKRXfzdPW+p/stnA3H?=
 =?us-ascii?Q?dAa89A0H9S+AIjCbOb0Y+6BeFBF9IwAD3U9qUk56+Pw8+qLRueuR/CC3A5gA?=
 =?us-ascii?Q?Xcsx1Uk1zlDTTD66DyB7yCxLWEYClbKVQCyLHsHO2SbJWmFpi7E6N6RBL7Np?=
 =?us-ascii?Q?tQLcL0JA90qAIrn9xeGgZM8DuEToclybS/kGz8nbMM+/V4gcWGrZfrmjfVYC?=
 =?us-ascii?Q?v1ODxoviE/+5ZwoMD8+N8gjp8yDivFS/NGZG7Fb48169le5yXRqXrMgeBCVp?=
 =?us-ascii?Q?9gn0bLOuhqoBps81nriEBvar8eCOzuSwyvDrEB+vw5r4Ru+/lj/7Yul1XYF2?=
 =?us-ascii?Q?gMgzChuvAA198C325fyh52t72znvkAQHvtNu40h3TV4ujc3pTjhKQL1mZDq9?=
 =?us-ascii?Q?XdxRjnw/HQY9KhBvQ1vuRilJ2Le3x37+LJwlBNSNCHipejq0vosetmawRbwW?=
 =?us-ascii?Q?C7b22pWDu6XcSlTAhSGE2GNM11+V8Xp1NhMLwFzYxsDu1MPgaaEGbSeGjDVr?=
 =?us-ascii?Q?n11PrTcunilfX7myx5pnc+YV9Hbup13qBmr+jGi3GDRoCLER8sBQveKSDL0u?=
 =?us-ascii?Q?u2+Q8cmeYwlDEY0iHWt+YtU0rnvURSFytoLCzO1WrmyGBEbuJQxRnpuWx9Zo?=
 =?us-ascii?Q?TMzzJrP4DiTFp8P7kcGIGvasynL9qXwXw3qLgJQW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a808e1-5ed3-4ab9-9c26-08dbae20f688
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 15:01:20.7384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfptgMYaRx8X64UTLymUSHSyphVVH5KiCojYj93zbe7XkJiY9/cCpVb1M/iXhwaP4a5320sgw23SGMkZAxhphA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5401
Received-SPF: softfail client-ip=40.107.237.55;
 envelope-from=John.Allen@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Sep 01, 2023 at 11:30:53AM +0100, Joao Martins wrote:
> On 26/07/2023 21:41, John Allen wrote:
> > Add cpuid bit definition for the SUCCOR feature. This cpuid bit is required to
> > be exposed to guests to allow them to handle machine check exceptions on AMD
> > hosts.
> > 
> > Reported-by: William Roche <william.roche@oracle.com>
> > Signed-off-by: John Allen <john.allen@amd.com>
> 
> I think this is matching the last discussion:
> 
> 	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> 
> The patch ordering doesn't look correct though. Perhaps we should expose succor
> only after MCE is fixed so this patch would be the second, not the first?

Yes, that makes sense. I will address this and send another version of
the series with the correct ordering.

> 
> Also, this should in generally be OK for -cpu host, but might be missing a third
> patch that adds "succor" to the AMD models e.g.

Babu,

I think we previously discussed adding this to the models later in a
separate series. Is this your preferred course of action or can we add
it with this series?

Thanks,
John

> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 97ad229d8ba3..d132cb3bbbbe 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4731,6 +4731,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>                      { /* end of list */ }
>                  },
>              },
> +            {
> +                .version = 5,
> +                .props = (PropValue[]) {
> +                    /* Erratum 1386 */
> +                    { "model-id",
> +                      "AMD EPYC-Rome-v5 Processor" },
> +                    { "succor", "on" },
> +                    { /* end of list */ }
> +                },
> +            },
>              { /* end of list */ }
>          }
>      },
> @@ -4806,6 +4816,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>                  },
>                  .cache_info = &epyc_milan_v2_cache_info
>              },
> +            {
> +                .version = 3,
> +                .props = (PropValue[]) {
> +                    /* Erratum 1386 */
> +                    { "model-id",
> +                      "AMD EPYC-Milan-v3 Processor" },
> +                    { "succor", "on" },
> +                    { /* end of list */ }
> +                },
> +            },
>              { /* end of list */ }
>          }
>      },
> @@ -4880,6 +4900,20 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>          .xlevel = 0x80000022,
>          .model_id = "AMD EPYC-Genoa Processor",
>          .cache_info = &epyc_genoa_cache_info,
> +        .versions = (X86CPUVersionDefinition[]) {
> +            { .version = 1 },
> +            {
> +                .version = 2,
> +                .props = (PropValue[]) {
> +                    /* Erratum 1386 */
> +                    { "model-id",
> +                      "AMD EPYC-Genoa-v2 Processor" },
> +                    { "succor", "on" },
> +                    { /* end of list */ }
> +                },
> +            },
> +            { /* end of list */ }
> +        }
>      },

