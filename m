Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E67EAA78
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 07:21:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mmM-0001ju-C5; Tue, 14 Nov 2023 01:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgross@suse.com>) id 1r2mmJ-0001jT-Hg
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 01:20:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jgross@suse.com>) id 1r2mmG-0007Rt-TC
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 01:20:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF2542189E;
 Tue, 14 Nov 2023 06:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1699942796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B7GQAx/ugbncSPf/+90n5B16KdzI++8qHbitfRCQ3K0=;
 b=XkPlRk0AQD2oc5sWF6e9NRvX1WpkUuH5jJWG9YQrnue8k1jL6/noVPVnkugrNHI+hsb0M3
 ZGigwyZHTfn2e/DC64Vy8D/FIf9HS0FGUrrzbe7+kW2lJba0Opq3Ng2TfPIqqFeExEtjKx
 92JXrdL2zKNdhY0u+bZHFYE6KvZbU+0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0E3613460;
 Tue, 14 Nov 2023 06:19:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aTHqKYwRU2UyOgAAMHmgww
 (envelope-from <jgross@suse.com>); Tue, 14 Nov 2023 06:19:56 +0000
Message-ID: <d84f794e-44d8-4c92-806f-7fff3fc49486@suse.com>
Date: Tue, 14 Nov 2023 07:19:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU][PATCHv2 0/8] Xen: support grant mappings.
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org,
 paul <paul@xen.org>
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
 <48b53eefdbcd4e61d09acfd2532ea8721376d0de.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261107010.271731@ubuntu-linux-20-04-desktop>
 <60882a8e4d1e9a446034c5d3dda14aed5e0e25cd.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261318191.271731@ubuntu-linux-20-04-desktop>
 <2fb3dfe783bd6226d3addcdccf2e2ef2061b324e.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261346370.271731@ubuntu-linux-20-04-desktop>
 <9b9543b1-b1a7-4699-89f5-2e87680d52e8@suse.com>
 <8cc48dd19e33be3c40ef6ff96bf7dd5d492186ae.camel@infradead.org>
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <8cc48dd19e33be3c40ef6ff96bf7dd5d492186ae.camel@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------w85pJsvfieJOG0WdSMrIBeLN"
Received-SPF: pass client-ip=195.135.220.28; envelope-from=jgross@suse.com;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------w85pJsvfieJOG0WdSMrIBeLN
Content-Type: multipart/mixed; boundary="------------MPeLgrN1zldUo3C4QX07wyF9";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org,
 paul <paul@xen.org>
Message-ID: <d84f794e-44d8-4c92-806f-7fff3fc49486@suse.com>
Subject: Re: [QEMU][PATCHv2 0/8] Xen: support grant mappings.
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
 <48b53eefdbcd4e61d09acfd2532ea8721376d0de.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261107010.271731@ubuntu-linux-20-04-desktop>
 <60882a8e4d1e9a446034c5d3dda14aed5e0e25cd.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261318191.271731@ubuntu-linux-20-04-desktop>
 <2fb3dfe783bd6226d3addcdccf2e2ef2061b324e.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261346370.271731@ubuntu-linux-20-04-desktop>
 <9b9543b1-b1a7-4699-89f5-2e87680d52e8@suse.com>
 <8cc48dd19e33be3c40ef6ff96bf7dd5d492186ae.camel@infradead.org>
In-Reply-To: <8cc48dd19e33be3c40ef6ff96bf7dd5d492186ae.camel@infradead.org>

--------------MPeLgrN1zldUo3C4QX07wyF9
Content-Type: multipart/mixed; boundary="------------1Y37uVy1q8keplRoO6Q5wH14"

