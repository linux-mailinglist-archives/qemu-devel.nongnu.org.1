Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE59E730AD8
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 00:42:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9ZAt-0001FK-92; Wed, 14 Jun 2023 18:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=52269c73c=graf@amazon.de>)
 id 1q9ZAo-0001Dp-IQ; Wed, 14 Jun 2023 18:41:07 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=52269c73c=graf@amazon.de>)
 id 1q9ZAm-00057R-JQ; Wed, 14 Jun 2023 18:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1686782465; x=1718318465;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YSEGY5+JrSNegiupQbx0woDawlnizwDe7z0MOZgWMuk=;
 b=tdEVibvm0vWai7zkfvqXZ9FTk4CkjwDcuaXxklRZ8sD/aKz2d4iox2X0
 yELTm1iQJfvamY1qOzmF6I3Lve8r5rR4N8jnsMyQ5vJfir0G4s70mngw2
 dAMFOe2sBAraVWFLBynI+AFST3Chxbm0Ky3TuAXl50p4HlRL+zYYUh7M8 w=;
X-IronPort-AV: E=Sophos;i="6.00,243,1681171200"; d="scan'208";a="345698899"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com)
 ([10.25.36.210]) by smtp-border-fw-9102.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 22:40:57 +0000
Received: from EX19MTAUWA002.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
 by email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com (Postfix)
 with ESMTPS id 3D1AB40DE2; Wed, 14 Jun 2023 22:40:56 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 22:40:45 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 22:40:43 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <qemu-arm@nongnu.org>, Cameron Esfahani
 <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Peter
 Maydell" <peter.maydell@linaro.org>
Subject: [PATCH 02/12] hw/misc/pvpanic: Add MMIO interface
Date: Wed, 14 Jun 2023 22:40:28 +0000
Message-ID: <20230614224038.86148-3-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614224038.86148-1-graf@amazon.com>
References: <20230614224038.86148-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Precedence: Bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.171.184.29;
 envelope-from=prvs=52269c73c=graf@amazon.de; helo=smtp-fw-9102.amazon.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
