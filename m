Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE0DA98A72
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Apr 2025 15:07:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Znp-0004P4-5v; Wed, 23 Apr 2025 09:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1353455048@qq.com>) id 1u7YRO-0006Xq-57
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:39:00 -0400
Received: from out203-205-221-192.mail.qq.com ([203.205.221.192])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1353455048@qq.com>) id 1u7YRI-00045b-0g
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1745408320; bh=3ElvOJBxgrmk7H5c01CjFiHAt0XU2kvXBzqmG3aLgYo=;
 h=From:To:Subject:Date;
 b=aAhKh6debIS/hch9mTo3QhpxPEBAvs6WvmefVlhsjN6cWBBaI9pUbWf9TCAo4HQqt
 hj6nLYmx+JkBPi11nBU2UZlV9Z8IsEsk+J3QMyUSjpZWvGpDQlWJvIi5Vf1V0CT41y
 Qj57lrCgGryTyTAJfRVFk8bZRQz+8FUnPvADtYfk=
X-QQ-FEAT: 8OvYDnhju3PqhIVSBrBmi1ogJEMTgH+X
X-QQ-SSF: 0000000000000050000000000000
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-XMAILINFO: NmRXuBzsYFPwz19L7d2MI/PpvLPKqES01pf3VlZvmNI5sGZGeqh6vyrvv8eSSa
 0zoZzCqcIP4ups4EBT6uI756z3sNDKn98I8NsljbFrhhWYvgMlK9ND69cHo1RoWunXYYty7QFwuxt
 JEP38KxD8dVmKj/v2/Mr1AM7fplXJ21U4qj0sNZtPfw6YaHasqof+G1DhCoy/JQHhw7Az/e9jowMk
 QP5ZorC4xByUKmkehwtvzHeuibDRT+MEgBVcO7pd8ZIN5MMrVwwdRdmYTSKYlGfd5sNfTaWYqZFKl
 3y9RnnroC9MmrCMYljDz3dEousgjoYcaEiwU4b5qA8oiZjBpUyYH3XUCDOC6a9pduwDpYZVGpTpwA
 l60SbgjdvxYqRCgAkIFujrKkOHW1nO3My+ZVDCI6aPwhAjbH2NSUfTKlq9MUu8iJiQIZBxy23zpAa
 P/93Xgttm8+F2T8/kSQrxWQYnjR7H8Ca4mOCWUlllFAn9aH8nyHGnAulm948s5GMqXnhhd8QsCI1M
 O01WW6ThwYz9HxnA0qUn4jMEchanse89ZCkbM8yIS4Jqac+edo8J7DOeGXOU3pnlGDrCaE1Xt70fS
 7vbcCa9YuTFwBGjIXSvY+w8P+FxmXOrdZI3VCUqcx531Wsh5Yx5xkVBM8T+IPHdvLJrRa9fKUfagg
 fZO1S3MJomHnFyHNPh2rlNtIpKh2CheN9LCww7Tsmtj4seIwb9wo6CwMOrESfD2X2Gp9a8HqHSSKB
 WDm6Zrz09xCLXGJP1QHRaZa+HiJn1/iYOYa/ns4antUuBRnnPNwh4w20qXGG5s5RthWVz//v49zcb
 SvpmnTUMSw6r9leJvptb3Ys4DpKEKp7rKw4JXXyL6nGhWdc+sjbJhS0/H7/iwFXEedbWRtMnvx0w+
 Nv+6HlZnj0hV2jl+myuPr8aanLEf0M8GSMVrS1D+syyapfQvqu0ImaeApFkoPRYQoItFXUJzZgzS3
 b0zvSpRzqDBf/z5fjmNwQTp2L3YVxygDygyipaeA==
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 202.175.25.135
X-QQ-STYLE: 
X-QQ-mid: webmail374t1745407865t6626610
From: "=?gb18030?B?0KHC7b7U?=" <1353455048@qq.com>
To: "=?gb18030?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Subject: Whether the qemu mps2-an385 model support getchar?
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_6808CF79_190920F0_06E9476A"
Content-Transfer-Encoding: 8Bit
Date: Wed, 23 Apr 2025 19:31:05 +0800
X-Priority: 3
Message-ID: <tencent_6CC3332A93DC02BE2030AB5BC0E63B10B808@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
Received-SPF: pass client-ip=203.205.221.192; envelope-from=1353455048@qq.com;
 helo=out203-205-221-192.mail.qq.com
