Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7CE81356A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 16:56:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDo4C-0007CG-8p; Thu, 14 Dec 2023 10:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1rDo41-0006tK-Qf
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 10:55:54 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1rDo3z-0007CA-ST
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 10:55:53 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3BEAW8F8005321; Thu, 14 Dec 2023 07:55:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=VYPqvpGcq5xts4u9zvJkXbp8+yowPuUYUzcHh8
 GJ87g=; b=AqAUrQtExY4KOAJJYuIVTGu3oIJAJjH+x8Fpo4zYeq21580tYrBvta
 r9mgU8wr9JfwzG8rrmMWhYdhn8C+dgsv+v2Ygc1sZZztaHbmEQ5LkIAOx8KiM08M
 UL0oxLlk6LbxjH+8IdiQDYLz5ahXLqTtlpTCsDCx4ZokzHeCWT5nqr9EeyWekWn4
 pyY215VwyfMCK8Jcap99S5jDG8qihXown7zaaPuqf4jAF4Xj0BpuCE6dYfkj+heX
 Q/40dSDniVSnO6HI4lCtdoDUs+HRyClVKKk5gOmQfdwmth6dkXhkAjiierdS856X
 6S1+RHRLgbS1S5T+jUT0041ri1+CiIwQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3uvregjm64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Dec 2023 07:55:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYkggK9lpkCGR0fqbQmaipMA7Xj9FqlNGJrN1GtInoft7++T46zSqd2CTZhN+sC5gxb7UUnTeqajq7Sz2d3ME2MgTJcnKMWSTDzhQ7R41L8gev6wq5F8setS6e/gBRMQQRzGOIr6nkmbGtn4Zf0ydun4Oz5JyRf7tc1N7vtylAnIf3kURsQ3cXqiDXdg9TmQmfUltNIUAopILkxnNbsalxeLgUdEDwgiwZ7L2ll5LgHg3/PrJRBSa29mHuM7To/FiZyr9skIaMAtsD5l1hwg1FxKg4T/OpnQqv/5eiPaKosex5F2DuVLCbzP++iSBmt3FbBw7aaD01b30M2swFqqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYPqvpGcq5xts4u9zvJkXbp8+yowPuUYUzcHh8GJ87g=;
 b=J92rdlxD2gXuo04Q61W3ogAAKwYsM1HSJF8gJ75NmeO3pm4Jqfl+F80inc2EUP3IrSnho+eSwzPFhkry8hkL1J+8rVMbTiwNr0q6ftiHGdMFzAxePcPJimWpnBxs5XrIKtw+2XksaMH0DxjZsjpwPVQUjre1RQJuAXe6uMelAktQH1aIaa9lwK04J2pzYQ/RyANAa77ofMRyTKV0NoBf/hBtPEtcbsm9TOxZCvHdU7R8b2BojznrTSdWpk5ognpaFFEyoVtMFIA6bmVNLbB8XC5PSfQk9/O3VmYJ2Qb03BvPgG4oyaXS+cCTxixGRfBqkoiAOCaf77h24fatK/m/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYPqvpGcq5xts4u9zvJkXbp8+yowPuUYUzcHh8GJ87g=;
 b=NwoGojp7U9QtqHNdFkTTsEy1WuvSBG/s685nqT6BD3YtSneuwP9gbA59lRpdp381RRnXVeN78IrGUC008hG2OIl1IaPR0XJhzi+mSGzAswcqeqpi5FW5476wuBpmDrd7zVykhdEaZFZ7QoEnsHUWkHHxOSKP+U7W01GGJuKfYnLQwUOwPVJaOKOvYEit8EH2ydOaLaUYotreKJ5CN4mThi7UFklo8z6qEnco0BEmTAvOK4J+RYqKZiHLrcCheZ2lE/+HUJ/k2e/YkXhPgbHCQvTp86SL9phaw0LmxEIg6g6JL2TX/0CAZE9MFZ7NgNRLTw/s4XDulj5xCHbWICgaPw==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by SN7PR02MB9282.namprd02.prod.outlook.com (2603:10b6:806:342::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 15:55:34 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::904c:75c4:cf57:bb95]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::904c:75c4:cf57:bb95%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 15:55:32 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
