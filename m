Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F59F80EE30
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 14:58:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD3Fr-0006pA-KN; Tue, 12 Dec 2023 08:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rD3Fp-0006ox-AG
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 08:56:57 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rD3Fn-0000FD-Bi
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 08:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702389415; x=1733925415;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hExJO6XFVf2thKrGOpZEs1KBXbhovsfmruHg+sf7uH4=;
 b=HqZlmCvRJNq+jtVvCQ1p62rxRVVIam5OXYBGkYi5roh7Cz+RK88e7Nf4
 b3kEX0sD75FQlyc1bJ/nyDTR1buW/9n1XwXCdzByNVvaH6fP7XqyW32d0
 S/1XOp7bn+wC7GlvxC764OXPYDn2vKHyCOMbxU0UorcKfoQwCxZ8869Et
 2/+ebgGXvEOO6wz/DLAAvrO3RmqgUFWAxCNh/PKO5vSem73H5+ZjdB8fU
 qsMUl6KJQ/sjXld48NNQYi0snCJvQ2sxMqNRzhAbcJhvHiFDpH/OHl0+x
 WnvrNl+ejQQEPKkwMHwcq7kwDgRVtetsa77WtsByfN92RTxRSS4RWBAr5 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="398652073"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; d="scan'208";a="398652073"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2023 05:56:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="807776344"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; d="scan'208";a="807776344"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Dec 2023 05:56:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 05:56:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 05:56:47 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 05:56:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKqvf0Ggt5otlwLyqQEqLEJHNo76I927Z6nQV10yXkDn/v2nN8+nRAdTq2OCQQ8i9Me4OWIe71h3IF0kdjZxa5hwCnwWBbp1iJO0kkoszdbu3nx32pKBBz2csLI0XchR6KSHmMTVUSggjGJdTzOyk/TVyvJ5SLq/O0AtCEEfaSojYlbQuKp4IbqkSvsbdymLtb7w9D7xuEydT+n0uvSHy1SKld6dnbH4h0kdpjd6qh5LMwM3Q2SCAfotyOJwHm1uLue45HNAsNkpJHQI7t3CMv1pWVRjD1o9+LtrWnSiQTJGuZfIQ+OzMmw5Gn7mYB9o50gD9viaS+lep+ef+gqasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRPPZWkLa2vlwdjBFuzYNkow5hJ0wKexRSoEtcPErAA=;
 b=JqG0rQ/Ix9cQ68TOyF5GpYJ/07todIcreD9s8DCpGVq5rGxhryI3b/qhzA1xWWOlAtS5CF7io6Z9uMhZnGGmN+8hF2y6sWUO423v9HJMChhBDRvM6KCCTfYdBDrdYqr5bGsUqdcb4LfBaOd8adHw0Dd5LmVRC9wTEEIU/YTY2HHebRtKmdTJKSPkr/kWtE9R8RUm/yVnCCW8On9EIcM24t8jC/NTx6MS2EUtxjVZOjufX7tKHNSbGuDgMn4xP0iEIDymFeJgUXZFgaIXQoTxmuULxqsIiDoH92SG15t2wWbhA7loqCkfOwXhxrrb3qmds3mPt/Cb35b9RIziRqJkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 13:56:43 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::6a55:3e93:ac5f:7b6d]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::6a55:3e93:ac5f:7b6d%4]) with mapi id 15.20.7046.027; Tue, 12 Dec 2023
 13:56:42 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Cornelia Huck
 <cohuck@redhat.com>, =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, Michael Roth
 <michael.roth@amd.com>, Sean Christopherson <seanjc@google.com>, "Claudio
 Fontana" <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, "Isaku
 Yamahata" <isaku.yamahata@gmail.com>, "Qiang, Chenyi"
 <chenyi.qiang@intel.com>
