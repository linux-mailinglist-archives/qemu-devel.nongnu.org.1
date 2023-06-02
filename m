Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B413D720831
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:13:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58Jc-0008Dy-J4; Fri, 02 Jun 2023 13:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q58JZ-0008D6-NH; Fri, 02 Jun 2023 13:11:49 -0400
Received: from mail-co1nam11olkn2080e.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::80e]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q58JX-0002FY-Kt; Fri, 02 Jun 2023 13:11:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvtPL2YRfHfgmeZiFsfMyueKmpGQwlB0Orf3fF+pm18Vr+ejCbvRHhsGulgGEBrZ1USQcbZ4pulEZ9SdySIS817Q2LQfAZC5vc4pkg4hly9wBxgrBhyY+ShpNS+nbVylB/l8jttykcQFOKcZT9EoLOM1ng3Nji7LPtWip0VMiwBUKawOssjhtr56w2o9byAFsvp1bLqDQW3tpgkKgl8gsF3twqVKzEOq47hosT11cfDEKu5IAXgf6ByKJTCged4domXHrLPHnXroRi6jdH1Y2nSdr1OHVgXCQSs/akv9z5sOoXEWldUV50lF+kMkM4BYbicQmG7FgQYcFNuOI7MaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsEqFJD7dS2O+zib+2VDcypdyLEBjLECwHl7BTsp6DU=;
 b=PB20YUkyW9xS0afD+jgrZc/fop0peRviJ6GZhiNr99ViE5p7HuRLqoGUr634Zf3RFcy6gJwybeMLnkhYqd61mUT6UWF4qtdUia6g8P/elW/hKrZShW021SSWJuNGHyMIvvf6VwJ1azuDzX08mgmSXnVZpOUxOIvucjNnAkz/iqlS16UuJIDdGZmpRuaNG3ftweiJcFU+PyYfLx7ibM1jd47HqJPbugyJSXNW1Z/cRdSs1SaZfI7UbTpLpwEIi3GzwvPGyjrrG6hVwo6GBDuKj7TEwSeC9kzdYnAiMWPam7xbMpmwoeUiCuLclsHtgaPP3QDePX105v0BmrgSTjv5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsEqFJD7dS2O+zib+2VDcypdyLEBjLECwHl7BTsp6DU=;
 b=MxqsGqRFBrB1pdZDauU6xXAMf00u3h3RLtPCMc1fqmjntwX+5oBbL9RgZntYWgIpUXMwzHqHhdx++T9PYSwKbTByLVM/SL1Tn94VZvIXncoDQMfrMTYaqJZJtL+v2lDsQTQ417krYJH+CtJssN9Pvr/21DJUFGf4l9bBaPEdU9nhERYoXNh2nMLRXVm2GatBp7goiYqa2lbl173TUcmHsbFCq3WSRKANYd9mK9BrCnYDy9lshUuyBWLLOWVUCz+VCyMwJEMNn3uBpcPDAGaq4r9jjgkUz/og0L2rxJKc7EfhEXRG2n0bF0D3Dd78u5UevwkD5Jc9bOW6fSXofrs7cA==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.26; Fri, 2 Jun 2023 17:11:44 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::20b8:bc4d:e007:4fbf]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::20b8:bc4d:e007:4fbf%2]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 17:11:44 +0000
