Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E956C7CD91A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:23:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3hb-0006VG-Ev; Wed, 18 Oct 2023 06:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3hH-0006KS-Lp
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:22:40 -0400
Received: from mail-dm6nam10on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::608]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3hE-0001tW-RR
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:22:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ymz3f0+0cHXVNHuUbThukptRLajgoHdfE/YF6t+gv7Ze5ERQb4/0AzCky94KYYFlTDADEmNSVGCDhbRaOXeCxRz67w/vqafK8bsf74YyVXtkbXNezVQhuFknJLQ7CoIYNb+4jxMDuQREDT55oBo9zKFkkyCKMXW2GuWMNSc2HDx016L26U5S8MeksD154uMcwhC98dliCApM4yRGL7kd22YIRc16S82M81XN6CF/epW8Zp/F0dCu0SPUc6bsVZLl6DNaVwz99VXt3Cz7CblqiCOzq60+BdPK0Rj2AzGp2KIKv6sk4tmCddcAESwhy+KyHFrv4Yxi794Z2aj/AwoxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC3FGyRr5Oork8U15ahYzWes0GMstVczU6Mzb4Zkx8s=;
 b=YfXtnY2FEI7TR78nbuVMeooHPyT4kq9DQB7jrWZn+NODNjIi6Y6FjWpAdKt0E7PfOs+cKpYsPl4P6QB6SamA6dHzxWXSND/zsM039e07VdighI9HL5qFR+fUjsENArAurMoLAApFI1EYMYypHHOnqidAFARj0oscMRHJiVWFmxB+fqXCAO6F2dX2lZKbLsVFHCDL1qCWsZMAr96YmXgMs3OiFrtZ0hRoZeXfNg14UlM1yEBGXDU1F3o1HFMjmVbqzWF+nzC/10pFefjmEZQgVrN3+9npmsPTAE8dYx1f1DRXM//RKPtQkMftbOR9RMbAaXdegz5zoQlibol2JSenRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC3FGyRr5Oork8U15ahYzWes0GMstVczU6Mzb4Zkx8s=;
 b=2KNc0SJf4JFCaZem6xE2M0X18ilvMNtmgL+/jtF+VJoiJGsGjfdsCyPJQwC0BOynb0yw+XxfeDHjCEhdkAZuxG4ZHMDDqwp3qx7xbmkA/C0zVb/C/+eK1k1Xz5uKXJbLGvqDWPjPpxYOBoZIBWoz1kMZrcBS6CRuNaQbJozhmLo=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.47; Wed, 18 Oct 2023 10:22:30 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 10:22:30 +0000
From: "Boddu, Sai Pavan" <sai.pavan.boddu@amd.com>
To: "Michel, Luc" <Luc.Michel@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Michel, Luc" <Luc.Michel@amd.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, "Iglesias,
 Francisco" <francisco.iglesias@amd.com>, "Konrad, Frederic"
 <Frederic.Konrad@amd.com>
Subject: RE: [PATCH 07/11] hw/net/cadence_gem: use FIELD to describe IRQ
 register fields
Thread-Topic: [PATCH 07/11] hw/net/cadence_gem: use FIELD to describe IRQ
 register fields
Thread-Index: AQHaATJq3CGcgUPKwUCYxIK6QRJFR7BPV4DQ
Date: Wed, 18 Oct 2023 10:22:30 +0000
Message-ID: <DS7PR12MB574116DE87CB46948ADC6FFAB6D5A@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
 <20231017194422.4124691-8-luc.michel@amd.com>
