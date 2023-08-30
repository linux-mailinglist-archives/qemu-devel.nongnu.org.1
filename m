Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4696178D786
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:17:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNqA-0002zk-Pd; Wed, 30 Aug 2023 12:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=599fd62c5=graf@amazon.de>)
 id 1qbNq8-0002yd-9A; Wed, 30 Aug 2023 12:14:44 -0400
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=599fd62c5=graf@amazon.de>)
 id 1qbNq5-0003bL-Eh; Wed, 30 Aug 2023 12:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1693412081; x=1724948081;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=60CfxM2CnF/paVsMzJ4VPvu4hWJW8Jp9HkIT4YXTfP0=;
 b=XIk2jKliT0KTT4gQvqKbD6yK1B8wshh3VnvH32gWTx3TzFQoNtWLwsBd
 Asb+fm5FZnRZHvZ6qSCUl0QCvAPKk8wq9bD203X0GXI4rGOdv7Ges7bhn
 ZQ+Dw7ZGk83xeZxP1ZcpcGclPiplPoNPZS9YRGsGy2ltVy+VJWvNyd0UE 4=;
X-IronPort-AV: E=Sophos;i="6.02,214,1688428800"; d="scan'208";a="601819024"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-52005.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 16:14:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
 by email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com (Postfix)
 with ESMTPS id 0EDDB80629; Wed, 30 Aug 2023 16:14:35 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 30 Aug 2023 16:14:34 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 30 Aug 2023 16:14:32 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <qemu-arm@nongnu.org>, Cameron Esfahani
 <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Mads Ynddal
 <mads@ynddal.dk>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Bernhard Beschow <shentey@gmail.com>, Gerd Hoffmann
 <kraxel@redhat.com>
Subject: [PATCH v2 02/12] hw/misc/pvpanic: Add MMIO interface
Date: Wed, 30 Aug 2023 16:14:15 +0000
Message-ID: <20230830161425.91946-3-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230830161425.91946-1-graf@amazon.com>
References: <20230830161425.91946-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Precedence: Bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=52.119.213.156;
 envelope-from=prvs=599fd62c5=graf@amazon.de; helo=smtp-fw-52005.amazon.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

