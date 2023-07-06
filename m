Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AF174A2FE
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 19:18:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHSbN-0002lA-VM; Thu, 06 Jul 2023 13:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenrui333@gmail.com>)
 id 1qHSL0-00065F-Co
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:00:14 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenrui333@gmail.com>)
 id 1qHSKw-0000Of-4v
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:00:14 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-992acf67388so113273266b.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688662807; x=1691254807;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WUesDeej3iHdp/Srf75y1+QmVEuLjPOgq+mXwCTnNQY=;
 b=SRA9ccKw4N8kyWoJToZLHlofD842wX8cfJsRSGaxByQkslDpKZmm0cuw2fmzxgkagX
 i/HvelBFMxcFfHsWFEJcGTlOoJt1kYl1l2JRVS74h7LzY3xUtp0KO1lRjCVI7q7MZ/DV
 D7GdndIJvCwbANKPPIlCJgYUrqeIJaecjVDv2KYekP6qdIX/qqZTkjQKzvJnrvbaW6Uq
 Na+7in7VwnavdTHW54LNbgXMF/+S9MSJ6WMmL7H7IAaPqH0shrCiL0wtKG4F+av9RWgP
 /C3fydJkloH53gwafWzl94jaGw7SU8ltmV/Xh6izFvbG6tTgX4SaUsVbh149QPo5ktSP
 +EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662807; x=1691254807;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WUesDeej3iHdp/Srf75y1+QmVEuLjPOgq+mXwCTnNQY=;
 b=Q51xOFPYdRf1cOM9zrkcYoWCn5A6Ot/L/qC951qiGn7kIMULK/UkaKtexpWYlna6Ej
 lysOqdKlD2DiHUcOo0hRTj6ip4Qtj30pMmwRg9jR/eZL9DXouYT+hya3mul1uR9PEtsZ
 ruZObenVCzN8OYyOJ1VAP9hPzR1xFiOI7DEUvjJL3gfYgDW+Kqb6IPMTQClK0QwS18XA
 M9AZr+iAdnnLskyMxnqlhClp7x8GRB/q08LhTkv3gzvNo0NoCXlr5QkCqzvP2Fmp6P/a
 t4Rf2BXp6IZ4V08hHSdprn6DyZ1EgKJyGMqu/pHZmaShZk6UYW6UZ9wzRyH8ncHg3xmT
 XqTQ==
X-Gm-Message-State: ABy/qLZ0UYtiQq0c/YvQeypcdRQYmTwuroQwcvS0EdFtNSktMIA/QsPc
 nsE6gwwsnA27viF0+sDeKTnPwATYzSvwuqzZmOon7ww2sCkAig==
X-Google-Smtp-Source: APBJJlHrXbUTUF8H/WVR8DEidFN6VulOx9mDmOS4scWNpkoY82KLvS5eSpaZ0zSH8+EymPQm55HI+Rk7Fqi/8sa5pSE=
X-Received: by 2002:a17:907:3a85:b0:97e:56d5:b885 with SMTP id
 fh5-20020a1709073a8500b0097e56d5b885mr1853110ejc.60.1688662806670; Thu, 06
 Jul 2023 10:00:06 -0700 (PDT)
MIME-Version: 1.0
From: Rui Chen <chenrui333@gmail.com>
Date: Thu, 6 Jul 2023 12:59:55 -0400
Message-ID: <CA+PgxXVxVKpT0SZ3N+Fc1YvXCiwkkbqm0FmLKqLTbgcDpYCNgg@mail.gmail.com>
Subject: [PATCH] chore: rename `tricore_feature` to
 `is_tricore_feature_enabled`
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="000000000000bcd5a505ffd4722f"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=chenrui333@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 06 Jul 2023 13:17:04 -0400
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

--000000000000bcd5a505ffd4722f
Content-Type: multipart/alternative; boundary="000000000000bcd5a405ffd4722d"