CC: "open list:All patches CC here" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "fam@euphon.net" <fam@euphon.net>, "fengli@smartx.com" <fengli@smartx.com>
Subject: Re: [PATCH 1/1] vhost-scsi: fix usage of error_reportf_err()
Thread-Topic: [PATCH 1/1] vhost-scsi: fix usage of error_reportf_err()
Thread-Index: AQHaLiXsjP6MhBH3N0WuPlxhYBW+i7Co76KA
Date: Thu, 14 Dec 2023 15:55:32 +0000
Message-ID: <63762673-5EC7-431F-9AE6-48B963B497C3@nutanix.com>
References: <20231214003117.43960-1-dongli.zhang@oracle.com>
In-Reply-To: <20231214003117.43960-1-dongli.zhang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|SN7PR02MB9282:EE_
x-ms-office365-filtering-correlation-id: 75f794de-1200-42f0-f226-08dbfcbd1a5c
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NH8prjR4XhHsNykfkDCEaLun87RVpsG4JVofJt/l2v7fYhtwGhB8qeZUFAAQ04Y2PEn6EryTA4oEXUGTXj4QB6GgRsHeEx1I3paykS+4JgSb6yG3X5NLkQxPrcRjcqZR3QKuS1D3UaIF9+tapTijSDa11479LgkARyaYBQ9KYCsODhX5mufMw35bjKisjcXBr7X5zl4JAWO+xU6mjpcge22IOEhdyMwS1hKcwoqULge8AztvwfHfphKlFRBwEaGgUlNnGULQQV9xHE6UszYwVn4yRC+2YcrP20HXQWuzQay4b/GgG4aY90CPK/W8UNmYKaE5XA7BGwHhuFgp30BlQP7ZMBVBeb5t+scz7DuopuD2Fa4Is8aEn2XHzyeoIihWchZEg0OYCVd/bl62RXlh1nflHglfce+H1JVdUo6ajXzmi+cOG/Rt+Py+F3SVkUnXojGSoWg1O7Fg2ZIvHlEuKaoGkBPf+7aWIXgsvny28yMsYlg2cp8vjLGmoiXPEsy4JNj7kYCoW0DUqRoskBi9Cy7OPOdfFkFFBB61SXvPtm88+RWfbEBEl575/Sd7mR43VudLcC/fDU5mpLoz6KrvCS423VDkoCK+0znjx/gxyy8KXU+a9QnkiMa3G4MYMd30o1BqvHe95j39JdSx9XsvIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(8936002)(44832011)(4326008)(5660300002)(2906002)(6486002)(478600001)(6512007)(6506007)(53546011)(66476007)(64756008)(316002)(54906003)(66446008)(66946007)(6916009)(66556008)(91956017)(76116006)(41300700001)(38100700002)(122000001)(33656002)(86362001)(36756003)(38070700009)(83380400001)(2616005)(71200400001)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LE8LQLgJYlqgkJr391ZKhoQ5rYSqZcWppgBNvGuGfUmetCXYYkS0IVB95gcl?=
 =?us-ascii?Q?WzPf5eKP0t8TD3FI0zo9Oht1g+GMjYxCB85ouDHAUNBoip+L8bBK/oeR5gVY?=
 =?us-ascii?Q?rz7zY7U1jV7tVarqAcVL3XSd0FYOCRprcb+/E3V7MJQ8ij6ZAUoqOqnyegZ+?=
 =?us-ascii?Q?R9M0/798f56U5apvxc4ykLKuoMJWrSiYyt4zpWZ8WZO5tl599TZ+xzxkXqZI?=
 =?us-ascii?Q?5TxHG7N3AFGJY+JYJX+uj8TWSy6GluHXTx2u919+/6ZxgB7NANMBV0oLpv60?=
 =?us-ascii?Q?5xAslGdLjbPrcCQFI+W076b7JIaiPtzVa1Rdq9NU7ONLeiHUJH4fCBYhAZtH?=
 =?us-ascii?Q?+XP0Qw7m77SBBfWCx2Noc4UMasBWyIRqmLSmP+eAw4ss2kJnh3XdrKiJIcq7?=
 =?us-ascii?Q?4WZrBt/MYCEnC45jooQBfPR7ay3X/V2J4a7xI+xyd3Ndv2Sx4Zeger3hGmWY?=
 =?us-ascii?Q?mKoIpyhfzaUYNScIX5YEZBzd/wRV7R8EK7JnCN80qBTnvNBPSvzvWO3XbKkM?=
 =?us-ascii?Q?DeljVXM0u9uaWByhMON3ou2qFmIq+Ec+XdciyKOeAe0Kt4SIb/HLXQ5Z9S/o?=
 =?us-ascii?Q?HOMvEbsHOb969b3DSLkuRa7AD+BRjAaCj/24x2jtaq7+MrwQRUbV4eTrvWsZ?=
 =?us-ascii?Q?64++o/McMl0EgmKAhlLzvHkKBnIYdVbBVmV3tuy9inUrlQoXwmOR8XN/+vCZ?=
 =?us-ascii?Q?6FNHXGuG0Znyj6hlkWItIQw25n1JruE5yLasHd0j9R6S30CKuvRc02LqlVsO?=
 =?us-ascii?Q?Gd6OtPaWX/LfEkdXQ+4mLxsQwXLy+HMobJNn4jpRiAlhDC9comYUCLr3U0vD?=
 =?us-ascii?Q?SbX6REQcQjKQs3zZZjJudSe+T9nYJ2o6oWg7sAtUDaCnsjJ+HNCIwto2zNFL?=
 =?us-ascii?Q?dyT9jvj+RibxR1jTWpSL+DU99AC0vIKA099C3cg+/t7zpuy9m1FcJ2LelGGb?=
 =?us-ascii?Q?DjQNUC9GpRBrwQp5jwU2dyfbAt3seoVc9PYnBturSJIV3cVKRJtYfF6e/USZ?=
 =?us-ascii?Q?5+k1PKV4rWshG7mpMJEt4cDQlIdsIEe4sFXS9kNY9+98URar4oZxj1+pcgDf?=
 =?us-ascii?Q?vO3M4yLkr7iJu62ZWckhQnehJt03mLTkkViz4gy3okTsEphcEtaivtdOitq0?=
 =?us-ascii?Q?CTap7ALZnkiVsp3FrBzFM/i2XQhx7Jhkd7kArHw1vbwHpvQorIl3uzzQCVID?=
 =?us-ascii?Q?i/Gjl1moT28Sz1HLAwwlu2s9uknu0YfMQ+JtV9D4Env9/EvuodjeAF53sGSB?=
 =?us-ascii?Q?gncZtuM5QW9SxU/YbeX1ciy7xzYdJahQKejgov6iRFPyo5SgG0mlV6+ceETN?=
 =?us-ascii?Q?cs5B/3cUMAQh//qmufh325ydELrbVJF/Td8ZUmWDP/26DIuGsh3Kpl2xne0i?=
 =?us-ascii?Q?ky2ozWkuTmyOC0qTEFCm3Ixjoj08ws9vFGsvCBWbRI/tHOGUWHBYu57qSQJU?=
 =?us-ascii?Q?eZrteZt+6B8H/PY0InlRGwLJFHZep4MbNZZ6W8qoi3XDuA2qgW5EfAZcWtP/?=
 =?us-ascii?Q?FXM3BGV6MNYFog2t83ZqLtSnjVCgc0Q5K4uEDaUcc9GM1qbc+yUOldaDlC2i?=
 =?us-ascii?Q?0vOoGpJqQpHtluLbAnCfnD8T8UCGJ/UetIC6JWQP2ZwuNdAVR2gEuliFBQJA?=
 =?us-ascii?Q?A1J5oz5QjRO2QLsFWRlzFYOkXEKdHW3FAOnLIFY3x9HWidYHWc2cn4xVeOus?=
 =?us-ascii?Q?1kWBlvA1NQacOC7xSVDV6Ee+Xm0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36AFAB265DACA54788DF95223215BCB4@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f794de-1200-42f0-f226-08dbfcbd1a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 15:55:32.4038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OU6p7WoFjvAkYHbQtScfr/y6nH2mYRQKxcToDz4eepgInqBgexrVw54C4g59mpFWY4JV7u9TOq+VviVkcknm38sX5cdvPFBTTd3qZFb/ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9282
