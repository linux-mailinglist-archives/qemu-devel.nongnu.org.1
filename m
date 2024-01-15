Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D6382E27B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:15:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVEL-0004nT-BH; Mon, 15 Jan 2024 17:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rPVEG-0004mz-FJ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:14:49 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rPVEE-0003XT-Ux
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:14:48 -0500
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7bf36d35af4so79039939f.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705356885; x=1705961685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=//CUTt+PfO8qp1j0mYbjeTsDoBV55fCccYfBnBFALhI=;
 b=GltzsiNYhGzap1tintpY9oiVRHy6vCZ/Y9EQzodV1SQZfg1yQh9pbqE5KrfLvjxl4/
 NDYR4EMXVlZy7Rpo1J20Mv/yu2Lai8awmy/2YanBu1RoYLXqup149MSVw4qtECDOFZow
 mqYjqAcNdt5YMnGcFkvc5C7Gh82B8qG31x4RdMoNdFzNc7t0eG7qBuhKUSMFvnyK+65z
 peFLNz0wsGxCaxXwSpDqf6j3CJnGm900t/9/J2csxpCYK4gHBoCZoqi1G1oMEhF7D/v5
 ODs65+NbcynCBsmCtIssKsXwJGatwFCPCOC/RdfEIdo4ikmu7irQYhoeWNStfZWhxqvT
 y/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705356885; x=1705961685;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=//CUTt+PfO8qp1j0mYbjeTsDoBV55fCccYfBnBFALhI=;
 b=ZY9ZMjCNLOPkgbEp6FimryVpnKm0l7IiD8V+3OieGCnynKxcspNE7e0Ke1Raux9dCV
 3twp4WEQTT+eW1Q4ka5tX7Kne9kQl9r/LG3lg8bbF08EtPxjqxR8zHzOjMZBLF0ecloB
 OY8krDzaVIJVcZ2QxQNa8mnl5gsKRf0UnOct4vUsaeHD4brJ2u2onopI9vzJnCBKV3zu
 +/htNBUQKXkbuWqbspguCOHSe15o6pFrEuuROn6daBsdmh3hMlfO6TQon/SbejEXb7z8
 Gjd749OpBAl/igziQmUUjTd7xjgHTaoZ+kbDMNsdnLIwsP4WhTj8/di68AzdvV1+lI3q
 eeZg==
X-Gm-Message-State: AOJu0YyH8g6kiLThAFmN35AcMkrF4W/wLbdx9EPpXsrh1e8faWyyQKNd
 8j2RQMPQTRCodMr7a3MFz96TtepzYW1jtg==
X-Google-Smtp-Source: AGHT+IGMGWhPYj4+uUfuYs4Gdw70Gh1yHOm/mZ+CPhuS8nsD+zSnkDb6CV6wMaay5GmoQ2az/K1CjA==
X-Received: by 2002:a6b:7f4a:0:b0:7bf:544c:b5ce with SMTP id
 m10-20020a6b7f4a000000b007bf544cb5cemr576015ioq.31.1705356884944; 
 Mon, 15 Jan 2024 14:14:44 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 gm25-20020a0566382b9900b0046df77733acsm2579705jab.102.2024.01.15.14.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 14:14:44 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 0/3] Hexagon (target/hexagon) Use QEMU decodetree
Date: Mon, 15 Jan 2024 15:14:40 -0700
Message-Id: <20240115221443.365287-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Replace the old Hexagon dectree.py with QEMU decodetree

**** Changes in v2 ****
Suggested Python improvements from Brian Cain <bcain@quicinc.com>


Taylor Simpson (3):
  Hexagon (target/hexagon) Use QEMU decodetree (32-bit instructions)
  Hexagon (target/hexagon) Use QEMU decodetree (16-bit instructions)
  Hexagon (target/hexagon) Remove old dectree.py

 target/hexagon/decode.h             |   5 +-
 target/hexagon/opcodes.h            |   2 -
 target/hexagon/decode.c             | 435 +++++++---------------------
 target/hexagon/gen_dectree_import.c |  49 ----
 target/hexagon/opcodes.c            |  29 --
 target/hexagon/translate.c          |   4 +-
 target/hexagon/README               |  14 +-
 target/hexagon/dectree.py           | 403 --------------------------
 target/hexagon/gen_decodetree.py    | 198 +++++++++++++
 target/hexagon/gen_trans_funcs.py   | 124 ++++++++
 target/hexagon/meson.build          | 147 +++++++++-
 11 files changed, 586 insertions(+), 824 deletions(-)
 delete mode 100755 target/hexagon/dectree.py
 create mode 100755 target/hexagon/gen_decodetree.py
 create mode 100755 target/hexagon/gen_trans_funcs.py

-- 
2.34.1


