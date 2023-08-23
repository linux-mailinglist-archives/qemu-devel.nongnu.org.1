Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BE2785284
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:16:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYj18-0005Ce-PH; Wed, 23 Aug 2023 04:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qYj16-0005Be-5o
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:15:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qYj12-0007Jw-OS
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:15:03 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 3E5E05C00D6;
 Wed, 23 Aug 2023 04:14:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 23 Aug 2023 04:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1692778497; x=
 1692864897; bh=o5ic5/+6EJNwErE6TEu6TmJub+yynzCwgkA9yfMtvkw=; b=C
 gqKTu161/X2E1TR26L6+R7Mp0thi+SYFrgO4kM6VDDoCBzK1VN+RGLKmxXge1bR5
 5e8tG0G/W71SF6S61zWR1ADoPWLyGZujLEvKUVvuHwD9Nt5Tlh2Ilu2resaswQOp
 cG+QbzVRb8gXt0I7bwM3iE5taC84UwoM4g/c5WQ/GCoA7HXcsKvULJE1Irmnmd/D
 i755wRkKAu8PwYd4Dnkyi93WE0whIDicA84n+R0B+OUiAujqnws2LxejAQ9WIvf5
 0xBG2e88PzS3Km6HFJiiW1hhTO6W2ile53b8pWia0f3Zmer7/cJzHFvTszRclTcI
 dhCYXj7/4Y2sGMOrsN3qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1692778497; x=1692864897; bh=o
 5ic5/+6EJNwErE6TEu6TmJub+yynzCwgkA9yfMtvkw=; b=lGTxJqhZHVHXgMy3i
 FHIT+Z7SqRDkdAZrrEok07zgOYfiq2HWcztvPu9Wztb/Rt0wHuJZL52U3hZMu+6b
 eFLREyfbbq3zGIu6WF2BDCUVZw4xxA3tqTo7yogk2iW2qFL7KtuqGk3WAclHsUwm
 g8GedvvhBDsFshVNN4cSOfre24/qievzv5WaCCdo9A7ZLTE3aYXhbQeYXD0ETxvF
 rBv39ooh4Twf6rqpLxBt9OGUwQGciSdF3JOWb95Gog35K5kuwcZfZNe0Ts7GLPpG
 436zTGGHWEepHN9m1ZYMnxKv+xrDiiDPQd6VA+Ho/odLEpR5KDOtX3hmG+l3Bhq5
 ektpA==
X-ME-Sender: <xms:AMDlZJfosRioU-cC8Zu8Q3VuiwAdugWWJozfcCzELF0GviGLn39lVg>
 <xme:AMDlZHPO4f-tVa2fO2J856oURSJ3Tq3ddJHAjnIcIska61-2o-Ag3TrsMEcX5wyiu
 PkwPb74pv_qyIFZkl4>
X-ME-Received: <xmr:AMDlZCiRBNbCeWjiV0WWPsgeiW1mfeUUydkANsGmAUpYMMh5NUexMaTEU7CfREUmFJGwgoI_IALeCukfwc0_GKOKBKCu7gBaN_q6DPwRtU3-VwRzHTABa0VYMYEKhIXizIrQBTmuboncQAcaTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgtddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpedvfffhheeffeeugfehheduleelieejueduffdtudevtdfghefhtdffgfevkeeu
 feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:AMDlZC8qHwDSyNxB0WtrqojkIgJu3IwxEiq6AQaZZb8U0jb2s03cvg>
 <xmx:AMDlZFv0wu5xlPXQP3nHo8PCZOPWV3ehFYilSSS-MLI9FuivIWJC0w>
 <xmx:AMDlZBFpVn-9VoeJt4f2ZB2KyjesNSTJ727lFR9nW29bvJSyatjV1g>
 <xmx:AcDlZLATGl6unsKDVYBU_eunhaPsp_1xxH7CoTgGXwiMkGeAqe_qvw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 04:14:54 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH 0/2] hw/misc: small fixes for i2c-echo
Date: Wed, 23 Aug 2023 10:14:40 +0200
Message-Id: <20230823-i2c-echo-fixes-v1-0-ccc05a6028f0@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPC/5WQC/x3LQQqAIBBA0avIrBswTciuEi3SxpyNhkIE0t2Tl
 o/Pb1CpMFVYRINCN1fOqWMcBPi4p5OQj25QUmk5K42sPJKPGQM/VNFOxksXpLHOQJ+uQn/oz7q
 97wcZNTHaYAAAAA==
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@aj.id.au>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=561; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=Esy8NHvDVEXxRgbHHxGoJOnBwt49Tl//0xoO8s059J0=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTlv/5kopjWEriYTp39hnT4HJlPnPJcPnaT1
 aFBfUxcsBHHyYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk5b/+AAoJEE3hrzFt
 Tw3ppVUH/jmGXIIcWj9KmAed3EFnJNKhqKi83ZG/vSzEbloc9AES1FdgnCPPrY9VBjRAe87RLzH
 oHE+WFrWw2o3ooHOMbtJvgDNpDRT3vB1Mj0G7TwfCfsgzFLXbLZsYQipm51SNSr+AljDUzsRVzh
 jUORIPzAWkzLkDgLGFu6eL1tIyRjxq5+IBCzIdi8bopvsELM5x6b1ZTTN27/IelO7v42GybwjyW
 n2ZKBjxw6EUaHrD06oVjf2jbIZOlzpJzpvx7e9LMrQx02dcfAwSI5+2NYGhwNracngC9d3OLubc
 sPnM9PTzwGKA5o98g/+57d9gKGqwpoWhqKjdmDiTR2A8Y/zYPcIVWbM0
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=66.111.4.27; envelope-from=its@irrelevant.dk;
 helo=out3-smtp.messagingengine.com
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

Add missing copyright/license note and add a Kconfig entry.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Klaus Jensen (2):
      hw/misc/i2c-echo: add copyright/license note
      hw/misc/Kconfig: add switch for i2c-echo

 hw/misc/Kconfig     |  5 +++++
 hw/misc/i2c-echo.c  | 10 ++++++++++
 hw/misc/meson.build |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)
---
base-commit: b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa
change-id: 20230823-i2c-echo-fixes-945c0bf059b5

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