SW4gYWRkaXRpb24gdG8gdGhlIElTQSBhbmQgUENJIHZhcmlhbnRzIG9mIHB2cGFuaWMsIGxldCdz
IGFkZCBhbiBNTUlPCnBsYXRmb3JtIGRldmljZSB0aGF0IHdlIGNhbiB1c2UgaW4gZW1iZWRkZWQg
YXJtIGVudmlyb25tZW50cy4KClNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBHcmFmIDxncmFmQGFt
YXpvbi5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxp
bmFyby5vcmc+ClRlc3RlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5h
cm8ub3JnPgoKLS0tCgp2MSAtPiB2MjoKCiAgLSBVc2UgU1BEWCBoZWFkZXIKICAtIFJlbW92ZSB1
c2VsZXNzIGluY2x1ZGVzCiAgLSBBZGFwdCB0byBuZXcgbWVzb24uYnVpbGQgdGFyZ2V0IChzeXN0
ZW1fc3MpCi0tLQogaW5jbHVkZS9ody9taXNjL3B2cGFuaWMuaCB8ICAxICsKIGh3L21pc2MvcHZw
YW5pYy1tbWlvLmMgICAgfCA2MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKIGh3L21pc2MvS2NvbmZpZyAgICAgICAgICAgfCAgNCArKysKIGh3L21pc2MvbWVzb24uYnVp
bGQgICAgICAgfCAgMSArCiA0IGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKykKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9taXNjL3B2cGFuaWMtbW1pby5jCgpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody9taXNjL3B2cGFuaWMuaCBiL2luY2x1ZGUvaHcvbWlzYy9wdnBhbmljLmgKaW5kZXggZmFi
OTQxNjVkMC4uZjllN2MxZWExNyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ody9taXNjL3B2cGFuaWMu
aAorKysgYi9pbmNsdWRlL2h3L21pc2MvcHZwYW5pYy5oCkBAIC0yMCw2ICsyMCw3IEBACiAKICNk
ZWZpbmUgVFlQRV9QVlBBTklDX0lTQV9ERVZJQ0UgInB2cGFuaWMiCiAjZGVmaW5lIFRZUEVfUFZQ
QU5JQ19QQ0lfREVWSUNFICJwdnBhbmljLXBjaSIKKyNkZWZpbmUgVFlQRV9QVlBBTklDX01NSU9f
REVWSUNFICJwdnBhbmljLW1taW8iCiAKICNkZWZpbmUgUFZQQU5JQ19JT1BPUlRfUFJPUCAiaW9w
b3J0IgogCmRpZmYgLS1naXQgYS9ody9taXNjL3B2cGFuaWMtbW1pby5jIGIvaHcvbWlzYy9wdnBh
bmljLW1taW8uYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwLi45OWEyNGYx
MDRjCi0tLSAvZGV2L251bGwKKysrIGIvaHcvbWlzYy9wdnBhbmljLW1taW8uYwpAQCAtMCwwICsx
LDYxIEBACisvKgorICogUUVNVSBzaW11bGF0ZWQgcHZwYW5pYyBkZXZpY2UgKE1NSU8gZnJvbnRl
bmQpCisgKgorICogQ29weXJpZ2h0IMKpIDIwMjMgQW1hem9uLmNvbSwgSW5jLiBvciBpdHMgYWZm
aWxpYXRlcy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KKyAqCisgKiBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisKKyNpbmNsdWRlICJxZW11L29zZGVwLmgiCisK
KyNpbmNsdWRlICJody9xZGV2LXByb3BlcnRpZXMuaCIKKyNpbmNsdWRlICJody9taXNjL3B2cGFu
aWMuaCIKKyNpbmNsdWRlICJody9zeXNidXMuaCIKKyNpbmNsdWRlICJzdGFuZGFyZC1oZWFkZXJz
L2xpbnV4L3B2cGFuaWMuaCIKKworT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoUFZQYW5pY01N
SU9TdGF0ZSwgUFZQQU5JQ19NTUlPX0RFVklDRSkKKworI2RlZmluZSBQVlBBTklDX01NSU9fU0la
RSAweDIKKworc3RydWN0IFBWUGFuaWNNTUlPU3RhdGUgeworICAgIFN5c0J1c0RldmljZSBwYXJl
bnRfb2JqOworCisgICAgUFZQYW5pY1N0YXRlIHB2cGFuaWM7Cit9OworCitzdGF0aWMgdm9pZCBw
dnBhbmljX21taW9faW5pdGZuKE9iamVjdCAqb2JqKQoreworICAgIFBWUGFuaWNNTUlPU3RhdGUg
KnMgPSBQVlBBTklDX01NSU9fREVWSUNFKG9iaik7CisKKyAgICBwdnBhbmljX3NldHVwX2lvKCZz
LT5wdnBhbmljLCBERVZJQ0UocyksIFBWUEFOSUNfTU1JT19TSVpFKTsKKyAgICBzeXNidXNfaW5p
dF9tbWlvKFNZU19CVVNfREVWSUNFKG9iaiksICZzLT5wdnBhbmljLm1yKTsKK30KKworc3RhdGlj
IFByb3BlcnR5IHB2cGFuaWNfbW1pb19wcm9wZXJ0aWVzW10gPSB7CisgICAgREVGSU5FX1BST1Bf
VUlOVDgoImV2ZW50cyIsIFBWUGFuaWNNTUlPU3RhdGUsIHB2cGFuaWMuZXZlbnRzLAorICAgICAg
ICAgICAgICAgICAgICAgIFBWUEFOSUNfUEFOSUNLRUQgfCBQVlBBTklDX0NSQVNIX0xPQURFRCks
CisgICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwKK307CisKK3N0YXRpYyB2b2lkIHB2cGFu
aWNfbW1pb19jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkKK3sKKyAg
ICBEZXZpY2VDbGFzcyAqZGMgPSBERVZJQ0VfQ0xBU1Moa2xhc3MpOworCisgICAgZGV2aWNlX2Ns
YXNzX3NldF9wcm9wcyhkYywgcHZwYW5pY19tbWlvX3Byb3BlcnRpZXMpOworICAgIHNldF9iaXQo
REVWSUNFX0NBVEVHT1JZX01JU0MsIGRjLT5jYXRlZ29yaWVzKTsKK30KKworc3RhdGljIGNvbnN0
IFR5cGVJbmZvIHB2cGFuaWNfbW1pb19pbmZvID0geworICAgIC5uYW1lICAgICAgICAgID0gVFlQ
RV9QVlBBTklDX01NSU9fREVWSUNFLAorICAgIC5wYXJlbnQgICAgICAgID0gVFlQRV9TWVNfQlVT
X0RFVklDRSwKKyAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihQVlBhbmljTU1JT1N0YXRlKSwK
KyAgICAuaW5zdGFuY2VfaW5pdCA9IHB2cGFuaWNfbW1pb19pbml0Zm4sCisgICAgLmNsYXNzX2lu
aXQgICAgPSBwdnBhbmljX21taW9fY2xhc3NfaW5pdCwKK307CisKK3N0YXRpYyB2b2lkIHB2cGFu
aWNfcmVnaXN0ZXJfdHlwZXModm9pZCkKK3sKKyAgICB0eXBlX3JlZ2lzdGVyX3N0YXRpYygmcHZw
YW5pY19tbWlvX2luZm8pOworfQorCit0eXBlX2luaXQocHZwYW5pY19yZWdpc3Rlcl90eXBlcykK
ZGlmZiAtLWdpdCBhL2h3L21pc2MvS2NvbmZpZyBiL2h3L21pc2MvS2NvbmZpZwppbmRleCA2OTk2
ZDI2NWU0Li5iNjk3NDZhNjBhIDEwMDY0NAotLS0gYS9ody9taXNjL0tjb25maWcKKysrIGIvaHcv
bWlzYy9LY29uZmlnCkBAIC0xMjUsNiArMTI1LDEwIEBAIGNvbmZpZyBQVlBBTklDX0lTQQogICAg
IGRlcGVuZHMgb24gSVNBX0JVUwogICAgIHNlbGVjdCBQVlBBTklDX0NPTU1PTgogCitjb25maWcg
UFZQQU5JQ19NTUlPCisgICAgYm9vbAorICAgIHNlbGVjdCBQVlBBTklDX0NPTU1PTgorCiBjb25m
aWcgQVVYCiAgICAgYm9vbAogICAgIHNlbGVjdCBJMkMKZGlmZiAtLWdpdCBhL2h3L21pc2MvbWVz
b24uYnVpbGQgYi9ody9taXNjL21lc29uLmJ1aWxkCmluZGV4IDg5MmY4YjkxYzUuLjYzODIxZDYw
NDAgMTAwNjQ0Ci0tLSBhL2h3L21pc2MvbWVzb24uYnVpbGQKKysrIGIvaHcvbWlzYy9tZXNvbi5i
dWlsZApAQCAtMTE2LDYgKzExNiw3IEBAIHN5c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJR19BUk1T
U0VfTUhVJywgaWZfdHJ1ZTogZmlsZXMoJ2FybXNzZS1taHUuYycpKQogCiBzeXN0ZW1fc3MuYWRk
KHdoZW46ICdDT05GSUdfUFZQQU5JQ19JU0EnLCBpZl90cnVlOiBmaWxlcygncHZwYW5pYy1pc2Eu
YycpKQogc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX1BWUEFOSUNfUENJJywgaWZfdHJ1ZTog
ZmlsZXMoJ3B2cGFuaWMtcGNpLmMnKSkKK3N5c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJR19QVlBB
TklDX01NSU8nLCBpZl90cnVlOiBmaWxlcygncHZwYW5pYy1tbWlvLmMnKSkKIHN5c3RlbV9zcy5h
ZGQod2hlbjogJ0NPTkZJR19BVVgnLCBpZl90cnVlOiBmaWxlcygnYXV4YnVzLmMnKSkKIHN5c3Rl
bV9zcy5hZGQod2hlbjogJ0NPTkZJR19BU1BFRURfU09DJywgaWZfdHJ1ZTogZmlsZXMoCiAgICdh
c3BlZWRfaGFjZS5jJywKLS0gCjIuMzkuMiAoQXBwbGUgR2l0LTE0MykKCgoKCkFtYXpvbiBEZXZl
bG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpH
ZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVp
bmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMg
QgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==


