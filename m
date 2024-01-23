Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF48838B4E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:01:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDas-0001ih-BU; Tue, 23 Jan 2024 05:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSDap-0001iR-4n
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:01:19 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSDak-0000OC-Nc
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706004075; x=1737540075;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pn0bIRKcoANUklLROejorQOQgnpdrAuC7H5WQ52b5JI=;
 b=eD/Z7MSOVbXfKBk6e9VpZkQfoS6FYJaKrRmqcXSKpuz8Tx9uShu+equu
 4uEaitHqup1+NsVrg9dchOCj3vL+A8JUnVpdrIQo/MVp29ZzPPT3JCVlY
 CO0FCuYr27muAJBiXTqj17s6blWkChmEmiwQI8kUnXlWwuC7WfxoywzHk
 /1st/7LBBy51zmYiOJ3M1gTjGD2f4iFzum7JVx/zBmBe83e8EVjo1NFBJ
 9Kit0M9G3RsQFc3838DuDhJ04wtUyIuyEH8OatL7CLmvO5JwzJCfFaLeG
 raO5cSfCrrVkaYYyeASLHTDjmepLgyacLQ7/VE5Nfbee1vSuAvctW/I5Z w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="14825749"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; d="scan'208";a="14825749"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2024 02:01:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="905180325"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; d="scan'208";a="905180325"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jan 2024 02:01:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 02:01:09 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 02:01:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 02:01:08 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 02:01:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfnFlmx6CBZ3Z/VidPfaA7GGCsq5cRrXTWuPPuerCXncZU+m88HtCFrm8z0Wa6mRqTSO+XfZGqxMUZRs9a2n5t3ZiOs38eWdyFBeedwCgA66V4XvinUKDSoqTxXGwOSQ/yYZyWZJrMWRNBQo1EbaxL227cC6sxAocFx/7qhno9wdszFHR40nHJXFnB3OjGk67miTL0X3c6rGgSWUXVvuAIeCWkjVfUKix0JgHfPiW6QgyZ2wD6LaAAMj4AUjwwIIvZzLWx0XprXrIrpR9d4RUP8OG6VdhTS3XTUYbIP0XsKUNifpKkVF4eWA2T6biQml1htcoJbdFV7wJFtkg9nKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn0bIRKcoANUklLROejorQOQgnpdrAuC7H5WQ52b5JI=;
 b=EHWkPy/dcjV8HlGK72/evQp1Ql8MferXO14oxPxnARz3yTcy5AavJcIu+Hx96vY3CVWlcJJOnnDnNtMYyODN46mT9o6DpdH8ukvSUaMIMM+VwIV1/MUlobeBtk3RKxCleKlVbrXoXc3JeK5cuY9E5IRhEm0PtXAGSKQWBvGPVta7TE1d6dbJ4stP8W/DAIqZXAurwgbewY4Fl4miDfwx7yYYqUbUsqydNtLBL92KONqq3JbYq1nVa+H7bipDWc2zfa7iNfaMk/5LeqNUr4GDEXDblQnSCxwWxOAI2wk1zWxqXAseV5vvcpMa06jhlvDgBUvRgnhFVzuwm64BHe6HZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 10:01:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 10:01:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Subject: RE: [PATCH rfcv1 6/6] intel_iommu: add a framework to check and sync
 host IOMMU cap/ecap
Thread-Topic: [PATCH rfcv1 6/6] intel_iommu: add a framework to check and sync
 host IOMMU cap/ecap
Thread-Index: AQHaR5v7WsCg8QEA5Em7AcF13NhjjbDnIBeAgAAUwEA=
Date: Tue, 23 Jan 2024 10:01:03 +0000
Message-ID: <SJ0PR11MB6744E0ECC309E1AEE1B6FD5092742@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-7-zhenzhong.duan@intel.com>
 <5f78ee34-757b-4264-81b7-7ec7e5f12259@redhat.com>
