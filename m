Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEEA96B8B5
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Sep 2024 12:41:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnQd-0001CQ-Bs; Wed, 04 Sep 2024 06:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQa-00013K-MZ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQX-0008H9-GU
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CoY+4E6hAlpGY4zEgSoU9suJEFylXHhACeFhYJ3dofY=;
 b=TYrYZjuMRg2ShTr9j0yS3KHxPT0LNRjZUv8dgR2Tx4phVsIiQXxc7bsPX1UjbkNFS02Qh5
 9Pj31kTxNu82bA5WtChFVJm7Tp8xRHOKZBh/deJCyKEsjQzGUdZyMnrVCcfCo1DFzZ3IS6
 usJ3Fz+AWHdfwYqr2Ta0svd6DLFUMTQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-1jY6cgVTMzKStwFvNcitVQ-1; Wed,
 04 Sep 2024 06:39:51 -0400
X-MC-Unique: 1jY6cgVTMzKStwFvNcitVQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60F8819560AD; Wed,  4 Sep 2024 10:39:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1255C195605A; Wed,  4 Sep 2024 10:39:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/42] python: Install pycotap in our venv if necessary
Date: Wed,  4 Sep 2024 12:38:42 +0200
Message-ID: <20240904103923.451847-8-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The upcoming functional tests will require pycotap for providing
TAP output from the python-based tests. Since we want to be able
to run some of the tests offline by default, too, let's install
it along with meson in our venv if necessary (it's size is only
5 kB, so adding the wheel here should not really be a problem).

The wheel file has been obtained with:

 pip download --only-binary :all: --dest . --no-cache pycotap

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240830133841.142644-8-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 python/wheels/pycotap-1.3.1-py3-none-any.whl | Bin 0 -> 5119 bytes
 pythondeps.toml                              |   1 +
 2 files changed, 1 insertion(+)
 create mode 100644 python/wheels/pycotap-1.3.1-py3-none-any.whl

diff --git a/python/wheels/pycotap-1.3.1-py3-none-any.whl b/python/wheels/pycotap-1.3.1-py3-none-any.whl
new file mode 100644
index 0000000000000000000000000000000000000000..9c2c7d259365c8a0487228c6878e2c0b10ba6bdd
GIT binary patch
literal 5119
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
a`M=gRMNm<H|DFb*0Z`-skj4D{@BaZhvADJX

literal 0
HcmV?d00001

diff --git a/pythondeps.toml b/pythondeps.toml
index 175cf99241..0a7f69b196 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -20,6 +20,7 @@
 [meson]
 # The install key should match the version in python/wheels/
 meson = { accepted = ">=1.1.0", installed = "1.2.3", canary = "meson" }
+pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
-- 
2.46.0


