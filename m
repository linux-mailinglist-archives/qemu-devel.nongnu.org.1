Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C337C7091
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:45:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwuX-0000Hy-A8; Thu, 12 Oct 2023 10:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qqwuU-0000HD-Ku
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:43:34 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qqwuS-0006dE-7b
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697121812; x=1728657812;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Djl+uEPx5BxRvuQX4Hc3QAa7hxv6hSnJTWH+BmfffXg=;
 b=hHePJUjqEfzb0DezRzTWOl54mB4/BH6zE9/DqCJNcfE5UzrLADo/LdC8
 GCnRjLN49c88G3H38SRffHTLcJ8xhdSWJd8xDaZ8BTmWGCJTXjC2zPAs8
 BPTD78ygZLRI7CZKr/Ao1LvkL49z0vEC1VYRBQPJRh+xFK8sTV7pU0KGV
 oyiUg3y3NG6qJhR+czgr91gGThfxAzoB8p5j/yaUOQbhHsP26aVYfQSvn
 0+epPWHlyTL0jAXML3x6KHCXLQmJ3HhwQ0TS8Vle2yGNiLmdHAnb2dCvM
 xqNyh6eV6sc/nSQDMub574y58fQm+/nHzv2YW6hCcg5pCNV5R7KM882m4 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="382171302"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; d="scan'208";a="382171302"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 07:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870604214"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; d="scan'208";a="870604214"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Oct 2023 07:43:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 07:43:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 07:43:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 07:43:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 07:43:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAxhiWxZLTi5WUjNh+DggW+R6v8QqQrzXe9KLYtVSLWIGO+3KL0wa+oPUHxVN1Yxgv9o3CmXby0/a1IB3AcatiVG90AvW93YvXrkxT63nGJpZ6X8Ie9aWDy30el5FIV5kFt8OHIgqq3I4p96zYMa+9/uPLoa7+z1VhtM6ez894bA2lX7+2JKyPWy2sVvFlWMPwycUC3gqgoxqdg1MjgDSa9nJAP0vcDPh7QkvGnf2D5nAcLq982oui2YHOkV77iDckjd4dgPpAqbmjZQQ4sotM+oqSUNRev4HhIPbFL/wLgxq/6iswQdDJOdrWprhUVzW/5MzTZjzZzxnNkIiy7CKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Djl+uEPx5BxRvuQX4Hc3QAa7hxv6hSnJTWH+BmfffXg=;
 b=oPcRNTsgHKsMgJzAjtIoFNqecgWj1nEDiZoeXhSD0t/JWUA/bcueNXaECoRmSmJ8ty+pMfzbh1M5gKfQjus/MmKx0h7r1iEzWfiW14SQIyhywwZPrucDLlcRF/oVXYMmPISLdkfkZp2y/edhHVJybY5IgMIK1NCOTJ1MRUqFCQMDkdgafL9RbDho+5b9xrgDnGc1cztDI7SPZQofcto3ZBEnyUIt8Go96dT/O1spFCwGJfM658sEpcaZjwQ2HOADyVh3Q5cUoSVbDF5NLybD6+peG9NkI941NoRgqF8UpISxZ9JhBDxHTTuJYLKEo/eTufGaz3wmjrgWmkfztAWBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 MW6PR11MB8366.namprd11.prod.outlook.com (2603:10b6:303:24c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Thu, 12 Oct 2023 14:43:25 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::6a55:3e93:ac5f:7b6d]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::6a55:3e93:ac5f:7b6d%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 14:43:25 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "quintela@redhat.com" <quintela@redhat.com>
CC: "peterx@redhat.com" <peterx@redhat.com>, "isaku.yamahata@gmail.com"
 <isaku.yamahata@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] migration: refactor migration_completion
Thread-Topic: [PATCH v2] migration: refactor migration_completion
Thread-Index: AQHZxrZrzbuQ2/SdmUaa0xzmirIuk7BE8xyqgAGzHhA=
Date: Thu, 12 Oct 2023 14:43:25 +0000
Message-ID: <DS0PR11MB6373C97B837C3640F9D4A732DCD3A@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230804093053.5037-1-wei.w.wang@intel.com>
 <87v8bdbac2.fsf@secure.mitica>
