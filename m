Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A747D6EBB
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:32:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveu7-0005sb-K6; Wed, 25 Oct 2023 10:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexeikaptur@yandex.ru>)
 id 1qvetp-0005pP-Qp; Wed, 25 Oct 2023 10:30:23 -0400
Received: from forward400c.mail.yandex.net ([2a02:6b8:c03:500:1:45:d181:db01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexeikaptur@yandex.ru>)
 id 1qvetk-0003GZ-SX; Wed, 25 Oct 2023 10:30:21 -0400
Received: from mail-nwsmtp-mxback-production-main-30.sas.yp-c.yandex.net
 (mail-nwsmtp-mxback-production-main-30.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:5328:0:640:d21c:0])
 by forward400c.mail.yandex.net (Yandex) with ESMTP id A1F336ED11;
 Wed, 25 Oct 2023 17:30:08 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c14:521b:0:640:6829:0
 [2a02:6b8:c14:521b:0:640:6829:0])
 by mail-nwsmtp-mxback-production-main-30.sas.yp-c.yandex.net (mxback/Yandex)
 with HTTP id 0UQQHv1U50U0-TX1Ar9yT; Wed, 25 Oct 2023 17:30:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1698244208; bh=ut59wcUMGfOTobDaoQJjaCmRPrli6dBzBpwf+wbwSa4=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=SUGhHbC8Rjpypyo7JMNPQQP2wrZKQI/rU2bLv5UHjuIMfNkQ9eEJ2uXXTgr5gAciY
 6obu3G6oQYW6PxIuGlQ/CvWvVvL7Q7nQi1paTam86PtpHEzqb/ule0BP7Dn3Yg5+HP
 +osWWWQsTIPMpL0oZD10q3cMYAKEa0xORGfE4MpA=
Authentication-Results: mail-nwsmtp-mxback-production-main-30.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by wghtu3g6gefsiaug.sas.yp-c.yandex.net with HTTP;
 Wed, 25 Oct 2023 17:30:08 +0300
From: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0JrQsNC/0YLRg9GA?= <alexeikaptur@yandex.ru>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alexey Kaptur <alexey.kaptur@kaspersky.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH] net,can: fix sja1000 IER behavior
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Wed, 25 Oct 2023 17:30:08 +0300
Message-Id: <239631698240490@mail.yandex.ru>
Content-Transfer-Encoding: base64
Content-Type: text/html; charset=utf-8
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:db01;
 envelope-from=alexeikaptur@yandex.ru; helo=forward400c.mail.yandex.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

PGRpdj48ZGl2PjxkaXY+V2l0aG91dCB0aGlzIHBhdGNoIGRpc2FibGluZyBpbnRlcnJ1cHRzIHRo
cm91Z2g8L2Rpdj48ZGl2PklFUiAoSW50ZXJydXB0IEVuYWJsZSBSZWdpc3RlcikgZG9lc24ndCB3
b3JrLDwvZGl2PjxkaXY+YmVjYXVzZSBpbnRlcnJ1cHQgc3RhdHVzIGlzIGNoYW5nZWQgb25seSBv
bjwvZGl2PjxkaXY+bmV4dCBTSkFfQ01SIHdyaXRlIG9yIFNKQV9JUiByZWFkaW5nLjwvZGl2Pjxk
aXY+VGhpcyBiZWhhdmlvciBkb2Vzbid0IGFmZmVjdCBMaW51eCBrZXJuZWw8L2Rpdj48ZGl2PmJl
Y2F1c2UgaGFuZGxpbmcgaXMgZG9uZSBpbnRvIGludGVycnVwdDwvZGl2PjxkaXY+Y29udGV4dCwg
bm90IGluIGJvdHRvbSBoYWxmLjwvZGl2PjxkaXY+SSB0cmllZCB0byB1c2UgYm90dG9tIGhhbGYg
YW5kIGdvdCBpbnRlcnJ1cHQ8L2Rpdj48ZGl2PnN0b3JtIGFmdGVyIG1hc2tpbmcgSVJRLjwvZGl2
PjxkaXY+U28gdGhpcyBwYXRjaCBmaXhlcyB0aGF0IGJlaGF2aW9yLjwvZGl2PjxkaXY+wqA8L2Rp
dj48ZGl2PlNpZ25lZC1vZmYtYnk6IEFsZXhleSBLYXB0dXIgJmx0O0FsZXhleS5LYXB0dXJAa2Fz
cGVyc2t5LmNvbSZndDs8L2Rpdj48ZGl2Pi0tLS08L2Rpdj48L2Rpdj7CoGh3L25ldC9jYW4vY2Fu
X3NqYTEwMDAuYyB8IDEgKzxkaXY+wqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyk8L2Rp
dj48ZGl2PsKgPC9kaXY+PGRpdj5kaWZmIC0tZ2l0IGEvaHcvbmV0L2Nhbi9jYW5fc2phMTAwMC5j
IGIvaHcvbmV0L2Nhbi9jYW5fc2phMTAwMC5jPC9kaXY+PGRpdj5pbmRleCA3MzIwMWY5MTM5Li5i
ZmFiMTRkZTEwIDEwMDY0NDwvZGl2PjxkaXY+LS0tIGEvaHcvbmV0L2Nhbi9jYW5fc2phMTAwMC5j
PC9kaXY+PGRpdj4rKysgYi9ody9uZXQvY2FuL2Nhbl9zamExMDAwLmM8L2Rpdj48ZGl2PkBAIC01
NDEsNiArNTQxLDcgQEAgdm9pZCBjYW5fc2phX21lbV93cml0ZShDYW5TSkExMDAwU3RhdGUgKnMs
IGh3YWRkciBhZGRyLCB1aW50NjRfdCB2YWwsPC9kaXY+PGRpdj7CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYnJlYWs7IC8qIERvIG5vdGhpbmcgKi88L2Rpdj48ZGl2PsKgwqDCoMKgwqDCoMKgwqAg
Y2FzZSBTSkFfSUVSOiAvKiBJbnRlcnJ1cHQgZW5hYmxlIHJlZ2lzdGVyICovPC9kaXY+PGRpdj7C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0mZ3Q7aW50ZXJydXB0X2VuID0gdmFsOzwvZGl2Pjxk
aXY+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FuX3NqYV91cGRhdGVfcGVsX2lycShzKTs8L2Rp
dj48ZGl2PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazs8L2Rpdj48ZGl2PsKgwqDCoMKg
wqDCoMKgwqAgY2FzZSAxNjogLyogUlggZnJhbWUgaW5mb3JtYXRpb24gYWRkcjE2LTI4LiAqLzwv
ZGl2PjxkaXY+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtJmd0O3N0YXR1c19wZWwgfD0gKDEg
Jmx0OyZsdDsgNSk7IC8qIFNldCB0cmFuc21pdCBzdGF0dXMuICovPC9kaXY+PGRpdj4tLTwvZGl2
PjxkaXY+Mi4yNS4xPC9kaXY+PGRpdj7CoDwvZGl2PjxkaXY+wqA8L2Rpdj48ZGl2PsKgPC9kaXY+
PC9kaXY+