X-Proofpoint-GUID: eCzutUwpGHjDQkwJ9qF0xFeVGJWRIOwg
X-Proofpoint-ORIG-GUID: eCzutUwpGHjDQkwJ9qF0xFeVGJWRIOwg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

> On Dec 13, 2023, at 7:31 PM, Dongli Zhang <dongli.zhang@oracle.com> wrote=
:
>=20
> It is required to use error_report() instead of error_reportf_err(), if t=
he
> prior function does not take local_err as the argument. As a result, the
> local_err is always NULL and segment fault may happen.
>=20
> vhost_scsi_start()
> -> vhost_scsi_set_endpoint(s) --> does not allocate local_err
> -> error_reportf_err()
>   -> error_vprepend()
>      -> g_string_append(newmsg, (*errp)->msg) --> (*errp) is NULL
>=20
> In addition, add ": " at the end of other error_reportf_err() logs.
>=20
> Fixes: 7962e432b4e4 ("vhost-user-scsi: support reconnect to backend")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
> hw/scsi/vhost-scsi.c      | 4 ++--
> hw/scsi/vhost-user-scsi.c | 3 ++-
> 2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 3126df9e1d..9929c0d14b 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -91,13 +91,13 @@ static int vhost_scsi_start(VHostSCSI *s)
>=20
>     ret =3D vhost_scsi_common_start(vsc, &local_err);
>     if (ret < 0) {
> -        error_reportf_err(local_err, "Error starting vhost-scsi");
> +        error_reportf_err(local_err, "Error starting vhost-scsi: ");
>         return ret;
>     }
>=20
>     ret =3D vhost_scsi_set_endpoint(s);
>     if (ret < 0) {
> -        error_reportf_err(local_err, "Error setting vhost-scsi endpoint"=
);
> +        error_report("Error setting vhost-scsi endpoint");
>         vhost_scsi_common_stop(vsc);
>     }
>=20
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 780f10559d..af18c4f3d3 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -83,7 +83,8 @@ static void vhost_user_scsi_set_status(VirtIODevice *vd=
ev, uint8_t status)
>     if (should_start) {
>         ret =3D vhost_user_scsi_start(s, &local_err);
>         if (ret < 0) {
> -            error_reportf_err(local_err, "unable to start vhost-user-scs=
i: %s",
> +            error_reportf_err(local_err,
> +                              "unable to start vhost-user-scsi: %s: ",
>                               strerror(-ret));
>             qemu_chr_fe_disconnect(&vs->conf.chardev);
>         }
> --=20
> 2.34.1
>=20


