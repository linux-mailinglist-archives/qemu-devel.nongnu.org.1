Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED87A90D7
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 04:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj9Ff-0006KG-Q8; Wed, 20 Sep 2023 22:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9Fe-0006K8-4Y
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 22:17:10 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9Fb-0004B3-Oj
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 22:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695262627; x=1726798627;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zbnNV5L4m7WkqecyLAcDeGR37pqLW4uVAjqSvaRM8KM=;
 b=kNS5HLgzXXnGUGvdXZeVJyLqc8DPflnUiiy2EKBjuATcoveBPtzztLtI
 d59Ldzl9WnH2v+Dkvp1GAYKy+f3X3y1ImHnIfxgh448f2Ri0S6x74DHY0
 FG5/O9OW3Sx7FydBjxhc44mlmcJn3Uk2p0z0n5hqKXA5MdLiNVENEupTb
 Z1R9jLeqSG6pSA4zQgrAIp5lN8MqCjhuf3yMuybV1UN9b6yCUhAdBAeea
 zcD0bq2QxdigNK5Ikrcbg7UXVKtCDf1AZM9inrp59uYKOdZODQJ2TmNbR
 IGrUWfDWtwkb34v06FjVf6RamtsVnWPwSuF1BBYRYG/bmjWlHCVbrtSac g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="383141447"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="383141447"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 19:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="993889805"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="993889805"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 19:17:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 19:17:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 19:17:04 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 19:17:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdpiIdVoUnA7t/G1nGzsY9wpC/O/UJwc2iJI+d7mkYgVSsX0eZtA2+kRgPMSqKb4Jlfltb93g1q1RCW9cEwOoIICdUp9OcMj0np9AD/DuVCgnm0l9ksPfw93N0AJsOmr9YUNpLJKl+GtRhDeO2fs0d/2wJ2VmYcSDa/Y1Pgc3M+dxrvmovu0tVOzJgAeTCQdyshEUGVObgzF/8oG3egZzCJAS9Mj3fOo0Tj4Ps8MTDos56uGU4EbfOfKES25qpPkMVhtZnKDg7TVqS4fRxo9r1H8lICAT888s5MttmraY1a/i/7OmXau56x204eK+A/aQoxNc//+PkI4flukzRpaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XI/SmQtZNzlCNZIRnWg8RYaGu9K6DAxeVp9Iye2Xno=;
 b=fOO7pcVL/7DXqMeeLLP7wrW1PZ/BPbVGwb7FXhN7X9RqD4fy6I86dkqvHkxdRP3nFmqO3yamGcpBSfnR78s/8vhRomKozn23/AfDauMEld8b8chsRYH1XFiuGIQUmJyUDNAsr0ZMh4mtypZbr6kjc2yuvixg7fnvnODG+o8I+j/OU1c9Tm3cgnTF3cqoLQh1ozneNpGxhQPw/nuKl3NtWCrWn2cOmV1vatuQ8mlNtp5vyyYGUCgOL146MNSofNieSCsiYAaAeRPuNg2di4fwSi6XV3btQfx2srv7r/DdRhzWsQrKrAr0rJWt2Np2n/VeXEygC22L8agbafReRnpwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW5PR11MB5931.namprd11.prod.outlook.com (2603:10b6:303:198::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.22; Thu, 21 Sep
 2023 02:16:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 02:16:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 06/22] vfio/common: Add a vfio device iterator
Thread-Topic: [PATCH v1 06/22] vfio/common: Add a vfio device iterator
Thread-Index: AQHZ2zAmb8M8reSSS0+IP/LBpi8W2LAkacIAgABCjIA=
Date: Thu, 21 Sep 2023 02:16:58 +0000
Message-ID: <SJ0PR11MB6744DD3D97968F6FB47EA66192F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-7-zhenzhong.duan@intel.com>
 <20230920161614.3d9e4e5b.alex.williamson@redhat.com>
