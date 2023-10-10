Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D477C4272
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 23:26:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqKF3-0008Ui-MZ; Tue, 10 Oct 2023 17:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qqKF0-0008Nu-W9
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 17:26:11 -0400
Received: from mail-dm6nam04on20615.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::615]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qqKEz-00085x-17
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 17:26:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPkrwo0CnZx18fkRGpX68as6FtpaMPGz3Xpx4kgq+ar2theHOxmvsmz2IT2HMJUP/aXiHcV5X7iUM4eeKeu4RCzHS0zKQWEB4OUrK8Dg5Y1WRbBeA0kbYKO5ScLWiiWIDJfRwEffn72oOQNR1fqTq+kwGfSP4KIpFcy9aoliED1n9rYWwhY6J6nYHyggrynR05uLxMLzpWye85+pGRWaXNgnMfoe0Dmbzcvor9oJyVQR/pEh0QeKiq9epzeKvHfk2derLX6rAs+ulPGEw/Y6EDDyn1LCowjd1DNncYmnwZmkkWDGKIStVrbugPtYKrRMlrnluC8E+eq7vtjYqdEIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+A+KQ8hY3qYmBLt53Xp1hEcFp/O/Sahf2Br9EOnnMQ=;
 b=bz8IssyVWc1cxvKQQ7zRdDU0U6BLhxp47EmCr7bBwlpdkWQoASysrwtduE9KSq5a3SKzTI7LVQHMtSKgJ4gv9YqRucOffLaJqjMlbUn1vTtZhl5L1KGyawslR8x//wPR3llJ7vcH3F6jrKt3EIsY6xhkpKAgVgSyyNNCHRvpnHERirHYBwHK/TNIiziAWlfIZee1yWGe/zOqkg7WcspK3vnjXamv/xKqLftXWMtLIvkzswSc0wmC6btw+Buphe7Ztbc2uUa3PHvv5KMPNtOgh5t0SdVFHhLcGtCiNAo16dcwhAHtI4ZORMbZwJSr0q5ykgG9LKy++AzsUfMPbCMu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+A+KQ8hY3qYmBLt53Xp1hEcFp/O/Sahf2Br9EOnnMQ=;
 b=lqS78H1h/CBpek2p7+9fkNrrz6WaATkZKDlLH299bw7oNCKQh4+C2U6gJ1410sqA9Th83J8TDtSAHHGUq7lqlZ/XgM3ZQ+/6hIA4pAg0HTsEpjQiuU+Krc+qc8PQRykrD5964fWqIcZvx0gjTMU+kjDoWyuY3j/BUEkk0TqFYcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Tue, 10 Oct
 2023 21:26:05 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::7c95:99c7:7f5f:c24a]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::7c95:99c7:7f5f:c24a%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 21:26:05 +0000
Date: Tue, 10 Oct 2023 14:26:02 -0700
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [QEMU][PATCH v1 3/7] softmmu: let qemu_map_ram_ptr() use
 qemu_ram_ptr_length()
