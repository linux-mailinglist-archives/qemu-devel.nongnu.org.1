Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2353373D7B9
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:24:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfe9-0000gt-KK; Mon, 26 Jun 2023 02:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erdnaxe@crans.org>)
 id 1qDfe6-0000gW-5e; Mon, 26 Jun 2023 02:24:18 -0400
Received: from redisdead.crans.org ([2a0c:700:2::ff:fe01:2402])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erdnaxe@crans.org>)
 id 1qDfe3-00063S-RQ; Mon, 26 Jun 2023 02:24:17 -0400
Received: from [192.168.1.35] (lcs07-lyo-176-188-229-245.sfr.lns.abo.bbox.fr
 [176.188.229.245])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by redisdead.crans.org (Postfix) with ESMTPSA id 0E0492B0;
 Mon, 26 Jun 2023 08:23:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crans.org; s=mail;
 t=1687760640; bh=i79IuxnAmv/lCC14GxyxC1VDPkpud/SzVtUk0jmjyng=;
 h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
 b=J7LYNdPn2QmLRBt6tQByZZ9OIUGGNAMTBk+uCWHCGFEvHBPCujPp7qyVX2TAx8lPg
 E6YQ3yQBagPhhpRTCCyiOK0hgw/lwdlGcc3jUvdt9dBM8oXUT1UBjnhJcJYoMK55UR
 MaiIcoPD9fw6bkiV8elVpiett+nbFF5z2EcWJN/1+KDwNN6FOEL1Ps0fDAGongnmey
 zcR+/LXAg4bxqztAMFyQ83wpQ41GaDWyvrQwvOkFM+nnQKtTT3GpQY53fGypUOaRE+
 WM0zWmRJBu1IYefuRpSBvyp7+cLFWMiyjloskkClXP3F1XS4tXOT544Ys6dH83UmYn
 VylWPUWwrq5cv54hbDq4pFR2zEpH7WgeGs/qPHAuAxWgvXSk/UL+weumSj5AyVoDzW
 msuHyN6ZTH72kfr28O6aZD0qHz1Qhb7vTvLP2FYGTGYrp42nQu5T6Qp50/Kv5OcjRr
 A/gioDhlk47sjAVNKT3ILQWaueNIsiKQkInFIGE8xy/PWuQ6lLn2Hq+bfrQwvWnaXu
 nXyxm3oS+5ztsYaC16wI17vxvndYz5zB2Sm/RIchPMoh1CYycs74b9/zMsG0UCivEa
 W3JljiKhgmlRjjvkhR34DZjc9AH0mqLz1rKQ8XclqgyRYie1X3IQrNy9FM9AxzUqmI
 o7/tJV+QPhPwqazT4oij+/ak=
Message-ID: <6fa294a1-1f1f-7f30-add0-bb49f7d04a65@crans.org>
Date: Mon, 26 Jun 2023 08:23:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Lucas Villa Real <lucas@osdyne.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20230619221819.6882-1-lucas@osdyne.com>
Content-Language: en-US
From: Alexandre IOOSS <erdnaxe@crans.org>
Organization: Crans
Subject: Re: [PATCH] STM32F100: support different density lines
In-Reply-To: <20230619221819.6882-1-lucas@osdyne.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hG1mjlQiT3T5vtgj16DBqeMj"
Received-SPF: pass client-ip=2a0c:700:2::ff:fe01:2402;
 envelope-from=erdnaxe@crans.org; helo=redisdead.crans.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
--------------hG1mjlQiT3T5vtgj16DBqeMj
Content-Type: multipart/mixed; boundary="------------BR0DOpDE40zcfg32V3TqrLc6";
 protected-headers="v1"
From: Alexandre IOOSS <erdnaxe@crans.org>
To: Lucas Villa Real <lucas@osdyne.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <6fa294a1-1f1f-7f30-add0-bb49f7d04a65@crans.org>
Subject: Re: [PATCH] STM32F100: support different density lines
References: <20230619221819.6882-1-lucas@osdyne.com>
In-Reply-To: <20230619221819.6882-1-lucas@osdyne.com>

