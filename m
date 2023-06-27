Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D39277400E5
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:26:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBVv-0000EG-IF; Tue, 27 Jun 2023 12:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBVs-0000DT-Lv
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:25:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBVm-0003Fl-PZ
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:25:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fa8cd4a113so26863125e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687883149; x=1690475149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tV6uJjNfKxjFHFViquI0SJu1Ss2OiTFYxgVHQ5LvQag=;
 b=vz3GTpJyIZzejUR5QStkHDhamW2HoF4hq8Iww0exDXSnuVPrzA/BJY1f+8dlk8RQsJ
 jHNsGEdlDsqptT1Vcl73cwm4BvXr/AiDlv89aPcTHI0JvE1AUZrdqP2vK4J23Sm5l0Fp
 k0NifdCqaU97G9yZcd3Jvn26dTEJkeW+fLvlJIcjVYM3vfwCOkksFN85ubkXVuAP4im1
 PrllyGMs+IgMJXOLYy9ss/mZxNL5FSARc+1NBUSIDFLAaVHd3R4qy8+ve679QQKtxhrr
 x1Zh+WfsTfMDwdU+ZXLFlVOSjs3WrdBsoyHdSSvrWXrJbWnabr+5pTc2jgFI3U4Zm+8G
 g6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687883149; x=1690475149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tV6uJjNfKxjFHFViquI0SJu1Ss2OiTFYxgVHQ5LvQag=;
 b=UqMiH2GOURYXK5+eXzqLdkdFF6GolHxYMNixg9G2pfAELpM6ctmVuInnoo8yqLPMHK
 oVZ10yKMHGiL0DA7yBPFtZBDmzsWr4NnENOZJque5tvHmU+OggLGh3Q859yolfLznABg
 tbRZn2rapEUo8ThymLBc0KAkKiUfPBT1OwN8oHbKtkueuzoXQUtIA81YGUI8WiaA31MG
 W7Vq9Uo6lmDxc1mq0kOzqE0FDI6rAEG/Lt1Gx6ruCtI0sybdkuaI03Wd3Agw1IQ1fXTv
 BTqNKBZ414HAS5qKJbEy0vsJozOb0MPsWjs0wV/efd32HegCYLHgHrH9txYiEtxh/0Pf
 FZWQ==
X-Gm-Message-State: AC+VfDwh6YXKk6EanyDaAXR6r1J5l689rVoJDDNLQ4/rTSt8fCgsMSLO
 6Iw0wU7g5C+FSQXkAsiJf5fN6A==
X-Google-Smtp-Source: ACHHUZ5iWj1kgO2abMVXA5UfP8IDDLxhgt5s6EBBvrFfJ8Vy0sKFHfw021Tc1t0mNomE9bXcgoszkg==
X-Received: by 2002:a7b:c4cb:0:b0:3fb:ab7d:ad95 with SMTP id
 g11-20020a7bc4cb000000b003fbab7dad95mr537473wmk.4.1687883148881; 
 Tue, 27 Jun 2023 09:25:48 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a7bce86000000b003fbaa2903f4sm1063394wmj.19.2023.06.27.09.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:25:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 205811FFD3;
 Tue, 27 Jun 2023 17:09:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-stable@nongnu.org,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Taylor Simpson <tsimpson@quicinc.com>
Subject: [PATCH v3 27/36] gdbstub: Permit reverse step/break to provide stop
 response
Date: Tue, 27 Jun 2023 17:09:34 +0100
Message-Id: <20230627160943.2956928-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

The final part of the reverse step and break handling is to bring
the machine back to a debug stop state. gdb expects a response.

A gdb 'rsi' command hangs forever because the gdbstub filters out
the response (also observable with reverse_debugging.py avocado
tests).

Fix by setting allow_stop_reply for the gdb backward packets.

Fixes: 758370052fb ("gdbstub: only send stop-reply packets when allowed to")
Cc: qemu-stable@nongnu.org
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Taylor Simpson <tsimpson@quicinc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Message-Id: <20230623035304.279833-1-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index be18568d0a..9496d7b175 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1814,6 +1814,7 @@ static int gdb_handle_packet(const char *line_buf)
                 .handler = handle_backward,
                 .cmd = "b",
                 .cmd_startswith = 1,
+                .allow_stop_reply = true,
                 .schema = "o0"
             };
             cmd_parser = &backward_cmd_desc;
-- 
2.39.2