Message-ID: <ZSXBaiyLZWechQ7L@amd.com>
References: <20231005181629.4046-1-vikram.garhwal@amd.com>
 <20231005181629.4046-4-vikram.garhwal@amd.com>
 <alpine.DEB.2.22.394.2310091703070.3431292@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2310091703070.3431292@ubuntu-linux-20-04-desktop>
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 22db7ab1-71ab-4ab5-d69f-08dbc9d782b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +JkntmOHC6PPN7oJLuu/b9dZiSkDKflq9mapy4LGAaUVlByTNMMANH3+2NJiXKGQGdT7jS4wDwzrUeZfkzucZu4+G8xydI6yClbCMVMKf5NggmbsAg4FLlH1pFDHQC6mzQO9XSW3oowV/fthbCy6CiQ447lR0ilIDP4z5Dlx5TGgFy8fAHZS+HroBJCIUzF8E4+kIv/4wOUdq279RSpFaYL+mxRToix4WhiuXkVi0SvS/rC6gZ1yMCR5XONCm9BAUIFBShVJdY0SLZZ/pLCz53e1j977h7T5iSiEjgcbbFKig14ciN9aIxCwT+oQ900XD1ClC8ShZNzuc5rOZfNNcyILii3aMh1ZEsl9uCHzwlC4kUjAeo2w7hDubbALKOSqR1EG4ls/jTRcJXcRBFAowCZ+VyfwmX78GtToHcf4z30gO5zSC/hoxLsDpK1mWnlsFTqYeCZZnJDvaWRtke1+PHQHr4F+oj1oqMaRCZ4gNFsVp9d8PLLH8h8cXKzmL225c6dfeIvyhtksBzHhb0UkeKlg16DHYB7RedBHdbF6okpNdcBy0ETmzYU0pYBD5fXJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4326008)(8676002)(6666004)(41300700001)(8936002)(6486002)(66476007)(6512007)(6506007)(38100700002)(2616005)(26005)(478600001)(66946007)(66556008)(44832011)(54906003)(6916009)(316002)(83380400001)(5660300002)(2906002)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFBtSFV3NUdRZ24zUUY0VHhJM3AwbXc1N1dPcWlTRHh6ekV0V1hNdHVJZkdv?=
 =?utf-8?B?LzdQaitzUFlnK1JHeUE4NkYrckNUc0ZFWE5QcGFTQWc1ZGVwR21xcjFhemw3?=
 =?utf-8?B?KzNseTFweUgxSzEvdXpCWUQyRkJFN1FjZkcxRW0wWEE4Z3c4SmRZckRoTzFM?=
 =?utf-8?B?Zlp4RlFHRm12cGVaU0E5eU5ZQW5uZjdsR2d0NE4ycFJ5ZmRzYUc3VTJDeDQ0?=
 =?utf-8?B?S3FON1kzRVF2M0F6QjZSRDZUd0dRV04wQVp0dUp1b1h4Qjl6S1EreHUwdUdK?=
 =?utf-8?B?V0k0TG1sU09YUUE0MEphS2VudDQ4OXdrQ0g3alAxNU5uYjY4bnBHSmFqYTEw?=
 =?utf-8?B?S0NhUU1EbExJUkpxZUhYOVByQXF3T0h5WFJhRXU1cEo2VGpIczl6NWl6T2ps?=
 =?utf-8?B?NnRIMDNPUEoveUdNdWQxV1ltcFNQeGpkV1dUbWlWOVl3cklzNTJiUW1XM2lz?=
 =?utf-8?B?K2N5d2tjZlAyOGkxT0o5WjAyZlZVR3BsZDM5dkhWMnpYdmVhMnpHQjZ3dGZh?=
 =?utf-8?B?RTRldldUc2dxTEd6cktqaFg0aEZQUHYyazFBU1g4Z3RWdUtqRlBSeXQwdXFi?=
 =?utf-8?B?ZVVKZVpuV213VkxRQmN4Zjh3Q1RsNE1aczlRcG5Fc3FLdmx3UG9IK1QyM01D?=
 =?utf-8?B?a1pKNE1mUTRyQkNxaGJMMGxodGJJTGRIRkRBMWdKNEpxYnJyeC9NMFNUNWU2?=
 =?utf-8?B?Q3o3ZTdmWWlhMGszdGY1OU5CMnlML3I2OTZXRnRZZ2RiWWtSN0laOGNkNjhF?=
 =?utf-8?B?TmhCNitzYVZ1QWRrRzYvRURoL0kvTHNEZmlQRVNJZDA4citNNUc1V2luc1NT?=
 =?utf-8?B?OW5tUVkrdmZYaSs5VEZUZEVOUWJ2aCtlUzdZMS90RG1qdC8vQTNMM0M0T0Z2?=
 =?utf-8?B?N1AvRzd1TldCejRxVXZxZzdzV1RzMHpiMWVhbmN1Q2JWYVVLK0FITVFteEZ1?=
 =?utf-8?B?R2ZENVJyR2NQVWZnMHZOSk1uam9aVGpDMVk4OWVJS1VvVE51OTRuUWg2Q1V5?=
 =?utf-8?B?YUxhcVVJbUM3OGwyMGZyYnc4TEdZdEcwNm9nY3BCbGFiMWRTeGVGRzhsMUcy?=
 =?utf-8?B?Slc2T3BQM09Ka1p0Y2dKUE0yZDROeXV3VW9IMUpoTFkwc3IzQS8vOUZjb3FQ?=
 =?utf-8?B?dXRFdGl1MUJCNkdwRGhKeEJiTmhkUFY5NDF0L2luKzQ3OHlLSC83SEtRTXBJ?=
 =?utf-8?B?b25US3FZOE1rSGtnUDFVdGxOTG5wbEppdHBjdFBPME9RRDJpKy9ISThTNzd1?=
 =?utf-8?B?cngwUDFmd2tIVTdDeUdHWG1tQkE3NHFEWGtUT3pVc0xkWU5qWXU3QnhjZTdS?=
 =?utf-8?B?YU8xWUIyNmZBYTJHeVBpZjRGTHdneXVrVlVVOVcwNzJnOTh4bjJGZEl0V2pa?=
 =?utf-8?B?THh2QzFaazZ1NXdNaVFqR25vTEhEMnFEY3JnNjhUMFN1UVpOSlpsMEJ1bkRK?=
 =?utf-8?B?ZC9ES2RwNUZiclJOQ01mcjZuTlQ0U001blpzaC9VTC9WRGlKMWNBWU94UlhJ?=
 =?utf-8?B?blBJLytnbTdwR2VoSWtROUJMVDJ4ek5rVmxxMTlKdlRiL2hSVFpRdG1MV0dH?=
 =?utf-8?B?MFdWZGhkUFFweGd5eXo4bnlwb1J0Y0ZDWEtlb0pRRXFRZGF6eFQ5d1piNDdl?=
 =?utf-8?B?UW9QaS9MWGp1Q3ZXYVRuZjg2VXQ3Nzh5V1pzSTNoN0phVnd2TXlPTk1mNitv?=
 =?utf-8?B?K2NCVGVxR2VGSE1VanZVV2lXRzlMSUxKait1bDM3bU9jNHIwRko3ekVwNzIy?=
 =?utf-8?B?TitiaWJhSzU5TzdQOTJ6MUhheTYrZ05vSERFUThVbHhaLzNvdS95djZwZ1A3?=
 =?utf-8?B?VGN1ZmpySWwwTFpuYXlyYTVTYUM4QVBoM1lwekFjQmV0QnFCeUhYenM5Uk5i?=
 =?utf-8?B?cEhxOVVTbUxFR1llUjluWGhUbDZrbjUvajVZeXdhVStHNnFYSStLZkpYSTcr?=
 =?utf-8?B?bDFXOVpFWDAyaDJuMVA3SW9kcys1bUVVd0NXSWs1WHMyMnVabmFwNUZLTUV1?=
 =?utf-8?B?Zjd4V0x2dW5vTVcvamUrcG9ITUMxSjhPa1ZxQUNQTDhrVFgrNHl4QzJKR0NV?=
 =?utf-8?B?NFZFRVpUeVVQZFhBM1A1NWZUL29OeFFvQ01xYmMrYmNRZk5EYzdFTExDOVlT?=
 =?utf-8?Q?zvKrkMCM//FNxZq8GPaNmkO/X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22db7ab1-71ab-4ab5-d69f-08dbc9d782b5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 21:26:05.2243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNWw0g0cqB212LH7bImvE4A7lcr80IorTL5qfELmkuDO01PCyHYZT++JMawJkTdes9ckGvYxnk4LxOtFFYxpuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::615;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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

