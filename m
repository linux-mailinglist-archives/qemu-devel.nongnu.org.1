Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5556E832AE8
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:04:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQpTC-0002zG-QV; Fri, 19 Jan 2024 09:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoyong.zhong@nephogine.com>)
 id 1rQmMW-0006Hc-3Z
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 05:44:36 -0500
Received: from mail-bn8nam11on2100.outbound.protection.outlook.com
 ([40.107.236.100] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoyong.zhong@nephogine.com>)
 id 1rQmMT-0002yX-TY
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 05:44:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB2EsYzDtfEqGdWWtvvvzIt+DkofqyVDbx3fy8hZvWw8RSn+WfAlgoM07zHWE9qTrxIVZrCwBH7dp9gwoPXh8/6GX/gw9cECZFS4G2ntgrdtbdBb37XQkgkYimZqbSQL1VW2yPgG2MeC5Hi9unmgvUX4TMh5KQWtWcgHxQaBguW4EuskG+Zl6sz5wkT+6KQyunhxeIJb4z/QiQbNZ5dCJrE5abmEQpkZgVQDcoPhUz/lQbs53FN5AQFfgliyA7N4sHpyM8uOzv3nBhIz5J35/T5itjEVEXQT4kJqUMxSqpR3yn0wBaf5M5TerMKEH7mY/dhD7vhTmBD8PPNFew7ViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0FdiGReDdPLEhuZaXqzJINLMEY1SWIf30TQrgOCvc4=;
 b=ABkFeX/qLantNjW4VuiS/TAUJ+7DmcRVtOOevMcxqDAeY8Q7ShL/TWoCFDT6wJuY7uGwPkJKQKUIBx8/AOhVM0+i7+RpH0xrbMO2o2TNZte9lk44LrxycfLlyqdugvn+us2MtvuQ65ug5Zz1TNsPvKbq+rpDZG7MVIvaqUxlaiUe0PqhQG8Hz73EZfyex8TsNXFCkAF+6MhiRBe3u5p6G4U9SVawRGE+u90bBBrDI/AQlDJINbYDEuwLWcnyCjNjz5WmN0R96mZv7NEN1vOy9R2SiaGdNA/obVOyRsD3IhqM22L0nc9ayrBQxtXDm6iVo9WfwuGnTPuL9p4PprmPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nephogine.com; dmarc=pass action=none
 header.from=nephogine.com; dkim=pass header.d=nephogine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nephogine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0FdiGReDdPLEhuZaXqzJINLMEY1SWIf30TQrgOCvc4=;
 b=Ce8rEP/mk+pdawB80Zmip9vNb9UWOgFHDppPzmLYxX2KADJAk37BSFxf7XAffOh2Ln7PfTVLRxHEDaCYIixgUK0qZW6Bht5fEHqnnuf6NIm0n/HDDB6T1XLEfVCQl1NUcwlLqHIWEQZqVZw1D6x/HrkhBwi74lhlC1FAptW9+LSR2gFUOBtyQcenzxCPQ2slKQ+Vzv5Amb1GXHn7OGdg8dCrnjF9aRG7dqM/wXWSqJDTR3gZVCb5+RFTmZ7HsPgc/XEKOcDoplpSQYgig0jDRN608CCFQxhXePiyU68/TzUFG7Jq8d4kn8g5OqBQ/qjelAAoEQg+tGs9VDaEtjZOQA==
