Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E4979F9EA
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 07:11:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgecV-0003gz-Bd; Thu, 14 Sep 2023 01:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=2621ff136d=lesikigor@meta.com>)
 id 1qgecN-0003gq-L5
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 01:10:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=2621ff136d=lesikigor@meta.com>)
 id 1qgecL-0000kH-ME
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 01:10:19 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38DIRbvk031523
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 22:09:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=JY06g3Tk/Sti+zBsNYLXzyKSePW+lh/KsAJncC0Jpkg=;
 b=AstIcIhTe7YED/VNJYqr+l5unfdL1GRqWplsrQ3kL3tqylyNLzUI5iB/WEPg7ChZPYyL
 cuoHTLqSx+pcFINlbOWHwRlz0MqcCy5stIDRaMBkJjtrs+lksr5GIvyT6gVEdWlo5Z73
 ZI/ELyReNiTTXan8bDjklxAhfQTxHSlkYKVOR0zuZWmNI7W8WpznyygAxmu+j+FvSrZN
 K1OC2nPXvsEldLJMyODMPbnhR2A3P+1p6JCfqzIPZYzrgJvx+J8LMvWlE8cs6vJs1oO6
 ChohEbNtG2fmISzrgaHvv0b4Zg8Myd9XbvSRcCj1NaJ3mpToRmFC388PC/7osBPwt1gN pA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t2y8tr83c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 22:09:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KODcG2K2AvOIdBwDtMjIrFEUF+lCijXxZ0089E59hGB6fTN/2vj74z+fyIE5RwJINcgXaOEeyNII1wOfSB1r9XfygROmZkbPCgrRjFcbgsvt/ZY9TIwcH5qh3V4Ia4MzGqR7nrb7RkrDNFhlLckxdeyuLTNhIQqeNGDZyiea6A2TIS5V1OcEpqPuhauy8CongqX/7NmXrAliNWW4Sa/ZJOG45m4hOes7u5DrtDu+/Mzf4fKPgWgoJZg+btDeNwkAgj86+aEmsSDpoILKfnQMR9uNbZZ2PmAAHzFS8tlBISvh/FMsRMZ+fMPi8Pj7kNK4wCSLB0MGDMxob5HzxyphAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JY06g3Tk/Sti+zBsNYLXzyKSePW+lh/KsAJncC0Jpkg=;
 b=HRDO3wtC7tXCNDRE5P8pFByWUX9dMp3zKdfENi7yH0toOeAYjgX3ssMg0WQk1K84xZUu2MOXiKvz3Vzd5LvAC5U0Lg8sRkH+nk8dqdHpw6zPkM3hCMPvEdbcILx3ZO5kStR0aDqFb0CxpO61wlqC4BWIY5d3/8XQacSMwpavoKVSul/1Xb8INQrZY/bjQOoCzr+7gV88L+p4cWk4I/wPNHfdZyW0QQ37/r9aEttPcEbffvWK8CGD3JJEMv7rtvKpkdvj+sQoLg2z2Qmb3ub8GcpANfKGmbUtxqGqKjOT5qZuRucbafcaTNKJ7S/Ts1Gks1iATWe2pH7+zVnZxfRCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN7PR15MB6086.namprd15.prod.outlook.com (2603:10b6:806:2ea::20)
 by SJ0PR15MB5810.namprd15.prod.outlook.com (2603:10b6:a03:4e0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 05:09:49 +0000
Received: from SN7PR15MB6086.namprd15.prod.outlook.com
 ([fe80::6221:ea7c:469b:ab63]) by SN7PR15MB6086.namprd15.prod.outlook.com
 ([fe80::6221:ea7c:469b:ab63%4]) with mapi id 15.20.6745.035; Thu, 14 Sep 2023
 05:09:49 +0000
From: Igor Lesik <lesikigor@meta.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: 50% of all time spent in victim_tlb_hit() !? (or case when OVPSim
 beats QEMU hands down)
Thread-Topic: 50% of all time spent in victim_tlb_hit() !? (or case when
 OVPSim beats QEMU hands down)
Thread-Index: AdnmyOEnIkpyT9RsSBSX0ZgamoKETA==
Date: Thu, 14 Sep 2023 05:09:49 +0000
Message-ID: <SN7PR15MB60861158AECDBD4C52E98EDCC3F7A@SN7PR15MB6086.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB6086:EE_|SJ0PR15MB5810:EE_
x-ms-office365-filtering-correlation-id: c3ff5651-c378-46f3-3f86-08dbb4e0d227
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uGRNWzTcrEa5UnXVIrjModRYDRWcFnDzZhKRmA/RkZfbVwCmYv9eCpE4YCCoubnV266yD+rzEu7fjbOv2j2i6oC2+xLeXebho5ykmlGvHP1IIZl2ukUhUKzLjCDzCtHyD5/Vx8+F/f1Jcg9EDF2aqgG5ay9AezRo1JzC4mz8qiTFwOqX3ix0/9SaCWyobEO0z2c1F8RXnfJi7OICzMVg8WCYvqcjV6TOdthT+zSuAMpQ7R/hRbpGmg+7PM+ChH60O7527UEBw4ycMOCfg6TZDjFOpf3hp57fFxaq8kPwAnV+jhfsIhfPVdBGgE3kHNGV05ANz6QiprkkcAO0r947WNKAAyPwPvGJWybxt9iv7kc/aCEBC/bEjv37+QITCxW09R+FFzdl2DiUm0bqa9WrCIobrODT5f1iBYlMGE1VYplxC1egvOWkKY/xwsuSJSRTbE/pJLAKxc5+HibgKaS41dId0I6tmH6XA0X/CfOI+w7CkvZxxWp0ZKKzZvltSm53XkvHxZaeNK1GLuXZE7Ntam5nehuSls9QcnKO0f8BlWMe7G/LnDBKNBckWhhgIwdGiyYuWHg76iwoHno4yAZxQBB3XBz7ufWXPupUPGMqUCx/cMhE/rH2IufqAfpkBOe0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR15MB6086.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(186009)(1800799009)(451199024)(2906002)(86362001)(9686003)(33656002)(478600001)(6506007)(7696005)(71200400001)(38070700005)(38100700002)(55016003)(122000001)(41300700001)(52536014)(8676002)(8936002)(5660300002)(316002)(6916009)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?W0Zo3Zl8vna3yj68Bxz2BSqC8YIQYKBCkW/6pQtpgPzAsos/9NglhAFhSQOzeq?=
 =?koi8-r?Q?C5VRIyOQNwZ/VmrDClO0DjXyzbxEaDYeZNE64xQBrSDpDMJmJBtjva+1glj6Zu?=
 =?koi8-r?Q?pE81mb8Nb5AYNo5BDDn+ABose5Jio3D4CW39zbfVTZRnIaydm3MUQhuHcPsaId?=
 =?koi8-r?Q?WzR3MDyWBSrFmxJCfxaP0mbcj1P4K3qxrBpd60+7ZZZKFO7N32Rd9hceCP5mC7?=
 =?koi8-r?Q?2d67V0gglo5TzF32e1OnCZZmcfW3PHLgHWCDoxZHUn12AUrBexO4aB1cmSRUF+?=
 =?koi8-r?Q?FvmzmGujzA4VuPE4lLjmB4sBXXV/AYTabrYlZuMKur1gTbk0REmi4HkVkiWHTW?=
 =?koi8-r?Q?czTht236qiVHJ1o0eVHsNBtLuPAvhyrLcxn93bWGZGB+N4VRqIxQ9ewV0AQk/K?=
 =?koi8-r?Q?PSzUV8NxMTe6gn2IbhSoIHtHx49F85382XCOliNqNkOklNoAAP87f11A7BpzvW?=
 =?koi8-r?Q?fgxU8BshLApfwjtbDonsmzp7yt6AQ7tP3StX2GPuC5sQtE6Z7EpcrWVFvviPTf?=
 =?koi8-r?Q?DEpAbtrGslFpu0dWaIJ3DgfXNOUUucbG6OC/8VI/R0K93vmj7gQkmmSH2JYVk/?=
 =?koi8-r?Q?kFhTJTR0fgAgvRNpm+7Ngmn+9fiNETQw2QjrLUvVRtapyhx+Ru+PqJlQbW7wZi?=
 =?koi8-r?Q?CDWW3Ze1jgnAyEiLvxOBCi+cxvZxaa7TCISzorvn/s11k/QzfgjfynvzjVFCxA?=
 =?koi8-r?Q?nr0POCBVdzk4z7sjrdAS3LtgghHE4ASpTUWNm2I0z+msQpYniyjlvJSK3A7jnc?=
 =?koi8-r?Q?0IUEvsEUc7sOSi0G6QUSLCo/ogqqdP2qG/KfuIdkPxgzLoUZZdUURe7Ahndajx?=
 =?koi8-r?Q?lPAqG4kCJSdUU+/B0ySWqtdT6M5/wPWj3tKJXkbRdArpbYBDIgA9G4sp9DbKYJ?=
 =?koi8-r?Q?GsMyOK7KKkZ+2JJgHZ7rp0UBBCF2lgsomtcgDDv91tBUpZJ5zRWVXg8M9POjn8?=
 =?koi8-r?Q?Lm2X3uLyYor+uTqhDUvp/+FBsvp8L+T9OjM+Miv5FN2tCTj6yBJXrrWvyA/U4y?=
 =?koi8-r?Q?hBz1AmhX6YLcvOV0X3R47lTyGkyE7jnarNmB64RkUng88t4VxZN1mtmjP+W4xp?=
 =?koi8-r?Q?fwt+K+p0KuVDF+anBnp8Br6USoOGBtfmiEnai+foqUdRwdHpBDwVv/h6pzoaOU?=
 =?koi8-r?Q?AT3liJuBG3h1PCnWCA1guf+hRXFwKLVu+oSTwtI8j0w9A5XunlpaJC/vbWTVRO?=
 =?koi8-r?Q?Thi6JOIaL2STpUI5+5KRVwxLM9GtO66Hh3rWQcYcL46P7U1QHN5cuTJP7iZgWR?=
 =?koi8-r?Q?8UvjfEMAmBkdgNemsqjBj9twvn7hsOYV6P9CnPHgMZfnqmsSxAZemWCidiKnXs?=
 =?koi8-r?Q?YE2eDmimIWGa6eVxe5d1pBK3YncVYsyJ5r80jQV6toKYGr0RSwlANZsYuITkiQ?=
 =?koi8-r?Q?ijToDGAQo7LRvUgn/wv6cfZhrvzZ00kEPFBg9T8jovogN56R5bJgOCsQ9LUgwr?=
 =?koi8-r?Q?1rPte2uWcXPUpyfDJAC0h3cZMfSR3TWuvjY2isw18OMMuc+FTByynE7jthWUbl?=
 =?koi8-r?Q?sGEhejKsikT0Lt1WIzOmn5jSQudOBl7Fd4pJ3yU0VrKfxNWhBcgxD0HbALcojx?=
 =?koi8-r?Q?YE43eIBaSg=3D=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB6086.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ff5651-c378-46f3-3f86-08dbb4e0d227
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 05:09:49.4264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llvQ8rxFhhh+5+HmWY5k5YeBPJnAYOF7eTA4avOs8Hbvtn2tVikacatOtOKTr3HYdgP8EJ7lTncH7QgwgFYjKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5810
X-Proofpoint-GUID: FMaRL1l12O1b0fOPM97-7ESjFYv1VsKT
X-Proofpoint-ORIG-GUID: FMaRL1l12O1b0fOPM97-7ESjFYv1VsKT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_02,2023-09-13_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=2621ff136d=lesikigor@meta.com;
 helo=mx0b-00082601.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, PLING_QUERY=0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi.

I came across a case when OVPSim shamelessly outperforms QEMU. In 8 CPUs te=
st,
OPVSim single-thread is faster than QEMU tcg-single 4 times, and faster tha=
n QEMU mttcg by ~30%.

I constructed a simple test case that reproduces it.
When I profiled the test I saw that ~50% of all time QEMU spends inside fun=
ction  victim_tlb_hit (according to perf tool).

Setup:
1. For both QEMU and OPVSim I made simple machine with 8 RISC-V CPUs and on=
e RAM (system mode).
2. Host machine is x86 with 4 Cores, but only 1 thread per Core, so 4 HW th=
reads only.
3. The test is "bare metal", no OS.
4. All CPUs run the same program, no explicit synchronizations in the code.
5. Both QEMU and OPVSim use semihosting EXIT and simulation ends when "last=
" exit happens.

Test:

```
#define N (10000000ul * 60ul)
#define M (1024*1024)

int my_main(int argc, char* argv[]) {

  volatile long unsigned int a =3D 0;
  volatile long unsigned int b[M] =3D {};
  volatile long unsigned int c[M] =3D {};

  for (long unsigned int i =3D 1; i < N; i++) {
      int j =3D i % M;
      a +=3D i;
      a |=3D (b[j] * i);
      b[j] +=3D a & (c[j] / i);
      c[j] +=3D i + a;
      a +=3D b[j] - c[j];
  }

  //consume a
```

Perf report:

```
  46.78%  qemu-system-riscv64      [.] victim_tlb_hit
  23.68%  qemu-system-riscv64      [.] helper_le_ldq_mmu
   4.46%  qemu-system-riscv64      [.] helper_latch_ld_dest_reg_id
```

victim_tlb_hit
```
       =81    jne    1f9
       =81    lea    (%rax,%r9,1),%rcx
       =81    add    $0x130,%rcx
  0.25 =81    mov    $0x7,%edi
  0.29 =81126:shl    $0x4,%rsi
  0.39 =81    mov    %rdx,%r8
  1.65 =81    shl    $0x5,%r8
  0.35 =81    add    0x1fa8(%rax,%rsi,1),%r8
  0.32 =81139:mov    $0x1,%esi
  0.37 =81    xchg   %esi,(%rax)
 51.86 =81    test   %esi,%esi
       =81    je     150
       =81    jmp    148
       =81146:pause
```


Results:
1. OPVSim single 4 times faster than QEMU tcg-single.
2. OPVSim single ~30% times faster than QEMU mttcg.
3. When M changed from 1M to 2, OPVSim single 2 times faster than QEMU tcg-=
single,
   and 2 time slower than QEMU mttcg.

Question: does someone have an idea/intuition how QEMU code can be improved=
 to speed up the simulation in cases like this?

Thanks,
Igor