In-Reply-To: <5f78ee34-757b-4264-81b7-7ec7e5f12259@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BN9PR11MB5276:EE_
x-ms-office365-filtering-correlation-id: 256d4b2b-ebd3-4ab6-0570-08dc1bfa3573
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zTC/peEQhBycO98P8+OVNzMSiG89aleCTSBMgC7AZJG+QKNwmkCQkg/90kbSC91khALsAtLyfJ+Ek6S8xeLLGw+c4/JTUlFlxeEil8C2ulc8267yuV9Of2ihtP9q/KIEvs5WtOy/qW+h3qsiOr+U79rpYghiqJGEBOTlQCkh2a0rolIR1zReHJhcjl+mToLgng6Q+JUUIf/txk38N82Vxvag/Yt3ZwnHVR805jhlSSCkbzTCrI2qWNCH/TNLffY4epb/wuDJcDoo/6ZBxOlK0/Pv7Er4SDfCwdOdKjlBIDPx3XZ5Q9OOSoeOlt4RXMLgcRIzhtnQS9j4Q1dN78f3rjFZRywu7TY+fibAZ0h7wmm0TF1x5hfGGq1lKLX4wmqsu2VRDWRMqziOfTiXASJUQxaxHVCdPCZ3TG9MdB0F/HhXXAsDLfprpz/aHcLGBI4epH8l2K2l3K8tpjKykjl/iyotjF2xITWixCh40IdMeZ338UT2C/X9gmdSLzOEMNwW0RXCW9+F7Oj06ypNV+yRKF9xPOvDJOImcFD+GcMdwg2GT5Ski4QUuNIeWUs2apzLSt8y9fymbuzd+UT6zAhaVA+/R9D0ZLM4reEc/rdDT8BVK2PJJ6CCrS/m9VGePdD+D4Eoyhg1p7smNpec3XMI2QUsFEuA44kG6I3hnIpyhNo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(64756008)(316002)(76116006)(54906003)(66946007)(66556008)(66476007)(66446008)(38070700009)(966005)(110136005)(4326008)(38100700002)(8676002)(52536014)(8936002)(122000001)(82960400001)(33656002)(86362001)(71200400001)(26005)(6506007)(478600001)(9686003)(7696005)(83380400001)(66574015)(41300700001)(5660300002)(2906002)(7416002)(55016003)(13296009)(473944003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkpCSExRTDBJM2FWUDNWU3NGRjdXbDQ2aXJ5ZmpQWHg2ekdpcjl3emxrdWNr?=
 =?utf-8?B?cC9MbmZmOERVYTEySU8wdFhSeXduWEV2WFRWWVplN3NDWmZGY3V6YmUxdnBp?=
 =?utf-8?B?NlF1ZndKNEZ3RHk0YjFyNCs1N0t1UHhNVFRud0Y0bE12T3pyN1dNamFHdkMv?=
 =?utf-8?B?WEpPSFhNOFdQdEUvbW43SFUwQXViRnlSUXNaSlY2RHJJVkFHeEthM0J2dlJI?=
 =?utf-8?B?TVdoVHBHZ20ybmpPZytIVTEyTjRBQ3hLWFNUUHFIWHpLSEVBeHBKRDNKak80?=
 =?utf-8?B?emM2TDNucUVacEI5ZWoxSVZaNXFBdUhQQUhsVU8yN1RETzdOcTU2ZFN1SUs0?=
 =?utf-8?B?Sk90Ni9uRzRaQlhYbUZZNzgyNTFUaTQxbnFuNW51L1RPQzJmS3l4SXY2QUhO?=
 =?utf-8?B?UjJGbXlrZTNNcTB2dnNla2k5SUJlQTZpRGJEUHc3NHROa0VOVFpBSGVIWENl?=
 =?utf-8?B?bnZmNmNSNDArZldsUG9rM092Y2ZacEo1RnE4My9MV0swTDIrb0FFR2JYeWc1?=
 =?utf-8?B?eVM1RFRVd3JveTlmdmQydkhxUHluSWozUFAzU0ZOWFc0VHpvNDdRQlhuRW45?=
 =?utf-8?B?cjVPS2E2Zyt1WDRwTEIzcTRVOGdLMDVMdHM2aGJaT0YxbW5vU210eVUyend4?=
 =?utf-8?B?N1VGZGFHZ2ZmcXg1M1VoZG5uTTVIM1p4RC9XZ05xNnZ6NUMvUDVScGkyOVVZ?=
 =?utf-8?B?aVh1VCtzQSszTUpPZTJIS3hhVU55RU8zQnVZdnF5OE5FRnE3SHpYL0VSb3RP?=
 =?utf-8?B?azBFTkRhSkY4dVJVZ0RwS1BaR1UwUGwrdDI4M09Tbm9UN3J4bmJ0NWVtM3ZB?=
 =?utf-8?B?ZWdBRS9BckYrWGxFSWZPeStLZ0FWRDBKeHpweWVmcWRiRml3bFpJdm9ZWWox?=
 =?utf-8?B?VUJjYVYxSHp4WjUwM1lOVDBLeXpkeWg1RmZYbUFvbVJleUJtT1ZRZUtvaGln?=
 =?utf-8?B?b1MrNSt5R01KMWkwdzlmck9ocllTUk9sU3d0K0ZiWFVIRkx6ZEZFSy9XRDFr?=
 =?utf-8?B?RzdVNndrMDNHRUJFSkdudmFtSHlxSFJRU1NGak9Ebjl5MFo3ZzRSV0labDc5?=
 =?utf-8?B?OVVHUklaN1hjNFRQZUI2bFVxVnF6TWQrQXlPTmFHUEtyeW5YU1lQc09wUDlQ?=
 =?utf-8?B?OVJ5cFlJTHF2TkJUclhoZXUzY0s0TE1ESUxMbUUyc3E3OHJDc3VCQXhYUDlG?=
 =?utf-8?B?Ym4ySWhTZFExZEZZdWdqWk9mNFNJSEY5UldQcUdHNUxLZWxVcFJwdXpiZW5C?=
 =?utf-8?B?NUxvbTJiOXJKVEpWUFQ3c0NjQlllamJHbTVSbW5YbzN6WmxjTHp6L3EySjZS?=
 =?utf-8?B?dnlZOUI3TWpZVUlMZ09SWGgwWUE4NnpyNGFYNmRaalc4MnQybWk4WmtuVWZr?=
 =?utf-8?B?cjJQSXlxOE5UTWpac1VBa09OSlJSVEkyR29NQ0F0N2ZLNWtkcVVkMi9ac0dl?=
 =?utf-8?B?RzVDMTdwTXFaZ2hjT2JjZzZveHR4d2ZxblRabldpYkNjM3FOaytLOWEyZ1k2?=
 =?utf-8?B?NS91VzNXT2l0azBnTlhhUVFXU0N4S0kvclBGQU1QTng0SDE1aXF6d0RBU0hk?=
 =?utf-8?B?bzJtZWlzVEJISTVaV0pLdTVBZTJVRjZYa3JMQTVZYlNVcnV1d2daZ2hXdlVB?=
 =?utf-8?B?OUE0OGxGQU9iUGtXNk5jditHQ3VMc2hERXIzR09yaFUyZUlRUDNZeHpMbjJK?=
 =?utf-8?B?clNoOVVveVRyYXlkN0sxRHpYbTk3RjRhdDkyU3oxTUZ0dnNUZHExc1Uzdk1t?=
 =?utf-8?B?Qm12ZVNoRm9jazBjVGlvVFZ3ajYyZGhFbUJXSkorblJKNUIvbVNONy9ydnBw?=
 =?utf-8?B?S1FZM1B0WG9kd1R3TWdnWHdvVTM1Q0RCME04dVF5Vm0xUVVWQU9hbnp2ZzV4?=
 =?utf-8?B?UzN6dGg1K1NYaFMyRkVpMlpqMlBRZDF6MVZsV1k4bFNyNHp3aFdDMjZkMTRY?=
 =?utf-8?B?MmJ0VmF5L2pVNSs4UjJsV2tmckJFeS8xN01PTFhFbldzcFl2dlZXak44bVNu?=
 =?utf-8?B?aC8wNG5MRjEzbitad1Z0bXQreVFzbEpBaXdvYi9UckJjZWFBd1h0Tjc5bkZl?=
 =?utf-8?B?Q0oyWVQreTB4ZW9sQUt0Sy9RSW1NMlFBaHdORFlsNUkrOGxtQS82WDhCcXYz?=
 =?utf-8?Q?LDZ2+txUk9b1PtjumJXNA66L4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256d4b2b-ebd3-4ab6-0570-08dc1bfa3573
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 10:01:03.2015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8/I1ThPS2mHB89D9kr0tgXqONrinHgL/8ZkJXfOvZqxmrC/wlb42nBOy9nSHc+sDE78kSC/tRNadjY2CLWmbYcVLC+TKLHYM0aB9Xa9cnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5276
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDYvNl0gaW50ZWxf
aW9tbXU6IGFkZCBhIGZyYW1ld29yayB0byBjaGVjayBhbmQNCj5zeW5jIGhvc3QgSU9NTVUgY2Fw
L2VjYXANCj4NCj5PbiAxLzE1LzI0IDExOjEzLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEZy
b206IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4NCj4+IEFkZCBhIGZyYW1ld29yayB0
byBjaGVjayBhbmQgc3luY2hyb25pemUgaG9zdCBJT01NVSBjYXAvZWNhcCB3aXRoDQo+PiB2SU9N
TVUgY2FwL2VjYXAuDQo+Pg0KPj4gQ3VycmVudGx5IG9ubHkgc3RhZ2UtMiB0cmFuc2xhdGlvbiBp
cyBzdXBwb3J0ZWQgd2hpY2ggaXMgYmFja2VkIGJ5DQo+PiBzaGFkb3cgcGFnZSB0YWJsZSBvbiBo
b3N0IHNpZGUuIFNvIHdlIGRvbid0IG5lZWQgZXhhY3QgbWF0Y2hpbmcgb2YNCj4+IGVhY2ggYml0
IG9mIGNhcC9lY2FwIGJldHdlZW4gdklPTU1VIGFuZCBob3N0LiBIb3dldmVyLCB3ZSBjYW4gc3Rp
bGwNCj4+IHV0aWxpemUgdGhpcyBmcmFtZXdvcmsgdG8gZW5zdXJlIGNvbXBhdGliaWxpdHkgb2Yg
aG9zdCBhbmQgdklPTU1VJ3MNCj4+IGFkZHJlc3Mgd2lkdGggYXQgbGVhc3QsIGkuZS4sIHZJT01N
VSdzIGF3X2JpdHMgPD0gaG9zdCBhd19iaXRzLA0KPj4gd2hpY2ggaXMgbWlzc2VkIGJlZm9yZS4N
Cj4+DQo+PiBXaGVuIHN0YWdlLTEgdHJhbnNsYXRpb24gaXMgc3VwcG9ydGVkIGluIGZ1dHVyZSwg
YS5rLmEuIHNjYWxhYmxlDQo+PiBtb2Rlcm4gbW9kZSwgd2UgbmVlZCB0byBlbnN1cmUgY29tcGF0
aWJpbGl0eSBvZiBlYWNoIGJpdHMuIFNvbWUNCj4+IGJpdHMgYXJlIHVzZXIgY29udHJvbGxhYmxl
LCB0aGV5IHNob3VsZCBiZSBjaGVja2VkIHdpdGggaG9zdCBzaWRlDQo+PiB0byBlbnN1cmUgY29t
cGF0aWJpbGl0eS4gT3RoZXIgYml0cyBhcmUgbm90LCB0aGV5IHNob3VsZCBiZSBzeW5jZWQNCj4+
IGludG8gdklPTU1VIGNhcC9lY2FwIGZvciBjb21wYXRpYmlsaXR5Lg0KPj4NCj4+IFRoZSBzZXF1
ZW5jZSB3aWxsIGJlOg0KPj4NCj4+IHZ0ZF9jYXBfaW5pdCgpIGluaXRpYWxpemVzIGlvbW11LT5j
YXAvZWNhcC4gLS0tLSB2dGRfY2FwX2luaXQoKQ0KPj4gaW9tbXUtPmhvc3RfY2FwL2VjYXAgaXMg
aW5pdGlhbGl6ZWQgYXMgaW9tbXUtPmNhcC9lY2FwLiAgLS0tLSB2dGRfaW5pdCgpDQo+PiBpb21t
dS0+aG9zdF9jYXAvZWNhcCBpcyBjaGVja2VkIGFuZCB1cGRhdGVkIHNvbWUgYml0cyB3aXRoIGhv
c3QNCj5jYXAvZWNhcC4gLS0tLSB2dGRfc3luY19od19pbmZvKCkNCj4+IGlvbW11LT5jYXAvZWNh
cCBpcyBmaW5hbGl6ZWQgYXMgaW9tbXUtPmhvc3RfY2FwL2VjYXAuICAtLS0tDQo+dnRkX21hY2hp
bmVfZG9uZV9ob29rKCkNCj4+DQo+PiBpb21tdS0+aG9zdF9jYXAvZWNhcCBpcyBhIHRlbXBvcmFy
eSBzdG9yYWdlIHRvIGhvbGQgaW50ZXJtZWRpYXRlIHZhbHVlDQo+PiB3aGVuIHN5bnRoZXNpemUg
aG9zdCBjYXAvZWNhcCBhbmQgdklPTU1VJ3MgaW5pdGlhbCBjb25maWd1cmVkIGNhcC9lY2FwLg0K
Pg0KPg0KPlRoZSBhYm92ZSAic2VxdWVuY2UiIHBhcmFncmFwaCBpcyBub3QgdmVyeSBjbGVhci4g
VGhlIHBhdGNoIG1heSBuZWVkIHRvDQo+YmUgc3BsaXQgZnVydGhlci4NCg0KT0ssIHdpbGwgZG8u
DQoNCj4NCj4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29t
Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
Pg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIHwgIDQgKysNCj4+
ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgfCA3OA0KPisrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2lu
dGVsX2lvbW11LmgNCj5iL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBpbmRleCBj
NjVmZGRlNTZmLi5iOGFiYmNjZTEyIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2lu
dGVsX2lvbW11LmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBA
QCAtMjkyLDYgKzI5Miw5IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPj4gICAgICAgdWlu
dDY0X3QgY2FwOyAgICAgICAgICAgICAgICAgICAvKiBUaGUgdmFsdWUgb2YgY2FwYWJpbGl0eSBy
ZWcgKi8NCj4+ICAgICAgIHVpbnQ2NF90IGVjYXA7ICAgICAgICAgICAgICAgICAgLyogVGhlIHZh
bHVlIG9mIGV4dGVuZGVkIGNhcGFiaWxpdHkgcmVnICovDQo+Pg0KPj4gKyAgICB1aW50NjRfdCBo
b3N0X2NhcDsgICAgICAgICAgICAgIC8qIFRoZSB2YWx1ZSBvZiBob3N0IGNhcGFiaWxpdHkgcmVn
ICovDQo+PiArICAgIHVpbnQ2NF90IGhvc3RfZWNhcDsgICAgICAgICAgICAgLyogVGhlIHZhbHVl
IG9mIGhvc3QgZXh0LWNhcGFiaWxpdHkgcmVnICovDQo+PiArDQo+PiAgICAgICB1aW50MzJfdCBj
b250ZXh0X2NhY2hlX2dlbjsgICAgIC8qIFNob3VsZCBiZSBpbiBbMSxNQVhdICovDQo+PiAgICAg
ICBHSGFzaFRhYmxlICppb3RsYjsgICAgICAgICAgICAgIC8qIElPVExCICovDQo+Pg0KPj4gQEAg
LTMxNCw2ICszMTcsNyBAQCBzdHJ1Y3QgSW50ZWxJT01NVVN0YXRlIHsNCj4+ICAgICAgIGJvb2wg
ZG1hX3RyYW5zbGF0aW9uOyAgICAgICAgICAgLyogV2hldGhlciBETUEgdHJhbnNsYXRpb24gc3Vw
cG9ydGVkICovDQo+PiAgICAgICBib29sIHBhc2lkOyAgICAgICAgICAgICAgICAgICAgIC8qIFdo
ZXRoZXIgdG8gc3VwcG9ydCBQQVNJRCAqLw0KPj4NCj4+ICsgICAgYm9vbCBjYXBfZmluYWxpemVk
OyAgICAgICAgICAgICAvKiBXaGV0aGVyIFZURCBjYXBhYmlsaXR5IGZpbmFsaXplZCAqLw0KPj4g
ICAgICAgLyoNCj4+ICAgICAgICAqIFByb3RlY3RzIElPTU1VIHN0YXRlcyBpbiBnZW5lcmFsLiAg
Q3VycmVudGx5IGl0IHByb3RlY3RzIHRoZQ0KPj4gICAgICAgICogcGVyLUlPTU1VIElPVExCIGNh
Y2hlLCBhbmQgY29udGV4dCBlbnRyeSBjYWNoZSBpbg0KPlZUREFkZHJlc3NTcGFjZS4NCj4+IGRp
ZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+IGluZGV4IDRjMWQwNThlYmQuLmJlMDNmY2JmNTIgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTM4
MTksNiArMzgxOSw0NyBAQCBWVERBZGRyZXNzU3BhY2UNCj4qdnRkX2ZpbmRfYWRkX2FzKEludGVs
SU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQo+PiAgICAgICByZXR1cm4gdnRkX2Rldl9hczsN
Cj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgYm9vbCB2dGRfc3luY19od19pbmZvKEludGVsSU9NTVVT
dGF0ZSAqcywgc3RydWN0DQo+aW9tbXVfaHdfaW5mb192dGQgKnZ0ZCwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIHVpbnQ2NF90
IGFkZHJfd2lkdGg7DQo+PiArDQo+PiArICAgIGFkZHJfd2lkdGggPSAodnRkLT5jYXBfcmVnID4+
IDE2KSAmIDB4M2ZVTEw7DQo+DQo+VmlyZWsgdXNlcyB0aGUgc2FtZSBraW5kIG9mIG1hY3JvIGlu
IDoNCj4NCj4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQwMTE4MTky
MDQ5LjE3OTY3NjMtMS0NCj52aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tLw0KPg0KPldoYXQgYWJv
dXQgdGhlICsgMSA/IExvb2tzIGxpa2UgaXQncyBtaXNzaW5nIGhlcmUsIGFjY29yZGluZyB0byAx
MS40LjINCj5DYXBhYmlsaXR5IFJlZ2lzdGVyLg0KPg0KPkNvdWxkIHdlIGludHJvZHVjZSBhIGNv
bW1vbiBtYWNybyBpbiBpbnRlbF9pb21tdV9pbnRlcm5hbC5oID8NCg0KU3VyZS4NCg0KPg0KPg0K
Pj4gKyAgICBpZiAocy0+YXdfYml0cyA+IGFkZHJfd2lkdGgpIHsNCj4+ICsgICAgICAgIGVycm9y
X3NldGcoZXJycCwgIlVzZXIgYXctYml0czogJXUgPiBob3N0IGFkZHJlc3Mgd2lkdGg6ICVsdSIs
DQo+DQo+SSB0aGluayAlbHUgc2hvdWxkIGJlIFBSSWQ2NC4gVGhpcyBpcyBhIGdlbmVyYWwgY29t
bWVudC4gWW91IHNob3VsZCBhdm9pZA0KPiVsbHgsICVseCwgZXRjLiBpbiB0aGUgY29kZS4NCg0K
R290IGl0Lg0KDQo+DQo+PiArICAgICAgICAgICAgICAgICAgIHMtPmF3X2JpdHMsIGFkZHJfd2lk
dGgpOw0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAg
IC8qIFRPRE86IGNoZWNrIGFuZCBzeW5jIGhvc3QgY2FwL2VjYXAgaW50byB2SU9NTVUgY2FwL2Vj
YXAgKi8NCj4+ICsNCj4+ICsgICAgcmV0dXJuIHRydWU7DQo+PiArfQ0KPj4gKw0KPj4gKy8qDQo+
PiArICogdmlydHVhbCBWVC1kIHdoaWNoIHdhbnRzIG5lc3RlZCBuZWVkcyB0byBjaGVjayB0aGUg
aG9zdCBJT01NVQ0KPj4gKyAqIG5lc3RpbmcgY2FwIGluZm8gYmVoaW5kIHRoZSBhc3NpZ25lZCBk
ZXZpY2VzLiBUaHVzIHRoYXQgdklPTU1VDQo+PiArICogY291bGQgYmluZCBndWVzdCBwYWdlIHRh
YmxlIHRvIGhvc3QuDQo+PiArICovDQo+PiArc3RhdGljIGJvb2wgdnRkX2NoZWNrX2lkZXYoSW50
ZWxJT01NVVN0YXRlICpzLCBJT01NVUZERGV2aWNlICppZGV2LA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIHN0cnVjdCBpb21tdV9o
d19pbmZvX3Z0ZCB2dGQ7DQo+PiArICAgIGVudW0gaW9tbXVfaHdfaW5mb190eXBlIHR5cGUgPQ0K
PklPTU1VX0hXX0lORk9fVFlQRV9JTlRFTF9WVEQ7DQo+PiArDQo+PiArICAgIGlmIChpb21tdWZk
X2RldmljZV9nZXRfaW5mbyhpZGV2LCAmdHlwZSwgc2l6ZW9mKHZ0ZCksICZ2dGQpKSB7DQo+PiAr
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJGYWlsZWQgdG8gZ2V0IElPTU1VIGNhcGFiaWxpdHkh
ISEiKTsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAg
ICBpZiAodHlwZSAhPSBJT01NVV9IV19JTkZPX1RZUEVfSU5URUxfVlREKSB7DQo+PiArICAgICAg
ICBlcnJvcl9zZXRnKGVycnAsICJJT01NVSBoYXJkd2FyZSBpcyBub3QgY29tcGF0aWJsZSEhISIp
Ow0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJl
dHVybiB2dGRfc3luY19od19pbmZvKHMsICZ2dGQsIGVycnApOw0KPj4gK30NCj4+ICsNCj4+ICAg
c3RhdGljIGludCB2dGRfZGV2X3NldF9pb21tdV9kZXZpY2UoUENJQnVzICpidXMsIHZvaWQgKm9w
YXF1ZSwNCj5pbnQzMl90IGRldmZuLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBJT01NVUZERGV2aWNlICppZGV2LCBFcnJvciAqKmVycnApDQo+PiAgIHsNCj4+IEBA
IC0zODM3LDYgKzM4NzgsMTAgQEAgc3RhdGljIGludCB2dGRfZGV2X3NldF9pb21tdV9kZXZpY2Uo
UENJQnVzDQo+KmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQzMl90IGRldmZuLA0KPj4gICAgICAgICAg
IHJldHVybiAwOw0KPj4gICAgICAgfQ0KPj4NCj4+ICsgICAgaWYgKCF2dGRfY2hlY2tfaWRldihz
LCBpZGV2LCBlcnJwKSkgew0KPj4gKyAgICAgICAgcmV0dXJuIC0xOw0KPj4gKyAgICB9DQo+PiAr
DQo+PiAgICAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4+DQo+PiAgICAgICB2dGRfaWRldiA9IGdf
aGFzaF90YWJsZV9sb29rdXAocy0+dnRkX2lvbW11ZmRfZGV2LCAma2V5KTsNCj4+IEBAIC00MDcx
LDEwICs0MTE2LDExIEBAIHN0YXRpYyB2b2lkIHZ0ZF9pbml0KEludGVsSU9NTVVTdGF0ZSAqcykN
Cj4+ICAgew0KPj4gICAgICAgWDg2SU9NTVVTdGF0ZSAqeDg2X2lvbW11ID0gWDg2X0lPTU1VX0RF
VklDRShzKTsNCj4+DQo+PiAtICAgIG1lbXNldChzLT5jc3IsIDAsIERNQVJfUkVHX1NJWkUpOw0K
Pj4gLSAgICBtZW1zZXQocy0+d21hc2ssIDAsIERNQVJfUkVHX1NJWkUpOw0KPj4gLSAgICBtZW1z
ZXQocy0+dzFjbWFzaywgMCwgRE1BUl9SRUdfU0laRSk7DQo+PiAtICAgIG1lbXNldChzLT53b21h
c2ssIDAsIERNQVJfUkVHX1NJWkUpOw0KPj4gKyAgICAvKiBDQVAvRUNBUCBhcmUgaW5pdGlhbGl6
ZWQgaW4gbWFjaGluZSBjcmVhdGUgZG9uZSBzdGFnZSAqLw0KPj4gKyAgICBtZW1zZXQocy0+Y3Ny
ICsgRE1BUl9HQ01EX1JFRywgMCwgRE1BUl9SRUdfU0laRSAtDQo+RE1BUl9HQ01EX1JFRyk7DQo+
PiArICAgIG1lbXNldChzLT53bWFzayArIERNQVJfR0NNRF9SRUcsIDAsIERNQVJfUkVHX1NJWkUg
LQ0KPkRNQVJfR0NNRF9SRUcpOw0KPj4gKyAgICBtZW1zZXQocy0+dzFjbWFzayArIERNQVJfR0NN
RF9SRUcsIDAsIERNQVJfUkVHX1NJWkUgLQ0KPkRNQVJfR0NNRF9SRUcpOw0KPj4gKyAgICBtZW1z
ZXQocy0+d29tYXNrICsgRE1BUl9HQ01EX1JFRywgMCwgRE1BUl9SRUdfU0laRSAtDQo+RE1BUl9H
Q01EX1JFRyk7DQo+Pg0KPj4gICAgICAgcy0+cm9vdCA9IDA7DQo+PiAgICAgICBzLT5yb290X3Nj
YWxhYmxlID0gZmFsc2U7DQo+PiBAQCAtNDExMCwxMyArNDE1NiwxNiBAQCBzdGF0aWMgdm9pZCB2
dGRfaW5pdChJbnRlbElPTU1VU3RhdGUgKnMpDQo+DQo+dnRkX2luaXQoKSBpcyBjYWxsZWQgZnJv
bSByZXNldCBhbmQgZnJvbSByZWFsaXplLiBUaGlzIGlzIHJlZHVuZGFudC4NCj5yZXNldCBzaG91
bGQgYmUgZW5vdWdoLg0KDQpMb29rcyBzby4gSSdsbCB0cnkgdG8gc2VlIGlmIGl0IGJyZWFrIGFu
eXRoaW5nLg0KDQo+DQo+DQo+PiAgICAgICAgICAgdnRkX3NwdGVfcnN2ZF9sYXJnZVszXSAmPSB+
VlREX1NQVEVfU05QOw0KPj4gICAgICAgfQ0KPj4NCj4+IC0gICAgdnRkX2NhcF9pbml0KHMpOw0K
Pj4gKyAgICBpZiAoIXMtPmNhcF9maW5hbGl6ZWQpIHsNCj4NCj5vay4gc28gdGhpcyBjYW4gb25s
eSBiZSBkb25lIGluIHJlc2V0Lg0KDQpOb3QgcXVpdGUgZ2V0LCB2dGRfaW5pdCBjYW4gYmUgY2Fs
bGVkIG11bHRpcGxlIHRpbWVzIGhhcm1sZXNzbHkgYmVmb3JlIG1hY2hpbmUgY3JlYXRlIGRvbmUu
DQpCdXQgb25jZSBpcyBlbm91Z2gsIGkuZS4sIGluIHJlc2V0LiBUaGUgY2FsbCBpbiByZWFsaXpl
IGxvb2tzIHJlZHVuZGFudC4NCg0KPg0KPj4gKyAgICAgICAgdnRkX2NhcF9pbml0KHMpOw0KPj4g
KyAgICAgICAgcy0+aG9zdF9jYXAgPSBzLT5jYXA7DQo+PiArICAgICAgICBzLT5ob3N0X2VjYXAg
PSBzLT5lY2FwOw0KPj4gKyAgICB9DQo+PiArDQo+PiAgICAgICB2dGRfcmVzZXRfY2FjaGVzKHMp
Ow0KPj4NCj4+ICAgICAgIC8qIERlZmluZSByZWdpc3RlcnMgd2l0aCBkZWZhdWx0IHZhbHVlcyBh
bmQgYml0IHNlbWFudGljcyAqLw0KPj4gICAgICAgdnRkX2RlZmluZV9sb25nKHMsIERNQVJfVkVS
X1JFRywgMHgxMFVMLCAwLCAwKTsNCj4+IC0gICAgdnRkX2RlZmluZV9xdWFkKHMsIERNQVJfQ0FQ
X1JFRywgcy0+Y2FwLCAwLCAwKTsNCj4+IC0gICAgdnRkX2RlZmluZV9xdWFkKHMsIERNQVJfRUNB
UF9SRUcsIHMtPmVjYXAsIDAsIDApOw0KPj4gICAgICAgdnRkX2RlZmluZV9sb25nKHMsIERNQVJf
R0NNRF9SRUcsIDAsIDB4ZmY4MDAwMDBVTCwgMCk7DQo+PiAgICAgICB2dGRfZGVmaW5lX2xvbmdf
d28ocywgRE1BUl9HQ01EX1JFRywgMHhmZjgwMDAwMFVMKTsNCj4+ICAgICAgIHZ0ZF9kZWZpbmVf
bG9uZyhzLCBETUFSX0dTVFNfUkVHLCAwLCAwLCAwKTsNCj4+IEBAIC00MjQxLDYgKzQyOTAsMTIg
QEAgc3RhdGljIGJvb2wNCj52dGRfZGVjaWRlX2NvbmZpZyhJbnRlbElPTU1VU3RhdGUgKnMsIEVy
cm9yICoqZXJycCkNCj4+ICAgICAgIHJldHVybiB0cnVlOw0KPj4gICB9DQo+Pg0KPj4gK3N0YXRp
YyB2b2lkIHZ0ZF9zZXR1cF9jYXBhYmlsaXR5X3JlZyhJbnRlbElPTU1VU3RhdGUgKnMpDQo+PiAr
ew0KPj4gKyAgICB2dGRfZGVmaW5lX3F1YWQocywgRE1BUl9DQVBfUkVHLCBzLT5jYXAsIDAsIDAp
Ow0KPj4gKyAgICB2dGRfZGVmaW5lX3F1YWQocywgRE1BUl9FQ0FQX1JFRywgcy0+ZWNhcCwgMCwg
MCk7DQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgaW50IHZ0ZF9tYWNoaW5lX2RvbmVfbm90aWZ5
X29uZShPYmplY3QgKmNoaWxkLCB2b2lkICp1bnVzZWQpDQo+PiAgIHsNCj4+ICAgICAgIEludGVs
SU9NTVVTdGF0ZSAqaW9tbXUgPQ0KPklOVEVMX0lPTU1VX0RFVklDRSh4ODZfaW9tbXVfZ2V0X2Rl
ZmF1bHQoKSk7DQo+PiBAQCAtNDI1OSw2ICs0MzE0LDE0IEBAIHN0YXRpYyBpbnQNCj52dGRfbWFj
aGluZV9kb25lX25vdGlmeV9vbmUoT2JqZWN0ICpjaGlsZCwgdm9pZCAqdW51c2VkKQ0KPj4NCj4+
ICAgc3RhdGljIHZvaWQgdnRkX21hY2hpbmVfZG9uZV9ob29rKE5vdGlmaWVyICpub3RpZmllciwg
dm9pZCAqdW51c2VkKQ0KPj4gICB7DQo+PiArICAgIEludGVsSU9NTVVTdGF0ZSAqaW9tbXUgPQ0K
PklOVEVMX0lPTU1VX0RFVklDRSh4ODZfaW9tbXVfZ2V0X2RlZmF1bHQoKSk7DQo+PiArDQo+PiAr
ICAgIGlvbW11LT5jYXAgPSBpb21tdS0+aG9zdF9jYXA7DQo+PiArICAgIGlvbW11LT5lY2FwID0g
aW9tbXUtPmhvc3RfZWNhcDsNCj4+ICsgICAgaW9tbXUtPmNhcF9maW5hbGl6ZWQgPSB0cnVlOw0K
Pj4gKw0KPj4gKyAgICB2dGRfc2V0dXBfY2FwYWJpbGl0eV9yZWcoaW9tbXUpOw0KPj4gKw0KPg0K
PlRoaXMgaXMgY29uZnVzaW5nLiBQbGVhc2Ugc3BsaXQgdGhlIHBhdGNoIGJldHRlciB0byByZWZs
ZWN0IHRoZSBvcmRlcmluZyBvZg0KPnRoZSBlL2NhcCByZWdpc3RlciBzZXR0aW5ncy4NCg0KV2ls
bCBkby4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

