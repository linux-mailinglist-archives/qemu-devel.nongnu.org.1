Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CB67B4C82
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 09:26:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnDIU-0002QG-QM; Mon, 02 Oct 2023 03:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qnDIR-0002Pz-4I; Mon, 02 Oct 2023 03:24:52 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qnDIP-0001an-3M; Mon, 02 Oct 2023 03:24:50 -0400
Received: from mail-nwsmtp-mxback-corp-main-12.vla.yp-c.yandex.net
 (mail-nwsmtp-mxback-corp-main-12.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:33a2:0:640:ecef:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 5A56460934;
 Mon,  2 Oct 2023 10:24:40 +0300 (MSK)
Received: from mail.yandex-team.ru (2a02:6b8:c15:2e85:0:640:fe53:0
 [2a02:6b8:c15:2e85:0:640:fe53:0])
 by mail-nwsmtp-mxback-corp-main-12.vla.yp-c.yandex.net (mxbackcorp/Yandex)
 with HTTP id ZOPxR00O14Y0-LlYMi7VP; Mon, 02 Oct 2023 10:24:40 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696231480;
 bh=zmcLUJA3NhEZvsRXOy87qmnYVNCuaX5bcbZ01wsZ/e0=;
 h=References:Date:Message-Id:Cc:Subject:To:From:In-Reply-To;
 b=hVv+wYJqFanv2qx29SQILm/z8/C/7L7wY6NM2DYGEXAFZRLIrESHIwGfPoRUrAXn3
 Z8PsKBh0mR/bQZUpemNGMb7XswhJWCzVBGUD30Ia2T/m5cjo4SUtYwq+Z+3Y9QIuM6
 OHojEjDubV6+c8g8JDxhvK3WEJsqZ7BztIszTcwU=
Authentication-Results: mail-nwsmtp-mxback-corp-main-12.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from 25wc44h4wzm3vfpi.iva.yp-c.yandex.net
 (25wc44h4wzm3vfpi.iva.yp-c.yandex.net [2a02:6b8:c0c:5fa3:0:640:4fcd:0])
 by mail-nwsmtp-mxback-corp-main-11.iva.yp-c.yandex.net (mxbackcorp/Yandex)
 with HTTP id VNPZS00OvGk0-K8HOKLeu
 for <d-tatianin@yandex-team.ru>; Mon, 02 Oct 2023 10:24:30 +0300
Received: by 25wc44h4wzm3vfpi.iva.yp-c.yandex.net with HTTP;
 Mon, 02 Oct 2023 10:24:29 +0300
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>
In-Reply-To: <20230919102346.2117963-2-d-tatianin@yandex-team.ru>
References: <20230919102346.2117963-1-d-tatianin@yandex-team.ru>
 <20230919102346.2117963-2-d-tatianin@yandex-team.ru>
Subject: Re: [PATCH v2 1/3] i386/a-b-bootblock: factor test memory addresses
 out into constants
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 02 Oct 2023 10:24:39 +0300
Message-Id: <4431696231449@mail.yandex-team.ru>
Content-Transfer-Encoding: base64
Content-Type: text/html; charset=utf-8
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

PGRpdj5QaW5nISA6KTwvZGl2PjxkaXY+wqA8L2Rpdj48ZGl2PjE5LjA5LjIwMjMsIDEzOjIzLCAi
RGFuaWlsIFRhdGlhbmluIiAmbHQ7ZC10YXRpYW5pbkB5YW5kZXgtdGVhbS5ydSZndDs6PC9kaXY+
PGJsb2NrcXVvdGU+PHA+U28gdGhhdCB3ZSBoYXZlIGxlc3MgbWFnaWMgbnVtYmVycyB0byBkZWFs
IHdpdGguIFRoaXMgYWxzbyBhbGxvd3MgdXMgdG88YnIgLz5yZXVzZSB0aGVzZSBpbiB0aGUgZm9s
bG93aW5nIGNvbW1pdHMuPGJyIC8+PGJyIC8+U2lnbmVkLW9mZi1ieTogRGFuaWlsIFRhdGlhbmlu
ICZsdDs8YSBocmVmPSJtYWlsdG86ZC10YXRpYW5pbkB5YW5kZXgtdGVhbS5ydSIgcmVsPSJub29w
ZW5lciBub3JlZmVycmVyIj5kLXRhdGlhbmluQHlhbmRleC10ZWFtLnJ1PC9hPiZndDs8YnIgLz5S
ZXZpZXdlZC1ieTogUGV0ZXIgWHUgJmx0OzxhIGhyZWY9Im1haWx0bzpwZXRlcnhAcmVkaGF0LmNv
bSIgcmVsPSJub29wZW5lciBub3JlZmVycmVyIj5wZXRlcnhAcmVkaGF0LmNvbTwvYT4mZ3Q7PGJy
IC8+LS0tPGJyIC8+wqB0ZXN0cy9taWdyYXRpb24vaTM4Ni9hLWItYm9vdGJsb2NrLlMgfCA5ICsr
KysrKy0tLTxiciAvPsKgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSk8YnIgLz48YnIgLz5kaWZmIC0tZ2l0IGEvdGVzdHMvbWlncmF0aW9uL2kzODYvYS1iLWJv
b3RibG9jay5TIGIvdGVzdHMvbWlncmF0aW9uL2kzODYvYS1iLWJvb3RibG9jay5TPGJyIC8+aW5k
ZXggM2Q0NjRjNzU2OC4uMDM2MjE2ZTRhNyAxMDA2NDQ8YnIgLz4tLS0gYS90ZXN0cy9taWdyYXRp
b24vaTM4Ni9hLWItYm9vdGJsb2NrLlM8YnIgLz4rKysgYi90ZXN0cy9taWdyYXRpb24vaTM4Ni9h
LWItYm9vdGJsb2NrLlM8YnIgLz5AQCAtMzQsNiArMzQsMTAgQEAgc3RhcnQ6ICMgYXQgMHg3YzAw
ID88YnIgLz7CoMKgwqDCoMKgwqDCoMKgwqBtb3YgJDE2LCVlYXg8YnIgLz7CoMKgwqDCoMKgwqDC
oMKgwqBtb3YgJWVheCwlZHM8YnIgLz7CoDxiciAvPisjIFN0YXJ0IGZyb20gMU1CPGJyIC8+Ky5z
ZXQgVEVTVF9NRU1fU1RBUlQsICgxMDI0KjEwMjQpPGJyIC8+Ky5zZXQgVEVTVF9NRU1fRU5ELCAo
MTAwKjEwMjQqMTAyNCk8YnIgLz4rPGJyIC8+wqDCoMKgwqDCoMKgwqDCoMKgbW92ICQ2NSwlYXg8
YnIgLz7CoMKgwqDCoMKgwqDCoMKgwqBtb3YgJDB4M2Y4LCVkeDxiciAvPsKgwqDCoMKgwqDCoMKg
wqDCoG91dGIgJWFsLCVkeDxiciAvPkBAIC00MSwxMiArNDUsMTEgQEAgc3RhcnQ6ICMgYXQgMHg3
YzAwID88YnIgLz7CoMKgwqDCoMKgwqDCoMKgwqAjIGJsIGtlZXBzIGEgY291bnRlciBzbyB3ZSBs
aW1pdCB0aGUgb3V0cHV0IHNwZWVkPGJyIC8+wqDCoMKgwqDCoMKgwqDCoMKgbW92ICQwLCAlYmw8
YnIgLz7CoG1haW5sb29wOjxiciAvPi0gIyBTdGFydCBmcm9tIDFNQjxiciAvPi0gbW92ICQoMTAy
NCoxMDI0KSwlZWF4PGJyIC8+KyBtb3YgJFRFU1RfTUVNX1NUQVJULCVlYXg8YnIgLz7CoGlubmVy
bG9vcDo8YnIgLz7CoMKgwqDCoMKgwqDCoMKgwqBpbmNiICglZWF4KTxiciAvPsKgwqDCoMKgwqDC
oMKgwqDCoGFkZCAkNDA5NiwlZWF4PGJyIC8+LSBjbXAgJCgxMDAqMTAyNCoxMDI0KSwlZWF4PGJy
IC8+KyBjbXAgJFRFU1RfTUVNX0VORCwlZWF4PGJyIC8+wqDCoMKgwqDCoMKgwqDCoMKgamwgaW5u
ZXJsb29wPGJyIC8+wqA8YnIgLz7CoMKgwqDCoMKgwqDCoMKgwqBpbmMgJWJsPC9wPi0tPGJyIC8+
Mi4zNC4xPGJyIC8+wqA8L2Jsb2NrcXVvdGU+