On Mon, Oct 09, 2023 at 05:10:43PM -0700, Stefano Stabellini wrote:
> On Thu, 5 Oct 2023, Vikram Garhwal wrote:
> > From: Juergen Gross <jgross@suse.com>
> > 
> > qemu_map_ram_ptr() and qemu_ram_ptr_length() share quite some code, so
> > modify qemu_ram_ptr_length() a little bit and use it for
> > qemu_map_ram_ptr(), too.
> > 
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> 
> This patch also doesn't apply due to code movement.
Will rebase it.
> 
> Other than that, the patch looks good to me
> 
> 
> > ---
> >  softmmu/physmem.c | 58 +++++++++++++++++++----------------------------
> >  1 file changed, 23 insertions(+), 35 deletions(-)
> > 
> > diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> > index e182a2fa07..6e5e379dd0 100644
> > --- a/softmmu/physmem.c
> > +++ b/softmmu/physmem.c
> > @@ -2163,38 +2163,8 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
> >  }
> >  #endif /* !_WIN32 */
> >  
> > -/* Return a host pointer to ram allocated with qemu_ram_alloc.
> > - * This should not be used for general purpose DMA.  Use address_space_map
> > - * or address_space_rw instead. For local memory (e.g. video ram) that the
> > - * device owns, use memory_region_get_ram_ptr.
> > - *
> > - * Called within RCU critical section.
> > - */
> > -void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
> > -{
> > -    RAMBlock *block = ram_block;
> > -
> > -    if (block == NULL) {
> > -        block = qemu_get_ram_block(addr);
> > -        addr -= block->offset;
> > -    }
> > -
> > -    if (xen_enabled() && block->host == NULL) {
> > -        /* We need to check if the requested address is in the RAM
> > -         * because we don't want to map the entire memory in QEMU.
> > -         * In that case just map until the end of the page.
> > -         */
> > -        if (block->offset == 0) {
> > -            return xen_map_cache(addr, 0, 0, false);
> > -        }
> > -
> > -        block->host = xen_map_cache(block->offset, block->max_length, 1, false);
> > -    }
> > -    return ramblock_ptr(block, addr);
> > -}
> > -
> > -/* Return a host pointer to guest's ram. Similar to qemu_map_ram_ptr
> > - * but takes a size argument.
> > +/*
> > + * Return a host pointer to guest's ram.
> >   *
> >   * Called within RCU critical section.
> >   */
> > @@ -2202,7 +2172,9 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
> >                                   hwaddr *size, bool lock)
> >  {
> >      RAMBlock *block = ram_block;
> > -    if (*size == 0) {
> > +    hwaddr len = 0;
> > +
> > +    if (size && *size == 0) {
> >          return NULL;
> >      }
> >  
> > @@ -2210,7 +2182,10 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
> >          block = qemu_get_ram_block(addr);
> >          addr -= block->offset;
> >      }
> > -    *size = MIN(*size, block->max_length - addr);
> > +    if (size) {
> > +        *size = MIN(*size, block->max_length - addr);
> > +        len = *size;
> > +    }
> >  
> >      if (xen_enabled() && block->host == NULL) {
> >          /* We need to check if the requested address is in the RAM
> > @@ -2218,7 +2193,7 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
> >           * In that case just map the requested area.
> >           */
> >          if (block->offset == 0) {
> > -            return xen_map_cache(addr, *size, lock, lock);
> > +            return xen_map_cache(addr, len, lock, lock);
> >          }
> >  
> >          block->host = xen_map_cache(block->offset, block->max_length, 1, lock);
> > @@ -2227,6 +2202,19 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
> >      return ramblock_ptr(block, addr);
> >  }
> >  
> > +/*
> > + * Return a host pointer to ram allocated with qemu_ram_alloc.
> > + * This should not be used for general purpose DMA.  Use address_space_map
> > + * or address_space_rw instead. For local memory (e.g. video ram) that the
> > + * device owns, use memory_region_get_ram_ptr.
> > + *
> > + * Called within RCU critical section.
> > + */
> > +void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
> > +{
> > +    return qemu_ram_ptr_length(ram_block, addr, NULL, false);
> > +}
> > +
> >  /* Return the offset of a hostpointer within a ramblock */
> >  ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
> >  {
> > -- 
> > 2.17.1
> > 

