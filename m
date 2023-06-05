Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C740C722559
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:15:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q696L-0007DQ-L0; Mon, 05 Jun 2023 08:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1q696A-0007BI-Kw; Mon, 05 Jun 2023 08:14:11 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1q6966-00081s-Vk; Mon, 05 Jun 2023 08:14:10 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAH75ki0X1k2VJPAg--.4006S2;
 Mon, 05 Jun 2023 20:12:18 +0800 (CST)
Received: from wangyuquan1236$phytium.com.cn ( [218.76.62.144] ) by
 ajax-webmail-mail (Coremail) ; Mon, 5 Jun 2023 20:13:46 +0800 (GMT+08:00)
X-Originating-IP: [218.76.62.144]
Date: Mon, 5 Jun 2023 20:13:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To: "Marcin Juszkiewicz" <marcin.juszkiewicz@linaro.org>
Cc: rad@semihalf.com, peter.maydell@linaro.org, quic_llindhol@quicinc.com,
 chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230428(d6537451) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-76b96e3b-3ecc-44d5-9200-de81e6d4c242-
In-Reply-To: <101d301d-d413-288e-9318-d0a226ea8715@linaro.org>
References: <20230605095536.117384-1-wangyuquan1236@phytium.com.cn>
 <20230605095536.117384-2-wangyuquan1236@phytium.com.cn>
 <101d301d-d413-288e-9318-d0a226ea8715@linaro.org>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: qtBckWZvb3Rlcl90eHQ9NzMxOjM4Mw==
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <40c4980d.387.1888b7a478a.Coremail.wangyuquan1236@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBXhCR70X1kC6MAAA--.596W
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQABAWR84icFX
	QAAsE
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7GrW3CrW5Gw4xAryDZF13Arb_yoW3Wrg_Zr
 ykCrn8Cw4qk3y09Fn3K3W3JrySkwsY9r4Igas5JFyxZa4av3Z8ZF4kK34Svr13Jr4vqFnx
 ArnIvrySk34a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

SGksIE1hcmNpbgoKT24gTW9uLCA1IEp1biAyMDIzIDExOjU5OjE2ICswMjAwLCBNYXJjaW4gSnVz
emtpZXdpY3ogd3JvdGU6Cgo+IAo+IFcgZG5pdSA1LjA2LjIwMjMgb8KgMTE6NTUsIFl1cXVhbiBX
YW5nIHBpc3plOgo+ID4gVGhlIGN1cnJlbnQgc2JzYS1yZWYgY2Fubm90IHVzZSBFSENJIGNvbnRy
b2xsZXIgd2hpY2ggaXMgb25seQo+ID4gYWJsZSB0byBkbyAzMi1iaXQgRE1BLCBzaW5jZSBzYnNh
LXJlZiBkb2Vzbid0IGhhdmUgUkFNIGJlbG93IDRHQi4KPiA+IEhlbmNlLCB0aGlzIHVzZXMgWEhD
SSB0byBwcm92aWRlIGEgdXNiIGNvbnRyb2xsZXIgd2l0aCA2NC1iaXQKPiA+IERNQSBjYXBhYmxp
dHkgaW5zdGVhZCBvZiBFSENJLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdXF1YW4gV2FuZzx3
YW5neXVxdWFuMTIzNkBwaHl0aXVtLmNvbS5jbj4KPiAKPiBDYW4geW91IHNoYXJlIGZpcm13YXJl
IHNpZGUgc28gaXQgY2FuIGJlIHRlc3RlZD8KPiAKPiBUaGUgbW9yZSBJIGRlYWwgd2l0aCBFREsy
IHRoZSBtb3JlIEkgdW5kZXJzdGFuZCB3aHkgcGVvcGxlIGdvIFUtQm9vdC4KCkkgZmlndXJlZCBv
dXQgdGhlIHN0dWNrIHByb2JsZW0gb2YgdGhlIHJlbGV2YW50IGZpcm13YXJlIHBhdGNoIGluIGVk
azIgCm1haWwgbGlzdC4gCgpCZWxvdyBpcyB0aGUgcGF0Y2hzZXQgbGluazoKaHR0cHM6Ly9lZGsy
Lmdyb3Vwcy5pby9nL2RldmVsL21lc3NhZ2UvMTA1NzEzCgpUaGFua3MKWXVxdWFuDQoNCuS/oeaB
r+WuieWFqOWjsOaYju+8muacrOmCruS7tuWMheWQq+S/oeaBr+W9kuWPkeS7tuS6uuaJgOWcqOe7
hOe7h+aJgOaciSzlj5Hku7bkurrmiYDlnKjnu4Tnu4flr7nor6Xpgq7ku7bmi6XmnInmiYDmnInm
nYPliKnjgILor7fmjqXmlLbogIXms6jmhI/kv53lr4Ys5pyq57uP5Y+R5Lu25Lq65Lmm6Z2i6K64
5Y+vLOS4jeW+l+WQkeS7u+S9leesrOS4ieaWuee7hOe7h+WSjOS4quS6uumAj+mcsuacrOmCruS7
tuaJgOWQq+S/oeaBr+OAgg0KSW5mb3JtYXRpb24gU2VjdXJpdHkgTm90aWNlOiBUaGUgaW5mb3Jt
YXRpb24gY29udGFpbmVkIGluIHRoaXMgbWFpbCBpcyBzb2xlbHkgcHJvcGVydHkgb2YgdGhlIHNl
bmRlcidzIG9yZ2FuaXphdGlvbi5UaGlzIG1haWwgY29tbXVuaWNhdGlvbiBpcyBjb25maWRlbnRp
YWwuUmVjaXBpZW50cyBuYW1lZCBhYm92ZSBhcmUgb2JsaWdhdGVkIHRvIG1haW50YWluIHNlY3Jl
Y3kgYW5kIGFyZSBub3QgcGVybWl0dGVkIHRvIGRpc2Nsb3NlIHRoZSBjb250ZW50cyBvZiB0aGlz
IGNvbW11bmljYXRpb24gdG8gb3RoZXJzLg==