Subject: RE: [PATCH v3 06/70] kvm: Introduce support for memory_attributes
Thread-Topic: [PATCH v3 06/70] kvm: Introduce support for memory_attributes
Thread-Index: AQHaF5O24VxNhOyFz0ifdu/xEp7Ej7Cl0dCg
Date: Tue, 12 Dec 2023 13:56:42 +0000
Message-ID: <DS0PR11MB6373D69ABBF4BDF7120438ACDC8EA@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-7-xiaoyao.li@intel.com>
In-Reply-To: <20231115071519.2864957-7-xiaoyao.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|IA1PR11MB6170:EE_
x-ms-office365-filtering-correlation-id: 5968bd74-435f-4ee0-fddc-08dbfb1a2bf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lHezIFsiZacSbQ68ctnoIAlKuFKi8owdEfG6xLgN1x8H8MvGAiL6LXAHwTD+lQfmC0xxrR39ndys79oZ9JWnTe789hB/gLkgAV3NM8pE/+6+gLyzDE+rEDy99dxvrd2ptY70dsex3l30Dw6OxvxxSM1laBRUMS9/OfmTvVk0yCXQQqolFJL2OWv5jx7ktYf5UCkdnHj+8pvUEFV+Jbwu5lTgXpzxoyNzWQL3YzB+jbWAfAxj8lN4zVl6vE/+4iHnEX2qOS//ZgqDsYTQlO0uCdOZ5mYY3NjU1QaUvczAhprTBxFe087zEqW+8XoZGrkqRsgR0eFrTcSuWB3utUN98GobQOkY1fpm/AC9aDMVIk0Vz3Zz0xR02WlXFBTxcSsUWfMmP1tFJFvVPbQAXDSL80x13V1YQRJL2hoGfWw66Jvjt/Tqf40G0h/RO2g9jPmNdRnjTJd3UySW1sO14szvRLA1HyLvzEwmd17Qt54hHK89+1PIVhjo3OZWVRTOCuFpXg/ehjVs0Dhjd8CfCT7SySMtCmUJMTBVg/sxxzfzH13QXk5FnoUGAswD83dZLhN4lGxnCuz2rSMizCxYMSDNk/pdn45Zb741i5aHiXJrd806hPMNhmDhXWoyHBoi98f4M7pLYF4CifTkcmGUXXe9ag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(71200400001)(9686003)(107886003)(7696005)(6506007)(478600001)(53546011)(26005)(66476007)(7416002)(66946007)(76116006)(2906002)(41300700001)(5660300002)(110136005)(66446008)(8676002)(316002)(54906003)(4326008)(8936002)(52536014)(64756008)(38070700009)(66556008)(122000001)(38100700002)(82960400001)(921008)(86362001)(33656002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Aahcge/Xwo3i/l0iHKQedqNpR4fXM1KAvdfjehRtufG53pwVrjGLZ5GOLT?=
 =?iso-8859-1?Q?U0EKPQHHMdeX/jw13cNP3VHsnDYz9Czbs9ULC+WwIKQtoZKgQq+T5QB3Ce?=
 =?iso-8859-1?Q?6sqbOUtKgGdu7qCm1poq538cpR38USnVFKomOtY1iFhv6QF19YwLZU0Y9T?=
 =?iso-8859-1?Q?g/VpgyzZW6QXxw08bikPqrf/TK8CwX+uvKqNElO3ctifpsufTr4e0b2J9r?=
 =?iso-8859-1?Q?PTXpNmdtNblCrdYd5dFeEgqfW/bZVVqFGwCZbn7WapJXxn821ZkCnU3tuh?=
 =?iso-8859-1?Q?TJzWvZtOHYqwKKlGb/y8orXd25BK7Yhz1qeyhjY51HEJE4b4QYsvSt+xSH?=
 =?iso-8859-1?Q?pX22DPhWqo+/raUnGVIK64yjQqcr1vAYXnJ+BQrF3DazXaG6VqX3ocME/F?=
 =?iso-8859-1?Q?fQRY8bfw/7YdOiXHtxUzGkDM/TAsG1FyY6Nvc3TY/ZYOqKv9vL3316U0x/?=
 =?iso-8859-1?Q?B0LBrl5zKtukvPem0VLTcNgzZkEdIsxhKVT7s0TGBJ4t7YL1J2plY/4CTM?=
 =?iso-8859-1?Q?Zpo3iMLqI1VeamKMsyWxdydbQoYEPzopsi2iaStwA9gmRroyZlKuyHl8Ty?=
 =?iso-8859-1?Q?zuNRETBZIUs5726eZNalNSZtAitby7BPxpV71fTLTc2OyL3ErDhJBedI4Q?=
 =?iso-8859-1?Q?6zrFQjTJ07FR25R+rRDrGZir06SxDoOtBYV8XydwdkmddiiajYrEF0W6oo?=
 =?iso-8859-1?Q?+X4I6DUGdxgN5lNGS5nzRUN0Ig3Nait+6RgxvEEayC7Wd0Y5ITQoI9TCkP?=
 =?iso-8859-1?Q?VQquVSrzNDMP97DNRyCf5ez1RtJaQf+vxekQjOORocrHgQfTLe5mSy3RDS?=
 =?iso-8859-1?Q?X2CJgcJ0utfv9cEisdqLSmmINdy3cUefJCYXXXyUYrVjY9BmO5Pc85DHdJ?=
 =?iso-8859-1?Q?83+wtzCW5meGHOeSUDGYyr/dwEWMDbi+ldhqrDdYiT/2UReDuq/V4fy79X?=
 =?iso-8859-1?Q?Ta0CLD17eqi5dt3xIYr6aJW5/s1bi4404AFlil3eraYwWQlLthV/4y8P9Q?=
 =?iso-8859-1?Q?pHEX80NcdBaYAh2ezfgIMlBIpjbmoodB3A96ZijKRyF1/wQzEysWaF90ZT?=
 =?iso-8859-1?Q?GDlbogtKR+21GRADYVlKUBXkbeYZcMbG1zi7vk5BZ89JQ+oUwCwTTuuU6M?=
 =?iso-8859-1?Q?YLajsaMafZovu5AyeHhvZ/XUwJIN+xBJlwnk04kOPsloBOJfH00BhIMxR/?=
 =?iso-8859-1?Q?SiXmm/o2bXNn1lr3jDkgt5qi56ggLCl8PHpJ8H9sHW5UJY2HIgpCVScnEi?=
 =?iso-8859-1?Q?e5NElQvaqQJAWHwf6Pb/iKbdg6kEGAJQDnLe8Xr81dnxMcj9NgEaAculq/?=
 =?iso-8859-1?Q?xoYFTNmpzNI3odWU8/RL82SW5Ib4FWR34xKeiXxjEBEnka6Xce+NA3UV2s?=
 =?iso-8859-1?Q?0RoTr8Vwl8VogZIH6QpQNLG3OlHPDxaQqQprhyR9Rf7TzFxUsnuRDbMSst?=
 =?iso-8859-1?Q?ncsJMEb8cghdDAfSvx88z+zBNfVPjqPJu9AeBSek/pmATPCtHrBQv7fSfN?=
 =?iso-8859-1?Q?P7CDmTjQuDyhKvdhtyRFGr0OUlZYaYcOH0UPbF99V1z8/B3cGMQWqI038I?=
 =?iso-8859-1?Q?5RAc2ly6S3jM5v8Cp9Oox13plGhKwI7qi+JP/nd08vprAPG4A+3fJzQj/5?=
 =?iso-8859-1?Q?lckOhjkqB2clY95iPDGV8EPbgJfZwjva4O?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5968bd74-435f-4ee0-fddc-08dbfb1a2bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 13:56:42.6145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2/ngAmHs0ZrxMrdSX3QYyWEANg51IqWsSVnIE0sWEz2ZRVR7cSCJJce6cegC7KiIS/BPa/xmGAiINeAxgRlKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6170
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wednesday, November 15, 2023 3:14 PM, Xiaoyao Li wrote:
> Introduce the helper functions to set the attributes of a range of memory=
 to