Received: from DM6PR13MB3988.namprd13.prod.outlook.com (2603:10b6:5:28e::12)
 by BY1PR13MB6576.namprd13.prod.outlook.com (2603:10b6:a03:4a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 10:39:27 +0000
Received: from DM6PR13MB3988.namprd13.prod.outlook.com
 ([fe80::eea0:4963:4082:20f5]) by DM6PR13MB3988.namprd13.prod.outlook.com
 ([fe80::eea0:4963:4082:20f5%5]) with mapi id 15.20.7159.020; Fri, 19 Jan 2024
 10:39:27 +0000
From: Rick Zhong <zhaoyong.zhong@nephogine.com>
To: Eugenio Perez Martin <eperezma@redhat.com>, Wentao Jia
 <wentao.jia@nephogine.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Xu
 <peterx@redhat.com>, Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: =?utf-8?B?5Zue5aSNOiBGVzogW1BBVENIXSB2aG9zdC11c2VyOiBhZGQgVklSVElPX0Zf?=
 =?utf-8?B?SU5fT1JERVIgYW5kIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBIGZlYXR1?=
 =?utf-8?Q?re?=
Thread-Topic: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
Thread-Index: AdokPrZLsAJfb0btQhCy7EbMDce/EgY4mSYwAAJ9PgAABGqn8AAAz8ygAfvHuzAAhk7OgAA1l2oAAAD22YAAB9kDgACXz1iAAAgyIIAAAEaZwA==
Date: Fri, 19 Jan 2024 10:39:26 +0000
Message-ID: <DM6PR13MB3988D0E01FE275F72E53397295702@DM6PR13MB3988.namprd13.prod.outlook.com>
References: <SN4PR13MB5727A538887598415C5A37D28681A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D7B4E7CC91345135A5058661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEvwanHfheCMo-gDjzx1DrX51AMtoaYJ9PcE0yYmZdA+Uw@mail.gmail.com>
 <SN4PR13MB5727A90B141E383127F1E25D8661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB572773EF8D25A2E2C5AE48608661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB57274870E6BBFC76749E8D96866F2@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEu6X2L-eawwsy_pE1mVVDU7V=Qe_51YrK16W-kKu4BGxA@mail.gmail.com>
 <SN4PR13MB572738F10FAE449DDBD735D686732@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEtHQHmhBAF6WguUSHr+iFMmOjvTshqpGzkvE=QtkgVVPA@mail.gmail.com>
 <SN4PR13MB5727AF7CB6E6CF563B618F1386732@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D5A7AD34F7169E2A236F86702@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CAJaqyWc2P6iHrG9dR2X9YC=P7dw4=Y2RwRkr5H81hkj6ej_5hA@mail.gmail.com>
In-Reply-To: <CAJaqyWc2P6iHrG9dR2X9YC=P7dw4=Y2RwRkr5H81hkj6ej_5hA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nephogine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3988:EE_|BY1PR13MB6576:EE_
x-ms-office365-filtering-correlation-id: 28624300-7714-4745-d692-08dc18dae8d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzuZgCzkfFSoXkXpFRh6nCObI5oRT9K+J01HZhT+uMJTUb5x/Auk+p9tYkN0NzNVLos/Ggr1WBCYvWLx8ioSi2Jnr2RbJ1xzIMO2bgImlYxley2+axn6eVmoo/X4u39x/rd3vHoVp9tvBSxW86A1uSJ9017Wtp2bVyXeJ8RI6tx7ZtDIXGh4QI6OseeoOMJC88N865o0ATC9ZPA/YHopWrTtgwn4sEng5tKvuM+IExPFmikVgxazuYbrOJo1OB6hfc+Xq2jOPEs8A8qFrIEJy1R7LPv56jUtIXDSOLrDY6rJqJQC31VTvb2dvCqTTiOEZ/qVWlZ5UP5Ac9TDYpGzGkDaXSfgz0QV0GIDGediN71xl7fxT2Xzf880uiiRJW00ndOnLkvp49kqKGsTLsVsUfjWXp16/eJVZbiDvdwjC0yr8aerJ1pDTsZRyZdFEbIYyqwRqesb2uua2I593DW//jloc1ewhOMa0JdeKHY5sLJJH8sZH6PheSVlXnyVlyIpOVkH54rjnUI9yWqD/YCf83j/ToCgYEQTmwN79J15xQ2oJRqCt7yk6P6CqO+lNGWvbS8ftq2JaPgQSexqxfoogY0c96BAd6M3YDqYYEwxsk+iKo0dO+tzTBEAo9wVs/08rUMjlXnOUGbrezz+fGXMp4MY+eg22B7IqY6pAqlveNE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR13MB3988.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(376002)(346002)(136003)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(6506007)(53546011)(26005)(83380400001)(966005)(38100700002)(5660300002)(66556008)(122000001)(4326008)(52536014)(8936002)(64756008)(2906002)(9686003)(41300700001)(478600001)(76116006)(110136005)(66476007)(316002)(54906003)(66446008)(66946007)(71200400001)(6636002)(33656002)(224303003)(86362001)(7696005)(38070700009)(55016003)(66899024)(550774002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWQvYTJUMWhpVEpDMXZsWks5ZVUxZU41aW5QZDJyVERoNzBOdlU2L1BMRVBW?=
 =?utf-8?B?bGZYeXgxZEZmWnpjbVVyNnhzdmRGbllISVd3ZDd5c0ZDdTlJb1E2UHhLUDRL?=
 =?utf-8?B?SG5ocXM5NlkrNkczRFNLdlplbmxyU3k4RTZYbG5xZ0VJbUkrdEtORTdILzk1?=
 =?utf-8?B?WXpKZ1BpdW1LN1FDQTdGTDZ4S25iNktJbWwzcGMwdzFlV1Fkc2VKVWd5emFl?=
 =?utf-8?B?ZEZuKzE4V1poUU1vaFg3a2MxVytNOXZaNHM3VVlrNDBncDduRHdKR1k3Unp0?=
 =?utf-8?B?cXlRZXk2U2t6V2FoMVQxSzM3ejAvbGQ5TkJNZkNjaGk2dlU4VUZiUDNnRHhU?=
 =?utf-8?B?UUpaL2t3MWVXZGszMElBalppeHZpRGR1c2xKbGhUNy9wL3RSdFUzK09LdUtG?=
 =?utf-8?B?Snk1eDdPbzVkdmlGa0VSU2NtSjlDUkZSQWZrbG80UTNaYm9EK1lodm01Ykwz?=
 =?utf-8?B?dHErMGNpdUxCZmNmNVBqUkd4SHlVK21SNTZyQ0J3N0R2SHh5OTVpZG5aWUE3?=
 =?utf-8?B?TzlSaXZqREF4R05ZRWZnSWNhMjlRZE4wNWVKSU5Ia0VvWW5JMTNYL0ovSy9o?=
 =?utf-8?B?bURIUlc3b3hhZWk2WUxsS0lHbjBCSUlkcVgwSll1VkpoQXRHd3kyRkxNcTZ1?=
 =?utf-8?B?YmFUKzBRZlIvR0tkQ0RoZTdlWE9wdUxyODVoNGdqUjRnNWxmdk5OVjczMkFt?=
 =?utf-8?B?YXVxcEcxWklnYlNXanBucjdDekpSa2dPd3VuUnl5RXI3WTlYTEJxS3JuZkhy?=
 =?utf-8?B?TUZLQ3NUdlF6L2xQaUFwbExxMGU1U1VQQUtRb3Avb3NJd1BKQU41aHFnd1Ax?=
 =?utf-8?B?dndsZkFDM2duemxXOE5iSzJoMkJ0OEFqTExxTC94ZThLSDN5aCs0R3FjYkR4?=
 =?utf-8?B?bk11M3k4L1UyYTVxcktwemx1UUp2YjZCQnhpSG1HLzAwdDh3L1pDUVpKdjBt?=
 =?utf-8?B?Vnh2T0FhY3VBSm9FZFpKa2E4L3Q1aVpqcUtTazFXclFPM1FJT2o1cWFpaVpJ?=
 =?utf-8?B?NlBCU3daMTFmOVRwMi9nTjNpTUx3TEttbDhlZkpwRFN0M1dZbHMvb0NtaDRO?=
 =?utf-8?B?dndKbHJ2d1hSMzNaRDY0Sk1zMVVGTklUSXBSQWIwaFZXY3MwYnovVjJkelRW?=
 =?utf-8?B?dFBTTitNdTZwcFBvVE5LbmU1Zk5YU1pCV3ZJSmx1Z1B5OWMzTjRqWnRqdVZ3?=
 =?utf-8?B?bjlBMUUwY3VGRno5MHBLeGdVUFQzUVhkdllLOWF4WTdKeHJFZmVsL3lqZENl?=
 =?utf-8?B?MThwbTJtZDRIbG03UHA2Ukt1b25tcUI3Q09ONTBJYUNJTmlPRW9zRnZZSkV0?=
 =?utf-8?B?aXJJR1JNOGJGcXppWFp2SjFGM1ZyRzBYWFRQa2Z1Sk83anFmZm5mSlNyWXJ0?=
 =?utf-8?B?dW5xSkN2TnZDRkJ4NTBXWEtqbjZyMzRzM2hCWitxTnBVRDRxVnFqbEs3V1d3?=
 =?utf-8?B?R2xONE1OYU1DcnZqWGQ0V1pJRjJHNFhjU3ZPQU5rSlczeGhRSjlDMWZqaWIy?=
 =?utf-8?B?aGxnNFNFeTg4a3ZMU1NUdTRhQnR6ZktNNENlR1pMeFpQNElZMllCODlOWmJ2?=
 =?utf-8?B?VXY0RkVlOUFMS0IzaVhoakpybW11amFBQ1F5WXBmQ2hLeVZ5a3I1SHlBSE1G?=
 =?utf-8?B?Yk1ZbllGd1FGTTR2NXhNUnIxUDNPYzZGMFc2YlFqMHNoVzM3dnhtNFJrdWU1?=
 =?utf-8?B?TGpLUTNTZE5zeXhXSTBLOHlPbkcwQ3RoVmZET01POEtDTWpJM1B4Ri81clNw?=
 =?utf-8?B?RmZtWE4zb2hnUWdIU0U2SWo1RzlUa1ZsMlQybnovZEpva0RWbjQ5Q0d4dlFa?=
 =?utf-8?B?TzZiSnZBQjc1ODllOWt4V0NoeWZrcDVyVS9LQUEySWNUNHFzTDF4MG5tMmpT?=
 =?utf-8?B?ZnlqdnFmTDdZYjV6K28rVDR6bFV0MFl4dldVZHM1MTFmQ0Exa25xekdIa04r?=
 =?utf-8?B?dkR3VWpoWDNzeEo3QzhCQmtoaGNyQjFIUUZGZW11cFAvUVhMN3hpcmk0V0hy?=
 =?utf-8?B?cnMvZlY2c1p4VlQzK2RkZHEwZitOTXhqMGppRzV1SEFnZC9ndDJCdjBVNm5M?=
 =?utf-8?B?cTVvQms1V1pMN3VGTUhYQ3NqNmxKQjJpc2dVTlFrMCtUd1ErYUdkNzJOMmps?=
 =?utf-8?B?SWxpamgzYXoyUmVBb2VPTlBnOFphd3BtRUs4cm9SUUNRa1JUd3lHdlRsNzRM?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nephogine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3988.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28624300-7714-4745-d692-08dc18dae8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 10:39:26.7630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sl7gLv0tP086QIrrPyHLayV/HR8Sw54jBV6vtNU1xd4Q7fgvzlfLhgyIKi2lrkk6063ZOG5tczrtNfRpqNl8raeF6zFnA9UIdP79g+PCFGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6576
Received-SPF: pass client-ip=40.107.236.100;
 envelope-from=zhaoyong.zhong@nephogine.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jan 2024 09:03:38 -0500
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

SGkgRXVnZW5pbywNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLiBWZXJ5IGhlbHBmdWwuIFdl
bnRhbyBhbmQgSSB3aWxsIGRpc2N1c3MgYW5kIGdldCBiYWNrIHRvIHlvdSBsYXRlci4NCg0KQWxz
byB3ZWxjb21lIGZvciBhbnkgY29tbWVudHMgZnJvbSBvdGhlciBndXlzLg0KDQpCZXN0IFJlZ2Fy
ZHMsDQpSaWNrIFpob25nDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogRXVn
ZW5pbyBQZXJleiBNYXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+IA0K5Y+R6YCB5pe26Ze0OiAy
MDI05bm0MeaciDE55pelIDE4OjI2DQrmlLbku7bkuro6IFdlbnRhbyBKaWEgPHdlbnRhby5qaWFA
bmVwaG9naW5lLmNvbT4NCuaKhOmAgTogcWVtdS1kZXZlbEBub25nbnUub3JnOyBtc3RAcmVkaGF0
LmNvbTsgUmljayBaaG9uZyA8emhhb3lvbmcuemhvbmdAbmVwaG9naW5lLmNvbT47IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+OyBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+OyBH
dW8gWmhpIDxxdHh1bmluZzE5OTlAc2p0dS5lZHUuY24+DQrkuLvpopg6IFJlOiBGVzogW1BBVENI
XSB2aG9zdC11c2VyOiBhZGQgVklSVElPX0ZfSU5fT1JERVIgYW5kIFZJUlRJT19GX05PVElGSUNB
VElPTl9EQVRBIGZlYXR1cmUNCg0KT24gRnJpLCBKYW4gMTksIDIwMjQgYXQgNzo0MuKAr0FNIFdl
bnRhbyBKaWEgPHdlbnRhby5qaWFAbmVwaG9naW5lLmNvbT4gd3JvdGU6DQo+DQo+DQo+IFZJUlRJ
T19GX0lOX09SREVSIGFuZCBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSBmZWF0dXJlIGFyZSBp
bXBvcnRhbnQgDQo+IGZlYXR1cmUgZm9yIGRwZGsgdmRwYSBwYWNrZXRzIHRyYW5zbWl0dGluZyBw
ZXJmb3JtYW5jZSwgYWRkIHRoZSAyIA0KPiBmZWF0dXJlcyBhdCB2aG9zdC11c2VyIGZyb250LWVu
ZCB0byBuZWdvdGlhdGlvbiB3aXRoIGJhY2tlbmQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEt5bGUg
WHUgPHpoZW5iaW5nLnh1QGNvcmlnaW5lLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogV2VudGFvIEpp
YSA8d2VudGFvLmppYUBjb3JpZ2luZS5jb20+DQo+IFJldmlld2VkLWJ5OiAgIFhpbnlpbmcgWXUg
PHhpbnlpbmcueXVAY29yaWdpbmUuY29tPg0KPiBSZXZpZXdlZC1ieTogICBTaHVqaW5nIERvbmcg
PHNodWppbmcuZG9uZ0Bjb3JpZ2luZS5jb20+DQo+IFJldmlld2VkLWJ5OiAgIFJpY2sgWmhvbmcg
PHpoYW95b25nLnpob25nQGNvcmlnaW5lLmNvbT4NCj4gLS0tDQo+ICBody9jb3JlL21hY2hpbmUu
YyAgIHwgMiArKw0KPiAgaHcvbmV0L3Zob3N0X25ldC5jICB8IDIgKysNCj4gIGh3L25ldC92aXJ0
aW8tbmV0LmMgfCA0ICsrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+
DQo+IGRpZmYgLS1naXQgYS9ody9jb3JlL21hY2hpbmUuYyBiL2h3L2NvcmUvbWFjaGluZS5jIGlu
ZGV4IA0KPiBmYjVhZmRjYWU0Li5lNjIwZjVlN2QwIDEwMDY0NA0KPiAtLS0gYS9ody9jb3JlL21h
Y2hpbmUuYw0KPiArKysgYi9ody9jb3JlL21hY2hpbmUuYw0KPiBAQCAtNDAsNiArNDAsNyBAQCBH
bG9iYWxQcm9wZXJ0eSBod19jb21wYXRfOF8xW10gPSB7DQo+ICAgICAgeyAicmFtZmIiLCAieC1t
aWdyYXRlIiwgIm9mZiIgfSwNCj4gICAgICB7ICJ2ZmlvLXBjaS1ub2hvdHBsdWciLCAieC1yYW1m
Yi1taWdyYXRlIiwgIm9mZiIgfSwNCj4gICAgICB7ICJpZ2IiLCAieC1wY2llLWZsci1pbml0Iiwg
Im9mZiIgfSwNCj4gKyAgICB7IFRZUEVfVklSVElPX05FVCwgIm5vdGlmaWNhdGlvbl9kYXRhIiwg
Im9mZiJ9LA0KPiAgfTsNCg0KQXNzdW1pbmcgdGhlIGRlZmF1bHQgInRydWUiIGluDQpody9uZXQv
dmlydGlvLW5ldC5jOnZpcnRpb19uZXRfcHJvcGVydGllcyBpcyB2YWxpZCwgdGhpcyBuZWVkcyB0
byBiZSBhcHBlbmRlZCB0byB0aGUgYXJyYXkgb2YgdGhlIFFFTVUgdmVyc2lvbiB0aGF0IGludHJv
ZHVjZWQgdGhlIHByb3BlcnR5IGluIHRoZSB2aXJ0aW9fbmV0X3Byb3BlcnRpZXMgYXJyYXksIG5v
dCB0aGUgb25lIHRoYXQgaW1wb3J0ZWQgdGhlIG1hY3JvIGZyb20gdGhlIGtlcm5lbC4gVGhpcyBh
bGxvd3MgUUVNVSB0byBrbm93IHRoYXQgb2xkIHZlcnNpb25zIGhhdmUgdGhlc2UgZmVhdHVyZXMg
ZGlzYWJsZWQgYWx0aG91Z2ggdGhlIGRlZmF1bHQgc2V0IGluIGh3L25ldC92aXJ0aW8tbmV0LmM6
dmlydGlvX25ldF9wcm9wZXJ0aWVzIGlzIHRydWUgd2hlbiBtaWdyYXRpbmcgZnJvbSAvIHRvIHRo
ZXNlIHZlcnNpb25zLg0KDQpZb3UgY2FuIGNoZWNrIHRoYXQgdGhpcyBpcyBhZGRlZCBwcm9wZXJs
eSBieSBtaWdyYXRpbmcgZnJvbSAvIHRvIGEgcHJldmlvdXMgdmVyc2lvbiBvZiBRRU1VLCB3aXRo
IHRoZSBjb21iaW5hdGlvbnMgb2YgdHJ1ZSBhbmQgZmFsc2UuDQoNCllvdSBoYXZlIGFuIGV4YW1w
bGUgaW4gWzFdIHdpdGggYmxrIGRldmljZXMgbXVsdGlxdWV1ZS4gQ0NpbmcgUGV0ZXIgWHUgYXMg
aGUga25vd3MgbW9yZSB0aGFuIG1lIGFib3V0IHRoaXMuDQoNClRoaXMgaXMgdmVyeSBlYXN5IHRv
IG1pc3Mgd2hlbiBhZGRpbmcgbmV3IGZlYXR1cmVzLiBTb21lYm9keSB3aG8ga25vd3MgcGVybCBz
aG91bGQgYWRkIGEgdGVzdCBpbiBjaGVja3BhdGgucGwgc2ltaWxhciB0byB0aGUgd2FybmluZyAi
YWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVw
ZGF0aW5nPyIgd2hlbiB2aXJ0aW8gcHJvcGVydGllcyBhcmUgbW9kaWZpZWQgOikuDQoNCj4gIGNv
bnN0IHNpemVfdCBod19jb21wYXRfOF8xX2xlbiA9IEdfTl9FTEVNRU5UUyhod19jb21wYXRfOF8x
KTsNCj4NCj4gQEAgLTY1LDYgKzY2LDcgQEAgR2xvYmFsUHJvcGVydHkgaHdfY29tcGF0XzdfMVtd
ID0gew0KPiAgICAgIHsgInZpcnRpby1ybmctcGNpIiwgInZlY3RvcnMiLCAiMCIgfSwNCj4gICAg
ICB7ICJ2aXJ0aW8tcm5nLXBjaS10cmFuc2l0aW9uYWwiLCAidmVjdG9ycyIsICIwIiB9LA0KPiAg
ICAgIHsgInZpcnRpby1ybmctcGNpLW5vbi10cmFuc2l0aW9uYWwiLCAidmVjdG9ycyIsICIwIiB9
LA0KPiArICAgIHsgVFlQRV9WSVJUSU9fTkVULCAiaW5fb3JkZXIiLCAib2ZmIn0sDQo+ICB9Ow0K
PiAgY29uc3Qgc2l6ZV90IGh3X2NvbXBhdF83XzFfbGVuID0gR19OX0VMRU1FTlRTKGh3X2NvbXBh
dF83XzEpOw0KPg0KPiBkaWZmIC0tZ2l0IGEvaHcvbmV0L3Zob3N0X25ldC5jIGIvaHcvbmV0L3Zo
b3N0X25ldC5jIGluZGV4IA0KPiBlOGUxNjYxNjQ2Li4yMTFjYTg1OWE2IDEwMDY0NA0KPiAtLS0g
YS9ody9uZXQvdmhvc3RfbmV0LmMNCj4gKysrIGIvaHcvbmV0L3Zob3N0X25ldC5jDQo+IEBAIC03
Niw2ICs3Niw4IEBAIHN0YXRpYyBjb25zdCBpbnQgdXNlcl9mZWF0dXJlX2JpdHNbXSA9IHsNCj4g
ICAgICBWSVJUSU9fRl9JT01NVV9QTEFURk9STSwNCj4gICAgICBWSVJUSU9fRl9SSU5HX1BBQ0tF
RCwNCj4gICAgICBWSVJUSU9fRl9SSU5HX1JFU0VULA0KPiArICAgIFZJUlRJT19GX0lOX09SREVS
LA0KPiArICAgIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBLA0KPiAgICAgIFZJUlRJT19ORVRf
Rl9SU1MsDQo+ICAgICAgVklSVElPX05FVF9GX0hBU0hfUkVQT1JULA0KPiAgICAgIFZJUlRJT19O
RVRfRl9HVUVTVF9VU080LA0KPiBkaWZmIC0tZ2l0IGEvaHcvbmV0L3ZpcnRpby1uZXQuYyBiL2h3
L25ldC92aXJ0aW8tbmV0LmMgaW5kZXggDQo+IDdhMjg0NmZhMWMuLmRjMGEwMjg5MzQgMTAwNjQ0
DQo+IC0tLSBhL2h3L25ldC92aXJ0aW8tbmV0LmMNCj4gKysrIGIvaHcvbmV0L3ZpcnRpby1uZXQu
Yw0KPiBAQCAtMzk0OSw2ICszOTQ5LDEwIEBAIHN0YXRpYyBQcm9wZXJ0eSB2aXJ0aW9fbmV0X3By
b3BlcnRpZXNbXSA9IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fTkVUX0ZfR1VF
U1RfVVNPNiwgdHJ1ZSksDQo+ICAgICAgREVGSU5FX1BST1BfQklUNjQoImhvc3RfdXNvIiwgVmly
dElPTmV0LCBob3N0X2ZlYXR1cmVzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19O
RVRfRl9IT1NUX1VTTywgdHJ1ZSksDQo+ICsgICAgREVGSU5FX1BST1BfQklUNjQoImluX29yZGVy
IiwgVmlydElPTmV0LCBob3N0X2ZlYXR1cmVzLA0KPiArICAgICAgICAgICAgICAgICAgICAgIFZJ
UlRJT19GX0lOX09SREVSLCB0cnVlKSwNCj4gKyAgICBERUZJTkVfUFJPUF9CSVQ2NCgibm90aWZp
Y2F0aW9uX2RhdGEiLCBWaXJ0SU9OZXQsIGhvc3RfZmVhdHVyZXMsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgVklSVElPX0ZfTk9USUZJQ0FUSU9OX0RBVEEsIHRydWUpLA0KDQpUaGlzIGRlZmF1
bHQ9dHJ1ZSBpcyB3cm9uZywgYW5kIG1ha2VzIGVtdWxhdGVkIGRldmljZXMgc2hvdyB0aGVzZSBm
ZWF0dXJlcyBhcyBhdmFpbGFibGUgd2hlbiB0aGV5J3JlIG5vdC4gWW91IGNhbiB0ZXN0IGl0IGJ5
IHJ1bm5pbmcgcWVtdSB3aXRoIHRoZSBwYXJhbWV0ZXJzOg0KDQotbmV0ZGV2IHRhcCxpZD1ob3N0
bmV0MCx2aG9zdD1vZmYgLWRldmljZSB2aXJ0aW8tbmV0LXBjaSxuZXRkZXY9aG9zdG5ldDAsLi4u
DQoNClRoZSBlbXVsYXRlZCBkZXZpY2UgbXVzdCBzdXBwb3J0IGJvdGggZmVhdHVyZXMgYmVmb3Jl
IG1ha2luZyB0aGVtIHR1bm5hYmxlcy4NCg0KT24gdGhlIG90aGVyIGhhbmQsIGFsbCBraW5kcyBv
ZiB2aXJ0aW8gZGV2aWNlcyBjYW4gdXNlIGluX29yZGVyIGFuZCBub3RpZmljYXRpb25fZGF0YSwg
c28gdGhleSBzaG91bGQgYmUgaW4gaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLmg6REVGSU5FX1ZJ
UlRJT19DT01NT05fRkVBVFVSRVMuIEJ1dCBub3QgYWxsIG9mIHRoZW0gYmVuZWZpdCBmcm9tIGlu
X29yZGVyLiBPbmUgZXhhbXBsZSBvZiB0aGlzIGlzIHZpcnRpby1ibGsuIEl0IGlzIHVzdWFsIHRo
YXQgcmVxdWVzdHMgYXJlIGNvbXBsZXRlZCBvdXQgb2Ygb3JkZXIgYnkgdGhlIGJhY2tlbmQgZGV2
aWNlLCBzbyBteSBpbXByZXNzaW9uIGlzIHRoYXQgaW5fb3JkZXIgd2lsbCBodXJ0IGl0cyBwZXJm
b3JtYW5jZS4NCkkndmUgbmV2ZXIgcHJvZmlsZWQgaXQgdGhvdWdoLCBzbyBJIG1heSBiZSB3cm9u
ZyA6KS4NCg0KTG9uZyBzdG9yeSBzaG9ydDogTWF5YmUgaW5fb3JkZXIgc2hvdWxkIGJlIGZhbHNl
IGJ5IGRlZmF1bHQsIGFuZCBlbmFibGVkIGp1c3QgaW4gdmlydGlvLW5ldD8NCg0KWW91IGNhbiBz
ZWUgcHJldmlvdXMgYXR0ZW1wdHMgb2YgaW1wbGVtZW50aW5nIHRoaXMgZmVhdHVyZSBpbiBxZW11
IGluIFsyXS4gQ0NpbmcgR3VvIHRvbywgYXMgSSBkb24ndCBrbm93IGlmIGhlIHBsYW5zIHRvIGNv
bnRpbnVlIHRoaXMgd29yayBzb29uLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IG5lZWQg
YW55IGhlbHAgd2l0aCB0aGVzZSENCg0KVGhhbmtzIQ0KDQpbMV0gaHR0cHM6Ly93d3cucWVtdS5v
cmcvZG9jcy9tYXN0ZXIvZGV2ZWwvbWlncmF0aW9uL2NvbXBhdGliaWxpdHkuaHRtbCNob3ctYmFj
a3dhcmRzLWNvbXBhdGliaWxpdHktd29ya3MNClsyXSBodHRwczovL2xpc3RzLmdudS5vcmcvYXJj
aGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMi0wOC9tc2cwMjc3Mi5odG1sDQoNCj4gICAgICBERUZJ
TkVfUFJPUF9FTkRfT0ZfTElTVCgpLA0KPiAgfTsNCj4NCj4gLS0NCj4NCg0K