Date: Fri, 2 Jun 2023 10:11:41 -0700
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v4 1/2] target/arm: allow DC CVA[D]P in user mode emulation
Message-ID: <DS7PR12MB630998C22930F8215D7E5DDAAC4EA@DS7PR12MB6309.namprd12.prod.outlook.com>
References: <DS7PR12MB6309FD700EF00EF1EB541CA7AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
 <DS7PR12MB6309408A6BB4A469862CCA34AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
 <a48e823c-38ea-d5a3-af67-dc93dd6507ff@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a48e823c-38ea-d5a3-af67-dc93dd6507ff@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-TMN: [xFCWCda588fiOLxJpUKNqOOkvMDt3enG]
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <ZHoizSWYew29ZD8J@manjaro-vmryzen>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: edfa12ef-7b61-4566-dae9-08db638c70d2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiWdkWUG43dlz/RJ/TUzWviICZIL4IGFEMbr+DIypX4qxO+LRQ7vvDo5q4LskH/du9sWnBwWdfnzZr2Yl1k4pjxME2Z490ZBuZi8odeyuiNwd5NIJ0j83Rpq4rdg+d5peKOS4NZcYSm4NikLRU52tHENgscCXwYwE3xW6oDu59cdUSYgEdGNQlXVxC7Jg0FRYlIkc7oFEC43Fp5NlPMBat6fAihHOIC7N9R47WYZyFjrLo6XIxZvlEeBVtqu8gMbGci1FFOPrs63e5fUcOO5zz77kPYUPr5VFv+SNTExzZzc6sfyysmHbx11I11o2b1uGNlGpOUZkjP5SjM+poFAnT2DohzAZ+MM4tyeLf54pETK7t+dCOcLC/M961RYjThwg3ns8WJrDn5FL3mztDTQgsa7O8njCVz0WEeDdP+Bci3dKlJoXcfwFS2Bzt2+Vu2YaTwssPAdE8hZBtZz/BwnvZxwfU4ND0lQjnU+8Q/6ZFRfxhSMm0yhFzezgZhTpbVUxhxjMgk+D/kW4DvsIVPyh0qwe3rDYi+Qpi+z7a691B3kaS4HurLNo6pd3tulMeo5a9GAbNWUWMA1BJp82xJJOx4X0LrPmYnbq6j4cTNcuBRsThC4M2+zfVSluQUQIFTQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHFORmhpUC9wSmYrbG41dVlsUWtBRVNQRjV1TklMdjRLbklJUUNXSnJNUXVh?=
 =?utf-8?B?SmVta0IyYTUrMVFQZ1FjT2NxTTZqRmNKRzlFdVRyT2V6UWFrMGQvOVhDRmdy?=
 =?utf-8?B?blZhYlZyOUVjTDBJWHZPT3MzdllwNHp3UWZpQ2F2N2E3K0VkWTFtK1ZCbnpX?=
 =?utf-8?B?YW84WXJJT0UvdmEwSVhMaTVXempublBSdjM4QXNreW1UVDFuS1ZTZ2t2bDFV?=
 =?utf-8?B?WStJZTN0MTVSUkw4UG9MMXplbnAxdlZUdGx5UGxVaHpVOXUvaWZjR1ZuL2ox?=
 =?utf-8?B?dUR2NDA2Y0pTOWRFTFBpejhVb2dscWtNdWxJekRjM3JHV0RZcm50SWpVNDB6?=
 =?utf-8?B?bTE5NlpmTW1hc0R5UTJnTDBSYjVIQm5BVHM3UGQ0RHM0VGpGUlR2ZkwvK0g2?=
 =?utf-8?B?Vy94cjhwRWRkWGdXZC9MUUJHY3oydlo1ZmU5d2xwQ1lkbzR1dkl4ZUlQdmEy?=
 =?utf-8?B?L2hUVkFEV1BXdGo5SjJUbUFWbldMWHVFY0dFYUY4MXhmd2toTVU4NmovckxD?=
 =?utf-8?B?THJLMEJrUWVPK2g0ZEVtcFF0V0FyRDVPT2N5dHREeWtWL2RnbWxhcjUzTWty?=
 =?utf-8?B?YjhFMjN6c2F5d3NkbnJxQVFnRmxzRC8wKzBSaHBRTWtNMjJZL0tDdzFVYWhR?=
 =?utf-8?B?RlYvM0Q4ZmdvQnBaUHd6SWl6NWNQL3FqemlYUWJCbDNrTE9qUFlNRDhidk5u?=
 =?utf-8?B?M3NFQVlRWjRLeCtwMGVZeXNsdUpNU005cHFzekNQWHJMZ25NNXFCdFZMWWFK?=
 =?utf-8?B?NzZCai81T3FlZjB4emloSmI5UXZ1b0hPNkdTY3Z0b3h0T2lYOEIzRWJIeHpr?=
 =?utf-8?B?ZGhlbVg2WGc1aHVDS3A0OGsxMFBIcHh1UFlSQXg3MjRyUVhlVE1pbTBzWFJO?=
 =?utf-8?B?YzI1OWpHTGVCUm5FTm40N0lTVkxmTWtHOUQzZUp6VU42T1puQ0ErYXRCWlV2?=
 =?utf-8?B?dVJuWnZIZ2NjU1U3VEZXbmhDeXZ2N0E4cXhKdnI3OEZIWXZtaXRwcm9ldHBL?=
 =?utf-8?B?Unc2M3lxeHBSZlJEU2dJMk1OZXJaN1JlMEpGSUkrNENtc1ljeFA1am15MFRV?=
 =?utf-8?B?UkRFeXBLK0xGZmx0M08vbTlCZW8wTFlkdUN4bFpldDA2OWNJaExnZlN4SG9P?=
 =?utf-8?B?dG91UFl1VzRTN1Q2MmF6YTBUZW9WNkpuN1N6Y3BRTytuN2FqMWNSckFzdThP?=
 =?utf-8?B?T1J5Y1Nlc2lINVdVSzg1Y2Q1VkVIV2pKUWU3M1BKaktVQ3JSYjZSK3VwK21P?=
 =?utf-8?B?aEo4UWk1cmNEV3FpT2hVNVhRVmZIM3I5UzBHOU84ZXpUbDY3cDB0YTdnSWIr?=
 =?utf-8?B?bFdoR01rMEp2RWVLdTdObzBPdkxYYkJneDZ3UjVNREdkMHJVRTFWeDl0eGhT?=
 =?utf-8?B?QVU2dTZ5aXUxYzdxdm81eExZT0xwUmlqWWVLVEU3Z0I2OXc3bkZML2NSeDJU?=
 =?utf-8?B?YUpNTmM2Q2x0UWd5d0kvandoSGJObVozcUxVR3krbFlKblhzTStkMVVNM2VW?=
 =?utf-8?B?c2FhQnZ5NlRoOGlzRGlkZXc0Tko5TGwvV2NuMWxrd1Z4cVNFWTUwREtwK01N?=
 =?utf-8?B?SmFMc1VnZjFTUmg1N1l2U1VIOHc0ZDZyTGc3azV0WGVkSzQwQWt5Zi9MTlE2?=
 =?utf-8?Q?pM85+gK+VnvelUgcNCf8i2AHTZIDtJLBTgQHdlQlCffg=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: edfa12ef-7b61-4566-dae9-08db638c70d2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 17:11:44.6570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