--------------BR0DOpDE40zcfg32V3TqrLc6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNi8yMC8yMyAwMDoxOCwgTHVjYXMgVmlsbGEgUmVhbCB3cm90ZToNCj4gVGhpcyBwYXRj
aCBhZGRzIHN1cHBvcnQgZm9yIHRoZSBlbXVsYXRpb24gb2YgZGlmZmVyZW50IGRlbnNpdHkg
bGluZXMNCj4gKGxvdywgbWVkaXVtLCBhbmQgaGlnaCkuIEEgbmV3IGNsYXNzIHByb3BlcnR5
IHN0bTMyZjEwMC1zb2MuZGVuc2l0eT0NCj4gaGFzIGJlZW4gaW50cm9kdWNlZCB0byBhbGxv
dyB1c2VycyB0byBzdGF0ZSB0aGUgZGVzaXJlZCBjb25maWd1cmF0aW9uLg0KPiBUaGF0IHBy
b3BlcnR5IGlzIHJlY29nbml6ZWQgYnkgYSBuZXcgbWFjaGluZSwgc3RtMzJmMS1nZW5lcmlj
LiBUaGUgU09DDQo+IGlzIGNvbmZpZ3VyZWQgYWNjb3JkaW5nIHRvIHRoZSBmb2xsb3dpbmc6
DQo+IA0KPiAgICAgZGVuc2l0eT1sb3cgICAgICAgMzIgS0IgRkxBU0gsIDIgU1BJcw0KPiAg
ICAgZGVuc2l0eT1tZWRpdW0gICAxMjggS0IgRkxBU0gsIDIgU1BJcw0KPiAgICAgZGVuc2l0
eT1oaWdoICAgICA1MTIgS0IgRkxBU0gsIDMgU1BJcw0KPiANCj4gV2l0aCB0aGlzIGNvZGUg
Y2hhbmdlIHdlIHNob3VsZCBiZSBhYmxlIHRvIGludHJvZHVjZSByaWNoZXIgZmVhdHVyZXMN
Cj4gdG8gU1RNMzJGMTAwLCBzdWNoIGFzIHN1cHBvcnQgZm9yIEZTTUMgKHNvIHRoYXQgYSBt
YWNoaW5lIHdpdGggbW9yZQ0KPiBSQU0gY2FwYWNpdHkgY2FuIGJlIHByb3Blcmx5IGVtdWxh
dGVkKS4gRlNNQyBpcyBzdXBwb3J0ZWQgb24gaGlnaA0KPiBkZW5zaXR5IGxpbmUgZGV2aWNl
cyBvbmx5Lg0KDQpUaGFua3MgYSBsb3QgZm9yIHRoZSBwYXRjaGVzIQ0KDQpTVE0zMiBmYW1p
bGllcyBsb29rIHZlcnkgc2ltaWxhciB0byBlYWNoIG90aGVyLCBpdCBtYWtlcyBncmVhdCBz
ZW5zZSB0byANCnRha2UgYSBnZW5lcmljIGFwcHJvYWNoIHJhdGhlciB0aGFuIGJsb2F0aW5n
IFFFTVUgd2l0aCBtYW55IG1hY2hpbmVzLg0KDQpZb3UgcGF0Y2ggcHJvcG9zZXMgdG8gY3Jl
YXRlIGEgInN0bTMyZjEtZ2VuZXJpYyIgbWFjaGluZS4gSSBiZWxpZXZlIHdlIA0Kc2hvdWxk
IHJhdGhlciBuYW1lIHRoaXMgbWFjaGluZSAic3RtMzJmMTAwLWdlbmVyaWMiOg0KICAgLSBT
VE0zMkYxMDEgaGFzIGEgWEwtZGVuc2l0eSBsaW5lLCBTVE0zMkYxMDAgZG9lcyBub3QgaGF2
ZSBhIA0KWEwtZGVuc2l0eSBsaW5lLg0KICAgLSBTVE0zMkYxMDAgaGlnaCBkZW5zaXR5IGxp
bmUgZG9lcyBub3QgaGF2ZSB0aGUgc2FtZSBtYXhpbXVtIFNSQU0gDQpzaXplLCB0aW1lcnMs
IFVTQVJUIG51bWJlcnMsIGNsb2NrIGZyZXF1ZW5jaWVzIGFuZCBDRUMgcGVyaXBoZXJhbHMg
YXMgDQp0aGUgU1RNMzJGMTAxIGhpZ2ggZGVuc2l0eSBsaW5lLg0KDQpSZWdhcmRpbmcgdGhl
IHN0bTMydmxkaXNjb3ZlcnkgbWFjaGluZSwgSSBhbSBub3QgYWdhaW5zdCBkZXByZWNhdGlu
ZyBpdCANCmlmIHdlIHdhcm4gdXNlcnMgdG8gdXNlIHN0bTMyZjEwMC1nZW5lcmljIHdpdGgg
ZGVuc2l0eT1tZWRpdW0uIFRoaXMgDQptYWtlcyBzZW5zZSBhcyB0aGUgZGV2ZWxvcG1lbnQg
Ym9hcmQgZG9lcyBub3QgYWRkIGFueXRoaW5nIG1vcmUgdGhhbiANCmp1c3Qgc29tZSBidXR0
b25zIGFuZCBMRUQuDQpNYXliZSAic3RtMzJ2bGRpc2NvdmVyeSIgY291bGQgYmVjb21lIGFu
IGFsaWFzIGZvciBzdG0zMmYxMDAtZ2VuZXJpYyANCm1hY2hpbmUgPw0KQEFsaXN0YWlyOiBE
byB5b3UgaGF2ZSBhbiBvcGluaW9uIG9uIGFsaWFzaW5nIHRoZSBvbGQgbWFjaGluZT8gSXMg
dGhpcyANCnNvbWV0aGluZyBjb21tb24gaW4gUUVNVT8NCg0KSW4gdGhlIGxvbmcgcnVuLCB3
ZSBzaG91bGQgbWF5YmUgcmVuYW1lICJzdG0zMmYxMDAtc29jLmMiIHRvIA0KInN0bTMyZjEt
c29jLmMiIGFuZCBhZGQgYW5vdGhlciBjbGFzcyBwcm9wZXJ0eSB0byBjaG9vc2UgdGhlIHN1
Yi1mYW1pbHkuIA0KVGhpcyB3b3VsZCBoaWdobHkgcmVkdWNlIHBvdGVudGlhbCBjb2RlIGR1
cGxpY2F0aW9uLg0KU1RNMzJGMSBtYWNoaW5lcyBjb3VsZCB0YWtlIHRoaXMgc3RydWN0dXJl
Og0KICAtIHN0bTMyZjEwMC1nZW5lcmljIG1hY2hpbmUNCiAgICAtIHN0bTMyZjEtc29jLmZh
bWlseT1mMTAwIHN0bTMyZjEtc29jLmRlbnNpdHk9bG93DQogICAgLSBzdG0zMmYxLXNvYy5m
YW1pbHk9ZjEwMCBzdG0zMmYxLXNvYy5kZW5zaXR5PW1lZGl1bQ0KICAgICAgKGFsaWFzIHN0
bTMydmxkaXNjb3ZlcnkpDQogICAgLSBzdG0zMmYxLXNvYy5mYW1pbHk9ZjEwMCBzdG0zMmYx
LXNvYy5kZW5zaXR5PWhpZ2gNCiAgLSBzdG0zMmYxMDEtZ2VuZXJpYyBtYWNoaW5lDQogICAg
LSBzdG0zMmYxLXNvYy5mYW1pbHk9ZjEwMSBzdG0zMmYxLXNvYy5kZW5zaXR5PWxvdw0KICAg
IC0gc3RtMzJmMS1zb2MuZmFtaWx5PWYxMDEgc3RtMzJmMS1zb2MuZGVuc2l0eT1tZWRpdW0N
CiAgICAtIHN0bTMyZjEtc29jLmZhbWlseT1mMTAxIHN0bTMyZjEtc29jLmRlbnNpdHk9aGln
aA0KICAgIC0gc3RtMzJmMS1zb2MuZmFtaWx5PWYxMDEgc3RtMzJmMS1zb2MuZGVuc2l0eT14
bA0KICAtIHN0bTMyZjEwMi1nZW5lcmljIG1hY2hpbmUNCiAgICAtIHN0bTMyZjEtc29jLmZh
bWlseT1mMTAyIHN0bTMyZjEtc29jLmRlbnNpdHk9bG93DQogICAgLSBzdG0zMmYxLXNvYy5m
YW1pbHk9ZjEwMiBzdG0zMmYxLXNvYy5kZW5zaXR5PW1lZGl1bQ0KICAtIHN0bTMyZjEwMy1n
ZW5lcmljIG1hY2hpbmUNCiAgICAtIHN0bTMyZjEtc29jLmZhbWlseT1mMTAzIHN0bTMyZjEt
c29jLmRlbnNpdHk9bG93DQogICAgLSBzdG0zMmYxLXNvYy5mYW1pbHk9ZjEwMyBzdG0zMmYx
LXNvYy5kZW5zaXR5PW1lZGl1bQ0KICAgICAgKGFsaWFzIHN0bTMyLW51Y2xlby1mMTAzcmIp
DQogICAgLSBzdG0zMmYxLXNvYy5mYW1pbHk9ZjEwMyBzdG0zMmYxLXNvYy5kZW5zaXR5PWhp
Z2gNCiAgICAtIHN0bTMyZjEtc29jLmZhbWlseT1mMTAzIHN0bTMyZjEtc29jLmRlbnNpdHk9
eGwNCkBBbGlzdGFpcjogV291bGQgc3VjaCBtb2RpZmljYXRpb24gbWFrZSBhbHNvIHNlbnNl
IHJlZ2FyZGluZyBzdG0zMmYyIGFuZCANCnN0bTMyZjQgZmFtaWxpZXM/DQoNClRoYW5rcywN
Ci0tIA0KQWxleGFuZHJlDQo=

