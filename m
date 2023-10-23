Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D9E7D371C
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:46:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quuJK-0006ZM-Is; Mon, 23 Oct 2023 08:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1qulMZ-00027C-J9
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 23:12:19 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1qulMX-0001cC-Vd
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 23:12:19 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5384975e34cso4305284a12.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 20:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698030736; x=1698635536; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qKPHId/HHLMHrd6WZLoQdnFciHykO9uvCGsXpHC+444=;
 b=fjooPO0WzvmtFlpsbeY537tifvorhce82a5sk48yViTYdDLzYshWGKBmBwyYILrO+o
 k/XvqC1d4mREu/qs911tcX0kLxVQM74vb0XAnNGocBY4SpQ6chCj6JfSNJtJvC4XGR76
 /1rU1enUb+3ApPOh8JsSDZSuRRiC6uFmeQqeZ0K5i1yy9pS6MbIbXtQFOoDwRUk2uS0N
 RKcEVwbSOwW0tCck4zdSdTsVmgd5JLddPd8b7V/NnAoZxN2YTUKnCjsp9I3/+uXkXfHq
 MS1FOlMzZx4GR8tZ9ByMbXapLRA10dFvNUUO+AAwQUYKpjUSJ4lwubwXOhHx0DlhCKya
 6ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698030736; x=1698635536;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qKPHId/HHLMHrd6WZLoQdnFciHykO9uvCGsXpHC+444=;
 b=AIBrdxS1o7rpgPpEHQLzZiX/KAYilT8yjTahrv+/bLI8WPcPREyxrHUqr/3zEq3Gz/
 KbIiNyBPqV3NfVDOI3TVNwjMtSHwUFcXKcmDNJwQe1v2J1S9u77wZvDK/VU/PNv0IOwL
 Mn4G4MP2LHjLRLqoCuUirgHxM4cZTP14ZiureAE3UriRQiD2k5R0k/sTmU5YU4NFzcFS
 8+3WWBo3VBcn6ZwtzN780VWsn7/Ck4Ox8zeOpVSrssKaARISLgWvYU63IY/P0E/e63TI
 bdTpV+2moJwm7LuXQjQnavNHsummMbhISvO5aRheRvVLvVRwoBo5wW6tyJ72/d0zUGDL
 GmjA==
X-Gm-Message-State: AOJu0YzwXPoxQLqJIunZyTpWmVjJSYmJhJ/R/ohlYBzCSs5vL8V427SD
 2v0v7RWp2mwsNVv+1lkH6gc=
X-Google-Smtp-Source: AGHT+IFMdo6mjrZ0WlBiEEdOXQn1C9nlFE4yLtG+GvG1FKKyBVonSCtHJnBzieizZ67u4r8T48wPhA==
X-Received: by 2002:a17:907:7ea3:b0:9c6:10d4:d09f with SMTP id
 qb35-20020a1709077ea300b009c610d4d09fmr6701349ejc.63.1698030735634; 
 Sun, 22 Oct 2023 20:12:15 -0700 (PDT)
Received: from [10.33.80.50] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a17090671c600b009920a690cd9sm5806083ejk.59.2023.10.22.20.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 20:12:15 -0700 (PDT)
Message-ID: <3913e8227c343a5d9bfcc2ac1f01d9bd8eceac7a.camel@gmail.com>
Subject: Re: [PATCH v3 0/9] virtio-console: notify about the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Szymon Lukasz <noh4hss@gmail.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, berrange@redhat.com, amit@kernel.org,
 mst@redhat.com,  marcandre.lureau@redhat.com, pbonzini@redhat.com
Date: Mon, 23 Oct 2023 05:12:14 +0200
In-Reply-To: <20200629164041.472528-1-noh4hss@gmail.com>
References: <20200629164041.472528-1-noh4hss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Oct 2023 08:44:49 -0400
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