X-Spam_score_int: 43
X-Spam_score: 4.3
X-Spam_bar: ++++
X-Spam_report: (4.3 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, HTML_MESSAGE=0.001, NO_FM_NAME_IP_HOSTN=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Apr 2025 09:06:04 -0400
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

This is a multi-part message in MIME format.

------=_NextPart_6808CF79_190920F0_06E9476A
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64

V2hlbiBJIHVzZSBtcHMyLWFuMzg1IG1vZGVsIG9uIHFlbXUsIEkgZm91bmQgdGhhdCBpdCBz
ZWVtcyBub3Qgc3VwcG9ydCBnZXRjaGFyLiBJIHVzZWQgdGhlIEZyZWVSVE9TIG9mZmljaWFs
IGRlbW8obXBzMi1hbjM4NS1HQ0MtUUVNVSksIHRoZW4gSSB0cmllZCB0byB1c2UgVUFSVCZu
YnNwOyB0byByZWNlaXZlIGlucHV0IHN0cmluZ3MgZnJvbSBRRU1VIHRlcm1pbmFsLCBzbyBJ
IHRyaWVkIHRvIHVzZSBnZXRjaGFyKCkgZnVuY3Rpb24uIEhvd2V2ZXIsIHNvbWUgZXJyb3Jz
IG9jY3VycmVkIGluIFFFTVUgYXMgc2hvd24gYmVsb3c6DQpxZW11OiBmYXRhbDogTG9ja3Vw
OiBjYW4ndCBlc2NhbGF0ZSAzIHRvIEhhcmRGYXVsdCAoY3VycmVudCBwcmlvcml0eSAtMSkN
CklzIGl0IG1lYW5zIHRoZXJlIGFyZSBzb21ldGhpbmcgd3JvbmcgaW4gdGhlIGVtdWxhdGVk
IGJvYXJkPyBBbmQgaG93IHRvIHNvbHZlIHRoZSBwcm9ibGVtPw0KDQoNCg0KDQombmJzcDs=

------=_NextPart_6808CF79_190920F0_06E9476A
Content-Type: text/html;
	charset="gb18030"
Content-Transfer-Encoding: base64

PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNo
YXJzZXQ9R0IxODAzMCI+PGRpdj5XaGVuIEkgdXNlIG1wczItYW4zODUgbW9kZWwgb24gcWVt
dSwgSSBmb3VuZCB0aGF0IGl0IHNlZW1zIG5vdCBzdXBwb3J0IGdldGNoYXIuIEkgdXNlZCB0
aGUgRnJlZVJUT1Mgb2ZmaWNpYWwgZGVtbyhtcHMyLWFuMzg1LUdDQy1RRU1VKSwgdGhlbiBJ
IHRyaWVkIHRvIHVzZSBVQVJUJm5ic3A7IHRvIHJlY2VpdmUgaW5wdXQgc3RyaW5ncyBmcm9t
IFFFTVUgdGVybWluYWwsIHNvIEkgdHJpZWQgdG8gdXNlIGdldGNoYXIoKSBmdW5jdGlvbi4g
SG93ZXZlciwgc29tZSBlcnJvcnMgb2NjdXJyZWQgaW4gUUVNVSBhcyBzaG93biBiZWxvdzo8
YnI+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMjA0LCAyMDQsIDIwNCk7IGZvbnQtZmFtaWx5
OiAmcXVvdDtTZWdvZSBXUEMmcXVvdDssICZxdW90O1NlZ29lIFVJJnF1b3Q7LCAmcXVvdDtN
aWNyb3NvZnQgWWFIZWkmcXVvdDssIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTNweDsgYmFj
a2dyb3VuZC1jb2xvcjogcmdiKDI0LCAyNCwgMjQpOyI+cWVtdTogZmF0YWw6IExvY2t1cDog
Y2FuJ3QgZXNjYWxhdGUgMyB0byBIYXJkRmF1bHQgKGN1cnJlbnQgcHJpb3JpdHkgLTEpPC9z
cGFuPjwvZGl2PjxkaXY+SXMgaXQgbWVhbnMgdGhlcmUgYXJlIHNvbWV0aGluZyB3cm9uZyBp
biB0aGUgZW11bGF0ZWQgYm9hcmQ/IEFuZCBob3cgdG8gc29sdmUgdGhlIHByb2JsZW0/PC9k
aXY+PGRpdj48aHIgYWxpZ249ImxlZnQiIHN0eWxlPSJtYXJnaW46IDAgMCAxMHB4IDA7Ym9y
ZGVyOiAwO2JvcmRlci1ib3R0b206MXB4IHNvbGlkICNFNEU1RTY7aGVpZ2h0OjA7bGluZS1o
ZWlnaHQ6MDtmb250LXNpemU6MDtwYWRkaW5nOiAyMHB4IDAgMCAwO3dpZHRoOiA1MHB4OyI+
PGRpdiBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC1mYW1pbHk6VmVyZGFuYTtjb2xvcjoj
MDAwOyI+PGEgY2xhc3M9InhtX3dyaXRlX2NhcmQiIGlkPSJpbl9hbGlhcyIgc3R5bGU9Indo
aXRlLXNwYWNlOiBub3JtYWw7IGRpc3BsYXk6IGlubGluZS1ibG9jazsgdGV4dC1kZWNvcmF0
aW9uOiBub25lICFpbXBvcnRhbnQ7Zm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sQmxpbmtN
YWNTeXN0ZW1Gb250LFBpbmdGYW5nIFNDLE1pY3Jvc29mdCBZYUhlaTsiIGhyZWY9Imh0dHBz
Oi8vd3gubWFpbC5xcS5jb20vaG9tZS9pbmRleD90PXJlYWRtYWlsX2J1c2luZXNzY2FyZF9t
aWRwYWdlJmFtcDtub2NoZWNrPXRydWUmYW1wO25hbWU9JUU1JUIwJThGJUU5JUE5JUFDJUU5
JUE5JUI5JmFtcDtpY29uPWh0dHAlM0ElMkYlMkZ0aGlyZHFxLnFsb2dvLmNuJTJGZyUzRmIl
M0RvaWRiJTI2ayUzRFh3aWJ5bU8zcDlscUhEZGlhcmI2N250QSUyNmt0aSUzRFpVLWNyQUFB
QUFBJTI2cyUzRDY0MCUyNnQlM0QxNTU3MjY5NzE1JmFtcDttYWlsPTEzNTM0NTUwNDglNDBx
cS5jb20mYW1wO2NvZGU9VHVrM0dpMUtua20ydVN1WGZmTHVuV1oyMy1iQWd1Q3M0WnNXcEN2
SkpqaDQ0bnJlMEhNMGdnMjJsakVyUEtJLWZYMGV1TVd3RFVNajJ3dGw3ckpUR1EiIHRhcmdl
dD0iX2JsYW5rIj48YnI+PC9hPjwvZGl2PjwvZGl2PjxkaXY+Jm5ic3A7PC9kaXY+

------=_NextPart_6808CF79_190920F0_06E9476A--