In-Reply-To: <20230920161614.3d9e4e5b.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW5PR11MB5931:EE_
x-ms-office365-filtering-correlation-id: d47f0ff8-5dbc-48b3-71bc-08dbba48d555
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wBym9GkelhtaI33zaH0jNGAQ99dDYSlV4J/h+GxMRkw/l4YcLXIeNDe2KOKYGiIsOLTkIRoePBV8Nz51ywY13rPF8/RgqOzGTL0sF5FcujWzE9zgg7mAp2AViwvwPDgtMwne+picS2ZBYQ8a7xybmynfonGYeFnfaTQdq318eYaI9urFkweLsm9Pfkh+vzJIARt+2lJ8PQ4R54iAZjAVOlDE9fKFTpYZID8xXs/hyQuAyOqatMMiudmL1qpSnd5l+SrSgDfXd/TuFR5PyMlaxxQ4pW4p6ic/CWFBMAt8gWyWPdh46TWHo4OYlnXmGeUs9bJcRp1JPiZeMjTV2PICVjIAYMrFNtmHHI+Hn2Cnb8u/zpOEUzab4GhI6ubLiNJCKk3dpTxyMuhU7wYVSR7Mv0oDtYZKpApnzzMICZmHnSHoHbtGnH0Ys4TNi+MD0EXjM9y3lX9QMbkqYo0bmG/sHwOCuODbjKafK/nTrOdFSdKdIHrZP1xOEAumemT/ho8vloTsKsqw6rzmew4nm9MRJ258ICSJBwNcDf6V2cmVNARQk9/g8encJss9ph854P9kbP/fQxD+zn3ueZr0R+ADazyVAjZahSkd38Nht9/rF4FfyzgPAi9gLJoXi+T2c9FN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(186009)(1800799009)(451199024)(30864003)(71200400001)(26005)(83380400001)(2906002)(107886003)(66556008)(64756008)(66946007)(4326008)(54906003)(76116006)(66446008)(9686003)(8936002)(66476007)(316002)(6506007)(6916009)(41300700001)(7696005)(5660300002)(8676002)(38100700002)(478600001)(38070700005)(52536014)(82960400001)(122000001)(86362001)(55016003)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KJBx5GudvGuS8C/FbgdYZo3WRa+CazvAzo1h3kdZ9LQMatjgZqglmiSG0Gop?=
 =?us-ascii?Q?GCqs1eNeW0boHyJ8qF4YpK4dcd4FR3dStc9Lmjusb95BlZ1KVE42PpKwMDFj?=
 =?us-ascii?Q?Je+9Crm/+vfChhvRR6P9zFVLmm6uk6WNTKrPafABPtEnH76bXasYQsEwr09d?=
 =?us-ascii?Q?a1B2o+jl9SOoK+GWGjCHtMZjxrxONk0muOFknb1XgmFV37AZy7yywWLmcHVM?=
 =?us-ascii?Q?ePz3qga2jbi7YtqHk/zi2cH64l7Eqj1q9i77hgXxmRgs6n2BOzpzq6t9jSB1?=
 =?us-ascii?Q?93qN3E6SJcYmNvxL3MsI/rsqBqR8Z4xcLBuGmh2qVyI40F3EGGuJ6SEddEXM?=
 =?us-ascii?Q?vp64gGI3zqdpwOcKSN+72Ip8IdDG2J0oNQuLfFZywQPOUHfnPolfmx9j5sGi?=
 =?us-ascii?Q?oRDppiYxPFSReiDuGJHvgWYaB8U6bg/UTPPdubds08D5WV4ekMDdkcMRNXmN?=
 =?us-ascii?Q?TLPKJk2oLsj0CBV+IEGnu/I92oszoJJokLIFYDi4MeQEV7BEEEqSzSR43f1K?=
 =?us-ascii?Q?HkTH8cv1D6ZnM1pBhmvH/BR9t97DZ4fuLmfj/ZIVZIyPoTSM2uzBTBxLt3XW?=
 =?us-ascii?Q?IUlUWeHsCKpb7PyvYxVuZ4lxx472ArkB72TojyGJ3pTl8kK2InFK34w+1CaL?=
 =?us-ascii?Q?zhYJyf6+8LKrwxKWSiQjSCkZwA4hYXMvurqSQ2J8uBokvtPYWLhwNd/7E+h6?=
 =?us-ascii?Q?q/5xUCmUMGWdgTOZwJEBcRZYqg4b+MDLJ5jI2dODLtqCYnwaIe0HmlACmQTB?=
 =?us-ascii?Q?RqXYyoPUFFtrPDP9V2UoaTuRGJ+d5DewbVhxP/KPs7Nj1PhBHm32nh2LhIzU?=
 =?us-ascii?Q?mguDQvtiQFDRNm5Fqci8IsjVBXhiqSNjyyQnRtv3aoZ8/RjRr6zm6apUJO+1?=
 =?us-ascii?Q?OM9Tn8oxJxbwuulWVSggpHcMQyW5IKnubMNLYD0KBpFKNx9FmYKYhYcF3nRU?=
 =?us-ascii?Q?OezG2otmJuImdVwbqodVbVSkAxaHmxJKyAJpZwGkaa5FbYMUBYhm/VXv6+bJ?=
 =?us-ascii?Q?/TBejI3XwtHcQC8sDWLtXRWADgAucvljW1vxtsXO8/J1VAiRXYq4dbL3c8p2?=
 =?us-ascii?Q?JDowjun+1MnR6pb003JbtKi+sqSZ4uyGJYYBTYXUnLOATXVFoe/zVyzYnKqQ?=
 =?us-ascii?Q?nlsNLftbfx6sThG6h4VgVfvYU6kDPpzSn3NAmcNkQR8y0+l7904hTJLcygu5?=
 =?us-ascii?Q?QFOc3a/wLHIHXQJzXVMbplcuqJFVlTLOXVLftgZXVnvp2m0JRjkdpTqi3gBG?=
 =?us-ascii?Q?IeW4b7DkqAPNLOz9Z7sruagGRTtQLpsswJNvRi5yhRu4oaQAiR5enwBziNly?=
 =?us-ascii?Q?SBhcuRLTtuGzzf1oFNE0RiykRi7OuDq1IpRWwMHnwZ4tqLyoUYHiG03gIiB2?=
 =?us-ascii?Q?XKHEVPkbE2vKXmvAsXcc8sOEAjAIcox4MXJUVkCcoaJ/eWSvTV8lK/kNwq/P?=
 =?us-ascii?Q?er+7wSkJnS6yjbvGUuMZYdDQqsLu4Qdh66omlBWhQubTJwb4r/ZbVjA6fSJw?=
 =?us-ascii?Q?Z6SjlZIRQhYkCTaH+3DhtxMjSvOo38HesZXxmJgNvnyFOKkWaVkHkEuGiogf?=
 =?us-ascii?Q?JMWqnZqK97T87Hch3Vs73IUpIZxbdXXOZPTkI7Ih?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47f0ff8-5dbc-48b3-71bc-08dbba48d555
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 02:16:58.2161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prZNmFl9VnwaW9rrVZSiAgyqEp1oyC3x3IZqzEwtEoZUaWjBstWu/vKCf6b99Z2w7a5F/eOLl2yPhCrhyQQaVkljWlc195vTeTr7sISXeAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5931
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