SSBoYXZlIGZvdW5kIHRoaXMgMyB5ZWFyIG9sZCBwYXRjaCBhZGRpbmcgdmlydGlvIGNvbnNvbGUg
cmVzaXplCnN1cHBvcnQsIHdoaWNoIHNlZW1zIHRvIGhhdmUgYmVlbiBmb3Jnb3R0ZW4gYXQgdGhh
dCB0aW1lLiBJIHdvdWxkIGxpa2UKdG8gc2VlIHRoaXMgZmVhdHVyZSBtZXJnZWQuCgpTenltb24s
IHlvdSBoYXZlIG9yaWdpbmFsbHkgc3VibWl0dGVkIHRoaXMgcGF0Y2gsIHdvdWxkIHlvdSBiZSB3
aWxsaW5nCnRvIHVwZGF0ZSBpdCBmb3IgdGhlIGxhdGVzdCBkZXZlbG9wbWVudCB0cmVlIGFuZCBy
ZXN1Ym1pdCBpdD8KCklmIGl0IHR1cm5zIG91dCB0aGF0IFN6eW1vbiBkb2Vzbid0IHdhbnQgdG8g
d29yayBvbiB0aGlzIGFueW1vcmUgZm9yCmFueSByZWFzb24gKG9yIGRvZXNuJ3QgcmVzcG9uZCks
IGNvdWxkIEkgcmVzdWJtaXQgdGhlIHBhdGNoIG15c2VsZj8KVGhlIGNvbnRyaWJ1dGluZyBndWlk
ZWxpbmVzIGRvbid0IHNheSBhbnl0aGluZyBhYm91dCB0aGlzLiBJJ20KZXNwZWNpYWxseSB1bnN1
cmUgaG93IHRvIGRlYWwgd2l0aCBTaWduZWQtb2ZmLWJ5LCBhcyBpbiBzdWNoIGNhc2UgSQp3b3Vs
ZCBiZSAocmUpc3VibWl0dGluZyBzb21ib2R5IGVsc2UncyB3b3JrLCBidXQgcG90ZW50aWFsbHkg
d2l0aCBteQptb2RpZmljYXRpb25zLiBJJ20gd2lsbGluZyB0byB1cGRhdGUgYW5kIHRlc3QgdGhl
IHBhdGNoLCBhbmQgaWYKbmVjZXNzYXJ5LCBhZGRyZXNzIGFueSByZXZpZXcgZmVlZGJhY2suCgog
LSBGaWxpcCBIZWpzZWsKCgo+IFRoZSBnb2FsIG9mIHRoaXMgc2VyaWVzIGlzIHRvIGhhdmUgYSBy
ZXNpemFibGUgdGVybWluYWwgaW50byBhIGd1ZXN0Cj4gd2l0aG91dCBoYXZpbmcgdG8gc2V0IHVw
IG5ldHdvcmtpbmcgYW5kIHVzaW5nLCBlLmcuIHNzaC4KPiAKPiBUaGUgdmlydGlvIHNwZWMgYWxs
b3dzIGEgdmlydGlvLWNvbnNvbGUgZGV2aWNlIHRvIG5vdGlmeSB0aGUgZ3Vlc3QKPiBhYm91dAo+
IHRlcm1pbmFsIHJlc2l6ZXMgaW4gdGhlIGhvc3QuIExpbnV4IEtlcm5lbCBpbXBsZW1lbnRzIHRo
ZSBkcml2ZXIgcGFydAo+IG9mCj4gdGhlIHNwZWMuIFRoaXMgc2VyaWVzIGltcGxlbWVudCB0aGUg
ZGV2aWNlIHBhcnQgaW4gUUVNVS4KPiAKPiBUaGlzIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIGEg
cmVzaXphYmxlIHRlcm1pbmFsIGlmIGEgdmlydGlvIGNvbnNvbGUKPiBkZXZpY2UgaXMgY29ubmVj
dGVkIHRvIHRoZSBzdGRpbyBiYWNrZW5kLiAKPiAKPiBUaGlzIHNlcmllcyBhbHNvIGludHJvZHVj
ZXMgcmVzaXplIG1lc3NhZ2VzIHRoYXQgY2FuIGJlIHNlbnQgb3ZlciBRTVAKPiB0bwo+IG5vdGlm
eSBRRU1VIGFib3V0IHRoZSBzaXplIG9mIHRoZSB0ZXJtaW5hbCBjb25uZW50ZWQgdG8gc29tZSBj
aGFyZGV2Lgo+IEluIHRoZSBsaWJ2aXJ0IHNldHRpbmcsIGl0IHdpbGwgYWxsb3cgdG8gaW1wbGVt
ZW50IGEgcmVzaXphYmxlCj4gdGVybWluYWwgCj4gZm9yIHZpcnNoIGNvbnNvbGUgYW5kIG90aGVy
IGxpYnZpcnQgY2xpZW50cy4KPiAKPiAKPiB2MzoKPiBhZGQgcmVzaXplIG1lc3NhZ2VzIG92ZXIg
UU1QLCBhcyBzdWdnZXN0ZWQgYnkgRGFuaWVsCj4gCj4gdjI6Cj4gZml4IGFkZGluZyBhIG5ldyB2
aXJ0aW8gZmVhdHVyZSBiaXQgdG8gdGhlIHZpcnRpbyBjb25zb2xlIGRldmljZQo+IAo+IFN6eW1v
biBMdWthc3ogKDkpOgo+IMKgIGNoYXJkZXY6IGFkZCBjb2xzLCByb3dzIGZpZWxkcwo+IMKgIGNo
YXJkZXY6IGFkZCBDSFJfRVZFTlRfUkVTSVpFCj4gwqAgY2hhcmRldjogYWRkIHFlbXVfY2hyX3Jl
c2l6ZSgpCj4gwqAgY2hhci1tdXg6IGFkZCBzdXBwb3J0IGZvciB0aGUgdGVybWluYWwgc2l6ZQo+
IMKgIG1haW4tbG9vcDogY2hhbmdlIHRoZSBoYW5kbGluZyBvZiBTSUdXSU5DSAo+IMKgIGNoYXIt
c3RkaW86IGFkZCBzdXBwb3J0IGZvciB0aGUgdGVybWluYWwgc2l6ZQo+IMKgIHFtcDogYWRkIGNo
YXJkZXYtcmVzaXplIGNvbW1hbmQKPiDCoCB2aXJ0aW8tc2VyaWFsLWJ1czogYWRkIHRlcm1pbmFs
IHJlc2l6ZSBtZXNzYWdlcwo+IMKgIHZpcnRpby1jb25zb2xlOiBub3RpZnkgdGhlIGd1ZXN0IGFi
b3V0IHRlcm1pbmFsIHJlc2l6ZXMKPiAKPiDCoGJhY2tlbmRzL2NyeXB0b2Rldi12aG9zdC11c2Vy
LmPCoMKgIHzCoCAxICsKPiDCoGNoYXJkZXYvY2hhci1mZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfCAxMyArKysrKysrCj4gwqBjaGFyZGV2L2NoYXItbXV4LmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxOCArKysrKysrKy0KPiDCoGNoYXJkZXYvY2hhci1zdGRp
by5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyOSArKysrKysrKysrKysrKwo+IMKgY2hh
cmRldi9jaGFyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDI2ICsr
KysrKysrKysrKysKPiDCoGh3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmPCoMKgwqDCoMKgwqDCoMKg
IHzCoCAxICsKPiDCoGh3L2NoYXIvdGVybWluYWwzMjcwLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAxICsKPiDCoGh3L2NoYXIvdHJhY2UtZXZlbnRzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDEgKwo+IMKgaHcvY2hhci92aXJ0aW8tY29uc29sZS5jwqDCoMKgwqDCoMKgwqDCoMKg
IHwgNjMKPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCj4gwqBody9jaGFyL3ZpcnRp
by1zZXJpYWwtYnVzLmPCoMKgwqDCoMKgwqAgfCA0MiArKysrKysrKysrKysrKysrKysrKy0KPiDC
oGh3L2NvcmUvbWFjaGluZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEg
Kwo+IMKgaHcvaXBtaS9pcG1pX2JtY19leHRlcm4uY8KgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKwo+
IMKgaHcvdXNiL2NjaWQtY2FyZC1wYXNzdGhydS5jwqDCoMKgwqDCoMKgIHzCoCAxICsKPiDCoGh3
L3VzYi9kZXYtc2VyaWFsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsKPiDC
oGh3L3VzYi9yZWRpcmVjdC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEg
Kwo+IMKgaW5jbHVkZS9jaGFyZGV2L2NoYXItZmUuaMKgwqDCoMKgwqDCoMKgwqAgfCAxMCArKysr
Kwo+IMKgaW5jbHVkZS9jaGFyZGV2L2NoYXIuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcg
KysrKwo+IMKgaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXNlcmlhbC5oIHzCoCA1ICsrKwo+IMKg
aW5jbHVkZS9xZW11L21haW4tbG9vcC5owqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0ICsrCj4gwqBt
b25pdG9yL2htcC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MSArCj4gwqBtb25pdG9yL3FtcC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqAgMSArCj4gwqBuZXQvdmhvc3QtdXNlci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMSArCj4gwqBxYXBpL2NoYXIuanNvbsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMjUgKysrKysrKysrKysrCj4gwqB1aS9jdXJzZXMuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTEgKysrLS0tCj4gwqB1
dGlsL21haW4tbG9vcC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIxICsr
KysrKysrKysrCj4gwqAyNSBmaWxlcyBjaGFuZ2VkLCAyNzQgaW5zZXJ0aW9ucygrKSwgMTIgZGVs
ZXRpb25zKC0pCj4gCgo=