--000000000000bcd5a405ffd4722d
Content-Type: text/plain; charset="UTF-8"

While upgrading capstone to v5
<https://github.com/Homebrew/homebrew-core/pull/135948>, there was some
name clash with the tricore_feature in capstone (which was introduced in this
PR <https://github.com/capstone-engine/capstone/pull/1973>), thus rename
tricore_feature to is_tricore_feature_enabled.

Build error log is below

/opt/homebrew/Cellar/capstone/5.0/include/capstone/tricore.h:561:3: error:
redefinition of 'tricore_feature' as different kind of symbol
} tricore_feature;
  ^
../target/tricore/cpu.h:261:19: note: previous definition is here
static inline int tricore_feature(CPUTriCoreState *env, int feature)
                  ^
1 error generated.

Let me know if that makes sense. Thanks!

--000000000000bcd5a405ffd4722d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">While=C2=A0<a href=3D"https://github.com/Homebrew/homebrew=
-core/pull/135948" target=3D"_blank">upgrading capstone to v5</a>, there wa=
s some name clash with the tricore_feature in capstone (which was introduce=
d in=C2=A0<a href=3D"https://github.com/capstone-engine/capstone/pull/1973"=
 target=3D"_blank">this PR</a>), thus rename tricore_feature to is_tricore_=
feature_enabled.<br><br>Build error log is below<br><br>/opt/homebrew/Cella=
r/capstone/5.0/include/capstone/tricore.h:561:3: error: redefinition of &#3=
9;tricore_feature&#39; as different kind of symbol<br>} tricore_feature;<br=
>=C2=A0 ^<br>../target/tricore/cpu.h:261:19: note: previous definition is h=
ere<br>static inline int tricore_feature(CPUTriCoreState *env, int feature)=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>1 e=
rror generated.<br><br>Let me know if that makes sense. Thanks!<br></div>

--000000000000bcd5a405ffd4722d--

--000000000000bcd5a505ffd4722f
Content-Type: application/octet-stream; name="qemu-for-capstone-5.patch"
Content-Disposition: attachment; filename="qemu-for-capstone-5.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ljre86k00>
X-Attachment-Id: f_ljre86k00

