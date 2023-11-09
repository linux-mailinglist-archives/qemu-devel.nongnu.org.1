Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F4D7E6B20
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:19:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r14vS-0002Hq-HO; Thu, 09 Nov 2023 08:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hans@keasigmadelta.com>)
 id 1r14vQ-0002HX-MG
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 08:18:24 -0500
Received: from mail-40136.proton.ch ([185.70.40.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hans@keasigmadelta.com>)
 id 1r14vM-0003TM-LZ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 08:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keasigmadelta.com;
 s=protonmail3; t=1699535894; x=1699795094;
 bh=Q8gUqIZec7eoD5jot3TYaCxuayHowpSJ0Zt/E4CwzSM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Q/XOmi6D+lVDzqbv8e/UECIAiOSxF869Ty4jgKUgHnP2Lk/ucCz/EmgH2wagxh1Xt
 4sdOW0xOibcoa9pqIvELXm8EyYHx9vu6Td3NZPbtVvOz9yqAPGuG1W+iSuxOV8TVH4
 8AXcnUrOs6LMfc7dtB8lHdWw2pBnMO6TN2BxvWmE16M+I7dTnsbXSzBlA9EIsysJI0
 8ehglLHxo5i2HEBZmcRNQusvO9XEvaAJTT+lEx65JnqKeEUp+t6jY5KzjHpL4iR/Nk
 Z3lYLk2wROfOB1oFq/A9mH7A5AKHi2trDe52DiCj4DkF6KIcVfbDe+2EAbu0Lsoyx7
 DqAK/4Z84Mgaw==
Date: Thu, 09 Nov 2023 13:17:51 +0000
To: Huang Rui <ray.huang@amd.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
From: Hans de Ruiter <hans@keasigmadelta.com>
Cc: Antonio Caggiano <quic_acaggian@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Gert Wollny <gert.wollny@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: QEMU Virtio GPU features status & roadmap?
Message-ID: <f029de29-1274-48a5-b261-6192253a225a@keasigmadelta.com>
In-Reply-To: <ZUyUwf3e6d8njOW3@amd.com>
References: <65466251-5c0c-90d0-c482-29ebc4e16a20@keasigmadelta.com>
 <6c565178-f34c-57f9-90be-25b2c738b068@quicinc.com>
 <CAJ+F1CK6Y-DqHTfC4u7EUhdgK0T++KTvvus6mqnRz-a9v-HQyQ@mail.gmail.com>
 <ZUyUwf3e6d8njOW3@amd.com>
Feedback-ID: 32757310:user:proton
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------490c9493e88079bfda339d8fc275edf926c7ed219473c6964d75ad0d2de30133";
 charset=utf-8
Received-SPF: pass client-ip=185.70.40.136;
 envelope-from=hans@keasigmadelta.com; helo=mail-40136.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------490c9493e88079bfda339d8fc275edf926c7ed219473c6964d75ad0d2de30133
Content-Type: multipart/mixed;
 boundary=3645f254e8fa86bb5ad37437d8c03a21e5e7dbdd574510fa253dbb36950b
Message-ID: <f029de29-1274-48a5-b261-6192253a225a@keasigmadelta.com>
Date: Thu, 9 Nov 2023 21:17:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU Virtio GPU features status & roadmap?
To: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Antonio Caggiano <quic_acaggian@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Gert Wollny <gert.wollny@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <65466251-5c0c-90d0-c482-29ebc4e16a20@keasigmadelta.com>
 <6c565178-f34c-57f9-90be-25b2c738b068@quicinc.com>
 <CAJ+F1CK6Y-DqHTfC4u7EUhdgK0T++KTvvus6mqnRz-a9v-HQyQ@mail.gmail.com>
 <0s7yVk-7G_804IwNoDhyUN9ad7OuTUQ247AtSp2BpMxuhulY_PAy5q03AMYp3MtBrzEXvjUP7CTSDhrGDmqG3A==@protonmail.internalid>
 <ZUyUwf3e6d8njOW3@amd.com>
Content-Language: en-US
From: Hans de Ruiter <hans@keasigmadelta.com>
In-Reply-To: <ZUyUwf3e6d8njOW3@amd.com>

--3645f254e8fa86bb5ad37437d8c03a21e5e7dbdd574510fa253dbb36950b
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8; format=flowed

SGkgZXZlcnlvbmUsDQoNClRoYW5rcyBmb3IgdGhlIGluZm8uIEl0J3MgZ3JlYXQgdG8gaGVhciB0
aGF0IHRoaW5ncyBhcmUgcHJvZ3Jlc3NpbmcuIEluIA0KdGhlIG1lYW50aW1lLCBJJ3ZlIHN0YXJ0
ZWQgd29ya2luZyB3aXRoIFZpcnRpbyBHUFUgaW4gaXRzIGN1cnJlbnQgc3RhdGUgDQpvbiBRRU1V
J3MgbWFzdGVyIGJyYW5jaC4gSSB0aGluayBJJ3ZlIG1hbmFnZWQgdG8gZmluZCBhIHdvcmthcm91
bmQgZm9yIA0KdGhlIGRpcmVjdCBWUkFNIGFjY2Vzcy4NCg0KQlRXLCBpcyB0aGVyZSBhbnkgb2Zm
aWNpYWwgZG9jdW1lbnRhdGlvbiBmb3IgVmlyR0wsIFZlbnVzLCBldGMuPyBPciBpcyANCnRoYXQg
eWV0IHRvIGJlIHdyaXR0ZW4/DQoNCnJlZ2FyZHMsDQpIYW5zDQoNCg0KT24gOS8xMS8yMyAxNjox
MywgSHVhbmcgUnVpIHdyb3RlOg0KPiBPbiBXZWQsIE5vdiAwOCwgMjAyMyBhdCAwNzowNzo0M1BN
ICswODAwLCBNYXJjLUFuZHLDqSBMdXJlYXUgd3JvdGU6DQo+PiBIaQ0KPj4NCj4+IE9uIFdlZCwg
Tm92IDgsIDIwMjMgYXQgMTowNOKAr1BNIEFudG9uaW8gQ2FnZ2lhbm8NCj4+IDxxdWljX2FjYWdn
aWFuQHF1aWNpbmMuY29tPiB3cm90ZToNCj4+PiBIaSBIYW5zLA0KPj4+DQo+Pj4gK2NjIEdlcnQg
YW5kIERtaXRyeQ0KPj4+DQo+Pj4gT24gMTcvMTAvMjAyMyAwMjo0OCwgSGFucyBkZSBSdWl0ZXIg
d3JvdGU6DQo+Pj4+IEhpLA0KPj4+Pg0KPj4+PiBJJ20gd29ya2luZyBvbiBWaXJ0aW8gR1BVIGRy
aXZlcnMgZm9yIEFtaWdhT1MsIGFuZCB3b3VsZCBsaWtlIHRvIGtub3cNCj4+Pj4gd2hhdCBmZWF0
dXJlcyBhcmUgY3VycmVudGx5IHN0YWJsZSBlbm91Z2ggdG8gdXNlLiBMb29raW5nIGF0IHRoZSBt
YXN0ZXINCj4+Pj4gUUVNVSBicmFuY2gsIGJvdGggVmlyZ2wgYW5kIGJsb2IgcmVzb3VyY2VzIGFy
ZSBzdXBwb3J0ZWQsIGJ1dCBOT1QgYXQgdGhlDQo+Pj4+IHNhbWUgdGltZS4gSXMgdGhlIGFiaWxp
dHkgdG8gdXNlIGJvdGggc2ltdWx0YW5lb3VzbHkgY29taW5nIHNvb24/DQo+Pj4+DQo+Pj4gTW1o
LCB3ZWxsLCB0aGV5IHNob3VsZCBiZSBjb21wYXRpYmxlLCBJJ2xsIHRyeSBzZW5kaW5nIGEgcGF0
Y2guDQo+Pj4NCj4+Pj4gQWxzbywgd2hhdCdzIHRoZSBzdGF0ZSBvZiBWZW51cy9WdWxrYW4gc3Vw
cG9ydD8gU3VydmV5aW5nIHZhcmlvdXMNCj4+Pj4gZm9ya3MvYnJhbmNoZXMsIGl0IGxvb2tzIHZl
cnkgZXhwZXJpbWVudGFsIGFuZCBzdWJqZWN0IHRvIGNoYW5nZS4NCj4+Pj4NCj4+PiBJIGJlbGll
dmUgdGhpcyBpcyBxdWl0ZSBzdGFibGUgbm93Og0KPj4+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNr
dG9wLm9yZy92aXJnbC92ZW51cy1wcm90b2NvbC8tL2lzc3Vlcy81DQo+PiBUaGUgbGFzdCBwYXRj
aCBzZXJpZXMgZm9yIFFFTVUgaXMgZnJvbSBIdWFuZyBSdWk6DQo+PiBodHRwczovL3BhdGNoZXcu
b3JnL1FFTVUvMjAyMzA5MTUxMTExMzAuMjQwNjQtMS1yYXkuaHVhbmdAYW1kLmNvbS8NCj4gSSBh
bSB3b3JraW5nIG9uIFY2LCBhbmQgd2lsbCBzZW5kIHRoZW0gb3V0IHZlcnkgc29vbi4NCj4NCj4g
VGhhbmtzLA0KPiBSYXkNCj4NCj4+PiBWaXJnbHJlbmRlcmVyIDEuMC4wIGhhcyBiZWVuIHJlbGVh
c2VkIGFzIHdlbGwuIEkgd29uZGVyIGlmIHRoYXQgcmVxdWlyZXMNCj4+PiBhbnkgY2hhbmdlIGlu
IFFFTVUuIEdlcnQgb3IgRG1pdHJ5IG1pZ2h0IGtub3cgdGhlIGFuc3dlci4NCj4+IE5vIGNoYW5n
ZXMgcmVxdWlyZWQgYWZhaWsuDQo+Pg0KPj4+PiBJIGhhdmUgdGhlIGFkZGVkIGRpZmZpY3VsdHkg
dGhhdCB0aGUgQW1pZ2FPUyBQaWNhc3NvOTYgZHJpdmVyIEFQSQ0KPj4+PiBleHBlY3RzIGRpcmVj
dCBDUFUgYWNjZXNzIHRvIGFsbCBvZiBWUkFNLCBhbmQgbGlrZXMgdG8gcGVlay9wb2tlDQo+Pj4+
IGRpcmVjdGx5IGludG8gdGhlIGJpdG1hcHMuIFRoYXQncyBjbGVhcmx5IG5vdCBwb3NzaWJsZSB3
aXRob3V0IGJsb2INCj4+Pj4gcmVzb3VyY2VzLCBvciBzaGFyZWQgbWVtb3J5IChub3QgZW50aXJl
bHkgc3VyZSB3aGF0IHRoZSBzaGFyZWQgbWVtb3J5DQo+Pj4+IGZlYXR1cmUgaXMgZm9yKS4gVGhp
cyBpcyB3aHkgSSB3YW50IHRvIGtub3cgd2hhdCBmZWF0dXJlcyBhcmUgc3RhYmxlIG9yDQo+Pj4+
IGNvbWluZyBzb29uLg0KPj4+Pg0KPj4+IFRoZSBzaGFyZWQgbWVtb3J5IGZlYXR1cmUgaXMganVz
dCBhIHJlcXVpcmVtZW50IHdoaWNoIGVuYWJsZXMgc3VwcG9ydA0KPj4+IGZvciBibG9iIHJlc291
cmNlcy4NCj4+IE5vdyB0aGF0IHdlIGFyZSBpbiBmcmVlemUsIHdlIHdvbid0IG1lcmdlIG5ldyBm
ZWF0dXJlcyB1bnRpbCB0aGUgZW5kDQo+PiBvZiB0aGlzIHllYXIgLyBuZXh0IHllYXIuIEJ1dCB3
ZSBjYW4gYWxyZWFkeSBwbGFuIC8gdGVzdCAvIHJldmlldyBldGMuDQo+Pg0KPj4gQW50b25pbywg
ZG8geW91IGhhdmUgeW91ciB3b3JrIGNvb3JkaW5hdGVkIHdpdGggSHVhbmc/DQo+Pg0KPj4gSHVh
bmcsIGFyZSB5b3UgZ29pbmcgdG8gc2VuZCBhIG5ldyB2ZXJzaW9uIG9mIHRoZSB2ZW51cyBzZXJp
ZXM/DQo+Pg0KPj4gSXQgd291bGQgYmUgZ3JlYXQgdG8gaW5jbHVkZSBkb2NzL3N5c3RlbS9kZXZp
Y2VzL3ZpcnRpby1ncHUucnN0DQo+PiB1cGRhdGVzIHRvby4gSXQncyBnZXR0aW5nIGRpZmZpY3Vs
dCB0byBmb2xsb3cgdGhlIHZhcmlvdXMgd2F5cw0KPj4gdmlydGlvLWdwdSBjYW4gYmUgdXNlZCBu
b3dhZGF5cy4NCj4+DQo+PiB0aGFua3MNCj4+DQo+PiAtLQ0KPj4gTWFyYy1BbmRyw6kgTHVyZWF1
DQo=
--3645f254e8fa86bb5ad37437d8c03a21e5e7dbdd574510fa253dbb36950b
Content-Transfer-Encoding: base64
Content-Disposition: attachment; name="publickey - hans@keasigmadelta.com -
 4293c311.asc"; filename="publickey - hans@keasigmadelta.com - 4293c311.asc"
Content-Type: application/pgp-keys; name="publickey - hans@keasigmadelta.com
 - 4293c311.asc"; filename="publickey - hans@keasigmadelta.com -
 4293c311.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdvcGVuUEdQIDIu
Ny4xCkNvbW1lbnQ6IGh0dHBzOi8vZ29wZW5wZ3Aub3JnCgp4ak1FWUZocFFoWUpLd1lCQkFIYVJ3
OEJBUWRBUEFDckNETHVSSkZPbVl3Mm02a3FxK3VOTlVVbloxYzFlUU5hCmo4TUxZL25OTDJoaGJu
TkFhMlZoYzJsbmJXRmtaV3gwWVM1amIyMGdQR2hoYm5OQWEyVmhjMmxuYldGa1pXeDAKWVM1amIy
MCt3bzhFRUJZS0FDQUZBbUJZYVVJR0N3a0hDQU1DQkJVSUNnSUVGZ0lCQUFJWkFRSWJBd0llQVFB
aApDUkNZL1hnVzF6ckt6aFloQkVLVHd4SFJvelIxamI0OVQ1ajllQmJYT3NyT2I2Y0EvalhkMUhk
V2paQkV6WUNqCjlmUitEWm5DREplbjNRYzhNRzU0TW9CZHZLZ0FBUDlvM3dqMGhpVXh4RXJhUjhs
U0tZMGhOVnBwR2Nrb0pLeUIKRlRXR25VRU9BODQ0QkdCWWFVSVNDaXNHQVFRQmwxVUJCUUVCQjBE
NS9xRWphWUU4MWs4R095OFF1RmNGbGZmWgpWbEw2M1ZsMThWZ3pONXJnSWdNQkNBZkNlQVFZRmdn
QUNRVUNZRmhwUWdJYkRBQWhDUkNZL1hnVzF6ckt6aFloCkJFS1R3eEhSb3pSMWpiNDlUNWo5ZUJi
WE9zck9zZXNBL2p5a0taQksxZ3JIVldWalFCbC9iMlVRVk1RVUhDUDkKdjdsM1p4QkZxaGlXQVFD
UjdjSWtrZ1ZvL1JXUzh5NG9MUXdZNjRQM0tzazRYOHpBZHBjOVl3MDhEQT09Cj0zL0llCi0tLS0t
RU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0=
--3645f254e8fa86bb5ad37437d8c03a21e5e7dbdd574510fa253dbb36950b--

--------490c9493e88079bfda339d8fc275edf926c7ed219473c6964d75ad0d2de30133
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmVM2/0JkJj9eBbXOsrOFiEEQpPDEdGjNHWNvj1PmP14Ftc6
ys4AAOq8AP9amRxCjl5HoMD7hiHQFozNEouTHNelBxBfWSBqPAp7zQEAkLdW
guYj4/eUqC5OF/JEHCTGWQl1ozZ0bNHNDlJvlwU=
=VIBq
-----END PGP SIGNATURE-----


--------490c9493e88079bfda339d8fc275edf926c7ed219473c6964d75ad0d2de30133--


