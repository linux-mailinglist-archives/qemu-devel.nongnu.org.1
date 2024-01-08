Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD21F827AE1
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 23:49:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMyQQ-0006Vl-63; Mon, 08 Jan 2024 17:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rMyQO-0006U4-7j
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:48:52 -0500
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rMyQM-0008U3-NC
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:48:51 -0500
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7bed9fb159fso2374339f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 14:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704754128; x=1705358928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DPahhnq71xE/yArN/fL6kp/8U5JbCKIFFFz4k5jVLz0=;
 b=SNKlHiTXy9Rdt+xghMKjK6yRvFBMkaA9L3ULScLN1gmgsrNw8BEYaqd7yh3Xs2oryU
 +l3T0ENSCJnv3EF6K3Mco79w3ZZQitPsV5OIbonQXXwInK9rx75onFyGdYi3fyBtO1E7
 qQmy+h9AFZBliD4+yW+XrdDeUkZ/C+t1pRoE8Etkq1XSRv8rCTmAg5KTUdMi1bHW6ch2
 g1b2PTB4bPf1feCavt+JazKI/k6qRqb4zBX7SedMKLx1/je8V15B15k467qceHqJ2DHv
 Bl9ZOUgqtJMeU1bCrVSB7N8OccoXNt3RNXl/EH9FfViJYJS1zESnOrQBxuFrbLszxcx4
 2Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704754128; x=1705358928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DPahhnq71xE/yArN/fL6kp/8U5JbCKIFFFz4k5jVLz0=;
 b=uFWOuyYTVr9dJUvCB+/5rbxyppLDc4Tt8F41Ri7XZIzur/a78kstFlnfO1ovOmEjOs
 6VlxsIUxvacVj175zHFJbYGMHYNTOBCmls+Re+sJTAm4OSIEyzqKy8xM+msbr1tITbbQ
 ApTvY2fioqSkZjETYVDJ0Ug/mKjV3SqaNxGiZLarovh3DTKYNRbVlBuAxUCCqKvkydOb
 hEtDey4GblESDmZFGKqfLhP+WEudUcOBcdy8W7hxxfud4lmWmWPGbT8lQMua4g/GI89d
 8x9bg5KSre/PKo/AlAm59nj3vXDIq4F08g9DEpd8rZ2cXSUGa4nuhz5067UPi0OX6208
 L8xw==
X-Gm-Message-State: AOJu0YyceGrDHL6OCylv8aDb73C49XX03GZq20gFPGLlhO+W2WQNJUBD
 1slVTEFxZHio4iBB4HVHDCi7pjboOhRyCw==
X-Google-Smtp-Source: AGHT+IEqkzJi2p5hQ8A8Z04iSBU8l8yILtL/GLjIqrFxZXNT4f0XJaucV1VUfBA8HIodEJMuLNiQ3g==
X-Received: by 2002:a5e:c60d:0:b0:7b7:fdeb:da0e with SMTP id
 f13-20020a5ec60d000000b007b7fdebda0emr6580196iok.22.1704754128332; 
 Mon, 08 Jan 2024 14:48:48 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a056638204700b0046e08e513b2sm241877jaj.116.2024.01.08.14.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 14:48:47 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 0/3] Hexagon (target/hexagon) Use QEMU decodetree
Date: Mon,  8 Jan 2024 15:48:42 -0700
Message-Id: <20240108224845.285864-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd2e.google.com
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
 target/hexagon/gen_decodetree.py    | 203 +++++++++++++
 target/hexagon/gen_trans_funcs.py   | 124 ++++++++
 target/hexagon/meson.build          | 147 +++++++++-
 11 files changed, 591 insertions(+), 824 deletions(-)
 delete mode 100755 target/hexagon/dectree.py
 create mode 100755 target/hexagon/gen_decodetree.py
 create mode 100755 target/hexagon/gen_trans_funcs.py

-- 
2.34.1


