Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADB1BE4E22
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Oct 2025 19:39:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Rw9-0006K9-DC; Thu, 16 Oct 2025 13:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Rvv-0006Gl-KR
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:38:35 -0400
Received: from p-east2-cluster2-host2-snip4-7.eps.apple.com ([57.103.78.20]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Rvl-0007bl-QE
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:38:35 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 6EE051800119; Thu, 16 Oct 2025 17:38:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=lE935EhSo6eiiRGBTf1TCzdO8HBh375WWDyS664DB/c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=W++12eaCy96hQ9x+mbUtcmZUoDvKj+5sPov5MvuBlgxYfTHNGz3omeu/jfUHRuvonAq++9ZzkIlGvPvAHTu5iukjNUUV/jvJrsgqQmIoBmlSf4dPl8NwVnIXhvzjIl8P1GWrAWXp3BZJLA2rIGiAzbNNYNelcWIk7COPSQuY2XSOIW9qF35d6E8aM2qlqbNFs2ctCFu6slZgYDbPcD3kg+68JtWbxPzubAkwT1fbKrphcvGJuJawqYKQg4xN8Q7rkSSW2iAMaQY4ACGml4qJL42lMr6PBuTRocu/ptN5knWPLaOzMrjzJdtnm7hRFsdMa3laC9gw29HVFf5E5HmVTg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 B39F318000A8; Thu, 16 Oct 2025 17:38:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 03/24] qtest: hw/arm: virt: skip ACPI test for ITS off
Date: Thu, 16 Oct 2025 19:37:42 +0200
Message-ID: <20251016173803.65764-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016173803.65764-1-mohamed@unpredictable.fr>
References: <20251016173803.65764-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyOCBTYWx0ZWRfX749a2SXYeHr3
 J5opij+NZ8W1L3rLUkZizWfNE1oh3Mx1jrncl/LyfcYXPBobM10lkJGai7DS39UTdV9U0MoL5W3
 JnjznS5+w70uWLEIRvWT3cTPPnXw6d6VKVQByzghN3O3r2R6ca3IdTVXSPOy/BFa3XUEWdOlyz1
 zWZoMewIH0ZYg8OH6BmjEAxuYtpxGT66CuvYf4HZl+7sB9yF4RJq7TP0jRUU2JD4DCT95tPa347
 G8A8JDzM9cYHtnkVfZkIeiSf5mKZ43VafG6olAqocq4o80PJXUNbhVhc1RfDPDAJwURcjAkCo=
X-Proofpoint-GUID: SKxZss3_oV4GvMKJxKSlK1Dpi1Nwz3gF
X-Proofpoint-ORIG-GUID: SKxZss3_oV4GvMKJxKSlK1Dpi1Nwz3gF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=982 mlxscore=0 suspectscore=0 clxscore=1030 spamscore=0
 malwarescore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160128
X-JNJ: AAAAAAAB8gRNF0hAdUMpu6gHhQeAPZFTUpHzUwdjfRuA1QHQU2+1roDqpXUA+Iz24pM0SS1sj2TNTl9ihTh5Yjp8dyUI/BwdGC6FIjH27Mvl2/TwgDcZnsdH3XTWRVewenvNGTxmwiFTBlqlRkP0is8SOZmr+cbhxCQqn4FDKWg7gSe/XQWcB/rZSsxiL6stjA6NQYPnjMikbP17puQssDEavPtY5Pmr+lK3vjKyJ4BeJChw90+oVud0HAbeIxXQI5+zfY15WDSh2nzCZe4ThQDrkC6f9f/tRXC15QjMl3SJ4RnAfAYkV0LmHl5AEp/OfB1B8LDxwYWHiAvlJZz3awEFMnLVUCrytLa2yvmMcr7uXZT1Km693S7g0DhSAn93MDYW56upxhsGp8cQpxbvT2BON99oajiS4cj6VKWdLoP/7GFd0WSolrXUufLRKCjRU84IYU4gMJc0pn1xj6YSZkL6hnM25uX3vpoaI9xL/mOvHZxS5RDBEgNfsW+Emk5BDZ33bNQ1v/lHf0d+viheTezE5vUq+O2DyCGnedr7PPST6SHvkV8SqCGYwVzPpRjvEdhFi/TTFfY9mrAivjaxCG8S10OeRaY9miQY7OWqKbl61t26sfPQtAC4FbQ+7GZe26mWErn7Ye+fIFzdRRFuRftWqwlILSikjbfG7trasNAztRJd6IX6X3/gvlzLFE04ZfcR4Jg7QLkiSA8fjvFszl4v2PZIGmt3HwqS+TqMQI7ZuApr8I4GmTSziUB7oFniId2Y9qc1+96Xfx9L8K3E1yMRkAccZinU9gv/jAaDE0OXRtf9gjzdO3Q0F89/g/fA2F8vM5A7rHkUMjthuLEaxXcRl4FcEaq5Uiw8hnhPmB8sUjtobvwvvNAz0nzaE58z8BQydTV7QObrEyNQHRoGwjrY/lzg
Received-SPF: pass client-ip=57.103.78.20;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..bfc4d60124 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
-- 
2.50.1 (Apple Git-155)


