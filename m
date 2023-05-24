Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D98EC70F4F4
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 13:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1mWV-00015I-Is; Wed, 24 May 2023 07:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q1mWR-000132-8l; Wed, 24 May 2023 07:19:15 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q1mWO-0005Tc-Fg; Wed, 24 May 2023 07:19:14 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 94A473200CCF;
 Wed, 24 May 2023 07:19:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 24 May 2023 07:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1684927148; x=
 1685013548; bh=5aYB7tac5/njghVjksmKJWxEDdCW26JNiVA2EAaA/KM=; b=g
 HVKtj3GErmjqX22YWYbs6zJR93xHYMK9zVoCTHFlyU5jL7qWarOoFfxE3+25G2wC
 PVBPGqcYCJ228+VyUKcPOiW1kh3ixaTaWOuZs94VtGSAdFrIUcha81M+o81z6vND
 tBlTO4V7RKZwKkw01CZHbDd6+V78XCsUfE0mMXyg8tp6Lp+YMiVXCGSCj3gJzagQ
 RTuRR6TKdRhLY0LtB6Lx7o0vqH+K9WbGeSOek7OMnBD7xPW76OYbTyVkDBYPM7uM
 jZYrX6DSij/TBdARvrVXhqIZ/t++ryPdEikdFweeMcYQRA94xm1b52ZUmHicUo1v
 mPuITFWhY951NuHcK6kEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1684927148; x=1685013548; bh=5
 aYB7tac5/njghVjksmKJWxEDdCW26JNiVA2EAaA/KM=; b=MfinN0p6iyhW5ewZD
 ogmjp44EPky+D7RFQpzpfylGlDEnKp0ovin2XAWlAFgNRFBN3fBTS64P6PuGjzS0
 bdyguSg1ZF9HzFWMneVu/g3FjxW7kUxnbsVXTT4QUd+0Jq3Fl/MpjvZ/nn2P6be0
 e3eW9fyWT0CWJ6LJIvKjZsFUyaEnmFIhYEgOyWbuxDbmy/ylK6cprkPo7ESTCzvT
 Ue+6tFfZh5vJpyb3LtKlRKJLydOshg8OCFYirb+/swg8nU2pYJxRoWd7Wy79rRRf
 6A3O0oQBAeTYJ9rrTldavGVycYV6ka3mNSPZXnfO5TtGu7EsRqzUep5QBMbOG/v5
 MNLOw==
X-ME-Sender: <xms:q_JtZG41nW9GTmpqrki-SgJZMHOtbad1p4u6EFFQuH-uorVE2xK1FQ>
 <xme:q_JtZP6vTrFAQIfajENWVzThsxXxcjrpQWOPIyo3v1UIGsfSzAZWnIfuwlbqTjHuO
 O9d24ZK7Esw8uz3xwk>
X-ME-Received: <xmr:q_JtZFd7J6pxb9twVCtvmaJ4rw8XFzEiMTQdle-EUrfOJroN02Ao6MG7UNxnUMicrbkAMJ_zRa-a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgfeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgtggfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpedukedvgfeujedvgfdvfefffffhheeitdeijeekleefvdfhgedvvddtfeeukefg
 ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:q_JtZDIat1bqpC32n7nVN7MCgrtUCGK1-OWPmVESxBhRSAK4K5IS_g>
 <xmx:q_JtZKLX2ivQDSur327XyymJTFmFyDTHKBfIhxPHjZTyHZGQJHHeyQ>
 <xmx:q_JtZEz4JxDqpt0YDMRtMtUKl7vNdVf7Tp5ihNfslEmuFTBLlbg_bw>
 <xmx:rPJtZPG6z4CmkpMhgRrHupqixzgn62gJLEjghlNatuHINn97045vmw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 May 2023 07:19:06 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <j.devantier@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 0/4] hw/nvme: tp4146 misc
Date: Wed, 24 May 2023 13:19:00 +0200
Message-Id: <20230524111904.91179-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.40.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=581; i=k.jensen@samsung.com;
 h=from:subject; bh=nqVRfn6zZcgW85tJ90KHxKddiNnCnLxThKgydP0Zmzg=;
 b=owJ4nJvAy8zAxej7cL1hrj/vS8bTakkMKbmflm+rmBe1ry/eTXK3+erEnpVs4mWXLdUKNhSWK
 H/393yav7GT0ZiFgZGLQVZMkSVIw3hV6aM7zxa5px2AGcTKBDKFgYtTACYSFs/+P1pk2S3jvXW+
 pxnL2Lo413jdn9r2rbewU6PgZliTTJ/z9hvPn2XG3V9SFfM8Qu3uoc+RE9efWy2p4Dh/hvtzo7B
 FwhdVvabHaZ81erOsRHvhg2cmS/S8XQpNJBv6V8S6qvfadWofF+aVEfqSof+41WbVupz430fS9L
 7dK58WzWLmcFHH0M7j38yghAjfLi2zvecYTy20leWOsLvrp+HS/euo1OmkC3LMBvImBmlBG3mtK
 qsMfa+pKEhxr5Sb1f6s9Mv1Baza2r8OGNe0m3nLWodMTG95/mRDmOTWc/G1cxsE+U86G0qaS87d
 8ESpmmvnQd1WxrrKLy4u97b73z4lZLs20vCcZEHaBN+fxQDjjJ4H
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.25; envelope-from=its@irrelevant.dk;
 helo=wout2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

A set of fixes and small quality-of-life improvements for the TP4146
("Flexible Data Placement") support.

Klaus Jensen (4):
  hw/nvme: fix verification of number of ruhis
  hw/nvme: verify uniqueness of reclaim unit handle identifiers
  hw/nvme: add placement handle list ranges
  docs: update hw/nvme documentation for TP4146

 docs/system/devices/nvme.rst | 37 +++++++++++++++++++++++-
 hw/nvme/ns.c                 | 55 ++++++++++++++++++++++++++++--------
 hw/nvme/subsys.c             |  6 ++--
 3 files changed, 84 insertions(+), 14 deletions(-)

-- 
2.40.0


