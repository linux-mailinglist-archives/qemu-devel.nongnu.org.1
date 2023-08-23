Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C23785B14
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:50:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpAo-0005OD-E2; Wed, 23 Aug 2023 10:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logoerthiner1@163.com>)
 id 1qYpA5-0005Kr-EN; Wed, 23 Aug 2023 10:48:45 -0400
Received: from m1368.mail.163.com ([220.181.13.68])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <logoerthiner1@163.com>)
 id 1qYpA0-000666-JP; Wed, 23 Aug 2023 10:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=xG1U2UMaL3Q4+Cwnpn0JHdhQDWNYASelwZVhr5H9KpQ=; b=N
 OfpoNzv4eJEt7zVOJYW3YEBj8RS1tA9KO9RwShfQQKXHh1EszUPASZpPCIxAlX0v
 Rp/PPliSCljBQDpEelWW4mACmayq/CGbefVkwQmq8BJUYYBW2ndr93ZQeD/GVpTE
 sUIOUQQF6h/C/uUShjVU6ZWuCvIiR6n+IzSz43vOVA=
Received: from logoerthiner1$163.com ( [42.84.232.221] ) by
 ajax-webmail-wmsvr68 (Coremail) ; Wed, 23 Aug 2023 22:47:39 +0800 (CST)
X-Originating-IP: [42.84.232.221]
Date: Wed, 23 Aug 2023 22:47:39 +0800 (CST)
From: ThinerLogoer  <logoerthiner1@163.com>
To: "David Hildenbrand" <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 "Paolo Bonzini" <pbonzini@redhat.com>, "Peter Xu" <peterx@redhat.com>, 
 "Igor Mammedov" <imammedo@redhat.com>, 
 =?GBK?Q?Philippe_Mathieu-Daud=A8=A6?= <philmd@linaro.org>, 
 =?GBK?Q?Daniel_P_=2E_Berrang=A8=A6?= <berrange@redhat.com>, 
 "Stefan Hajnoczi" <stefanha@redhat.com>, 
 "Elena Ufimtseva" <elena.ufimtseva@oracle.com>, 
 "Jagannathan Raman" <jag.raman@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, "Ani Sinha" <anisinha@redhat.com>, 
 "Xiao Guangrong" <xiaoguangrong.eric@gmail.com>, 
 "Daniel Henrique Barboza" <danielhb413@gmail.com>, 
 "Greg Kurz" <groug@kaod.org>, "Eric Blake" <eblake@redhat.com>, 
 "Markus Armbruster" <armbru@redhat.com>, 
 "Eduardo Habkost" <eduardo@habkost.net>
Subject: Re:Re: [PATCH v2 3/9] backends/hostmem-file: Add "rom" property to
 support VM templating with R/O files
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <049b3601-5d57-d772-8365-a3e9bf9f03bc@redhat.com>
References: <20230822114504.239505-1-david@redhat.com>
 <20230822114504.239505-4-david@redhat.com>
 <5537a603.478c.18a1da37f4a.Coremail.logoerthiner1@163.com>
 <049b3601-5d57-d772-8365-a3e9bf9f03bc@redhat.com>
X-NTES-SC: AL_QuySAPSbvUgu7yOQbOkXnk4Shuc2XMu4u/gu34JTP5E0mSrL8yIhRXBeAFbJwtKpNCCXvxelbhFR6uJnZrZbQa3gPd+zR44r+jmZW26+OKPp
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <79eeb4c6.8f5c.18a22dd8c80.Coremail.logoerthiner1@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: RMGowAB3J7ELHOZkRskZAA--.10160W
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/xtbBawvUnlet+DVg2AAAsl
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.68; envelope-from=logoerthiner1@163.com;
 helo=m1368.mail.163.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