--------------BR0DOpDE40zcfg32V3TqrLc6--

--------------hG1mjlQiT3T5vtgj16DBqeMj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEELTca0n4rvHeX4bdZbHknjz/NzAIFAmSZLv4FAwAAAAAACgkQbHknjz/NzAIk
FA/+MwAIvUFATyBS08D0LSmzfyRS80K0A8lr/L8ES+NeUCd/hkEcIi+LlnWU1/d/6GrRfVJJcNxb
0HTnFuP0UjHRjXsPTcOA2ntNZXWnBQl7wo1uOXqsoklnwlZEdLhKqRA346pincX943JTvFzRXOyN
uDTeb/QaOmybQxZkwyIDahZXJR4adIoVhRsoc+vE0HjZ6DSABG4H0WTz4dP7aEyhKELk3h6PPZau
98xnpttVawrj5AvIpV4mTviE1GaMimmVpXmm7/RjYeZ/QN18o7+hZMqKxSDlN+9jQMP0r6BFquyn
mP+7+YxkM6gQHMBX4znyokZ+dZEU+Y9V/uhZoo/EzS7TmWES3WdRnCcZIF5dzGrofvcYXa4hc799
wgeQaBPLu8YlzslyW05Fpm1OHTSS2vwftVgnBPFfPeUt0grp+RC5q4PU7d3WKLDZmNXbJJtiE3vI
xLlQV4MZPbc8H1gwMRTK4bxUGFEMm88QJwIzt/m65wODMnXqePYRaM4XWGyrDSDuUasivjCZFzVK
2mk24W2MjyRGL+TkhR3+EK+TW8imKwfgMUJIZVzA4BAL6YJ2ZsbMOLz7U/omYBmRoLyoGV/fvGVZ
e7RDOZzl2eX97GG/eNP/8Y3uOLxy/PGIoT/3rz0QK//CRTwwlI+FUDWNHajnfJikJ1HkCl/qiBj2
ZTw=
=1uV/
-----END PGP SIGNATURE-----

--------------hG1mjlQiT3T5vtgj16DBqeMj--

