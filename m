Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684E804452
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 02:54:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAKcd-0002oy-GY; Mon, 04 Dec 2023 20:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcY-0002ob-1Z
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:10 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcW-0005wI-GD
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:09 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b8b0b75445so2241298b6e.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 17:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701741186; x=1702345986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XF5K8O5SQwDSokoUyiDBbzfRCq65ULeWitW0enkEhyo=;
 b=H6OApjeVWnKubzkRZodByq7skBd+4xvX+x2mDOEUiQf0xYcA/GrxZwLK/WSupIYmha
 rCS2kWMRvoi6lrvFnwkGmGt2o0565n84WwWcMIBE14KpqKklRvF5/iUamDgY0fa4wUPu
 3xJGHUxV3MM2DxXtq73+LI7oRpZMYR4tjlumH0EFqp9GEQRS1O3LOXlm5tO5KY85Guna
 hu1dmvv1aVTsojlLaw+p78JW1tZN/kxfoXSLIPdJpnUcFBwOZo9F3+IxpEEck6h5QhUk
 xGVp/m26Kl+YOrL15ZFnTuwVtTU9vIyJqCaTsA6DZRsZMYdUAxt+KQDMPuqJaiRWl1Ro
 UpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701741186; x=1702345986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XF5K8O5SQwDSokoUyiDBbzfRCq65ULeWitW0enkEhyo=;
 b=IdFKbfefp9zFVywnGRk24XCDJpZPXb0Xvo67lH5kmSwlMrONyKaP7lV9jXUoWnBJC2
 /8aAy7Tlpl+9VHsJX8YMEpHhC++sgo7IgL73MD2NUSsttfuHKpjbuwKCN6c6tisijza7
 JUS3iuO8Uu5jxSWWCucrG1+s9VQFqXxkXJOYPuqgRNDjgcb7ceKarcSLdpFBVR8wKPEe
 sTVLU34icgpPI9dsyWySAqLw64X6yHqNORkNOAm1el6zfcewuhZAl5aOZqk/YbyRC0qS
 gtbEuU0k/x+gsNvbKpKeWetQgXRcoTRRGbSUtAX86KdWxeMf7NQCLX7wwZVKQkoE3s8Q
 NVwg==
X-Gm-Message-State: AOJu0YyJPJl84gVNN1r2wuFKPsxNZo3OrH0CpwYSr9Mf0WKHwPLYwWud
 nReXO7fFg4ofxZQge7t8vXal/flqIoa4HA==
X-Google-Smtp-Source: AGHT+IEvM9EEnKbGA4RZk1LrusTBi9MolWL/qZAVvFSwl8Og4eTjiFgBdwt+QLOu6EuaXLIDty2e6w==
X-Received: by 2002:a05:6808:2018:b0:3b6:cbfd:b1c1 with SMTP id
 q24-20020a056808201800b003b6cbfdb1c1mr6802882oiw.23.1701741185756; 
 Mon, 04 Dec 2023 17:53:05 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 c4-20020aca1c04000000b003b8b7063a44sm1064624oic.44.2023.12.04.17.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 17:53:05 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 0/9] Hexagon (target/hexagon) Make generators object oriented
Date: Mon,  4 Dec 2023 18:52:54 -0700
Message-Id: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22b.google.com
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
 target/hexagon/gen_helper_funcs.py          | 400 +++-------
 target/hexagon/gen_helper_protos.py         | 184 ++---
 target/hexagon/gen_idef_parser_funcs.py     |  20 +-
 target/hexagon/gen_op_regs.py               |   6 +-
 target/hexagon/gen_tcg_funcs.py             | 578 ++------------
 target/hexagon/hex_common.py                | 818 ++++++++++++++++++--
 11 files changed, 963 insertions(+), 1227 deletions(-)

-- 
2.34.1


