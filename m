Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECEA7D8E25
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 07:28:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwFO2-0001YU-RK; Fri, 27 Oct 2023 01:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgross@suse.com>) id 1qwFNv-0001MR-Ce
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 01:27:55 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jgross@suse.com>) id 1qwFNn-0004vG-1u
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 01:27:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6267B1FDB3;
 Fri, 27 Oct 2023 05:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1698384458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fksRgmPiYy0rwmEfN2NkBxLL2loAWuI5iXuaja+YU6Q=;
 b=USPkX5gAVg4GzstL8KWMiWS7Ls4QLJn+3wD5JABAQtO6OJSEugHAXaVnP1lGB1giVF846R
 67p5iyq9tqt2PwZV2RpHBPhsLim/on8VvRM4sVUuxgsH2cI4RQ07DGgAJDfHG193+0B3DJ
 3MalfhN6IFSJo0xugstG9L/yZeSMdf4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39DAE13524;
 Fri, 27 Oct 2023 05:27:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BEGkDEpKO2XqWgAAMHmgww
 (envelope-from <jgross@suse.com>); Fri, 27 Oct 2023 05:27:38 +0000
Message-ID: <9b9543b1-b1a7-4699-89f5-2e87680d52e8@suse.com>
Date: Fri, 27 Oct 2023 07:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU][PATCHv2 0/8] Xen: support grant mappings.
Content-Language: en-US
To: Stefano Stabellini <sstabellini@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
 <48b53eefdbcd4e61d09acfd2532ea8721376d0de.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261107010.271731@ubuntu-linux-20-04-desktop>
 <60882a8e4d1e9a446034c5d3dda14aed5e0e25cd.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261318191.271731@ubuntu-linux-20-04-desktop>
 <2fb3dfe783bd6226d3addcdccf2e2ef2061b324e.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261346370.271731@ubuntu-linux-20-04-desktop>
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
In-Reply-To: <alpine.DEB.2.22.394.2310261346370.271731@ubuntu-linux-20-04-desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------c1lBvZPhxwJVYYXx50hDf0sV"
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -8.99
X-Spamd-Result: default: False [-8.99 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; XM_UA_NO_VERSION(0.01)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
 HAS_ATTACHMENT(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 BAYES_HAM(-3.00)[100.00%];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MIME_BASE64_TEXT(0.10)[];
 SIGNED_PGP(-2.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 MIME_UNKNOWN(0.10)[application/pgp-keys]
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=jgross@suse.com;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
--------------c1lBvZPhxwJVYYXx50hDf0sV
Content-Type: multipart/mixed; boundary="------------I4qNkJn56wsK2Ovo0yOx9fqC";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org
Message-ID: <9b9543b1-b1a7-4699-89f5-2e87680d52e8@suse.com>
Subject: Re: [QEMU][PATCHv2 0/8] Xen: support grant mappings.
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
 <48b53eefdbcd4e61d09acfd2532ea8721376d0de.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261107010.271731@ubuntu-linux-20-04-desktop>
 <60882a8e4d1e9a446034c5d3dda14aed5e0e25cd.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261318191.271731@ubuntu-linux-20-04-desktop>
 <2fb3dfe783bd6226d3addcdccf2e2ef2061b324e.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261346370.271731@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2310261346370.271731@ubuntu-linux-20-04-desktop>

--------------I4qNkJn56wsK2Ovo0yOx9fqC
Content-Type: multipart/mixed; boundary="------------BZtmMjHWrzN4Bnc4Zh37x47G"

--------------BZtmMjHWrzN4Bnc4Zh37x47G
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMTAuMjMgMjI6NTYsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4gT24gVGh1
LCAyNiBPY3QgMjAyMywgRGF2aWQgV29vZGhvdXNlIHdyb3RlOg0KPj4gT24gVGh1LCAyMDIz
LTEwLTI2IGF0IDEzOjM2IC0wNzAwLCBTdGVmYW5vIFN0YWJlbGxpbmkgd3JvdGU6DQo+Pj4N
Cj4+Pj4gVGhpcyBzZWVtcyBsaWtlIGEgbG90IG9mIGNvZGUgdG8gcmVwbGFjZSB0aGF0IHNp
bXBsZXIgb3B0aW9uLi4uIGlzDQo+Pj4+IHRoZXJlIGEgbWFzc2l2ZSBwZXJmb3JtYW5jZSB3
aW4gZnJvbSBkb2luZyBpdCB0aGlzIHdheT8gV291bGQgd2Ugd2FudA0KPj4+PiB0byB1c2Ug
dGhpcyB0cmljayBmb3IgdGhlIFhlbiBQViBiYWNrZW5kcyAocWRpc2ssIHFuaWMpICp0b28q
PyBNaWdodCBpdA0KPj4+PiBtYWtlIHNlbnNlIHRvIGludHJvZHVjZSB0aGUgc2ltcGxlIHZl
cnNpb24gYW5kICp0aGVuKiB0aGUgb3B0aW1pc2F0aW9uLA0KPj4+PiB3aXRoIHNvbWUgY2xl
YXIgYmVuY2htYXJraW5nIHRvIHNob3cgdGhlIHdpbj8NCj4+Pg0KPj4+IFRoaXMgaXMgbm90
IGRvbmUgZm9yIHBlcmZvcm1hbmNlIGJ1dCBmb3Igc2FmZXR5IChhcyBpbiBzYWZldHkNCj4+
PiBjZXJ0aWZpY2F0aW9ucywgSVNPIDI2MjYyLCBldGMuKS4gVGhpcyBpcyB0byBlbmFibGUg
dW5wcml2aWxlZ2VkIHZpcnRpbw0KPj4+IGJhY2tlbmRzIHJ1bm5pbmcgaW4gYSBEb21VLiBC
eSB1bnByaXZpbGVnZWQgSSBtZWFuIGEgdmlydGlvIGJhY2tlbmQgdGhhdA0KPj4+IGlzIHVu
YWJsZSB0byBtYXAgYXJiaXRyYXJ5IG1lbW9yeSAodGhlIHhlbmZvcmVpZ25tZW1vcnkgaW50
ZXJmYWNlIGlzDQo+Pj4gcHJvaGliaXRlZCkuDQo+Pj4NCj4+PiBUaGUgZ29hbCBpcyB0byBy
dW4gWGVuIG9uIHNhZmV0eS1jcml0aWNhbCBzeXN0ZW1zIHN1Y2ggYXMgY2FycywNCj4+PiBp
bmR1c3RyaWFsIHJvYm90cyBhbmQgbW9yZS4gSW4gdGhpcyBjb25maWd1cmF0aW9uIHRoZXJl
IGlzIG5vDQo+Pj4gdHJhZGl0aW9uYWwgRG9tMCBpbiB0aGUgc3lzdGVtIGF0IGFsbC4gSWYg
eW91wqAgd291bGQgbGlrZSB0byBrbm93IG1vcmU6DQo+Pj4gaHR0cHM6Ly93d3cueW91dHVi
ZS5jb20vd2F0Y2g/dj10aXNsalk2QnF2MCZsaXN0PVBMWXl3N0lRakwtekh0cFl0TXBGUjNL
WWRSbjByY3A1WG4maW5kZXg9OA0KPj4NCj4+IFllYWgsIEkgdW5kZXJzdGFuZCB3aHkgd2Un
cmUgdXNpbmcgZ3JhbnQgbWFwcGluZ3MgaW5zdGVhZCBvZiBqdXN0DQo+PiBkaXJlY3RseSBo
YXZpbmcgYWNjZXNzIHZpYSBmb3JlaWdubWVtIG1hcHBpbmdzLiBUaGF0IHdhc24ndCB3aGF0
IEkgd2FzDQo+PiBjb25mdXNlZCBhYm91dC4NCj4+DQo+PiBXaGF0IEkgaGF2ZW4ndCB3b3Jr
ZWQgb3V0IGlzIHdoeSB3ZSdyZSBpbXBsZW1lbnRpbmcgdGhpcyB0aHJvdWdoIGFuDQo+PiBh
dXRvbWF0aWNhbGx5LXBvcHVsYXRlZCBNZW1vcnlSZWdpb24gaW4gUUVNVSwgcmF0aGVyIHRo
YW4ganVzdCB1c2luZw0KPj4gZ3JhbnQgbWFwcGluZyBvcHMgbGlrZSB3ZSBhbHdheXMgaGF2
ZS4NCj4+DQo+PiBJdCBzZWVtcyBsaWtlIGEgbG90IG9mIGNvbXBsZXhpdHkganVzdCB0byBh
dm9pZCBjYWxsaW5nDQo+PiBxZW11X3hlbl9nbnR0YWJfbWFwX3JlZnMoKSBmcm9tIHRoZSB2
aXJ0aW8gYmFja2VuZC4NCj4gDQo+IEkgdGhpbmsgdGhlcmUgYXJlIHR3byBxdWVzdGlvbnMg
aGVyZS4gT25lIHF1ZXN0aW9uIGlzICJXaHkgZG8gd2UgbmVlZA0KPiBhbGwgdGhlIG5ldyBn
cmFudCBtYXBwaW5nIGNvZGUgYWRkZWQgdG8geGVuLW1hcGNhY2hlLmMgaW4gcGF0Y2ggIzc/
DQo+IENhbid0IHdlIHVzZSBxZW11X3hlbl9nbnR0YWJfbWFwX3JlZnMoKSBpbnN0ZWFkPyIN
Cg0KVGhlIG1haW4gbW90aXZhdGlvbiB3YXMgdG8gX2F2b2lkXyBoYXZpbmcgdG8gY2hhbmdl
IGFsbCB0aGUgYmFja2VuZHMuDQoNCk15IGltcGxlbWVudGF0aW9uIGVuYWJsZXMgX2FsbF8g
cWVtdSBiYXNlZCB2aXJ0aW8gYmFja2VuZHMgdG8gdXNlIGdyYW50DQptYXBwaW5ncy4gQW5k
IGlmIGEgbmV3IGJhY2tlbmQgaXMgYWRkZWQgdG8gcWVtdSwgdGhlcmUgd2lsbCBiZSBubyBj
aGFuZ2UNCnJlcXVpcmVkIHRvIG1ha2UgaXQgd29yayB3aXRoIGdyYW50cy4NCg0KPiBBbmQg
dGhlIHNlY29uZCBxdWVzdGlvbiBpcyB3aGVyZSB0byBjYWxsIHRoZSBncmFudCBtYXBwaW5n
IGZyb20gKHdoZXRoZXINCj4gdGhlIG5ldyBjb2RlIG9yIHRoZSBvbGQgcWVtdV94ZW5fZ250
dGFiX21hcF9yZWZzIGNvZGUgaXQgZG9lc24ndA0KPiBtYXR0ZXIpLiBJdCBjb3VsZCBiZSBl
dmVuIHNpbXBsZXIgdGhhbiBjYWxsaW5nIGl0IGZyb20gdGhlIHZpcnRpbw0KPiBiYWNrZW5k
czogd2UgY291bGQganVzdCBjYWxsIGl0IGZyb20gdGhlIGV4aXN0aW5nIHFlbXVfcmFtX3B0
cl9sZW5ndGgoKQ0KPiBob29rLiBTZWUgdGhpcyBkaXNjdXNzaW9uOg0KPiBodHRwczovL21h
cmMuaW5mby8/bD1xZW11LWRldmVsJm09MTY5ODI4NDM0OTI3Nzc4DQoNCkkgd2FudGVkIHRv
IGJlIGV4cGxpY2l0IHdoZXJlIGFuZCB3aGVuIHRoZSBtYXBwaW5nIGFuZCB1bm1hcHBpbmcg
YXJlDQpoYXBwZW5pbmcuIEFkZGluZyB0aGUgbWFwcGluZyB0byBxZW11X3JhbV9wdHJfbGVu
Z3RoKCkgd291bGQgYmUgcHJvYmFibHkNCnBvc3NpYmxlLCBidXQgaXQgd291bGQgYmUgcXVp
dGUgaGFyZCB0byB2ZXJpZnkgdGhhdCBubyBkb3VibGUgbWFwcGluZ3MNCmFyZSBoYXBwZW5p
bmcuIEFuZCBJIGhhZCBwcm9ibGVtcyB3aXRoIHRoYXQgYXBwcm9hY2ggd2hlbiBxZW11IHdh
cyBzZXR0aW5nDQp1cCB0aGUgcmluZyBwYWdlIGFjY2Vzcy4NCg0KQWRkaW5nIGEgbWFwKCkg
YW5kIGFuIHVubWFwKCkgaG9vayBzZWVtZWQgdG8gYmUgdGhlIGNsZWFuZXN0IHNvbHV0aW9u
LCBldmVuDQppZiBpdCBuZWVkcyBtb3JlIGNvZGUgY2h1cm4uIFRoZSBxZW11X3JhbV9wdHJf
bGVuZ3RoKCkgYXBwcm9hY2ggc2VlbWVkIHRvIGJlDQptb3JlIGxpa2UgYSBoYWNrIHRoYW4g
YSBzb2x1dGlvbi4NCg0KDQpKdWVyZ2VuDQo=
--------------BZtmMjHWrzN4Bnc4Zh37x47G
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------BZtmMjHWrzN4Bnc4Zh37x47G--

--------------I4qNkJn56wsK2Ovo0yOx9fqC--

--------------c1lBvZPhxwJVYYXx50hDf0sV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmU7SkgFAwAAAAAACgkQsN6d1ii/Ey9N
9AgAl6B6JuEFZbEL/aPCh9i79ovsjX3o1bEyO4s0q4+pd0tRWsGUtUjZXfIeYzW8fTxfZSP2PlXX
d4zCnvsun8IJoI5taJYlA1A4VMbs/nomYhmtIqfYnjriQjvTD10WfxTHTlQluomTIDTO7Qd1Dq93
rzjT0vaM/fegLXwb2VXSIzRMc4r5Vfb0j30JGUgmt7YHZOmjtR6KBKIJ4pDDZvMeNLMIQW/DPJau
/hGfCO20VvUJUEk9ZQLqSCjgSHqXddO1iNOcZnd2VvYK8uyVAmhCbvrxCEuRqqXacxhLi4UiWA24
ELIjZ3S9/ZX826Tb/m49YJkz+Vr3mJtSrGCyjeFtaA==
=5mYm
-----END PGP SIGNATURE-----

--------------c1lBvZPhxwJVYYXx50hDf0sV--