QXQgMjAyMy0wOC0yMyAyMDo0Mzo0OCwgIkRhdmlkIEhpbGRlbmJyYW5kIiA8ZGF2aWRAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4+PiArICAgICAgICBUaGUgYGByb21gYCBvcHRpb24gc3BlY2lmaWVzIHdo
ZXRoZXIgdG8gY3JlYXRlIFJlYWQgT25seSBNZW1vcnkgKFJPTSkKPj4+ICsgICAgICAgIHRoYXQg
Y2Fubm90IGJlIG1vZGlmaWVkIGJ5IHRoZSBWTS4gSWYgc2V0IHRvIGBgb25gYCwgdGhlIFZNIGNh
bm5vdAo+Pj4gKyAgICAgICAgbW9kaWZ5IHRoZSBtZW1vcnkuIElmIHNldCB0byBgYG9mZmBgLCB0
aGUgVk0gY2FuIG1vZGlmeSB0aGUgbWVtb3J5Lgo+Pj4gKyAgICAgICAgSWYgc2V0IHRvIGBgYXV0
b2BgIChkZWZhdWx0KSwgdGhlIHZhbHVlIG9mIHRoZSBgYHJlYWRvbmx5YGAgcHJvcGVydHkKPj4+
ICsgICAgICAgIGlzIHVzZWQuIFRoaXMgb3B0aW9uIGlzIHByaW1hcmlseSBoZWxwZnVsIGZvciBW
TSB0ZW1wbGF0aW5nLCB3aGVyZSB3ZQo+Pj4gKyAgICAgICAgd2FudCB0byBvcGVuIGEgZmlsZSBy
ZWFkb25seSAoYGByZWFkb25seT1vbmBgKSBhbmQgYWxsb3cgcHJpdmF0ZQo+Pj4gKyAgICAgICAg
bW9kaWZpY2F0aW9ucyBvZiB0aGUgbWVtb3J5IGJ5IHRoZSBWTSAoYGBzaGFyZT1vZmZgYCwgYGBy
b209b2ZmYGApLgo+Pj4gKwo+Pj4gICAgICBgYC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtcmFtLGlk
PWlkLG1lcmdlPW9ufG9mZixkdW1wPW9ufG9mZixzaGFyZT1vbnxvZmYscHJlYWxsb2M9b258b2Zm
LHNpemU9c2l6ZSxob3N0LW5vZGVzPWhvc3Qtbm9kZXMscG9saWN5PWRlZmF1bHR8cHJlZmVycmVk
fGJpbmR8aW50ZXJsZWF2ZWBgCj4+PiAgICAgICAgICBDcmVhdGVzIGEgbWVtb3J5IGJhY2tlbmQg
b2JqZWN0LCB3aGljaCBjYW4gYmUgdXNlZCB0byBiYWNrIHRoZQo+Pj4gICAgICAgICAgZ3Vlc3Qg
UkFNLiBNZW1vcnkgYmFja2VuZCBvYmplY3RzIG9mZmVyIG1vcmUgY29udHJvbCB0aGFuIHRoZQo+
PiAKPj4gSW4gb25lIHdvcmQsIEknZCBzdWdnZXN0IGFkdmVydGlzaW5nIHRoZSBleGlzdGVuY2Ug
b2YgInJvbSIgb3B0aW9uIG1vcmUgaW52YXNpdmVseSwgd2hlbmV2ZXIKPj4gcHJpdmF0ZSBmaWxl
IG1hcHBpbmcgaXMgdXNlZC4KPj4gCj4+IElNSE8geW91IHNob3VsZCBwcm9iYWJseSBiZSBtb3Jl
IGludmFzaXZlIGhlcmUgdG8gd2FybiB1bmNvbmRpdGlvbmFsbHkgd2hlbgo+PiB0aGUgbWVtb3J5
IGJhY2tlbmQgZmlsZSBpcyBnb2luZyB0byBiZSBvcGVuZWQgcmVhZHdyaXRlIGJ1dCBpcyBtYXBw
ZWQgbm9uIHNoYXJlZC4KPgo+QXMgRGFuaWVsIHNhaWQsIHdlIHNob3VsZCBub3QgYWRkIG5ldyB3
YXJuaW5ncyBmb3Igc2FuZSB1c2UgY2FzZXMuIEJ1dCB3ZSBjYW4gaW5kZWVkIGdpdmUgYSBoaW50
IHdoZW4gb3BlbmluZyB0aGUgZmlsZSBmYWlsZWQsIHNlZSBiZWxvdy4KPgoKV2VsbCBJIGRvbid0
IHRoaW5rIGl0J3MgY29tcGxldGVseSBzYW5lIHVzZSBjYXNlcyB0aG91Z2ggd2UgY2FuIGtlZXAg
aXQgZm9yIGJhY2t3YXJkCmNvbXBhdGliaWxpdHkuCgpBIG5vbnNoYXJlZCBtZW1vcnkgbWFwIGJh
Y2tlZCBieSBhbiBmZCBvcGVuZWQgcmVhZHdyaXRlIGlzIHByb2JhYmx5CnByb2JsZW1hdGljIGFu
ZCBub3Qgd2hhdCBvbmUgdXN1YWxseSBleHBlY3QuIEVpdGhlciBpdCBzaG91bGQgYmUgc2hhcmVk
Cm9yIGl0IHNob3VsZCBvcGVuZWQgcmVhZG9ubHkuIEN1cnJlbnQgYmVoYXZpb3Igc3RpY2tzIHRv
CnRoZSBmaWxlIGJlaW5nIG9wZW5lZCByZWFkd3JpdGUgYnkgZGVmYXVsdCBidXQgd2FybmluZyBj
YW4gYmUgcmFpc2VkIHdoZW4KcmVhZG9ubHkgaG9sZHMgKGZpbGUgcGF0aCBkb2VzIG5vdCBwcmVm
aXggd2l0aCAvZGV2LCBhbmQgaXMgYSBub25lbXB0eSByZWd1bGFyIGZpbGUsCmFuZCBtYXBwaW5n
IGlzIHByaXZhdGUpLCBpbmRpY2F0ZSB0aGF0IHRoZSB1c2VyIG1heSBwcm9iYWJseSB3YW50IGEK
InJlYWRvbmx5PW9uLHJvbT1vZmYiIHNldHVwLgoKPj4gCj4+IEkgYXMgYSB1c2VyIGZpbmQgdGhl
IHBhdGNoIHNlcmllcyBpbmRlZWQgd29yayBmdW5jdGlvbmFsbHkgd2hlbiBJIGFtIGF3YXJlIG9m
IHRoZSAicm9tIgo+PiBvcHRpb24gLSBidXQgd2hhdCBpZiBJIGFtIG5vdCBhd2FyZSwgdGhlIG91
dGNvbWUgaXMgc3RpbGwgdGhhdCBxZW11IHRyaWVkCj4+IHRvIG9wZW4gdGhlIGZpbGUgcmVhZHdy
aXRlIGV2ZW4gd2hlbiBpdCBpcyBnb2luZyB0byBiZSBtYXBwZWQgcHJpdmF0ZS4KPgo+WWVzLCB0
aGUgaW1wbGljaXQgInJlYWRvbmx5PW9mZiIgaXMgYWN0aXZlIGluIGFueSBjYXNlLCBhbmQgd2Ug
Y2Fubm90IGNoYW5nZSB0aGF0IGR1ZSB0byBleGlzdGluZyB1c2VycyB1bmZvcnR1bmF0ZWx5Lgo+
CgpZZWFoIEkgYW0gb2sgd2l0aCB0aGF0IG5vdywgYW5kIEkgZm91bmQgYSB3YXkgZm9yIG15IHNl
dHVwIHRvIHdvcmsgd2l0aCB5b3VyIHBhdGNoZXMsCnNvIEkgYW0gaGFwcHkgd2l0aCBpdC4KCj4+
IAo+PiBXaGVuIHRoZSBmaWxlIGlzIHJlYWRvbmx5LCB0aGUgZXJyb3IgbWVzc2FnZSBpczoKPj4g
YGBgCj4+IHFlbXUtc3lzdGVtLXg4Nl82NDogY2FuJ3Qgb3BlbiBiYWNraW5nIHN0b3JlIHBjLnJh
bSBmb3IgZ3Vlc3QgUkFNOiBQZXJtaXNzaW9uIGRlbmllZAo+PiBgYGAKPj4gCj4+IFRoaXMgc2hv
dWxkIGJlIHByb2JhYmx5IGhlbHBmdWwgaWYgcWVtdSBmb3VuZCB0aGF0IHRoZSBmaWxlIGV4aXN0
cyBhcyBhIHJlZ3VsYXIgZmlsZSBhbmQKPj4gaXMgbWFwcGVkIHByaXZhdGUsIHRvIHNheSBzb21l
dGhpbmcgbGlrZQo+PiAKPj4gYGBgCj4+IHFlbXUtc3lzdGVtLXg4Nl82NDogY2FuJ3Qgb3BlbiBi
YWNraW5nIHN0b3JlIHBjLnJhbSBmb3IgZ3Vlc3QgUkFNOiBQZXJtaXNzaW9uIGRlbmllZAo+PiB0
aXA6IG1hcHBpbmcgaXMgcHJpdmF0ZSBhbmQgcmFtIGZpbGUgaXMgcHJvYmFibHkgcmVhZG9ubHks
IG1heWJlIHlvdSBzaG91bGQgYXBwZW5kICJyZWFkb25seT1vbixyb209b2ZmIgo+PiB0byAiLW9i
amVjdCBtZW1vcnktYmFja2VuZC1maWxlLC4uLiIgb3B0aW9uIGxpc3QuIHNlZSBkb2N1bWVudGF0
aW9uIHh4eCBmb3IgZGV0YWlscwo+PiBgYGAKPgo+V2hhdCBhYm91dCB0aGUgZm9sbG93aW5nLCBp
ZiB3ZSBjYW4gaW5kZWVkIG9wZW4gdGhlIGZpbGUgUi9PIGFuZCB3ZSdyZSBkZWFsaW5nIHdpdGhh
ICBwcml2YXRlIG1hcHBpbmc6Cj4KPnFlbXUtc3lzdGVtLXg4Nl82NDogY2FuJ3Qgb3BlbiBiYWNr
aW5nIHN0b3JlIHRtcC1maWxlIGZvciBndWVzdCBSQU06IFBlcm1pc3Npb24gZGVuaWVkCj5Db25z
aWRlciBvcGVuaW5nIHRoZSBiYWNraW5nIHN0b3JlIHJlYWQtb25seSB1c2luZyAnLW9iamVjdCBt
ZW1vcnktYmFja2VuZC1maWxlLHJlYWRvbmx5PW9uLHJvbT1vZmYsLi4uJyAoc2VlICJWTSB0ZW1w
bGF0aW5nIiBkb2N1bWVudGF0aW9uKQo+Cj4/CgpUaGlzIGlzIGdvb2QuIFdvcmRpbmcgbWlnaHQg
bmVlZCBpbXByb3ZlbWVudC4gKEFyZSBxZW11IGVycm9yIG1lc3NhZ2VzIGFsd2F5cyB0aGlzIGNv
bGQ/KQoKLS0KClJlZ2FyZHMsCgpsb2dvZXJ0aGluZXIK

