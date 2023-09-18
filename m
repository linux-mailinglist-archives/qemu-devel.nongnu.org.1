Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C10E7A47A4
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:55:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBtq-00051B-Hd; Mon, 18 Sep 2023 06:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qiBto-00050x-Jk
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:54:40 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qiBtm-0000Ar-RS
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:54:40 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 9B0F03200564;
 Mon, 18 Sep 2023 06:54:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Mon, 18 Sep 2023 06:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1695034474; x=1695120874; bh=6HCr3S0i0x
 CJSyP8asVJZ843rG5WmihZHN7F3mbDiD0=; b=SoQ0BhUAr/f6H838qCMytd6VF2
 Vt5biaro991czBY8EpM4TIWKuscjTByqE3ju6hR8l8C3tP6GKstc0MremiuOtf0e
 ySzDeUOP2xM7tyxS4fDVR75d2mG06pcxmmCyNlvLTyFCmPzgg99yRL1IUGN2VUHS
 3OdTc8i9G79vZq257o0KbzBKcYqMRIY/bPahCvwB5oTEYpDFdVdFZSKbt+AL9Nqv
 ldJ2WFpx7qVlpaTtoq0iYS/CP3obhY2moQA01jTmTc+L8lQKh/assjsrpGuIcDEi
 YkCheqn8JGTWJ1suVaT1nJTfIrFszEg+QbDZuZXGI7jCJZzXIo+yWJo/oOQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1695034474; x=1695120874; bh=6HCr3S0i0xCJS
 yP8asVJZ843rG5WmihZHN7F3mbDiD0=; b=Odl1wdkCtb2lgaQb2HyjxJll22v2W
 GE8wAb2bYalIOFffrMTUElzh6h3ld/lMNVxEtHkvUTtk237w76uK7DGyG2SMU4Io
 TDtoK61KoFNO+C06xjBO5HZ6HZL37Ihy2bOR/ndQENVNe8YfwDqfdJ4cDGekjg9Q
 aT7zwiyRx17RANMrLIy0q+uFHjpgUyvmGP1wm3pMtaUI8oOpfBpJwyrqTApD0jDe
 UzHuepfmEcQVIWqjNUQo2Ub700ucdhm6v119/yPUvZQYpOFWQZQ2yqz/oJCBYlPO
 pj2Xvn/TY3jer7repTpkzyl9m/Wfc3XQ5i7Y95GKbuGUDFepzkg4e6s/Q==
X-ME-Sender: <xms:aSwIZeXK4M2MONxvaj3MhM6aCHQhm4cV7HD2A7rrwGB8CBOwMFSujA>
 <xme:aSwIZak9EojbwJH3Igb9kKNA4amEHRsDuzxr5jvIydKf7PBqmdGMuofgUORzeoxrF
 v9b_aIVsAnzbajlhg>
X-ME-Received: <xmr:aSwIZSZvVrDexeQg5OTbbQGlpU42UWCNn2yjPtu_ST4bFkMYlJJnNpwOMa5v3FWAXkF1Gyk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejkedgfedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
 evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
 uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeggfetgfelhefhueefke
 duvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:aSwIZVXjlGyqWPl_l9vbGXnykK2GkW7w5qEdX81JRlWzXFwCqRC7lA>
 <xmx:aSwIZYntQoT_AdX9Sy3OoBH6M9uGucqmlpgZX1F0811ukfHkK0yFNg>
 <xmx:aSwIZafVGrsSSY_6D2SbHRhtaOEK2EdWiiR9o_f9ua1fkcyEwnW_Tg>
 <xmx:aiwIZUskAzqzQbRuqqaZ0jC84qn5Vw2CRzxCNg4GLtwgXYyimCtgRA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Sep 2023 06:54:32 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: qemu-devel@nongnu.org,
	berrange@redhat.com
Cc: hmodi@aviatrix.com
Subject: [PATCH 0/3] qga: Add optional stream-output argument to guest-exec
Date: Mon, 18 Sep 2023 04:54:20 -0600
Message-ID: <cover.1695034158.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.24; envelope-from=dxu@dxuuu.xyz;
 helo=wout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, commands run through guest-exec are "silent" until they
finish running. This is fine for short lived commands. But for commands
that take a while, this is a bad user experience.

Usually long running programs know that they will run for a while. To
improve user experience, they will typically print some kind of status
to output at a regular interval. So that the user knows that their
command isn't just hanging.

This patchset adds support for an optional stream-output parameter to
guest-exec. This causes subsequent calls to guest-exec-status to return
all buffered output. This allows downstream applications to be able to
relay "status" to the end user.

I also uncovered a latent memory leak bug with the added unit test. The
fix is in commit 1.


Daniel Xu (3):
  qga: Fix memory leak when output stream is unused
  qga: Add optional stream-output argument to guest-exec
  qga: test: Add test for guest-exec stream-output

 qga/commands.c        | 16 +++++++--
 qga/qapi-schema.json  |  7 +++-
 tests/unit/test-qga.c | 77 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 3 deletions(-)

-- 
2.41.0