>-----Original Message-----
>From: Alex Williamson <alex.williamson@redhat.com>
>Subject: Re: [PATCH v1 06/22] vfio/common: Add a vfio device iterator
>
>On Wed, 30 Aug 2023 18:37:38 +0800
>Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:
>
>> With a vfio device iterator added, we can make some migration and reset
>> related functions group agnostic.
>> E.x:
>> vfio_mig_active
>> vfio_migratable_device_num
>> vfio_devices_all_dirty_tracking
>> vfio_devices_all_device_dirty_tracking
>> vfio_devices_all_running_and_mig_active
>> vfio_devices_dma_logging_stop
>> vfio_devices_dma_logging_start
>> vfio_devices_query_dirty_bitmap
>> vfio_reset_handler
>>
>> Or else we need to add container specific callback variants for above
>> functions just because they iterate devices based on group.
>>
>> Move the reset handler registration/unregistration to a place that is no=
t
>> group specific, saying first vfio address space created instead of the
>> first group.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/vfio/common.c | 224 ++++++++++++++++++++++++++---------------------
>>  1 file changed, 122 insertions(+), 102 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 949ad6714a..51c6e7598e 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -84,6 +84,26 @@ static int vfio_ram_block_discard_disable(VFIOContain=
er
>*container, bool state)
>>      }
>>  }
>>
>> +static VFIODevice *vfio_container_dev_iter_next(VFIOContainer *containe=
r,
>> +                                                VFIODevice *curr)
>> +{
>> +    VFIOGroup *group;
>> +
>> +    if (!curr) {
>> +        group =3D QLIST_FIRST(&container->group_list);
>> +    } else {
>> +        if (curr->next.le_next) {
>> +            return curr->next.le_next;
>> +        }
>
>
>VFIODevice *device =3D QLIST_NEXT(curr, next);
>
>if (device) {
>    return device;
>}
>
>> +        group =3D curr->group->container_next.le_next;
>
>
>group =3D QLIST_NEXT(curr->group, container_next);
>
>> +    }
>> +
>> +    if (!group) {
>> +        return NULL;
>> +    }
>> +    return QLIST_FIRST(&group->device_list);
>> +}
>> +
>>  /*
>>   * Device state interfaces
>>   */
>> @@ -112,17 +132,22 @@ static int vfio_get_dirty_bitmap(VFIOContainer
>*container, uint64_t iova,
>>
>>  bool vfio_mig_active(void)
>>  {
>> -    VFIOGroup *group;
>> +    VFIOAddressSpace *space;
>> +    VFIOContainer *container;
>>      VFIODevice *vbasedev;
>>
>> -    if (QLIST_EMPTY(&vfio_group_list)) {
>> +    if (QLIST_EMPTY(&vfio_address_spaces)) {
>>          return false;
>>      }
>>
>> -    QLIST_FOREACH(group, &vfio_group_list, next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            if (vbasedev->migration_blocker) {
>> -                return false;
>> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>> +        QLIST_FOREACH(container, &space->containers, next) {
>> +            vbasedev =3D NULL;
>> +            while ((vbasedev =3D vfio_container_dev_iter_next(container=
,
>> +                                                            vbasedev)))=
 {
>> +                if (vbasedev->migration_blocker) {
>> +                    return false;
>> +                }
>
>Appears easy to avoid setting vbasedev in the loop iterator and
>improving the scope of vbasedev:
>
>VFIODevice *vbasedev =3D vfio_container_dev_iter_next(container, NULL);
>
>while (vbasedev) {
>    if (vbasedev->migration_blocker) {
>        return false;
>    }
>
>    vbasedev =3D vfio_container_dev_iter_next(container, vbasedev);
>}
>
>>              }
>>          }
>>      }
>> @@ -133,14 +158,19 @@ static Error *multiple_devices_migration_blocker;
>>
>>  static unsigned int vfio_migratable_device_num(void)
>>  {
>> -    VFIOGroup *group;
>> +    VFIOAddressSpace *space;
>> +    VFIOContainer *container;
>>      VFIODevice *vbasedev;
>>      unsigned int device_num =3D 0;
>>
>> -    QLIST_FOREACH(group, &vfio_group_list, next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            if (vbasedev->migration) {
>> -                device_num++;
>> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>> +        QLIST_FOREACH(container, &space->containers, next) {
>> +            vbasedev =3D NULL;
>> +            while ((vbasedev =3D vfio_container_dev_iter_next(container=
,
>> +                                                            vbasedev)))=
 {
>> +                if (vbasedev->migration) {
>> +                    device_num++;
>> +                }
>
>Same as above.
>
>>              }
>>          }
>>      }
>> @@ -207,8 +237,7 @@ static void vfio_set_migration_error(int err)
>>
>>  static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>>  {
>> -    VFIOGroup *group;
>> -    VFIODevice *vbasedev;
>> +    VFIODevice *vbasedev =3D NULL;
>>      MigrationState *ms =3D migrate_get_current();
>>
>>      if (ms->state !=3D MIGRATION_STATUS_ACTIVE &&
>> @@ -216,19 +245,17 @@ static bool
>vfio_devices_all_dirty_tracking(VFIOContainer *container)
>>          return false;
>>      }
>>
>> -    QLIST_FOREACH(group, &container->group_list, container_next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            VFIOMigration *migration =3D vbasedev->migration;
>> +    while ((vbasedev =3D vfio_container_dev_iter_next(container, vbased=
ev))) {
>> +        VFIOMigration *migration =3D vbasedev->migration;
>
>Similar, and all the other loops below.
>
>>
>> -            if (!migration) {
>> -                return false;
>> -            }
>> +        if (!migration) {
>> +            return false;
>> +        }
>>
>> -            if (vbasedev->pre_copy_dirty_page_tracking =3D=3D ON_OFF_AU=
TO_OFF &&
>> -                (migration->device_state =3D=3D VFIO_DEVICE_STATE_RUNNI=
NG ||
>> -                 migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE_C=
OPY)) {
>> -                return false;
>> -            }
>> +        if (vbasedev->pre_copy_dirty_page_tracking =3D=3D ON_OFF_AUTO_O=
FF &&
>> +            (migration->device_state =3D=3D VFIO_DEVICE_STATE_RUNNING |=
|
>> +             migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE_COPY)=
) {
>> +            return false;
>>          }
>>      }
>>      return true;
>> @@ -236,14 +263,11 @@ static bool
>vfio_devices_all_dirty_tracking(VFIOContainer *container)
>>
>>  static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *conta=
iner)
>>  {
>> -    VFIOGroup *group;
>> -    VFIODevice *vbasedev;
>> +    VFIODevice *vbasedev =3D NULL;
>>
>> -    QLIST_FOREACH(group, &container->group_list, container_next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            if (!vbasedev->dirty_pages_supported) {
>> -                return false;
>> -            }
>> +    while ((vbasedev =3D vfio_container_dev_iter_next(container, vbased=
ev))) {
>> +        if (!vbasedev->dirty_pages_supported) {
>> +            return false;
>>          }
>>      }
>>
>> @@ -256,27 +280,24 @@ static bool
>vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
>>   */
>>  static bool vfio_devices_all_running_and_mig_active(VFIOContainer
>*container)
>>  {
>> -    VFIOGroup *group;
>> -    VFIODevice *vbasedev;
>> +    VFIODevice *vbasedev =3D NULL;
>>
>>      if (!migration_is_active(migrate_get_current())) {
>>          return false;
>>      }
>>
>> -    QLIST_FOREACH(group, &container->group_list, container_next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            VFIOMigration *migration =3D vbasedev->migration;
>> +    while ((vbasedev =3D vfio_container_dev_iter_next(container, vbased=
ev))) {
>> +        VFIOMigration *migration =3D vbasedev->migration;
>>
>> -            if (!migration) {
>> -                return false;
>> -            }
>> +        if (!migration) {
>> +            return false;
>> +        }
>>
>> -            if (migration->device_state =3D=3D VFIO_DEVICE_STATE_RUNNIN=
G ||
>> -                migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE_CO=
PY) {
>> -                continue;
>> -            } else {
>> -                return false;
>> -            }
>> +        if (migration->device_state =3D=3D VFIO_DEVICE_STATE_RUNNING ||
>> +            migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE_COPY) =
{
>> +            continue;
>> +        } else {
>> +            return false;
>>          }
>>      }
>>      return true;
>> @@ -1243,25 +1264,22 @@ static void
>vfio_devices_dma_logging_stop(VFIOContainer *container)
>>      uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>>                                sizeof(uint64_t))] =3D {};
>>      struct vfio_device_feature *feature =3D (struct vfio_device_feature=
 *)buf;
>> -    VFIODevice *vbasedev;
>> -    VFIOGroup *group;
>> +    VFIODevice *vbasedev =3D NULL;
>>
>>      feature->argsz =3D sizeof(buf);
>>      feature->flags =3D VFIO_DEVICE_FEATURE_SET |
>>                       VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
>>
>> -    QLIST_FOREACH(group, &container->group_list, container_next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            if (!vbasedev->dirty_tracking) {
>> -                continue;
>> -            }
>> +    while ((vbasedev =3D vfio_container_dev_iter_next(container, vbased=
ev))) {
>> +        if (!vbasedev->dirty_tracking) {
>> +            continue;
>> +        }
>>
>> -            if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>> -                warn_report("%s: Failed to stop DMA logging, err %d (%s=
)",
>> -                             vbasedev->name, -errno, strerror(errno));
>> -            }
>> -            vbasedev->dirty_tracking =3D false;
>> +        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>> +            warn_report("%s: Failed to stop DMA logging, err %d (%s)",
>> +                        vbasedev->name, -errno, strerror(errno));
>>          }
>> +        vbasedev->dirty_tracking =3D false;
>>      }
>>  }
>>
>> @@ -1336,8 +1354,7 @@ static int
>vfio_devices_dma_logging_start(VFIOContainer *container)
>>  {
>>      struct vfio_device_feature *feature;
>>      VFIODirtyRanges ranges;
>> -    VFIODevice *vbasedev;
>> -    VFIOGroup *group;
>> +    VFIODevice *vbasedev =3D NULL;
>>      int ret =3D 0;
>>
>>      vfio_dirty_tracking_init(container, &ranges);
>> @@ -1347,21 +1364,19 @@ static int
>vfio_devices_dma_logging_start(VFIOContainer *container)
>>          return -errno;
>>      }
>>
>> -    QLIST_FOREACH(group, &container->group_list, container_next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            if (vbasedev->dirty_tracking) {
>> -                continue;
>> -            }
>> +    while ((vbasedev =3D vfio_container_dev_iter_next(container, vbased=
ev))) {
>> +        if (vbasedev->dirty_tracking) {
>> +            continue;
>> +        }
>>
>> -            ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>> -            if (ret) {
>> -                ret =3D -errno;
>> -                error_report("%s: Failed to start DMA logging, err %d (=
%s)",
>> -                             vbasedev->name, ret, strerror(errno));
>> -                goto out;
>> -            }
>> -            vbasedev->dirty_tracking =3D true;
>> +        ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>> +        if (ret) {
>> +            ret =3D -errno;
>> +            error_report("%s: Failed to start DMA logging, err %d (%s)"=
,
>> +                         vbasedev->name, ret, strerror(errno));
>> +            goto out;
>>          }
>> +        vbasedev->dirty_tracking =3D true;
>>      }
>>
>>  out:
>> @@ -1440,22 +1455,19 @@ static int
>vfio_devices_query_dirty_bitmap(VFIOContainer *container,
>>                                             VFIOBitmap *vbmap, hwaddr io=
va,
>>                                             hwaddr size)
>>  {
>> -    VFIODevice *vbasedev;
>> -    VFIOGroup *group;
>> +    VFIODevice *vbasedev =3D NULL;
>>      int ret;
>>
>> -    QLIST_FOREACH(group, &container->group_list, container_next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            ret =3D vfio_device_dma_logging_report(vbasedev, iova, size=
,
>> -                                                 vbmap->bitmap);
>> -            if (ret) {
>> -                error_report("%s: Failed to get DMA logging report, iov=
a: "
>> -                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRI=
x
>> -                             ", err: %d (%s)",
>> -                             vbasedev->name, iova, size, ret, strerror(=
-ret));
>> +    while ((vbasedev =3D vfio_container_dev_iter_next(container, vbased=
ev))) {
>> +        ret =3D vfio_device_dma_logging_report(vbasedev, iova, size,
>> +                                             vbmap->bitmap);
>> +        if (ret) {
>> +            error_report("%s: Failed to get DMA logging report, iova: "
>> +                         "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
>> +                         ", err: %d (%s)",
>> +                         vbasedev->name, iova, size, ret, strerror(-ret=
));
>>
>> -                return ret;
>> -            }
>> +            return ret;
>>          }
>>      }
>>
>> @@ -1739,21 +1751,30 @@ bool vfio_get_info_dma_avail(struct
>vfio_iommu_type1_info *info,
>>
>>  void vfio_reset_handler(void *opaque)
>>  {
>> -    VFIOGroup *group;
>> +    VFIOAddressSpace *space;
>> +    VFIOContainer *container;
>>      VFIODevice *vbasedev;
>>
>> -    QLIST_FOREACH(group, &vfio_group_list, next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            if (vbasedev->dev->realized) {
>> -                vbasedev->ops->vfio_compute_needs_reset(vbasedev);
>> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>> +        QLIST_FOREACH(container, &space->containers, next) {
>> +            vbasedev =3D NULL;
>> +            while ((vbasedev =3D vfio_container_dev_iter_next(container=
,
>> +                                                            vbasedev)))=
 {
>> +                if (vbasedev->dev->realized) {
>> +                    vbasedev->ops->vfio_compute_needs_reset(vbasedev);
>> +                }
>>              }
>>          }
>>      }
>>
>> -    QLIST_FOREACH(group, &vfio_group_list, next) {
>> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -            if (vbasedev->dev->realized && vbasedev->needs_reset) {
>> -                vbasedev->ops->vfio_hot_reset_multi(vbasedev);
>> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>> +        QLIST_FOREACH(container, &space->containers, next) {
>> +            vbasedev =3D NULL;
>> +            while ((vbasedev =3D vfio_container_dev_iter_next(container=
,
>> +                                                            vbasedev)))=
 {
>> +                if (vbasedev->dev->realized && vbasedev->needs_reset) {
>> +                    vbasedev->ops->vfio_hot_reset_multi(vbasedev);
>> +                    }
>>              }
>>          }
>>      }
>> @@ -1841,6 +1862,10 @@ static VFIOAddressSpace
>*vfio_get_address_space(AddressSpace *as)
>>      space->as =3D as;
>>      QLIST_INIT(&space->containers);
>>
>> +    if (QLIST_EMPTY(&vfio_address_spaces)) {
>> +        qemu_register_reset(vfio_reset_handler, NULL);
>> +    }
>> +
>
>We could just have a vfio_device_list to avoid iterating either
>containers and group or address spaces.  Thanks,

Good idea! Will do.
A vfio_device_list can be used by both BEs and I can have this
patch dropped.

Thanks
Zhenzhong