--------------1Y37uVy1q8keplRoO6Q5wH14
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMTEuMjMgMjE6MjQsIERhdmlkIFdvb2Rob3VzZSB3cm90ZToNCj4gT24gRnJpLCAy
MDIzLTEwLTI3IGF0IDA3OjI3ICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gT24g
MjYuMTAuMjMgMjI6NTYsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4+PiBPbiBUaHUs
IDI2IE9jdCAyMDIzLCBEYXZpZCBXb29kaG91c2Ugd3JvdGU6DQo+Pj4+IE9uIFRodSwgMjAy
My0xMC0yNiBhdCAxMzozNiAtMDcwMCwgU3RlZmFubyBTdGFiZWxsaW5pIHdyb3RlOg0KPj4+
Pj4NCj4+Pj4+PiBUaGlzIHNlZW1zIGxpa2UgYSBsb3Qgb2YgY29kZSB0byByZXBsYWNlIHRo
YXQgc2ltcGxlciBvcHRpb24uLi4gaXMNCj4+Pj4+PiB0aGVyZSBhIG1hc3NpdmUgcGVyZm9y
bWFuY2Ugd2luIGZyb20gZG9pbmcgaXQgdGhpcyB3YXk/IFdvdWxkIHdlIHdhbnQNCj4+Pj4+
PiB0byB1c2UgdGhpcyB0cmljayBmb3IgdGhlIFhlbiBQViBiYWNrZW5kcyAocWRpc2ssIHFu
aWMpICp0b28qPyBNaWdodCBpdA0KPj4+Pj4+IG1ha2Ugc2Vuc2UgdG8gaW50cm9kdWNlIHRo
ZSBzaW1wbGUgdmVyc2lvbiBhbmQgKnRoZW4qIHRoZSBvcHRpbWlzYXRpb24sDQo+Pj4+Pj4g
d2l0aCBzb21lIGNsZWFyIGJlbmNobWFya2luZyB0byBzaG93IHRoZSB3aW4/DQo+Pj4+Pg0K
Pj4+Pj4gVGhpcyBpcyBub3QgZG9uZSBmb3IgcGVyZm9ybWFuY2UgYnV0IGZvciBzYWZldHkg
KGFzIGluIHNhZmV0eQ0KPj4+Pj4gY2VydGlmaWNhdGlvbnMsIElTTyAyNjI2MiwgZXRjLiku
IFRoaXMgaXMgdG8gZW5hYmxlIHVucHJpdmlsZWdlZCB2aXJ0aW8NCj4+Pj4+IGJhY2tlbmRz
IHJ1bm5pbmcgaW4gYSBEb21VLiBCeSB1bnByaXZpbGVnZWQgSSBtZWFuIGEgdmlydGlvIGJh
Y2tlbmQgdGhhdA0KPj4+Pj4gaXMgdW5hYmxlIHRvIG1hcCBhcmJpdHJhcnkgbWVtb3J5ICh0
aGUgeGVuZm9yZWlnbm1lbW9yeSBpbnRlcmZhY2UgaXMNCj4+Pj4+IHByb2hpYml0ZWQpLg0K
Pj4+Pj4NCj4+Pj4+IFRoZSBnb2FsIGlzIHRvIHJ1biBYZW4gb24gc2FmZXR5LWNyaXRpY2Fs
IHN5c3RlbXMgc3VjaCBhcyBjYXJzLA0KPj4+Pj4gaW5kdXN0cmlhbCByb2JvdHMgYW5kIG1v
cmUuIEluIHRoaXMgY29uZmlndXJhdGlvbiB0aGVyZSBpcyBubw0KPj4+Pj4gdHJhZGl0aW9u
YWwgRG9tMCBpbiB0aGUgc3lzdGVtIGF0IGFsbC4gSWYgeW91wqAgd291bGQgbGlrZSB0byBr
bm93IG1vcmU6DQo+Pj4+PiBodHRwczovL3d3dy55b3V0dWJlLmNvbS93YXRjaD92PXRpc2xq
WTZCcXYwJmxpc3Q9UExZeXc3SVFqTC16SHRwWXRNcEZSM0tZZFJuMHJjcDVYbiZpbmRleD04
DQo+Pj4+DQo+Pj4+IFllYWgsIEkgdW5kZXJzdGFuZCB3aHkgd2UncmUgdXNpbmcgZ3JhbnQg
bWFwcGluZ3MgaW5zdGVhZCBvZiBqdXN0DQo+Pj4+IGRpcmVjdGx5IGhhdmluZyBhY2Nlc3Mg
dmlhIGZvcmVpZ25tZW0gbWFwcGluZ3MuIFRoYXQgd2Fzbid0IHdoYXQgSSB3YXMNCj4+Pj4g
Y29uZnVzZWQgYWJvdXQuDQo+Pj4+DQo+Pj4+IFdoYXQgSSBoYXZlbid0IHdvcmtlZCBvdXQg
aXMgd2h5IHdlJ3JlIGltcGxlbWVudGluZyB0aGlzIHRocm91Z2ggYW4NCj4+Pj4gYXV0b21h
dGljYWxseS1wb3B1bGF0ZWQgTWVtb3J5UmVnaW9uIGluIFFFTVUsIHJhdGhlciB0aGFuIGp1
c3QgdXNpbmcNCj4+Pj4gZ3JhbnQgbWFwcGluZyBvcHMgbGlrZSB3ZSBhbHdheXMgaGF2ZS4N
Cj4+Pj4NCj4+Pj4gSXQgc2VlbXMgbGlrZSBhIGxvdCBvZiBjb21wbGV4aXR5IGp1c3QgdG8g
YXZvaWQgY2FsbGluZw0KPj4+PiBxZW11X3hlbl9nbnR0YWJfbWFwX3JlZnMoKSBmcm9tIHRo
ZSB2aXJ0aW8gYmFja2VuZC4NCj4+Pg0KPj4+IEkgdGhpbmsgdGhlcmUgYXJlIHR3byBxdWVz
dGlvbnMgaGVyZS4gT25lIHF1ZXN0aW9uIGlzICJXaHkgZG8gd2UgbmVlZA0KPj4+IGFsbCB0
aGUgbmV3IGdyYW50IG1hcHBpbmcgY29kZSBhZGRlZCB0byB4ZW4tbWFwY2FjaGUuYyBpbiBw
YXRjaCAjNz8NCj4+PiBDYW4ndCB3ZSB1c2UgcWVtdV94ZW5fZ250dGFiX21hcF9yZWZzKCkg
aW5zdGVhZD8iDQo+Pg0KPj4gVGhlIG1haW4gbW90aXZhdGlvbiB3YXMgdG8gX2F2b2lkXyBo
YXZpbmcgdG8gY2hhbmdlIGFsbCB0aGUgYmFja2VuZHMuDQo+Pg0KPj4gTXkgaW1wbGVtZW50
YXRpb24gZW5hYmxlcyBfYWxsXyBxZW11IGJhc2VkIHZpcnRpbyBiYWNrZW5kcyB0byB1c2Ug
Z3JhbnQNCj4+IG1hcHBpbmdzLiBBbmQgaWYgYSBuZXcgYmFja2VuZCBpcyBhZGRlZCB0byBx
ZW11LCB0aGVyZSB3aWxsIGJlIG5vIGNoYW5nZQ0KPj4gcmVxdWlyZWQgdG8gbWFrZSBpdCB3
b3JrIHdpdGggZ3JhbnRzLg0KPiANCj4gSSdtIG5vdCByZWFsbHkgY29udmluY2VkIEkgYnV5
IHRoYXQuIFRoaXMgaXMgYSBsb3Qgb2YgY29tcGxleGl0eSwgYW5kDQo+IGRvbid0IGJhY2tl
bmRzIG5lZWQgdG8gY2FsbCBhbiBhcHByb3ByaWF0ZSBtYXBwaW5nIGZ1bmN0aW9uIHRvIG1h
cCB2aWENCj4gYW4gSU9NTVUgaWYgaXQncyBwcmVzZW50IGFueXdheT8gTWFrZSB0aGVuIGNh
bGwgYSBoZWxwZXIgd2hlcmUgeW91IGNhbg0KPiBkbyB0aGlzIGluIG9uZSBwbGFjZSBkaXJl
Y3RseSBpbnN0ZWFkIG9mIHRocm91Z2ggYSBmYWtlIE1lbW9yeVJlZ2lvbiwNCj4gYW5kIHlv
dSdyZSBkb25lLCBzdXJlbHk/DQoNClRoYXQgd2FzIHRlc3RlZCB3aXRoIHVubW9kaWZpZWQg
YmxvY2sgYW5kIG5ldCBiYWNrZW5kcyBpbiBxZW11Lg0KDQpNYXliZSBJIG1pc3NlZCBzb21l
dGhpbmcsIGJ1dCBJIHRoaW5rIHRoZSBJT01NVSBhY2Nlc3NlcyBhcmUgX25vdF8gY292ZXJp
bmcNCmFjY2Vzc2VzIHRvIHRoZSB2aXJ0aW8gcmluZ3MgZnJvbSBxZW11LiBBbmQgdGhpcyBp
cyBzb21ldGhpbmcgeW91IHJlYWxseQ0Kd2FudCBmb3IgZHJpdmVyIGRvbWFpbnMuDQoNCg0K
SnVlcmdlbg0K
--------------1Y37uVy1q8keplRoO6Q5wH14
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------1Y37uVy1q8keplRoO6Q5wH14--

--------------MPeLgrN1zldUo3C4QX07wyF9--

--------------w85pJsvfieJOG0WdSMrIBeLN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmVTEYwFAwAAAAAACgkQsN6d1ii/Ey/G
Jgf/TSVkZAYGojX20gxztVxLbAc6hsrbNh289ftQitpHzYePdKHlHC6qro7uZD1XA7IXWi9vZmiJ
tLIT4fhKxxDyHZtQbVLXUs8EdqttWq8IBFZXgBcG0Dk8cmD52nyjd6THgblauQtKYvlQVpjRElR/
zuhYBNjf9ZHct3trhOfL734Ly+j7XCeeZL8Z8KUlJiDHu0qBUabmx8Q8khxYNEZvo2nJRF5kHxLU
K4oVo/P7YMUPvTQ3mEDmV0FOBGUOSzxFqQ2wKDO+cLzPM0uHhE6wICyFMA/in8T3FU8N5/LTFCxe
vSIxGHhYJjeX2Rp7iMcZi8YVwPm6eN7i55poAPgunw==
=OnqR
-----END PGP SIGNATURE-----

--------------w85pJsvfieJOG0WdSMrIBeLN--

