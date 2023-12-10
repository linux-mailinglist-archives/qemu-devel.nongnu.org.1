Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E87DD80BD7E
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 23:08:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCRxJ-0004v1-2D; Sun, 10 Dec 2023 17:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxH-0004ut-It
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:19 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxG-0004Y3-34
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:19 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6d9f514f796so1688923a34.3
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 14:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702246035; x=1702850835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0Y+LNJ6HTs6ANDIoy64EPRLOOumatkpCdJLZ9/sq3Lc=;
 b=XewEE1leeVrd5HQpHtbgoTeGl2ZLbzO5zOpUEelW0uksiRbqpRKJsTuVHxyxB/XdlL
 EPl79P5hpAIDeorthLeIP05KwpV/9vJcYfDCSU+BptV7v2je0VUzZEHVJ2Lu14JwnMcT
 nju7tN3jVMuxZ/qPkruA5Wbd3rmx2Efzk9gylyE90YsesUWc7SpTcgM9cfmLLf5Wk4VY
 CqGOJO44nulBSRiHLUsl/J/kqiTNTceTa5opERx81H6Quhf4nFLyHz4HdguHo/i7R9Ho
 upogZo8ocVHGhmr2IoMx/2c2r18c/fFYXHI1TvBvDzxgJEcbZz+8c4UO2MOReys+P0eu
 eiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702246035; x=1702850835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Y+LNJ6HTs6ANDIoy64EPRLOOumatkpCdJLZ9/sq3Lc=;
 b=LaFOJZJ3UxjQosKtul/3XpRaNRbmlDTmfNrUVvSn3UBFp4Xr8zhZn4BKeN06zIg5v5
 l8U2RRWWzYuIoZ0GwXTMtzNcCB8Tz+DZSZ5V5AkEJDHFicqiHLNymJvbAj+Qfrg+VCVo
 UgtNxI1/3zFXivvLDpjeM0JHpkHD/Pg2u0W74pS856ZzVLO1e0BtBQSVGMZvueqTu6Bx
 fMizd8/1LzBAdjYDl9JQ0cu+MIbvoZ18O+Jvt+vC8Affbk9U5vRYz3GAHmnrbjBN3FtL
 C6PhBCfROz/3cRQOhGbiwAXRtazi6d8ngtI8fYHlGfMnHajipzN1B53ae2JIXJNTtAh+
 vcyg==
X-Gm-Message-State: AOJu0Yz5MXwiyVVpz+b4NR0XFiI5VhEEIb5RunAry4HIyl8YCxDnmqpj
 rguEFkPQu0HtD1RAr8Bj/mYUCwSLpk9Nbw==
X-Google-Smtp-Source: AGHT+IEbZ9js78tqwogu28yJXWSfPVmjal7IdOkhnmrpG6p8ViBpGG5Lxd/Cund1i851gIWtRgiKJg==
X-Received: by 2002:a05:6830:1d8b:b0:6d9:e90c:ec64 with SMTP id
 y11-20020a0568301d8b00b006d9e90cec64mr3768575oti.36.1702246035365; 
 Sun, 10 Dec 2023 14:07:15 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 q23-20020a4a6c17000000b0058e200a9065sm1588173ooc.29.2023.12.10.14.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 14:07:14 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 0/9] Hexagon (target/hexagon) Make generators object
 oriented
Date: Sun, 10 Dec 2023 15:07:03 -0700
Message-Id: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x32d.google.com
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

See commit message in second patch

**** Changes in v2 ****
Address feedback from Brian Cain <bcain@quicinc.com>
- Consolidate logic to create helper arg lists


Taylor Simpson (9):
  Hexagon (target/hexagon) Clean up handling of modifier registers
  Hexagon (target/hexagon) Make generators object oriented -
    gen_tcg_funcs
  Hexagon (target/hexagon) Make generators object oriented -
    gen_helper_protos
  Hexagon (target/hexagon) Make generators object oriented -
    gen_helper_funcs
  Hexagon (target/hexagon) Make generators object oriented -
    gen_idef_parser_funcs
  Hexagon (target/hexagon) Make generators object oriented - gen_op_regs
  Hexagon (target/hexagon) Make generators object oriented -
    gen_analyze_funcs
  Hexagon (target/hexagon) Remove unused WRITES_PRED_REG attribute
  Hexagon (target/hexagon) Remove dead functions from hex_common.py

 target/hexagon/gen_tcg.h                    |   9 +-
 target/hexagon/macros.h                     |   3 +-
 target/hexagon/attribs_def.h.inc            |   1 -
 target/hexagon/idef-parser/parser-helpers.c |   8 +-
 target/hexagon/gen_analyze_funcs.py         | 163 +---
 target/hexagon/gen_helper_funcs.py          | 368 ++------
 target/hexagon/gen_helper_protos.py         | 149 +---
 target/hexagon/gen_idef_parser_funcs.py     |  20 +-
 target/hexagon/gen_op_regs.py               |   6 +-
 target/hexagon/gen_tcg_funcs.py             | 566 +-----------
 target/hexagon/hex_common.py                | 921 ++++++++++++++++++--
 11 files changed, 964 insertions(+), 1250 deletions(-)

-- 
2.34.1


