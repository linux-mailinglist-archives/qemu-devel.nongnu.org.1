Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C1C812D29
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 11:38:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDj61-0000AU-CG; Thu, 14 Dec 2023 05:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1rDj5z-0000AI-69
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 05:37:35 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1rDj5u-0002XB-TV
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 05:37:34 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com A121AC0009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1702550243; bh=N5/Y0EIYWCbMdr/bm/D96C0zftFcSjbSOmFYJ7dU2hY=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=cy27L+BT4AUCTLmMhOCxHQvBSB0b+c8IIpKiUbxHfNa7VDRzgaZpnmyPdA/3gQfTH
 6dE4mXNeZUDu0k4VQaiUMG/1rT4QD2wtjjCMD6kTlupGtv7oCWk3wzOd8S+KyCZJEI
 qv+pSe25XD1O9FngPSE+UEvE/tPaCRfzIMz5T/AlEhheZMHA9F+zdA2CRp76X+ebM9
 R6rLN/NiuX88pWkDyM2YowgwePtXt92elquFEfz2MRv6HBIsC8jLChD0Veu0flAZ4G
 56rRtFJrQKMci0RA8kfUyK1dS1JkYRYBhRGfK/RMhtw66jC73eUjtEQof6wsTa2jKu
 MQxf/+YetTtYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1702550243; bh=N5/Y0EIYWCbMdr/bm/D96C0zftFcSjbSOmFYJ7dU2hY=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=mrUnEzjcbh3anad/VlqN5MjSQ027GwgRvdqNtoM/XoSfuJsBqCct0KhxltfXfSvLu
 n/MzkdsbmLEwPKG/TsUabDOAW5mfRNQrVx848lbs7hsAYjC0K26CxHcKGrTikfXf7g
 eLjDuo7RATxhRmukzL6AsJCYJtnw6D14y/63ypzNuuHqLJ+vQdTyO8g14tzDobR8Cb
 CraecTOa90KqLw5xWxcE0KoAcpsSPn1C/kuPkGmgidTcumwwG5B8NyiCennTUh4F4w
 xCcP61w6x7niQW26nJTiAR5flqrLn3+ns5d1IMxbWdheI4xSRij2K3upE9250cZ6BZ
 TET8+eLlnDn3Q==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: RE: [PATCH] accel/tcg: Expose translation block flags to plugins
Thread-Topic: [PATCH] accel/tcg: Expose translation block flags to plugins
Thread-Index: AQHaHT3TrjAfLTNeO062RegvgZAvHbClsYKLgAMBaIA=
Date: Thu, 14 Dec 2023 10:37:22 +0000
Message-ID: <17a36db2c85e46b9bcb380eb6d1f4667@yadro.com>
References: <20231122121655.20818-1-m.tyutin@yadro.com>
 <87edfrd2yw.fsf@draig.linaro.org>
In-Reply-To: <87edfrd2yw.fsf@draig.linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=89.207.88.248; envelope-from=m.tyutin@yadro.com;
 helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQWxleCwNCg0KPiA+IEV4cG9zaW5nIGFwcHJvcHJpYXRlIHRyYW5zbGF0aW9uIGJsb2NrIGZs