RnJvbSBjNTAyNzI0NjVhNGVhYmE4NWFmYWY0MWUwYzMzNDBjN2QzZmZiODk0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSdWkgQ2hlbiA8cnVpQGNoZW5ydWkuZGV2PgpEYXRlOiBUaHUs
IDYgSnVsIDIwMjMgMTE6MTM6NTkgLTA0MDAKU3ViamVjdDogW1BBVENIXSBjaG9yZTogcmVuYW1l
IGB0cmljb3JlX2ZlYXR1cmVgIHRvCiBgaXNfdHJpY29yZV9mZWF0dXJlX2VuYWJsZWRgCgpTaWdu
ZWQtb2ZmLWJ5OiBSdWkgQ2hlbiA8cnVpQGNoZW5ydWkuZGV2PgotLS0KIHRhcmdldC90cmljb3Jl
L2NwdS5jICAgICAgIHwgOCArKysrLS0tLQogdGFyZ2V0L3RyaWNvcmUvY3B1LmggICAgICAgfCAy
ICstCiB0YXJnZXQvdHJpY29yZS9oZWxwZXIuYyAgICB8IDQgKystLQogdGFyZ2V0L3RyaWNvcmUv
b3BfaGVscGVyLmMgfCA0ICsrLS0KIDQgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC90cmljb3JlL2NwdS5jIGIvdGFyZ2V0
L3RyaWNvcmUvY3B1LmMKaW5kZXggZjE1MTY5YmQxYjQ3YjkwOWQ0NWVjZGZhY2MzY2FkOTY3OWY4
ZjAzMy4uZDZiMmFlYWMxMjIwNzcwNWQwZmE5OGE1MWM0ZWVjY2MwYWUxNmI1MCAxMDA2NDQKLS0t
IGEvdGFyZ2V0L3RyaWNvcmUvY3B1LmMKKysrIGIvdGFyZ2V0L3RyaWNvcmUvY3B1LmMKQEAgLTEw
NCwxOCArMTA0LDE4IEBAIHN0YXRpYyB2b2lkIHRyaWNvcmVfY3B1X3JlYWxpemVmbihEZXZpY2VT
dGF0ZSAqZGV2LCBFcnJvciAqKmVycnApCiAgICAgfQogCiAgICAgLyogU29tZSBmZWF0dXJlcyBh
dXRvbWF0aWNhbGx5IGltcGx5IG90aGVycyAqLwotICAgIGlmICh0cmljb3JlX2ZlYXR1cmUoZW52
LCBUUklDT1JFX0ZFQVRVUkVfMTYyKSkgeworICAgIGlmIChpc190cmljb3JlX2ZlYXR1cmVfZW5h
YmxlZChlbnYsIFRSSUNPUkVfRkVBVFVSRV8xNjIpKSB7CiAgICAgICAgIHNldF9mZWF0dXJlKGVu
diwgVFJJQ09SRV9GRUFUVVJFXzE2MSk7CiAgICAgfQogCi0gICAgaWYgKHRyaWNvcmVfZmVhdHVy
ZShlbnYsIFRSSUNPUkVfRkVBVFVSRV8xNjEpKSB7CisgICAgaWYgKGlzX3RyaWNvcmVfZmVhdHVy
ZV9lbmFibGVkKGVudiwgVFJJQ09SRV9GRUFUVVJFXzE2MSkpIHsKICAgICAgICAgc2V0X2ZlYXR1
cmUoZW52LCBUUklDT1JFX0ZFQVRVUkVfMTYpOwogICAgIH0KIAotICAgIGlmICh0cmljb3JlX2Zl
YXR1cmUoZW52LCBUUklDT1JFX0ZFQVRVUkVfMTYpKSB7CisgICAgaWYgKGlzX3RyaWNvcmVfZmVh
dHVyZV9lbmFibGVkKGVudiwgVFJJQ09SRV9GRUFUVVJFXzE2KSkgewogICAgICAgICBzZXRfZmVh
dHVyZShlbnYsIFRSSUNPUkVfRkVBVFVSRV8xMzEpOwogICAgIH0KLSAgICBpZiAodHJpY29yZV9m
ZWF0dXJlKGVudiwgVFJJQ09SRV9GRUFUVVJFXzEzMSkpIHsKKyAgICBpZiAoaXNfdHJpY29yZV9m
ZWF0dXJlX2VuYWJsZWQoZW52LCBUUklDT1JFX0ZFQVRVUkVfMTMxKSkgewogICAgICAgICBzZXRf
ZmVhdHVyZShlbnYsIFRSSUNPUkVfRkVBVFVSRV8xMyk7CiAgICAgfQogICAgIGNwdV9yZXNldChj
cyk7CmRpZmYgLS1naXQgYS90YXJnZXQvdHJpY29yZS9jcHUuaCBiL3RhcmdldC90cmljb3JlL2Nw
dS5oCmluZGV4IGE1MGI5MWNjMzYyYWM1MzRiYzFlYmQ1NGQ1MGRlMzg0MGM0ZTU0NjEuLjVkYTg4
NDc3MWI4NDQ2NzY3ZjZkYTM2YjcyZjFlM2QxYzI3NzdhZDYgMTAwNjQ0Ci0tLSBhL3RhcmdldC90
cmljb3JlL2NwdS5oCisrKyBiL3RhcmdldC90cmljb3JlL2NwdS5oCkBAIC0yNzcsNyArMjc3LDcg
QEAgZW51bSB0cmljb3JlX2ZlYXR1cmVzIHsKICAgICBUUklDT1JFX0ZFQVRVUkVfMTYyLAogfTsK
IAotc3RhdGljIGlubGluZSBpbnQgdHJpY29yZV9mZWF0dXJlKENQVVRyaUNvcmVTdGF0ZSAqZW52
LCBpbnQgZmVhdHVyZSkKK3N0YXRpYyBpbmxpbmUgaW50IGlzX3RyaWNvcmVfZmVhdHVyZV9lbmFi
bGVkKENQVVRyaUNvcmVTdGF0ZSAqZW52LCBpbnQgZmVhdHVyZSkKIHsKICAgICByZXR1cm4gKGVu
di0+ZmVhdHVyZXMgJiAoMVVMTCA8PCBmZWF0dXJlKSkgIT0gMDsKIH0KZGlmZiAtLWdpdCBhL3Rh
cmdldC90cmljb3JlL2hlbHBlci5jIGIvdGFyZ2V0L3RyaWNvcmUvaGVscGVyLmMKaW5kZXggOTUx
MDI0ZDQ5MTY3YjczZTM1ZWQ5NjFhOTQwMTQ1YjAyMjMzMjQ5Ni4uMTRjZDA3YzJlM2U1MmVhMjc0
OWEwNjljMzBiODM4ZjM0YjIwODc4NiAxMDA2NDQKLS0tIGEvdGFyZ2V0L3RyaWNvcmUvaGVscGVy
LmMKKysrIGIvdGFyZ2V0L3RyaWNvcmUvaGVscGVyLmMKQEAgLTE1NSw3ICsxNTUsNyBAQCB2b2lk
IHBzd193cml0ZShDUFVUcmlDb3JlU3RhdGUgKmVudiwgdWludDMyX3QgdmFsKQogI2RlZmluZSBG
SUVMRF9HRVRURVJfV0lUSF9GRUFUVVJFKE5BTUUsIFJFRywgRklFTEQsIEZFQVRVUkUpICAgICBc
CiB1aW50MzJfdCBOQU1FKENQVVRyaUNvcmVTdGF0ZSAqZW52KSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXAogeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcCi0gICAgaWYgKHRyaWNvcmVfZmVhdHVyZShlbnYsIFRSSUNP
UkVfRkVBVFVSRV8jI0ZFQVRVUkUpKSB7ICAgICAgIFwKKyAgICBpZiAoaXNfdHJpY29yZV9mZWF0
dXJlX2VuYWJsZWQoZW52LCBUUklDT1JFX0ZFQVRVUkVfIyNGRUFUVVJFKSkgeyAgICAgICBcCiAg
ICAgICAgIHJldHVybiBGSUVMRF9FWDMyKGVudi0+UkVHLCBSRUcsIEZJRUxEICMjIF8gIyMgRkVB
VFVSRSk7IFwKICAgICB9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXAogICAgIHJldHVybiBGSUVMRF9FWDMyKGVudi0+UkVHLCBSRUcs
IEZJRUxEICMjIF8xMyk7ICAgICAgICAgICAgICBcCkBAIC0xNzAsNyArMTcwLDcgQEAgdWludDMy
X3QgTkFNRShDUFVUcmlDb3JlU3RhdGUgKmVudikgICAgICAgICBcCiAjZGVmaW5lIEZJRUxEX1NF
VFRFUl9XSVRIX0ZFQVRVUkUoTkFNRSwgUkVHLCBGSUVMRCwgRkVBVFVSRSkgICAgICAgICAgICAg
IFwKIHZvaWQgTkFNRShDUFVUcmlDb3JlU3RhdGUgKmVudiwgdWludDMyX3QgdmFsKSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcCiB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKLSAgICBpZiAodHJpY29y
ZV9mZWF0dXJlKGVudiwgVFJJQ09SRV9GRUFUVVJFXyMjRkVBVFVSRSkpIHsgICAgICAgICAgICAg
ICAgXAorICAgIGlmIChpc190cmljb3JlX2ZlYXR1cmVfZW5hYmxlZChlbnYsIFRSSUNPUkVfRkVB
VFVSRV8jI0ZFQVRVUkUpKSB7ICAgICAgICAgICAgICAgIFwKICAgICAgICAgZW52LT5SRUcgPSBG
SUVMRF9EUDMyKGVudi0+UkVHLCBSRUcsIEZJRUxEICMjIF8gIyMgRkVBVFVSRSwgdmFsKTsgXAog
ICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcCiAgICAgZW52LT5SRUcgPSBGSUVMRF9EUDMyKGVudi0+UkVHLCBS
RUcsIEZJRUxEICMjIF8xMywgdmFsKTsgICAgICAgICAgICAgIFwKZGlmZiAtLWdpdCBhL3Rhcmdl
dC90cmljb3JlL29wX2hlbHBlci5jIGIvdGFyZ2V0L3RyaWNvcmUvb3BfaGVscGVyLmMKaW5kZXgg
ODIxYTRiNjdjYjZkYmI0ZjVmNTE4ODZmYjRjYTg5MGZmOTRiYzBlMi4uNWY3ZmM4YWFmYjkwY2E1
MGVhZTlmMjA4ZDJiNTI2NmNjMjFhMjY4NSAxMDA2NDQKLS0tIGEvdGFyZ2V0L3RyaWNvcmUvb3Bf
aGVscGVyLmMKKysrIGIvdGFyZ2V0L3RyaWNvcmUvb3BfaGVscGVyLmMKQEAgLTI1ODQsNyArMjU4
NCw3IEBAIHZvaWQgaGVscGVyX3JldChDUFVUcmlDb3JlU3RhdGUgKmVudikKICAgICAvKiBQQ1hJ
ID0gbmV3X1BDWEk7ICovCiAgICAgZW52LT5QQ1hJID0gbmV3X1BDWEk7CiAKLSAgICBpZiAodHJp
Y29yZV9mZWF0dXJlKGVudiwgVFJJQ09SRV9GRUFUVVJFXzEzMSkpIHsKKyAgICBpZiAoaXNfdHJp
Y29yZV9mZWF0dXJlX2VuYWJsZWQoZW52LCBUUklDT1JFX0ZFQVRVUkVfMTMxKSkgewogICAgICAg
ICAvKiBQU1cgPSB7bmV3X1BTV1szMToyNl0sIFBTV1syNToyNF0sIG5ld19QU1dbMjM6MF19OyAq
LwogICAgICAgICBwc3dfd3JpdGUoZW52LCAobmV3X1BTVyAmIH4oMHgzMDAwMDAwKSkgKyAocHN3
ICYgKDB4MzAwMDAwMCkpKTsKICAgICB9IGVsc2UgeyAvKiBUUklDT1JFX0ZFQVRVUkVfMTMgb25s
eSAqLwpAQCAtMjY5NSw3ICsyNjk1LDcgQEAgdm9pZCBoZWxwZXJfcmZtKENQVVRyaUNvcmVTdGF0
ZSAqZW52KQogICAgIGVudi0+Z3ByX2FbMTBdID0gY3B1X2xkbF9kYXRhKGVudiwgZW52LT5EQ1gr
OCk7CiAgICAgZW52LT5ncHJfYVsxMV0gPSBjcHVfbGRsX2RhdGEoZW52LCBlbnYtPkRDWCsxMik7
CiAKLSAgICBpZiAodHJpY29yZV9mZWF0dXJlKGVudiwgVFJJQ09SRV9GRUFUVVJFXzEzMSkpIHsK
KyAgICBpZiAoaXNfdHJpY29yZV9mZWF0dXJlX2VuYWJsZWQoZW52LCBUUklDT1JFX0ZFQVRVUkVf
MTMxKSkgewogICAgICAgICBlbnYtPkRCR1RDUiA9IDA7CiAgICAgfQogfQo=
--000000000000bcd5a505ffd4722f--