YXpvbi5jb20+Ci0tLQogaHcvbWlzYy9LY29uZmlnICAgICAgICAgICB8ICA0ICsrKwogaHcvbWlz
Yy9tZXNvbi5idWlsZCAgICAgICB8ICAxICsKIGh3L21pc2MvcHZwYW5pYy1tbWlvLmMgICAgfCA2
NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUvaHcvbWlz
Yy9wdnBhbmljLmggfCAgMSArCiA0IGZpbGVzIGNoYW5nZWQsIDcyIGluc2VydGlvbnMoKykKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBody9taXNjL3B2cGFuaWMtbW1pby5jCgpkaWZmIC0tZ2l0IGEvaHcv
bWlzYy9LY29uZmlnIGIvaHcvbWlzYy9LY29uZmlnCmluZGV4IGU0YzIxNDkxNzUuLjIxOTEzZWYx
OTEgMTAwNjQ0Ci0tLSBhL2h3L21pc2MvS2NvbmZpZworKysgYi9ody9taXNjL0tjb25maWcKQEAg
LTEyNSw2ICsxMjUsMTAgQEAgY29uZmlnIFBWUEFOSUNfSVNBCiAgICAgZGVwZW5kcyBvbiBJU0Ff
QlVTCiAgICAgc2VsZWN0IFBWUEFOSUNfQ09NTU9OCiAKK2NvbmZpZyBQVlBBTklDX01NSU8KKyAg
ICBib29sCisgICAgc2VsZWN0IFBWUEFOSUNfQ09NTU9OCisKIGNvbmZpZyBBVVgKICAgICBib29s
CiAgICAgc2VsZWN0IEkyQwpkaWZmIC0tZ2l0IGEvaHcvbWlzYy9tZXNvbi5idWlsZCBiL2h3L21p
c2MvbWVzb24uYnVpbGQKaW5kZXggNzhjYTg1N2M5ZC4uYjkzNWU3NGQ1MSAxMDA2NDQKLS0tIGEv
aHcvbWlzYy9tZXNvbi5idWlsZAorKysgYi9ody9taXNjL21lc29uLmJ1aWxkCkBAIC0xMTUsNiAr
MTE1LDcgQEAgc29mdG1tdV9zcy5hZGQod2hlbjogJ0NPTkZJR19BUk1TU0VfTUhVJywgaWZfdHJ1
ZTogZmlsZXMoJ2FybXNzZS1taHUuYycpKQogCiBzb2Z0bW11X3NzLmFkZCh3aGVuOiAnQ09ORklH
X1BWUEFOSUNfSVNBJywgaWZfdHJ1ZTogZmlsZXMoJ3B2cGFuaWMtaXNhLmMnKSkKIHNvZnRtbXVf
c3MuYWRkKHdoZW46ICdDT05GSUdfUFZQQU5JQ19QQ0knLCBpZl90cnVlOiBmaWxlcygncHZwYW5p
Yy1wY2kuYycpKQorc29mdG1tdV9zcy5hZGQod2hlbjogJ0NPTkZJR19QVlBBTklDX01NSU8nLCBp
Zl90cnVlOiBmaWxlcygncHZwYW5pYy1tbWlvLmMnKSkKIHNvZnRtbXVfc3MuYWRkKHdoZW46ICdD
T05GSUdfQVVYJywgaWZfdHJ1ZTogZmlsZXMoJ2F1eGJ1cy5jJykpCiBzb2Z0bW11X3NzLmFkZCh3
aGVuOiAnQ09ORklHX0FTUEVFRF9TT0MnLCBpZl90cnVlOiBmaWxlcygKICAgJ2FzcGVlZF9oYWNl
LmMnLApkaWZmIC0tZ2l0IGEvaHcvbWlzYy9wdnBhbmljLW1taW8uYyBiL2h3L21pc2MvcHZwYW5p
Yy1tbWlvLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMC4uYWViZTcyMjdl
NgotLS0gL2Rldi9udWxsCisrKyBiL2h3L21pc2MvcHZwYW5pYy1tbWlvLmMKQEAgLTAsMCArMSw2
NiBAQAorLyoKKyAqIFFFTVUgc2ltdWxhdGVkIHB2cGFuaWMgZGV2aWNlIChNTUlPIGZyb250ZW5k
KQorICoKKyAqIENvcHlyaWdodCDCqSAyMDIzIEFtYXpvbi5jb20sIEluYy4gb3IgaXRzIGFmZmls
aWF0ZXMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCisgKgorICogVGhpcyB3b3JrIGlzIGxpY2Vuc2Vk
IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdQTCwgdmVyc2lvbiAyIG9yIGxhdGVyLgorICog
U2VlIHRoZSBDT1BZSU5HIGZpbGUgaW4gdGhlIHRvcC1sZXZlbCBkaXJlY3RvcnkuCisgKi8KKwor
I2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJxZW11L21vZHVsZS5oIgorI2luY2x1
ZGUgInN5c2VtdS9ydW5zdGF0ZS5oIgorCisjaW5jbHVkZSAiaHcvbnZyYW0vZndfY2ZnLmgiCisj
aW5jbHVkZSAiaHcvcWRldi1wcm9wZXJ0aWVzLmgiCisjaW5jbHVkZSAiaHcvbWlzYy9wdnBhbmlj
LmgiCisjaW5jbHVkZSAicW9tL29iamVjdC5oIgorI2luY2x1ZGUgImh3L2lzYS9pc2EuaCIKKyNp
bmNsdWRlICJzdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3B2cGFuaWMuaCIKKworT0JKRUNUX0RFQ0xB
UkVfU0lNUExFX1RZUEUoUFZQYW5pY01NSU9TdGF0ZSwgUFZQQU5JQ19NTUlPX0RFVklDRSkKKwor
I2RlZmluZSBQVlBBTklDX01NSU9fU0laRSAweDIKKworc3RydWN0IFBWUGFuaWNNTUlPU3RhdGUg
eworICAgIFN5c0J1c0RldmljZSBwYXJlbnRfb2JqOworCisgICAgUFZQYW5pY1N0YXRlIHB2cGFu
aWM7Cit9OworCitzdGF0aWMgdm9pZCBwdnBhbmljX21taW9faW5pdGZuKE9iamVjdCAqb2JqKQor
eworICAgIFBWUGFuaWNNTUlPU3RhdGUgKnMgPSBQVlBBTklDX01NSU9fREVWSUNFKG9iaik7CisK
KyAgICBwdnBhbmljX3NldHVwX2lvKCZzLT5wdnBhbmljLCBERVZJQ0UocyksIFBWUEFOSUNfTU1J
T19TSVpFKTsKKyAgICBzeXNidXNfaW5pdF9tbWlvKFNZU19CVVNfREVWSUNFKG9iaiksICZzLT5w
dnBhbmljLm1yKTsKK30KKworc3RhdGljIFByb3BlcnR5IHB2cGFuaWNfbW1pb19wcm9wZXJ0aWVz
W10gPSB7CisgICAgREVGSU5FX1BST1BfVUlOVDgoImV2ZW50cyIsIFBWUGFuaWNNTUlPU3RhdGUs
IHB2cGFuaWMuZXZlbnRzLAorICAgICAgICAgICAgICAgICAgICAgIFBWUEFOSUNfUEFOSUNLRUQg
fCBQVlBBTklDX0NSQVNIX0xPQURFRCksCisgICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwK
K307CisKK3N0YXRpYyB2b2lkIHB2cGFuaWNfbW1pb19jbGFzc19pbml0KE9iamVjdENsYXNzICpr
bGFzcywgdm9pZCAqZGF0YSkKK3sKKyAgICBEZXZpY2VDbGFzcyAqZGMgPSBERVZJQ0VfQ0xBU1Mo
a2xhc3MpOworCisgICAgZGV2aWNlX2NsYXNzX3NldF9wcm9wcyhkYywgcHZwYW5pY19tbWlvX3By
b3BlcnRpZXMpOworICAgIHNldF9iaXQoREVWSUNFX0NBVEVHT1JZX01JU0MsIGRjLT5jYXRlZ29y
aWVzKTsKK30KKworc3RhdGljIGNvbnN0IFR5cGVJbmZvIHB2cGFuaWNfbW1pb19pbmZvID0gewor
ICAgIC5uYW1lICAgICAgICAgID0gVFlQRV9QVlBBTklDX01NSU9fREVWSUNFLAorICAgIC5wYXJl
bnQgICAgICAgID0gVFlQRV9TWVNfQlVTX0RFVklDRSwKKyAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNp
emVvZihQVlBhbmljTU1JT1N0YXRlKSwKKyAgICAuaW5zdGFuY2VfaW5pdCA9IHB2cGFuaWNfbW1p
b19pbml0Zm4sCisgICAgLmNsYXNzX2luaXQgICAgPSBwdnBhbmljX21taW9fY2xhc3NfaW5pdCwK
K307CisKK3N0YXRpYyB2b2lkIHB2cGFuaWNfcmVnaXN0ZXJfdHlwZXModm9pZCkKK3sKKyAgICB0
eXBlX3JlZ2lzdGVyX3N0YXRpYygmcHZwYW5pY19tbWlvX2luZm8pOworfQorCit0eXBlX2luaXQo
cHZwYW5pY19yZWdpc3Rlcl90eXBlcykKZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvbWlzYy9wdnBh
bmljLmggYi9pbmNsdWRlL2h3L21pc2MvcHZwYW5pYy5oCmluZGV4IGZhYjk0MTY1ZDAuLmY5ZTdj
MWVhMTcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvbWlzYy9wdnBhbmljLmgKKysrIGIvaW5jbHVk
ZS9ody9taXNjL3B2cGFuaWMuaApAQCAtMjAsNiArMjAsNyBAQAogCiAjZGVmaW5lIFRZUEVfUFZQ
QU5JQ19JU0FfREVWSUNFICJwdnBhbmljIgogI2RlZmluZSBUWVBFX1BWUEFOSUNfUENJX0RFVklD
RSAicHZwYW5pYy1wY2kiCisjZGVmaW5lIFRZUEVfUFZQQU5JQ19NTUlPX0RFVklDRSAicHZwYW5p
Yy1tbWlvIgogCiAjZGVmaW5lIFBWUEFOSUNfSU9QT1JUX1BST1AgImlvcG9ydCIKIAotLSAKMi4z
OS4yIChBcHBsZSBHaXQtMTQzKQoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55
IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hy
aXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmlj
aHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6
IERFIDI4OSAyMzcgODc5CgoK


