Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C327F5E0C
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:42:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r684f-0005vy-DI; Thu, 23 Nov 2023 06:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r684d-0005v6-4J
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:40:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r684U-0004I2-M5
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700739636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JeqP892DzhkTxHj6IE1v7O4xtUsvGNW8S07qnUqVAWU=;
 b=EFkNAILJGO2GsH45c45YwIjnP+8Unr3tzGqTIRblG/0GUZCHZ9lSJLL7ep5gr5V6ZMpNm/
 9huU03uoJTRYaFBjv/0d12Y8Gf4ssp9mKnT3dfBLUIuCcZnkHDjjdMznUR0VC29c/rtGKB
 Y9k9QyRwzJ0si7hvNT5YACbKVsh3r1M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-B1j-S8t-OzSv9DlmRtuTgQ-1; Thu, 23 Nov 2023 06:40:31 -0500
X-MC-Unique: B1j-S8t-OzSv9DlmRtuTgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88519185A783;
 Thu, 23 Nov 2023 11:40:30 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A97F2166B26;
 Thu, 23 Nov 2023 11:40:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/2] docs: define policy forbidding use of "AI" / LLM code
 generators
Date: Thu, 23 Nov 2023 11:40:24 +0000
Message-ID: <20231123114026.3589272-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch kicks the hornet's nest of AI / LLM code generators.

With the increasing interest in code generators in recent times,
it is inevitable that QEMU contributions will include AI generated
code. Thus far we have remained silent on the matter. Given that
everyone knows these tools exist, our current position has to be
considered tacit acceptance of the use of AI generated code in QEMU.

The question for the project is whether that is a good position for
QEMU to take or not ?

IANAL, but I like to think I'm reasonably proficient at understanding
open source licensing. I am not inherantly against the use of AI tools,
rather I am anti-risk. I also want to see OSS licenses respected and
complied with.

AFAICT at its current state of (im)maturity the question of licensing
of AI code generator output does not have a broadly accepted / settled
legal position. This is an inherant bias/self-interest from the vendors
promoting their usage, who tend to minimize/dismiss the legal questions.
From my POV, this puts such tools in a position of elevated legal risk.

Given the fuzziness over the legal position of generated code from
such tools, I don't consider it credible (today) for a contributor
to assert compliance with the DCO terms (b) or (c) (which is a stated
pre-requisite for QEMU accepting patches) when a patch includes (or is
derived from) AI generated code.

By implication, I think that QEMU must (for now) explicitly decline
to (knowingly) accept AI generated code.

Perhaps a few years down the line the legal uncertainty will have
reduced and we can re-evaluate this policy.

NB I say "knowingly" because as reviewers we do ultimately have to
trust what contributors tell us about their patch origins, and this
has always been the case. Our policies and the use of the DCO, serve
to shift legal risk/exposure away from the project. They let us as a
project demonstrate that we took steps to set out our expectations /
requirements, and thus any contravention is the responsibility of the
contributor invovled, not the project.

Discuss...

Daniel P. Berrangé (2):
  docs: introduce dedicated page about code provenance / sign-off
  docs: define policy forbidding use of "AI" / LLM code generators

 docs/devel/code-provenance.rst    | 237 ++++++++++++++++++++++++++++++
 docs/devel/index-process.rst      |   1 +
 docs/devel/submitting-a-patch.rst |  18 +--
 3 files changed, 241 insertions(+), 15 deletions(-)
 create mode 100644 docs/devel/code-provenance.rst

-- 
2.41.0