In-Reply-To: <87v8bdbac2.fsf@secure.mitica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|MW6PR11MB8366:EE_
x-ms-office365-filtering-correlation-id: 2735f276-d597-499a-92b8-08dbcb319764
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /9VrE2ihAGc8q3NcGQFYOjaRVVchGEm/I5dcMOQVPxxlpArPnh6w8C97ixyAa8rUi5hY3WD9rnuPwHqmy+ytk+sfem8BklUWE980M+lxWx2xMe4EahqePJOzyJbY8jUulQ5nm/qEqtqeH8SvjkFyMXRb8UPbBINGvWPLORgosot8akLGwiZhd/ZwEglaoc+Wy/I/3Bb2HmYfvylC++1Meizq53LtXeleDaN3e6qTbDEAPzwEH7/8t55klEs9/OY79EdI1C0VwF5J6SuBvu5vm7N7m/nyvaKCLZPt0cT4kFTts1awPUleAFi4ZzU/cEqCvOKgIcluU+QWD6D8txUn4jDqKksZIpSIwwQmGilZQp4kH/s+hqI9WjqBI68aUl27Rm7eXoAM1LqnggBGZr5LqLMVKZMSkLPdMxJHc6jKOg4W7Fikt9ItKfhr6qFBbTSBXjMdQwGiTKmRRmBFGyQLlztX+3BaOn25Xbh8WGxUyhcVgyHLUnqQh8oZDPp2Sc6AyCsEuxnInNp/iPyd1EFqij5Tj0wSrY78gyKZD7C0YszZ2i2RZF1bTEGsnCz95WEIoGJwZ1xmpD6f56Qw3o9XrQXRi4N7BK4SicP8VJSo0bBYF7KRFwutOmDoXeUy9F74
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(7696005)(6506007)(53546011)(52536014)(5660300002)(71200400001)(26005)(2906002)(4744005)(86362001)(83380400001)(33656002)(38100700002)(82960400001)(122000001)(38070700005)(9686003)(76116006)(66556008)(66946007)(66476007)(64756008)(66446008)(54906003)(41300700001)(316002)(6916009)(478600001)(4326008)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ESmGr0IWiAS+LbqGVYAtpwAlTPGSLiMw5qT4rYMjIJVkmVLyJa2bkmeDPLvr?=
 =?us-ascii?Q?iQLHmkvgs5W0gW3F2SMCYZr0BHuXIw79mRbCMoG4Z3woQnXBwjkTPnxmHXUU?=
 =?us-ascii?Q?HTA4PL5hRE6VL7xJnmxp1j0EcKnRYS2dbKLBC/bNPFI9kk1jDMEYuPZ0o38j?=
 =?us-ascii?Q?iVs7Ud1TlmJP7lgE+JgnCie7f0pMumXStq0crg3L/NPSLTFY5MQqYD7kUnpB?=
 =?us-ascii?Q?+DJOSRX+6ivpQ63uh8ZZF60SCrFIBu9E4imMkNatt8Iblvzh6IqNmFU9bbkx?=
 =?us-ascii?Q?eFV9+0ykmiYlfnNrr9AFpy3sV1DBtO6KdU5WpyzHBdiUAknoP8X9bVLuCO4v?=
 =?us-ascii?Q?aA1mVxw4Ak+pTkkM4Ew5AAR/a/zeyV1R5Lpqs8QtruuxlVNeews3rIzpMPlz?=
 =?us-ascii?Q?/sv09UpQDxnOWgh2RuijTH9g2ysrftqpQPChsj9qS00BValBWB6/hVff2u+M?=
 =?us-ascii?Q?32tU4+dtNf5INJWaMJFgQJpiqM7EQIMBK0NY41PLQb8Lolv/nfKGn9YXVhdY?=
 =?us-ascii?Q?3HNAkNdv6K5ivaj59WV5xBsP1hmg/lYs9zVG4joGRltIEeoh6F/6BZYCZqeI?=
 =?us-ascii?Q?97o6qSygHtNJ3M6+jMbplnJLzQdJTXi+Kr89nd1feg6INlUEjaC1knmWjoHq?=
 =?us-ascii?Q?tBF8jptWzZvPqMAJCZtxb7N1HfLd9q9EBQDkUNLDn62TWLWKUhNWTWTQ2XMs?=
 =?us-ascii?Q?1d91rtik8Z7h2SSsWm/17cLP+zroPB6JFYmpCxJNQeYo0b9oy2+CXJeIFGlL?=
 =?us-ascii?Q?mgdql2AUExj2QqKozsij4Lt25W9nVH/k2l4muPUXrC/bWZk8Nbbtvty+6aHe?=
 =?us-ascii?Q?o/S7d6A7vMlDxTb8xiSDeeIVLWohvp1DFoz73k8xsQZydWamKgOVgs/i/Bwy?=
 =?us-ascii?Q?tm9iPSX+GxsEgtmylg5ubKApagrOTiY6DHahEQEvRtwk3lBNMPam74PJm0Wb?=
 =?us-ascii?Q?p0ocQrr0BiKxRUr8fWNStUmOdE9icG0uwrb8vP8GNDVSXZs88bOEdN4SS5tS?=
 =?us-ascii?Q?1f88vLfuyNV1s8gplGRLw8wVabAP5KqI3C0NZiAQy/MppngCB0i1FdpEzVtz?=
 =?us-ascii?Q?hy/qT+XQybcQeT4e7GGdI4M5r4xn4M8rCly5QWnJHzEssIYGH4iGMZIRzuYE?=
 =?us-ascii?Q?2DWjR8i5/TcVDLyZ4MO9DGEoqKQ0fU7r1I/7/FZZy8bzSrzm1X3u/ZDeah1E?=
 =?us-ascii?Q?5ItI+W2fTdArGDoSgnVeCgU9ywNeLrBf+6wf4iBJk9dJW54t/ueM8Nq8GIVw?=
 =?us-ascii?Q?PDDFaaDaD1vobsTyb1Z2bYtWitFGdDtGUiMFHSEx7XTFpAJE+7Py5RR2afKT?=
 =?us-ascii?Q?IDl0dO/VBCVq9wt4Mvo5LgyS4fvbK0yWYnb65lLyBur9q0IdRl0ZGDJ/WQIc?=
 =?us-ascii?Q?W/GHQS4Iwpsl5ozBEqv4Lb2QuXnWeWdCagET31kuB/daakUaaW1b4HQcgiCW?=
 =?us-ascii?Q?K2czrpi7QNq8T9A3s5FHDydEH0Yno5KKf8roL++PHsd9b4LbRinQiGvUI2Ed?=
 =?us-ascii?Q?RCPxFq7zfocF29seznAuzbFBcOFVBoPiqjPXQBubkEgOIHjQYasVqkAjHpYM?=
 =?us-ascii?Q?LDPUrF17gwd1Ke5flIhn+nEuLxkSj0JYtbl2CejN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2735f276-d597-499a-92b8-08dbcb319764
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 14:43:25.6264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLLjcgR6o6taEsOL+aogu9mqC6gPzm9FjzN4ToY6lLfz+M1XA7wFlv1RN3dtlIu/Oc/QVO+UhoqjWqdBG9vtaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8366
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Wednesday, October 11, 2023 8:41 PM, Juan Quintela wrote:
> Wei Wang <wei.w.wang@intel.com> wrote:
> > Current migration_completion function is a bit long. Refactor the long
> > implementation into different subfunctions:
> > - migration_completion_precopy: completion code related to precopy
> > - migration_completion_postcopy: completion code related to postcopy
> > - close_return_path_on_source: rp thread related cleanup on migration
> > completion. It is named to match with open_return_path_on_source.

Btw, just a reminder that the above line related to close_return_path_on_so=
urce
in the commit log needs to be removed as it's not added by the patch after =
solving
the conflicts.