YWcgYWxsb3dzIHBsdWdpbnMgdG8NCj4gPiBoYW5kbGUgIm1lbW9yeSBvbmx5IiBibG9ja3MgaW4g
YXBwcm9wcmlhdGUgd2F5Lg0KPiANCj4gV2UgZG9uJ3Qgd2FudCB0byBleHBvc2UgaW50ZXJuYWwg
ZGV0YWlscyB0byB0aGUgcGx1Z2luLiBJdCBzaG91bGRuJ3QNCj4gbmVlZCB0byBjYXJlLg0KPiAN
Cj4gRG8geW91IGhhdmUgYSB0ZXN0IGNhc2Ugd2hlcmUgeW91IG1pc3NlZCBjb3VudGluZyB0aGUg
ZXhlY3V0aW9uIG9mIHRoZQ0KPiBpbnN0cnVjdGlvbj8NCg0KVG8gc3BlZWR1cCBwbHVnaW4gZXhl
Y3V0aW9uIHRpbWUgd2Ugd2FudCB0byBzaGlmdCBwcm9jZXNzaW5nIGxvZ2ljIHRvDQpibG9jayB0
cmFuc2xhdGlvbiBwaGFzZSBhbmQga2VlcCBleGVjdXRpb24gY2FsbGJhY2sgbGlnaHQuIEFsc28g
bW92aW5nDQppbnN0cnVtZW50YXRpb24gYXQgYmxvY2sgbGV2ZWwgYXMgb3Bwb3NpdGUgdG8gaW5z
dHJ1Y3Rpb24gbGV2ZWwsIGhlbHBzDQp0byBzcGVlZHVwIHVwIGV4ZWN1dGlvbiBhcyB3ZWxsLg0K
DQpHaXZlbiB0aGF0LCB3ZSBwcmVwYXJlIHN0cnVjdHVyZXMgaW4gdHJhbnNsYXRpb24gY2FsbGJh
Y2suIEZvciBleGFtcGxlOg0KDQp2b2lkIGhhbmRsZUJsb2NrVHJhbnNsYXRpb24ocWVtdV9wbHVn
aW5faWRfdCwgcWVtdV9wbHVnaW5fdGIqIHRibG9jaykNCnsNCiAgICBCbG9ja1N0YXRzKiBzID0g
bmV3IEJsb2NrU3RhdHMoKTsNCiAgICBzLT5pbml0KHRibG9jayk7DQogICAgZ19zdGF0cy0+YXBw
ZW5kKHMpOw0KDQogICAgLyogVGhlbiwgaW5zZXJ0IGV4ZWN1dGlvbiBjYWxsYmFja3MgYW5kIHBh
c3MgQmxvY2tTdGF0cyBhcw0KICAgICAgIHVzZXJkYXRhIGZvciBxdWljayBkYXRhIGxvb2t1cCBp
biBydW4gdGltZSBhdDoNCiAgICAgICAgMSkgYmFzaWMgYmxvY2sgcHJvbG9ndWU6DQogICAgICAg
ICAgIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX3ZjcHVfdGJfZXhlY19jYih0YmxvY2ssIGNiLCBmbGFn
cywgcyk7DQogICAgICAgIDIpIG1lbW9yeSBsb2FkL3N0b3JlOg0KICAgICAgICAgICBxZW11X3Bs
dWdpbl9yZWdpc3Rlcl92Y3B1X21lbV9jYih0YmxvY2ssIGNiLCBmbGFncywNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtX2ZsYWdzLCBzKTsNCiAgICAqLw0K
fQ0KDQoNCkhhdmluZyBhcnRpZmljaWFsICJtZW0gb25seSIgYmxvY2sgbGVhZHMgdG8gYWxsb2Nh
dGlvbiBvZiBuZXcNCkJsb2NrU3RhdHMgYW5kIG1lbW9yeSBhY2Nlc3Mgd2lsbCBiZSBhdHRyaWJ1
dGVkIHRvIHRoYXQgYmxvY2sgaW5zdGVhZA0Kb2YgIm9yaWdpbmFsIiBvbmUgd2hpY2ggaXMgc3Vw
cG9zZWQgdG8gYmUgZXhlY3V0ZWQuIElmIHdlIGtub3cgdGhhdA0KYmxvY2sgaXMgIm1lbSBvbmx5
IiBvbiB0cmFuc2xhdGlvbiBwaGFzZSwgdGhlbiBtZW1vcnkgY2FsbGJhY2sgaXMNCmltcGxlbWVu
dGVkIGRpZmZlcmVudGx5IHRvIGZpbmQgcmVsZXZhbnQgQmxvY2tTdGF0cy4NCg0KLS0NCk1pa2hh
aWwNCg==