> private or shared.
>=20
> This is necessary to notify KVM the private/shared attribute of each gpa =
range.
> KVM needs the information to decide the GPA needs to be mapped at hva-
> based shared memory or guest_memfd based private memory.
>=20
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  accel/kvm/kvm-all.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>  include/sysemu/kvm.h |  3 +++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
> 69afeb47c9c0..76e2404d54d2 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -102,6 +102,7 @@ bool kvm_has_guest_debug;  static int kvm_sstep_flags=
;
> static bool kvm_immediate_exit;  static bool kvm_guest_memfd_supported;
> +static uint64_t kvm_supported_memory_attributes;
>  static hwaddr kvm_max_slot_size =3D ~0;
>=20
>  static const KVMCapabilityInfo kvm_required_capabilites[] =3D { @@ -1305=
,6
> +1306,44 @@ void kvm_set_max_memslot_size(hwaddr max_slot_size)
>      kvm_max_slot_size =3D max_slot_size;
>  }
>=20
> +static int kvm_set_memory_attributes(hwaddr start, hwaddr size,
> +uint64_t attr) {
> +    struct kvm_memory_attributes attrs;
> +    int r;
> +
> +    attrs.attributes =3D attr;
> +    attrs.address =3D start;
> +    attrs.size =3D size;
> +    attrs.flags =3D 0;
> +
> +    r =3D kvm_vm_ioctl(kvm_state, KVM_SET_MEMORY_ATTRIBUTES, &attrs);
> +    if (r) {
> +        warn_report("%s: failed to set memory (0x%lx+%#zx) with attr 0x%=
lx
> error '%s'",
> +                     __func__, start, size, attr, strerror(errno));
> +    }
> +    return r;
> +}
> +
> +int kvm_set_memory_attributes_private(hwaddr start, hwaddr size) {
> +    if (!(kvm_supported_memory_attributes &
> KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +        error_report("KVM doesn't support PRIVATE memory attribute\n");
> +        return -EINVAL;
> +    }
> +
> +    return kvm_set_memory_attributes(start, size,
> +KVM_MEMORY_ATTRIBUTE_PRIVATE); }
> +
> +int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size) {
> +    if (!(kvm_supported_memory_attributes &
> KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +        error_report("KVM doesn't support PRIVATE memory attribute\n");
> +        return -EINVAL;
> +    }

Duplicate code in kvm_set_memory_attributes_shared/private.
Why not move the check into kvm_set_memory_attributes?