In-Reply-To: <20231017194422.4124691-8-luc.michel@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|IA0PR12MB7652:EE_
x-ms-office365-filtering-correlation-id: a130c644-7cfa-467a-5635-08dbcfc422cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pnaUBN6jdH2Y0h500sIJyjGs77FXb5JICYwSQtNyP13TmTSbugKj8eF52nYAM2tvd1MlqMredpG9vF9Quf5SfLXztaPg/lzhW9zcZxr9AutKdsbo59YDODdBSV47Gu3SgfU9EBqw9JyRAZSrDkC4Rk2f5TF/UjzUNkkEX8yTHbKZf6veFOfQvZpgJ8Wbc4BaYM9s2fq5RXN/kiZGXruAvV+aF/hd3a+Af0ofNORLHmxSBrXQvznCCSclUhfQA9FjSg/OjGiX2opduDZrbu+RAbNaKeyqyhSkENR6kCqzulMglLsvAmMD5N9PNvOuCeAhrSKSkbEumBiuQtCYV9PsImeMFhYgPJHQ7olTrJSMnbE5V+5QYtgzAnef+sEfjnAfoz7cwFAmZraRYsCXRORekdvPnIJznET2IuHVrtwL/kywVBGsFAopDp/eSKQui2JDAcqDd5TW6BZXMBhTzlVRMl89b/wmsOpXxgOiC9X2NIxTOx/zU86Zim+byCffC93GacQfWLrkN/jtrRcF2lyHrTAuyaI6IxL0NnURpxFi+sJvEAm+Jt+TOzyT7MqKCUputRpNQ646cvUHw9qvPyoL7Ulk4BglzL+dwW+h9zmZI8zKpQHmTFCveUIe91oT8kpIi8gu3/Nhb9WPc8FskCEEA9b8h9VYbzFvRCsAW8CCsHE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(55016003)(26005)(7696005)(9686003)(6506007)(83380400001)(66476007)(71200400001)(52536014)(8936002)(4326008)(316002)(5660300002)(478600001)(2906002)(8676002)(54906003)(64756008)(66556008)(66946007)(76116006)(110136005)(38070700005)(122000001)(86362001)(66446008)(38100700002)(41300700001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ub+FZLwq0zVISPKCH1Zftf0J84hZNsWCsajPF5ZmuL04+4F5mwpLu1Qfc8?=
 =?iso-8859-1?Q?RbmijJje+2zVPOEQuCF5s/t3q3On4/Y6upj6Z1p+eIdm/8AS03wtKwR+tJ?=
 =?iso-8859-1?Q?7SG+cex2BWBxT+tNs9n85yAzkopbS1kL7lP2YzkypR1no5No3ye+lWKY1x?=
 =?iso-8859-1?Q?5HSsWz08LPSShd6Y/QjKY4x61yydchV+1origkABMc6vFuxedbhtrTajLt?=
 =?iso-8859-1?Q?L9wrjmQljI3eOxmgZvFh9AKEaVZwOvah0hct9sBmlgl1uUaDnliduMiWkX?=
 =?iso-8859-1?Q?wdj2AlohifQx4uM0xccBhyNp6wl2GGXg8tcIVmfMkMt4NeyO2XoGARN21P?=
 =?iso-8859-1?Q?ugbWlJydVJB+Z2gNs8xoYImC5Y/6Elgd/+nw+Ab+LQoZgOQa9WFL+jxShI?=
 =?iso-8859-1?Q?Md8MwEf/Vs88BndS0hKcdUB9gK6HjB00je0XfU6ClhOs94pkOJdTwAfxjI?=
 =?iso-8859-1?Q?ry1S8NhUeeynzOY8Sl5JI72z7gnOYMrx/XfObdo4Sa8iymQXlYuyu03a4h?=
 =?iso-8859-1?Q?MRguDsadlY8Q7nNB5OtdtIL68OA2yzefdDPl0IbRkwBCEFKHL9Cz6vn1Qd?=
 =?iso-8859-1?Q?85BrRj7ymW+L6Rse60j/7YFsi0bQC1x7hrcX8/xThtUbhTW7wzs7ka/c6P?=
 =?iso-8859-1?Q?soxMBZcjN4GuyzZWukh65zPuRayBvOcyJczLLF9KG6FwwWuTEvSzXaEk+k?=
 =?iso-8859-1?Q?gqGvNzEhjNkU/Jfrn6IJ3eaLlFawat3ybPLXkS1hGQSoQO7BdyF7a8+fo/?=
 =?iso-8859-1?Q?kW3Esv4WmFpJNbygwKdgZTnsn9qyJOgfXu4v23RMInL6OS6pZHTR9reDbP?=
 =?iso-8859-1?Q?E69WzSSH24CZF11JQivlbtJFGPyO/Gzc6mQFLKHABhUFZsfgV0EHSMVt/C?=
 =?iso-8859-1?Q?XCFt/PjIQ7N5GTbtxlBkXpNkwIk8+yJ4Ag5TMie3X+1xSWLJH74AFuKMs4?=
 =?iso-8859-1?Q?wKJ2AFFa4aPU6CBfzm0uC92VaWQVpskujVXzVBbRV141kNFSlBTOMVPFjp?=
 =?iso-8859-1?Q?Oh8cN9nWD9ndo11uZsKOlqmkhFnt2KN4XQABhVW9M5I9GJbSR8Y1ilex4f?=
 =?iso-8859-1?Q?t4Mr5dOrK/ubGzjY2yg79GewAgdGaSf/ecLLpIWRdErppsrb7/NvxwwdB3?=
 =?iso-8859-1?Q?pfiQmde+zrudbElI3dvmBPBksNHqnruftodQA6++YT3hbrmTr06+gEQysa?=
 =?iso-8859-1?Q?9yQzWiYKhA1+gNKIAfRWRbZtvn9jtjQaqn3mKZDlehnnivibrpG5RE/FVC?=
 =?iso-8859-1?Q?G37vLHcNVCTWaO//cZ3Izprp4yRqdpvMhweLaDduq+JAHRQFZhciG8LYwQ?=
 =?iso-8859-1?Q?S9X1xw8OmuLkCyB6i0c6gIBPl22vWZMdotE9myVwVg6nf3Igd9WfGaZH2p?=
 =?iso-8859-1?Q?6cXJD+31qGK5VZ6szB8Kgcu2MOesl6vXUC6rMABGQ6R8lpejzC+7+046Xg?=
 =?iso-8859-1?Q?YzQjiRrcCziTA5JZY77q7oc8p8qpJVFZ4bQSmCCtV2UEBRvFwIjlA2w8Vn?=
 =?iso-8859-1?Q?EZwsnwx8mJfLpOXXKNK+9eNI4iWZj2MLpJSRvF1UFqR9w20vD9QBE+QNPE?=
 =?iso-8859-1?Q?YVICVKTD0C8yz51xQ+ZO5LO08f2vsgPq8m3DAorCpv1w/cukJgTyCgkKil?=
 =?iso-8859-1?Q?EaXrgpNGCjV9s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a130c644-7cfa-467a-5635-08dbcfc422cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 10:22:30.7208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYSVAa8zAAsYhW24exndBfvTKYbEjcfrb71NATqgdGLB0Ae12l2nObUqzes2nLHI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
Received-SPF: softfail client-ip=2a01:111:f400:7e88::608;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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



>-----Original Message-----
>From: Luc Michel <luc.michel@amd.com>
>Sent: Wednesday, October 18, 2023 1:14 AM
>To: qemu-devel@nongnu.org
>Cc: Michel, Luc <Luc.Michel@amd.com>; qemu-arm@nongnu.org; Edgar E .
>Iglesias <edgar.iglesias@gmail.com>; Alistair Francis <alistair@alistair23=
.me>;
>Peter Maydell <peter.maydell@linaro.org>; Jason Wang
><jasowang@redhat.com>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;
>Iglesias, Francisco <francisco.iglesias@amd.com>; Konrad, Frederic
><Frederic.Konrad@amd.com>; Boddu, Sai Pavan
><sai.pavan.boddu@amd.com>
>Subject: [PATCH 07/11] hw/net/cadence_gem: use FIELD to describe IRQ
>register fields
>
>Use de FIELD macro to describe the IRQ related register fields.
>
>Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: sai.pavan.boddu@amd.com


>---
> hw/net/cadence_gem.c | 51 +++++++++++++++++++++++++++++++++-------
>----
> 1 file changed, 39 insertions(+), 12 deletions(-)
>
>diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
>0acee1d544..6d084a3b31 100644
>--- a/hw/net/cadence_gem.c
>+++ b/hw/net/cadence_gem.c
>@@ -155,13 +155,46 @@ REG32(RXSTATUS, 0x20) /* RX Status reg */
>     FIELD(RXSTATUS, RECEIVE_OVERRUN, 2, 1)
>     FIELD(RXSTATUS, FRAME_RECEIVED, 1, 1)
>     FIELD(RXSTATUS, BUF_NOT_AVAILABLE, 0, 1)
>
> REG32(ISR, 0x24) /* Interrupt Status reg */
>+    FIELD(ISR, TX_LOCKUP, 31, 1)
>+    FIELD(ISR, RX_LOCKUP, 30, 1)
>+    FIELD(ISR, TSU_TIMER, 29, 1)
>+    FIELD(ISR, WOL, 28, 1)
>+    FIELD(ISR, RECV_LPI, 27, 1)
>+    FIELD(ISR, TSU_SEC_INCR, 26, 1)
>+    FIELD(ISR, PTP_PDELAY_RESP_XMIT, 25, 1)
>+    FIELD(ISR, PTP_PDELAY_REQ_XMIT, 24, 1)
>+    FIELD(ISR, PTP_PDELAY_RESP_RECV, 23, 1)
>+    FIELD(ISR, PTP_PDELAY_REQ_RECV, 22, 1)
>+    FIELD(ISR, PTP_SYNC_XMIT, 21, 1)
>+    FIELD(ISR, PTP_DELAY_REQ_XMIT, 20, 1)
>+    FIELD(ISR, PTP_SYNC_RECV, 19, 1)
>+    FIELD(ISR, PTP_DELAY_REQ_RECV, 18, 1)
>+    FIELD(ISR, PCS_LP_PAGE_RECV, 17, 1)
>+    FIELD(ISR, PCS_AN_COMPLETE, 16, 1)
>+    FIELD(ISR, EXT_IRQ, 15, 1)
>+    FIELD(ISR, PAUSE_FRAME_XMIT, 14, 1)
>+    FIELD(ISR, PAUSE_TIME_ELAPSED, 13, 1)
>+    FIELD(ISR, PAUSE_FRAME_RECV, 12, 1)
>+    FIELD(ISR, RESP_NOT_OK, 11, 1)
>+    FIELD(ISR, RECV_OVERRUN, 10, 1)
>+    FIELD(ISR, LINK_CHANGE, 9, 1)
>+    FIELD(ISR, USXGMII_INT, 8, 1)
>+    FIELD(ISR, XMIT_COMPLETE, 7, 1)
>+    FIELD(ISR, AMBA_ERROR, 6, 1)
>+    FIELD(ISR, RETRY_EXCEEDED, 5, 1)
>+    FIELD(ISR, XMIT_UNDER_RUN, 4, 1)
>+    FIELD(ISR, TX_USED, 3, 1)
>+    FIELD(ISR, RX_USED, 2, 1)
>+    FIELD(ISR, RECV_COMPLETE, 1, 1)
>+    FIELD(ISR, MGNT_FRAME_SENT, 0, 1)
> REG32(IER, 0x28) /* Interrupt Enable reg */  REG32(IDR, 0x2c) /* Interrup=
t
>Disable reg */  REG32(IMR, 0x30) /* Interrupt Mask reg */
>+
> REG32(PHYMNTNC, 0x34) /* Phy Maintenance reg */  REG32(RXPAUSE, 0x38)
>/* RX Pause Time reg */  REG32(TXPAUSE, 0x3c) /* TX Pause Time reg */
>REG32(TXPARTIALSF, 0x40) /* TX Partial Store and Forward */
>REG32(RXPARTIALSF, 0x44) /* RX Partial Store and Forward */ @@ -306,16
>+339,10 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
>     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
>
> /*****************************************/
>
>
>-/* GEM_ISR GEM_IER GEM_IDR GEM_IMR */
>-#define GEM_INT_TXCMPL        0x00000080 /* Transmit Complete */
>-#define GEM_INT_AMBA_ERR      0x00000040
>-#define GEM_INT_TXUSED         0x00000008
>-#define GEM_INT_RXUSED         0x00000004
>-#define GEM_INT_RXCMPL        0x00000002
>
> #define GEM_PHYMNTNC_OP_R      0x20000000 /* read operation */
> #define GEM_PHYMNTNC_OP_W      0x10000000 /* write operation */
> #define GEM_PHYMNTNC_ADDR      0x0F800000 /* Address bits */
> #define GEM_PHYMNTNC_ADDR_SHFT 23
>@@ -1002,11 +1029,11 @@ static void gem_get_rx_desc(CadenceGEMState
>*s, int q)
>
>     /* Descriptor owned by software ? */
>     if (rx_desc_get_ownership(s->rx_desc[q]) =3D=3D 1) {
>         DB_PRINT("descriptor 0x%" HWADDR_PRIx " owned by sw.\n",
>desc_addr);
>         s->regs[R_RXSTATUS] |=3D R_RXSTATUS_BUF_NOT_AVAILABLE_MASK;
>-        gem_set_isr(s, q, GEM_INT_RXUSED);
>+        gem_set_isr(s, q, R_ISR_RX_USED_MASK);
>         /* Handle interrupt consequences */
>         gem_update_int_status(s);
>     }
> }
>
>@@ -1102,11 +1129,11 @@ static ssize_t gem_receive(NetClientState *nc,
>const uint8_t *buf, size_t size)
>     /* Find which queue we are targeting */
>     q =3D get_queue_from_screen(s, rxbuf_ptr, rxbufsize);
>
>     if (size > gem_get_max_buf_len(s, false)) {
>         qemu_log_mask(LOG_GUEST_ERROR, "rx frame too long\n");
>-        gem_set_isr(s, q, GEM_INT_AMBA_ERR);
>+        gem_set_isr(s, q, R_ISR_AMBA_ERROR_MASK);
>         return -1;
>     }
>
>     while (bytes_to_copy) {
>         hwaddr desc_addr;
>@@ -1179,11 +1206,11 @@ static ssize_t gem_receive(NetClientState *nc,
>const uint8_t *buf, size_t size)
>
>     /* Count it */
>     gem_receive_updatestats(s, buf, size);
>
>     s->regs[R_RXSTATUS] |=3D R_RXSTATUS_FRAME_RECEIVED_MASK;
>-    gem_set_isr(s, q, GEM_INT_RXCMPL);
>+    gem_set_isr(s, q, R_ISR_RECV_COMPLETE_MASK);
>
>     /* Handle interrupt consequences */
>     gem_update_int_status(s);
>
>     return size;
>@@ -1292,11 +1319,11 @@ static void gem_transmit(CadenceGEMState *s)
>                                                (p - s->tx_packet)) {
>                 qemu_log_mask(LOG_GUEST_ERROR, "TX descriptor @ 0x%" \
>                          HWADDR_PRIx " too large: size 0x%x space 0x%zx\n=
",
>                          packet_desc_addr, tx_desc_get_length(desc),
>                          gem_get_max_buf_len(s, true) - (p - s->tx_packet=
));
>-                gem_set_isr(s, q, GEM_INT_AMBA_ERR);
>+                gem_set_isr(s, q, R_ISR_AMBA_ERROR_MASK);
>                 break;
>             }
>
>             /* Gather this fragment of the packet from "dma memory" to ou=
r
>              * contig buffer.
>@@ -1330,11 +1357,11 @@ static void gem_transmit(CadenceGEMState *s)
>                                          4 * gem_get_desc_len(s, false);
>                 }
>                 DB_PRINT("TX descriptor next: 0x%08x\n", s->tx_desc_addr[=
q]);
>
>                 s->regs[R_TXSTATUS] |=3D R_TXSTATUS_TRANSMIT_COMPLETE_MAS=
K;
>-                gem_set_isr(s, q, GEM_INT_TXCMPL);
>+                gem_set_isr(s, q, R_ISR_XMIT_COMPLETE_MASK);
>
>                 /* Handle interrupt consequences */
>                 gem_update_int_status(s);
>
>                 /* Is checksum offload enabled? */ @@ -1380,11 +1407,11 @=
@ static
>void gem_transmit(CadenceGEMState *s)
>
>         if (tx_desc_get_used(desc)) {
>             s->regs[R_TXSTATUS] |=3D R_TXSTATUS_USED_BIT_READ_MASK;
>             /* IRQ TXUSED is defined only for queue 0 */
>             if (q =3D=3D 0) {
>-                gem_set_isr(s, 0, GEM_INT_TXUSED);
>+                gem_set_isr(s, 0, R_ISR_TX_USED_MASK);
>             }
>             gem_update_int_status(s);
>         }
>     }
> }
>--
>2.39.2


