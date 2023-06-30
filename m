Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DD97442CF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 21:40:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFJys-0006Rb-R3; Fri, 30 Jun 2023 15:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan@outlook.com>) id 1qFJyn-0006F8-JM
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 15:40:29 -0400
Received: from mail-tyzapc01olkn2090.outbound.protection.outlook.com
 ([40.92.107.90] helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan@outlook.com>) id 1qFJyO-00080H-3x
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 15:40:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZRPULBZBTrtYOOZR8P+1noc/1BeLSkMLYJ2DSw3z7PbAN3f8F9lYaau73YXdFTT5HG+1I4WLE0QXoiAmWE626+l7ft0dGdMkxy7MSsiFWPLjg4mrkMTLBRQwyId/fEX/wIohsMVryg8I2Z0zEgt3cUfotQzrIgmV77GUn/BUbBZxLpKP+Dwn1qx9eCebl91/m5uKEdqOCuoFL2uY38+o2dufNBGdz/J6Cm878e2joXnVZ7GF3zQnbNltMEgK0p85/DsNaE9L/us3qaBpWa8/Y2f1I50eUDl/Emw63kkZAiFxJ5F+yVvpk6uTm1MVAkopDD2so1VxeXHiNFdXVD6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIbjBgwnzbuF8VEg2oO4mHuSO6QwBfxJmC3zKKDlTo0=;
 b=QuejcPKuq0TyCeAFgf759z2y9xCHx4tdBNrfExUEJKDe/eqrf3Qo9snYGrUwbo14xIcYyWrfmJGMgEjOuJtgq/RWO44KkkY6jjPBk+38nJc2xF/SzA/YHB5FbyQuWJzH4SNR73dq1PMouoxWr/LXYGg9mnXR9XD3lfRdX14LsqhX8QY8UWTHaieO3bBTcPfXTx4mvk6oyhOSR48sp6t8cPSRVy/Y7IAAdTOnLa+0pfPdTOrN2oJTnRxVjA2JbxOvind3/agJw808iJnlla0a+b5dJRDTjaoe+6YFUijMdrRK/pzlLqHqma6YSRwo1FU9SFSx35kf5MJY3o3AuQmU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIbjBgwnzbuF8VEg2oO4mHuSO6QwBfxJmC3zKKDlTo0=;
 b=IbfE7GCgNUWF3swfkMg1VHb+eD3DS3OMlsAiXq/zjpCUiY0IEvXNk13PjII/kUhTpLie3dIqh3IMDEBUTOke6CENG8ZVilnzAxdD/i+DDROZMwPr7yJLlv9eJzey0QDbd6byvwtQfARMNsrsPGWuIu5q/R76AjAXXAWvIICdqvBn8Wj6kV6dUzgQUJ7slfZyn1HpIXYPG3O85GAWwVPzQjMLG6ilB0lH7xVjcKuO3ttX6hUlSTvGln0TxKd+5MObt4qMexL11YHoytTAlpLHLdsFoheJ6A91ebtsZ/yVoOM2PNEhluXRWFwhSkPkRnSVkeTu1ous+1EkFATlAby/iw==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SG2PR06MB5333.apcprd06.prod.outlook.com (2603:1096:4:1d0::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.19; Fri, 30 Jun 2023 19:34:53 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 19:34:53 +0000
Date: Fri, 30 Jun 2023 12:34:36 -0700
From: "nifan@outlook.com" <nifan@outlook.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Fan Ni <fan.ni@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
 "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>
Subject: Re: [RFC 5/7] hw/cxl/cxl-mailbox-utils: Add mailbox commands to
 support add/release dynamic capacity response
Message-ID: <SG2PR06MB3397B0935E5C7AF1E3E5BAE3B22AA@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230511175609.2091136-1-fan.ni@samsung.com>
 <CGME20230511175642uscas1p1a998a2d4a20c370f0172db93d537ed39@uscas1p1.samsung.com>
 <20230511175609.2091136-6-fan.ni@samsung.com>
 <20230515153755.00002bfc@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515153755.00002bfc@Huawei.com>
X-TMN: [nZzNy93DgneCap5rtl+Cj8jF29WaJkML]
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZJ8uTKWnQBBBhMcu@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SG2PR06MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d65a236-a318-4cea-64f4-08db79a111c2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/DlxQDkLfXT4uocyCIuM1COGn3DzSkkvhRMqTC173AkA45BgjwthU/oDXPD8hOKeFM8m2O4w3J00OHU8mL+es3lJ1/S6e1DQbsvaAnQMP1trquHe4x8F/EW+gx20HKl7iKWONE01nLEUHl91H5Ar45UjlzKue1sz3GIdIs929J7rRDgqNngEzKGPB7scKUVOtD+kzM/WnzS6Z8xo9hpSobmuClZeOTwEolUTmMjf8WTbEsbiX1OEL2LYlAhFTk4H4otLTK0UgzrYcHhHgpjio2pw2tndGSPM2ada478SdALpMLNI3daxWlYVrqlrPzDuyvVRaTMhEY4Ep6yrtNBhhEIAMcCtkvdu5nqeoVwRn77V5yP8ZmJQ2S9UMVm1NlmyfJfgKFPZbJXpDMwr75qXYGDGdt2U3xev4IhHBTme6316txVGXB2m3y5f6f3Lo1WxXb5m1vu/lvFu4CsljQCo1AXZoAA8tTS86ev+j0IV2fSSkL6MwvpbyU46mPQqc6AUuJzVL4mP5MeoM3i90FOOTuPUkckvvJlILsBQU0CnvOmd0ttVW2PbSsMmnbmdgu+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE5wRXRRYmZaUFB4c3pRQUdwT3VncStla1FRUzRua1k3eUJTWU4zcERIN0Zl?=
 =?utf-8?B?ZkRQZGRZMENMdnJzS1JVN3NxcEdWQkVhY2V5WGdtdndIaUxsNEFFWmEwelhU?=
 =?utf-8?B?Z1habW1tZGdPaUVMaXRLM3c3QlJWcUduZkFQeUdUTVFJSThpODl4NG5lcVcy?=
 =?utf-8?B?OWZqUmxmbUtYUUJQV29BTHZvKzRNYzVqd2U1RUFKbUVxZkROTFlBVUpnVlNx?=
 =?utf-8?B?czkvU0RMM3hwMjZYaWpRbkhJekc1Yk5zYU1aNkgxdVZsaEtYY2VvcmFoRnZk?=
 =?utf-8?B?akJKcTRsZGhyaUhoN0huV3pKMm1UVU9BTVdGYzQ1ZWdvTUk4K1MyNVMxb1dR?=
 =?utf-8?B?eVhEWXljY0U4NzZKcjQwUkROUHRjK1ZObTdyMXhSa2Jpcy80a3lya21leEg2?=
 =?utf-8?B?Y21zdHdwWXgybzJsRDZRUGJTblJxRS9VU0lEUzRSYldoekZ2TXFaSWJSNVRJ?=
 =?utf-8?B?VmZUL0VNejJtaEp3UEFQS1hCeGpNNHNwN0FXMFVhazRZNnhMNzBUZk9PMWFh?=
 =?utf-8?B?RmpmazNUQ1Q1ZEV1SE0zbmtnWlI2MWhNT3ZqK1Zrb2pHK2ttMllpYVV5cWE0?=
 =?utf-8?B?KzhJYXA1U3RyVWhwSzVNay9TZUFiL1ZhNkJVeVdtM1Y5WHkxU0doT2x3WklY?=
 =?utf-8?B?NGE5VHVyK3E5N3hxQjc0aDF2bTV3dHA5a2xvNko4K1hmTFl2aklmVkhSVFN4?=
 =?utf-8?B?MEFlTktFUkF0d2Jod2llckN0b29NSGFNdEs1NEIydGlReC92Rjg4WXltV1pE?=
 =?utf-8?B?TXVFclRSYTdVbUljSEhGelQ0K3RSOFczVGg0cWZ0MzhMUmxGTWhvaTE1R3Ix?=
 =?utf-8?B?eXNkTEc1ZEN3Y0c4R2VVRHZMQkxDcERUbDNGQnUrZWQyNGRBbW9hdlNJYjIv?=
 =?utf-8?B?YzQwaXRHMGhUWTdVdVNvSklmYlhsS1RxSzI0YjgrUngxY0tMSWU2cGlQL1Vz?=
 =?utf-8?B?MXJJa2FEOGRZaERqbUx0V0t2NEN6Yjg0SmtOL1I2NDZDYjBmd1VtZlJSUzc4?=
 =?utf-8?B?aC9TTkpKUVh2TUp2ZGt0T0FsTVhtejlFa2JaOGpWSTVJZGhjMUEwaklENDBu?=
 =?utf-8?B?WEZCTVhvUzJXSGwrSGNJc0lkc0VQNkoyTUc2eEEyOUluZ0dZNnpTRHdmOUZY?=
 =?utf-8?B?RU1MOFJiZlhTUDVwKzNKVzFYNlA0SzA4T3dNVHdFUnNmZERQZ2laVTVQdXdE?=
 =?utf-8?B?MFJCWXRjR3M0SEdVa3VNWjl6aVo5ZlYyZGZ5ZzBXdGNhMkxOV2tHc2hwSUFQ?=
 =?utf-8?B?K1BvNjFKVmU4MEFqVlBNVDFkTXlIajBzQVhjL0NwQ1k2ekhDaDJKd2IyZDVH?=
 =?utf-8?B?NktpSkNpM1BzdmJYNGlaTjVuQ3lsTXlsb1NRU2lqSDJ6b204R1B3SjhhY2cr?=
 =?utf-8?B?VFF5M3VBTVV0bEZEdXZPNk1UWHR4bS8vR2pDeVdmVk45eFVHcDZXVFNyQldQ?=
 =?utf-8?B?ME9hdmJqeTRaaXlseWFvSERBSmpMRURDZFNMK0ttTVY2QkFhOUlkdmhFQnVl?=
 =?utf-8?B?eENhbXRGaVhrNENzMmxtUTdvaDArSm1heTBPQ25iUGVscUpBWTRnaTJBK0th?=
 =?utf-8?B?NkZVK3U3T09abFcwYXJJOUU5TXA2TDRBMFBUcmVxUk92SmpKSWNKeGxXRmhk?=
 =?utf-8?B?N2FmeUtaVGFzYjdlUHlKNE1icitxOHc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d65a236-a318-4cea-64f4-08db79a111c2
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 19:34:53.6674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5333
Received-SPF: pass client-ip=40.92.107.90; envelope-from=nifan@outlook.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The 05/15/2023 15:37, Jonathan Cameron wrote:
> On Thu, 11 May 2023 17:56:40 +0000
> Fan Ni <fan.ni@samsung.com> wrote:
> 
> > From: Fan Ni <nifan@outlook.com>
> > 
> > Per CXL spec 3.0, we implemented the two mailbox commands:
> > Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.8.9.3, and
> > Release Dynamic Capacity Response (Opcode 4803h) 8.2.9.8.9.4.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 223 ++++++++++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_device.h |   3 +-
> >  2 files changed, 225 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index ed2ac154cb..7212934627 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -84,6 +84,8 @@ enum {
> >  	DCD_CONFIG = 0x48, /*8.2.9.8.9*/
> >  		#define GET_DC_REGION_CONFIG   0x0
> >  		#define GET_DYN_CAP_EXT_LIST   0x1
> > +		#define ADD_DYN_CAP_RSP        0x2
> > +		#define RELEASE_DYN_CAP        0x3
> >      PHYSICAL_SWITCH = 0x51
> >          #define IDENTIFY_SWITCH_DEVICE      0x0
> >  };
> > @@ -1069,6 +1071,221 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(struct cxl_cmd *cmd,
> >  	return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +static inline int test_bits(const unsigned long *addr, int nr, int size)
> 
> Not obvious what this does from the name.  Please add some docs.
> 
> > +{
> > +	unsigned long res = find_next_zero_bit(addr, size + nr, nr);
> > +
> > +	if (res >= nr + size)
> > +		return 1;
> > +	else
> > +		return 0;
> > +}
> > +
> > +static uint8_t find_region_id(struct CXLType3Dev *dev, uint64_t dpa
> 
> Operates only on things in dev->dc, so perhaps pass that instead.
dc is a struct defined inside CXLType3Dev struct, so will leave it as it
is for now.

Fan
> 
> > +		, uint64_t len)
> 
> comma on previous line.
> 
> > +{
> > +	int8_t i = dev->dc.num_regions-1;
> > +
> > +	while (i > 0 && dpa < dev->dc.regions[i].base)
> > +		i--;
> > +
> > +	if (dpa < dev->dc.regions[i].base
> > +			|| dpa + len > dev->dc.regions[i].base + dev->dc.regions[i].len)
> > +		return dev->dc.num_regions;
> > +
> > +	return i;
> > +}
> > +
> > +static CXLRetCode detect_malformed_extent_list(CXLType3Dev *dev, void *data)
> > +{
> > +	struct updated_dc_extent_list_in_pl {
> This is same as used in next function.  Pull it out of the functions and
> use that type rather than mapping via a void *data pointer.  
> 
> > +		uint32_t num_entries_updated;
> > +		uint8_t rsvd[4];
> > +		struct {
> > +			uint64_t start_dpa;
> > +			uint64_t len;
> > +			uint8_t rsvd[8];
> > +		} QEMU_PACKED updated_entries[];
> > +	} QEMU_PACKED;
> > +
> > +	struct updated_dc_extent_list_in_pl *in = data;
> > +	unsigned long *blk_bitmap;
> > +	uint64_t min_block_size = dev->dc.regions[0].block_size;
> > +	struct CXLDCD_Region *region = &dev->dc.regions[0];
> > +	uint32_t i;
> > +	uint64_t dpa, len;
> > +	uint8_t rid;
> > +
> > +	for (i = 1; i < dev->dc.num_regions; i++) {
> > +		region = &dev->dc.regions[i];
> > +		if (min_block_size > region->block_size)
> > +			min_block_size = region->block_size;
> > +	}
> > +	blk_bitmap = bitmap_new((region->len + region->base
> > +				- dev->dc.regions[0].base) / min_block_size);
> > +	g_assert(blk_bitmap);
> 
> Abort in bitmap_new() anyway so no need for this.  Most qemu allocations
> don't need to be checked as they fail hard anyway so we never get to the checks.
> 
> > +	bitmap_zero(blk_bitmap, (region->len + region->base
> > +				- dev->dc.regions[0].base) / min_block_size);
> 
> bitmap_new() seems to use a g_malloc0 internally so no need to zero again here
> I think.
> 
> > +
> > +	for (i = 0; i < in->num_entries_updated; i++) {
> > +		dpa = in->updated_entries[i].start_dpa;
> > +		len = in->updated_entries[i].len;
> > +
> > +		rid = find_region_id(dev, dpa, len);
> > +		if (rid == dev->dc.num_regions) {
> 
> Use a goto and single cleanup path having set ret or similar to
> the particular issue.
> 
> > +			g_free(blk_bitmap);
> > +			return CXL_MBOX_INVALID_PA;
> > +		}
> > +		region = &dev->dc.regions[rid];
> > +		if (dpa % region->block_size || len % region->block_size) {
> > +			g_free(blk_bitmap);
> > +			return CXL_MBOX_INVALID_EXTENT_LIST;
> goto from here as well.. etc.
> 
> > +		}
> > +		/* the dpa range already covered by some other extents in the list */
> > +		if (test_bits(blk_bitmap, dpa/min_block_size, len/min_block_size)) {
> > +			g_free(blk_bitmap);
> > +			return CXL_MBOX_INVALID_EXTENT_LIST;
> > +		}
> > +		bitmap_set(blk_bitmap, dpa/min_block_size, len/min_block_size);
> > +	}
> > +
> > +	g_free(blk_bitmap);
> > +	return CXL_MBOX_SUCCESS;
> > +}
> > +
> > +/*
> > + * cxl spec 3.0: 8.2.9.8.9.3
> > + * Add Dynamic Capacity Response (opcode 4802h)
> > + * Assuming extent list is updated when a extent is added, when receiving
> > + * the response, verify and ensure the extent is utilized by the host, and
> > + * update extent list  as needed.
> 
> Double space in middle of sentence
> 
> > + **/
> > +static CXLRetCode cmd_dcd_add_dyn_cap_rsp(struct cxl_cmd *cmd,
> > +		CXLDeviceState *cxl_dstate,
> > +		uint16_t *len_unused)
> > +{
> > +	struct add_dyn_cap_ext_list_in_pl {
> > +		uint32_t num_entries_updated;
> > +		uint8_t rsvd[4];
> > +		struct {
> > +			uint64_t start_dpa;
> > +			uint64_t len;
> > +			uint8_t rsvd[8];
> > +		} QEMU_PACKED updated_entries[];
> 
> These extent list entries keep turning up in the code. Pull that out of here
> to be a general 'Extent list element' or similar.
> 
> > +	} QEMU_PACKED;
> > +
> > +	struct add_dyn_cap_ext_list_in_pl *in = (void *)cmd->payload;
> > +	struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> > +	CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> > +	CXLDCD_Extent *ent;
> > +	uint32_t i;
> > +	uint64_t dpa, len;
> > +	CXLRetCode rs;
> > +
> > +	if (in->num_entries_updated == 0)
> > +		return CXL_MBOX_SUCCESS;
> > +
> > +	rs = detect_malformed_extent_list(ct3d, in);
> > +	if (rs != CXL_MBOX_SUCCESS)
> > +		return rs;
> > +
> > +	for (i = 0; i < in->num_entries_updated; i++) {
> > +		dpa = in->updated_entries[i].start_dpa;
> > +		len = in->updated_entries[i].len;
> > +
> > +		/* Todo: check following
> > +		 * One or more of the updated extent lists contain Starting DPA
> > +		 * or Lengths that are out of range of a current extent list
> > +		 * maintained by the device.
> > +		 **/
> > +
> > +		QTAILQ_FOREACH(ent, extent_list, node) {
> 
> Add some comments here.  Is this a repeated entry test?
> 
> > +			if (ent->start_dpa == dpa && ent->len == len)
> > +				return CXL_MBOX_INVALID_PA;
> > +			if (ent->start_dpa <= dpa
> > +				&& dpa + len <= ent->start_dpa + ent->len) {
> 
> Comment needed on this one. Why is it shrinking an existing entry?
> 
> > +				ent->start_dpa = dpa;
> > +				ent->len = len;
> > +				break;
> 
> If you break here I think it will only result in return CXL_MBOX_SUCCESS so
> might as well do that here.
> 
> > +			} else if ((dpa < ent->start_dpa + ent->len
> > +				&& dpa + len > ent->start_dpa + ent->len)
> 
> Above is new entry would contain existing one.
> 
> > +				|| (dpa < ent->start_dpa && dpa + len > ent->start_dpa))
> > +				return CXL_MBOX_INVALID_EXTENT_LIST;
> > +		}
> > +		// a new extent added
> 
> Why?  This function generally need more documentation.
> 
> > +		if (!ent) {
> > +			ent = g_new0(CXLDCD_Extent, 1);
> > +			assert(ent);
> 
> No need.  g_new0 will already have blown up before you get here.
> 
> > +			ent->start_dpa = dpa;
> > +			ent->len = len;
> > +			memset(ent->tag, 0, 0x10);
> Allocated empty just above, still empty so no need to set it again.
> > +			ent->shared_seq = 0;
> > +			QTAILQ_INSERT_TAIL(extent_list, ent, node);
> > +		}
> > +	}
> > +
> > +	return CXL_MBOX_SUCCESS;
> > +}
> > +
> > +/*
> > + * Spec 3.0: 8.2.9.8.9.4
> > + * Release Dynamic Capacity (opcode 4803h)
> > + **/
> > +static CXLRetCode cmd_dcd_release_dcd_capacity(struct cxl_cmd *cmd,
> > +		CXLDeviceState *cxl_dstate,
> > +		uint16_t *len_unused)
> > +{
> > +	struct release_dcd_cap_in_pl {
> > +		uint32_t num_entries_updated;
> > +		uint8_t rsvd[4];
> > +		struct {
> > +			uint64_t start_dpa;
> > +			uint64_t len;
> > +			uint8_t rsvd[8];
> > +		} QEMU_PACKED updated_entries[];
> > +	} QEMU_PACKED;
> > +
> > +	struct release_dcd_cap_in_pl *in = (void *)cmd->payload;
> > +	struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> > +	CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> > +	CXLDCD_Extent *ent;
> > +	uint32_t i;
> > +	uint64_t dpa, len;
> > +	CXLRetCode rs;
> > +
> > +	if (in->num_entries_updated == 0)
> > +		return CXL_MBOX_INVALID_INPUT;
> > +
> > +	rs = detect_malformed_extent_list(ct3d, in);
> > +	if (rs != CXL_MBOX_SUCCESS)
> > +		return rs;
> > +
> > +		/* Todo: check following
> > +		 * One or more of the updated extent lists contain Starting DPA
> > +		 * or Lengths that are out of range of a current extent list
> > +		 * maintained by the device.
> > +		 **/
> > +
> > +	for (i = 0; i < in->num_entries_updated; i++) {
> > +		dpa = in->updated_entries[i].start_dpa;
> > +		len = in->updated_entries[i].len;
> > +
> > +		QTAILQ_FOREACH(ent, extent_list, node) {
> > +			if (ent->start_dpa == dpa && ent->len == len)
> 
> Do the remove here and comment on 'found entry' not needed.
> Note I think you can release partial extents so that will need handling at some point.
> 
> > +				break;
> > +			else if ((dpa < ent->start_dpa + ent->len
> > +				&& dpa + len > ent->start_dpa + ent->len)
> > +				|| (dpa < ent->start_dpa && dpa + len > ent->start_dpa))
> Comment on this condition and why it's a problem.
> 
> > +				return CXL_MBOX_INVALID_EXTENT_LIST;
> > +		}
> > +		/* found the entry, release it */
> > +		if (ent)
> > +			QTAILQ_REMOVE(extent_list, ent, node);
> > +	}
> > +
> > +	return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> >  #define IMMEDIATE_DATA_CHANGE (1 << 2)
> >  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> > @@ -1112,6 +1329,12 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
> >  	[DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
> >  		"DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
> >  		8, 0 },
> > +	[DCD_CONFIG][ADD_DYN_CAP_RSP] = {
> > +		"ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
> > +		~0, IMMEDIATE_DATA_CHANGE },
> > +	[DCD_CONFIG][RELEASE_DYN_CAP] = {
> > +		"RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dcd_capacity,
> > +		~0, IMMEDIATE_DATA_CHANGE },
> >  };
> >  
> >  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 20ad5e7411..c0c8fcc24b 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -131,7 +131,8 @@ typedef enum {
> >      CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
> >      CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
> >      CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
> > -    CXL_MBOX_MAX = 0x17
> > +	CXL_MBOX_INVALID_EXTENT_LIST = 0x17,
> 
> 0x1e in the spec.
> 
> > +	CXL_MBOX_MAX = 0x18
> >  } CXLRetCode;
> >  
> >  struct cxl_cmd;
> 

-- 
Fan Ni <nifan@outlook.com>