Received-SPF: pass client-ip=2a01:111:f400:7eab::80e;
 envelope-from=chaosdefinition@hotmail.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 06/02/2023 12:27 PM +0200, Philippe Mathieu-Daudé wrote:
> On 2/6/23 00:11, Zhuojia Shen wrote:
> > DC CVAP and DC CVADP instructions can be executed in EL0 on Linux,
> > either directly when SCTLR_EL1.UCI == 1 or emulated by the kernel (see
> > user_cache_maint_handler() in arch/arm64/kernel/traps.c).
> > 
> > This patch enables execution of the two instructions in user mode
> > emulation.
> > 
> > Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/helper.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> 
> > -#ifndef CONFIG_USER_ONLY
> >   static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
> >                             uint64_t value)
> >   {
> > @@ -7420,6 +7419,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
> >       /* This won't be crossing page boundaries */
> >       haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
> >       if (haddr) {
> > +#ifndef CONFIG_USER_ONLY
> 
> This ifdef'ry placement is odd. Is it to silent a
> unused-but-set-variable warning?

Yes, exactly.  Since we pass -Werror, ifdef'ing out the if statement
wouldn't even compile.

> 
> >           ram_addr_t offset;
> >           MemoryRegion *mr;
> > @@ -7430,6 +7430,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
> >           if (mr) {
> >               memory_region_writeback(mr, offset, dline_size);
> >           }
> > +#endif /*CONFIG_USER_ONLY*/
> >       }
> >   }
> > @@ -7448,7 +7449,6 @@ static const ARMCPRegInfo dcpodp_reg[] = {
> >         .fgt = FGT_DCCVADP,
> >         .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
> >   };
> > -#endif /*CONFIG_USER_ONLY*/
> 

