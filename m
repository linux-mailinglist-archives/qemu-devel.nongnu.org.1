Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BD680DCFD
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:26:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCniO-0001S9-8C; Mon, 11 Dec 2023 16:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCniD-0001Cf-Sj
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:21:16 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCniB-0005RA-F9
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:21:13 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-54cdef4c913so12195497a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329670; x=1702934470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbDQbeYc3MqbJhEQi67twemcgBt5US82mKEOXjqMt3c=;
 b=bu83fq66c3y8COUJQE/1HYDTWJBAj8oK7R9gJtR8+C1t/KaOAzRszW2erbuUnI6b55
 OFJ6jOSo89aMtGE9T8XQG/X1TcRnS1GHF8o0utDxq3RBraquD4FeP+NewW4NW0NQqe8e
 Cgvehdyxlzfo7igd/CI6mOY42FmBJE0wfMn8dWYMAyLipP1Pl8JyXk4cveJ4kCMoSLnf
 lUyXg6e8WufGTxMWgdahTyUYJqCxAfJD3vzr0nUsA2I78y3ENvkESPDmBqGmvDl29R7w
 wJVzgm6nV3BWFimhaxy2LMbuxgtM828C9/vTPRB1TWQuPQDdj/fhjKN0VsnidOKaL+J3
 kwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329670; x=1702934470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WbDQbeYc3MqbJhEQi67twemcgBt5US82mKEOXjqMt3c=;
 b=ZisJOaZsecQ3oqJ0A4ioY1EIhtdw+9QOcl6rDAGaqrl8/cODKJqIOwh6VvJ9k+INRL
 gx5nW9vohw4BfYi+Ijesekgv8glPE4xNkjs6yPfFN2EawduNL6j20gPBjWHx6nmFDnw1
 mb+T4aMh6NkmY2uPehtsyhha8XG3azc1j003Q6QmE/3GRiJJu1xUHG1esx2BopVh9vst
 BIV7gJQO1skqHWGEbpcEEbUMVBcEB3ki6yvj5lmv4pre0JrcMFyrZ9ykjeXCRHjnzYDr
 MDqvDEm2Cgiwe+L7snALynojUaGkCd9rrzb4G2stdJAuSoetk51e2keyi5eDw+KOWe+t
 YGpw==
X-Gm-Message-State: AOJu0Yyaw5KIpieN3waI20GEdGkTafYw5w/IcgDwaFXct700aN1JiLro
 2wrP6n40BsCE+tkGOzh5RDzE6OURLitn6jXumQYysw==
X-Google-Smtp-Source: AGHT+IHqm4UZ94oft03ymzOFSZfr6wL2NQDR25w3u0JiNetMo2FIb4m6lHXBdEO0USlv9SICLLe3wg==
X-Received: by 2002:a17:907:c08:b0:a1f:9842:5a4b with SMTP id
 ga8-20020a1709070c0800b00a1f98425a4bmr3691271ejc.66.1702329669925; 
 Mon, 11 Dec 2023 13:21:09 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 vh9-20020a170907d38900b00a1d18c142eesm5352528ejc.59.2023.12.11.13.21.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:21:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Claudio Fontana <cfontana@suse.de>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/24] host/load-extract: Include missing 'qemu/atomic.h' and
 'qemu/int128.h'
Date: Mon, 11 Dec 2023 22:19:44 +0100
Message-ID: <20231211212003.21686-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

int128_make128(), int128_getlo() and int128_urshift() are
declared in "qemu/int128.h". qatomic_read__nocheck() is
declared in "qemu/atomic.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 host/include/generic/host/load-extract-al16-al8.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/host/include/generic/host/load-extract-al16-al8.h b/host/include/generic/host/load-extract-al16-al8.h
index d95556130f..6b47339b57 100644
--- a/host/include/generic/host/load-extract-al16-al8.h
+++ b/host/include/generic/host/load-extract-al16-al8.h
@@ -8,6 +8,9 @@
 #ifndef HOST_LOAD_EXTRACT_AL16_AL8_H
 #define HOST_LOAD_EXTRACT_AL16_AL8_H
 
+#include "qemu/atomic.h"
+#include "qemu/int128.h"
+
 /**
  * load_atom_extract_al16_or_al8:
  * @pv: host address
-- 
2.41.0


