Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A26779493
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:29:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUV09-0006M8-N5; Fri, 11 Aug 2023 12:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qUV06-0006K9-Up
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:28:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qUV05-0005EP-Fy
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:28:34 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31965c94001so101455f8f.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691771312; x=1692376112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zMEsHZBJkqQjHLunjzGEDP3wsnZT7wCzzg3kXjjglpM=;
 b=UYWiyYSfa68fbuJ9Gn/kXXb+SVBhGtuzcEzXb7w1TP/xHlOxpzhI0zVbsLVTcVMbWJ
 k/tgE9Hhona33io6KUete3UQJ2af8EiV9YV7vNB/s19dV3AADVOnHwnJRSThDjizpQ0h
 ZAWp3gBTblgEpaOQgeLAAuTGB7wK5687ZRRYmQvtuPLTS7ribJaFHZXhRktHkBMa79Yu
 6cbRgNJL5BgdA9GGSEEiO3SZ2RaSAfUrVJzzz3n9R5SoHehKMHWSIVEinWCr1FbBQd/4
 eBLElc/EVsCZUXXgVgdglaiamFTPMW6S1YnChSnuuQukOmQGNNogg1wV7tjrDRwP+4Ew
 eKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691771312; x=1692376112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zMEsHZBJkqQjHLunjzGEDP3wsnZT7wCzzg3kXjjglpM=;
 b=g8A+kQIhBs7jBzEhx/4mdNmJOtfiKFyCSd2J973vb72Onr4356PMGtsiMjguwgcJAl
 z75BN1IILN5b+jHsh5os+hCx39A+1s4N1O/0cGSBwn/Cy7L8gmqIkozqVousxuyVDWzu
 1iaBW3sgAXW39xQ5WocBiYRc1hR/h2O8rmTogFVFAd17cnXyF0duDKw+fojo8WmkQYN1
 DlI9JRY8BwZ6O7DUxCcbd8GHqWC4Ed3FLTXxR099EJx7Mnxn9MrymAEtaRFdpWXBblZA
 JRKDVkA9K40zxBMBGv0FmWA3BOSyO2hxDtvJRseWBQtnVgodXI3+o2AI2XHLS2C82lXh
 DSeQ==
X-Gm-Message-State: AOJu0Yz36ChcbIu2o7zTt91NNBgWB+HLHdnLfVmAc1UJd43vsf6DaytQ
 5MAj7fAQExH7mXeDBH3DjzphBw==
X-Google-Smtp-Source: AGHT+IGKl+z4bHvxcFN9RsQ7P6rxi2gGZdw1cwUk6fNAHyNA//TuscND47i9W9kZtdzWIE0tK6yyEQ==
X-Received: by 2002:a5d:6b4f:0:b0:317:708e:1c29 with SMTP id
 x15-20020a5d6b4f000000b00317708e1c29mr1767980wrw.40.1691771311398; 
 Fri, 11 Aug 2023 09:28:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f17-20020adff451000000b00317efb41e44sm5931793wrp.18.2023.08.11.09.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:28:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5ABEA1FFBB;
 Fri, 11 Aug 2023 17:28:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 0/2] linux-user: extend -dfilter to accept paths
Date: Fri, 11 Aug 2023 17:28:28 +0100
Message-Id: <20230811162830.2278032-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I was getting lost on debugging output and I couldn't get the mapped
address of libnative to be stable. So to help I hacked up this
extension which may or may not be worth developing further.

Consider this a debugging RFC tool for now.

Alex Bennée (2):
  linux-user: implement some basic FD<->path tracking
  linux-user: implement name lookup for dfilter

 include/qemu/log.h   | 12 ++++++
 linux-user/syscall.c | 90 +++++++++++++++++++++++++++++++++++++++++---
 util/log.c           | 36 +++++++++++++++++-
 3 files changed, 131 insertions(+), 7 deletions(-)

-- 
2.39.2


