Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C597A48F6
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiCsD-0002A6-BX; Mon, 18 Sep 2023 07:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qiCsB-00029v-ID
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:57:03 -0400
Received: from mail-dm6nam11on2086.outbound.protection.outlook.com
 ([40.107.223.86] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qiCs9-0006rC-7m
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:57:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfRapshyx6F0MzoYhm3wXmaXvLmUjIkUlrq3Y7MFW5we4K7qyFngnBed+6mCWZoKAx6IylNrUmMxTT3PRfqchP3nuz3UkfF1Bc36edLlD/jPu7wlLd9NF6FmssdxMRE9jIoeWOabLF+ON3nkbIZ+3zDzYTidpiMMyvJUNfNY5k8dKbHoje4dAXM7fGzUJdttQWZrRgMz964rL9+nWOIz4xUbrVs9rovtuqtQX2QGGFNbuUTVftnAIyKIclW56DR6+0g3NaDLaktcwOOCdLOnf/5bO8v00WwG6c7w6B+a1cGte7MzL4KSkCCtEAEh62v2cpf0sozUEtu6UdryA5tYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSloGAr0Xw+bEdSDE1YNUNhK7C3gPQt0wQO5EEA0zY0=;
 b=PGWzPfleP8R7RkZZAGg5Jw/UI4VCdm+U9/eJXr7wdVRCvZ1zLhL3aT7MhKberR5iNGOpa5pJVtbaO0LcNTQyNWdntmlzZ8rMiFQp6BQrYelB1O6OsTj52sAi9MUAT9Ov90oY0XCIPlzZBwDILseQa6PUKyDDFagp6J/5p3h4FDlHV/0E6ppl/mSQH89m6pgEUvMjK7WyqgNMbTT0JgIp3titzPPh0kAHgHrMkei9rFZaABhfPaD4yk3SYMcf4zWSNlnweUFs2HBIND8F5+ENnj/mZ1pVOi9POF6xhSFIJsjr/b5C6EVJhtntlmkBMDbhgvdRXHlSr0771viGH5BtSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSloGAr0Xw+bEdSDE1YNUNhK7C3gPQt0wQO5EEA0zY0=;
 b=phhTQ71rZQdxbWyMAmhW4uZQkJTl7c9o6LWTdnfFJyCPhYw5/LvZSxHUAiwGFSiLJ133pAs2OBxy3JP+2wDYH/qjavXvKTnJ5ARV0vbAdzYxWYVmRQPqLfYS4jqBpgO9nivpPGj1CL8DxQw6SCP+Ojb0nafFcZ+M5B6kNRKpoPvWXJ6S9Dv92b3BPyVE6IVfqtjDb3I+1D1sgxG4FDaAGWXx70A0ZyANzclc0L1iy647ZJw+tjXgqi2YZRtbKvM7Ak/fIYkiypYzU6Tc6x54+HrnGzw/2Ej2ByLqK1xKTBuN1Gdy18s+HwZt4NaS3jiePt0b9K+Q8+Zpb1+9PHYkLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Mon, 18 Sep
 2023 11:51:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 11:51:55 +0000
Date: Mon, 18 Sep 2023 08:51:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v1 00/22] vfio: Adopt iommufd
Message-ID: <20230918115153.GA13733@nvidia.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <62367cc3-20e9-f533-5f74-2dc3cba702ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62367cc3-20e9-f533-5f74-2dc3cba702ce@redhat.com>
X-ClientProxiedBy: BL0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:91::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ea1d91-ae20-4741-8630-08dbb83da79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PA7u5w+OUuGWVp/btLjF/DTRX0JiV9A4hMqrC8t5qrGwlxR7kCB3MJbaGQG1v4/+VNpo5OzE7xHfj4TSmHI39D/Tg7Ilz+SfBCdD0DlY2NTse1x0z+RjotWeB1uZ1mJjjjijJC0I+O6Rc3VuIg99ffSCCmgDS3ivW6ZTb8qlYhk7kveP1mewaahFHtcluTzyoNYwHiLcBhG1KoaX16fiIht4YrEIJb/oQnmK1cq3VEhuM7oDrQH7lJYpiPgBfMBdg9lRqH+gbLzVgb837rwZBZTbOFufU7HPCaGsm1ybxBS9SDbYK4mRltS0Nz+FIAHPVtsGik8mQJF0TxKZad+MlTek5Pa3rGReh2TXXztloACbLS86I1U5goO4CM9cgciMFQ1awmctXKu2w3yAFja8pTkfRUvBYOP0/w/3+EEHWy3CsNCPjHf/8ORx6C2mvn1vH08gnYbun7KvhJMNIFSAoV4YR3WfE5JikcimIqwpaiQWdeyBgXa9eChJ8XC2/54Na/7iHdVbLij1yKZ3nfD8z5SzWNMpdwf2Sc2YewAnkw6YWdiN2yAKNUn+UQ1UEXeP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(5660300002)(66574015)(6512007)(33656002)(1076003)(2616005)(26005)(6486002)(6506007)(53546011)(83380400001)(478600001)(7416002)(316002)(41300700001)(6916009)(66556008)(66476007)(66946007)(2906002)(4744005)(38100700002)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk1vQUo2MndxVE04Z3RTcVI4YmMyVGdmUjVjTkdyb2J4dmJNM3IyOEZmUnNn?=
 =?utf-8?B?WEJqMU51Y0tqbkRDbThxSWxGMDY0ckhnZkczTmFTdVRJRE01SGw2S1dOZ0NN?=
 =?utf-8?B?MXh3K0JFRXVmQTZ4d014L3ovSDF2UTY5TlBXcGJSNFNIVWtmdlkzUjVlTzlk?=
 =?utf-8?B?TTgyd3c2RmpUSXdaRTBXcWpKTjQvUVIxQnZZZVJ1Tk40R1BJSjVROXpidU4z?=
 =?utf-8?B?b3h0a1JnL1NCVXQ0MHJUUzlNOTRHZzVsQjlaazlQdk0vSHhZMHMwN0I5MXVB?=
 =?utf-8?B?ck5lUjBqSkRiUkg2dG82SmM4bW1yM1FTc1VBbXU4V3dRRXFTa3VnY3E0Ly9R?=
 =?utf-8?B?UXBnQ1QvMm5mZFZEK01Lc0lodWl5MmxlS0JTek5FMGhnWmE3TllGcWxsOFkx?=
 =?utf-8?B?UHRBejdqclE1bEtOUVZZRnZXZEkwc3hGS2ZmMG9ublhPelRSZDRlSDFxTURX?=
 =?utf-8?B?YXFtMnNTVFVpR2xWZTNadzB0WmpGYzJBbDJDN00xRXFja2xhTXMwbUNKN1Ns?=
 =?utf-8?B?M3ZzOGlQWEMySitFcDRyWFQ1TXQ2Qmp0TTVMTTh3cGtqd3k3WmJKckxOR0Jo?=
 =?utf-8?B?UldvTDV3Z0ZSZGd0WURpRUp2VkE3a2pUQTk4TmwvT2VTSFU2K2l0Y3VhKzVK?=
 =?utf-8?B?WGMyQklBZ2xQUnRTR1AxdzdSOEZhQ3ZxUFN5RlFxaDlHcm1JSk43aDZ5a2oy?=
 =?utf-8?B?VldLNnB4NlhSV0lreVQ5bW9qRVhLODk4M2lUcWU0aXlSOWdtYUs0Z21MRmQ4?=
 =?utf-8?B?SkovLzNtN3pyNER5V3JOenNXL1BmandTazdvWTZqZTMwUi9sa0JQWU05Tng4?=
 =?utf-8?B?MlJLL1d6Y3pGL01NcjR3Z2JZaDNLT2daNkFlbXI4anpvQXpTbEpTcVB3OHgv?=
 =?utf-8?B?cXZrVDJjSG1rTmJGemlhQlZmYS9aWm9GdUp4bmUvMkh0RFdDdmVUVXhxWFNX?=
 =?utf-8?B?OHhpdVNPTTFwaUZTTThZYkk4MG4xemJsYmdIVkE3ODNDSytiVm11Z1dJODRK?=
 =?utf-8?B?eUxsUE8yOXBTcUVKUGJCNlBvSDZpNGMrWUF4emI2blNHQkJ2YU11K05zWnpm?=
 =?utf-8?B?cGlFcjh5NDVYbllzNEtCYWxxeURHbjBVNlpnd0ZuZ1gvTkdpWnowOUtuVWF6?=
 =?utf-8?B?OHJkYitrWUtOVmYxZlplVnp5M1A1QmM1aTBCRithTW56dUFCdmFRZUw4QXhB?=
 =?utf-8?B?V2NBaEY4MUpoNnFhSHoyM2tHaHZSQS9veGM2WGhKZHNQa3FTYjYyTGhPa2hl?=
 =?utf-8?B?VGtNUGNBeHEvNFpRaDFTRG5tZFhjTURQR0l3RUZVNVBHWFAzbmRqdmJzTzV3?=
 =?utf-8?B?b0NVbVZxMU80dFlIdVdHUGhERXU4MlVDb3V4MnBWb3hrL1d4b3Z5am1JKzRW?=
 =?utf-8?B?RHFyaWhQWEYzdFExU1VlMmh1VGltTmNKZ0k2ZjhHSi9ZYm9TRXk5eHhuaVg3?=
 =?utf-8?B?VkZqVXJPbGprU2E2NkFjTnZvU2QwRUtyYWE1SmVCOXpvRFNaUkQ1bkxqZDFJ?=
 =?utf-8?B?SEFMRnBSUXM5Rjg3aHFFVjBzdTE5S0ZGd24yMUk4NnFTdnJ0czlsRmtiYzI1?=
 =?utf-8?B?MFoxaGtWbkNpeHVtSllrMGl2WEhiUmI5WUl0U215bkxzdGFsemsyTEM1VnZZ?=
 =?utf-8?B?S2pUeFVSZ1dSUmxxZGdmZURYaURjQTlEOUlLWFRqamJ1dElXdkVCMGQwVDB6?=
 =?utf-8?B?aVd0Rnd3SllISjA5L0JKUUkydHVkZVVib1lGRWNxaWhHSVJyb2pWME9CWDFD?=
 =?utf-8?B?UlVxM0huTWFtMUpzazFuZWxENXRNWmhyUnhZZTNIOGhmMHNUeDJCaTZJcVdQ?=
 =?utf-8?B?Nm90cENMUStEY2xySm9UWXBURjhKOEpnNkM3QndSNmJudEFRQkE0MkxtS1Bv?=
 =?utf-8?B?eE5OR3VsaW9IbHFHTW8xY0pOWHczcVA0MkFIMnNCZDl0UG9CL1pOb05QT2ps?=
 =?utf-8?B?S3Q3V3RlUWg5MTY3SlVHa3d5N3VuUFljNjc0b3JidTNvQ0JOWUJRZnBTS3VU?=
 =?utf-8?B?bG9CWU5DaTllZDVjNFNCb0lFSCtMMFBlZTNpVWRVNVAzSkYyWm56Q1gzRndS?=
 =?utf-8?B?QU8wMHRjZlFuc0VpcVhLRElVUzNUc0tLUUJJTDJGR05SREhMeEh2OXhxK1pw?=
 =?utf-8?Q?MGCI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ea1d91-ae20-4741-8630-08dbb83da79a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 11:51:54.8744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXVj+Cd0mAcTfi/1jIujU6X849GPKSmYGtTKeA3eXYRwtn3pDhFHPN1BrW/awN1U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
Received-SPF: softfail client-ip=40.107.223.86; envelope-from=jgg@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

On Fri, Sep 15, 2023 at 02:42:48PM +0200, Cédric Le Goater wrote:
> On 8/30/23 12:37, Zhenzhong Duan wrote:
> > Hi All,
> > 
> > As the kernel side iommufd cdev and hot reset feature have been queued,
> > also hwpt alloc has been added in Jason's for_next branch [1], I'd like
> > to update a new version matching kernel side update and with rfc flag
> > removed. Qemu code can be found at [2], look forward more comments!
> 
> FYI, I have started cleaning up the VFIO support in QEMU PPC. First
> is the removal of nvlink2, which was dropped from the kernel 2.5 years
> ago. Next is probably removal of all the PPC bits in VFIO. Code is
> bitrotting and AFAICT VFIO has been broken on these platforms since
> 5.18 or so.

It was fixed since then - at least one company (not IBM) still cares
about vfio on ppc, though I think it is for a DPDK use case not VFIO.

Jason

